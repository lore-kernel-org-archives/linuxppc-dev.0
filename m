Date: Wed, 26 Jun 2002 01:25:24 -0700
From: Matt Porter <porter@cox.net>
To: Dan Malek <dan@embeddededge.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Move kgdb init code?
Message-ID: <20020626012524.A16050@home.com>
References: <20020624221020.A14330@home.com> <3D1897FC.D7D7C5B2@mvista.com> <20020625135008.A15298@home.com> <3D18E933.7020402@embeddededge.com> <20020625153900.B15298@home.com> <3D192BDF.4050206@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3D192BDF.4050206@embeddededge.com>; from dan@embeddededge.com on Tue, Jun 25, 2002 at 10:50:07PM -0400
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Jun 25, 2002 at 10:50:07PM -0400, Dan Malek wrote:
> Matt Porter wrote:
>
> > The only thing I was talking about was moving it toward the end
> > of setup_arch.  All _driver_ init is after that.
>
> Hmmm.....why doesn't kgdb_map_scc call early_serial_init() instead
> of waiting for the 4xx platform setup to do that?  The purpose of
> kgdb_map_scc() is to do everything necessary to make the serial
> port accessible.  Is there something else done in platform specific
> setup that is needed?

The kgdb_map_scc in my gen550_kgdb.c is currently relying on rs_table
to be filled out.  The reason for this approach is that I'm trying
to enable all those 7xx/74xx ports at the same time.  Those ports
all have 16550's at arbitrary locations.  Some use io_block_mapping
and fixed virtual mapping for the UARTs at compile time and a few
have been updated to do without io_block_mapping and use
early_serial_init to load rs_table at run-time.  At any rate, every
one of them is potentially different and so should be calling
early_serial_init from the <board>.c or <board>_setup.c to pass in
the board-specific UART values.

In short, gen550_kgdb.c:kgdb_map_scc has no board-specific knowledge.
It relies on the board-specific setup to map things so that all these
7xx/74xx boards can be more or less generically enabled.  It _could_
call early_serial_init but then would be a mess of per-board #ifdefs
in order to ioremap the proper UART phys addrs.  That defeats our
whole goal of abstracting generic stuff out of the <board>.c files
and having all board-specific support in one place.

> > I think we are talking two different things.  Kgdb does not work on
> > the vast number of 7xx/74xx designs with 16550's all at arbitrary
> > locations.  The ppc4xx_kgdb.c binding is non-functional is _devel
> > (relying on the old COM_PORT structure that is gone).
> >
> > You've got me confused Dan, where did I suggest removing a useful
> > feature?
>
> Well, it used to be a useful feature :-)  If people keep breaking
> kgdb by making changes it relies upon for proper operation, that
> should get fixed :-)

Damn people. :)

> > I don't understand what you are suggesting.  I don't poke a static
> > serial port mapping in (to be used in STD_SERIAL_DEFS) because
> > early_serial_init()/ioremap() can do it dynamically for me.
>
> Well, that was one of the important changes (mapping the port
> or using an existing mapping) to allow an early kgdb.  I guess if
> you don't want to map it, that's a reason why it won't work.
>
>
> > Hrm, so are you suggesting a do an early mapping (I use one for
> > early boot text support) init kgdb, and not use early_serial_setup()?
> > I think kgdb should be able to work with early_serial_setup().
>
> :-)
>
> The kgdb doesn't care how the port was set up, just that is has a
> way to use it.  You could call early_serial_setup() several times,
> depending upon how the mapping may change.  This is basically how
> the 8xx and 8260 work.  I use an early trivial mapping that was set
> up by the bootloader, then an intermediate mapping, then finally
> something after rs_init() is called.

I'm starting to see that the difference in approaches is due to
the difference in architecture forced by the 60x bus classic PPCs
which can/do have 16550's interfaced at a variety of addresses and
even reg shift offsets.  In your examples, 8xx and 8260 are both
SoCs with onboard specialized UARTs at known locations in which
you have your own uart driver.  Since the UART's configuration is
the same in all board implementations, your task is simplified
for kgdb mapping.

> I guess if moving it to later in setup_arch() is enough.......

Moving it later is a simple way to make it work by default on
existing embedded 7xx/74xx board ports (with the gen550_kgdb.c support).

So, my concern at the beginning is whether moving it from before
ppc_md.setup_arch to after that call would have adverse effects
on those using kgdb.  If it does, then we'll just have to get
the early mapping on all those board ports straightened out to
cooperate with the current calling location of kgdb_map_scc.

Thanks,
--
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
