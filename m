Return-Path: <david-b@pacbell.net>
Received: from smtp127.sbc.mail.sp1.yahoo.com (smtp127.sbc.mail.sp1.yahoo.com
	[69.147.65.186]) by ozlabs.org (Postfix) with SMTP id C2FD1DDF9C
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Apr 2009 06:12:41 +1000 (EST)
From: David Brownell <david-b@pacbell.net>
To: Stefan Roese <sr@denx.de>
Subject: Re: [PATCH v6] spi: Add PPC4xx SPI driver
Date: Wed, 22 Apr 2009 13:00:39 -0700
References: <1231411250-25380-1-git-send-email-sr@denx.de>
In-Reply-To: <1231411250-25380-1-git-send-email-sr@denx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200904221300.39747.david-b@pacbell.net>
Cc: linuxppc-dev@ozlabs.org, spi-devel-general@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 08 January 2009, Stefan Roese wrote:
> This adds a SPI driver for the SPI controller found in the IBM/AMCC
> 4xx PowerPC's.


> +/*
> + * The PPC4xx SPI controller has no FIFO so each sent/received byte will
> + * generate an interrupt to the CPU. This can cause high CPU utilization.
> + * This driver allows platforms to reduce the interrupt load on the CPU
> + * during SPI transfers by setting max_speed_hz via the device tree.

Note that an alternate strategy is to use polling instead of IRQs,
at least when the data rate is high enough that the IRQ processing
is also slowing down the data transfers.


> +/* bits in mode register - bit 0 ist MSb */
> +/* data latched on leading edge of clock, else trailing edge */
> +#define SPI_PPC4XX_MODE_SCP	(0x80 >> 3)

Or in short, SCP == CPHA.

> +/* port enabled */
> +#define SPI_PPC4XX_MODE_SPE	(0x80 >> 4)
> +/* MSB first, else LSB first */
> +#define SPI_PPC4XX_MODE_RD	(0x80 >> 5)
> +/* clock invert - idle clock = 1, active clock = 0; else reversed */
> +#define SPI_PPC4XX_MODE_CI	(0x80 >> 6)

Or in short, CI == CPOL.

> +/* loopback enable */
> +#define SPI_PPC4XX_MODE_IL	(0x80 >> 7)
> +/* bits in control register */
> +/* starts a transfer when set */
> +#define SPI_PPC4XX_CR_STR	(0x80 >> 7)
> +/* bits in status register */
> +/* port is busy with a transfer */
> +#define SPI_PPC4XX_SR_BSY	(0x80 >> 6)
> +/* RxD ready */
> +#define SPI_PPC4XX_SR_RBR	(0x80 >> 7)
> +
> +/* the spi->mode bits understood by this driver: */
> +#define MODEBITS	(SPI_CPHA | SPI_CPOL | SPI_CS_HIGH | SPI_LSB_FIRST)
> +
> +/* clock settings (SCP and CI) for various SPI modes */
> +#define SPI_CLK_MODE0	SPI_PPC4XX_MODE_SCP
> +#define SPI_CLK_MODE1	0
> +#define SPI_CLK_MODE2	SPI_PPC4XX_MODE_CI
> +#define SPI_CLK_MODE3	(SPI_PPC4XX_MODE_SCP | SPI_PPC4XX_MODE_CI)

Color me puzzled then.  Either the definitions of MODE0 and MODE1
are swapped here ... or the comments above are wrong, and SCP should
describe "falling" vs "rising" instead of "leading" vs "trailing".


> +static int spi_ppc4xx_setupxfer(struct spi_device *spi, struct spi_transfer *t)
> +{
> +	struct ppc4xx_spi *hw = spi_master_get_devdata(spi->master);
> +	struct spi_ppc4xx_cs *cs = spi->controller_state;
> +	int scr;
> +	u8 cdm = 0;
> +	u32 speed;
> +	u8 bits_per_word;
> +
> +	bits_per_word = (t) ? t->bits_per_word : spi->bits_per_word;
> +	speed = (t) ? t->speed_hz : spi->max_speed_hz;
> +
> +	...
> +
> +	if (!speed || (speed > spi->max_speed_hz)) {

This is wrong.  Typical case is that t->speed_hz is zero,
meaning "use spi->max_speed_hz" ... you treat that as an error.

> +		dev_err(&spi->dev, "invalid speed_hz (%d)\n", speed);
> +		return -EINVAL;
> +	}
> +
> +	...
> +}
> +
> +static int spi_ppc4xx_setup(struct spi_device *spi)
> +{
> +	int ret;
> +	struct spi_ppc4xx_cs *cs = spi->controller_state;
> +	int init = 0;

This "init" thing is still wrong.

Consider:  board gets set up with one device.  Later,
*WHILE BUSY TRANSFERRING DATA TO/FROM THAT DEVICE*
some other device gets instantiated.  Then ...


> +	if (cs == NULL) {
> +		cs = kzalloc(sizeof *cs, GFP_KERNEL);
> +		if (!cs)
> +			return -ENOMEM;
> +		spi->controller_state = cs;
> +
> +		/*
> +		 * First time called, so let's init the SPI controller
> +		 * at the end of this function
> +		 */
> +		init = 1;

"init" becomes true here, although the controller has
already been initialized.  If it needs to be set up,
do it in probe() before registering the spi_master.


> +	}
> +
> +	...
> +
> +	/*
> +	 * New configuration (mode, speed etc) will be written to the
> +	 * controller in spi_ppc4xx_setupxfer(). Only call
> +	 * spi_ppc4xx_setupxfer() directly upon first initialization.
> +	 */
> +	if (init) {
> +		ret = spi_ppc4xx_setupxfer(spi, NULL);

... so blam, you clobber the settings currently being used for
the active transfer.  So this would be a bug.

If not ... this driver deserves a comment on exactly how
unusual this driver is.  Specifically, that all spi_device
children must be set up *in advance* so that standard calls
like spi_new_device() don't work with it; and why.

I don't think I see anything in this driver which would
prevent that from working, though.  Sure you've got to
have a list of chipselect GPIOs in advance, but that's
distinct from being unable to use spi_new_device().


> +	...
> +}
> +
> +static void spi_ppc4xx_chipsel(struct spi_device *spi, int value)
> +{
> +	struct ppc4xx_spi *hw = spi_master_get_devdata(spi->master);
> +	unsigned int cspol = spi->mode & SPI_CS_HIGH ? 1 : 0;
> +	unsigned int cs = spi->chip_select;
> +
> +	if (!hw->num_gpios)
> +		return;

Hmm, num_gpios ... can never be zero, right?  You always
set it up so that of_gpio_count() GPIOs can all be used
as chipselects.  Looks like this check is not needed.

> +
> +	if (cs >= hw->num_gpios)
> +		return;

I guess I don't see why you have num_gpio instead of just
using the chipselect count, either.  (Assuming that the
of_gpio_count routine isn't counting *all* gpios, instead
of just ones allocated to this controller, which would be
a different issue.)


> +
> +	if (value != BITBANG_CS_INACTIVE && value != BITBANG_CS_ACTIVE)
> +		return;

Strange, what other values could be passed??


> +
> +	if (value == BITBANG_CS_INACTIVE)
> +		cspol = !cspol;
> +
> +	gpio_set_value(hw->gpios[cs], cspol);
> +}
> +
> +static irqreturn_t spi_ppc4xx_int(int irq, void *dev_id)
> +{
> +	struct ppc4xx_spi *hw;
> +	u8 status;
> +	u8 data;
> +	unsigned int count;
> +
> +	hw = (struct ppc4xx_spi *)dev_id;
> +
> +	status = in_8(&hw->regs->sr);
> +	if (!status)
> +		return IRQ_NONE;
> +
> +	/* should never happen but check anyway */
> +	if (status & SPI_PPC4XX_SR_BSY) {

Maybe "if (unlikely(...)) {" then.


> +		u8 lstatus;
> +		int cnt = 0;
> +
> +		dev_dbg(hw->dev, "got interrupt but spi still busy?\n");

But ... *does* this ever happen?  If not, I'd strike this
code.  And if it does, I'd add a comment explaining what's
known about this hardware bug.  Without this, the IRQ handler
would look pretty tight.

> +		do {
> +			ndelay(10);
> +			lstatus = in_8(&hw->regs->sr);
> +		} while (++cnt < 100 && lstatus & SPI_PPC4XX_SR_BSY);
> +
> +		if (cnt >= 100) {
> +			dev_err(hw->dev, "busywait: too many loops!\n");
> +			complete(&hw->done);
> +			return IRQ_HANDLED;
> +		} else {
> +			/* status is always 1 (RBR) here */
> +			status = in_8(&hw->regs->sr);
> +			dev_dbg(hw->dev, "loops %d status %x\n", cnt, status);
> +		}
> +	}
> +
> +	count = hw->count;
> +	hw->count++;
> +
> +	if (status & SPI_PPC4XX_SR_RBR) {
> +		/* Data Ready */

Most SPI hardware I've seen has at most a weak distinction
between "tx done" and "rx done" IRQs ... there's little
point to separate IRQs, since shifting out the last TX bit
is what shifts in the last RX bit.

Unless this is unusual hardware you can probably just assume
that there's RX data, and only read it if hw->rx is non-null.
Or, if this is *not* set, report the odd behavior...


> +		data = in_8(&hw->regs->rxd);
> +		if (hw->rx)
> +			hw->rx[count] = data;
> +	}
> +
> +	count++;
> +
> +	if (count < hw->len) {
> +		data = hw->tx ? hw->tx[count] : 0;
> +		out_8(&hw->regs->txd, data);
> +		out_8(&hw->regs->cr, SPI_PPC4XX_CR_STR);
> +	} else {
> +		complete(&hw->done);
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +		...
> +

> +static int __init spi_ppc4xx_of_probe(struct of_device *op,
> +				      const struct of_device_id *match)
> +{
> +	struct ppc4xx_spi *hw;
> +	struct spi_master *master;
> +	struct spi_bitbang *bbp;
> +	struct resource resource;
> +	struct device_node *np = op->node;
> +	struct device *dev = &op->dev;
> +	struct device_node *opbnp;
> +	int ret;
> +	const unsigned int *clk;
> +
> +	master = spi_alloc_master(dev, sizeof *hw);
> +	if (master == NULL)
> +		return -ENOMEM;
> +	dev_set_drvdata(dev, master);
> +	hw = spi_master_get_devdata(master);
> +	memset(hw, 0, sizeof(struct ppc4xx_spi));

That memset is not required, it comes to you pre-zeroed.

> +
> +	hw->master = spi_master_get(master);
> +	hw->dev = dev;
> +
> +	init_completion(&hw->done);
> +
> +	hw->num_gpios = of_gpio_count(np);

Worth a comment what's going on there.  I'm assuming this
of_gpio_count() thing returns a count of GPIOs somehow
associated with this specific device tree node, rather than
say all GPIOs known to the device tree...

> +	if (hw->num_gpios) {
> +		int i;
> +
> +		hw->gpios = kzalloc(sizeof(int) * hw->num_gpios,
> +				    GFP_KERNEL);
> +		if (!hw->gpios) {
> +			ret = -ENOMEM;
> +			goto free_master;
> +		}
> +
> +		for (i = 0; i < hw->num_gpios; i++) {
> +			int gpio = of_get_gpio(np, i);
> +			if (gpio < 0) {
> +				dev_err(dev, "Invalid gpio spec %d\n", i);
> +				ret = gpio;
> +				goto free_gpios;
> +			}
> +
> +			ret = gpio_request(gpio, np->name);
> +			if (ret < 0) {
> +				dev_err(dev, "gpio %d already in use\n", i);
> +				ret = gpio;
> +				goto free_gpios;
> +			}
> +
> +			gpio_direction_output(gpio, 0);
> +			hw->gpios[i] = gpio;
> +		}
> +	}

Else ... error, if there are no chipselects?

I've got a patch pending to add a "no chipselect" spi->mode flag.
If you expect to support that, please let me know.


> +
> +	/* Setup the state for the bitbang driver */
> +	bbp = &hw->bitbang;
> +	bbp->master = hw->master;
> +	bbp->setup_transfer = spi_ppc4xx_setupxfer;
> +	bbp->chipselect = spi_ppc4xx_chipsel;
> +	bbp->txrx_bufs = spi_ppc4xx_txrx;
> +	bbp->use_dma = 0;
> +	bbp->master->setup = spi_ppc4xx_setup;
> +	bbp->master->cleanup = spi_ppc4xx_cleanup;
> +	/* only one SPI controller */
> +	bbp->master->bus_num = 0;

Bad assumption.  There could be GPIO-based adapters,
of course.  And aren't these the cores which can be
found on higher end Xilinx FPGAs?  And, accordingly,
integrated with any number of additional controllers?

If so, the restriction is just that this controller
be bus #0.  If not ... the Kconfig should say more
about *which* PPC4xx chips have this controller.
(I suspect it's the latter.)


> +	if (bbp->master->num_chipselect == 0) {

You didn't set it, so of course it's still zeroed.


> +		/* this many pins in al GPIO controllers */
> +		bbp->master->num_chipselect = hw->num_gpios;

So num_chipselect is alays num_gpios, and there's no point
to having num_gpios since you could always use num_chipselect.


> +	}
> +
> +	...
> +}
