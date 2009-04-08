Return-Path: <jacmet@gmail.com>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.28])
	by ozlabs.org (Postfix) with ESMTP id 37660DDF7C
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Apr 2009 19:18:55 +1000 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so7393yxg.39
	for <linuxppc-dev@ozlabs.org>; Wed, 08 Apr 2009 02:18:49 -0700 (PDT)
Sender: Peter Korsgaard <jacmet@gmail.com>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 6/6] powerpc/fsl_soc: Isolate legacy fsl_spi support to
	mpc832x_rdb boards
References: <20090123195041.GF21237@oksana.dev.rtsoft.ru>
	<20090123194958.GA17355@oksana.dev.rtsoft.ru>
From: Peter Korsgaard <jacmet@sunsite.dk>
Date: Wed, 08 Apr 2009 11:18:43 +0200
In-Reply-To: <20090318200048.GD8182@oksana.dev.rtsoft.ru> (Anton Vorontsov's
	message of "Wed\, 18 Mar 2009 23\:00\:48 +0300")
Message-ID: <87bpr71p1o.fsf_-_@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: spi-devel-general@lists.sourceforge.net,
	Andrew Morton <akpm@linux-foundation.org>,
	David Brownell <dbrownell@users.sourceforge.net>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>>> "Anton" == Anton Vorontsov <avorontsov@ru.mvista.com> writes:

Hi,

 Anton> The advantages of this:
 Anton> - Don't encourage legacy support;
 Anton> - Less external symbols, less code to compile-in for !MPC832x_RDB
 Anton>   platforms.

It's nice with your cleanups, but I wonder how to handle more
complicated chip select handling than simply toggling a single gpio.

I have a board (or 2 actually, but they are similar in this regard)
with a mpc8347 using SPI to a number of addon boards. For signal
integrity reasons the SPI signals are routed to a MUX, so the chip
select logic has to set the MUX in addition to controlling the CS line
of the device.

I've been using code like this since late 2007, but this patch
ofcourse breaks it:

static void thinx_spi_activate_cs(u8 cs, u8 polarity)
{
	static u8 old_cs = 255;

	if (cs != old_cs) {
		/* mux setup (cs 2:1)*/
		gpio_set_value(gpio1 + GPIO_SPI_MUX_NOE, 1);
		gpio_set_value(gpio1 + GPIO_SPI_MUX_SEL0, cs&2);
		gpio_set_value(gpio1 + GPIO_SPI_MUX_SEL1, cs&4);
		gpio_set_value(gpio1 + GPIO_SPI_MUX_NOE, 0);
		old_cs = cs;
	}

	switch (cs) {
	case 0: gpio_set_value(gpio1 + GPIO_SPI_CS_BKL1, polarity); break;
	case 1: gpio_set_value(gpio1 + GPIO_SPI_CS_BKL2, polarity); break;
	case 2: gpio_set_value(gpio1 + GPIO_SPI_CS_OPT1, polarity); break;
	case 3: gpio_set_value(gpio1 + GPIO_SPI_CS_OPT2, polarity); break;
	}
}

static void thinx_spi_deactivate_cs(u8 cs, u8 polarity)
{
	switch (cs) {
	case 0: gpio_set_value(gpio1 + GPIO_SPI_CS_BKL1, !polarity); break;
	case 1: gpio_set_value(gpio1 + GPIO_SPI_CS_BKL2, !polarity); break;
	case 2: gpio_set_value(gpio1 + GPIO_SPI_CS_OPT1, !polarity); break;
	case 3: gpio_set_value(gpio1 + GPIO_SPI_CS_OPT2, !polarity); break;
	}
}

static __init int thinx_spi_init(void)
{
	struct device_node *np;
	struct of_gpio_chip *gc;
	static const int gpios[] = {
		GPIO_SPI_CS_BKL1,
		GPIO_SPI_CS_BKL2,
		GPIO_SPI_CS_OPT1,
		GPIO_SPI_CS_OPT2,
		GPIO_SPI_MUX_NOE,
		GPIO_SPI_MUX_SEL0,
		GPIO_SPI_MUX_SEL1
	};
	int i;

	np = of_find_node_by_name(NULL, "gpio-controller");
	if (!np || !np->data) {
		printk(KERN_ERR
		       "gpio1 node not found or controller not registerred\n");
		return -ENODEV;
	}
	gc = np->data;
	gpio1 = gc->gc.base;

	for (i=0; i<ARRAY_SIZE(gpios); i++) {
		gpio_request(gpio1 + gpios[i], "spi");
		gpio_direction_output(gpio1 + gpios[i], 1);
	}

	fsl_spi_init(thinx_spi_boardinfo, ARRAY_SIZE(thinx_spi_boardinfo),
		     thinx_spi_activate_cs, thinx_spi_deactivate_cs);

	return 0;
}

Now, I don't quite see how to handle this with the new OF bindings -
Any ideas?

-- 
Bye, Peter Korsgaard
