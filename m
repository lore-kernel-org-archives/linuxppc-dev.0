Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x235.google.com (mail-pf0-x235.google.com
 [IPv6:2607:f8b0:400e:c00::235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qjySP3P3tzDq9q
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Apr 2016 14:55:49 +1000 (AEST)
Received: by mail-pf0-x235.google.com with SMTP id e128so116283365pfe.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 Apr 2016 21:55:49 -0700 (PDT)
Subject: Re: [PATCH V2 17/68] powerpc/mm/hash: Add support for POWER9 hash
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
References: <1460182444-2468-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1460182444-2468-18-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <570B2E4E.10708@gmail.com>
Date: Mon, 11 Apr 2016 14:55:42 +1000
MIME-Version: 1.0
In-Reply-To: <1460182444-2468-18-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 09/04/16 16:13, Aneesh Kumar K.V wrote:
> PowerISA 3.0 adds a parition table indexed by LPID. Parition table allow
> us to specify the MMU model that will be used for guest and host
> translation.
> 
> This patch add support with SLB based hash model (UPRT = 0). What is
> required with this model is to support the new hash page table entry
> format and also setup Partition table such we use hash table for
> address translation.
> 
> We don't have segment table support yet.
> 
> Inorder to make sure we don't load KVM module on Power9 (since we
> don't have kvm support yet) this patch also disable kvm on Power9
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/book3s/64/mmu-hash.h | 13 +++++++--
>  arch/powerpc/kvm/book3s_hv.c                  |  6 ++++
>  arch/powerpc/kvm/book3s_pr.c                  |  6 +++-
>  arch/powerpc/mm/hash_native_64.c              | 11 ++++++-
>  arch/powerpc/mm/hash_utils_64.c               | 42 +++++++++++++++++++++++++--
>  arch/powerpc/mm/pgtable_64.c                  |  7 +++++
>  arch/powerpc/platforms/ps3/htab.c             |  2 +-
>  arch/powerpc/platforms/pseries/lpar.c         |  2 +-
>  8 files changed, 81 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/book3s/64/mmu-hash.h b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
> index ce73736b42db..843b5d839904 100644
> --- a/arch/powerpc/include/asm/book3s/64/mmu-hash.h
> +++ b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
> @@ -78,6 +78,10 @@
>  #define HPTE_V_SECONDARY	ASM_CONST(0x0000000000000002)
>  #define HPTE_V_VALID		ASM_CONST(0x0000000000000001)
>  
> +/*
> + * ISA 3.0 have a different HPTE format.
> + */
> +#define HPTE_R_3_0_SSIZE_SHIFT	58
>  #define HPTE_R_PP0		ASM_CONST(0x8000000000000000)
>  #define HPTE_R_TS		ASM_CONST(0x4000000000000000)
>  #define HPTE_R_KEY_HI		ASM_CONST(0x3000000000000000)
> @@ -224,7 +228,8 @@ static inline unsigned long hpte_encode_avpn(unsigned long vpn, int psize,
>  	 */
>  	v = (vpn >> (23 - VPN_SHIFT)) & ~(mmu_psize_defs[psize].avpnm);
>  	v <<= HPTE_V_AVPN_SHIFT;
> -	v |= ((unsigned long) ssize) << HPTE_V_SSIZE_SHIFT;
> +	if (!cpu_has_feature(CPU_FTR_ARCH_300))
> +		v |= ((unsigned long) ssize) << HPTE_V_SSIZE_SHIFT;
>  	return v;
>  }
>  
> @@ -248,8 +253,12 @@ static inline unsigned long hpte_encode_v(unsigned long vpn, int base_psize,
>   * aligned for the requested page size
>   */
>  static inline unsigned long hpte_encode_r(unsigned long pa, int base_psize,
> -					  int actual_psize)
> +					  int actual_psize, int ssize)
>  {
> +
> +	if (cpu_has_feature(CPU_FTR_ARCH_300))
> +		pa |= ((unsigned long) ssize) << HPTE_R_3_0_SSIZE_SHIFT;
> +

Looks good, I was wondering if we can compute cpu_has_feature(CPU_FTR_ARCH_300) once for the instance
and use it, but I am just nit-picking. I've never tried using ASM_MMU_FTR_IF(), I don't know
if you've explored it. Not very important for this patchset though

>  	/* A 4K page needs no special encoding */
>  	if (actual_psize == MMU_PAGE_4K)
>  		return pa & HPTE_R_RPN;
> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index baeddb06811d..c07600efcef6 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -3083,6 +3083,12 @@ static int kvmppc_core_check_processor_compat_hv(void)
>  	if (!cpu_has_feature(CPU_FTR_HVMODE) ||
>  	    !cpu_has_feature(CPU_FTR_ARCH_206))
>  		return -EIO;
> +	/*
> +	 * Disable KVM for Power9, untill the required bits merged.
> +	 */
> +	if (cpu_has_feature(CPU_FTR_ARCH_300))
> +		return -EIO;
> +
>  	return 0;
>  }
>  
> diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
> index 95bceca8f40e..ffbaf40b7f31 100644
> --- a/arch/powerpc/kvm/book3s_pr.c
> +++ b/arch/powerpc/kvm/book3s_pr.c
> @@ -1683,7 +1683,11 @@ static void kvmppc_core_destroy_vm_pr(struct kvm *kvm)
>  
>  static int kvmppc_core_check_processor_compat_pr(void)
>  {
> -	/* we are always compatible */
> +	/*
> +	 * Disable KVM for Power9 untill the required bits merged.
> +	 */
> +	if (cpu_has_feature(CPU_FTR_ARCH_300))
> +		return -EIO;
>  	return 0;
>  }
>  
> diff --git a/arch/powerpc/mm/hash_native_64.c b/arch/powerpc/mm/hash_native_64.c
> index 8eaac81347fd..d873f6507f72 100644
> --- a/arch/powerpc/mm/hash_native_64.c
> +++ b/arch/powerpc/mm/hash_native_64.c
> @@ -221,7 +221,7 @@ static long native_hpte_insert(unsigned long hpte_group, unsigned long vpn,
>  		return -1;
>  
>  	hpte_v = hpte_encode_v(vpn, psize, apsize, ssize) | vflags | HPTE_V_VALID;
> -	hpte_r = hpte_encode_r(pa, psize, apsize) | rflags;
> +	hpte_r = hpte_encode_r(pa, psize, apsize, ssize) | rflags;
>  
>  	if (!(vflags & HPTE_V_BOLTED)) {
>  		DBG_LOW(" i=%x hpte_v=%016lx, hpte_r=%016lx\n",
> @@ -719,6 +719,12 @@ static void native_flush_hash_range(unsigned long number, int local)
>  	local_irq_restore(flags);
>  }
>  
> +static int native_update_partition_table(u64 patb1)
> +{
> +	partition_tb->patb1 = cpu_to_be64(patb1);

Do we need to tell the hardware that patb1 was updated?

> +	return 0;
> +}
> +
>  void __init hpte_init_native(void)
>  {
>  	ppc_md.hpte_invalidate	= native_hpte_invalidate;
> @@ -729,4 +735,7 @@ void __init hpte_init_native(void)
>  	ppc_md.hpte_clear_all	= native_hpte_clear;
>  	ppc_md.flush_hash_range = native_flush_hash_range;
>  	ppc_md.hugepage_invalidate   = native_hugepage_invalidate;
> +
> +	if (cpu_has_feature(CPU_FTR_ARCH_300))
> +		ppc_md.update_partition_table = native_update_partition_table;
>  }
> diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
> index e924690a5a0e..43e0d86b7ca1 100644
> --- a/arch/powerpc/mm/hash_utils_64.c
> +++ b/arch/powerpc/mm/hash_utils_64.c
> @@ -674,6 +674,41 @@ int remove_section_mapping(unsigned long start, unsigned long end)
>  }
>  #endif /* CONFIG_MEMORY_HOTPLUG */
>  
> +static void __init hash_init_partition_table(phys_addr_t hash_table,
> +					     unsigned long pteg_count)
> +{
> +	unsigned long ps_field;
> +	unsigned long htab_size;
> +	unsigned long patb_size = 1UL << PATB_SIZE_SHIFT;
> +
> +	/*
> +	 * slb llp encoding for the page size used in VPM real mode.
> +	 * We can ignore that for lpid 0
> +	 */
> +	ps_field = 0;
> +	htab_size =  __ilog2(pteg_count) - 11;
> +
> +	BUILD_BUG_ON_MSG((PATB_SIZE_SHIFT > 24), "Partition table size too large.");
> +	partition_tb = __va(memblock_alloc_base(patb_size, patb_size,
> +						MEMBLOCK_ALLOC_ANYWHERE));
> +
> +	/* Initialize the Partition Table with no entries */
> +	memset((void *)partition_tb, 0, patb_size);
> +	partition_tb->patb0 = cpu_to_be64(ps_field | hash_table | htab_size);
> +	/*
> +	 * FIXME!! This should be done via update_partition table
> +	 * For now UPRT is 0 for us.
> +	 */
> +	partition_tb->patb1 = 0;

So the design is that we allocate upto 2^24/16 entries for the partition table
and set the first entry LPID0 to use HPT with ps_field set to 0 and patb1
to be updated by the callback we provide via native_update_partition_table?

> +	DBG("Partition table %p\n", partition_tb);
> +	/*
> +	 * update partition table control register,
> +	 * 64 K size.
> +	 */
> +	mtspr(SPRN_PTCR, __pa(partition_tb) | (PATB_SIZE_SHIFT - 12));
> +
> +}
> +
>  static void __init htab_initialize(void)
>  {
>  	unsigned long table;
> @@ -742,8 +777,11 @@ static void __init htab_initialize(void)
>  		/* Initialize the HPT with no entries */
>  		memset((void *)table, 0, htab_size_bytes);
>  
> -		/* Set SDR1 */
> -		mtspr(SPRN_SDR1, _SDR1);
> +		if (!cpu_has_feature(CPU_FTR_ARCH_300))
> +			/* Set SDR1 */
> +			mtspr(SPRN_SDR1, _SDR1);
> +		else
> +			hash_init_partition_table(table, pteg_count);
>  	}
>  
>  	prot = pgprot_val(PAGE_KERNEL);
> diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
> index 98c91ad18ba7..5fff787da17a 100644
> --- a/arch/powerpc/mm/pgtable_64.c
> +++ b/arch/powerpc/mm/pgtable_64.c
> @@ -69,6 +69,13 @@
>  #endif
>  #endif

<snip>

Otherwise looks good!

Balbir Singh
