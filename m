Return-Path: <labbott@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 726041A0E56
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Aug 2015 09:32:32 +1000 (AEST)
Subject: Re: [PATCH v6 3/3] qe_common: add qe_muram_ functions to manage muram
To: Zhao Qiang <qiang.zhao@freescale.com>, scottwood@freescale.com
References: <1440408703-6113-1-git-send-email-qiang.zhao@freescale.com>
 <1440408703-6113-3-git-send-email-qiang.zhao@freescale.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 lauraa@codeaurora.org, X.xie@freescale.com, benh@kernel.crashing.org,
 leoli@freescale.com, paulus@samba.org
From: Laura Abbott <labbott@redhat.com>
Message-ID: <55DBA98D.1070202@redhat.com>
Date: Mon, 24 Aug 2015 16:32:29 -0700
MIME-Version: 1.0
In-Reply-To: <1440408703-6113-3-git-send-email-qiang.zhao@freescale.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/24/2015 02:31 AM, Zhao Qiang wrote:

> diff --git a/drivers/soc/fsl/qe/qe_common.c b/drivers/soc/fsl/qe/qe_common.c
> new file mode 100644
> index 0000000..7f1762c
> --- /dev/null
> +++ b/drivers/soc/fsl/qe/qe_common.c
> @@ -0,0 +1,193 @@
> +/*
> + * common qe code
> + *
> + * author: scott wood <scottwood@freescale.com>
> + *
> + * copyright 2007-2008,2010 freescale Semiconductor, Inc.
> + *
> + * some parts derived from commproc.c/qe2_common.c, which is:
> + * copyright (c) 1997 dan error_act (dmalek@jlc.net)
> + * copyright (c) 1999-2001 dan Malek <dan@embeddedalley.com>
> + * copyright (c) 2000 montavista Software, Inc (source@mvista.com)
> + * 2006 (c) montavista software, Inc.
> + * vitaly bordug <vbordug@ru.mvista.com>
> + *
> + * this program is free software; you can redistribute it and/or modify
> + * it under the terms of version 2 of the GNU General Public License as
> + * published by the free software Foundation.
> + */
> +
> +#include <linux/genalloc.h>
> +#include <linux/list.h>
> +#include <linux/init.h>
> +#include <linux/of_device.h>
> +#include <linux/spinlock.h>
> +#include <linux/export.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/slab.h>
> +
> +#include <linux/io.h>
> +#include <soc/fsl/qe/qe.h>
> +
> +static struct gen_pool *muram_pool;
> +static struct genpool_data_align muram_pool_data;
> +static spinlock_t qe_muram_lock;
> +static u8 __iomem *muram_vbase;
> +static phys_addr_t muram_pbase;
> +
> +struct muram_block {
> +	struct list_head head;
> +	unsigned long start;
> +	int size;
> +};
> +
> +static LIST_HEAD(muram_block_list);
> +
> +/* max address size we deal with */
> +#define OF_MAX_ADDR_CELLS	4
> +
> +int qe_muram_init(void)
> +{
> +	struct device_node *np;
> +	struct resource r;
> +	u32 zero[OF_MAX_ADDR_CELLS] = {};
> +	resource_size_t max = 0;
> +	int i = 0;
> +	int ret = 0;
> +
> +	if (muram_pbase)
> +		return 0;
> +
> +	muram_pool = gen_pool_create(1, -1);
> +	gen_pool_set_algo(muram_pool, gen_pool_first_fit_align,
> +			  &muram_pool_data);
> +
> +	np = of_find_compatible_node(NULL, NULL, "fsl,qe-muram-data");
> +	if (!np) {
> +		/* try legacy bindings */
> +		np = of_find_node_by_name(NULL, "data-only");
> +		if (!np) {
> +			pr_err("Cannot find CPM muram data node");
> +			ret = -ENODEV;
> +			goto out;
> +		}
> +	}
> +
> +	muram_pbase = of_translate_address(np, zero);
> +	if (muram_pbase == (phys_addr_t)OF_BAD_ADDR) {
> +		pr_err("Cannot translate zero through CPM muram node");
> +		ret = -ENODEV;
> +		goto out;
> +	}
> +
> +	while (of_address_to_resource(np, i++, &r) == 0) {
> +		if (r.end > max)
> +			max = r.end;
> +		ret = gen_pool_add(muram_pool, r.start - muram_pbase,
> +				   resource_size(&r), -1);
> +		if (ret) {
> +				pr_err("QE MURAM: could not add muram ");
> +				pr_err("remainder to pool!\n");

Don't split the error string over two lines

> +				return ret;

returning here misses the error path

> +			}
> +
> +	}
> +
> +	muram_vbase = ioremap(muram_pbase, max - muram_pbase + 1);
> +	if (!muram_vbase) {
> +		pr_err("Cannot map CPM muram");
> +		ret = -ENOMEM;
> +	}
> +

gen_pool_destroy on the error path

> +out:
> +	of_node_put(np);
> +	return ret;
> +}
> +
> +/**
> + * qe_muram_alloc - allocate the requested size worth of multi-user ram
> + * @size: number of bytes to allocate
> + * @align: requested alignment, in bytes
> + *
> + * This function returns an offset into the muram area.
> + * Use qe_dpram_addr() to get the virtual address of the area.
> + * Use qe_muram_free() to free the allocation.
> + */
> +unsigned long qe_muram_alloc(unsigned long size, unsigned long align)
> +{
> +	unsigned long start;
> +	unsigned long flags;
> +	struct muram_block *entry;
> +
> +	spin_lock_irqsave(&qe_muram_lock, flags);
> +	muram_pool_data.align = align;
> +	start = gen_pool_alloc(muram_pool, size);

The advantage of creating gen_pool_alloc_data was so that you could
pass in the align automatically without having to modify the structure.
Is there a reason you aren't using that?

> +	memset(qe_muram_addr(start), 0, size);

There doesn't seem to be a check for allocation failure from the
gen_alloc.

> +	entry = kmalloc(sizeof(*entry), GFP_KERNEL);
> +	if (!entry)
> +		goto out;
> +	entry->start = start;
> +	entry->size = size;
> +	list_add(&entry->head, &muram_block_list);

What's the point of keeping the block list anyway? It's used only in
this file and it only seems to duplicate what gen_alloc is doing internally.
Is there some lookup functionality you still need? Could you use a gen_alloc
API to do so?

> +	spin_unlock_irqrestore(&qe_muram_lock, flags);
> +
> +	return start;
> +out:
> +	gen_pool_free(muram_pool, start, size);
> +	return (unsigned long) -ENOMEM;
> +}
> +EXPORT_SYMBOL(qe_muram_alloc);
> +
> +/**
> + * qe_muram_free - free a chunk of multi-user ram
> + * @offset: The beginning of the chunk as returned by qe_muram_alloc().
> + */
> +int qe_muram_free(unsigned long offset)
> +{
> +	unsigned long flags;
> +	int size;
> +	struct muram_block *tmp;
> +
> +	size = 0;
> +	spin_lock_irqsave(&qe_muram_lock, flags);
> +	list_for_each_entry(tmp, &muram_block_list, head) {
> +		if (tmp->start == offset) {
> +			size = tmp->size;
> +			list_del(&tmp->head);
> +			kfree(tmp);
> +			break;
> +		}
> +	}
> +	gen_pool_free(muram_pool, offset, size);
> +	spin_unlock_irqrestore(&qe_muram_lock, flags);
> +
> +	return size;
> +}
> +EXPORT_SYMBOL(qe_muram_free);
> +
> +/**
> + * qe_muram_addr - turn a muram offset into a virtual address
> + * @offset: muram offset to convert
> + */
> +void __iomem *qe_muram_addr(unsigned long offset)
> +{
> +	return muram_vbase + offset;
> +}
> +EXPORT_SYMBOL(qe_muram_addr);
> +
> +unsigned long qe_muram_offset(void __iomem *addr)
> +{
> +	return addr - (void __iomem *)muram_vbase;
> +}
> +EXPORT_SYMBOL(qe_muram_offset);
> +
> +/**
> + * qe_muram_dma - turn a muram virtual address into a DMA address
> + * @offset: virtual address from qe_muram_addr() to convert
> + */
> +dma_addr_t qe_muram_dma(void __iomem *addr)
> +{
> +	return muram_pbase + ((u8 __iomem *)addr - muram_vbase);
> +}
> +EXPORT_SYMBOL(qe_muram_dma);

Thanks,
Laura
