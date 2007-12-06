Return-Path: <geert@linux-m68k.org>
Received: from vervifontaine.sonycom.com (vervifontaine.sonytel.be
	[80.88.33.193]) by ozlabs.org (Postfix) with ESMTP id 2420EDE988
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Dec 2007 19:13:15 +1100 (EST)
Date: Thu, 6 Dec 2007 09:13:04 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
Sender: geert@sonytel.be
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] pci: Fix bus resource assignment on 32 bits with 64b
	resources
In-Reply-To: <1196927934.7033.39.camel@pasglop>
Message-ID: <Pine.LNX.4.62.0712060910160.9929@pademelon.sonytel.be>
References: <20071205064116.D849BDE10A@ozlabs.org>
	<1196911347.7033.15.camel@pasglop>
	<20071206063940.GA16474@kroah.com> <1196927934.7033.39.camel@pasglop>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Greg KH <greg@kroah.com>, linux-pci@atrey.karlin.mff.cuni.cz,
	Linux Kernel Development <linux-kernel@vger.kernel.org>,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 6 Dec 2007, Benjamin Herrenschmidt wrote:
> On Wed, 2007-12-05 at 22:39 -0800, Greg KH wrote:
> > > that is  it can be either unsigned int, unsigned long or unsigned
> > long
> > > long... and we have no way to reliably printk that.
> > 
> > We do this already just fine.  Take a look in the kernel, I think we
> > just always cast it to long long to be uniform.
> 
> I wanted to avoid that for two reasons:
> 
>  - casts are fugly
>  - it adds support code to cast & handle 64 bits to 32 bits platforms
>    that wouldn't normally need it

Indeed. I still have a few places to fix it up in the Zorro bus code and
drivers. Everything is 32 bit, but allyesconfig sets CONFIG_RESOURCES_64BIT...
In some way I liked the recent suggestion to make CONFIG_RESOURCES_64BIT
depend on something...

> Now, if you really think that's the way to go, I'll respin with casts
> (I've used cast in subsequent patches merging bits & pieces of the
> powerpc 32 and 64 bits PCI code too in fact).

And casting to `unsigned long' for Zorro bus may sound fine, except what if
one day we'll need 64-bit resources for one platform?

> I was just hoping somebody had a better idea, like a way to add a new
> format specifier to printk without losing gcc type checking :-)

#define PRI* (...) ;-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
