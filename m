Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 0B7351007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 19 Nov 2009 10:29:25 +1100 (EST)
Date: Thu, 19 Nov 2009 02:29:20 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Torsten Fleischer <to-fleischer@t-online.de>
Subject: Re: spi_mpc8xxx.c: chip select polarity problem
Message-ID: <20091118232920.GA24307@oksana.dev.rtsoft.ru>
References: <200911161742.46663.to-fleischer@t-online.de>
	<20091117202211.GB27574@oksana.dev.rtsoft.ru>
	<20091117232823.GA19058@oksana.dev.rtsoft.ru>
	<200911181720.06390.to-fleischer@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <200911181720.06390.to-fleischer@t-online.de>
Cc: linuxppc-dev@lists.ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Nov 18, 2009 at 05:20:06PM +0100, Torsten Fleischer wrote:
[...]
> > Oh. On the other hand, we can postpone the gpio_direction_output()
> > call, and still require that the platform code (or firmware)
> > should be responsible for setting a sane default values on the
> > chip selects.
> > 
> 
> How about that?

Looks great, thanks!

Few minor issues below.

> diff -u -r -N linux-2.6.31.6_orig//drivers/spi/spi_mpc8xxx.c linux-2.6.31.6/drivers/spi/spi_mpc8xxx.c
> --- linux-2.6.31.6_orig//drivers/spi/spi_mpc8xxx.c	2009-11-10 01:32:31.000000000 +0100
> +++ linux-2.6.31.6/drivers/spi/spi_mpc8xxx.c	2009-11-18 10:47:06.000000000 +0100
> @@ -114,6 +114,7 @@
>  	u32 rx_shift;		/* RX data reg shift when in qe mode */
>  	u32 tx_shift;		/* TX data reg shift when in qe mode */
>  	u32 hw_mode;		/* Holds HW mode register settings */
> +	int initialized;
>  };
>  
>  static inline void mpc8xxx_spi_write_reg(__be32 __iomem *reg, u32 val)
> @@ -437,6 +438,7 @@
>  		cs = kzalloc(sizeof *cs, GFP_KERNEL);
>  		if (!cs)
>  			return -ENOMEM;
> +		cs->initialized = 0;

No need for this, we allocated cs with kzalloc, which zeroes
the memory anyway.

>  		spi->controller_state = cs;
>  	}
>  	mpc8xxx_spi = spi_master_get_devdata(spi->master);
> @@ -503,15 +505,25 @@
>  
>  	return ret;
>  }
> +
> +static void mpc8xxx_spi_cs_init(struct spi_device *spi);
> +
> +

Whenever possible, please avoid forward declarations.

>  static int mpc8xxx_spi_transfer(struct spi_device *spi,
>  				struct spi_message *m)
>  {
>  	struct mpc8xxx_spi *mpc8xxx_spi = spi_master_get_devdata(spi->master);
> +	struct spi_mpc8xxx_cs *cs = spi->controller_state;
>  	unsigned long flags;
>  
>  	m->actual_length = 0;
>  	m->status = -EINPROGRESS;
>  
> +	if (cs && !cs->initialized) {
> +		mpc8xxx_spi_cs_init(spi);
> +		cs->initialized = 1;
> +	}
> +
>  	spin_lock_irqsave(&mpc8xxx_spi->lock, flags);
>  	list_add_tail(&m->queue, &mpc8xxx_spi->queue);
>  	queue_work(mpc8xxx_spi->workqueue, &mpc8xxx_spi->work);
> @@ -671,6 +683,17 @@
>  	gpio_set_value(gpio, on ^ alow);
>  }
>  
> +static void mpc8xxx_spi_cs_init(struct spi_device *spi)
> +{
> +	struct device *dev = spi->dev.parent;
> +	struct mpc8xxx_spi_probe_info *pinfo = to_of_pinfo(dev->platform_data);
> +	u16 cs = spi->chip_select;
> +	int gpio = pinfo->gpios[cs];
> +	bool on = (pinfo->alow_flags[cs] ^ !(spi->mode & SPI_CS_HIGH));

The outermost parenthesis aren't needed.

> +
> +	gpio_direction_output(gpio, on);

gpio_direction_output() may fail, so spi_cs_init too.

I'd write it as 'return gpio_direction_outpit(..)', and in
mpc8xxx_spi_transfer something like this:

	if (cs && !cs->initialized) {
		int ret;

		ret = mpc8xxx_spi_cs_init(spi);
		if (ret) {
			dev_dbg(&spi->dev, "cs_init failed: %d\n", ret);
			return ret;
		}
		cs->initialized = 1;
	}


Thanks!

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
