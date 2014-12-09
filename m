Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46BD81A04DD
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Dec 2014 16:42:40 +1100 (AEDT)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <imunsie@au1.ibm.com>;
 Tue, 9 Dec 2014 15:42:39 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 621D83578048
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Dec 2014 16:42:36 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sB95gS1S36831390
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 9 Dec 2014 16:42:36 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sB95g3AK024615
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 9 Dec 2014 16:42:03 +1100
Received: from ozlabs.au.ibm.com (ozlabs.au.ibm.com [9.192.253.14])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 sB95g3ut024073
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 9 Dec 2014 16:42:03 +1100
Received: from localhost (haven.au.ibm.com [9.192.253.15])
 (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 89402A019A
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Dec 2014 16:41:39 +1100 (AEDT)
Content-Type: text/plain; charset=UTF-8
From: Ian Munsie <imunsie@au1.ibm.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH 7/7] CXL: Unmap MMIO regions when detaching a context
In-reply-to: <1418026681-14787-7-git-send-email-imunsie@au.ibm.com>
References: <1418026681-14787-1-git-send-email-imunsie@au.ibm.com>
 <1418026681-14787-7-git-send-email-imunsie@au.ibm.com>
Date: Tue, 09 Dec 2014 16:41:39 +1100
Message-Id: <1418103566-sup-1772@delenn.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This one should go to stable - this was the first bug uncovered after
fixing the sleep while atomic and force unbinding the driver.

Cheers,
-Ian

Excerpts from Ian Munsie's message of 2014-12-08 19:18:01 +1100:
> From: Ian Munsie <imunsie@au1.ibm.com>
> 
> If we need to force detach a context (e.g. due to EEH or simply force
> unbinding the driver) we should prevent the userspace contexts from
> being able to access the Problem State Area MMIO region further, which
> they may have mapped with mmap().
> 
> This patch unmaps any mapped MMIO regions when detaching a userspace
> context.
> 
> Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
> ---
>  drivers/misc/cxl/context.c | 11 ++++++++++-
>  drivers/misc/cxl/cxl.h     |  7 ++++++-
>  drivers/misc/cxl/file.c    |  6 +++++-
>  3 files changed, 21 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/misc/cxl/context.c b/drivers/misc/cxl/context.c
> index 4aa31a3..51fd6b5 100644
> --- a/drivers/misc/cxl/context.c
> +++ b/drivers/misc/cxl/context.c
> @@ -34,7 +34,8 @@ struct cxl_context *cxl_context_alloc(void)
>  /*
>   * Initialises a CXL context.
>   */
> -int cxl_context_init(struct cxl_context *ctx, struct cxl_afu *afu, bool master)
> +int cxl_context_init(struct cxl_context *ctx, struct cxl_afu *afu, bool master,
> +             struct address_space *mapping)
>  {
>      int i;
>  
> @@ -42,6 +43,8 @@ int cxl_context_init(struct cxl_context *ctx, struct cxl_afu *afu, bool master)
>      ctx->afu = afu;
>      ctx->master = master;
>      ctx->pid = NULL; /* Set in start work ioctl */
> +    mutex_init(&ctx->mapping_lock);
> +    ctx->mapping = mapping;
>  
>      /*
>       * Allocate the segment table before we put it in the IDR so that we
> @@ -147,6 +150,12 @@ static void __detach_context(struct cxl_context *ctx)
>      afu_release_irqs(ctx);
>      flush_work(&ctx->fault_work); /* Only needed for dedicated process */
>      wake_up_all(&ctx->wq);
> +
> +    /* Release Problem State Area mapping */
> +    mutex_lock(&ctx->mapping_lock);
> +    if (ctx->mapping)
> +        unmap_mapping_range(ctx->mapping, 0, 0, 1);
> +    mutex_unlock(&ctx->mapping_lock);
>  }
>  
>  /*
> diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
> index c1f8aa6..0df0438 100644
> --- a/drivers/misc/cxl/cxl.h
> +++ b/drivers/misc/cxl/cxl.h
> @@ -405,6 +405,10 @@ struct cxl_context {
>      phys_addr_t psn_phys;
>      u64 psn_size;
>  
> +    /* Used to unmap any mmaps when force detaching */
> +    struct address_space *mapping;
> +    struct mutex mapping_lock;
> +
>      spinlock_t sste_lock; /* Protects segment table entries */
>      struct cxl_sste *sstp;
>      u64 sstp0, sstp1;
> @@ -606,7 +610,8 @@ int cxl_alloc_sst(struct cxl_context *ctx);
>  void init_cxl_native(void);
>  
>  struct cxl_context *cxl_context_alloc(void);
> -int cxl_context_init(struct cxl_context *ctx, struct cxl_afu *afu, bool master);
> +int cxl_context_init(struct cxl_context *ctx, struct cxl_afu *afu, bool master,
> +             struct address_space *mapping);
>  void cxl_context_free(struct cxl_context *ctx);
>  int cxl_context_iomap(struct cxl_context *ctx, struct vm_area_struct *vma);
>  
> diff --git a/drivers/misc/cxl/file.c b/drivers/misc/cxl/file.c
> index 2e067a5..b09be44 100644
> --- a/drivers/misc/cxl/file.c
> +++ b/drivers/misc/cxl/file.c
> @@ -77,7 +77,7 @@ static int __afu_open(struct inode *inode, struct file *file, bool master)
>          goto err_put_afu;
>      }
>  
> -    if ((rc = cxl_context_init(ctx, afu, master)))
> +    if ((rc = cxl_context_init(ctx, afu, master, inode->i_mapping)))
>          goto err_put_afu;
>  
>      pr_devel("afu_open pe: %i\n", ctx->pe);
> @@ -113,6 +113,10 @@ static int afu_release(struct inode *inode, struct file *file)
>           __func__, ctx->pe);
>      cxl_context_detach(ctx);
>  
> +    mutex_lock(&ctx->mapping_lock);
> +    ctx->mapping = NULL;
> +    mutex_unlock(&ctx->mapping_lock);
> +
>      put_device(&ctx->afu->dev);
>  
>      /*
