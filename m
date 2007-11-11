Return-Path: <benh@kernel.crashing.org>
Subject: Re: IRQs in i2c-mpc.c
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <A4797E92-9FCF-484A-B6AA-9385913AD465@kernel.crashing.org>
References: <9e4733910711101144r3f8745dbs572aefa8658e1312@mail.gmail.com>
	<3DBBAC12-579B-4C1F-9C9E-D085FB22B687@kernel.crashing.org>
	<9e4733910711101516n64870e40rbd1fcbe3d123fcc3@mail.gmail.com>
	<A4797E92-9FCF-484A-B6AA-9385913AD465@kernel.crashing.org>
Content-Type: text/plain
Date: Sun, 11 Nov 2007 17:26:20 +1100
Message-Id: <1194762380.21340.36.camel@pasglop>
Mime-Version: 1.0
Cc: PowerPC dev list <Linuxppc-dev@ozlabs.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sat, 2007-11-10 at 17:18 -0600, Kumar Gala wrote:
> On Nov 10, 2007, at 5:16 PM, Jon Smirl wrote:
> 
> > On 11/10/07, Kumar Gala <galak@kernel.crashing.org> wrote:
> >> Looking at the current driver it looks like we could get ride of if
> >> check since the previous code checked the return of  
> >> platform_get_irq().
> >
> > The code was a snippet from the larger patch that is converting i2c
> > from being a platform driver to a of_platform driver.
> >
> > The question is, what to do about a missing IRQ tag in the device tree
> > or a IRQ of zero. What is an error and what should be ignored, etc.
> 
> I think the lack of an IRQ in the device tree should be an error.  If  
> the IRQ value is zero, than its zero.

virq 0 is always illegal so if platform_get_irq() returns 0, it can be
safely treated as an error or the absence of irq, on both powerpc and
x86.

Ben.
