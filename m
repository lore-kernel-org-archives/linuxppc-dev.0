Return-Path: <cbou@mail.ru>
Received: from mx4.mail.ru (fallback.mail.ru [194.67.57.14])
	by ozlabs.org (Postfix) with ESMTP id E86BEDDDEF
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Nov 2007 13:33:05 +1100 (EST)
Received: from mx34.mail.ru (mx34.mail.ru [194.67.23.200])
	by mx4.mail.ru (mPOP.Fallback_MX) with ESMTP id 4590410A9F97
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Nov 2007 04:06:07 +0300 (MSK)
Date: Thu, 29 Nov 2007 03:54:40 +0300
From: Anton Vorontsov <cbou@mail.ru>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 2/3] [libata] pata_of_platform: OF-Platform PATA device
	driver
Message-ID: <20071129005440.GA2235@zarina>
References: <20071127153708.GA12490@localhost.localdomain>
	<20071127153908.GB14183@localhost.localdomain>
	<20071127212222.GB10829@lixom.net>
	<200711272233.00456.arnd@arndb.de>
	<20071128154904.GA20722@localhost.localdomain>
	<474D9327.9020305@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <474D9327.9020305@ru.mvista.com>
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org,
	Arnd Bergmann <arnd@arndb.de>, linux-ide@vger.kernel.org
Reply-To: cbou@mail.ru
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Nov 28, 2007 at 07:11:19PM +0300, Sergei Shtylyov wrote:
> Anton Vorontsov wrote:
> 
> >>>>This driver nicely wraps around pata_platform library functions,
> >>>>and provides OF platform bus bindings to the PATA devices.
> 
> >>>>+static struct of_device_id pata_of_platform_match[] = {
> >>>>+     { .compatible = "pata-platform", },
> >>>>+};
> 
> >>>"pata-platform" really means nothing outside of linux. A more
> >>>generic label would be useful.
> 
> > Agreed.
> 
>     Now you're quick to agree. :-)

I'm quick to change my mind either. ;-)

*BOOM*, I changed my mind.

> >>Maybe the name of the standards it supports? Could be
> >>"ata-4", "ata-5" and the like, or the exact transfer mode, like
> >>"pata-udma-5", "pata-pio-3", "sata-150", etc.
> 
> > You're quite optimistic about pata_platform capabilities. ;-)
> 
>     Indeed. :-)
> 
> > As far as I know it is [obviously] supports PIO modes only. And so
> > far I was able to get max 5.28 MB/s read transfers. Which looks like
> > ideal case for PIO1 (CF I'm testing on is 3.0, max. PIO4).
> 
>     Believe me, it's a great speed even for PIO4. Most systems only show 3+ 
> MiB/s in this mode according to hdparm.
> 
> > I've modified pio_mask appropriately, plus I've tried to comment
> > out .set_mode = pata_platform_set_mode, and now it says:
> 
> > ata5: PATA max PIO4 mmio cmd 0xf0000000 ctl 0xf000020c irq 24
> > ata5.00: CFA: TOSHIBA THNCF512MQG, 3.00, max PIO4
> > ata5.00: configured for PIO4
> > ata5.00: configured for PIO4
> 
> > That looks good, but speed is the same. Oh well, it's another
> > matter.
> 
> > Back to dts, I think pata-pio-X is good scheme. That way we can
> > pass pio_mask via device tree. Sounds reasonable?
> 
>     Grumble. Can't we pass this via some property other than "compatible"? I'm 
> opposed to "ata-5" and the like in there as well cause it's not clear what 
> information this would provide. Why people so love to make things complex WRT 
> the "compatible" property -- instead of making the task of selecting a proper 
> driver more simple, they tend to make it mode complex by trying to specify 
> values that have quite little to do with the device's programming interface 
> itself...

Ok, now I'm agree here. dts already specifying "fsl,mpc8349emitx-pata",
second compatible entry is okay to mean nothing outside Linux itself,
there are plenty of examples for such kind.

Remaining question: any preferred name for that property? pio-mode okay?
It's assuming that PIO6 capable bus supports PIO0 as well, thus no mask.

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
