Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E453CDE324
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2007 00:06:04 +1000 (EST)
In-Reply-To: <20071014044205.23438.36036.stgit@trillian.cg.shawcable.net>
References: <20071014044041.23438.14070.stgit@trillian.cg.shawcable.net>
	<20071014044205.23438.36036.stgit@trillian.cg.shawcable.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <C2B03958-38CC-4B5C-96C1-E8B5366C4D49@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v2 4/7] bestcomm: core bestcomm support for Freescale
	MPC5200
Date: Mon, 15 Oct 2007 09:06:32 -0500
To: Grant Likely <grant.likely@secretlab.ca>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, domen.puncer@telargo.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

(Comments just on SRAM code)

I think this should be made generic and be utility functionality to  
rheap.

CPM, CPM2, QE, L2 SRAM, etc can all use this.  I'd rather we didn't  
have 3 ways to do the exact same functionality.  (cpm_dpalloc,  
cpm_dpfree, qe_muram_alloc, qe_muram_free)

see other comments inline.

> +
> diff --git a/arch/powerpc/sysdev/bestcomm/sram.c b/arch/powerpc/ 
> sysdev/bestcomm/sram.c
> new file mode 100644
> index 0000000..b3f2ed1
> --- /dev/null
> +++ b/arch/powerpc/sysdev/bestcomm/sram.c
> @@ -0,0 +1,177 @@
> +/*
> + * Simple memory allocator for on-board SRAM
> + *
> + *
> + * Maintainer : Sylvain Munaut <tnt@246tNt.com>
> + *
> + * Copyright (C) 2005 Sylvain Munaut <tnt@246tNt.com>
> + *
> + * This file is licensed under the terms of the GNU General Public  
> License
> + * version 2. This program is licensed "as is" without any  
> warranty of any
> + * kind, whether express or implied.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>
> +#include <linux/string.h>
> +#include <linux/ioport.h>
> +#include <linux/of.h>
> +
> +#include <asm/io.h>
> +#include <asm/mmu.h>
> +
> +#include "sram.h"
> +
> +
> +/* Struct keeping our 'state' */
> +struct bcom_sram *bcom_sram = NULL;

shouldn't be global, so we can support more than one SRAM.

> +EXPORT_SYMBOL_GPL(bcom_sram);	/* needed for inline functions */
> +
> +
> +/*  
> ====================================================================== 
> == */
> +/* Public  
> API                                                               */
> +/*  
> ====================================================================== 
> == */
> +/* DO NOT USE in interrupts, if needed in irq handler, we should  
> use the
> +   _irqsave version of the spin_locks */
> +
> +int bcom_sram_init(struct device_node *sram_node, char *owner)
> +{
> +	int rv;
> +	const u32 *regaddr_p;
> +	u64 regaddr64, size64;
> +	unsigned int psize;
> +
> +	/* Create our state struct */
> +	if (bcom_sram) {
> +		printk(KERN_ERR "%s: bcom_sram_init: "
> +			"Already initialiwed !\n", owner);
> +		return -EBUSY;
> +	}
> +
> +	bcom_sram = kmalloc(sizeof(struct bcom_sram), GFP_KERNEL);

should return this handle to the user.

> +	if (!bcom_sram) {
> +		printk(KERN_ERR "%s: bcom_sram_init: "
> +			"Couldn't allocate internal state !\n", owner);
> +		return -ENOMEM;
> +	}
> +
> +	/* Get address and size of the sram */
> +	regaddr_p = of_get_address(sram_node, 0, &size64, NULL);
> +	if (!regaddr_p) {
> +		printk(KERN_ERR "%s: bcom_sram_init: "
> +			"Invalid device node !\n", owner);
> +		rv = -EINVAL;
> +		goto error_free;
> +	}
> +
> +	regaddr64 = of_translate_address(sram_node, regaddr_p);
> +
> +	bcom_sram->base_phys = (phys_addr_t) regaddr64;
> +	bcom_sram->size = (unsigned int) size64;
> +
> +	/* Request region */
> +	if (!request_mem_region(bcom_sram->base_phys, bcom_sram->size,  
> owner)) {
> +		printk(KERN_ERR "%s: bcom_sram_init: "
> +			"Couln't request region !\n", owner);
> +		rv = -EBUSY;
> +		goto error_free;
> +	}
> +
> +	/* Map SRAM */
> +		/* sram is not really __iomem */
> +	bcom_sram->base_virt = (void*) ioremap(bcom_sram->base_phys,  
> bcom_sram->size);
> +
> +	if (!bcom_sram->base_virt) {
> +		printk(KERN_ERR "%s: bcom_sram_init: "
> +			"Map error SRAM zone 0x%08lx (0x%0x)!\n",
> +			owner, bcom_sram->base_phys, bcom_sram->size );
> +		rv = -ENOMEM;
> +		goto error_release;
> +	}
> +
> +	/* Create an rheap (defaults to 32 bits word alignment) */
> +	bcom_sram->rh = rh_create(4);
> +
> +	/* Attach the free zones */
> +#if 0
> +	/* Currently disabled ... for future use only */
> +	reg_addr_p = of_get_property(sram_node, "available", &psize);
> +#else
> +	regaddr_p = NULL;
> +	psize = 0;
> +#endif
> +
> +	if (!regaddr_p || !psize) {
> +		/* Attach the whole zone */
> +		rh_attach_region(bcom_sram->rh, 0, bcom_sram->size);
> +	} else {
> +		/* Attach each zone independently */
> +		while (psize >= 2 * sizeof(u32)) {
> +			phys_addr_t zbase = of_translate_address(sram_node, regaddr_p);
> +			rh_attach_region(bcom_sram->rh, zbase - bcom_sram->base_phys,  
> regaddr_p[1]);
> +			regaddr_p += 2;
> +			psize -= 2 * sizeof(u32);
> +		}
> +	}
> +
> +	/* Init our spinlock */
> +	spin_lock_init(&bcom_sram->lock);
> +
> +	return 0;
> +
> +error_release:
> +	release_mem_region(bcom_sram->base_phys, bcom_sram->size);
> +error_free:
> +	kfree(bcom_sram);
> +	bcom_sram = NULL;
> +
> +	return rv;
> +}
> +EXPORT_SYMBOL_GPL(bcom_sram_init);
> +
> +void bcom_sram_cleanup(void)
> +{
> +	/* Free resources */

should take bcom_sram handle as a param

> +	if (bcom_sram) {
> +		rh_destroy(bcom_sram->rh);
> +		iounmap((void __iomem *)bcom_sram->base_virt);
> +		release_mem_region(bcom_sram->base_phys, bcom_sram->size);
> +		kfree(bcom_sram);
> +		bcom_sram = NULL;
> +	}
> +}
> +EXPORT_SYMBOL_GPL(bcom_sram_cleanup);
> +
> +void* bcom_sram_alloc(int size, int align, phys_addr_t *phys)
> +{
> +	unsigned long offset;

should take bcom_sram handle as a param

> +
> +	spin_lock(&bcom_sram->lock);
> +	offset = rh_alloc_align(bcom_sram->rh, size, align, NULL);
> +	spin_unlock(&bcom_sram->lock);
> +
> +	if (IS_ERR_VALUE(offset))
> +		return NULL;
> +
> +	*phys = bcom_sram->base_phys + offset;
> +	return bcom_sram->base_virt + offset;
> +}
> +EXPORT_SYMBOL_GPL(bcom_sram_alloc);
> +
> +void bcom_sram_free(void *ptr)
> +{
> +	unsigned long offset;
> +
should take bcom_sram handle as a param


> +	if (!ptr)
> +		return;
> +
> +	offset = ptr - bcom_sram->base_virt;
> +
> +	spin_lock(&bcom_sram->lock);
> +	rh_free(bcom_sram->rh, offset);
> +	spin_unlock(&bcom_sram->lock);
> +}
> +EXPORT_SYMBOL_GPL(bcom_sram_free);
> +
> diff --git a/arch/powerpc/sysdev/bestcomm/sram.h b/arch/powerpc/ 
> sysdev/bestcomm/sram.h
> new file mode 100644
> index 0000000..b6d6689
> --- /dev/null
> +++ b/arch/powerpc/sysdev/bestcomm/sram.h
> @@ -0,0 +1,54 @@
> +/*
> + * Handling of a sram zone for bestcomm
> + *
> + *
> + * Copyright (C) 2007 Sylvain Munaut <tnt@246tNt.com>
> + *
> + * This file is licensed under the terms of the GNU General Public  
> License
> + * version 2. This program is licensed "as is" without any  
> warranty of any
> + * kind, whether express or implied.
> + */
> +
> +#ifndef __BESTCOMM_SRAM_H__
> +#define __BESTCOMM_SRAM_H__
> +
> +#include <asm/rheap.h>
> +#include <asm/mmu.h>
> +#include <linux/spinlock.h>
> +
> +
> +/* Structure used internally */
> +	/* The internals are here for the inline functions
> +	 * sake, certainly not for the user to mess with !
> +	 */
> +struct bcom_sram {
> +	phys_addr_t		 base_phys;
> +	void 			*base_virt;

__iomem for base_virt?

> +	unsigned int		 size;
> +	rh_info_t		*rh;
> +	spinlock_t		 lock;
> +};
> +
> +extern struct bcom_sram *bcom_sram;
> +
> +
> +/* Public API */
> +extern int  bcom_sram_init(struct device_node *sram_node, char  
> *owner);
> +extern void bcom_sram_cleanup(void);
> +
> +extern void* bcom_sram_alloc(int size, int align, phys_addr_t *phys);
> +extern void  bcom_sram_free(void *ptr);
> +
> +static inline phys_addr_t bcom_sram_va2pa(void *va) {

should take bcom_sram handle as a param

> +	return bcom_sram->base_phys +
> +		(unsigned long)(va - bcom_sram->base_virt);

shouldn't this cast be phys_addr_t?

> +}
> +
> +static inline void *bcom_sram_pa2va(phys_addr_t pa) {

should take bcom_sram handle as a param


> +	return bcom_sram->base_virt +
> +		(unsigned long)(pa - bcom_sram->base_phys);

shouldn't this cast be phys_addr_t?


> +}
> +
> +
> +#endif  /* __BESTCOMM_SRAM_H__ */
> +
