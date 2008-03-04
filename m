Return-Path: <phdm@macqel.be>
Received: from mail.macqel.be (mail.macqel.be [194.78.208.39])
	by ozlabs.org (Postfix) with ESMTP id 2FEECE0079
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Mar 2008 19:34:48 +1100 (EST)
Date: Tue, 4 Mar 2008 09:34:47 +0100
From: Philippe De Muyter <phdm@macqel.be>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: ARCH=ppc -> ARCH=powerpc : help needed for dts file
Message-ID: <20080304083447.GC18829@netgate.macqel>
References: <20080303144727.GA27949@ingate.macqel>
	<20080303170719.GC28951@ld0162-tx32.am.freescale.net>
	<20080303210532.GA20382@netgate.macqel>
	<1204579574.21545.19.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1204579574.21545.19.camel@pasglop>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Ben,

On Tue, Mar 04, 2008 at 08:26:14AM +1100, Benjamin Herrenschmidt wrote:
> 
> > > Maybe your PCI interrupt-map is wrong...
> > 
> > Is the PCI-interrupt map that part of the dts file :
> > 
> >                 interrupt-map = <
> > 
> >                         /* IDSEL 0x02 */
> >                         1000 0 0 1 &mpic 1 1
> >                         1000 0 0 2 &mpic 2 1
> >                         1000 0 0 3 &mpic 3 1
> >                         1000 0 0 4 &mpic 4 1
> > 
> >                         /* IDSEL 0x03 */
> >                         1800 0 0 1 &mpic 4 1
> >                         1800 0 0 2 &mpic 1 1
> >                         1800 0 0 3 &mpic 2 1
> >                         1800 0 0 4 &mpic 3 1
> > 
> > 			...
> > 
> > I do not understand anything there :(
> 
> It's documented in booting-without-of.txt afaik... The interrupt-map
> goes along with the interrupt-map-mask. The later defines which bits of
> the map are relevant.

Maybe I should read my mail in time-of-arrival order :)

> 
> The first part of the map is 3 cells containing a PCI address, followed
> by a cell containing a PCI IRQ line (1=A....4=D). The next is the parent
> interrupt controller, followed by the IRQ specification, which for MPIC
> is the interrupt number on that controller, followed by an encoding of
> the interrupt polarity & trigger type (1 for level-low).
> 
> The first part, the PCI address, has a special format, which should be
> documented as well in the document I pointed out. For readability, we
> ommited the top 16 bits of the first cell, which are the address type
> and bus number, mostly irrelevant for interrupt mapping. The next bits
> are the device/function. Usually only the device part is unmasked.

1. Can all that info be found in /proc in a running system or even in the
sources, or do I need an hardware doc for that ?

2. Maybe you could explain the conversion between the kernel/lsusb notation
(0000:00:12.0, 0000:00:12.1, 0000:00:12.2)

or /proc/bus/pci notation :
0090    104cac46        35              9ffff000                       0                      0                0                       0                       0
                       0                    1000                       0                      0                0                       0                       0
                       0        yenta_cardbus
0091    104cac46        36              9fbfe000                       0                      0                0                       0                       0
                       0                    1000                       0                      0                0                       0                       0
                       0        yenta_cardbus
0092    104c802a        37              9f7fd800                9f7f8000                      0                0                       0                       0
                       0                     800                    4000                      0                0                       0                       0
                       0        ohci1394

and dts-notation ?

Thanks for listening

Philippe
