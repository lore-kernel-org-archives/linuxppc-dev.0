Date: Wed, 23 Jun 2004 09:28:09 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Dale Farnsworth <dale@farnsworth.org>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: 2.6 networking support for Redwood[56]
Message-ID: <20040623092809.A25264@home.com>
References: <20040621213948.GA8849@zenos.farnsworth.org> <20040621161214.A5851@home.com> <20040622004111.GB8849@zenos.farnsworth.org> <20040623125835.GA15700@zenos.farnsworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040623125835.GA15700@zenos.farnsworth.org>; from dale@farnsworth.org on Wed, Jun 23, 2004 at 05:58:35AM -0700
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Jun 23, 2004 at 05:58:35AM -0700, Dale Farnsworth wrote:
>
> On Tue, Jun 22, 2004 at 12:41:11AM +0000, Dale Farnsworth wrote:
> > On Mon, Jun 21, 2004 at 11:12:14PM +0000, Matt Porter wrote:
> > > On Mon, Jun 21, 2004 at 02:39:48PM -0700, Dale Farnsworth wrote:
> > > >
> > > > I'm adding network support for the IBM Redwood5 and Redwood6 in 2.6.
> > > >
> > > > It looks like the best supported driver for the smc91111 chip
> > > > is used by the ARM folks and is found in drivers/net/arm/smc91x.[ch]
> > > > This driver recently went into the linux-2.5 tree.
> > > >
> > > > I moved these two files into drivers/net so they are available for
> > > > PPC as well as ARM and added some Redwood-specific support.  That
> > > > was straightforward.  This driver calls a couple of ARM-specific
> > > > functions platform_get_resource() and platform_get_irq().  ARM
> > > > implements these functions in arch/arm/common/platform.c.  I
> > > > copied arch/arm/common/platform.c into arch/ppc/syslib/platform.c
> > > > which works fine, but I don't care for duplicated code.  Maybe a
> > > > better approach would be to add these functions to drivers/base/platform.c
> > >
> > > How about wrapping each arch-specific call up in something more abstract
> > > and then using OCP to get the PPC info?
> > >
> > > roughly...
> > >
> > > #ifdef CONFIG_PPC_OCP
> > > TO_SMC_DEV		to_ocp_device()
> > > SMC_GET_BASE_ADDR	dev->def->paddr
> > > ...
> > > #else /* ARM */
> > > TO_SMC_DEV		to_platform_device()
> > > SMC_GET_BASE_ADDR	platform_get_resource(dev, IORESOURCE_MEM, 1)
> > > ...
> > > #endif
> > >
> > > There's only about 4 places in the probe/remove calls to do this.
> > > Add an ocp_add_one_device in your redwood*.c to enable the smc9111
> > > device with the board-specific attributes.
> > >
> > > You may have to play a bit with the prove/remove calls since they
> > > want to deal with a resource struct, but it might be worth looking
> > > at.
> >
> > Sounds like a better approach.  I'll modify the driver to present
> > either the ARM interface or the PPC_OCP interface.  Muddles the
> > driver a bit, but should keep both archs happy.
>
> FYI, platform_get_resource() and platform_get_irq() just went into
> linux-2.5/drivers/base/platform.c so this issue is now moot.

Yep, I agree with that.

-Matt

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
