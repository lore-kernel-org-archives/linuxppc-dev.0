Return-Path: <cbouatmailru@gmail.com>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51]) by ozlabs.org (Postfix) with ESMTP id 5F2B4B7174
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  3 Sep 2010 00:01:55 +1000 (EST)
Received: by ewy21 with SMTP id 21so243010ewy.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 02 Sep 2010 07:01:53 -0700 (PDT)
Date: Thu, 2 Sep 2010 18:01:47 +0400
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: Sergei Poselenov <sposelenov@emcraft.com>
Subject: Re: [PATCH 1/2] [PPC] Motion-PRO: Added LED support for the
	Promess Motion-Pro board. The driver is based on the original
	version(http://www.mail-archive.com/linuxppc-dev@lists.ozlabs.org/msg06694.html),
	adapted for the current kernel structures.
Message-ID: <20100902140147.GA4245@oksana.dev.rtsoft.ru>
References: <1283422832-9620-1-git-send-email-sposelenov@emcraft.com>
	<20100902124617.GA27957@oksana.dev.rtsoft.ru>
	<20100902173456.3fdef6b8@emcraft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20100902173456.3fdef6b8@emcraft.com>
Cc: linuxppc-dev@lists.ozlabs.org, wd@denx.de, dzu@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 02, 2010 at 05:34:56PM +0400, Sergei Poselenov wrote:
[...]
> > > +	tristate "Motionpro LEDs Support"
> > > +	depends on LEDS_CLASS
> > > +	help
> > > +	  This option enables support for status and ready LEDs
> > > connected
> > > +	  to GPIO lines on Motionpro board.
> > 
> > Why not expose these GPIOs via GPIOLIB[1] and use generic GPIO
> > LEDs[2] driver, along with the timer LED trigger[3] for blinking?
> > 
> > Thanks,
> > 
> > [1] Documentation/gpio.txt
> >     Documentation/powerpc/dts-bindings/gpio/gpio.txt
> > [2] drivers/leds/leds-gpio.c
> >     Documentation/powerpc/dts-bindings/gpio/led.txt
> > [3] drivers/leds/ledtrig-timer.c
> > 
> 
> Yes, this seem possible to implement (and thanks for pointing into
> this), however, the driver is already exists (actually, since 2007),
> so why to not add it to save efforts?

- Faking PWM in the LEDs driver is just wrong thing to do.
  I don't see any other drivers doing this, and even if they
  were, they would need to be fixed;

- This duplicates timer trigger functionality;

- By writing (if there isn't any already) a generic GPIOLIB
  driver for the GPIO controller that you have, you could use
  these GPIOs not only for LEDs, but also for SPI, MDIO, I2C,
  MMC, and even raw NAND chips.

  I.e., by choosing the right methodology you save much more
  efforts in the long run.

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
