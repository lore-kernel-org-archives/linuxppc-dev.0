Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 128AA1A0166
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Feb 2016 18:05:30 +1100 (AEDT)
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Mon, 1 Feb 2016 17:05:29 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 9042D2BB0059
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Feb 2016 18:05:23 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1174pX144892310
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 1 Feb 2016 18:05:00 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1174oUb008067
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 1 Feb 2016 18:04:51 +1100
Message-ID: <56AF0380.3020500@linux.vnet.ibm.com>
Date: Mon, 01 Feb 2016 12:34:32 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>, paulus@samba.org,
 mpe@ellerman.id.au, benh@kernel.crashing.org
CC: aik@ozlabs.ru, lvivier@redhat.com, thuth@redhat.com,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFCv2 5/9] arch/powerpc: Split hash page table sizing heuristic
 into a helper
References: <1454045043-25545-1-git-send-email-david@gibson.dropbear.id.au>
 <1454045043-25545-6-git-send-email-david@gibson.dropbear.id.au>
In-Reply-To: <1454045043-25545-6-git-send-email-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/29/2016 10:53 AM, David Gibson wrote:
> htab_get_table_size() either retrieve the size of the hash page table (HPT)
> from the device tree - if the HPT size is determined by firmware - or
> uses a heuristic to determine a good size based on RAM size if the kernel
> is responsible for allocating the HPT.
> 
> To support a PAPR extension allowing resizing of the HPT, we're going to
> want the memory size -> HPT size logic elsewhere, so split it out into a
> helper function.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  arch/powerpc/include/asm/mmu-hash64.h |  3 +++
>  arch/powerpc/mm/hash_utils_64.c       | 30 +++++++++++++++++-------------
>  2 files changed, 20 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/mmu-hash64.h b/arch/powerpc/include/asm/mmu-hash64.h
> index 7352d3f..cf070fd 100644
> --- a/arch/powerpc/include/asm/mmu-hash64.h
> +++ b/arch/powerpc/include/asm/mmu-hash64.h
> @@ -607,6 +607,9 @@ static inline unsigned long get_kernel_vsid(unsigned long ea, int ssize)
>  	context = (MAX_USER_CONTEXT) + ((ea >> 60) - 0xc) + 1;
>  	return get_vsid(context, ea, ssize);
>  }
> +
> +unsigned htab_shift_for_mem_size(unsigned long mem_size);
> +
>  #endif /* __ASSEMBLY__ */
>  
>  #endif /* _ASM_POWERPC_MMU_HASH64_H_ */
> diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
> index e88a86e..d63f7dc 100644
> --- a/arch/powerpc/mm/hash_utils_64.c
> +++ b/arch/powerpc/mm/hash_utils_64.c
> @@ -606,10 +606,24 @@ static int __init htab_dt_scan_pftsize(unsigned long node,
>  	return 0;
>  }
>  
> -static unsigned long __init htab_get_table_size(void)
> +unsigned htab_shift_for_mem_size(unsigned long mem_size)
>  {
> -	unsigned long mem_size, rnd_mem_size, pteg_count, psize;
> +	unsigned memshift = __ilog2(mem_size);
> +	unsigned pshift = mmu_psize_defs[mmu_virtual_psize].shift;
> +	unsigned pteg_shift;
> +
> +	/* round mem_size up to next power of 2 */
> +	if ((1UL << memshift) < mem_size)
> +		memshift += 1;
> +
> +	/* aim for 2 pages / pteg */

While here I guess its a good opportunity to write couple of lines
about why one PTE group for every two physical pages on the system,
why minimum (1UL << 11 = 2048) number of PTE groups required, why
(1U << 7 = 128) entries per PTE group and also remove the existing
confusing comments above ? Just a suggestion.

> +	pteg_shift = memshift - (pshift + 1);
> +
> +	return max(pteg_shift + 7, 18U);
> +}
>  
> +static unsigned long __init htab_get_table_size(void)
> +{
>  	/* If hash size isn't already provided by the platform, we try to
>  	 * retrieve it from the device-tree. If it's not there neither, we
>  	 * calculate it now based on the total RAM size
> @@ -619,17 +633,7 @@ static unsigned long __init htab_get_table_size(void)
>  	if (ppc64_pft_size)
>  		return 1UL << ppc64_pft_size;
>  
> -	/* round mem_size up to next power of 2 */
> -	mem_size = memblock_phys_mem_size();
> -	rnd_mem_size = 1UL << __ilog2(mem_size);
> -	if (rnd_mem_size < mem_size)
> -		rnd_mem_size <<= 1;
> -
> -	/* # pages / 2 */
> -	psize = mmu_psize_defs[mmu_virtual_psize].shift;
> -	pteg_count = max(rnd_mem_size >> (psize + 1), 1UL << 11);
> -
> -	return pteg_count << 7;
> +	return htab_shift_for_mem_size(memblock_phys_mem_size());

Would it be 1UL << htab_shift_for_mem_size(memblock_phys_mem_size())
instead ? It was returning the size of the HPT not the shift of HPT
originally or I am missing something here.
