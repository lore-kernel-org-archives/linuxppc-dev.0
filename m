Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 5015D2C0123
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Aug 2012 06:50:02 +1000 (EST)
Subject: Re: [PATCH][v2] powerpc/mm: using two zones for freescale 64 bit
 kernel
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1345805425-3829-1-git-send-email-Shaohui.Xie@freescale.com>
Date: Thu, 30 Aug 2012 15:49:50 -0500
Message-Id: <9EADE983-F25D-41BC-8A04-E69A20BF68E3@kernel.crashing.org>
References: <1345805425-3829-1-git-send-email-Shaohui.Xie@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Mingkai Hu <Mingkai.hu@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>,
 Shaohui Xie <Shaohui.Xie@freescale.com>, Chen Yuanquan <B41889@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Aug 24, 2012, at 5:50 AM, Shaohui Xie wrote:

> PowerPC platform only supports ZONE_DMA zone for 64bit kernel, so all =
the
> memory will be put into this zone. If the memory size is greater than
> the device's DMA capability and device uses dma_alloc_coherent to =
allocate
> memory, it will get an address which is over the device's DMA =
addressing,
> the device will fail.
>=20
> So we split the memory to two zones: zone ZONE_DMA32 & ZONE_NORMAL, =
since
> we already allocate PCICSRBAR/PEXCSRBAR right below the 4G boundary =
(if the
> lowest PCI address is above 4G), so we constrain the DMA zone =
ZONE_DMA32
> to 2GB, also, we clear flag __GFP_DMA & __GFP_DMA32 and set =
__GFP_DMA32 only
> if the device's dma_mask < total memory size. By doing this, devices =
which
> cannot DMA all the memory will be limited to ZONE_DMA32, but devices =
which
> can DMA all the memory will not be affected by this limitation.
>=20
> Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>
> Signed-off-by: Mingkai Hu <Mingkai.hu@freescale.com>
> Signed-off-by: Chen Yuanquan <B41889@freescale.com>
> ---
> changes for v2:
> 1. use a config option for using two zones (ZONE_DMA32 & ZONE_NORMAL) =
in
> freescale 64 bit kernel.
>=20
> arch/powerpc/Kconfig      |    3 +++
> arch/powerpc/kernel/dma.c |   15 +++++++++++++++
> arch/powerpc/mm/mem.c     |    4 ++++
> 3 files changed, 22 insertions(+), 0 deletions(-)

Ben,

What's the feeling of doing this on ppc64 always?=20

- k

>=20
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 352f416..a96fbbb 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -629,6 +629,9 @@ config ZONE_DMA
> 	bool
> 	default y
>=20
> +config ZONE_DMA32
> +	def_bool (PPC64 && PPC_FSL_BOOK3E)
> +
> config NEED_DMA_MAP_STATE
> 	def_bool (PPC64 || NOT_COHERENT_CACHE)
>=20
> diff --git a/arch/powerpc/kernel/dma.c b/arch/powerpc/kernel/dma.c
> index 355b9d8..cbf5ac1 100644
> --- a/arch/powerpc/kernel/dma.c
> +++ b/arch/powerpc/kernel/dma.c
> @@ -41,9 +41,24 @@ void *dma_direct_alloc_coherent(struct device *dev, =
size_t size,
> #else
> 	struct page *page;
> 	int node =3D dev_to_node(dev);
> +#ifdef CONFIG_ZONE_DMA32
> +	phys_addr_t top_ram_pfn =3D memblock_end_of_DRAM();
>=20
> +	/*
> +	 * check for crappy device which has dma_mask < ZONE_DMA, and
> +	 * we are not going to support it, just warn and fail.
> +	 */
> +	if (*dev->dma_mask < DMA_BIT_MASK(31)) {
> +		dev_err(dev, "Unsupported dma_mask 0x%llx\n", =
*dev->dma_mask);
> +		return NULL;
> +	}
> 	/* ignore region specifiers */
> +	flag  &=3D ~(__GFP_HIGHMEM | __GFP_DMA | __GFP_DMA32);
> +	if (*dev->dma_mask < top_ram_pfn - 1)
> +		flag |=3D __GFP_DMA32;
> +#else
> 	flag  &=3D ~(__GFP_HIGHMEM);
> +#endif
>=20
> 	page =3D alloc_pages_node(node, flag, get_order(size));
> 	if (page =3D=3D NULL)
> diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
> index baaafde..2a11e49 100644
> --- a/arch/powerpc/mm/mem.c
> +++ b/arch/powerpc/mm/mem.c
> @@ -280,6 +280,10 @@ void __init paging_init(void)
> #ifdef CONFIG_HIGHMEM
> 	max_zone_pfns[ZONE_DMA] =3D lowmem_end_addr >> PAGE_SHIFT;
> 	max_zone_pfns[ZONE_HIGHMEM] =3D top_of_ram >> PAGE_SHIFT;
> +#elif defined CONFIG_ZONE_DMA32
> +	max_zone_pfns[ZONE_DMA32] =3D min_t(phys_addr_t, top_of_ram,
> +					1ull << 31) >> PAGE_SHIFT;
> +	max_zone_pfns[ZONE_NORMAL] =3D top_of_ram >> PAGE_SHIFT;
> #else
> 	max_zone_pfns[ZONE_DMA] =3D top_of_ram >> PAGE_SHIFT;
> #endif
> --=20
> 1.6.4
>=20
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
