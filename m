Return-Path: <cbouatmailru@gmail.com>
Received: from mail-ey0-f170.google.com (mail-ey0-f170.google.com
	[209.85.215.170]) by ozlabs.org (Postfix) with ESMTP id 9DA19B70E3
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Oct 2010 21:22:13 +1000 (EST)
Received: by eyg24 with SMTP id 24so1633384eyg.15
	for <linuxppc-dev@ozlabs.org>; Fri, 01 Oct 2010 04:22:10 -0700 (PDT)
Date: Fri, 1 Oct 2010 15:22:04 +0400
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: Mingkai Hu <Mingkai.hu@freescale.com>
Subject: Re: [PATCH v3 3/7] eSPI: add eSPI controller support
Message-ID: <20101001112204.GA16783@oksana.dev.rtsoft.ru>
References: <1285833646-12006-1-git-send-email-Mingkai.hu@freescale.com>
	<1285833646-12006-2-git-send-email-Mingkai.hu@freescale.com>
	<1285833646-12006-3-git-send-email-Mingkai.hu@freescale.com>
	<1285833646-12006-4-git-send-email-Mingkai.hu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1285833646-12006-4-git-send-email-Mingkai.hu@freescale.com>
Cc: linuxppc-dev@ozlabs.org, kumar.gala@freescale.com,
	linux-mtd@lists.infradead.org, spi-devel-general@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Mingkai,

There are mostly cosmetic comments down below.

On Thu, Sep 30, 2010 at 04:00:42PM +0800, Mingkai Hu wrote:
[...]
> +/*
> + * Freescale eSPI controller driver.
> + *
> + * Copyright 2010 Freescale Semiconductor, Inc.
> + *
> + * This program is free software; you can redistribute  it and/or modify it
> + * under  the terms of  the GNU General  Public License as published by the
> + * Free Software Foundation;  either version 2 of the  License, or (at your
> + * option) any later version.
> + */
> +#include <linux/module.h>
> +#include <linux/delay.h>
> +#include <linux/irq.h>
> +#include <linux/spi/spi.h>
> +#include <linux/platform_device.h>
> +#include <linux/fsl_devices.h>
> +#include <linux/mm.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <linux/of_spi.h>
> +#include <sysdev/fsl_soc.h>

Please move the sysdev/ include after linux/.
Will make it a bit prettier. :-)

> +#include <linux/interrupt.h>
> +#include <linux/err.h>
> +
> +#include "spi_fsl_lib.h"
[...]
> +static void fsl_espi_change_mode(struct spi_device *spi)
> +{
> +	struct mpc8xxx_spi *mspi = spi_master_get_devdata(spi->master);
> +	struct spi_mpc8xxx_cs *cs = spi->controller_state;
> +	struct fsl_espi_reg *reg_base = (struct fsl_espi_reg *)mspi->reg_base;

No need for the type cast. The same for the rest of the code.

> +	__be32 __iomem *mode;
> +	__be32 __iomem *espi_mode = NULL;
> +	u32 tmp;
> +	unsigned long flags;
> +
> +	espi_mode = &reg_base->mode;
> +	mode = &reg_base->csmode[spi->chip_select];

Could save a few lines by turning this into initializers.

> +
> +	/* Turn off IRQs locally to minimize time that SPI is disabled. */
> +	local_irq_save(flags);
> +
> +	/* Turn off SPI unit prior changing mode */
> +	tmp = mpc8xxx_spi_read_reg(espi_mode);
> +	mpc8xxx_spi_write_reg(espi_mode, tmp & ~SPMODE_ENABLE);
> +	mpc8xxx_spi_write_reg(mode, cs->hw_mode);
> +	mpc8xxx_spi_write_reg(espi_mode, tmp);
> +
> +	local_irq_restore(flags);
> +}
> +
> +static u32 fsl_espi_tx_buf_lsb(struct mpc8xxx_spi *mpc8xxx_spi)
> +{
> +	u32 data;
> +	u16 data_h, data_l;

u16 data_h;
u16 data_l;

> +

No need for this empty line.

> +	const u32 *tx = mpc8xxx_spi->tx;

<- Instead, add an empty line here.

> +	if (!tx)
> +		return 0;
> +
> +	data = *tx++ << mpc8xxx_spi->tx_shift;
> +	data_l = data & 0xffff;
> +	data_h = (data >> 16) & 0xffff;
> +	swab16s(&data_l);
> +	swab16s(&data_h);
> +	data = data_h | data_l;
> +
> +	mpc8xxx_spi->tx = tx;
> +	return data;
> +}
> +
> +static int fsl_espi_setup_transfer(struct spi_device *spi,
> +					struct spi_transfer *t)
> +{
> +	struct mpc8xxx_spi *mpc8xxx_spi;
> +	int bits_per_word = 0;
> +	u8 pm;
> +	u32 hz = 0;
> +	struct spi_mpc8xxx_cs	*cs = spi->controller_state;

Stray tab.

> +
> +	mpc8xxx_spi = spi_master_get_devdata(spi->master);

Could move this to the initializer.

> +
> +	if (t) {
> +		bits_per_word = t->bits_per_word;
> +		hz = t->speed_hz;
> +	}
> +
> +	/* spi_transfer level calls that work per-word */
> +	if (!bits_per_word)
> +		bits_per_word = spi->bits_per_word;
> +
> +	/* Make sure its a bit width we support [4..16] */
> +	if ((bits_per_word < 4) || (bits_per_word > 16))
> +		return -EINVAL;
> +
> +	if (!hz)
> +		hz = spi->max_speed_hz;
> +
> +	cs->rx_shift = 0;
> +	cs->tx_shift = 0;
> +	cs->get_rx = mpc8xxx_spi_rx_buf_u32;
> +	cs->get_tx = mpc8xxx_spi_tx_buf_u32;
> +	if (bits_per_word <= 8) {
> +		cs->rx_shift = 8 - bits_per_word;
> +	} else if (bits_per_word <= 16) {
> +		cs->rx_shift = 16 - bits_per_word;
> +		if (spi->mode & SPI_LSB_FIRST)
> +			cs->get_tx = fsl_espi_tx_buf_lsb;
> +	} else
> +		return -EINVAL;

} else {
}

> +
> +	mpc8xxx_spi->rx_shift = cs->rx_shift;
> +	mpc8xxx_spi->tx_shift = cs->tx_shift;
> +	mpc8xxx_spi->get_rx = cs->get_rx;
> +	mpc8xxx_spi->get_tx = cs->get_tx;
> +
> +	bits_per_word = bits_per_word - 1;
> +
> +	/* mask out bits we are going to set */
> +	cs->hw_mode &= ~(CSMODE_LEN(0xF) | CSMODE_DIV16
> +				  | CSMODE_PM(0xF));

No need to break this statement.

> +
> +	cs->hw_mode |= CSMODE_LEN(bits_per_word);
> +
> +	if ((mpc8xxx_spi->spibrg / hz) > 64) {
> +		cs->hw_mode |= CSMODE_DIV16;
> +		pm = (mpc8xxx_spi->spibrg - 1) / (hz * 64) + 1;
> +
> +		WARN_ONCE(pm > 16, "%s: Requested speed is too low: %d Hz. "
> +			  "Will use %d Hz instead.\n", dev_name(&spi->dev),
> +			  hz, mpc8xxx_spi->spibrg / 1024);
> +		if (pm > 16)
> +			pm = 16;
> +	} else {
> +		pm = (mpc8xxx_spi->spibrg - 1) / (hz * 4) + 1;
> +	}
> +	if (pm)
> +		pm--;
> +
> +	cs->hw_mode |= CSMODE_PM(pm);
> +
> +	fsl_espi_change_mode(spi);
> +	return 0;
> +}
> +
> +int fsl_espi_cpu_bufs(struct mpc8xxx_spi *mspi, struct spi_transfer *t,
> +		unsigned int len)

Does this need to be global?

> +{
> +	u32 word;
> +	struct fsl_espi_reg *reg_base = (struct fsl_espi_reg *)mspi->reg_base;
> +
> +	mspi->count = len;
> +
> +	/* enable rx ints */
> +	mpc8xxx_spi_write_reg(&reg_base->mask, SPIM_NE);
> +
> +	/* transmit word */
> +	word = mspi->get_tx(mspi);
> +	mpc8xxx_spi_write_reg(&reg_base->transmit, word);
> +
> +	return 0;
> +}
> +
> +static int fsl_espi_bufs(struct spi_device *spi, struct spi_transfer *t,
> +			    bool is_dma_mapped)

No need for the is_dma_mapped argument.

> +{
> +	struct mpc8xxx_spi *mpc8xxx_spi = spi_master_get_devdata(spi->master);
> +	struct fsl_espi_reg *reg_base;
> +	unsigned int len = t->len;
> +	u8 bits_per_word;
> +	int ret;
> +
> +	reg_base = (struct fsl_espi_reg *)mpc8xxx_spi->reg_base;

Better write this as an initializer, no need for the cast.

> +
> +	bits_per_word = spi->bits_per_word;
> +	if (t->bits_per_word)
> +		bits_per_word = t->bits_per_word;
[...]
> +static int fsl_espi_setup(struct spi_device *spi)
> +{
> +	struct mpc8xxx_spi *mpc8xxx_spi;
> +	struct fsl_espi_reg *reg_base;
> +	int retval;
> +	u32 hw_mode;
> +	u32 loop_mode;
> +	struct spi_mpc8xxx_cs	*cs = spi->controller_state;

Stray tab.

> +
> +	if (!spi->max_speed_hz)
> +		return -EINVAL;
> +
> +	if (!cs) {
> +		cs = kzalloc(sizeof *cs, GFP_KERNEL);
> +		if (!cs)
> +			return -ENOMEM;
> +		spi->controller_state = cs;
> +	}
[...]
> +		rx_data = mpc8xxx_spi_read_reg(&reg_base->receive);
> +
> +		if (mspi->rx)
> +			mspi->get_rx(rx_data, mspi);
> +	}
> +
> +	if ((events & SPIE_NF) == 0)

if (!(events & bit)) is a bit more more natural. Also, the if
statement here needs braces.

> +		/* spin until TX is done */
> +		while (((events = mpc8xxx_spi_read_reg(&reg_base->event))
> +					& SPIE_NF) == 0)
> +			cpu_relax();

This is dangerous. There's a handy spin_event_timeout()
in asm/delay.h.

> +
> +	/* Clear the events */
> +	mpc8xxx_spi_write_reg(&reg_base->event, events);
> +
> +	mspi->count -= 1;
> +	if (mspi->count) {
> +		u32 word = mspi->get_tx(mspi);
> +
> +		mpc8xxx_spi_write_reg(&reg_base->transmit, word);
> +	} else {
> +		complete(&mspi->done);
> +	}
> +}
> +
> +static irqreturn_t fsl_espi_irq(s32 irq, void *context_data)
> +{
> +	struct mpc8xxx_spi *mspi = context_data;
> +	struct fsl_espi_reg *reg_base = (struct fsl_espi_reg *)mspi->reg_base;
> +	irqreturn_t ret = IRQ_NONE;
> +	u32 events;
> +
> +	/* Get interrupt events(tx/rx) */
> +	events = mpc8xxx_spi_read_reg(&reg_base->event);
> +	if (events)
> +		ret = IRQ_HANDLED;
> +
> +	dev_dbg(mspi->dev, "%s: events %x\n", __func__, events);

dev_vdbg()

> +
> +	fsl_espi_cpu_irq(mspi, events);
> +
> +	return ret;
> +}
> +
> +static void fsl_espi_remove(struct mpc8xxx_spi *mspi)
> +{
> +	iounmap(mspi->reg_base);
> +}
> +
> +static struct spi_master * __devinit fsl_espi_probe(struct device *dev,
> +		struct resource *mem, unsigned int irq)
> +{
> +	struct fsl_spi_platform_data *pdata = dev->platform_data;
> +	struct spi_master *master;
> +	struct mpc8xxx_spi *mpc8xxx_spi;
> +	struct fsl_espi_reg *reg_base;
> +	u32 regval;
> +	int i, ret = 0;
> +
> +	master = spi_alloc_master(dev, sizeof(struct mpc8xxx_spi));
> +	if (master == NULL) {

Sometimes you check for !allocated, and sometimes allocated == NULL.
Be consistent. (And !allocated is more natural.)

> +		ret = -ENOMEM;
> +		goto err;
> +	}
> +
> +	dev_set_drvdata(dev, master);
> +
> +	ret = mpc8xxx_spi_probe(dev, mem, irq);
> +	if (ret)
> +		goto err_probe;
> +
> +	master->setup = fsl_espi_setup;
> +
> +	mpc8xxx_spi = spi_master_get_devdata(master);
> +	mpc8xxx_spi->spi_do_one_msg = fsl_espi_do_one_msg;
> +	mpc8xxx_spi->spi_remove = fsl_espi_remove;
> +
> +	mpc8xxx_spi->reg_base = ioremap(mem->start, resource_size(mem));
> +	if (mpc8xxx_spi->reg_base == NULL) {

Ditto.

> +		ret = -ENOMEM;
> +		goto err_probe;
> +	}
> +
> +	reg_base = (struct fsl_espi_reg *)mpc8xxx_spi->reg_base;
> +
> +	/* Register for SPI Interrupt */
> +	ret = request_irq(mpc8xxx_spi->irq, fsl_espi_irq,
> +			  0, "fsl_espi", mpc8xxx_spi);
> +
> +	if (ret != 0)

Every time someone writes 'if (rc != 0)', a kitty dies.
Simple 'if (rc)' saves kittens.

> +		goto free_irq;
> +
> +	if (mpc8xxx_spi->flags & SPI_QE_CPU_MODE) {
> +		mpc8xxx_spi->rx_shift = 16;
> +		mpc8xxx_spi->tx_shift = 24;
> +	}
[...]
> +
> +static int __devexit of_fsl_espi_remove(struct platform_device *dev)
> +{
> +	int ret;
> +
> +	ret = mpc8xxx_spi_remove(&dev->dev);
> +	if (ret)
> +		return ret;
> +
> +	return 0;

Just 'return mpc8xxx_spi_remove(&dev->dev);' is sufficient.

Also, I think there's no need for this wrapper nowadays (but
splitting OF and real probe() stuff is still appropriate).

> +}
> +
> +static const struct of_device_id of_fsl_espi_match[] = {
> +	{ .compatible = "fsl,mpc8536-espi" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, of_fsl_espi_match);
> +
> +static struct of_platform_driver fsl_espi_driver = {
> +	.driver = {
> +		.name = "fsl_espi",
> +		.owner = THIS_MODULE,
> +		.of_match_table = of_fsl_espi_match,
> +	},
> +	.probe		= of_fsl_espi_probe,
> +	.remove		= __devexit_p(of_fsl_espi_remove),
> +};
> +
> +static int __init fsl_espi_init(void)
> +{
> +	return of_register_platform_driver(&fsl_espi_driver);
> +}
> +module_init(fsl_espi_init);
> +
> +static void __exit fsl_espi_exit(void)
> +{
> +	of_unregister_platform_driver(&fsl_espi_driver);
> +}
> +module_exit(fsl_espi_exit);
> +
> +MODULE_AUTHOR("Mingkai Hu");
> +MODULE_DESCRIPTION("Enhanced Freescale SPI Driver");

This sounds like that this is an enhanced version of the
Freescale SPI driver, which it is not. ;-)

> +MODULE_LICENSE("GPL");
> diff --git a/drivers/spi/spi_fsl_lib.h b/drivers/spi/spi_fsl_lib.h
> index 6ae8949..9c81498 100644
> --- a/drivers/spi/spi_fsl_lib.h
> +++ b/drivers/spi/spi_fsl_lib.h
> @@ -26,6 +26,7 @@ struct mpc8xxx_spi {
>  	/* rx & tx bufs from the spi_transfer */
>  	const void *tx;
>  	void *rx;
> +	int len;

I'd place the #ifdef CONFIG_SPI_ESPI, for documentation purposes.

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
