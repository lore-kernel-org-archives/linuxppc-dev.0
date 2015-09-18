Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0148.outbound.protection.outlook.com [65.55.169.148])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 613EB1A04B3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2015 12:39:33 +1000 (AEST)
Message-ID: <1442543958.19102.91.camel@freescale.com>
Subject: Re: [PATCH v9 3/5] qe_common: add qe_muram_ functions to manage muram
From: Scott Wood <scottwood@freescale.com>
To: Zhao Qiang-B45475 <qiang.zhao@freescale.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "lauraa@codeaurora.org" <lauraa@codeaurora.org>, Xie Xiaobo-R63061
 <X.Xie@freescale.com>, "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
 Li Yang-Leo-R58472 <LeoLi@freescale.com>, "paulus@samba.org"
 <paulus@samba.org>
Date: Thu, 17 Sep 2015 21:39:18 -0500
In-Reply-To: <SN1PR0301MB15505D0C83E1D28D2FE6517F9B590@SN1PR0301MB1550.namprd03.prod.outlook.com>
References: <1442194700-6194-1-git-send-email-qiang.zhao@freescale.com>
 <1442194700-6194-3-git-send-email-qiang.zhao@freescale.com>
 <1442521702.19102.75.camel@freescale.com>
 <SN1PR0301MB15505D0C83E1D28D2FE6517F9B590@SN1PR0301MB1550.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-09-17 at 21:35 -0500, Zhao Qiang-B45475 wrote:
> On Mon, 2015-09-18 at 04:28 +0800, Wood Scott-B07421 wrote:
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Friday, September 18, 2015 4:28 AM
> > To: Zhao Qiang-B45475
> > Cc: linux-kernel@vger.kernel.org; linuxppc-dev@lists.ozlabs.org;
> > lauraa@codeaurora.org; Xie Xiaobo-R63061; benh@kernel.crashing.org; Li
> > Yang-Leo-R58472; paulus@samba.org
> > Subject: Re: [PATCH v9 3/5] qe_common: add qe_muram_ functions to manage
> > muram
> > 
> > On Mon, 2015-09-14 at 09:38 +0800, Zhao Qiang wrote:
> > > diff --git a/arch/powerpc/sysdev/qe_lib/qe_common.c
> > > b/arch/powerpc/sysdev/qe_lib/qe_common.c
> > > new file mode 100644
> > > index 0000000..1213458
> > > --- /dev/null
> > > +++ b/arch/powerpc/sysdev/qe_lib/qe_common.c
> > > @@ -0,0 +1,242 @@
> > > +/*
> > > + * Freescale QE common code
> > > + *
> > > + * Author: Zhao Qiang  <qiang.zhao@freescale.com>
> > > + *
> > > + * Copyright 2015 Freescale Semiconductor, Inc.
> > > + *
> > > + * This program is free software; you can redistribute it and/or
> > > +modify
> > > + * it under the terms of the GNU General Public License as published
> > > +by
> > > + * the Free Software Foundation; either version 2 of the License, or
> > > + * (at your option) any later version.
> > > + */
> > > +
> > > +#include <linux/genalloc.h>
> > > +#include <linux/list.h>
> > > +#include <linux/init.h>
> > > +#include <linux/of_device.h>
> > > +#include <linux/spinlock.h>
> > > +#include <linux/export.h>
> > > +#include <linux/of.h>
> > > +#include <linux/of_address.h>
> > > +#include <linux/slab.h>
> > > +
> > > +#include <linux/io.h>
> > > +#include <asm/qe.h>
> > > +
> > > +static struct gen_pool *muram_pool;
> > > +static struct genpool_data_align muram_pool_data; static struct
> > > +genpool_data_fixed muram_pool_data_fixed; static spinlock_t
> > > +qe_muram_lock; static u8 __iomem *muram_vbase; static phys_addr_t
> > > +muram_pbase;
> > > +
> > > +struct muram_block {
> > > +     struct list_head head;
> > > +     unsigned long start;
> > > +     int size;
> > > +};
> > > +
> > > +static LIST_HEAD(muram_block_list);
> > > +
> > > +/* max address size we deal with */
> > > +#define OF_MAX_ADDR_CELLS    4
> > > +#define GENPOOL_OFFSET               4096
> > > +
> > > +int qe_muram_init(void)
> > > +{
> > > +     struct device_node *np;
> > > +     struct resource r;
> > > +     u32 zero[OF_MAX_ADDR_CELLS] = {};
> > > +     resource_size_t max = 0;
> > > +     int i = 0;
> > > +     int ret = 0;
> > > +
> > > +     if (muram_pbase)
> > > +             return 0;
> > > +
> > > +     np = of_find_compatible_node(NULL, NULL, "fsl,qe-muram-data");
> > > +     if (!np) {
> > > +             /* try legacy bindings */
> > > +             np = of_find_node_by_name(NULL, "data-only");
> > > +             if (!np) {
> > > +                     pr_err("Cannot find CPM muram data node");
> > > +                     ret = -ENODEV;
> > > +                     goto out;
> > > +             }
> > > +     }
> > > +
> > > +     muram_pool = gen_pool_create(1, -1);
> > > +     muram_pbase = of_translate_address(np, zero);
> > > +     if (muram_pbase == (phys_addr_t)OF_BAD_ADDR) {
> > > +             pr_err("Cannot translate zero through CPM muram node");
> > > +             ret = -ENODEV;
> > > +             goto err;
> > > +     }
> > > +
> > > +     while (of_address_to_resource(np, i++, &r) == 0) {
> > > +             if (r.end > max)
> > > +                     max = r.end;
> > > +             ret = gen_pool_add(muram_pool, r.start - muram_pbase +
> > > +                                GENPOOL_OFFSET, resource_size(&r), -1);
> > > +             if (ret) {
> > > +                             pr_err("QE: couldn't add muram to
> > pool!\n");
> > > +                             goto err;
> > > +                     }
> > > +
> > > +     }
> > > +
> > > +     muram_vbase = ioremap(muram_pbase, max - muram_pbase + 1);
> > > +     if (!muram_vbase) {
> > > +             pr_err("Cannot map QE muram");
> > > +             ret = -ENOMEM;
> > > +             goto err;
> > > +     }
> > > +     goto out;
> > > +err:
> > > +     gen_pool_destroy(muram_pool);
> > > +out:
> > > +     of_node_put(np);
> > > +     return ret;
> > > +}
> > > +
> > > +/*
> > > + * qe_muram_alloc - allocate the requested size worth of multi-user
> > > +ram
> > > + * @size: number of bytes to allocate
> > > + * @align: requested alignment, in bytes
> > > + *
> > > + * This function returns an offset into the muram area.
> > > + */
> > > +unsigned long qe_muram_alloc(unsigned long size, unsigned long align)
> > > +{
> > > +     unsigned long start;
> > > +     unsigned long flags;
> > > +     struct muram_block *entry;
> > > +
> > > +     spin_lock_irqsave(&qe_muram_lock, flags);
> > > +     muram_pool_data.align = align;
> > > +     gen_pool_set_algo(muram_pool, gen_pool_first_fit_align,
> > > +                       &muram_pool_data);
> > > +     start = gen_pool_alloc(muram_pool, size);
> > > +     if (!start)
> > > +             goto out2;
> > > +     start = start - GENPOOL_OFFSET;
> > > +     memset(qe_muram_addr(start), 0, size);
> > > +     entry = kmalloc(sizeof(*entry), GFP_KERNEL);
> > > +     if (!entry)
> > > +             goto out1;
> > > +     entry->start = start;
> > > +     entry->size = size;
> > > +     list_add(&entry->head, &muram_block_list);
> > > +     spin_unlock_irqrestore(&qe_muram_lock, flags);
> > > +
> > > +     return start;
> > > +out1:
> > > +     gen_pool_free(muram_pool, start, size);
> > > +out2:
> > > +     spin_unlock_irqrestore(&qe_muram_lock, flags);
> > > +     return (unsigned long) -ENOMEM;
> > > +}
> > > +EXPORT_SYMBOL(qe_muram_alloc);
> > > +
> > > +/*
> > > + * qe_muram_alloc_fixed - reserve a specific region of multi-user ram
> > > + * @size: number of bytes to allocate
> > > + * @offset: offset of allocation start address
> > > + *
> > > + * This function returns an offset into the muram area.
> > > + */
> > > +unsigned long qe_muram_alloc_fixed(unsigned long offset, unsigned
> > > +long
> > > size)
> > > +{
> > > +
> > > +     unsigned long start;
> > > +     unsigned long flags;
> > > +     unsigned long size_alloc = size;
> > > +     struct muram_block *entry;
> > > +     int end_bit;
> > > +     int order = muram_pool -> min_alloc_order;
> > > +
> > > +     spin_lock_irqsave(&qe_muram_lock, flags);
> > > +     end_bit = (offset >> order) + ((size + (1UL << order) - 1) >>
> > order);
> > > +     if ((offset + size) > (end_bit << order))
> > > +             size_alloc = size + (1UL << order);
> > > +
> > > +     muram_pool_data_fixed.offset = offset + GENPOOL_OFFSET;
> > > +     gen_pool_set_algo(muram_pool, gen_pool_fixed_fit,
> > > +                       &muram_pool_data_fixed);
> > > +     start = gen_pool_alloc(muram_pool, size_alloc);
> > > +     if (!start)
> > > +             goto out2;
> > > +     start = start - GENPOOL_OFFSET;
> > > +     memset(qe_muram_addr(start), 0, size_alloc);
> > > +     entry = kmalloc(sizeof(*entry), GFP_KERNEL);
> > > +     if (!entry)
> > > +             goto out1;
> > > +     entry->start = start;
> > > +     entry->size = size_alloc;
> > > +     list_add(&entry->head, &muram_block_list);
> > > +     spin_unlock_irqrestore(&qe_muram_lock, flags);
> > > +
> > > +     return start;
> > > +out1:
> > > +     gen_pool_free(muram_pool, start, size_alloc);
> > > +out2:
> > > +     spin_unlock_irqrestore(&qe_muram_lock, flags);
> > > +     return (unsigned long) -ENOMEM;
> > > +
> > > +
> > > +}
> > > +EXPORT_SYMBOL(qe_muram_alloc_fixed);
> > > +
> > > +/**
> > > + * qe_muram_free - free a chunk of multi-user ram
> > > + * @offset: The beginning of the chunk as returned by qe_muram_alloc().
> > > + */
> > > +int qe_muram_free(unsigned long offset) {
> > > +     unsigned long flags;
> > > +     int size;
> > > +     struct muram_block *tmp;
> > > +
> > > +     size = 0;
> > > +     spin_lock_irqsave(&qe_muram_lock, flags);
> > > +     list_for_each_entry(tmp, &muram_block_list, head) {
> > > +             if (tmp->start == offset) {
> > > +                     size = tmp->size;
> > > +                     list_del(&tmp->head);
> > > +                     kfree(tmp);
> > > +                     break;
> > > +             }
> > > +     }
> > > +     gen_pool_free(muram_pool, offset + GENPOOL_OFFSET, size);
> > > +     spin_unlock_irqrestore(&qe_muram_lock, flags);
> > > +
> > > +     return size;
> > > +}
> > > +EXPORT_SYMBOL(qe_muram_free);
> > > +
> > > +/**
> > > + * qe_muram_addr - turn a muram offset into a virtual address
> > > + * @offset: muram offset to convert
> > > + */
> > > +void __iomem *qe_muram_addr(unsigned long offset) {
> > > +     return muram_vbase + offset;
> > > +}
> > > +EXPORT_SYMBOL(qe_muram_addr);
> > > +
> > > +unsigned long qe_muram_offset(void __iomem *addr) {
> > > +     return addr - (void __iomem *)muram_vbase; }
> > > +EXPORT_SYMBOL(qe_muram_offset);
> > > +
> > > +/**
> > > + * qe_muram_dma - turn a muram virtual address into a DMA address
> > > + * @offset: virtual address from qe_muram_addr() to convert  */
> > > +dma_addr_t qe_muram_dma(void __iomem *addr) {
> > > +     return muram_pbase + ((u8 __iomem *)addr - muram_vbase); }
> > > +EXPORT_SYMBOL(qe_muram_dma);
> > 
> > Why are you adding new functions rather than replacing the implementation
> > of the old ones?
> > 
> > Again, I don't want to see a big addition in one place and a big deletion
> > elsewhere.  I want to see the actual code changes as a diff.  Any moving
> > around of code must be a separate patch from making changes to it that
> > are significant enough that git format-patch doesn't detect it as a move.
> 
> Modify cpm_muram functions with genalloc first, Then move it to qe_muram 
> with
> churn of cpm_muram_* and qe_mura_*? Or other method?

All modifications first (both genalloc and, if you must, renaming), then 
move.  Or move, then all modifications.  I don't care which order, just don't 
make changes in the same patch as moving the code.

-Scott
