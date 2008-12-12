Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id A0597DE0D7
	for <linuxppc-dev@ozlabs.org>; Sat, 13 Dec 2008 04:14:40 +1100 (EST)
Date: Fri, 12 Dec 2008 20:14:38 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: "Steven A. Falco" <sfalco@harris.com>
Subject: Re: [RFC] Dummy GPIO driver for use with SPI
Message-ID: <20081212171438.GA9738@oksana.dev.rtsoft.ru>
References: <4942738A.80609@harris.com>
	<20081212150144.GA28147@oksana.dev.rtsoft.ru>
	<49429861.9060305@harris.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <49429861.9060305@harris.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Dec 12, 2008 at 11:59:13AM -0500, Steven A. Falco wrote:
> Anton Vorontsov wrote:
> > On Fri, Dec 12, 2008 at 09:22:02AM -0500, Steven A. Falco wrote:
> >> This patch adds a dummy GPIO driver, which is useful for SPI devices
> >> that do not have a physical chip select.
> > 
> > Hm. Then you don't need a chip-select, and SPI driver must understand
> > this case. When SPI controller has no "gpios" property, it should just
> > ignore any chip-select toggling operations.
> > 
> > As an implementation example you can use this patch:
> > 
> > http://patchwork.ozlabs.org/patch/12499/
> > 
> > grep for "SPI w/o chip-select line."
> > 
> 
> My actual situation is a bit more complicated - serves me right for
> trying to simplify it in my RFC.
> 
> We have three devices on the SPI bus.  Two have well-behaved chip
> selects - they are ST flash memory devices.  The third device, the
> Atmel chip does not have a chip select.  It does have a RESET pin,
> which is similar to a chip select, but the Atmel protocol requires
> that that pin be low during the entire programming operation, and
> I cannot chain all the tx/rx operations together into one atomic 
> SPI transaction, so I cannot use that pin as the SPI chip select.
> 
> Instead, I manage the RESET pin outside of the SPI driver, and hence
> there is no chip select for that one device, so I use my dummy CS
> driver to provide a fake chip select to satisfy the SPI driver.
> 
> This does have the limitation that I must be careful not to access
> the flash parts at the same time as I access the Atmel, but that is
> ok for my application.  I guess I could use something like your
> patch, but I'd maybe have to extend the flags to include a "do not
> use" bit, which would bypass the gpio_is_valid and gpio_request
> calls.
> 
> What do you think about having a mechanism to specify that some
> SPI slaves have a chip select, while others don't have to have a
> chip select managed by the SPI subsystem?

Um.. do you know that you can pass '0' as a GPIO?

For example,

spi-controller {
	gpios = <&pio1 1 0	/* cs0 */
		 0		/* cs1, no GPIO */
		 &pio2 2 0>;	/* cs2 */

	device@0 {
		reg = <0>; /* spi device, cs 0: "&pio1 1 0" */
	}

	device@1 {
		reg = <1>; /* spi device, cs 1: no actual GPIO */
	}

	device@2 {
		reg = <2>; /* spi device, cs 2: "&pio2 2 0" */
	}
};

With this patch
http://patchwork.ozlabs.org/patch/12450/

of_get_gpio() will differentiate "end of gpios" and "no gpio" cases.
So, in the SPI driver you can do something like this:

count = of_gpio_count(np);
for (i = 0; i < count; i++) {
	int gpio;

	gpio = of_get_gpio(np, i);
	if (gpio_is_valid(gpio)) {
		normal case;
	} else if (gpio == -EEXIST) {
		the special case;
	} else {
		error;
	}
}

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
