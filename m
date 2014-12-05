Return-Path: <vinod.koul@intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by lists.ozlabs.org (Postfix) with ESMTP id 072E01A0C2A
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Dec 2014 03:27:56 +1100 (AEDT)
Date: Fri, 5 Dec 2014 21:58:23 +0530
From: Vinod Koul <vinod.koul@intel.com>
To: xuelin.shi@freescale.com
Subject: Re: [RESEND PATCH v4] dmaengine: Driver support for FSL RaidEngine
 device.
Message-ID: <20141205162823.GN3411@intel.com>
References: <1413530900-22732-1-git-send-email-xuelin.shi@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1413530900-22732-1-git-send-email-xuelin.shi@freescale.com>
Cc: dmaengine@vger.kernel.org, Harninder Rai <harninder.rai@freescale.com>,
 dan.j.williams@intel.com, linuxppc-dev@lists.ozlabs.org,
 Naveen Burmi <naveenburmi@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Oct 17, 2014 at 03:28:20PM +0800, xuelin.shi@freescale.com wrote:
> +/*
> + * drivers/dma/fsl_raid.c
> + *
> + * Freescale RAID Engine device driver
> + *
> + * Author:
> + *	Harninder Rai <harninder.rai@freescale.com>
> + *	Naveen Burmi <naveenburmi@freescale.com>
> + *
> + * Rewrite:
> + *	Xuelin Shi <xuelin.shi@freescale.com>
> + *
> + * Copyright (c) 2010-2014 Freescale Semiconductor, Inc.
> + *
> + * Redistribution and use in source and binary forms, with or without
> + * modification, are permitted provided that the following conditions are met:
> + *     * Redistributions of source code must retain the above copyright
> + *       notice, this list of conditions and the following disclaimer.
> + *     * Redistributions in binary form must reproduce the above copyright
> + *       notice, this list of conditions and the following disclaimer in the
> + *       documentation and/or other materials provided with the distribution.
> + *     * Neither the name of Freescale Semiconductor nor the
> + *       names of its contributors may be used to endorse or promote products
> + *       derived from this software without specific prior written permission.
hmmm, this doesnt sound right. BSD header in kernel code
I am not a lawyer but for kernel this doesn't sound right. Why cant this be
only GPL? Why does this deviate from norm?

> + *
> + * ALTERNATIVELY, this software may be distributed under the terms of the
> + * GNU General Public License ("GPL") as published by the Free Software
> + * Foundation, either version 2 of that License or (at your option) any
> + * later version.
> + *
> + * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND ANY
> + * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
> + * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
> + * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR ANY
> + * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
> + * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
> + * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
> + * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
> + * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
> + * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> + *
> + * Theory of operation:
> + *
> + * General capabilities:
> + *	RAID Engine (RE) block is capable of offloading XOR, memcpy and P/Q
> + *	calculations required in RAID5 and RAID6 operations. RE driver
> + *	registers with Linux's ASYNC layer as dma driver. RE hardware
> + *	maintains strict ordering of the requests through chained
> + *	command queueing.
okay I see driver is use re_xxx which is a very common term imo. I think we
need to protect the symbols by adding fsl_re_ tag. otherwise it will
conflict if someone does generic raid engine and decides to name it re_xxx

> + *
> + * Data flow:
> + *	Software RAID layer of Linux (MD layer) maintains RAID partitions,
> + *	strips, stripes etc. It sends requests to the underlying AYSNC layer
> + *	which further passes it to RE driver. ASYNC layer decides which request
> + *	goes to which job ring of RE hardware. For every request processed by
> + *	RAID Engine, driver gets an interrupt unless coalescing is set. The
> + *	per job ring interrupt handler checks the status register for errors,
> + *	clears the interrupt and leave the post interrupt processing to the irq
> + *	thread.
> + */
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/of_irq.h>
> +#include <linux/of_address.h>
> +#include <linux/of_platform.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/dmapool.h>
> +#include <linux/dmaengine.h>
> +#include <linux/io.h>
> +#include <linux/spinlock.h>
> +#include <linux/slab.h>
> +
> +#include "dmaengine.h"
> +#include "fsl_raid.h"
> +
> +#define MAX_XOR_SRCS		16
> +#define MAX_PQ_SRCS		16
> +#define MAX_INITIAL_DESCS	256
> +#define MAX_DESCS_LIMIT		(4 * MAX_INITIAL_DESCS)
> +#define FRAME_FORMAT		0x1
> +#define MAX_DATA_LENGTH		(1024*1024)
these need to be namespaced

> +
> +static enum dma_status re_jr_tx_status(struct dma_chan *chan,
> +		dma_cookie_t cookie, struct dma_tx_state *txstate)
> +{
> +	enum dma_status ret;
> +	struct re_jr *jr = container_of(chan, struct re_jr, chan);
> +
> +	ret = dma_cookie_status(chan, cookie, txstate);
> +
> +	if (ret != DMA_COMPLETE) {
> +		re_jr_cleanup_descs(jr);
why do you do cleanup here?

> +		ret = dma_cookie_status(chan, cookie, txstate);
and then call again
> +	}

this is clearly not the expectation of tx_status callback.

  * device_tx_status
     - Should report the bytes left to go over on the given channel
     - Should only care about the transaction descriptor passed as
       argument, not the currently active one on a given channel
     - The tx_state argument might be NULL
     - Should use dma_set_residue to report it
     - In the case of a cyclic transfer, it should only take into
       account the current period.
     - This function can be called in an interrupt context.


> +
> +static struct dma_async_tx_descriptor *re_jr_prep_genq(
> +		struct dma_chan *chan, dma_addr_t dest, dma_addr_t *src,
> +		unsigned int src_cnt, const unsigned char *scf, size_t len,
> +		unsigned long flags)
> +{
> +	struct re_jr *jr;
> +	struct fsl_re_dma_async_tx_desc *desc;
> +	struct xor_cdb *xor;
> +	struct cmpnd_frame *cf;
> +	u32 cdb;
> +	unsigned int i, j;
> +
> +	if (len > MAX_DATA_LENGTH) {
> +		pr_err("Length greater than %d not supported\n",
> +		       MAX_DATA_LENGTH);
> +		return NULL;
> +	}
here you are putting onus on client to know your max length magically. Also
you should consider splitting the txn to multiple of max lengths and process
them. That would make it really nice driver

> +int re_jr_probe(struct platform_device *ofdev,
> +		struct device_node *np, u8 q, u32 off)
> +{
> +	struct device *dev;
> +	struct re_drv_private *repriv;
> +	struct re_jr *jr;
> +	struct dma_device *dma_dev;
> +	u32 ptr;
> +	u32 status;
> +	int ret = 0, rc;
> +	struct platform_device *jr_ofdev;
> +
> +	dev = &ofdev->dev;
> +	repriv = dev_get_drvdata(dev);
> +	dma_dev = &repriv->dma_dev;
> +
> +	jr = devm_kzalloc(dev, sizeof(*jr), GFP_KERNEL);
> +	if (!jr) {
> +		dev_err(dev, "No free memory for allocating JR struct\n");
> +		return -ENOMEM;
> +	}
> +
> +	/* create platform device for jr node */
> +	jr_ofdev = of_platform_device_create(np, NULL, dev);
> +	if (jr_ofdev == NULL) {
> +		dev_err(dev, "Not able to create ofdev for jr %d\n", q);
> +		ret = -EINVAL;
> +		goto err_free;
> +	}
> +	dev_set_drvdata(&jr_ofdev->dev, jr);
shouldn't this be last thing you set... once everything is initialized right
> +
> +	/* read reg property from dts */
> +	rc = of_property_read_u32(np, "reg", &ptr);
> +	if (rc) {
> +		dev_err(dev, "Reg property not found in JR number %d\n", q);
> +		ret = -ENODEV;
> +		goto err_free;
> +	}
> +
> +	jr->jrregs = (struct jr_config_regs *)((u8 *)repriv->re_regs +
> +			off + ptr);
> +
> +	/* read irq property from dts */
> +	jr->irq = irq_of_parse_and_map(np, 0);
> +	if (jr->irq == NO_IRQ) {
> +		dev_err(dev, "No IRQ defined for JR %d\n", q);
> +		ret = -ENODEV;
> +		goto err_free;
> +	}
> +
> +	ret = devm_request_threaded_irq(&jr_ofdev->dev, jr->irq, re_jr_isr,
> +					re_jr_isr_thread, 0, jr->name, jr);
the dmaengine API expects that you run a tasklet. Pls convert this

> +
> +	if (ret) {
> +		dev_err(dev, "Unable to register JR interrupt for JR %d\n", q);
> +		ret = -EINVAL;
> +		goto err_free;
> +	}
> +
> +	snprintf(jr->name, sizeof(jr->name), "re_jr%02d", q);
> +
> +	repriv->re_jrs[q] = jr;
> +	jr->chan.device = dma_dev;
> +	jr->chan.private = jr;
> +	jr->dev = &jr_ofdev->dev;
> +	jr->re_dev = repriv;
> +
> +	spin_lock_init(&jr->desc_lock);
> +	INIT_LIST_HEAD(&jr->ack_q);
> +	INIT_LIST_HEAD(&jr->active_q);
> +	INIT_LIST_HEAD(&jr->submit_q);
> +	INIT_LIST_HEAD(&jr->free_q);
> +
> +	list_add_tail(&jr->chan.device_node, &dma_dev->channels);
> +	dma_dev->chancnt++;
This is filled by framework, pls remove this


> +/* Probe function for RAID Engine */
> +static int raide_probe(struct platform_device *ofdev)
> +{
> +	struct re_drv_private *repriv;
> +	struct device_node *np;
> +	struct device_node *child;
> +	u32 off;
> +	u8 ridx = 0;
> +	struct dma_device *dma_dev;
> +	struct resource *res;
> +	int rc;
> +	struct device *dev = &ofdev->dev;
> +
> +	dev_info(dev, "Freescale RAID Engine driver\n");
noise, pls remove this and other places

> +#define MAX_RE_JRS		4
> +
> +#define RE_DPAA_MODE		(1 << 30)
> +#define RE_NON_DPAA_MODE	(1 << 31)
> +#define RE_GFM_POLY		0x1d000000
> +#define RE_JR_INB_JOB_ADD(x)	((x) << 16)
> +#define RE_JR_OUB_JOB_RMVD(x)	((x) << 16)
> +#define RE_JR_CFG1_CBSI		0x08000000
> +#define RE_JR_CFG1_CBS0		0x00080000
> +#define RE_JR_OUB_SLOT_FULL_SHIFT	8
> +#define RE_JR_OUB_SLOT_FULL(x)	((x) >> RE_JR_OUB_SLOT_FULL_SHIFT)
> +#define RE_JR_INB_SLOT_AVAIL_SHIFT	8
> +#define RE_JR_INB_SLOT_AVAIL(x)	((x) >> RE_JR_INB_SLOT_AVAIL_SHIFT)
reading thru driver made me curious on what JR stands for?

> +#define RE_PQ_OPCODE		0x1B
> +#define RE_XOR_OPCODE		0x1A
> +#define RE_MOVE_OPCODE		0x8
> +#define FRAME_DESC_ALIGNMENT	16
> +#define RE_BLOCK_SIZE		0x3 /* 4096 bytes */
> +#define CACHEABLE_INPUT_OUTPUT	0x0
> +#define BUFFERABLE_OUTPUT	0x0
> +#define INTERRUPT_ON_ERROR	0x1
> +#define DATA_DEPENDENCY		0x1
> +#define ENABLE_DPI		0x0
> +#define RING_SIZE		0x400
> +#define RING_SIZE_MASK		(RING_SIZE - 1)
> +#define RING_SIZE_SHIFT		8
these are in header, pls namespace them

> +/* Data protection/integrity related fields */
> +#define DPI_APPS_MASK		0xC0000000
> +#define DPI_APPS_SHIFT		30
> +#define DPI_REF_MASK		0x30000000
> +#define DPI_REF_SHIFT		28
> +#define DPI_GUARD_MASK		0x0C000000
> +#define DPI_GUARD_SHIFT		26
> +#define DPI_ATTR_MASK		0x03000000
> +#define DPI_ATTR_SHIFT		24
> +#define DPI_META_MASK		0x0000FFFF
here too and whole of the driver

-- 
~Vinod
