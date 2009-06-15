Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 7CE00B7140
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 15 Jun 2009 16:59:46 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 07D02DDD01
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Jun 2009 16:59:44 +1000 (EST)
Subject: Re: [PATCH v3] powerpc: add ioremap_early() for mapping IO regions
	before MMU_init()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <20090527185422.15186.46133.stgit@localhost.localdomain>
References: <20090527185422.15186.46133.stgit@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 15 Jun 2009 16:57:11 +1000
Message-Id: <1245049031.19217.49.camel@pasglop>
Mime-Version: 1.0
Cc: scottwood@freescale.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2009-05-27 at 12:55 -0600, Grant Likely wrote:
> From: Grant Likely <grant.likely@secretlab.ca>
> 
> ioremap_early() is useful for things like mapping SoC internally registers
> and early debug output because it allows mappings to devices to be setup
> early in the boot process where they are needed.  It also give a
> performance boost since BAT mapped registers don't get flushed out of
> the TLB.
> 
> Without ioremap_early(), early mappings are set up in an ad-hoc manner
> and they get lost when the MMU is set up.  Drivers then have to perform
> hacky fixups to transition over to new mappings.
> 
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> ---

My 40x config gives me:

/home/benh/linux-powerpc-test/drivers/video/xilinxfb.c:409: warning:
‘dcr_host.base’ may be used uninitialized in this function

(warning, I think, was already there, so the patch is going into -next
but we may want another one, provided we find a way to shut the idiot up
without horrible hacks since that's just gcc being stupid I believe).

Cheers,
Ben.

> new in v3:
> - Rebased onto Ben's dma_alloc_coherent changes
> - Fixed alignment to match region size
> 
>  arch/powerpc/include/asm/io.h                |    8 +
>  arch/powerpc/kernel/setup_32.c               |    4 
>  arch/powerpc/mm/init_32.c                    |    3 
>  arch/powerpc/mm/mmu_decl.h                   |    7 +
>  arch/powerpc/mm/pgtable_32.c                 |   12 +
>  arch/powerpc/mm/ppc_mmu_32.c                 |  210 +++++++++++++++++++++++---
>  arch/powerpc/platforms/52xx/mpc52xx_common.c |   13 ++
>  arch/powerpc/sysdev/cpm_common.c             |    2 
>  8 files changed, 228 insertions(+), 31 deletions(-)
> 
> 
> diff --git a/arch/powerpc/include/asm/io.h b/arch/powerpc/include/asm/io.h
> index 001f2f1..10183e2 100644
> --- a/arch/powerpc/include/asm/io.h
> +++ b/arch/powerpc/include/asm/io.h
> @@ -624,6 +624,12 @@ static inline void iosync(void)
>   *
>   * * iounmap undoes such a mapping and can be hooked
>   *
> + * * ioremap_early is for setting up mapping regions during early boot.  Useful
> + *   for console devices or mapping an entire region of SoC internal registers.
> + *   ioremap_early becomes usable at machine_init() time.  Care must be taken
> + *   when using this routine because it can consume limited resources like BAT
> + *   registers.
> + *
>   * * __ioremap_at (and the pending __iounmap_at) are low level functions to
>   *   create hand-made mappings for use only by the PCI code and cannot
>   *   currently be hooked. Must be page aligned.
> @@ -647,6 +653,8 @@ extern void __iomem *ioremap_flags(phys_addr_t address, unsigned long size,
>  
>  extern void iounmap(volatile void __iomem *addr);
>  
> +extern void __iomem *ioremap_early(phys_addr_t addr, unsigned long size);
> +
>  extern void __iomem *__ioremap(phys_addr_t, unsigned long size,
>  			       unsigned long flags);
>  extern void __iomem *__ioremap_caller(phys_addr_t, unsigned long size,
> diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
> index 9e1ca74..c1c0442 100644
> --- a/arch/powerpc/kernel/setup_32.c
> +++ b/arch/powerpc/kernel/setup_32.c
> @@ -41,6 +41,7 @@
>  #include <asm/mmu_context.h>
>  
>  #include "setup.h"
> +#include "mm/mmu_decl.h"
>  
>  #define DBG(fmt...)
>  
> @@ -118,6 +119,9 @@ notrace unsigned long __init early_init(unsigned long dt_ptr)
>   */
>  notrace void __init machine_init(unsigned long dt_ptr)
>  {
> +	/* Get ready to allocate IO virtual address regions */
> +	ioremap_init();
> +
>  	/* Enable early debugging if any specified (see udbg.h) */
>  	udbg_early_init();
>  
> diff --git a/arch/powerpc/mm/init_32.c b/arch/powerpc/mm/init_32.c
> index 3de6a0d..806c237 100644
> --- a/arch/powerpc/mm/init_32.c
> +++ b/arch/powerpc/mm/init_32.c
> @@ -168,9 +168,6 @@ void __init MMU_init(void)
>  		ppc_md.progress("MMU:mapin", 0x301);
>  	mapin_ram();
>  
> -	/* Initialize early top-down ioremap allocator */
> -	ioremap_bot = IOREMAP_TOP;
> -
>  	/* Map in I/O resources */
>  	if (ppc_md.progress)
>  		ppc_md.progress("MMU:setio", 0x302);
> diff --git a/arch/powerpc/mm/mmu_decl.h b/arch/powerpc/mm/mmu_decl.h
> index d1f9c62..6be30fe 100644
> --- a/arch/powerpc/mm/mmu_decl.h
> +++ b/arch/powerpc/mm/mmu_decl.h
> @@ -86,11 +86,14 @@ struct tlbcam {
>  
>  extern void mapin_ram(void);
>  extern int map_page(unsigned long va, phys_addr_t pa, int flags);
> -extern void setbat(int index, unsigned long virt, phys_addr_t phys,
> -		   unsigned int size, int flags);
> +extern int setbat(unsigned long virt, phys_addr_t phys, unsigned int size,
> +		  int flags);
> +extern int loadbat(unsigned long virt, phys_addr_t phys, unsigned int size,
> +		   int flags);
>  extern void settlbcam(int index, unsigned long virt, phys_addr_t phys,
>  		      unsigned int size, int flags, unsigned int pid);
>  extern void invalidate_tlbcam_entry(int index);
> +extern void ioremap_init(void); /* called by machine_init() */
>  
>  extern int __map_without_bats;
>  extern unsigned long ioremap_base;
> diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
> index 5422169..508fb91 100644
> --- a/arch/powerpc/mm/pgtable_32.c
> +++ b/arch/powerpc/mm/pgtable_32.c
> @@ -51,8 +51,6 @@ extern char etext[], _stext[];
>  #ifdef HAVE_BATS
>  extern phys_addr_t v_mapped_by_bats(unsigned long va);
>  extern unsigned long p_mapped_by_bats(phys_addr_t pa);
> -void setbat(int index, unsigned long virt, phys_addr_t phys,
> -	    unsigned int size, int flags);
>  
>  #else /* !HAVE_BATS */
>  #define v_mapped_by_bats(x)	(0UL)
> @@ -126,6 +124,16 @@ pgtable_t pte_alloc_one(struct mm_struct *mm, unsigned long address)
>  	return ptepage;
>  }
>  
> +/**
> + * ioremap_init - Initialize early top-down ioremap allocator
> + */
> +void __init ioremap_init(void)
> +{
> +	if (ioremap_bot)
> +		return;
> +	ioremap_bot = IOREMAP_TOP;
> +}
> +
>  void __iomem *
>  ioremap(phys_addr_t addr, unsigned long size)
>  {
> diff --git a/arch/powerpc/mm/ppc_mmu_32.c b/arch/powerpc/mm/ppc_mmu_32.c
> index 2d2a87e..01acd2e 100644
> --- a/arch/powerpc/mm/ppc_mmu_32.c
> +++ b/arch/powerpc/mm/ppc_mmu_32.c
> @@ -72,38 +72,41 @@ unsigned long p_mapped_by_bats(phys_addr_t pa)
>  	return 0;
>  }
>  
> +/**
> + * mmu_mapin_ram - Map as much of RAM as possible into kernel space using BATs
> + */
>  unsigned long __init mmu_mapin_ram(void)
>  {
>  	unsigned long tot, bl, done;
> -	unsigned long max_size = (256<<20);
> +	int rc;
>  
>  	if (__map_without_bats) {
> -		printk(KERN_DEBUG "RAM mapped without BATs\n");
> +		pr_debug("RAM mapped without BATs\n");
>  		return 0;
>  	}
>  
> -	/* Set up BAT2 and if necessary BAT3 to cover RAM. */
> -
> -	/* Make sure we don't map a block larger than the
> -	   smallest alignment of the physical address. */
> +	/* Set up BATs to cover RAM. */
>  	tot = total_lowmem;
> -	for (bl = 128<<10; bl < max_size; bl <<= 1) {
> -		if (bl * 2 > tot)
> +	done = 0;
> +	while (done < tot) {
> +		/* determine the smallest block size need to map the region.
> +		 * Don't use a BAT mapping if the remaining region is less
> +		 * that 128k */
> +		if (tot - done <= 128<<10)
>  			break;
> -	}
> -
> -	setbat(2, PAGE_OFFSET, 0, bl, PAGE_KERNEL_X);
> -	done = (unsigned long)bat_addrs[2].limit - PAGE_OFFSET + 1;
> -	if ((done < tot) && !bat_addrs[3].limit) {
> -		/* use BAT3 to cover a bit more */
> -		tot -= done;
> -		for (bl = 128<<10; bl < max_size; bl <<= 1)
> -			if (bl * 2 > tot)
> +		for (bl = 128<<10; bl < (256<<20); bl <<= 1)
> +			if ((bl * 2) > (tot - done))
>  				break;
> -		setbat(3, PAGE_OFFSET+done, done, bl, PAGE_KERNEL_X);
> -		done = (unsigned long)bat_addrs[3].limit - PAGE_OFFSET + 1;
> +
> +		/* Allocate the BAT and recalculate amount of RAM mapped */
> +		rc = setbat(PAGE_OFFSET+done, done, bl, PAGE_KERNEL_X);
> +		if (rc < 0)
> +			break;
> +		done = (unsigned long)bat_addrs[rc].limit - PAGE_OFFSET + 1;
>  	}
>  
> +	if (done == 0)
> +		pr_crit("Weird; No BATs available for RAM.\n");
>  	return done;
>  }
>  
> @@ -112,12 +115,29 @@ unsigned long __init mmu_mapin_ram(void)
>   * The parameters are not checked; in particular size must be a power
>   * of 2 between 128k and 256M.
>   */
> -void __init setbat(int index, unsigned long virt, phys_addr_t phys,
> -		   unsigned int size, int flags)
> +int __init setbat(unsigned long virt, phys_addr_t phys,
> +		  unsigned int size, int flags)
>  {
>  	unsigned int bl;
> -	int wimgxpp;
> -	struct ppc_bat *bat = BATS[index];
> +	int wimgxpp, index, nr_bats;
> +	struct ppc_bat *bat;
> +
> +	/* Find a free BAT
> +	 *
> +	 * Special case; Keep the first entry in reserve for mapping RAM.
> +	 * Otherwise the too many other users can prevent RAM from getting
> +	 * mapped at all with a BAT.
> +	 */
> +	index = (flags == PAGE_KERNEL_X) ? 0 : 1;
> +	nr_bats = mmu_has_feature(MMU_FTR_USE_HIGH_BATS) ? 8 : 4;
> +	for (; index < nr_bats; index++) {
> +		if ((BATS[index][0].batu == 0) && (BATS[index][1].batu == 0))
> +			break;
> +	}
> +	if (index == nr_bats)
> +		return -1;
> +
> +	bat = BATS[index];
>  
>  	if ((flags & _PAGE_NO_CACHE) ||
>  	    (cpu_has_feature(CPU_FTR_NEED_COHERENT) == 0))
> @@ -156,6 +176,150 @@ void __init setbat(int index, unsigned long virt, phys_addr_t phys,
>  	bat_addrs[index].start = virt;
>  	bat_addrs[index].limit = virt + ((bl + 1) << 17) - 1;
>  	bat_addrs[index].phys = phys;
> +	return index;
> +}
> +
> +/**
> + * loadbat - Set up and configure one of the I/D BAT register pairs.
> + * @virt - virtual address, 128k aligned
> + * @phys - physical address, 128k aligned
> + * @size - size of mapping
> + * @flags - region attribute flags
> + *
> + * Uses setbat() to allocate a BAT pair and immediately writes the
> + * configuration into the BAT registers (instead of waiting for load_up_mmu)
> + */
> +int __init loadbat(unsigned long virt, phys_addr_t phys,
> +		   unsigned int size, int flags)
> +{
> +	struct ppc_bat *bat;
> +	int i;
> +
> +	i = setbat(virt, phys, size, flags);
> +	if (i < 0)
> +		return i;
> +	bat = BATS[i];
> +
> +	/* BATs must be set with a switch statement because there is no way
> +	 * to paramaterize mtspr/mfspr instructions.
> +	 *
> +	 * Note: BAT0 is not handled here because early boot code depends
> +	 * on BAT0 for mapping first 16M of RAM.  setbat() keeps BAT0 in
> +	 * reserve for mapping main memory anyway, so this is okay.
> +	 */
> +	switch (i) {
> +	case 1:
> +		mtspr(SPRN_IBAT1U, bat[0].batu);
> +		mtspr(SPRN_IBAT1L, bat[0].batl);
> +		mtspr(SPRN_DBAT1U, bat[1].batu);
> +		mtspr(SPRN_DBAT1L, bat[1].batl);
> +		break;
> +	case 2:
> +		mtspr(SPRN_IBAT2U, bat[0].batu);
> +		mtspr(SPRN_IBAT2L, bat[0].batl);
> +		mtspr(SPRN_DBAT2U, bat[1].batu);
> +		mtspr(SPRN_DBAT2L, bat[1].batl);
> +		break;
> +	case 3:
> +		mtspr(SPRN_IBAT3U, bat[0].batu);
> +		mtspr(SPRN_IBAT3L, bat[0].batl);
> +		mtspr(SPRN_DBAT3U, bat[1].batu);
> +		mtspr(SPRN_DBAT3L, bat[1].batl);
> +		break;
> +	case 4:
> +		mtspr(SPRN_IBAT4U, bat[0].batu);
> +		mtspr(SPRN_IBAT4L, bat[0].batl);
> +		mtspr(SPRN_DBAT4U, bat[1].batu);
> +		mtspr(SPRN_DBAT4L, bat[1].batl);
> +		break;
> +	case 5:
> +		mtspr(SPRN_IBAT5U, bat[0].batu);
> +		mtspr(SPRN_IBAT5L, bat[0].batl);
> +		mtspr(SPRN_DBAT5U, bat[1].batu);
> +		mtspr(SPRN_DBAT5L, bat[1].batl);
> +		break;
> +	case 6:
> +		mtspr(SPRN_IBAT6U, bat[0].batu);
> +		mtspr(SPRN_IBAT6L, bat[0].batl);
> +		mtspr(SPRN_DBAT6U, bat[1].batu);
> +		mtspr(SPRN_DBAT6L, bat[1].batl);
> +		break;
> +	case 7:
> +		mtspr(SPRN_IBAT7U, bat[0].batu);
> +		mtspr(SPRN_IBAT7L, bat[0].batl);
> +		mtspr(SPRN_DBAT7U, bat[1].batu);
> +		mtspr(SPRN_DBAT7L, bat[1].batl);
> +		break;
> +	}
> +
> +	return i;
> +}
> +
> +/**
> + * ioremap_early - Allow large persistant IO regions to be mapped early.
> + * @addr: physical address of region
> + * @size: size of region
> + *
> + * This routine uses setbat() to set up IO ranges before the MMU is
> + * fully configured.
> + *
> + * This routine can be called really early, before MMU_init() is called.  It
> + * is useful for setting up early debug output consoles and frequently
> + * accessed IO regions, like the internally memory mapped registers (IMMR)
> + * in an SoC.  Ranges mapped with this function persist even after MMU_init()
> + * is called and the MMU is turned on 'for real.'
> + *
> + * The region mapped is large (minimum size of 128k) and virtual mapping must
> + * be aligned against this boundary.  Therefore, to avoid fragmentation all
> + * calls to ioremap_early() are best made before any calls to ioremap
> + * for smaller regions.
> + */
> +void __iomem * __init
> +ioremap_early(phys_addr_t addr, unsigned long size)
> +{
> +	unsigned long v, p, bl;
> +	int i;
> +
> +	/* Be loud and annoying if someone calls this too late.
> +	 * No need to crash the kernel though */
> +	WARN_ON(mem_init_done);
> +	if (mem_init_done)
> +		return NULL;
> +
> +	/* Make sure request is sane */
> +	if (size == 0)
> +		return NULL;
> +
> +	/* If the region is already block mapped, then there is nothing
> +	 * to do; just return the mapped address */
> +	v = p_mapped_by_bats(addr);
> +	if (v)
> +		return (void __iomem *)v;
> +
> +	/* Align region size */
> +	for (bl = 128<<10; bl < (256<<20); bl <<= 1) {
> +		p = _ALIGN_DOWN(addr, bl); /* BATs align on 128k boundaries */
> +		size = ALIGN(addr - p + size, bl);
> +		if (bl >= size)
> +			break;
> +	}
> +
> +	/* Complain loudly if too much is requested */
> +	if (bl >= (256<<20)) {
> +		WARN_ON(1);
> +		return NULL;
> +	}
> +
> +	/* Allocate the aligned virtual base address.  ALIGN_DOWN is used
> +	 * to ensure no overlaps occur with normal 4k ioremaps. */
> +	ioremap_bot = _ALIGN_DOWN(ioremap_bot, bl) - size;
> +
> +	/* Set up a BAT for this IO region */
> +	i = loadbat(ioremap_bot, p, size, PAGE_KERNEL_NCG);
> +	if (i < 0)
> +		return NULL;
> +
> +	return (void __iomem *) (ioremap_bot + (addr - p));
>  }
>  
>  /*
> diff --git a/arch/powerpc/platforms/52xx/mpc52xx_common.c b/arch/powerpc/platforms/52xx/mpc52xx_common.c
> index 8e3dd5a..2c49148 100644
> --- a/arch/powerpc/platforms/52xx/mpc52xx_common.c
> +++ b/arch/powerpc/platforms/52xx/mpc52xx_common.c
> @@ -146,7 +146,20 @@ static struct of_device_id mpc52xx_cdm_ids[] __initdata = {
>  void __init
>  mpc52xx_map_common_devices(void)
>  {
> +	const struct of_device_id immr_ids[] = {
> +		{ .compatible = "fsl,mpc5200-immr", },
> +		{ .compatible = "fsl,mpc5200b-immr", },
> +		{ .type = "soc", .compatible = "mpc5200", }, /* lite5200 */
> +		{ .type = "builtin", .compatible = "mpc5200", }, /* efika */
> +		{}
> +	};
>  	struct device_node *np;
> +	struct resource res;
> +
> +	/* Pre-map the whole register space using a BAT entry */
> +	np = of_find_matching_node(NULL, immr_ids);
> +	if (np && (of_address_to_resource(np, 0, &res) == 0))
> +		ioremap_early(res.start, res.end - res.start + 1);
>  
>  	/* mpc52xx_wdt is mapped here and used in mpc52xx_restart,
>  	 * possibly from a interrupt context. wdt is only implement
> diff --git a/arch/powerpc/sysdev/cpm_common.c b/arch/powerpc/sysdev/cpm_common.c
> index e4b6d66..370723e 100644
> --- a/arch/powerpc/sysdev/cpm_common.c
> +++ b/arch/powerpc/sysdev/cpm_common.c
> @@ -56,7 +56,7 @@ void __init udbg_init_cpm(void)
>  {
>  	if (cpm_udbg_txdesc) {
>  #ifdef CONFIG_CPM2
> -		setbat(1, 0xf0000000, 0xf0000000, 1024*1024, PAGE_KERNEL_NCG);
> +		setbat(0xf0000000, 0xf0000000, 1024*1024, PAGE_KERNEL_NCG);
>  #endif
>  		udbg_putc = udbg_putc_cpm;
>  	}
