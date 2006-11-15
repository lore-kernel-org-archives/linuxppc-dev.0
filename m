Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D876267CBA
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Nov 2006 05:04:50 +1100 (EST)
Date: Wed, 15 Nov 2006 19:04:40 +0100
From: Christoph Hellwig <hch@lst.de>
To: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: Re: [PATCH 7/16] powerpc: add support for ps3 platform
Message-ID: <20061115180440.GB18856@lst.de>
References: <4554DACB.8060809@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4554DACB.8060809@am.sony.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Index: cell--common--6/arch/powerpc/platforms/ps3pf/mm.c
> ===================================================================
> --- /dev/null
> +++ cell--common--6/arch/powerpc/platforms/ps3pf/mm.c
> @@ -0,0 +1,872 @@
> +/*
> + * mm.c - PS3 Platform address space management.

Please never put the filename in the start of file comments, it
gets out of date far to easily.

> + *
> + *  Copyright (C) 2006 Sony Computer Entertainment Inc.
> + *  Copyright 2006 Sony Corp.

One with a (C) and one without looks very odd.  Who from your corporate
mother Sony Corp touched this code anyway?

> +#undef DEBUG

No need to put this in, it's undefined by default.  And having it
prevents people from enabling debugging through the compiler flags.

> +#if defined(DEBUG)
> +#undef pr_debug
> +#define pr_debug(fmt...) udbg_printf(fmt)
> +#endif

Please don't do this kind of thing.  Either you want pr_debug then
you use it as-is, or you want something different and you should call
it different.

> +
> +enum {
> +#if defined(CONFIG_PS3PF_USE_LPAR_ADDR)
> +	USE_LPAR_ADDR = 1,
> +#else
> +	USE_LPAR_ADDR = 0,
> +#endif
> +#if defined(CONFIG_PS3PF_DYNAMIC_DMA)
> +	USE_DYNAMIC_DMA = 1,
> +#else
> +	USE_DYNAMIC_DMA = 0,
> +#endif
> +};

This is really ugly.  At least dynamic_dma (or as we'd say it iommu)
shoud be a runtime feature.  So this should just be an

  "int ps3hv_use_iommu"
  
variable initialize to the proper default.

> +
> +enum page_size {
> +	page_size_4k = 12U,
> +	page_size_64k = 16U,
> +	page_size_16m = 24U,
> +};

Please use ALL_CAPS for such constants.


> +
> +enum allocate_memory {
> +	/* bit 63: transferability */
> +	LV1_AM_TF_NO = 0x00,
> +	LV1_AM_TF_YES = 0x01,
> +	/* bit 62: destruction scheme */
> +	LV1_AM_DS_NO_CONNECTIONS = 0x00,
> +	LV1_AM_DS_ANYTIME = 0x02,
> +	/* bit 61: fail or alternative */
> +	LV1_AM_FA_FAIL = 0x00,
> +	LV1_AM_FA_ALTERNATIVE = 0x04,
> +	/* bit 60: lpar address */
> +	LV1_AM_ADDR_ANY = 0x00,
> +	LV1_AM_ADDR_0 = 0x08,
> +};

If these are for different its they should be in different enums
and use different prefixes.

> +/**
> + * struct mem_region - memory region structure
> + * @base: base address
> + * @size: size in bytes
> + * @offset: difference between base and rm.size
> + */
> +
> +struct mem_region {
> +	unsigned long base;
> +	unsigned long size;
> +	unsigned long offset;
> +};

This seems like a duplication of the iseries lmb, please try to reuse
that functionality.

> + * @len: Length in bytes of the area to map.
> + * c_out: A pointer to receive an allocated struct dma_chunk for this area.
> + *
> + * This is the lowest level dma mapping routine, and is the one that will
> + * make the HV call to add the pages into the io controller address space.
> + */
> +
> +static int dma_map_pages(struct ps3pf_dma_region *r, unsigned long virt_addr,
> +	unsigned long len, struct dma_chunk **c_out)
> +{
> +	int result;
> +	unsigned long phys_addr;
> +	struct dma_chunk *c;
> +
> +	phys_addr = is_kernel_addr(virt_addr) ? __pa(virt_addr) : virt_addr;

When do you ever get non-kernel addresses into the dma calls? I in
either case this should move into the caller and the routine
should get a simple unsigned long phys_addr argument.

But when looking at this whole dma_map code is looks rather bogus to
me.  Could it be that you try to pre-map dma regions rather than doing
it through the dma API?

> +#if !defined(_510B7842_EE09_4B12_BE5C_D217383D50C7)
> +#define _510B7842_EE09_4B12_BE5C_D217383D50C7

WTF?

> +#if defined(CONFIG_BLK_DEV_INITRD)
> + 	if (initrd_start)
> + 		ROOT_DEV = Root_RAM0;
> + 	else
> +#endif
> +#if defined(CONFIG_ROOT_NFS)
> +		ROOT_DEV = Root_NFS;
> +#else
> + 		ROOT_DEV = Root_HDA1;
> +#endif

Please don't put this auto-select root device idiocy into any new
ports (Yeah, I'm pretty sure you just copy & pasted it from somewhere..)

> +#if !defined(PPC_MSG_MIGRATE_TASK)
> +static const int PPC_MSG_MIGRATE_TASK = 2;
> +#endif

This looks rather odd, what is it trying to do?

> +unsigned long __deprecated ps3pf_legacy_virq_to_outlet(unsigned int virq);

Never put deprecated routines into a new code submission.
