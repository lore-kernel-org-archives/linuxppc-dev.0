Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yGYX02r1fzDqlv
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Oct 2017 22:54:40 +1100 (AEDT)
Received: by mail-pf0-x242.google.com with SMTP id b6so1178039pfh.7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Oct 2017 04:54:40 -0700 (PDT)
Date: Tue, 17 Oct 2017 21:54:24 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/mm/radix: Drop unneeded NULL check
Message-ID: <20171017215339.16354330@roar.ozlabs.ibm.com>
In-Reply-To: <20171016071100.8497-1-aneesh.kumar@linux.vnet.ibm.com>
References: <20171016071100.8497-1-aneesh.kumar@linux.vnet.ibm.com>
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

On Mon, 16 Oct 2017 12:41:00 +0530
"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> wrote:

> @@ -175,10 +175,9 @@ void radix__local_flush_tlb_page(struct vm_area_struct *vma, unsigned long vmadd
>  #ifdef CONFIG_HUGETLB_PAGE
>  	/* need the return fix for nohash.c */
>  	if (vma && is_vm_hugetlb_page(vma))
> -		return __local_flush_hugetlb_page(vma, vmaddr);
> +		return radix__local_flush_hugetlb_page(vma, vmaddr);
>  #endif
> -	radix__local_flush_tlb_page_psize(vma ? vma->vm_mm : NULL, vmaddr,
> -					  mmu_virtual_psize);
> +	radix__local_flush_tlb_page_psize(vma->vm_mm, vmaddr, mmu_virtual_psize);
>  }
>  EXPORT_SYMBOL(radix__local_flush_tlb_page);
>  

Missed the other NULL pointer check in this hunk.

> @@ -247,10 +246,9 @@ void radix__flush_tlb_page(struct vm_area_struct *vma, unsigned long vmaddr)
>  {
>  #ifdef CONFIG_HUGETLB_PAGE
>  	if (vma && is_vm_hugetlb_page(vma))
> -		return flush_hugetlb_page(vma, vmaddr);
> +		return radix__flush_hugetlb_page(vma, vmaddr);
>  #endif
> -	radix__flush_tlb_page_psize(vma ? vma->vm_mm : NULL, vmaddr,
> -				    mmu_virtual_psize);
> +	radix__flush_tlb_page_psize(vma->vm_mm, vmaddr, mmu_virtual_psize);
>  }
>  EXPORT_SYMBOL(radix__flush_tlb_page);
>  

And another one.

Thanks,
Nick
