Return-Path: <miltonm@bga.com>
Received: from ruth.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id F3F5EDDE21
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Jun 2007 02:30:50 +1000 (EST)
Mime-Version: 1.0 (Apple Message framework v624)
In-Reply-To: <20070615120848.454492000@pademelon.sonytel.be>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <d46c75da8a86ab5cd83b63f9dbfee33f@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [patch 5/6] ps3: ROM Storage Driver
Date: Mon, 18 Jun 2007 11:30:39 -0500
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Cc: ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
>
> Add a CD/DVD/BD Storage Driver for the PS3:
>   - Implemented as a SCSI device driver
>   - Uses software scatter-gather with a 64 KiB bounce buffer as the 
> hypervisor
>     doesn't support scatter-gather
>


>
> +config PS3_ROM
> +	tristate "PS3 ROM Storage Driver"
> +	depends on PPC_PS3 && BLK_DEV_SR
> +	select PS3_STORAGE
> +	help
> +	  Include support for the PS3 ROM Storage.
> +
> +	  This support is required to access the PS3 BD/DVD/CD-ROM drive.
> +	  In general, all users will say Y or M.
> +


When I think ROM I usually dont' start with optical media.

Have you condered calling this the optical driver?

Or at least putting BD?DVD?CD-ROM on the prompt.


Why does it depend on BLK_DEV_SR?

...
> +
> +#include <linux/cdrom.h>
> +#include <linux/highmem.h>
> +#include <linux/interrupt.h>
> +#include <linux/kthread.h>
> +
> +#include <scsi/scsi.h>
> +#include <scsi/scsi_cmnd.h>
> +#include <scsi/scsi_dbg.h>
> +#include <scsi/scsi_device.h>
> +#include <scsi/scsi_host.h>
> +
> +#include <asm/lv1call.h>
> +#include <asm/ps3stor.h>
> +
> +
> +#define DEVICE_NAME			"ps3rom"
> +
> +#define BOUNCE_SIZE			(64*1024)
> +
> +#define PS3ROM_MAX_SECTORS		(BOUNCE_SIZE / CD_FRAMESIZE)
> +

the above describes the device

> +#define LV1_STORAGE_SEND_ATAPI_COMMAND	(1)
> +
>
while this one is part of the hypervisor ABI.


> +
> +struct ps3rom_private {
> +	struct ps3_storage_device *dev;
> +	struct scsi_cmnd *cmd;
> +};
> +#define ps3rom_priv(dev)	((dev)->sbd.core.driver_data)
>

The above is driver defined.

> +
> +struct lv1_atapi_cmnd_block {
> +	u8	pkt[32];	/* packet command block           */
> +	u32	pktlen;		/* should be 12 for ATAPI 8020    */
> +	u32	blocks;
> +	u32	block_size;
> +	u32	proto;		/* transfer mode                  */
> +	u32	in_out;		/* transfer direction             */
> +	u64	buffer;		/* parameter except command block */
> +	u32	arglen;		/* length above                   */
> +};
> +

Its minor, but I'd probably put the define down here with the rest of 
the ABI contants vs all defines then structs then enums.

> +enum lv1_atapi_proto {
> +	NON_DATA_PROTO     = 0,
> +	PIO_DATA_IN_PROTO  = 1,
> +	PIO_DATA_OUT_PROTO = 2,
> +	DMA_PROTO = 3
> +};
> +
> +enum lv1_atapi_in_out {
> +	DIR_WRITE = 0, /* memory -> device */
> +	DIR_READ = 1 /* device -> memory */
> +};
> +
>


...


> +
> +static int __devinit ps3rom_probe(struct ps3_system_bus_device *_dev)
> +{
> +	struct ps3_storage_device *dev = to_ps3_storage_device(&_dev->core);
> +	int error;
> +	struct Scsi_Host *host;
> +	struct ps3rom_private *priv;
> +
> +	if (dev->blk_size != CD_FRAMESIZE) {
> +		dev_err(&dev->sbd.core,
> +			"%s:%u: cannot handle block size %lu\n", __func__,
> +			__LINE__, dev->blk_size);
> +		return -EINVAL;
> +	}
> +
> +	dev->bounce_size = BOUNCE_SIZE;
> +	dev->bounce_buf = kmalloc(BOUNCE_SIZE, GFP_DMA);
> +	if (!dev->bounce_buf) {
> +		return -ENOMEM;
> +	}
> +
> +	error = ps3stor_setup(dev);
> +	if (error)
> +		goto fail_free_bounce;
> +
> +	/* override the interrupt handler */
> +	free_irq(dev->irq, dev);
> +	error = request_irq(dev->irq, ps3rom_interrupt, IRQF_DISABLED,
> +			    dev->sbd.core.driver->name, dev);
> +	if (error) {
> +		dev_err(&dev->sbd.core, "%s:%u: request_irq failed %d\n",
> +			__func__, __LINE__, error);
> +		goto fail_teardown;
> +	}
> +

Somebody's help isn't helpful?  Layering problem?


> +	host = scsi_host_alloc(&ps3rom_host_template,
> +			       sizeof(struct ps3rom_private));
> +	if (!host) {
> +		dev_err(&dev->sbd.core, "%s:%u: scsi_host_alloc failed\n",
> +			__func__, __LINE__);
> +		goto fail_teardown;
> +	}
> +
> +	priv = (struct ps3rom_private *)host->hostdata;
> +	ps3rom_priv(dev) = host;
> +	priv->dev = dev;
>

Is there code to clear ->priv when failing or unregistering?  Usually 
these fields are set to NULL to avoid accidental use of stale pointers 
to freed memory.  Discovering a NULL pointer defereence is usually 
easier than a stale usage.

> +
> +	/* One device/LUN per SCSI bus */
> +	host->max_id = 1;
> +	host->max_lun = 1;
> +
> +	error = scsi_add_host(host, &dev->sbd.core);
> +	if (error) {
> +		dev_err(&dev->sbd.core, "%s:%u: scsi_host_alloc failed %d\n",
> +			__func__, __LINE__, error);
> +		error = -ENODEV;
> +		goto fail_host_put;
> +	}
> +
> +	scsi_scan_host(host);
> +	return 0;
> +
> +fail_host_put:
> +	scsi_host_put(host);
> +fail_teardown:
> +	ps3stor_teardown(dev);
> +fail_free_bounce:
> +	kfree(dev->bounce_buf);
> +	return error;
> +}
>
