Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 258BB1007DE
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 18 Nov 2009 10:28:27 +1100 (EST)
Date: Wed, 18 Nov 2009 02:28:23 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Torsten Fleischer <to-fleischer@t-online.de>
Subject: Re: spi_mpc8xxx.c: chip select polarity problem
Message-ID: <20091117232823.GA19058@oksana.dev.rtsoft.ru>
References: <200911161742.46663.to-fleischer@t-online.de>
	<20091116171037.GA26163@oksana.dev.rtsoft.ru>
	<20091116180008.GA6748@oksana.dev.rtsoft.ru>
	<200911172109.28841.to-fleischer@t-online.de>
	<20091117202211.GB27574@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20091117202211.GB27574@oksana.dev.rtsoft.ru>
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

On Tue, Nov 17, 2009 at 11:22:11PM +0300, Anton Vorontsov wrote:
> On Tue, Nov 17, 2009 at 09:09:28PM +0100, Torsten Fleischer wrote:
> > On Mon, Nov 16, 2009 at 19:00PM, Anton Vorontsov wrote:
> > [...]
> > > > So it might be better to fix up initial value in the platform code?
> > > 
> > > Oh, we actually cannot, because the driver calls
> > > gpio_direction_output().
> > > 
> > > And since we don't know the mode prior to SPI device's driver
> > > probe() finished, we'll have to set up an initial state in the
> > > first SPI transfer. I.e. something like this:
> > 
> > In most cases the device drivers perform SPI transfers already in their 
> > probe() function. How can it be ensured that the CS of all other devices are 
> > inactive even if they are not initialized at that time?
> 
> Good question. Oh, well... then we have to use spi-cs-high,
> no matter that it is a duplication of the 'compatible' property.
> SPI bus drivers don't know all the devices and their CS level,
> and so spi-cs-high is the only way to tell that information. :-(

Oh. On the other hand, we can postpone the gpio_direction_output()
call, and still require that the platform code (or firmware)
should be responsible for setting a sane default values on the
chip selects.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
