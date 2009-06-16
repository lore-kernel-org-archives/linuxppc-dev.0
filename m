Return-Path: <iws@ovro.caltech.edu>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id DC24DB71B6
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 17 Jun 2009 06:13:01 +1000 (EST)
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id 459F7DDD1B
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Jun 2009 06:13:00 +1000 (EST)
Date: Tue, 16 Jun 2009 13:12:56 -0700
From: Ira Snyder <iws@ovro.caltech.edu>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [RFC PATCH] fsldma: Add DMA_SLAVE support
Message-ID: <20090616201256.GG15955@ovro.caltech.edu>
References: <20090515225659.GD858@ovro.caltech.edu>
	<4A37EC14.5010005@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4A37EC14.5010005@intel.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Li Yang <leoli@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 16, 2009 at 12:01:40PM -0700, Dan Williams wrote:
> Hi Ira,
>
> Ira Snyder wrote:
>> Use the DMA_SLAVE capability of the DMAEngine API to copy/from a
>> scatterlist into an arbitrary list of hardware address/length pairs.
>>
>> This allows a single DMA transaction to copy data from several different
>> devices into a scatterlist at the same time.
>>
>> This also adds support to enable some controller-specific features such as
>> external start and external pause of a DMA transaction.
>>
>> Signed-off-by: Ira W. Snyder <iws@ovro.caltech.edu>
>> ---
>>
>> This is a request for comments on this patch. I hunch it is not quite
>> ready for inclusion, though it is certainly ready for review. Correct
>> functioning of this patch depends on the patches submitted earlier.
>>
>> As suggested by Dan Williams, I implemented DMA_SLAVE support for the
>> fsldma controller to allow me to use the hardware to transfer to/from a
>> scatterlist to a list of hardware address/length pairs.
>>
>> I implemented support for the extra features available in the DMA
>> controller, such as external pause and external start. I have not tested
>> the features yet. I am willing to drop the support if everything else
>> looks good.
>>
>> I have implemented helper functions for creating the list of hardware
>> address/length pairs as static inline functions in the linux/fsldma.h
>> header. Should I incorporate these into the driver itself and use
>> EXPORT_SYMBOL()? I've never done this before :)
>
> Using EXPORT_SYMBOL would defeat the purpose of conforming to the  
> dmaengine api which should allow other subsystems to generically  
> discover an fsldma resource.
>

Any driver would still use dma_request_channel(), etc. to get access to
a DMA channel. AFAICT, DMA_SLAVE is intended for doing something
completely hardware-specific with the DMA controller.

>> diff --git a/include/linux/fsldma.h b/include/linux/fsldma.h
>> new file mode 100644
>> index 0000000..a42dcdd
>> --- /dev/null
>> +++ b/include/linux/fsldma.h
>> @@ -0,0 +1,105 @@
>> +/*
>> + * Freescale MPC83XX / MPC85XX DMA Controller
>> + *
>> + * Copyright (c) 2009 Ira W. Snyder <iws@ovro.caltech.edu>
>> + *
>> + * This file is licensed under the terms of the GNU General Public License
>> + * version 2. This program is licensed "as is" without any warranty of any
>> + * kind, whether express or implied.
>> + */
>> +
>> +#ifndef __LINUX_FSLDMA_H__
>> +#define __LINUX_FSLDMA_H__
>> +
>> +#include <linux/dmaengine.h>
>> +
>> +/*
>> + * physical hardware address / length pair for use with the
>> + * DMAEngine DMA_SLAVE API
>> + */
>> +struct fsl_dma_hw_addr {
>> +       struct list_head entry;
>> +
>> +       dma_addr_t address;
>> +       size_t length;
>> +};
>
> Can you explain a bit more why you need the new dma address list, would  
> a struct scatterlist suffice?
>

I don't believe so. A scatterlist only holds page/length pairs. How
would you pass an arbitrary dma_addr_t/length pair in a scatterlist. I
/could/ abuse sg_dma_address() and do something like the following, but
I think you'd be even less inclined to take the patch:

struct scatterlist sg[10];

sg_dma_address(sg) = addr1;
sg_dma_len(sg) = len1;
sg++;
sg_dma_address(sg) = addr2;
sg_dma_len(sg) = len2;

/* and so on */

This would mean that there is a scatterlist with the struct page
pointers set to NULL, which has not had dma_map_sg() run on it. Seems
like abuse to me.

What I've implemented is this: (sorry about the poor drawing)

scatterlist           fsl_dma_hw_addr
+--------+            +-------+
|  DATA  | -------->  | DEST1 |
|  DATA  | ----+      +-------+
|  DATA  |     |
|  DATA  |     |      +-------+
|  DATA  |     +--->  | DEST2 |
|  DATA  |            +-------+
+--------+
                          .
                          .
                          .

Of course, the reverse works as well. You can copy from a list of
hardware address/length pairs to a scatterlist.

So, using my implementation of the DMA_SLAVE feature, you can take a big
chunk of data (which is organized into a scatterlist) and DMA it
directly to a set of hardware addresses, all in a single, unbroken
transaction.

I've got an FPGA programmer which needs a ~12MB image dumped to a FIFO
at 0xf0003000 in 4K chunks (all writes must be in the 0xf0003000 to
0xf0004000 range). The programmer is actually in control of the DMA
controller at that time. Internally, the FPGA programmer does some
toggling of pins, etc. which is needed to actually push the image into
the FPGA's themselves.

> In general it is difficult to merge new functionality without an in-tree  
> user.  Can you share the client of this new api?
>

I've inlined the driver for the FPGA programmer below. I don't think it
is appropriate to push into mainline, since it will only work for our
board, and nothing else.

It is pretty simple, but I'm totally open to suggestions for changes. I
used a char device to fill in a scatterlist, then set up the DMA to
0xf0003000 in 4K chunks.

I've got another driver that uses the interface, but this one is a bit
simpler. I can post the other one if you'd like, as well.

> I suspect you can get away without needing these new helper routines.  
> Have a look at how Haavard implemented his DMA_SLAVE client in  
> drivers/mmc/host/atmel-mci.c.
>
> Haavard ended up needing to add some public structure definitions to  
> include/linux, but my preference is to keep this in an  
> architecture/platform specific header file location if possible.
>

I was studying his code when I implemented this routine. He defined
struct dw_dma_slave in include/linux/dw_dmac.h. This is how he passes
information to device_prep_slave_sg() in the mmc driver.

It appears that his controller just uses a single register for
device-to-peripheral transfers. I implemented something different:
scatter/gather IO to/from a list of address/length pairs.

He also used platform data to get the register addresses. I'm unaware of
a way to put arbitrary platform data into the OF tree used on PowerPC.

I didn't want to force other users to implement the allocation routines
for the struct fsl_dma_hw_addr themselves, so I provided routines to do
so.

Thanks for the questions/comments. I feel like I've left something
unanswered, but I can't figure out what it is. Any more questions?
Ira


Some quick notes on the driver below:
carma_device_create()/carma_device_destroy() are just wrappers around
device_create()/device_destroy() which share a struct class, so that all
of the related drivers for FPGA's can go into /sys/class/carma/.

/*
 * CARMA Board Data FPGA Programmer
 *
 * Copyright (c) 2009 Ira W. Snyder <iws@ovro.caltech.edu>
 *
 * This file is licensed under the terms of the GNU General Public License
 * version 2. This program is licensed "as is" without any warranty of any
 * kind, whether express or implied.
 */

#include <linux/cdev.h>
#include <linux/completion.h>
#include <linux/delay.h>
#include <linux/dma-mapping.h>
#include <linux/highmem.h>
#include <linux/init.h>
#include <linux/interrupt.h>
#include <linux/io.h>
#include <linux/kernel.h>
#include <linux/leds.h>
#include <linux/module.h>
#include <linux/mutex.h>
#include <linux/of_platform.h>
#include <linux/dmaengine.h>

/* Freescale DMA Controller DMA_SLAVE interface */
#include <linux/fsldma.h>

/* MPC8349EMDS specific get_immrbase() */
#include <sysdev/fsl_soc.h>

/* CARMA device class */
#include "carma.h"

static const char driver_name[] = "fpga-program";

/*
 * Maximum firmware size
 *
 * 12849552 bytes for a CARMA Digitizer Board
 * XXXXXXXX bytes for a CARMA Correlator Board
 */
#define FW_SIZE_MAX (16 << 20)

struct fpga_fw_elem {
	struct page *page;
	unsigned int len;
	struct list_head entry;
};

struct fpga_dev {

	/* Character Device */
	struct cdev cdev;
	dev_t devno;

	/* Device Registers */
	struct device *dev;
	void __iomem *regs;
	void __iomem *immr;

	/* Freescale DMA Device */
	struct device *dmadev;
	struct dma_chan *chan;

	/* Interrupts */
	int irq, status;
	struct completion completion;

	/* FPGA Bitfile */
	struct mutex lock;
	struct list_head list;
	size_t bytes;
};

#define to_fpga_dev(X) container_of(X, struct fpga_dev, cdev)

/*----------------------------------------------------------------------------*/
/* FPGA Bitfile Element Allocation Helpers                                    */
/*----------------------------------------------------------------------------*/

static struct fpga_fw_elem *fpga_fw_elem_alloc(gfp_t gfp)
{
	struct fpga_fw_elem *elem;

	elem = kzalloc(sizeof(*elem), gfp);
	if (!elem)
		return NULL;

	elem->page = alloc_page(gfp);
	if (!elem->page) {
		kfree(elem);
		return NULL;
	}

	INIT_LIST_HEAD(&elem->entry);
	return elem;
}

static void fpga_fw_elem_free(struct fpga_fw_elem *elem)
{
	if (elem) {
		__free_page(elem->page);
		kfree(elem);
	}
}

/*----------------------------------------------------------------------------*/
/* FPGA Bitfile Helpers                                                       */
/*----------------------------------------------------------------------------*/

/*
 * Drop the firmware bitfile image from memory
 *
 * LOCKING: you must hold the priv->lock mutex
 *
 * @param priv the driver's private data structure
 */
static void fpga_drop_firmware_data(struct fpga_dev *priv)
{
	struct fpga_fw_elem *elem, *tmp;

	priv->bytes = 0;
	list_for_each_entry_safe(elem, tmp, &priv->list, entry) {
		list_del(&elem->entry);
		fpga_fw_elem_free(elem);
	}
}

static unsigned int list_num_entries(struct list_head *list)
{
	struct list_head *tmp;
	unsigned int num = 0;

	list_for_each(tmp, list)
		num++;

	return num;
}

/*----------------------------------------------------------------------------*/
/* LED Trigger (could be a seperate module)                                   */
/*----------------------------------------------------------------------------*/

/*
 * NOTE: this whole thing does have the problem that whenever the led's are
 * NOTE: first set to use the fpga trigger, they could be in the wrong state
 */

DEFINE_LED_TRIGGER(ledtrig_fpga);

static void ledtrig_fpga_programmed(bool enabled)
{
	if (enabled)
		led_trigger_event(ledtrig_fpga, LED_FULL);
	else
		led_trigger_event(ledtrig_fpga, LED_OFF);
}

/*----------------------------------------------------------------------------*/
/* FPGA Register Helpers                                                      */
/*----------------------------------------------------------------------------*/

/* Register Definitions */
#define FPGA_CONFIG_CONTROL		0x40
#define FPGA_CONFIG_STATUS		0x44
#define FPGA_CONFIG_FIFO_SIZE		0x48
#define FPGA_CONFIG_FIFO_USED		0x4C
#define FPGA_CONFIG_TOTAL_BYTE_COUNT	0x50
#define FPGA_CONFIG_CUR_BYTE_COUNT	0x54

#define FPGA_FIFO_ADDRESS		0x3000

static int fpga_fifo_size(void __iomem *regs)
{
	return ioread32be(regs + FPGA_CONFIG_FIFO_SIZE);
}

static int fpga_config_error(void __iomem *regs)
{
	return ioread32be(regs + FPGA_CONFIG_STATUS) & 0xFFFE;
}

static int fpga_fifo_empty(void __iomem *regs)
{
	return ioread32be(regs + FPGA_CONFIG_FIFO_USED) == 0;
}

static void fpga_fifo_write(void __iomem *regs, u32 val)
{
	iowrite32be(val, regs + FPGA_FIFO_ADDRESS);
}

static void fpga_set_byte_count(void __iomem *regs, u32 count)
{
	iowrite32be(count, regs + FPGA_CONFIG_TOTAL_BYTE_COUNT);
}

static void fpga_programmer_enable(struct fpga_dev *priv, bool dma)
{
	if (dma)
		iowrite32be(0x5, priv->regs + FPGA_CONFIG_CONTROL);
	else
		iowrite32be(0x1, priv->regs + FPGA_CONFIG_CONTROL);
}

static void fpga_programmer_disable(struct fpga_dev *priv)
{
	iowrite32be(0x0, priv->regs + FPGA_CONFIG_CONTROL);
}

#ifdef DEBUG
static void fpga_dump_registers(struct fpga_dev *priv)
{
	/* Dump all status registers */
	dev_info(priv->dev, "Configuration failed, dumping status registers\n");
	dev_info(priv->dev, "Control:    0x%.8x\n", ioread32be(priv->regs + FPGA_CONFIG_CONTROL));
	dev_info(priv->dev, "Status:     0x%.8x\n", ioread32be(priv->regs + FPGA_CONFIG_STATUS));
	dev_info(priv->dev, "FIFO Size:  0x%.8x\n", ioread32be(priv->regs + FPGA_CONFIG_FIFO_SIZE));
	dev_info(priv->dev, "FIFO Used:  0x%.8x\n", ioread32be(priv->regs + FPGA_CONFIG_FIFO_USED));
	dev_info(priv->dev, "FIFO Total: 0x%.8x\n", ioread32be(priv->regs + FPGA_CONFIG_TOTAL_BYTE_COUNT));
	dev_info(priv->dev, "FIFO Curr:  0x%.8x\n", ioread32be(priv->regs + FPGA_CONFIG_CUR_BYTE_COUNT));
}
#else
static void fpga_dump_registers(struct fpga_dev *priv)
{
}
#endif

/*----------------------------------------------------------------------------*/
/* FPGA Power Supply Code                                                     */
/*----------------------------------------------------------------------------*/

/*
 * Determine if the FPGA power is good for all supplies
 */
static bool fpga_power_good(struct fpga_dev *priv)
{
	const int addr[] = { 0x2006, 0x2008, 0x200A, 0x200D, };
	int i;

	for (i = 0; i < ARRAY_SIZE(addr); i++) {
		u8 val = ioread8(priv->regs + addr[i]);
		dev_dbg(priv->dev, "FPGA pgood 0x%.4x -> 0x%.2x\n", addr[i], val);

		if (!(val & 0x1))
			return false;
	}

	return true;
}

/*
 * Disable the FPGA power supplies
 */
static void fpga_disable_power_supplies(struct fpga_dev *priv)
{
	iowrite8(0x00, priv->regs + 0x2007); /* raw supply */
	iowrite8(0x00, priv->regs + 0x2009); /* 1.2v supply */
	iowrite8(0x00, priv->regs + 0x200B); /* 2.5v supply */
	iowrite8(0x00, priv->regs + 0x200E); /* 3.3v supply */
}

/*
 * Enable the FPGA power supplies
 *
 * @return 0 if the power went good, -ERRNO otherwise
 */
static int fpga_enable_power_supplies(struct fpga_dev *priv)
{
	unsigned long timeout;

	iowrite8(0x01, priv->regs + 0x2007); /* raw supply */
	iowrite8(0x7A, priv->regs + 0x2009); /* 1.2v supply */
	iowrite8(0x03, priv->regs + 0x200B); /* 2.5v supply */
	iowrite8(0x01, priv->regs + 0x200E); /* 3.3v supply */

	/* We'll give 1 second for the power supplies to enable */
	timeout = jiffies + HZ;

	while (!time_after(jiffies, timeout)) {
		if (fpga_power_good(priv))
			return 0;

		msleep(10);
	}

	/* Timed out, so disable the power supplies */
	fpga_disable_power_supplies(priv);

	return -ETIMEDOUT;
}

/*
 * Determine if the FPGA power supplies are all enabled
 */
static bool fpga_power_enabled(struct fpga_dev *priv)
{
	const int addr[] = { 0x2007, 0x2009, 0x200B, 0x200E, };
	const int vals[] = { 0x01, 0x7A, 0x03, 0x01, };
	int i;

	BUILD_BUG_ON(ARRAY_SIZE(addr) != ARRAY_SIZE(vals));

	/* Check each enable against the expected values */
	for (i = 0; i < ARRAY_SIZE(addr); i++) {
		if (ioread8(priv->regs + addr[i]) != vals[i])
			return false;
	}

	return true;
}

/*
 * Determine if the FPGA's are programmed and running correctly
 */
static bool fpga_running(struct fpga_dev *priv)
{
	if (!fpga_power_good(priv))
		return false;

	/* Check the config done bit */
	return ioread32be(priv->regs + FPGA_CONFIG_STATUS) & (1 << 18);
}

/*----------------------------------------------------------------------------*/
/* FPGA Programming Code                                                      */
/*----------------------------------------------------------------------------*/

/*
 * Program some data to the FPGA fifo
 *
 * @priv the private data
 * @buf the data to program
 * @count the length of data to program (must be a multiple of 4 bytes)
 *
 * @return 0 on success, -ERRNO otherwise
 */
static int fpga_program_block(struct fpga_dev *priv, void *buf, size_t count)
{
	u32 *data = buf;
	int size = fpga_fifo_size(priv->regs);
	int i, len;
	unsigned long timeout;

	/* FIXME: BUG_ON instead */
	WARN_ON_ONCE(count % 4 != 0);

	while (count > 0) {

		/* Get the size of the block to write (maximum is FIFO_SIZE) */
		len = min_t(size_t, count, size);
		timeout = jiffies + HZ / 4;

		/* Write the block */
		for (i = 0; i < len / 4; i++)
			fpga_fifo_write(priv->regs, data[i]);

		/* Update the amounts left */
		count -= len;
		data += len / 4;

		/* Wait for the fifo to empty */
		while (true) {

			if (fpga_fifo_empty(priv->regs)) {
				break;
			} else {
				dev_dbg(priv->dev, "Fifo not empty\n");
				cpu_relax();
			}

			if (fpga_config_error(priv->regs)) {
				dev_err(priv->dev, "Error detected\n");
				return -EIO;
			}

			if (time_after(jiffies, timeout)) {
				dev_err(priv->dev, "Fifo timed out\n");
				return -ETIMEDOUT;
			}

			msleep(10);
		}
	}

	return 0;
}

/*
 * Program the FPGA's using the CPU
 *
 * @param priv the driver's private data structure
 * @return 0 on success, -ERRNO otherwise
 */
static noinline int fpga_program_cpu(struct fpga_dev *priv)
{
	struct fpga_fw_elem *elem;
	void *data;
	int ret;

	/* Disable the programmer */
	fpga_programmer_disable(priv);

	/* Set the total byte count */
	fpga_set_byte_count(priv->regs, priv->bytes);
	dev_dbg(priv->dev, "total byte count %u bytes\n", priv->bytes);

	/* Enable the controller for programming */
	fpga_programmer_enable(priv, false);
	dev_dbg(priv->dev, "enabled the controller\n");

	/* Write each chunk of the FPGA bitfile to FPGA programmer */
	list_for_each_entry(elem, &priv->list, entry) {
		data = kmap(elem->page);
		ret = fpga_program_block(priv, data, elem->len);
		kunmap(elem->page);

		if (ret)
			goto out_disable_controller;
	}

	/* Wait for the interrupt handler to notify us that programming finished */
	ret = wait_for_completion_timeout(&priv->completion, 2 * HZ);
	if (!ret) {
		dev_err(priv->dev, "Timed out waiting for completion\n");
		ret = -ETIMEDOUT;
		goto out_disable_controller;
	}

	/* Retrieve the status from the interrupt handler */
	ret = priv->status;

out_disable_controller:
	fpga_programmer_disable(priv);
	return ret;
}

/*
 * Program the FPGA's using the DMA controller
 *
 * @param priv the driver's private data structure
 * @return 0 on success, -ERRNO otherwise
 */
static noinline int fpga_program_dma(struct fpga_dev *priv)
{
	struct dma_chan *chan = priv->chan;
	struct dma_async_tx_descriptor *tx;
	struct fsl_dma_slave *slave;
	struct sg_table table;
	dma_cookie_t cookie;
	unsigned int nents, npages;
	size_t len, avail = 0;
	int ret;
	struct scatterlist *sg;
	struct fpga_fw_elem *elem;

	/* Disable the programmer */
	fpga_programmer_disable(priv);
	chan->device->device_terminate_all(chan);

	/* Allocate the DMA_SLAVE structure */
	slave = fsl_dma_slave_alloc(GFP_KERNEL);
	if (!slave) {
		dev_err(priv->dev, "Unable to allocate DMA_SLAVE structure\n");
		ret = -ENOMEM;
		goto out_return;
	}

	/* Set the DMA controller in external start mode */
	slave->external_start = true;

	/* Allocate the SG table */
	npages = list_num_entries(&priv->list);
	ret = sg_alloc_table(&table, npages, GFP_KERNEL);
	if (ret) {
		dev_err(priv->dev, "Unable to allocate SG table\n");
		goto out_free_slave;
	}

	/* Fill the SG table */
	sg = table.sgl;
	list_for_each_entry(elem, &priv->list, entry) {
		sg_set_page(sg, elem->page, elem->len, 0);
		sg = sg_next(sg);
	}

	/* Map the SG table for DMA */
	nents = dma_map_sg(priv->dmadev, table.sgl, npages, DMA_TO_DEVICE);
	if (nents <= 0) {
		dev_err(priv->dev, "Unable to DMA map SG table\n");
		ret = -ENOMEM;
		goto out_free_table;
	}

	/* Append the addresses to the DMA_SLAVE structure */
	avail = priv->bytes;
	while (avail > 0) {
		len = min_t(size_t, avail, PAGE_SIZE);
		ret = fsl_dma_slave_append(slave, 0xf0003000, len);
		if (ret) {
			dev_err(priv->dev, "Unable to append FIFO address\n");
			goto out_unmap_table;
		}

		avail -= len;
	}

	/* Submit the DMA slave */
	chan->private = slave;
	tx = chan->device->device_prep_slave_sg(chan, table.sgl, nents,
						DMA_TO_DEVICE, 0);
	if (!tx) {
		dev_err(priv->dev, "Unable to prep DMA_SLAVE transaction\n");
		ret = -ENOMEM;
		goto out_unmap_table;
	}

	/*
	 * Submit the transaction to the DMA controller
	 *
	 * We would leak memory if the submission failed, but that doesn't
	 * happen in the fsldma driver, so it isn't an issue
	 */
	cookie = tx->tx_submit(tx);
	if (dma_submit_error(cookie)) {
		dev_err(priv->dev, "Unable to submit DMA_SLAVE transaction\n");
		ret = -ENOMEM;
		goto out_unmap_table;
	}

	dma_async_memcpy_issue_pending(chan);

	/* Set the total byte count */
	fpga_set_byte_count(priv->regs, priv->bytes);
	dev_dbg(priv->dev, "total byte count %u bytes\n", priv->bytes);

	/* Enable the controller for DMA programming */
	fpga_programmer_enable(priv, true);
	dev_dbg(priv->dev, "enabled the controller\n");

	/* Wait for the interrupt handler to notify us that programming finished */
	ret = wait_for_completion_timeout(&priv->completion, 2 * HZ);
	if (!ret) {
		dev_err(priv->dev, "Timed out waiting for completion\n");
		ret = -ETIMEDOUT;
		goto out_disable_controller;
	}

	/* Retrieve the status from the interrupt handler */
	ret = priv->status;

out_disable_controller:
	fpga_programmer_disable(priv);
	chan->device->device_terminate_all(chan);
out_unmap_table:
	dma_unmap_sg(priv->dmadev, table.sgl, npages, DMA_TO_DEVICE);
out_free_table:
	sg_free_table(&table);
out_free_slave:
	fsl_dma_slave_free(slave);
out_return:
	return ret;
}

/*----------------------------------------------------------------------------*/
/* Interrupt Handling                                                         */
/*----------------------------------------------------------------------------*/

static irqreturn_t fpga_interrupt(int irq, void *dev_id)
{
	struct fpga_dev *priv = dev_id;

	/* Save the status */
	priv->status = fpga_config_error(priv->regs) ? -EIO : 0;
	dev_dbg(priv->dev, "INTERRUPT status %d\n", priv->status);
	fpga_dump_registers(priv);

	/* Disabling the programmer clears the interrupt */
	fpga_programmer_disable(priv);

	/* Notify any waiters */
	complete(&priv->completion);

	return IRQ_HANDLED;
}

/*----------------------------------------------------------------------------*/
/* SYSFS Helpers                                                              */
/*----------------------------------------------------------------------------*/

static int fpga_do_stop(struct fpga_dev *priv)
{
	/* TODO: anything else here ? */

	/* Set the led to unprogrammed */
	ledtrig_fpga_programmed(false);

	return 0;
}

static noinline int fpga_do_program(struct fpga_dev *priv)
{
	int ret;

	if (list_empty(&priv->list)) {
		dev_err(priv->dev, "No data to program\n");
		return -EINVAL;
	}

	if (!fpga_power_enabled(priv)) {
		dev_err(priv->dev, "Power not enabled\n");
		return -EINVAL;
	}

	if (!fpga_power_good(priv)) {
		dev_err(priv->dev, "Power not good\n");
		return -EINVAL;
	}

	/* Try to program the FPGA's using DMA */
	ret = fpga_program_dma(priv);

	/* If DMA failed or doesn't exist, try with CPU */
	if (ret) {
		dev_warn(priv->dev, "Falling back to CPU programming\n");
		ret = fpga_program_cpu(priv);
	}

	if (ret) {
		dev_err(priv->dev, "Unable to program FPGA's\n");
		return ret;
	}

	/* Drop the firmware bitfile from memory */
	fpga_drop_firmware_data(priv);

	dev_dbg(priv->dev, "FPGA programming successful\n");
	ledtrig_fpga_programmed(true);

	return 0;
}

/*----------------------------------------------------------------------------*/
/* File Operations                                                            */
/*----------------------------------------------------------------------------*/

static int fpga_open(struct inode *inode, struct file *filp)
{
	struct fpga_dev *priv = to_fpga_dev(inode->i_cdev);

	/* We only allow one process at a time */
	if (mutex_lock_interruptible(&priv->lock))
		return -ERESTARTSYS;

	filp->private_data = priv;

	/* Free any data left over from a previous open (if any) */
	fpga_drop_firmware_data(priv);

	return nonseekable_open(inode, filp);
}

static int fpga_release(struct inode *inode, struct file *filp)
{
	struct fpga_dev *priv = filp->private_data;

	mutex_unlock(&priv->lock);
	return 0;
}

static ssize_t fpga_write(struct file *filp, const char __user *buf,
			  size_t count, loff_t *f_pos)
{
	struct fpga_dev *priv = filp->private_data;
	struct fpga_fw_elem *elem, *tmp;
	size_t used, len, copy;
	struct list_head list;
	void *mem;
	int ret;

	/* Disallow firmware images larger than 16MB */
	if (priv->bytes >= FW_SIZE_MAX)
		return -ENOSPC;

	count = min_t(size_t, FW_SIZE_MAX - priv->bytes, count);

	INIT_LIST_HEAD(&list);
	len = count;
	used = 0;

	while (len > 0) {

		/* Allocate a list element */
		elem = fpga_fw_elem_alloc(GFP_KERNEL);
		if (!elem) {
			count = used;
			goto out_success;
		}

		/* Copy the data from userspace */
		copy = min_t(size_t, PAGE_SIZE, len);
		mem = kmap(elem->page);
		ret = copy_from_user(mem, buf + used, copy);
		kunmap(elem->page);

		if (ret) {
			count = -EFAULT;
			goto out_cleanup;
		}

		elem->len = copy;
		list_add_tail(&elem->entry, &list);

		len -= copy;
		used += copy;
	}

out_success:
	if (list_empty(&list))
		return -ENOMEM;

	list_splice_tail_init(&list, &priv->list);
	priv->bytes += count;

	*f_pos += count;
	return count;

out_cleanup:
	/* Free the last allocated element */
	fpga_fw_elem_free(elem);

	/* Free all of the elements on the temporary list */
	list_for_each_entry_safe(elem, tmp, &list, entry) {
		list_del(&elem->entry);
		fpga_fw_elem_free(elem);
	}

	return count;
}

static const struct file_operations fpga_fops = {
	.owner		= THIS_MODULE,
	.open		= fpga_open,
	.release	= fpga_release,
	.write		= fpga_write,
	.llseek		= no_llseek,
};

/*----------------------------------------------------------------------------*/
/* Device Attributes                                                          */
/*----------------------------------------------------------------------------*/

static ssize_t pgood_show(struct device *dev, struct device_attribute *attr,
			  char *buf)
{
	struct fpga_dev *priv = dev_get_drvdata(dev);
	return snprintf(buf, PAGE_SIZE, "%d\n", fpga_power_good(priv));
}

static ssize_t penable_show(struct device *dev, struct device_attribute *attr,
			    char *buf)
{
	struct fpga_dev *priv = dev_get_drvdata(dev);
	return snprintf(buf, PAGE_SIZE, "%d\n", fpga_power_enabled(priv));
}

static ssize_t penable_store(struct device *dev, struct device_attribute *attr,
			     const char *buf, size_t count)
{
	struct fpga_dev *priv = dev_get_drvdata(dev);
	unsigned long val;

	if (strict_strtoul(buf, 0, &val))
		return -EINVAL;

	if (val) {
		fpga_enable_power_supplies(priv);
	} else {
		fpga_do_stop(priv);
		fpga_disable_power_supplies(priv);
	}

	return count;
}

static ssize_t program_show(struct device *dev, struct device_attribute *attr,
			    char *buf)
{
	struct fpga_dev *priv = dev_get_drvdata(dev);
	return snprintf(buf, PAGE_SIZE, "%d\n", fpga_running(priv));
}

static ssize_t program_store(struct device *dev, struct device_attribute *attr,
			     const char *buf, size_t count)
{
	struct fpga_dev *priv = dev_get_drvdata(dev);
	unsigned long val;
	int ret;

	if (strict_strtoul(buf, 0, &val))
		return -EINVAL;

	/* We can't have an image writer and be programming simultaneously */
	if (mutex_lock_interruptible(&priv->lock))
		return -ERESTARTSYS;

	if (val) {
		ret = fpga_do_program(priv);
		if (ret)
			goto out_unlock;
	}

	ret = count;

out_unlock:
	mutex_unlock(&priv->lock);
	return ret;
}

static DEVICE_ATTR(power_good, S_IRUGO, pgood_show, NULL);
static DEVICE_ATTR(power_enable, S_IRUGO | S_IWUSR, penable_show, penable_store);
static DEVICE_ATTR(program, S_IRUGO | S_IWUSR, program_show, program_store);

static struct attribute *fpga_attributes[] = {
	&dev_attr_power_good.attr,
	&dev_attr_power_enable.attr,
	&dev_attr_program.attr,
	NULL,
};

static const struct attribute_group fpga_attr_group = {
	.attrs = fpga_attributes,
};

/*----------------------------------------------------------------------------*/
/* OpenFirmware Device Subsystem                                              */
/*----------------------------------------------------------------------------*/

static bool dma_filter(struct dma_chan *chan, void *data)
{
	/*
	 * DMA Channel #0 is the only acceptable device
	 *
	 * This probably won't survive an unload/load cycle of the Freescale
	 * DMAEngine driver, but that won't be a problem
	 */
	return chan->chan_id == 0 && chan->device->dev_id == 0;
}

static int fpga_of_remove(struct of_device *op)
{
	struct fpga_dev *priv = dev_get_drvdata(&op->dev);

	sysfs_remove_group(&priv->dev->kobj, &fpga_attr_group);

	cdev_del(&priv->cdev);
	free_irq(priv->irq, priv);

	iounmap(priv->immr);

	fpga_disable_power_supplies(priv);
	iounmap(priv->regs);

	dma_release_channel(priv->chan);
	carma_device_destroy(priv->devno);
	unregister_chrdev_region(priv->devno, 1);

	/* Free any firmware image that has not been programmed */
	fpga_drop_firmware_data(priv);

	mutex_destroy(&priv->lock);
	kfree(priv);

	return 0;
}

static int fpga_of_probe(struct of_device *op, const struct of_device_id *match)
{
	struct fpga_dev *priv;
	dma_cap_mask_t mask;
	u32 val;
	int ret;

	/* Allocate private data */
	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
	if (!priv) {
		dev_err(&op->dev, "Unable to allocate private data\n");
		ret = -ENOMEM;
		goto out_return;
	}

	dev_set_drvdata(&op->dev, priv);
	mutex_init(&priv->lock);
	init_completion(&priv->completion);
	cdev_init(&priv->cdev, &fpga_fops);
	priv->dmadev = &op->dev;
	INIT_LIST_HEAD(&priv->list);

	/* Allocate the character device */
	ret = alloc_chrdev_region(&priv->devno, 0, 1, driver_name);
	if (ret) {
		dev_err(&op->dev, "Unable to allocate chardev region\n");
		goto out_free_priv;
	}

	/* Allocate the CARMA device */
	priv->dev = carma_device_create(&op->dev, priv->devno, driver_name);
	if (IS_ERR(priv->dev)) {
		dev_err(&op->dev, "Unable to create CARMA device\n");
		ret = PTR_ERR(priv->dev);
		goto out_unregister_chrdev_region;
	}

	dev_set_drvdata(priv->dev, priv);
	dma_cap_zero(mask);
	dma_cap_set(DMA_MEMCPY, mask);
	dma_cap_set(DMA_INTERRUPT, mask);
	dma_cap_set(DMA_SLAVE, mask);

	/* Get control of DMA channel #0 */
	priv->chan = dma_request_channel(mask, dma_filter, NULL);
	if (!priv->chan) {
		dev_err(&op->dev, "Unable to acquire DMA channel #0\n");
		goto out_carma_device_destroy;
	}

	/* Remap the registers for use */
	priv->regs = of_iomap(op->node, 0);
	if (!priv->regs) {
		dev_err(&op->dev, "Unable to ioremap registers\n");
		ret = -ENOMEM;
		goto out_dma_release_channel;
	}

	/* Remap the IMMR for use */
	priv->immr = ioremap(get_immrbase(), 0x100000);
	if (!priv->immr) {
		dev_err(&op->dev, "Unable to ioremap IMMR\n");
		ret = -ENOMEM;
		goto out_unmap_regs;
	}

	/*
	 * Enable external DMA control pins
	 *
	 * WARNING: this must be done before attempting to set up the DMA
	 * WARNING: controller for externally initiated transfers. The default
	 * WARNING: state of the DMA control pins is incorrect for proper
	 * WARNING: operation of the FPGA programmer!!!
	 *
	 * NOTE: 2009-06-12: the U-Boot bootloader handles this now
	 *
	 * Failing to do so will cause the DMA controller to transfer a single
	 * cacheline worth of data, and then wedge itself.
	 */
	iowrite32be(0x80000E00, priv->immr + 0x114);

	/*
	 * TODO: make a better interface for this
	 *
	 * The DMA controller is not being used by the driver at this point,
	 * so we will just add the bits we need, and the driver will not alter
	 * them. This sets the following values:
	 *
	 * DMA Request Count: 8 cache lines
	 * Bandwidth Control: 8 cache lines
	 *
	 * These request count setting is necessary for the programmer to work
	 * in external start mode. The bandwidth control setting is optional.
	 */
	val = ioread32(priv->immr + 0x8100);
	iowrite32(val | 0x08600000, priv->immr + 0x8100);

	/* Enable the FPGA Programmer Interrupt */
	iowrite32be(0x1, priv->regs + 0x24); /* IRQ0 internal control */
	iowrite32be(0x1, priv->regs + 0x28); /* IRQ0 enabled */

	/* Find the correct IRQ number */
	priv->irq = irq_of_parse_and_map(op->node, 0);
	ret = request_irq(priv->irq, fpga_interrupt, IRQF_SHARED, driver_name, priv);
	if (ret) {
		dev_err(&op->dev, "Unable to request IRQ %d\n", priv->irq);
		ret = -ENODEV;
		goto out_unmap_immr;
	}

	/* Reset and stop the FPGA's, just in case */
	fpga_do_stop(priv);

	/* Enable the FPGA power supplies */
	ret = fpga_enable_power_supplies(priv);
	if (ret) {
		dev_err(&op->dev, "Unable to enable FPGA power supplies\n");
		ret = -ENODEV;
		goto out_free_irq;
	}

	/* Register the character device */
	ret = cdev_add(&priv->cdev, priv->devno, 1);
	if (ret) {
		dev_err(&op->dev, "Unable to add character device\n");
		goto out_disable_power_supplies;
	}

	/* Create the sysfs files */
	ret = sysfs_create_group(&priv->dev->kobj, &fpga_attr_group);
	if (ret) {
		dev_err(&op->dev, "Unable to create sysfs files\n");
		goto out_cdev_del;
	}

	dev_info(priv->dev, "CARMA FPGA Programmer Driver loaded\n");
	return 0;

out_cdev_del:
	cdev_del(&priv->cdev);
out_disable_power_supplies:
	fpga_disable_power_supplies(priv);
out_free_irq:
	free_irq(priv->irq, priv);
out_unmap_immr:
	iounmap(priv->immr);
out_unmap_regs:
	iounmap(priv->regs);
out_dma_release_channel:
	dma_release_channel(priv->chan);
out_carma_device_destroy:
	carma_device_destroy(priv->devno);
out_unregister_chrdev_region:
	unregister_chrdev_region(priv->devno, 1);
out_free_priv:
	mutex_destroy(&priv->lock);
	kfree(priv);
out_return:
	return ret;
}

static struct of_device_id fpga_of_match[] = {
	{ .compatible = "carma,fpga-programmer", },
	{},
};

static struct of_platform_driver fpga_of_driver = {
	.owner		= THIS_MODULE,
	.name		= driver_name,
	.match_table	= fpga_of_match,
	.probe		= fpga_of_probe,
	.remove		= fpga_of_remove,
};

/*----------------------------------------------------------------------------*/
/* Module Init / Exit                                                         */
/*----------------------------------------------------------------------------*/

static int __init fpga_init(void)
{
	led_trigger_register_simple("fpga", &ledtrig_fpga);
	return of_register_platform_driver(&fpga_of_driver);
}

static void __exit fpga_exit(void)
{
	of_unregister_platform_driver(&fpga_of_driver);
	led_trigger_unregister_simple(ledtrig_fpga);
}

MODULE_AUTHOR("Ira W. Snyder <iws@ovro.caltech.edu>");
MODULE_DESCRIPTION("CARMA FPGA Programmer Driver");
MODULE_LICENSE("GPL");

module_init(fpga_init);
module_exit(fpga_exit);
