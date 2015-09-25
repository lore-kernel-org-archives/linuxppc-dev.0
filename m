Return-Path: <timur@tabi.org>
Received: from muin.pair.com (muin.pair.com [209.68.1.55])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2AE6E1A0326
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2015 11:01:09 +1000 (AEST)
Subject: Re: [PATCH v3 1/3] powerpc/512x: add LocalPlus Bus FIFO device driver
To: Alexander Popov <alex.popov@linux.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Anatolij Gustschin <agust@denx.de>, Rob Herring <robh@kernel.org>,
 Grant Likely <grant.likely@linaro.org>,
 Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>,
 Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>,
 Ian Campbell <ijc+devicetree@hellion.org.uk>,
 Kumar Gala <galak@codeaurora.org>, linuxppc-dev@lists.ozlabs.org,
 dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <1443115737-3948-1-git-send-email-alex.popov@linux.com>
 <1443115737-3948-2-git-send-email-alex.popov@linux.com>
From: Timur Tabi <timur@tabi.org>
Message-ID: <56049CD0.7080104@tabi.org>
Date: Thu, 24 Sep 2015 20:01:04 -0500
MIME-Version: 1.0
In-Reply-To: <1443115737-3948-2-git-send-email-alex.popov@linux.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Alexander Popov wrote:
> +struct mpc512x_lpbfifo_request {
> +	phys_addr_t bus_phys;	/* physical address of some device on LPB */

Is this a phys_addr_t or a dma_addr_t?  It can't be both a physical 
address and a bus address.

> +	void *ram_virt;		/* virtual address of some region in RAM */
> +	u32 size;
> +	enum lpb_dev_portsize portsize;
> +	enum mpc512x_lpbfifo_req_dir dir;
> +	void (*callback)(struct mpc512x_lpbfifo_request *);
> +};
> +
> +int mpc512x_lpbfifo_submit(struct mpc512x_lpbfifo_request *req);
> +
>   #endif /* __ASM_POWERPC_MPC5121_H__ */
> diff --git a/arch/powerpc/platforms/512x/Kconfig b/arch/powerpc/platforms/512x/Kconfig
> index 48bf38d..f09016f 100644
> --- a/arch/powerpc/platforms/512x/Kconfig
> +++ b/arch/powerpc/platforms/512x/Kconfig
> @@ -10,6 +10,12 @@ config PPC_MPC512x
>   	select USB_EHCI_BIG_ENDIAN_MMIO if USB_EHCI_HCD
>   	select USB_EHCI_BIG_ENDIAN_DESC if USB_EHCI_HCD
>
> +config MPC512x_LPBFIFO
> +	tristate "MPC512x LocalPlus Bus FIFO driver"
> +	depends on PPC_MPC512x && MPC512X_DMA
> +	help
> +	  Enable support for Freescale MPC512x LocalPlus Bus FIFO (SCLPC).
> +
>   config MPC5121_ADS
>   	bool "Freescale MPC5121E ADS"
>   	depends on PPC_MPC512x
> diff --git a/arch/powerpc/platforms/512x/Makefile b/arch/powerpc/platforms/512x/Makefile
> index 0169312..f47d422 100644
> --- a/arch/powerpc/platforms/512x/Makefile
> +++ b/arch/powerpc/platforms/512x/Makefile
> @@ -5,4 +5,5 @@ obj-$(CONFIG_COMMON_CLK)	+= clock-commonclk.o
>   obj-y				+= mpc512x_shared.o
>   obj-$(CONFIG_MPC5121_ADS)	+= mpc5121_ads.o mpc5121_ads_cpld.o
>   obj-$(CONFIG_MPC512x_GENERIC)	+= mpc512x_generic.o
> +obj-$(CONFIG_MPC512x_LPBFIFO)	+= mpc512x_lpbfifo.o
>   obj-$(CONFIG_PDM360NG)		+= pdm360ng.o
> diff --git a/arch/powerpc/platforms/512x/mpc512x_lpbfifo.c b/arch/powerpc/platforms/512x/mpc512x_lpbfifo.c
> new file mode 100644
> index 0000000..e6f2c6b
> --- /dev/null
> +++ b/arch/powerpc/platforms/512x/mpc512x_lpbfifo.c
> @@ -0,0 +1,560 @@
> +/*
> + * The driver for Freescale MPC512x LocalPlus Bus FIFO
> + * (called SCLPC in the Reference Manual).
> + *
> + * Copyright (C) 2013-2015 Alexander Popov<alex.popov@linux.com>.
> + *
> + * This file is released under the GPLv2.
> + */
> +
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +#include <asm/mpc5121.h>
> +#include <asm/io.h>
> +#include <linux/spinlock.h>
> +#include <linux/slab.h>
> +#include <linux/dmaengine.h>
> +#include <linux/dma-direction.h>
> +#include <linux/dma-mapping.h>
> +
> +#define DRV_NAME "mpc512x_lpbfifo"
> +
> +struct cs_range {
> +	u32 csnum;
> +	u32 base; /* must be zero */
> +	u32 addr;
> +	u32 size;
> +};
> +
> +static struct lpbfifo_data {
> +	spinlock_t lock; /* for protecting lpbfifo_data */
> +	phys_addr_t regs_phys;
> +	resource_size_t regs_size;
> +	struct mpc512x_lpbfifo __iomem *regs;
> +	int irq;
> +	struct cs_range *cs_ranges;
> +	size_t cs_n;
> +	struct dma_chan *chan;
> +	struct mpc512x_lpbfifo_request *req;
> +	dma_addr_t ram_bus_addr;
> +	bool wait_lpbfifo_irq;
> +	bool wait_lpbfifo_callback;
> +} lpbfifo;
> +
> +/*
> + * A data transfer from RAM to some device on LPB is finished
> + * when both mpc512x_lpbfifo_irq() and mpc512x_lpbfifo_callback()
> + * have been called. We execute the callback registered in
> + * mpc512x_lpbfifo_request just after that.
> + * But for a data transfer from some device on LPB to RAM we don't enable
> + * LPBFIFO interrupt because clearing MPC512X_SCLPC_SUCCESS interrupt flag
> + * automatically disables LPBFIFO reading request to the DMA controller
> + * and the data transfer hangs. So the callback registered in
> + * mpc512x_lpbfifo_request is executed at the end of mpc512x_lpbfifo_callback().
> + */
> +
> +/*
> + * mpc512x_lpbfifo_irq - IRQ handler for LPB FIFO
> + */
> +static irqreturn_t mpc512x_lpbfifo_irq(int irq, void *param)
> +{
> +	struct device *d = (struct device *)param;

Please use the variable name 'dev' instead of 'd', for consistency.

> +	struct mpc512x_lpbfifo_request *req = lpbfifo.req;
> +	unsigned long flags;
> +	u32 status;
> +
> +	spin_lock_irqsave(&lpbfifo.lock, flags);
> +
> +	if (!lpbfifo.regs)
> +		goto end0;
> +
> +	if (!req || req->dir == MPC512X_LPBFIFO_REQ_DIR_READ) {
> +		dev_err(d, "bogus LPBFIFO IRQ\n");
> +		goto end0;
> +	}

So this might be an obscure bug.  The code says that "req = lpbfifo.req" 
above.  However, it doesn't know that this block is in a critical 
section, so it will initialize 'req' not on the top line of the 
function, but rather right here.  That means that although you think 
that you're initializing 'req' before the spin_lock_irqsave(), the code 
might actually initialize it after the spin_lock_irqsave().

My suggestion is that you explicitly initialize 'req' after 
spin_lock_irqsave().  Or better yet, don't use 'req' and explicitly 
reference lpbfifo.req every time.

> +
> +	status = in_be32(&lpbfifo.regs->status);
> +	if (status != MPC512X_SCLPC_SUCCESS) {
> +		dev_err(d, "DMA transfer between RAM and peripheral failed\n");
> +		out_be32(&lpbfifo.regs->enable,
> +				MPC512X_SCLPC_RESET | MPC512X_SCLPC_FIFO_RESET);
> +		goto end0;
> +	}
> +	/* Clear the interrupt flag */
> +	out_be32(&lpbfifo.regs->status, MPC512X_SCLPC_SUCCESS);
> +
> +	lpbfifo.wait_lpbfifo_irq = false;
> +
> +	if (lpbfifo.wait_lpbfifo_callback)
> +		goto end0;
> +
> +	/* Transfer is finished, set the FIFO as idle */
> +	lpbfifo.req = NULL;
> +
> +	spin_unlock_irqrestore(&lpbfifo.lock, flags);
> +
> +	if (req->callback)
> +		req->callback(req);
> +
> +	return IRQ_HANDLED;
> +
> + end0:
> +	spin_unlock_irqrestore(&lpbfifo.lock, flags);
> +	return IRQ_HANDLED;
> +}
> +
> +/*
> + * mpc512x_lpbfifo_callback is called by DMA driver when
> + * DMA transaction is finished.
> + */
> +static void mpc512x_lpbfifo_callback(void *param)
> +{
> +	unsigned long flags;
> +	struct mpc512x_lpbfifo_request *req = lpbfifo.req;
> +	enum dma_data_direction dir;
> +
> +	spin_lock_irqsave(&lpbfifo.lock, flags);
> +
> +	if (!lpbfifo.regs) {
> +		spin_unlock_irqrestore(&lpbfifo.lock, flags);
> +		return;
> +	}
> +
> +	if (!req) {
> +		pr_err("bogus LPBFIFO callback\n");
> +		spin_unlock_irqrestore(&lpbfifo.lock, flags);
> +		return;
> +	}
> +
> +	/* Release the mapping */
> +	if (req->dir == MPC512X_LPBFIFO_REQ_DIR_WRITE)
> +		dir = DMA_TO_DEVICE;
> +	else
> +		dir = DMA_FROM_DEVICE;
> +	dma_unmap_single(lpbfifo.chan->device->dev,
> +			lpbfifo.ram_bus_addr, req->size, dir);

Are you sure it's okay to call dma_unmap_single() from within a spinlock?

> +
> +	lpbfifo.wait_lpbfifo_callback = false;
> +
> +	if (!lpbfifo.wait_lpbfifo_irq) {
> +		/* Transfer is finished, set the FIFO as idle */
> +		lpbfifo.req = NULL;
> +
> +		spin_unlock_irqrestore(&lpbfifo.lock, flags);
> +
> +		if (req->callback)
> +			req->callback(req);
> +	} else {
> +		spin_unlock_irqrestore(&lpbfifo.lock, flags);
> +	}
> +}
> +
> +static int mpc512x_lpbfifo_kick(void)
> +{
> +	u32 bits;
> +	int no_incr = 0;

I think this should be a 'bool'

> +	u32 bpt;
> +	u32 cs = 0;
> +	size_t i;
> +	struct dma_device *dma_dev = NULL;
> +	struct scatterlist sg;
> +	enum dma_data_direction dir;
> +	struct dma_slave_config dma_conf = {};
> +	struct dma_async_tx_descriptor *dma_tx = NULL;
> +	dma_cookie_t cookie;
> +	int e;

Please use 'ret'

> +
> +	/*
> +	 * 1. Fit the requirements:
> +	 * - the packet size must be a multiple of 4 since FIFO Data Word
> +	 *    Register allows only full-word access according the Reference
> +	 *    Manual;
> +	 * - the physical address of the device on LPB and the packet size
> +	 *    must be aligned on BPT (bytes per transaction) or 8-bytes
> +	 *    boundary according the Reference Manual;
> +	 * - but we choose DMA maxburst equal (or very close to) BPT to prevent
> +	 *    DMA controller from overtaking FIFO and causing FIFO underflow
> +	 *    error. So we force the packet size to be aligned on BPT boundary
> +	 *    not to confuse DMA driver which requires the packet size to be
> +	 *    aligned on maxburst boundary;
> +	 * - BPT should be set to the LPB device port size for operation with
> +	 *    disabled auto-incrementing according Reference Manual.
> +	 */
> +	if (lpbfifo.req->size == 0 || !IS_ALIGNED(lpbfifo.req->size, 4)) {
> +		e = -EINVAL;
> +		goto err_param;
> +	}
> +
> +	if (lpbfifo.req->portsize != LPB_DEV_PORTSIZE_UNDEFINED) {
> +		bpt = lpbfifo.req->portsize;
> +		no_incr = 1;
> +	} else {
> +		bpt = 32;
> +	}

Blank space

> +	while (true) {
> +		if (!IS_ALIGNED(lpbfifo.req->bus_phys, min(bpt, 0x8u)) ||
> +					!IS_ALIGNED(lpbfifo.req->size, bpt)) {
> +			if (no_incr) {
> +				e = -EINVAL;
> +				goto err_param;

Remove 'err_param' and just do "return -EINVAL" here.

> +			}
> +
> +			bpt >>= 1;
> +		} else {
> +			dma_conf.dst_maxburst = max(bpt, 0x4u) / 4;
> +			dma_conf.src_maxburst = max(bpt, 0x4u) / 4;
> +			break;
> +		}
> +	}

This is an odd use of a while-loop.

> +
> +	for (i = 0; i < lpbfifo.cs_n; i++) {
> +		phys_addr_t cs_start;
> +		phys_addr_t cs_end;
> +
> +		cs_start = lpbfifo.cs_ranges[i].addr;
> +		cs_end = cs_start + lpbfifo.cs_ranges[i].size - 1;
> +
> +		if (lpbfifo.req->bus_phys >= cs_start &&
> +		    lpbfifo.req->bus_phys + lpbfifo.req->size - 1 <= cs_end) {
> +			cs = lpbfifo.cs_ranges[i].csnum;
> +			break;
> +		}
> +	}
> +	if (i == lpbfifo.cs_n) {

Can you test for "!cs" here instead?

> +		e = -EFAULT;
> +		goto err_param;
> +	}
> +
> +	/* 2. Prepare DMA */
> +	dma_dev = lpbfifo.chan->device;
> +
> +	sg_init_table(&sg, 1);
> +	if (lpbfifo.req->dir == MPC512X_LPBFIFO_REQ_DIR_WRITE)
> +		dir = DMA_TO_DEVICE;
> +	else
> +		dir = DMA_FROM_DEVICE;
> +	sg_dma_address(&sg) = dma_map_single(dma_dev->dev,
> +			lpbfifo.req->ram_virt, lpbfifo.req->size, dir);
> +	if (dma_mapping_error(dma_dev->dev, sg_dma_address(&sg))) {
> +		e = -EFAULT;
> +		goto err_param;
> +	}
> +	lpbfifo.ram_bus_addr = sg_dma_address(&sg); /* For freeing later */
> +	sg_dma_len(&sg) = lpbfifo.req->size;

I don't think sg_dma_len() is meant to be used as an lvalue.

> +
> +	if (lpbfifo.req->dir == MPC512X_LPBFIFO_REQ_DIR_WRITE) {
> +		dma_conf.direction = DMA_MEM_TO_DEV;
> +		dma_conf.dst_addr = lpbfifo.regs_phys +
> +				offsetof(struct mpc512x_lpbfifo, data_word);
> +	} else {
> +		dma_conf.direction = DMA_DEV_TO_MEM;
> +		dma_conf.src_addr = lpbfifo.regs_phys +
> +				offsetof(struct mpc512x_lpbfifo, data_word);
> +	}

Why are you repeating the "lpbfifo.req->dir == 
MPC512X_LPBFIFO_REQ_DIR_WRITE)" test here?  Can't you combine it with 
the one above?

> +	dma_conf.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
> +	dma_conf.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
> +
> +	/* Make DMA channel work with LPB FIFO data register */
> +	if (dma_dev->device_config(lpbfifo.chan, &dma_conf)) {
> +		e = -EINVAL;
> +		goto err_dma_prep;
> +	}
> +
> +	dma_tx = dmaengine_prep_slave_sg(lpbfifo.chan, &sg,
> +						1, dma_conf.direction, 0);
> +	if (!dma_tx) {
> +		e = -ENOSPC;
> +		goto err_dma_prep;
> +	}
> +	dma_tx->callback = mpc512x_lpbfifo_callback;
> +	dma_tx->callback_param = NULL;
> +
> +	/* 3. Prepare FIFO */
> +	out_be32(&lpbfifo.regs->enable,
> +				MPC512X_SCLPC_RESET | MPC512X_SCLPC_FIFO_RESET);
> +	out_be32(&lpbfifo.regs->enable, 0x0);
> +
> +	/*
> +	 * Configure the watermarks for write operation (RAM->DMA->FIFO->dev):
> +	 * - high watermark 7 words according the Reference Manual,
> +	 * - low watermark 512 bytes (half of the FIFO).
> +	 * These watermarks don't work for read operation since the
> +	 * MPC512X_SCLPC_FLUSH bit is set (according the Reference Manual).
> +	 */
> +	out_be32(&lpbfifo.regs->fifo_ctrl, MPC512X_SCLPC_FIFO_CTRL(0x7));
> +	out_be32(&lpbfifo.regs->fifo_alarm, MPC512X_SCLPC_FIFO_ALARM(0x200));
> +
> +	/*
> +	 * Start address is a physical address of the region which belongs
> +	 * to the device on the LocalPlus Bus
> +	 */
> +	out_be32(&lpbfifo.regs->start_addr, lpbfifo.req->bus_phys);
> +
> +	/*
> +	 * Configure chip select, transfer direction, address increment option
> +	 * and bytes per transaction option
> +	 */
> +	bits = 0;
> +	bits |= MPC512X_SCLPC_CS(cs);

Just do "bits = MPC512X_SCLPC_CS(cs);"

> +	if (lpbfifo.req->dir == MPC512X_LPBFIFO_REQ_DIR_READ)
> +		bits |= MPC512X_SCLPC_READ | MPC512X_SCLPC_FLUSH;
> +	if (no_incr)
> +		bits |= MPC512X_SCLPC_DAI;
> +	bits |= MPC512X_SCLPC_BPT(bpt);
> +	out_be32(&lpbfifo.regs->ctrl, bits);
> +
> +	/* Unmask irqs */
> +	bits = MPC512X_SCLPC_ENABLE | MPC512X_SCLPC_ABORT_INT_ENABLE;
> +	if (lpbfifo.req->dir == MPC512X_LPBFIFO_REQ_DIR_WRITE)
> +		bits |= MPC512X_SCLPC_NORM_INT_ENABLE;
> +	else
> +		lpbfifo.wait_lpbfifo_irq = false;
> +
> +	out_be32(&lpbfifo.regs->enable, bits);
> +
> +	/* 4. Set packet size and kick FIFO off */
> +	bits = lpbfifo.req->size;
> +	bits |= MPC512X_SCLPC_START;

Similar thing here.

> +	out_be32(&lpbfifo.regs->pkt_size, bits);
> +
> +	/* 5. Finally kick DMA off */
> +	cookie = dma_tx->tx_submit(dma_tx);
> +	if (dma_submit_error(cookie)) {
> +		e = -ENOSPC;
> +		goto err_dma_submit;
> +	}
> +
> +	return 0;
> +
> + err_dma_submit:
> +	out_be32(&lpbfifo.regs->enable,
> +				MPC512X_SCLPC_RESET | MPC512X_SCLPC_FIFO_RESET);
> + err_dma_prep:
> +	dma_unmap_single(dma_dev->dev, sg_dma_address(&sg),
> +						lpbfifo.req->size, dir);
> + err_param:
> +	return e;
> +}
> +
> +int mpc512x_lpbfifo_submit(struct mpc512x_lpbfifo_request *req)
> +{
> +	unsigned long flags;
> +	int result = 0;

Please be consistent.  Use 'ret' here.

> +
> +	spin_lock_irqsave(&lpbfifo.lock, flags);
> +
> +	if (!lpbfifo.regs) {
> +		result = -ENODEV;
> +		goto end0;
> +	}
> +
> +	/* Check whether a transfer is in progress */
> +	if (lpbfifo.req) {
> +		result = -EBUSY;
> +		goto end0;
> +	}
> +
> +	lpbfifo.wait_lpbfifo_irq = true;
> +	lpbfifo.wait_lpbfifo_callback = true;
> +	lpbfifo.req = req;
> +	result = mpc512x_lpbfifo_kick();
> +	if (result != 0)
> +		lpbfifo.req = NULL; /* Set the FIFO as idle */
> +
> + end0:
> +	spin_unlock_irqrestore(&lpbfifo.lock, flags);
> +	return result;
> +}

You just wrote this
And it looks crazy
So here's my function
Call it, maybe?

static int __mpc512x_lpbfifo_submit(struct mpc512x_lpbfifo_request *req)
{
	int ret = 0;

	if (!lpbfifo.regs)
		return -ENODEV;

	/* Check whether a transfer is in progress */
	if (lpbfifo.req)
		return -EBUSY;

	lpbfifo.wait_lpbfifo_irq = true;
	lpbfifo.wait_lpbfifo_callback = true;
	lpbfifo.req = req;

	ret = mpc512x_lpbfifo_kick();
	if (ret)
		lpbfifo.req = NULL; /* Set the FIFO as idle */

	return ret;
}

int __mpc512x_lpbfifo_submit(struct mpc512x_lpbfifo_request *req)
{
	unsigned long flags;
	int ret = 0;

	spin_lock_irqsave(&lpbfifo.lock, flags);
	ret = __mpc512x_lpbfifo_submit(req);
	spin_unlock_irqrestore(&lpbfifo.lock, flags);

	return ret;
}

This approach eliminates the gotos.

> +EXPORT_SYMBOL(mpc512x_lpbfifo_submit);
> +
> +static int get_cs_ranges(void)
> +{
> +	int res = -ENODEV;
> +	struct device_node *lb_node;
> +	const u32 *addr_cells_p;
> +	const u32 *size_cells_p;
> +	int proplen;
> +	size_t i;
> +
> +	lb_node = of_find_node_by_path("/localbus@80000020");

Can you use of_find_compatible() instead?  It's more flexible.

> +	if (!lb_node)
> +		goto end0;
> +
> +	if (!of_device_is_compatible(lb_node, "fsl,mpc5121-localbus"))
> +		goto end1;
> +
> +	/*
> +	 * The node defined as compatible with 'fsl,mpc5121-localbus'
> +	 * should have 2 address cells and 1 size cell.
> +	 * One item of its ranges property should consist of:
> +	 * - the first address cell which is the chipselect number;
> +	 * - the second address cell which is the offset in the chipselect,
> +	 *    must be zero.
> +	 * - CPU address of the beginning of an access window;
> +	 * - the only size cell which is the size of an access window.
> +	 */
> +	addr_cells_p = of_get_property(lb_node, "#address-cells", NULL);
> +	size_cells_p = of_get_property(lb_node, "#size-cells", NULL);
> +	if (addr_cells_p == NULL || *addr_cells_p != 2 ||
> +				size_cells_p == NULL ||	*size_cells_p != 1) {
> +		goto end1;
> +	}

Is this really necessary?  Can't you use the built-in OF functions for 
parsing ranges?  Driver code that has to parse #address-cells or 
#size-cells is usually wrong.

> +
> +	proplen = of_property_count_u32_elems(lb_node, "ranges");
> +	if (proplen < 0 || proplen % 4 != 0)
> +		goto end1;
> +
> +	lpbfifo.cs_n = proplen / 4;
> +	lpbfifo.cs_ranges = kcalloc(lpbfifo.cs_n, sizeof(struct cs_range),
> +								GFP_KERNEL);
> +	if (!lpbfifo.cs_ranges)
> +		goto end1;
> +
> +	if (of_property_read_u32_array(lb_node, "ranges",
> +				(u32 *)lpbfifo.cs_ranges, proplen) != 0) {
> +		goto end2;
> +	}
> +
> +	for (i = 0; i < lpbfifo.cs_n; i++) {
> +		if (lpbfifo.cs_ranges[i].base != 0)
> +			goto end2;
> +	}
> +
> +	res = 0;
> + end2:
> +	if (res != 0)
> +		kfree(lpbfifo.cs_ranges);
> + end1:
> +	of_node_put(lb_node);
> + end0:
> +	return res;
> +}
> +
> +static int mpc512x_lpbfifo_probe(struct platform_device *pdev)
> +{
> +	struct resource r;
> +	int e = 0;
> +
> +	memset(&lpbfifo, 0, sizeof(struct lpbfifo_data));
> +
> +	lpbfifo.irq = irq_of_parse_and_map(pdev->dev.of_node, 0);
> +	if (lpbfifo.irq == NO_IRQ) {
> +		dev_err(&pdev->dev, "mapping irq failed\n");
> +		e = -ENODEV;
> +		goto err0;
> +	}
> +
> +	if (of_address_to_resource(pdev->dev.of_node, 0, &r) != 0) {
> +		dev_err(&pdev->dev, "bad 'reg' in 'sclpc' device tree node\n");
> +		e = -ENODEV;
> +		goto err1;
> +	}
> +	lpbfifo.regs_phys = r.start;
> +	lpbfifo.regs_size = resource_size(&r);
> +
> +	if (!request_mem_region(lpbfifo.regs_phys,
> +					lpbfifo.regs_size, DRV_NAME)) {
> +		dev_err(&pdev->dev, "unable to request region\n");
> +		e = -EBUSY;
> +		goto err1;
> +	}
> +
> +	lpbfifo.regs = ioremap(lpbfifo.regs_phys, lpbfifo.regs_size);

Why can't you use the devm functions?

> +	if (!lpbfifo.regs) {
> +		dev_err(&pdev->dev, "mapping registers failed\n");
> +		e = -ENOMEM;
> +		goto err2;
> +	}
> +
> +	out_be32(&lpbfifo.regs->enable,
> +				MPC512X_SCLPC_RESET | MPC512X_SCLPC_FIFO_RESET);
> +
> +	if (request_irq(lpbfifo.irq, mpc512x_lpbfifo_irq, 0,
> +						DRV_NAME, &pdev->dev) != 0) {
> +		dev_err(&pdev->dev, "requesting irq failed\n");
> +		e = -ENODEV;
> +		goto err3;
> +	}
> +
> +	lpbfifo.chan = dma_request_slave_channel(&pdev->dev, "rx-tx");
> +	if (lpbfifo.chan == NULL) {
> +		dev_err(&pdev->dev, "requesting DMA channel failed\n");
> +		e = -ENODEV;
> +		goto err4;
> +	}
> +
> +	if (get_cs_ranges() != 0) {
> +		dev_err(&pdev->dev, "bad '/localbus' device tree node\n");
> +		e = -ENODEV;
> +		goto err5;
> +	}
> +
> +	spin_lock_init(&lpbfifo.lock);
> +
> +	dev_info(&pdev->dev, "probe succeeded\n");
> +	return 0;
> +
> + err5:
> +	dma_release_channel(lpbfifo.chan);
> + err4:
> +	free_irq(lpbfifo.irq, &lpbfifo);
> + err3:
> +	iounmap(lpbfifo.regs);
> +	lpbfifo.regs = NULL;
> + err2:
> +	release_mem_region(lpbfifo.regs_phys, lpbfifo.regs_size);
> + err1:
> +	irq_dispose_mapping(lpbfifo.irq);
> + err0:
> +	dev_err(&pdev->dev, "probe failed\n");

This is redundant.

> +	return e;
> +}
> +
> +static int mpc512x_lpbfifo_remove(struct platform_device *pdev)
> +{
> +	unsigned long flags;
> +	struct dma_device *dma_dev = lpbfifo.chan->device;
> +	struct mpc512x_lpbfifo __iomem *regs = NULL;
> +
> +	spin_lock_irqsave(&lpbfifo.lock, flags);
> +	regs = lpbfifo.regs;
> +	lpbfifo.regs = NULL;
> +	spin_unlock_irqrestore(&lpbfifo.lock, flags);
> +
> +	dma_dev->device_terminate_all(lpbfifo.chan);
> +	out_be32(&regs->enable, MPC512X_SCLPC_RESET | MPC512X_SCLPC_FIFO_RESET);
> +	kfree(lpbfifo.cs_ranges);
> +	dma_release_channel(lpbfifo.chan);
> +	free_irq(lpbfifo.irq, &pdev->dev);
> +	iounmap(regs);
> +	release_mem_region(lpbfifo.regs_phys, lpbfifo.regs_size);
> +	irq_dispose_mapping(lpbfifo.irq);
> +
> +	return 0;
> +}
