Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41BhxB18StzF0dT
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jun 2018 12:15:24 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id b74-v6so2436587pfl.5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jun 2018 19:15:24 -0700 (PDT)
Date: Fri, 22 Jun 2018 12:15:11 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-kernel@vger.kernel.org, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael
 Ellerman <mpe@ellerman.id.au>, "Aneesh Kumar K.V"
 <aneesh.kumar@linux.vnet.ibm.com>, Thiago Jung Bauermann
 <bauerman@linux.vnet.ibm.com>, Ram Pai <linuxram@us.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 13/26] ppc: Convert mmu context allocation to new IDA API
Message-ID: <20180622121511.00ae9d00@roar.ozlabs.ibm.com>
In-Reply-To: <20180621212835.5636-14-willy@infradead.org>
References: <20180621212835.5636-1-willy@infradead.org>
 <20180621212835.5636-14-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 21 Jun 2018 14:28:22 -0700
Matthew Wilcox <willy@infradead.org> wrote:

> ida_alloc_range is the perfect fit for this use case.  Eliminates
> a custom spinlock, a call to ida_pre_get and a local check for the
> allocated ID exceeding a maximum.
> 
> Signed-off-by: Matthew Wilcox <willy@infradead.org>
> ---
>  arch/powerpc/mm/mmu_context_book3s64.c | 44 +++-----------------------
>  1 file changed, 4 insertions(+), 40 deletions(-)
> 
> diff --git a/arch/powerpc/mm/mmu_context_book3s64.c b/arch/powerpc/mm/mmu_context_book3s64.c
> index f3d4b4a0e561..5a0cf2cc8ba0 100644
> --- a/arch/powerpc/mm/mmu_context_book3s64.c
> +++ b/arch/powerpc/mm/mmu_context_book3s64.c
> @@ -26,48 +26,16 @@
>  #include <asm/mmu_context.h>
>  #include <asm/pgalloc.h>
>  
> -static DEFINE_SPINLOCK(mmu_context_lock);
>  static DEFINE_IDA(mmu_context_ida);
>  
>  static int alloc_context_id(int min_id, int max_id)
>  {
> -	int index, err;
> -
> -again:
> -	if (!ida_pre_get(&mmu_context_ida, GFP_KERNEL))
> -		return -ENOMEM;
> -
> -	spin_lock(&mmu_context_lock);
> -	err = ida_get_new_above(&mmu_context_ida, min_id, &index);
> -	spin_unlock(&mmu_context_lock);
> -
> -	if (err == -EAGAIN)
> -		goto again;
> -	else if (err)
> -		return err;
> -
> -	if (index > max_id) {
> -		spin_lock(&mmu_context_lock);
> -		ida_remove(&mmu_context_ida, index);
> -		spin_unlock(&mmu_context_lock);
> -		return -ENOMEM;
> -	}
> -
> -	return index;
> +	return ida_alloc_range(&mmu_context_ida, min_id, max_id, GFP_KERNEL);
>  }
>  
>  void hash__reserve_context_id(int id)
>  {
> -	int rc, result = 0;
> -
> -	do {
> -		if (!ida_pre_get(&mmu_context_ida, GFP_KERNEL))
> -			break;
> -
> -		spin_lock(&mmu_context_lock);
> -		rc = ida_get_new_above(&mmu_context_ida, id, &result);
> -		spin_unlock(&mmu_context_lock);
> -	} while (rc == -EAGAIN);
> +	int result = ida_alloc_range(&mmu_context_ida, id, id, GFP_KERNEL);
>  
>  	WARN(result != id, "mmu: Failed to reserve context id %d (rc %d)\n", id, result);
>  }
> @@ -172,9 +140,7 @@ int init_new_context(struct task_struct *tsk, struct mm_struct *mm)
>  
>  void __destroy_context(int context_id)
>  {
> -	spin_lock(&mmu_context_lock);
> -	ida_remove(&mmu_context_ida, context_id);
> -	spin_unlock(&mmu_context_lock);
> +	ida_free(&mmu_context_ida, context_id);
>  }
>  EXPORT_SYMBOL_GPL(__destroy_context);
>  
> @@ -182,13 +148,11 @@ static void destroy_contexts(mm_context_t *ctx)
>  {
>  	int index, context_id;
>  
> -	spin_lock(&mmu_context_lock);
>  	for (index = 0; index < ARRAY_SIZE(ctx->extended_id); index++) {
>  		context_id = ctx->extended_id[index];
>  		if (context_id)
> -			ida_remove(&mmu_context_ida, context_id);
> +			ida_free(&mmu_context_ida, context_id);
>  	}
> -	spin_unlock(&mmu_context_lock);
>  }
>  
>  static void pte_frag_destroy(void *pte_frag)

This hunk should be okay because the mmu_context_lock does not protect
the extended_id array, right Aneesh?

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

Thanks,
Nick
