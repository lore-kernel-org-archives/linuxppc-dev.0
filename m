Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id CD925DE60F
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jul 2008 00:23:57 +1000 (EST)
Date: Tue, 15 Jul 2008 18:23:54 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Richard Purdie <rpurdie@rpsys.net>
Subject: Re: [PATCH v2] leds: implement OpenFirmare GPIO LED driver
Message-ID: <20080715142354.GA3296@polina.dev.rtsoft.ru>
References: <20080715123822.GA10893@polina.dev.rtsoft.ru>
	<20080715124013.GA13086@polina.dev.rtsoft.ru>
	<1216126470.5345.55.camel@dax.rpnet.com>
	<20080715132438.GA26648@polina.dev.rtsoft.ru>
	<1216128687.5345.61.camel@dax.rpnet.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <1216128687.5345.61.camel@dax.rpnet.com>
Cc: linuxppc-dev@ozlabs.org, Stephen Rothwell <sfr@canb.auug.org.au>,
	linux-kernel@vger.kernel.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jul 15, 2008 at 02:31:27PM +0100, Richard Purdie wrote:
> On Tue, 2008-07-15 at 17:24 +0400, Anton Vorontsov wrote:
> > On Tue, Jul 15, 2008 at 01:54:30PM +0100, Richard Purdie wrote:
> > > I don't have any issue with the driver itself, just the name which is
> > > going to confuse people no end.
> > > 
> > > Can we come up with a better name for this driver please?
> [...]
> > > "openfirmware-led"?
> > 
> > And this would be wrong, since this driver is for GPIO LEDs only, not
> > for all LEDs that OF can describe. In future there could be OF PWM LEDs
> > or something like this.
> 
> Ok, will these be a separate driver or combined into the gpio driver?

I believe this must be a separate driver. The two drivers would have
nothing in common except prologue registration stuff.

> > > I'm mainly concerned with the more user visible bits like the name of
> > > the .c file, the wording of the Kconfig option and the module
> > > description. We need to play down the GPIO bit and play up the
> > > openfirmware bindings bit.
> > 
> > Hm... file name is leds-of-gpio.c, how could I play up the "of" bit more
> > than this? ;-)
> 
> Spell out openfirmware :). I initially had no idea "of == openfirmware"
> and I suspect others won't either...

This would be unusually long name, that is

$ find . -iname '*openfirmware*' | wc -l
0

And in contrast:

drivers/video/offb.c
drivers/video/nvidia/nv_of.c
drivers/usb/host/ohci-ppc-of.c
drivers/usb/host/ehci-ppc-of.c
drivers/serial/of_serial.c
drivers/mtd/maps/physmap_of.c
...

So, I think we should stick with the "of" for consistency, while
confused users may consult with Kconfig for disambiguation.

But if you really want the expanded name.. just repeat it, and I'll
change the name.

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
