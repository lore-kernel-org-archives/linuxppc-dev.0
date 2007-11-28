Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id A8143DDE3F
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Nov 2007 02:44:19 +1100 (EST)
Date: Wed, 28 Nov 2007 18:49:04 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/3] [libata] pata_of_platform: OF-Platform PATA device
	driver
Message-ID: <20071128154904.GA20722@localhost.localdomain>
References: <20071127153708.GA12490@localhost.localdomain>
	<20071127153908.GB14183@localhost.localdomain>
	<20071127212222.GB10829@lixom.net>
	<200711272233.00456.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <200711272233.00456.arnd@arndb.de>
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org,
	linux-ide@vger.kernel.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Nov 27, 2007 at 10:32:58PM +0100, Arnd Bergmann wrote:
> On Tuesday 27 November 2007, Olof Johansson wrote:
> > On Tue, Nov 27, 2007 at 06:39:08PM +0300, Anton Vorontsov wrote:
> > > This driver nicely wraps around pata_platform library functions,
> > > and provides OF platform bus bindings to the PATA devices.
> > 
> > > +static struct of_device_id pata_of_platform_match[] = {
> > > +     { .compatible = "pata-platform", },
> > > +};
> > 
> > "pata-platform" really means nothing outside of linux. A more
> > generic label would be useful.

Agreed.

> Maybe the name of the standards it supports? Could be
> "ata-4", "ata-5" and the like, or the exact transfer mode, like
> "pata-udma-5", "pata-pio-3", "sata-150", etc.

You're quite optimistic about pata_platform capabilities. ;-)

As far as I know it is [obviously] supports PIO modes only. And so
far I was able to get max 5.28 MB/s read transfers. Which looks like
ideal case for PIO1 (CF I'm testing on is 3.0, max. PIO4).

I've modified pio_mask appropriately, plus I've tried to comment
out .set_mode = pata_platform_set_mode, and now it says:

ata5: PATA max PIO4 mmio cmd 0xf0000000 ctl 0xf000020c irq 24
ata5.00: CFA: TOSHIBA THNCF512MQG, 3.00, max PIO4
ata5.00: configured for PIO4
ata5.00: configured for PIO4

That looks good, but speed is the same. Oh well, it's another
matter.


Back to dts, I think pata-pio-X is good scheme. That way we can
pass pio_mask via device tree. Sounds reasonable?

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
