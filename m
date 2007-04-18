Return-Path: <laurent.pinchart@technotrade.biz>
From: Laurent Pinchart <laurent.pinchart@technotrade.biz>
To: Bill Gatliff <bgat@billgatliff.com>
Subject: Re: Compiling interrupt controller code as a module
Date: Wed, 18 Apr 2007 11:39:55 +0200
References: <200704171731.43608.laurent.pinchart@technotrade.biz>
	<46250034.7000202@billgatliff.com>
In-Reply-To: <46250034.7000202@billgatliff.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200704181139.56819.laurent.pinchart@technotrade.biz>
Cc: Linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Bill,

> > I wrote a kernel driver for a custom bus (using arch/ppc). The hardware
> > has a cascaded interrupt controller wired to one of the CPU interrupts.
> > The interrupt controller IRQ handler calls __do_IRQ() to dispatch
> > interrupts.
> >
> > Everything worked fine until I tried to compile the code as a module
> > because __do_IRQ() is not exported. Is there a way to compile an
> > interrupt controller as a module, or must it be included in the kernel ?
>
> Could you just export __do_IRQ()?

That's obviously the easiest solution. As __do_IRQ() is not exported by 
default, and as the function name starts with two underscores, I got the 
feeling it was somehow meant to be private.

I also had a look at the genirq code. It misses a few exports as well 
(irq_set_chip_and_handler for instance).

Laurent Pinchart
