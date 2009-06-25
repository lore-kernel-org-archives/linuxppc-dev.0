Return-Path: <sfalco@harris.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id C991BB7067
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 26 Jun 2009 04:53:12 +1000 (EST)
Received: from mlbe2k1.cs.myharris.net (mlbe2k1.cs.myharris.net
	[137.237.90.88]) by ozlabs.org (Postfix) with ESMTP id B8EBDDDD0B
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Jun 2009 04:53:11 +1000 (EST)
Message-ID: <4A43C792.9030909@harris.com>
Date: Thu, 25 Jun 2009 14:53:06 -0400
From: "Steven A. Falco" <sfalco@harris.com>
MIME-Version: 1.0
To: David Brownell <david-b@pacbell.net>, Stefan Roese <sr@denx.de>
Subject: Re: Subject: [PATCH v6] spi: Add PPC4xx SPI driver
References: <200906251833.n5PIX42Z017229@saf.cs.myharris.net>
In-Reply-To: <200906251833.n5PIX42Z017229@saf.cs.myharris.net>
Content-Type: text/plain; charset=UTF-8
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Stefan suggested that I try to address the comments against the PPC4xx
SPI driver, so here goes...

A post of version 7 of the driver will follow this email, but I thought
it might make it easier on everyone to inline my comments here.  Hence,
this brief, introductory "top post".

> On Thursday 08 January 2009, Stefan Roese wrote:
>> This adds a SPI driver for the SPI controller found in the IBM/AMCC
>> 4xx PowerPC's.
> 
> 
>> +/*
>> + * The PPC4xx SPI controller has no FIFO so each sent/received byte will
>> + * generate an interrupt to the CPU. This can cause high CPU utilization.
>> + * This driver allows platforms to reduce the interrupt load on the CPU
>> + * during SPI transfers by setting max_speed_hz via the device tree.
> 
> Note that an alternate strategy is to use polling instead of IRQs,
> at least when the data rate is high enough that the IRQ processing
> is also slowing down the data transfers.
> 
> 
>> +/* bits in mode register - bit 0 ist MSb */
>> +/* data latched on leading edge of clock, else trailing edge */
>> +#define SPI_PPC4XX_MODE_SCP	(0x80 >> 3)
> 
> Or in short, SCP == CPHA.
> 

Actually, SCP = !CPHA.  I've added a comment to that effect in v7.

>> +/* port enabled */
>> +#define SPI_PPC4XX_MODE_SPE	(0x80 >> 4)
>> +/* MSB first, else LSB first */
>> +#define SPI_PPC4XX_MODE_RD	(0x80 >> 5)
>> +/* clock invert - idle clock = 1, active clock = 0; else reversed */
>> +#define SPI_PPC4XX_MODE_CI	(0x80 >> 6)
> 
> Or in short, CI == CPOL.
> 

Correct.  Comment added.

>> +/* loopback enable */
>> +#define SPI_PPC4XX_MODE_IL	(0x80 >> 7)
>> +/* bits in control register */
>> +/* starts a transfer when set */
>> +#define SPI_PPC4XX_CR_STR	(0x80 >> 7)
>> +/* bits in status register */
>> +/* port is busy with a transfer */
>> +#define SPI_PPC4XX_SR_BSY	(0x80 >> 6)
>> +/* RxD ready */
>> +#define SPI_PPC4XX_SR_RBR	(0x80 >> 7)
>> +
>> +/* the spi->mode bits understood by this driver: */
>> +#define MODEBITS	(SPI_CPHA | SPI_CPOL | SPI_CS_HIGH | SPI_LSB_FIRST)
>> +
>> +/* clock settings (SCP and CI) for various SPI modes */
>> +#define SPI_CLK_MODE0	SPI_PPC4XX_MODE_SCP
>> +#define SPI_CLK_MODE1	0
>> +#define SPI_CLK_MODE2	SPI_PPC4XX_MODE_CI
>> +#define SPI_CLK_MODE3	(SPI_PPC4XX_MODE_SCP | SPI_PPC4XX_MODE_CI)
> 
> Color me puzzled then.  Either the definitions of MODE0 and MODE1
> are swapped here ... or the comments above are wrong, and SCP should
> describe "falling" vs "rising" instead of "leading" vs "trailing".
> 
> 

The modes were wrong.  MODE0 and MODE1 were correct, but MODE2 and MODE3
were interchanged.  Fixed in v7, and verified on a logic analyzer.

>> +static int spi_ppc4xx_setupxfer(struct spi_device *spi, struct spi_transfer *t)
>> +{
>> +	struct ppc4xx_spi *hw = spi_master_get_devdata(spi->master);
>> +	struct spi_ppc4xx_cs *cs = spi->controller_state;
>> +	int scr;
>> +	u8 cdm = 0;
>> +	u32 speed;
>> +	u8 bits_per_word;
>> +
>> +	bits_per_word = (t) ? t->bits_per_word : spi->bits_per_word;
>> +	speed = (t) ? t->speed_hz : spi->max_speed_hz;
>> +
>> +	...
>> +
>> +	if (!speed || (speed > spi->max_speed_hz)) {
> 
> This is wrong.  Typical case is that t->speed_hz is zero,
> meaning "use spi->max_speed_hz" ... you treat that as an error.
> 

Correct.  I've fixed the logic for t->speed_hz and for t->bits_per_word.

>> +		dev_err(&spi->dev, "invalid speed_hz (%d)\n", speed);
>> +		return -EINVAL;
>> +	}
>> +
>> +	...
>> +}
>> +
>> +static int spi_ppc4xx_setup(struct spi_device *spi)
>> +{
>> +	int ret;
>> +	struct spi_ppc4xx_cs *cs = spi->controller_state;
>> +	int init = 0;
> 
> This "init" thing is still wrong.

Correct.  I've removed it entirely.

> 
> Consider:  board gets set up with one device.  Later,
> *WHILE BUSY TRANSFERRING DATA TO/FROM THAT DEVICE*
> some other device gets instantiated.  Then ...
> 
> 
>> +	if (cs == NULL) {
>> +		cs = kzalloc(sizeof *cs, GFP_KERNEL);
>> +		if (!cs)
>> +			return -ENOMEM;
>> +		spi->controller_state = cs;
>> +
>> +		/*
>> +		 * First time called, so let's init the SPI controller
>> +		 * at the end of this function
>> +		 */
>> +		init = 1;
> 
> "init" becomes true here, although the controller has
> already been initialized.  If it needs to be set up,
> do it in probe() before registering the spi_master.
> 
> 
>> +	}
>> +
>> +	...
>> +
>> +	/*
>> +	 * New configuration (mode, speed etc) will be written to the
>> +	 * controller in spi_ppc4xx_setupxfer(). Only call
>> +	 * spi_ppc4xx_setupxfer() directly upon first initialization.
>> +	 */
>> +	if (init) {
>> +		ret = spi_ppc4xx_setupxfer(spi, NULL);
> 
> ... so blam, you clobber the settings currently being used for
> the active transfer.  So this would be a bug.
> 
> If not ... this driver deserves a comment on exactly how
> unusual this driver is.  Specifically, that all spi_device
> children must be set up *in advance* so that standard calls
> like spi_new_device() don't work with it; and why.
> 
> I don't think I see anything in this driver which would
> prevent that from working, though.  Sure you've got to
> have a list of chipselect GPIOs in advance, but that's
> distinct from being unable to use spi_new_device().
> 
> 
>> +	...
>> +}
>> +
>> +static void spi_ppc4xx_chipsel(struct spi_device *spi, int value)
>> +{
>> +	struct ppc4xx_spi *hw = spi_master_get_devdata(spi->master);
>> +	unsigned int cspol = spi->mode & SPI_CS_HIGH ? 1 : 0;
>> +	unsigned int cs = spi->chip_select;
>> +
>> +	if (!hw->num_gpios)
>> +		return;
> 
> Hmm, num_gpios ... can never be zero, right?  You always
> set it up so that of_gpio_count() GPIOs can all be used
> as chipselects.  Looks like this check is not needed.
> 

I believe that it can be zero, in the case where there is a single
"always on" device.  But I have modified this test to use
hw->master->num_chipselect as per your next comment.  I've also added a
check for the special case of EEXIST, which on powerpc means "a hole in
the list of gpio's".  I actually use this for an AVR device, because it
won't tolerate transitions on its CS lead, so I manage its CS outside of
the driver.  I can explain further if you want the details of our
hardware ugliness. :-)

>> +
>> +	if (cs >= hw->num_gpios)
>> +		return;
> 
> I guess I don't see why you have num_gpio instead of just
> using the chipselect count, either.  (Assuming that the
> of_gpio_count routine isn't counting *all* gpios, instead
> of just ones allocated to this controller, which would be
> a different issue.)
> 
> 

Correct, and fixed in v7.

>> +
>> +	if (value != BITBANG_CS_INACTIVE && value != BITBANG_CS_ACTIVE)
>> +		return;
> 
> Strange, what other values could be passed??
> 
> 

I've removed this test - it is superfluous.

>> +
>> +	if (value == BITBANG_CS_INACTIVE)
>> +		cspol = !cspol;
>> +
>> +	gpio_set_value(hw->gpios[cs], cspol);
>> +}
>> +
>> +static irqreturn_t spi_ppc4xx_int(int irq, void *dev_id)
>> +{
>> +	struct ppc4xx_spi *hw;
>> +	u8 status;
>> +	u8 data;
>> +	unsigned int count;
>> +
>> +	hw = (struct ppc4xx_spi *)dev_id;
>> +
>> +	status = in_8(&hw->regs->sr);
>> +	if (!status)
>> +		return IRQ_NONE;
>> +
>> +	/* should never happen but check anyway */
>> +	if (status & SPI_PPC4XX_SR_BSY) {
> 
> Maybe "if (unlikely(...)) {" then.
> 
> 

I added unlikely() and a comment explaining why this test might be
needed.  I've not observed it myself, but the documentation seems to
allow for the possibility.

>> +		u8 lstatus;
>> +		int cnt = 0;
>> +
>> +		dev_dbg(hw->dev, "got interrupt but spi still busy?\n");
> 
> But ... *does* this ever happen?  If not, I'd strike this
> code.  And if it does, I'd add a comment explaining what's
> known about this hardware bug.  Without this, the IRQ handler
> would look pretty tight.
> 

See the comment in the v7 code for why this might be necessary.

>> +		do {
>> +			ndelay(10);
>> +			lstatus = in_8(&hw->regs->sr);
>> +		} while (++cnt < 100 && lstatus & SPI_PPC4XX_SR_BSY);
>> +
>> +		if (cnt >= 100) {
>> +			dev_err(hw->dev, "busywait: too many loops!\n");
>> +			complete(&hw->done);
>> +			return IRQ_HANDLED;
>> +		} else {
>> +			/* status is always 1 (RBR) here */
>> +			status = in_8(&hw->regs->sr);
>> +			dev_dbg(hw->dev, "loops %d status %x\n", cnt, status);
>> +		}
>> +	}
>> +
>> +	count = hw->count;
>> +	hw->count++;
>> +
>> +	if (status & SPI_PPC4XX_SR_RBR) {
>> +		/* Data Ready */
> 
> Most SPI hardware I've seen has at most a weak distinction
> between "tx done" and "rx done" IRQs ... there's little
> point to separate IRQs, since shifting out the last TX bit
> is what shifts in the last RX bit.
> 
> Unless this is unusual hardware you can probably just assume
> that there's RX data, and only read it if hw->rx is non-null.
> Or, if this is *not* set, report the odd behavior...
> 
> 

I've removed this test.  The docs clearly state that the RBR bit is the
cause of the interrupt, so there is no reason to test it.

>> +		data = in_8(&hw->regs->rxd);
>> +		if (hw->rx)
>> +			hw->rx[count] = data;
>> +	}
>> +
>> +	count++;
>> +
>> +	if (count < hw->len) {
>> +		data = hw->tx ? hw->tx[count] : 0;
>> +		out_8(&hw->regs->txd, data);
>> +		out_8(&hw->regs->cr, SPI_PPC4XX_CR_STR);
>> +	} else {
>> +		complete(&hw->done);
>> +	}
>> +
>> +	return IRQ_HANDLED;
>> +}
>> +
>> +		...
>> +
> 
>> +static int __init spi_ppc4xx_of_probe(struct of_device *op,
>> +				      const struct of_device_id *match)
>> +{
>> +	struct ppc4xx_spi *hw;
>> +	struct spi_master *master;
>> +	struct spi_bitbang *bbp;
>> +	struct resource resource;
>> +	struct device_node *np = op->node;
>> +	struct device *dev = &op->dev;
>> +	struct device_node *opbnp;
>> +	int ret;
>> +	const unsigned int *clk;
>> +
>> +	master = spi_alloc_master(dev, sizeof *hw);
>> +	if (master == NULL)
>> +		return -ENOMEM;
>> +	dev_set_drvdata(dev, master);
>> +	hw = spi_master_get_devdata(master);
>> +	memset(hw, 0, sizeof(struct ppc4xx_spi));
> 
> That memset is not required, it comes to you pre-zeroed.
> 

Removed.

>> +
>> +	hw->master = spi_master_get(master);
>> +	hw->dev = dev;
>> +
>> +	init_completion(&hw->done);
>> +
>> +	hw->num_gpios = of_gpio_count(np);
> 
> Worth a comment what's going on there.  I'm assuming this
> of_gpio_count() thing returns a count of GPIOs somehow
> associated with this specific device tree node, rather than
> say all GPIOs known to the device tree...
> 

I've beefed up the comments for this in v7.  Please let me know if you
want more.

>> +	if (hw->num_gpios) {
>> +		int i;
>> +
>> +		hw->gpios = kzalloc(sizeof(int) * hw->num_gpios,
>> +				    GFP_KERNEL);
>> +		if (!hw->gpios) {
>> +			ret = -ENOMEM;
>> +			goto free_master;
>> +		}
>> +
>> +		for (i = 0; i < hw->num_gpios; i++) {
>> +			int gpio = of_get_gpio(np, i);
>> +			if (gpio < 0) {
>> +				dev_err(dev, "Invalid gpio spec %d\n", i);
>> +				ret = gpio;
>> +				goto free_gpios;
>> +			}
>> +
>> +			ret = gpio_request(gpio, np->name);
>> +			if (ret < 0) {
>> +				dev_err(dev, "gpio %d already in use\n", i);
>> +				ret = gpio;
>> +				goto free_gpios;
>> +			}
>> +
>> +			gpio_direction_output(gpio, 0);
>> +			hw->gpios[i] = gpio;
>> +		}
>> +	}
> 
> Else ... error, if there are no chipselects?
> 
> I've got a patch pending to add a "no chipselect" spi->mode flag.
> If you expect to support that, please let me know.
> 
> 

I guess we should allow the case of a single device with no CS.  I don't
have such a configuration, but I think the way I've written the
spi_ppc4xx_chipsel() will handle that case.

>> +
>> +	/* Setup the state for the bitbang driver */
>> +	bbp = &hw->bitbang;
>> +	bbp->master = hw->master;
>> +	bbp->setup_transfer = spi_ppc4xx_setupxfer;
>> +	bbp->chipselect = spi_ppc4xx_chipsel;
>> +	bbp->txrx_bufs = spi_ppc4xx_txrx;
>> +	bbp->use_dma = 0;
>> +	bbp->master->setup = spi_ppc4xx_setup;
>> +	bbp->master->cleanup = spi_ppc4xx_cleanup;
>> +	/* only one SPI controller */
>> +	bbp->master->bus_num = 0;
> 
> Bad assumption.  There could be GPIO-based adapters,
> of course.  And aren't these the cores which can be
> found on higher end Xilinx FPGAs?  And, accordingly,
> integrated with any number of additional controllers?
> 
> If so, the restriction is just that this controller
> be bus #0.  If not ... the Kconfig should say more
> about *which* PPC4xx chips have this controller.
> (I suspect it's the latter.)
> 
> 

I've changed this to ...bus_num = -1.  The dynamic allocation works for
me.

>> +	if (bbp->master->num_chipselect == 0) {
> 
> You didn't set it, so of course it's still zeroed.
> 
> 

Removed this test.

>> +		/* this many pins in al GPIO controllers */
>> +		bbp->master->num_chipselect = hw->num_gpios;
> 
> So num_chipselect is alays num_gpios, and there's no point
> to having num_gpios since you could always use num_chipselect.
> 
> 

Correct.  Substituted num_chipselect for num_gpios in v7.

>> +	}
>> +
>> +	...
>> +}
> 
> 
