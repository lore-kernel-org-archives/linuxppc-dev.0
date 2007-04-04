Return-Path: <SRS0+5a975b97460a6157554b+1319+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D48D2DDE1C
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Apr 2007 16:04:35 +1000 (EST)
Subject: Re: [PATCH] Stop pmac_zilog from abusing 8250's device numbers.
From: David Woodhouse <dwmw2@infradead.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17939.15726.114059.679277@cargo.ozlabs.ibm.com>
References: <1175610345.2665.15.camel@shinybook.infradead.org>
	<17938.57292.870224.132415@cargo.ozlabs.ibm.com>
	<1175642916.10567.24.camel@shinybook.infradead.org>
	<20070403212928.GA12951@cynthia.pants.nu>
	<20070404022544.59b022a6@the-village.bc.nu>
	<17939.10130.687893.167511@cargo.ozlabs.ibm.com>
	<1175663999.2932.8.camel@shinybook.infradead.org>
	<17939.15726.114059.679277@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Wed, 04 Apr 2007 02:03:54 -0400
Message-Id: <1175666635.2932.17.camel@shinybook.infradead.org>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-04-04 at 15:53 +1000, Paul Mackerras wrote:
> David Woodhouse writes:
> 
> > Why? What's so special about the name 'ttyS'?
> 
> It's the name that users of Linux expect built-in serial ports to have.

Not really. The norm under Linux is for non-8250 ports to use
properly-registered device numbers and names. There's not many which are
still broken in this respect -- it's basically pmac_zilog and some Sun
UARTs, isn't it?

And even if it _were_ true, it wouldn't be a particularly good reason
for changing the way we handle serial ports under Linux.

> > > The built-in ports can generally be enumerated early on boot in a
> > > stable order, and they should be assigned the low ttySn numbers,
> > > regardless of what chip is used to implement them. 
> > 
> > I don't see why that 'should' be the case. Certainly it _isn't_ the case
> > on most supported platforms -- we have separate device numbers, and
> > names, for most types of ports. There's only one or two drivers which
> > abuse ttySn for anything other than 8250 ports.
>
> It 'should' be the case because that is what is easiest for users and
> makes most sense from a user's point of view.

I really don't buy that argument. People cope perfectly well
with /dev/ttySA0 on StrongARM, with /dev/ttySC0 on SH, etc. If it isn't
an 8250, it doesn't usually get called ttyS0. There's certainly nothing
_easier_ about ttyS0. Unless it's really an effort to type that extra
character :)

> You still haven't given any reason why a user should have to know or
> care whether the built-in serial ports on his/her computer are
> implemented with a 16C550 chip or a Z85C30 chip or something else.

Because that's the way serial ports are named under Linux. If you want
to change that, then take it up with the serial maintainer -- but
pmac_zilog as it is upstream at the moment is just _broken_. The module
just doesn't load if you have 8250 built in or loaded. That's what you
get when you abuse device numbers belonging to another driver.

> In any case your patch is a user-visible incompatible API change and
> will break existing working setups, so it should only be put in after
> suitable warning has been given.  Maybe we need a module parameter to
> select between the old and new behaviour to ease the transition.

Perhaps that's true; I'd certainly never seen a working setup with
pmac_zilog, because I'd never actually seen the module load. It's always
failed for me, because I have 8250 support built in to my kernels.

-- 
dwmw2
