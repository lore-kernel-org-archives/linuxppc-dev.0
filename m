Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.180])
	by ozlabs.org (Postfix) with ESMTP id 55704DE094
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2007 00:20:08 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so2125674wag
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Oct 2007 07:20:07 -0700 (PDT)
Message-ID: <fa686aa40710150720x6c0ab76hf45d434740d5718f@mail.gmail.com>
Date: Mon, 15 Oct 2007 08:20:06 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Kumar Gala" <galak@kernel.crashing.org>
Subject: Re: [PATCH v2 4/7] bestcomm: core bestcomm support for Freescale
	MPC5200
In-Reply-To: <C2B03958-38CC-4B5C-96C1-E8B5366C4D49@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20071014044041.23438.14070.stgit@trillian.cg.shawcable.net>
	<20071014044205.23438.36036.stgit@trillian.cg.shawcable.net>
	<C2B03958-38CC-4B5C-96C1-E8B5366C4D49@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, domen.puncer@telargo.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 10/15/07, Kumar Gala <galak@kernel.crashing.org> wrote:
> (Comments just on SRAM code)
>
> I think this should be made generic and be utility functionality to
> rheap.
>
> CPM, CPM2, QE, L2 SRAM, etc can all use this.  I'd rather we didn't
> have 3 ways to do the exact same functionality.  (cpm_dpalloc,
> cpm_dpfree, qe_muram_alloc, qe_muram_free)

Fair enough; but not in this patch set.  This series is working
support for bestcomm.  To go to the more generic level of being used
by multiple parts should be done in a separate series.

>
> see other comments inline.
>
> > +
> > diff --git a/arch/powerpc/sysdev/bestcomm/sram.c b/arch/powerpc/
> > sysdev/bestcomm/sram.c
> > new file mode 100644
> > index 0000000..b3f2ed1
> > --- /dev/null
> > +++ b/arch/powerpc/sysdev/bestcomm/sram.c
> > @@ -0,0 +1,177 @@
> > +/*
> > + * Simple memory allocator for on-board SRAM
> > + *
> > + *
> > + * Maintainer : Sylvain Munaut <tnt@246tNt.com>
> > + *
> > + * Copyright (C) 2005 Sylvain Munaut <tnt@246tNt.com>
> > + *
> > + * This file is licensed under the terms of the GNU General Public
> > License
> > + * version 2. This program is licensed "as is" without any
> > warranty of any
> > + * kind, whether express or implied.
> > + */
> > +
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/slab.h>
> > +#include <linux/spinlock.h>
> > +#include <linux/string.h>
> > +#include <linux/ioport.h>
> > +#include <linux/of.h>
> > +
> > +#include <asm/io.h>
> > +#include <asm/mmu.h>
> > +
> > +#include "sram.h"
> > +
> > +
> > +/* Struct keeping our 'state' */
> > +struct bcom_sram *bcom_sram = NULL;
>
> shouldn't be global, so we can support more than one SRAM.

Again; I agree, but I'm not going to make that change in this series.

>
> > +EXPORT_SYMBOL_GPL(bcom_sram);        /* needed for inline functions */
> > +
> > +
> > +/*
> > ======================================================================
> > == */
> > +/* Public
> > API                                                               */
> > +/*
> > ======================================================================
> > == */
> > +/* DO NOT USE in interrupts, if needed in irq handler, we should
> > use the
> > +   _irqsave version of the spin_locks */
> > +
> > +int bcom_sram_init(struct device_node *sram_node, char *owner)
> > +{
> > +     int rv;
> > +     const u32 *regaddr_p;
> > +     u64 regaddr64, size64;
> > +     unsigned int psize;
> > +
> > +     /* Create our state struct */
> > +     if (bcom_sram) {
> > +             printk(KERN_ERR "%s: bcom_sram_init: "
> > +                     "Already initialiwed !\n", owner);
> > +             return -EBUSY;
> > +     }
> > +
> > +     bcom_sram = kmalloc(sizeof(struct bcom_sram), GFP_KERNEL);
>
> should return this handle to the user.

To be done when this driver is changed to support multiple sram regions.

> > diff --git a/arch/powerpc/sysdev/bestcomm/sram.h b/arch/powerpc/
> > sysdev/bestcomm/sram.h
> > new file mode 100644
> > index 0000000..b6d6689
> > --- /dev/null
> > +++ b/arch/powerpc/sysdev/bestcomm/sram.h
> > @@ -0,0 +1,54 @@
> > +/*
> > + * Handling of a sram zone for bestcomm
> > + *
> > + *
> > + * Copyright (C) 2007 Sylvain Munaut <tnt@246tNt.com>
> > + *
> > + * This file is licensed under the terms of the GNU General Public
> > License
> > + * version 2. This program is licensed "as is" without any
> > warranty of any
> > + * kind, whether express or implied.
> > + */
> > +
> > +#ifndef __BESTCOMM_SRAM_H__
> > +#define __BESTCOMM_SRAM_H__
> > +
> > +#include <asm/rheap.h>
> > +#include <asm/mmu.h>
> > +#include <linux/spinlock.h>
> > +
> > +
> > +/* Structure used internally */
> > +     /* The internals are here for the inline functions
> > +      * sake, certainly not for the user to mess with !
> > +      */
> > +struct bcom_sram {
> > +     phys_addr_t              base_phys;
> > +     void                    *base_virt;
>
> __iomem for base_virt?

I'll take a look

>
> > +     unsigned int             size;
> > +     rh_info_t               *rh;
> > +     spinlock_t               lock;
> > +};
> > +
> > +extern struct bcom_sram *bcom_sram;
> > +
> > +
> > +/* Public API */
> > +extern int  bcom_sram_init(struct device_node *sram_node, char
> > *owner);
> > +extern void bcom_sram_cleanup(void);
> > +
> > +extern void* bcom_sram_alloc(int size, int align, phys_addr_t *phys);
> > +extern void  bcom_sram_free(void *ptr);
> > +
> > +static inline phys_addr_t bcom_sram_va2pa(void *va) {
>
> should take bcom_sram handle as a param
>
> > +     return bcom_sram->base_phys +
> > +             (unsigned long)(va - bcom_sram->base_virt);
>
> shouldn't this cast be phys_addr_t?

I don't think so.  ->base_phys is of type phys_addr_t;
(va-bcom_sram->base_virt) is just an offset from ->base_phys.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
