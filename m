Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BB09D1A0197
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Aug 2014 15:14:00 +1000 (EST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 14 Aug 2014 15:13:59 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 687232CE8051
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Aug 2014 15:13:57 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay07.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s7E5EbfB16515244
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Aug 2014 15:14:37 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s7E5Duxw009753
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Aug 2014 15:13:57 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] PC, KVM,
 CMA: Fix regression caused by wrong get_order() use
In-Reply-To: <1407992587-9164-1-git-send-email-aik@ozlabs.ru>
References: <1407992587-9164-1-git-send-email-aik@ozlabs.ru>
Date: Thu, 14 Aug 2014 10:43:52 +0530
Message-ID: <87egwj64bz.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: kvm@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alexander Graf <agraf@suse.de>, kvm-ppc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Gleb Natapov <gleb@kernel.org>,
 Paul Mackerras <paulus@samba.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Alexey Kardashevskiy <aik@ozlabs.ru> writes:

> fc95ca7284bc54953165cba76c3228bd2cdb9591 claims that there is no
> functional change but this is not true as it calls get_order() (which
> takes bytes) where it should have called ilog2() and the kernel stops
> on VM_BUG_ON().
>
> This replaces get_order() with order_base_2() (round-up version of ilog2).
>
> Suggested-by: Paul Mackerras <paulus@samba.org>
> Cc: Alexander Graf <agraf@suse.de>
> Cc: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

> ---
>
> Changes:
> v2:
> * s/ilog2/order_base_2/
> * removed cc: <stable@vger.kernel.org> as I got wrong impression that v3.16 is
> broken
>
> ---
>  arch/powerpc/kvm/book3s_hv_builtin.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/powerpc/kvm/book3s_hv_builtin.c b/arch/powerpc/kvm/book3s_hv_builtin.c
> index 329d7fd..b9615ba 100644
> --- a/arch/powerpc/kvm/book3s_hv_builtin.c
> +++ b/arch/powerpc/kvm/book3s_hv_builtin.c
> @@ -101,7 +101,7 @@ struct kvm_rma_info *kvm_alloc_rma()
>  	ri = kmalloc(sizeof(struct kvm_rma_info), GFP_KERNEL);
>  	if (!ri)
>  		return NULL;
> -	page = cma_alloc(kvm_cma, kvm_rma_pages, get_order(kvm_rma_pages));
> +	page = cma_alloc(kvm_cma, kvm_rma_pages, order_base_2(kvm_rma_pages));
>  	if (!page)
>  		goto err_out;
>  	atomic_set(&ri->use_count, 1);
> @@ -135,12 +135,12 @@ struct page *kvm_alloc_hpt(unsigned long nr_pages)
>  {
>  	unsigned long align_pages = HPT_ALIGN_PAGES;
>
> -	VM_BUG_ON(get_order(nr_pages) < KVM_CMA_CHUNK_ORDER - PAGE_SHIFT);
> +	VM_BUG_ON(order_base_2(nr_pages) < KVM_CMA_CHUNK_ORDER - PAGE_SHIFT);
>
>  	/* Old CPUs require HPT aligned on a multiple of its size */
>  	if (!cpu_has_feature(CPU_FTR_ARCH_206))
>  		align_pages = nr_pages;
> -	return cma_alloc(kvm_cma, nr_pages, get_order(align_pages));
> +	return cma_alloc(kvm_cma, nr_pages, order_base_2(align_pages));
>  }
>  EXPORT_SYMBOL_GPL(kvm_alloc_hpt);
>
> -- 
> 2.0.0
