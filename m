Return-Path: <sr@denx.de>
Received: from mout-xforward.kundenserver.de (mout-xforward.kundenserver.de
	[212.227.17.5]) by ozlabs.org (Postfix) with ESMTP id 36C58DE0D8
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Jan 2009 05:12:28 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH v5] spi: Add PPC4xx SPI driver
Date: Mon, 5 Jan 2009 19:12:25 +0100
References: <1227628088-10849-1-git-send-email-sr@denx.de>
	<200812271130.12513.david-b@pacbell.net>
In-Reply-To: <200812271130.12513.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200901051912.25874.sr@denx.de>
Cc: linuxppc-dev@ozlabs.org, spi-devel-general@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Saturday 27 December 2008, David Brownell wrote:
> On Tuesday 25 November 2008, Stefan Roese wrote:
> > Changes in v5:
> > - Don't call setupxfer() from setup() so that the baudrate etc
> >   won't get changed while another transfer is active, as suggested
> >   by David Brownell.
>
> Better, but this still doesn't seem quite right:

David, thanks for the review. Please find some comments below.

> > +static int spi_ppc4xx_setupxfer(struct spi_device *spi, struct
> > spi_transfer *t) +{
> > +	struct ppc4xx_spi *hw = spi_master_get_devdata(spi->master);
> > +	struct spi_ppc4xx_cs *cs = spi->controller_state;
> > +	unsigned char cdm = 0;
> > +	int scr;
> > +	u8 bpw;
> > +
> > +	/* Write new configration */
> > +	out_8(&hw->regs->mode, cs->mode);
> > +
> > +	/*
> > +	 * Allow platform reduce the interrupt load on the CPU during SPI
> > +	 * transfers. We do not target maximum performance, but rather allow
> > +	 * platform to limit SPI bus frequency and interrupt rate.
>
> That comment doesn't seem even vaguely related to the
> code it allegedly refers to ... nothing in this routine
> affects the IRQ load.

IIRC (I didn't write the original version of this driver) then this comments 
simply refers to the fact that the platform can select a maximum SPI 
frequency via spi->max_speed_hz which is pretty obvious. So I'll just remove 
this comment in the next version.

> > +	 */
> > +	bpw = t ? t->bits_per_word : spi->bits_per_word;
> > +	cs->speed_hz = t ? min(t->speed_hz, spi->max_speed_hz) :
> > +		spi->max_speed_hz;
> > +
> > +	if (bpw != 8) {
> > +		dev_err(&spi->dev, "invalid bits-per-word (%d)\n", bpw);
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (cs->speed_hz == 0) {
> > +		dev_err(&spi->dev, "invalid speed_hz (must be non-zero)\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	/* set the clock */
> > +	/* opb_freq was already divided by 4 */
> > +	scr = (hw->opb_freq / cs->speed_hz) - 1;
> > +
> > +	if (scr > 0)
> > +		cdm = min(scr, 0xff);
> > +
> > +	dev_dbg(&spi->dev, "setting pre-scaler to %d (hz %d)\n", cdm,
> > +		cs->speed_hz);
> > +
> > +	if (in_8(&hw->regs->cdm) != cdm)
> > +		out_8(&hw->regs->cdm, cdm);
> > +
> > +	spin_lock(&hw->bitbang.lock);
> > +	if (!hw->bitbang.busy) {
> > +		hw->bitbang.chipselect(spi, BITBANG_CS_INACTIVE);
> > +		/* need to ndelay here? */
> > +	}
> > +	spin_unlock(&hw->bitbang.lock);
> > +
> > +	return 0;
> > +}
> > +
> > +static int spi_ppc4xx_setup(struct spi_device *spi)
> > +{
> > +	int ret;
> > +	struct spi_ppc4xx_cs *cs = spi->controller_state;
> > +	int init = 0;
> > +
> > +	if (!spi->bits_per_word)
> > +		spi->bits_per_word = 8;
>
> Given the above restrictions, it'd be better to
>
> 	if (spi->bits_per_word != 8)
> 		return -EINVAL;
>
> On the general policy of reporting such errors as near as
> practical to the place they appear ... otherwise it gets
> hard to track them down, since the faults get reported a
> long time later, well after the point drivers expect to see
> such reports.

OK, point gotten. Will change in next version.

> Likewise with spi->max_speed_hz. 

OK.

> > +
> > +	if (spi->mode & ~MODEBITS) {
> > +		dev_dbg(&spi->dev, "setup: unsupported mode bits %x\n",
> > +			spi->mode & ~MODEBITS);
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (cs == NULL) {
> > +		cs = kzalloc(sizeof *cs, GFP_KERNEL);
> > +		if (!cs)
> > +			return -ENOMEM;
> > +		spi->controller_state = cs;
> > +
> > +		/*
> > +		 * First time called, so let's init the SPI controller
> > +		 * at the end of this function
> > +		 */
> > +		init = 1;
> > +	}
> > +
> > +	/*
> > +	 * We set all bits of the SPI0_MODE register, so,
> > +	 * no need to read-modify-write
> > +	 */
> > +	cs->mode = SPI_PPC4XX_MODE_SPE;
> > +
> > +	switch (spi->mode & (SPI_CPHA | SPI_CPOL)) {
> > +	case SPI_MODE_0:
> > +		cs->mode |= SPI_CLK_MODE0;
> > +		break;
> > +	case SPI_MODE_1:
> > +		cs->mode |= SPI_CLK_MODE1;
> > +		break;
> > +	case SPI_MODE_2:
> > +		cs->mode |= SPI_CLK_MODE2;
> > +		break;
> > +	case SPI_MODE_3:
> > +		cs->mode |= SPI_CLK_MODE3;
> > +		break;
> > +	}
> > +
> > +	if (spi->mode & SPI_LSB_FIRST) {
> > +		/* this assumes that bit 7 is the LSb! */
> > +		cs->mode |= SPI_PPC4XX_MODE_RD;
>
> The Linux bit numbering convention is that BIT(0) is the LSB,
> so that comment is nonsensical.  BIT(7) will always bee the
> MSB of an 8-bit byte.
>
> If the issue is a PPC convention that BIT(0) is the MSB,
> then please adjust comments accordingly.  Or better, just
> strike the comment ... bit numbering is irrelevant here,
> the only requirement is that LSB_FIRST causes the LSB
> to be sent first, instead of the MSB.

OK, comment removed.

> > +	}
> > +
> > +	/*
> > +	 * New configuration (mode, speed etc) will be written to the
> > +	 * controller in spi_ppc4xx_setupxfer(). Only call
> > +	 * spi_ppc4xx_setupxfer() directly upon first initialization.
> > +	 */
> > +	if (init) {
> > +		ret = spi_ppc4xx_setupxfer(spi, NULL);
>
> Here it is, calling setupxfer()... despite one of the goals
> of the v5 patch being to *not* do that from spi_setup()!

It's only called upon first driver initialization (as the comment above 
explains).

> I suspect what you must intend here is to just force the
> slave to be deselected.  If so, then just call your
>
>    hw->bitbang.chipselect(spi, BITBANG_CS_INACTIVE);
>
> directly,

No, this doesn't work. I just tried it in my next driver version. Somehow the 
communication doesn't start up when setupxfer is not called at least once 
upon initialization. Sorry, but I worked on this driver quite some time ago 
and don't remember the details now.

> instead of letting setupxfer() trash register 
> state that may be controlling some active transfer.

As this call is done only upon first driver initialization, no active transfer 
can be interrupted. Or did I miss something here?

Please let me know if this approach is acceptable for now, or if I need to dig 
into this deeper. The problem is that I don't have the time for this now so 
further patch versions would come (much) later.

Otherwise I will send a new patch version with the fixes/changes mentioned 
above tomorrow.

Thanks.

Best regards,
Stefan
