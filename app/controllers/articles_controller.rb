class ArticlesController < ApplicationController
    before_action :set_article_number, only: [:edit, :update, :show, :destroy]
    
    
    def index
        @articles = Article.all
    end
    
    def new
        @article = Article.new
    end
    
    
    def edit
        # @article = Article.find(params[:id]) 
        @article = set_article_number()
    end
    
    
    def update
       @article = Article.find(params[:id]) 
        if @article.update(article_params)
           flash[:success] = "Article was successfully Updated!"
           redirect_to article_path(@article)
        else
            render 'edit'
        end
    end 
    
    
    def show
    #   @article = Article.find(params[:id]) 
    end    
    
    
    def destroy
    #   @art = Article.find(params[:id])  
      @article.destroy 
      flash[:danger] = "Article was successfully deleted"
      redirect_to articles_path
    end
    
    
    def create
                #render plain: params[:article].inspect
        @article = Article.new(article_params) 
        @article.user = User.first
        if @article.save
            flash[:success] = "Article was successfully created"
            redirect_to article_path(@article)
        else
            render 'new'
        end
    end 
    
    
    private 
    
        def set_article_number
            @article = Article.find(params[:id])
        end
        def article_params
            params.require(:article).permit(:title, :description)  
        end
    
end