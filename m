Return-Path: <to-fleischer@t-online.de>
Received: from mailout08.t-online.de (mailout08.t-online.de [194.25.134.20])
	by ozlabs.org (Postfix) with ESMTP id 1BD481007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 27 Nov 2009 04:38:34 +1100 (EST)
From: Torsten Fleischer <to-fleischer@t-online.de>
To: avorontsov@ru.mvista.com
Subject: Re: spi_mpc8xxx.c: chip select polarity problem
Date: Thu, 26 Nov 2009 18:27:38 +0100
References: <200911161742.46663.to-fleischer@t-online.de>
	<fa686aa40911251411t13dd0131od6b497399641ce3d@mail.gmail.com>
	<20091126121204.GA3558@oksana.dev.rtsoft.ru>
In-Reply-To: <20091126121204.GA3558@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <200911261827.38405.to-fleischer@t-online.de>
Cc: spi-devel-general@lists.sourceforge.net, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Nov 26, 2009 at 13:12:04 Anton Vorontsov wrote:
[...]
> > Ah.  I understand what you're doing now.   Hmmm.  This approach
> > concerns me because it relies on firmware or platform code to get CS
> > gpios set up properly before the driver is probed.
> 
> Yes, that was said at the very beginning of this thread.
> 
> >  Firmware doesn't
> > always get it right, and I prefer to avoid platform specific setups as
> > much as possible.  Why can't the CS polarity be encoded into the
> > device tree so the driver *does* have the polarity data at probe time?
> 
> We have the spi-cs-high property, but it duplicates compatible
> property. 'compatible' is enough to tell whether some device has
> cs-high or cs-low (device's driver knows that already).
> 
> The problem is that SPI bus master doesn't know all the devices,
> so it can't extract that information from the compatible string.
> To workaround that we can use 'spi-cs-high', but that's ugly
> workaround.
> 
> SPI modes (0,1,2,3) is another matter, some devices can work in
> several modes, so 'spi-cpol' and 'spi-cpha' are actually useful.
> 
To get a sane initial state the needed GPIOs can be set to be inputs during 
the driver's initialization.
This requires pull-up/pull-down resistors connected to the chip select 
lines. I think we can assume that they exist, because the GPIOs are all inputs 
after the controller's hardware reset and the resistors are needed to have a 
well-defined voltage level on the chip select lines. Normally the level is set 
so that the devices are disabled.

Therefore, it doesn't matter if the firmware sets the GPIOs wrong.
