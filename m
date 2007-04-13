Return-Path: <hch@lst.de>
Date: Fri, 13 Apr 2007 09:06:39 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jeremy Kerr <jk@ozlabs.org>
Subject: Re: [Cbe-oss-dev] [PATCH 1/4] spufs: clean up logic in
	spu_reacquire_runnable
Message-ID: <20070413070639.GC13026@lst.de>
References: <1176428938.598660.69304866740.qpush@pokey>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1176428938.598660.69304866740.qpush@pokey>
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Apr 13, 2007 at 11:48:58AM +1000, Jeremy Kerr wrote:
> spu_reacquire_runnable has an overly-complex way of calculating its
> return value. This change fixes it.
> 
> Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
> 
>  arch/powerpc/platforms/cell/spufs/run.c |    4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> Index: linux-2.6-spufs/arch/powerpc/platforms/cell/spufs/run.c
> ===================================================================
> --- linux-2.6-spufs.orig/arch/powerpc/platforms/cell/spufs/run.c
> +++ linux-2.6-spufs/arch/powerpc/platforms/cell/spufs/run.c
> @@ -200,9 +200,7 @@ static inline int spu_reacquire_runnable
>  		       SPU_STATUS_STOPPED_BY_HALT)) {
>  		return *status;
>  	}
> -	if ((ret = spu_run_init(ctx, npc)) != 0)
> -		return ret;
> -	return 0;
> +	return spu_run_init(ctx, npc);

I have a patch that does this and some more cleanups in surrounding
code.  If you don't mind I'd like to drop this patch and promise to
send out my bigger patch ina few hours.
