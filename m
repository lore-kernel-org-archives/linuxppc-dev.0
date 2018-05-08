Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40gFJ018rBzF1x3
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 May 2018 19:56:31 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w489nFXG061989
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 8 May 2018 05:56:29 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2hu6wffc1a-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 May 2018 05:56:29 -0400
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 8 May 2018 10:56:26 +0100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 09/17] powerpc: make __ioremap_caller() common to PPC32
 and PPC64
In-Reply-To: <457781f2de403852ba2a60257c3d9aca75c4d2c8.1525435203.git.christophe.leroy@c-s.fr>
References: <cover.1525435203.git.christophe.leroy@c-s.fr>
 <457781f2de403852ba2a60257c3d9aca75c4d2c8.1525435203.git.christophe.leroy@c-s.fr>
Date: Tue, 08 May 2018 15:26:20 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87lgcusc6z.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Christophe Leroy <christophe.leroy@c-s.fr> writes:

> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  arch/powerpc/include/asm/book3s/64/pgtable.h |   1 +
>  arch/powerpc/mm/ioremap.c                    | 126 +++++++--------------------
>  2 files changed, 34 insertions(+), 93 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
> index c5c6ead06bfb..2bebdd8302cb 100644
> --- a/arch/powerpc/include/asm/book3s/64/pgtable.h
> +++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
> @@ -18,6 +18,7 @@
>  #define _PAGE_RO		0
>  #define _PAGE_USER		0
>  #define _PAGE_HWWRITE		0
> +#define _PAGE_COHERENT		0

This is something I was trying to avoid when I split the headers. We do
support _PAGE_USER it is !_PAGE_PRIVILEGED. It gets really confusing
when we have these conflicting names because we are trying to make code
common across platforms.


>  
>  #define _PAGE_EXEC		0x00001 /* execute permission */
>  #define _PAGE_WRITE		0x00002 /* write access allowed */
> diff --git a/arch/powerpc/mm/ioremap.c b/arch/powerpc/mm/ioremap.c
> index 65d611d44d38..59be5dfcb3e9 100644
> --- a/arch/powerpc/mm/ioremap.c
> +++ b/arch/powerpc/mm/ioremap.c
> @@ -33,95 +33,6 @@ unsigned long ioremap_bot;
>  unsigned long ioremap_bot = IOREMAP_BASE;
>  #endif
>  
> -#ifdef CONFIG_PPC32
> -
> -void __iomem *
> -__ioremap_caller(phys_addr_t addr, unsigned long size, unsigned long flags,
> -		 void *caller)
> -{
> -	unsigned long v, i;
> -	phys_addr_t p;
> -	int err;
> -
> -	/* Make sure we have the base flags */
> -	if ((flags & _PAGE_PRESENT) == 0)
> -		flags |= pgprot_val(PAGE_KERNEL);
> -
> -	/* Non-cacheable page cannot be coherent */
> -	if (flags & _PAGE_NO_CACHE)
> -		flags &= ~_PAGE_COHERENT;
> -
> -	/*
> -	 * Choose an address to map it to.
> -	 * Once the vmalloc system is running, we use it.
> -	 * Before then, we use space going up from IOREMAP_BASE
> -	 * (ioremap_bot records where we're up to).
> -	 */
> -	p = addr & PAGE_MASK;
> -	size = PAGE_ALIGN(addr + size) - p;
> -
> -	/*
> -	 * If the address lies within the first 16 MB, assume it's in ISA
> -	 * memory space
> -	 */
> -	if (p < 16*1024*1024)
> -		p += _ISA_MEM_BASE;
> -
> -#ifndef CONFIG_CRASH_DUMP
> -	/*
> -	 * Don't allow anybody to remap normal RAM that we're using.
> -	 * mem_init() sets high_memory so only do the check after that.
> -	 */
> -	if (slab_is_available() && (p < virt_to_phys(high_memory)) &&
> -	    page_is_ram(__phys_to_pfn(p))) {
> -		printk("__ioremap(): phys addr 0x%llx is RAM lr %ps\n",
> -		       (unsigned long long)p, __builtin_return_address(0));
> -		return NULL;
> -	}
> -#endif
> -
> -	if (size == 0)
> -		return NULL;
> -
> -	/*
> -	 * Is it already mapped?  Perhaps overlapped by a previous
> -	 * mapping.
> -	 */
> -	v = p_block_mapped(p);
> -	if (v)
> -		goto out;
> -
> -	if (slab_is_available()) {
> -		struct vm_struct *area;
> -		area = get_vm_area_caller(size, VM_IOREMAP, caller);
> -		if (area == 0)
> -			return NULL;
> -		area->phys_addr = p;
> -		v = (unsigned long) area->addr;
> -	} else {
> -		v = ioremap_bot;
> -		ioremap_bot += size;
> -	}
> -
> -	/*
> -	 * Should check if it is a candidate for a BAT mapping
> -	 */
> -
> -	err = 0;
> -	for (i = 0; i < size && err == 0; i += PAGE_SIZE)
> -		err = map_kernel_page(v+i, p+i, flags);
> -	if (err) {
> -		if (slab_is_available())
> -			vunmap((void *)v);
> -		return NULL;
> -	}
> -
> -out:
> -	return (void __iomem *) (v + ((unsigned long)addr & ~PAGE_MASK));
> -}
> -
> -#else
> -
>  /**
>   * __ioremap_at - Low level function to establish the page tables
>   *                for an IO mapping
> @@ -135,6 +46,10 @@ void __iomem * __ioremap_at(phys_addr_t pa, void *ea, unsigned long size,
>  	if ((flags & _PAGE_PRESENT) == 0)
>  		flags |= pgprot_val(PAGE_KERNEL);
>  
> +	/* Non-cacheable page cannot be coherent */
> +	if (flags & _PAGE_NO_CACHE)
> +		flags &= ~_PAGE_COHERENT;
> +
>  	/* We don't support the 4K PFN hack with ioremap */
>  	if (flags & H_PAGE_4K_PFN)
>  		return NULL;
> @@ -187,6 +102,33 @@ void __iomem * __ioremap_caller(phys_addr_t addr, unsigned long size,
>  	if ((size == 0) || (paligned == 0))
>  		return NULL;
>  
> +	/*
> +	 * If the address lies within the first 16 MB, assume it's in ISA
> +	 * memory space
> +	 */
> +	if (IS_ENABLED(CONFIG_PPC32) && paligned < 16*1024*1024)
> +		paligned += _ISA_MEM_BASE;
> +
> +	/*
> +	 * Don't allow anybody to remap normal RAM that we're using.
> +	 * mem_init() sets high_memory so only do the check after that.
> +	 */
> +	if (!IS_ENABLED(CONFIG_CRASH_DUMP) &&
> +	    slab_is_available() && (paligned < virt_to_phys(high_memory)) &&
> +	    page_is_ram(__phys_to_pfn(paligned))) {
> +		printk("__ioremap(): phys addr 0x%llx is RAM lr %ps\n",
> +		       (u64)paligned, __builtin_return_address(0));
> +		return NULL;
> +	}
> +
> +	/*
> +	 * Is it already mapped?  Perhaps overlapped by a previous
> +	 * mapping.
> +	 */
> +	ret = (void __iomem *)p_block_mapped(paligned);
> +	if (ret)
> +		goto out;
> +
>  	if (slab_is_available()) {
>  		struct vm_struct *area;
>  
> @@ -205,14 +147,12 @@ void __iomem * __ioremap_caller(phys_addr_t addr, unsigned long size,
>  		if (ret)
>  			ioremap_bot += size;
>  	}
> -
> +out:
>  	if (ret)
> -		ret += addr & ~PAGE_MASK;
> +		ret += (unsigned long)addr & ~PAGE_MASK;
>  	return ret;
>  }
>  
> -#endif
> -
>  /*
>   * Unmap an IO region and remove it from imalloc'd list.
>   * Access to IO memory should be serialized by driver.
> -- 
> 2.13.3
