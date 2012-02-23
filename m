Return-Path: <linux+linuxppc-dev=lists.ozlabs.org@arm.linux.org.uk>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
 [IPv6:2002:4e20:1eda::1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 10418B6FD8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Feb 2012 07:25:53 +1100 (EST)
Date: Thu, 23 Feb 2012 20:25:34 +0000
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: in_be32() etc
Message-ID: <20120223202534.GE22562@n2100.arm.linux.org.uk>
References: <20120223112915.GT22562@n2100.arm.linux.org.uk>
 <1330028339.20389.28.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1330028339.20389.28.camel@pasglop>
Sender: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Feb 24, 2012 at 07:18:59AM +1100, Benjamin Herrenschmidt wrote:
> On Thu, 2012-02-23 at 11:29 +0000, Russell King - ARM Linux wrote:
> > What's this stuff doing in generic drivers?
> 
> Well, I suppose that's because the xilinx stuff used to be ppc
> only ? :-)

Note that's just the first one grep turned up.  I've no idea which specific
drivers the ST SPEAr people are wanting these accessors for (they didn't
include that information in their submission adding them to ARM.)

> > See drivers/gpio/gpio-xilinx.c:
> > static int xgpio_get(struct gpio_chip *gc, unsigned int gpio)
> > {
> >         struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
> > 
> >         return (in_be32(mm_gc->regs + XGPIO_DATA_OFFSET) >> gpio) & 1;
> > }
> > 
> > include/linux/of_gpio.h:
> > struct of_mm_gpio_chip {
> >         struct gpio_chip gc;
> >         void (*save_regs)(struct of_mm_gpio_chip *mm_gc);
> >         void __iomem *regs;
> > };
> > 
> > Why am I being asked to add in_be32() etc to ARMs io.h ?  Why do we need
> > yet another set of IO accessors?  Is there something wrong with
> > ioread*()/ioread*be() etc?
> 
> Nope, nothing wrong with them, the driver should be fixed. in_be* is
> historical ppc stuff.
> 
> > My guess is this stems from a lack of proper review
> 
> That or history. Our readX/writeX used to be more PCI specific (have
> infrastructure to work around PCI bridge bugs) which some drivers
> avoided using the in_/out_ variants, in some case it's just pure
> history, etc... Some of these things are ancient.

So, if I tell the SPEAr people that any driver they come across using
these old in_XX should be converted to use ioread*() you'll be happy
for that to happen?
