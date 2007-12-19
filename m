Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id A6060DDDF0
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Dec 2007 00:03:45 +1100 (EST)
Date: Wed, 19 Dec 2007 16:05:59 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] [POWERPC][RFC] MPC8360E-RDK: Device tree and board file
Message-ID: <20071219130559.GA7846@localhost.localdomain>
References: <20071210202934.GA32046@localhost.localdomain>
	<10D5CABD-442B-44DF-83D7-7FED5CD150E3@kernel.crashing.org>
	<20071215162331.GA24999@localhost.localdomain>
	<20071217051403.GB3477@localhost.localdomain>
	<20071217170303.GA4303@loki.buserror.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20071217170303.GA4303@loki.buserror.net>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Dec 17, 2007 at 11:03:04AM -0600, Scott Wood wrote:
> On Mon, Dec 17, 2007 at 04:14:03PM +1100, David Gibson wrote:
[...]
> > > +		ranges = <0 0xe0100000 0x00100000>;
> > > +		reg = <0xe0100000 0x480>;
> > > +		/* filled by u-boot */
> > > +		brg-frequency = <0>;
> > > +		bus-frequency = <0>;
> > 
> > This should probably be clock-frequency, not bus-frequency.  After
> > all, it's a bus node, what other sort of frequency would it be.
> 
> Actually, it should probably be dropped altogether.

No, we can't drop it. We can replace it by clock-frequency, but
not just drop it, because bus frequency used by at least one driver --
spi_mpc83xx, to calculate proper clocks prescaling value.

As for renaming this property... well, I can rename it, but
bus-frequency is so widely used: bootloaders are depending on this
property, so we'll have to leave "legacy" code in linux to find
legacy properties... thus RDK will by just some kind of white crow
among others (at first).

Do we really want to rename it after all? It's not a problem per se,
just want to hear some consensus.

> 
> > > +		muram@10000 {
> > > +			device_type = "muram";
> > 
> > And this device_type needs to go, too.
> 
> Yes, replace it with compatible = "fsl,cpm-muram".

cpm? This is QE. I'll name it fsl,qe-muram. If you think it
is fully compatible with cpm, then I'd better add
"fsl,qe-muram", "fsl,cpm-muram".

> > > +			ranges = <0 0x00010000 0x0000c000>;
> > > +
> > > +			data-only@0 {
> > > +				reg = <0 0xc000>;
> 
> compatible = "fsl,cpm-muram-data".

ditto.


Thanks,

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
