Return-Path: <Wei.Zhang@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 45567DDE17
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Mar 2008 14:18:53 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	m2P3IkP8025808
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Mar 2008 20:18:47 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id m2P3Ihbc026264
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Mar 2008 22:18:44 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] [POWERPC] Introduce lowmem_end_addr to distiguish
	fromtotal_lowmem
Date: Tue, 25 Mar 2008 11:18:42 +0800
Message-ID: <78567AC4946EDC42B7DE978C350CD869EC52AE@zch01exm26.fsl.freescale.net>
In-Reply-To: <Pine.LNX.4.64.0803241832570.29472@blarg.am.freescale.net>
References: <Pine.LNX.4.64.0803241832570.29472@blarg.am.freescale.net>
From: "Zhang Wei" <Wei.Zhang@freescale.com>
To: "Kumar Gala" <galak@kernel.crashing.org>, <linuxppc-dev@ozlabs.org>
Cc: Wang Haiying <Haiying.Wang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi, Kumar,

> -----Original Message-----
> From: linuxppc-dev-bounces+wei.zhang=3Dfreescale.com@ozlabs.org=20
>=20
> total_lowmem represents the amount of low memory not the=20
> physical address
> that low memory ends at.  If the start of memory is at 0 it=20
> happends that
> total_lowmem can be used as both the size and the address that lowmem
> ends at. (technical its one byte beyond the end)
>=20
> To make the code a bit more clear and deal with the case when=20
> the start of
> memory isn't at physical 0, we introduce lowmem_end_addr that=20
> represents
> one byte beyond the last physical address in the lowmem region.

About the kernel memory offset, if the memory area from phyical 0
 to lowmem start address is reserved for other usage in this kernel,
 no more comments. If it will be used by other kernel (in asmp mode),
 how about to use tlb mapping physical address to virtual address 0
 not move the kernel lowmem address? I consider the tlb mapping
 will be more safe.

Cheers!
Wei.

>=20
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---
>  arch/powerpc/mm/44x_mmu.c |    2 +-
>  arch/powerpc/mm/init_32.c |    4 +++-
>  arch/powerpc/mm/init_64.c |    2 ++
>  arch/powerpc/mm/mem.c     |   16 +++++++++-------
>  4 files changed, 15 insertions(+), 9 deletions(-)
>=20
> diff --git a/arch/powerpc/mm/44x_mmu.c b/arch/powerpc/mm/44x_mmu.c
> index 04dc087..953fb91 100644
> --- a/arch/powerpc/mm/44x_mmu.c
> +++ b/arch/powerpc/mm/44x_mmu.c
> @@ -67,7 +67,7 @@ unsigned long __init mmu_mapin_ram(void)
>=20
>  	/* Pin in enough TLBs to cover any lowmem not covered by the
>  	 * initial 256M mapping established in head_44x.S */
> -	for (addr =3D PPC_PIN_SIZE; addr < total_lowmem;
> +	for (addr =3D PPC_PIN_SIZE; addr < lowmem_end_addr;
>  	     addr +=3D PPC_PIN_SIZE)
>  		ppc44x_pin_tlb(addr + PAGE_OFFSET, addr);
>=20
> diff --git a/arch/powerpc/mm/init_32.c b/arch/powerpc/mm/init_32.c
> index 01a81a0..345a275 100644
> --- a/arch/powerpc/mm/init_32.c
> +++ b/arch/powerpc/mm/init_32.c
> @@ -147,6 +147,7 @@ void __init MMU_init(void)
>  	}
>=20
>  	total_lowmem =3D total_memory =3D lmb_end_of_DRAM() - memstart_addr;
> +	lowmem_end_addr =3D memstart_addr + total_lowmem;
>=20
>  #ifdef CONFIG_FSL_BOOKE
>  	/* Freescale Book-E parts expect lowmem to be mapped by=20
> fixed TLB
> @@ -157,9 +158,10 @@ void __init MMU_init(void)
>=20
>  	if (total_lowmem > __max_low_memory) {
>  		total_lowmem =3D __max_low_memory;
> +		lowmem_end_addr =3D memstart_addr + total_lowmem;
>  #ifndef CONFIG_HIGHMEM
>  		total_memory =3D total_lowmem;
> -		lmb_enforce_memory_limit(total_lowmem);
> +		lmb_enforce_memory_limit(lowmem_end_addr);
>  		lmb_analyze();
>  #endif /* CONFIG_HIGHMEM */
>  	}
> diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
> index abeb0eb..f18b203 100644
> --- a/arch/powerpc/mm/init_64.c
> +++ b/arch/powerpc/mm/init_64.c
> @@ -75,6 +75,8 @@
>  /* max amount of RAM to use */
>  unsigned long __max_memory;
>=20
> +phys_addr_t memstart_addr;
> +
>  void free_initmem(void)
>  {
>  	unsigned long addr;
> diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
> index 60c019c..9c10b14 100644
> --- a/arch/powerpc/mm/mem.c
> +++ b/arch/powerpc/mm/mem.c
> @@ -217,9 +217,11 @@ void __init do_init_bootmem(void)
>  	unsigned long total_pages;
>  	int boot_mapsize;
>=20
> -	max_pfn =3D total_pages =3D lmb_end_of_DRAM() >> PAGE_SHIFT;
> +	max_pfn =3D lmb_end_of_DRAM() >> PAGE_SHIFT;
> +	total_pages =3D (lmb_end_of_DRAM() - memstart_addr) >> PAGE_SHIFT;
>  #ifdef CONFIG_HIGHMEM
>  	total_pages =3D total_lowmem >> PAGE_SHIFT;
> +	max_low_pfn =3D lowmem_end_addr >> PAGE_SHIFT;
>  #endif
>=20
>  	/*
> @@ -245,18 +247,18 @@ void __init do_init_bootmem(void)
>  	 * present.
>  	 */
>  #ifdef CONFIG_HIGHMEM
> -	free_bootmem_with_active_regions(0, total_lowmem >> PAGE_SHIFT);
> +	free_bootmem_with_active_regions(0, lowmem_end_addr >>=20
> PAGE_SHIFT);
>=20
>  	/* reserve the sections we're already using */
>  	for (i =3D 0; i < lmb.reserved.cnt; i++) {
>  		unsigned long addr =3D lmb.reserved.region[i].base +
>  				    =20
> lmb_size_bytes(&lmb.reserved, i) - 1;
> -		if (addr < total_lowmem)
> +		if (addr < lowmem_end_addr)
>  			reserve_bootmem(lmb.reserved.region[i].base,
>  				=09
> lmb_size_bytes(&lmb.reserved, i),
>  					BOOTMEM_DEFAULT);
> -		else if (lmb.reserved.region[i].base < total_lowmem) {
> -			unsigned long adjusted_size =3D total_lowmem -
> +		else if (lmb.reserved.region[i].base <=20
> lowmem_end_addr) {
> +			unsigned long adjusted_size =3D lowmem_end_addr -
>  				      lmb.reserved.region[i].base;
>  			reserve_bootmem(lmb.reserved.region[i].base,
>  					adjusted_size, BOOTMEM_DEFAULT);
> @@ -326,7 +328,7 @@ void __init paging_init(void)
>  	       (top_of_ram - total_ram) >> 20);
>  	memset(max_zone_pfns, 0, sizeof(max_zone_pfns));
>  #ifdef CONFIG_HIGHMEM
> -	max_zone_pfns[ZONE_DMA] =3D total_lowmem >> PAGE_SHIFT;
> +	max_zone_pfns[ZONE_DMA] =3D lowmem_end_addr >> PAGE_SHIFT;
>  	max_zone_pfns[ZONE_HIGHMEM] =3D top_of_ram >> PAGE_SHIFT;
>  #else
>  	max_zone_pfns[ZONE_DMA] =3D top_of_ram >> PAGE_SHIFT;
> @@ -381,7 +383,7 @@ void __init mem_init(void)
>  	{
>  		unsigned long pfn, highmem_mapnr;
>=20
> -		highmem_mapnr =3D total_lowmem >> PAGE_SHIFT;
> +		highmem_mapnr =3D lowmem_end_addr >> PAGE_SHIFT;
>  		for (pfn =3D highmem_mapnr; pfn < max_mapnr; ++pfn) {
>  			struct page *page =3D pfn_to_page(pfn);
>  			if (lmb_is_reserved(pfn << PAGE_SHIFT))
> --=20
> 1.5.4.1
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>=20
