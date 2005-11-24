Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 45B486881D
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Nov 2005 22:17:43 +1100 (EST)
Date: Thu, 24 Nov 2005 12:17:01 +0100
From: Christoph Hellwig <hch@lst.de>
To: Heiko Schocher <hs@denx.de>
Message-ID: <20051124111701.GA12510@lst.de>
References: <72C7A068-2C84-49BB-957A-1D1A725949D0@kernel.crashing.org>
	<AHEILKONAKAEJPHNMOPNEEMNCDAA.hs@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AHEILKONAKAEJPHNMOPNEEMNCDAA.hs@denx.de>
Cc: linuxppc-dev@ozlabs.org, lm-sensors@lm-sensors.org
Subject: Re: [PATCH]	I2C:	Add I2C support for the MPC8260
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> + * Release 0.1

please don't put such versaison comments in, the SCM has the history.

> +#include <linux/config.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/sched.h>
> +#include <linux/init.h>
> +#include <linux/pci.h>
> +#include <asm/io.h>
> +#include <linux/fsl_devices.h>
> +#include <linux/i2c.h>
> +#include <linux/interrupt.h>
> +#include <linux/delay.h>
> +#include <asm/immap_cpm2.h>
> +#include <asm/mpc8260.h>
> +#include <asm/cpm2.h>
> +
> +#include <linux/i2c-algo-cpm2.h>
> +#include <linux/platform_device.h>

<asm/*.h> always after <linux/*.h> please.

> +#define CPM_MAX_READ	513
> +
> +static wait_queue_head_t iic_wait;
> +static ushort r_tbase, r_rbase;
> +
> +int cpm_scan = 0;
> +int cpm_debug = 0;
> +
> +struct mpc_i2c {
> +	u32 interrupt;
> +	wait_queue_head_t queue;
> +	struct i2c_adapter adap;
> +	int irq;
> +	u32 flags;
> +	struct i2c_algo_cpm2_data *data;
> +};
> +
> +static struct i2c_algo_cpm2_data cpm2_data;
> +
> +static void
> +cpm2_iic_init(struct i2c_algo_cpm2_data *data)
> +{
> +	volatile cpm_cpm2_t *cp;
> +	volatile cpm2_map_t *immap;
> +
> +	cp = cpmp;	/* Get pointer to Communication Processor */
> +	immap = (cpm2_map_t *)CPM_MAP_ADDR;	/* and to internal registers */
> +
> +	*(ushort *)(&immap->im_dprambase[PROFF_I2C_BASE]) = PROFF_I2C;
> +	data->iip = (iic_t *)&immap->im_dprambase[PROFF_I2C];

Please stop volatile abuse and use ioremap & friends to properly to access
I/O memory.

> +	/* Chip bug, set enable here */
> +	local_irq_save(flags);
> +	i2c->i2c_i2cmr = 0x13;	/* Enable some interupts */
> +	i2c->i2c_i2cer = 0xff;
> +	i2c->i2c_i2mod |= 1;	/* Enable */
> +	i2c->i2c_i2com = 0x81;	/* Start master */
> +
> +	/* Wait for IIC transfer */
> +	interruptible_sleep_on(&iic_wait);

never use interruptible_sleep_on() and the local_irq_save usage here is
bogus aswell, please use proper irq disabling spinlocks and make sure
you don't sleep with interrupts disabled.

> +	if (cpm_debug) {
> +			int u;
> +			for (u = 0; u < count; u++) {
> +				printk(KERN_DEBUG "buf[%d] = 0x%x\n", u, buf[u]);
> +			}
> +			}


broken indentation.

> +			if (cpm_debug)
> +				printk(KERN_DEBUG "i2c-cpm2.o: wrote %d\n", ret);

could you please use dev_dbg() instead of all this if (cpm_debug) mess?

> +			if (ret < pmsg->len ) {
> +				return (ret<0) ? ret : -EREMOTEIO;

indentation problems again.

> +	int result = 0;
> +	struct mpc_i2c *i2c;
> +	struct platform_device *pdev = to_platform_device(device);
> +	struct fsl_i2c_platform_data *pdata;
> +
> +	pdata = (struct fsl_i2c_platform_data *) pdev->dev.platform_data;

generally no need to cast here.  Also please use platform_get_drvdata()

> +
> +	if (!(i2c = kmalloc(sizeof(*i2c), GFP_KERNEL))) {
> +		return -ENOMEM;
> +	}
> +	memset(i2c, 0, sizeof(*i2c));

please use kzalloc()

> +	if ((result = i2c_add_adapter(&i2c->adap)) < 0) {

please split such lines into two.

> +  fail_add:

goto lables should either be in column 0 or 1 (and that consitantly
through a source file)
