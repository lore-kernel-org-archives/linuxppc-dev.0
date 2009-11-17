Return-Path: <to-fleischer@t-online.de>
Received: from mailout09.t-online.de (mailout09.t-online.de [194.25.134.84])
	by ozlabs.org (Postfix) with ESMTP id 69DC8B6EF4
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 18 Nov 2009 10:27:48 +1100 (EST)
From: Torsten Fleischer <to-fleischer@t-online.de>
To: avorontsov@ru.mvista.com
Subject: Re: spi_mpc8xxx.c: chip select polarity problem
Date: Tue, 17 Nov 2009 21:09:28 +0100
References: <200911161742.46663.to-fleischer@t-online.de>
	<20091116171037.GA26163@oksana.dev.rtsoft.ru>
	<20091116180008.GA6748@oksana.dev.rtsoft.ru>
In-Reply-To: <20091116180008.GA6748@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <200911172109.28841.to-fleischer@t-online.de>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Nov 16, 2009 at 19:00PM, Anton Vorontsov wrote:
[...]
> > So it might be better to fix up initial value in the platform code?
> 
> Oh, we actually cannot, because the driver calls
> gpio_direction_output().
> 
> And since we don't know the mode prior to SPI device's driver
> probe() finished, we'll have to set up an initial state in the
> first SPI transfer. I.e. something like this:

In most cases the device drivers perform SPI transfers already in their 
probe() function. How can it be ensured that the CS of all other devices are 
inactive even if they are not initialized at that time?

Regards
Torsten Fleischer
