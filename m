Date: Tue, 25 Jun 2002 15:39:00 -0700
From: Matt Porter <porter@cox.net>
To: Dan Malek <dan@embeddededge.com>
Cc: Matt Porter <porter@cox.net>, Frank Rowand <frowand@mvista.com>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: Move kgdb init code?
Message-ID: <20020625153900.B15298@home.com>
References: <20020624221020.A14330@home.com> <3D1897FC.D7D7C5B2@mvista.com> <20020625135008.A15298@home.com> <3D18E933.7020402@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3D18E933.7020402@embeddededge.com>; from dan@embeddededge.com on Tue, Jun 25, 2002 at 06:05:39PM -0400
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Jun 25, 2002 at 06:05:39PM -0400, Dan Malek wrote:
> Matt Porter wrote:
>
> > Actually, some ports have no virtual mapping prior to
> > early_serial_init()
>
> Ummmm....something doesn't seem right then.  The kernel has
> to be mapped in order for it to be running at this time,  and
> the I/O can actually move around.

That should be "no serial port mapping prior to early_serial_init().

> I did lots of this work to get kgdb, and more importantly xmon,
> to initialize this early.  On the 8xx, the serial port is actually
> moved at least three times as the VM and the driver initializations
> are done.
>
> Early in kgdb/xmon, they rely on the same mapping that is used by
> the boot loader that brought the kernel to being.  If I can make this
> work on 8xx, it should work on anything :-)  The 8xx can only do DMA
> I/O, so it's particularly challenging to chase memory around that
> can be used for these buffers.
>
>
> > That doesn't seem to be the general purpose case, though.  When
> > you have kgdb functionality in the kernel for functional board
> > ports, later debug seems to be the general use of it.
>
> You always want to start up kgdb as soon as possible.  It gives you
> the opportunity to debug driver initialization.

The only thing I was talking about was moving it toward the end
of setup_arch.  All _driver_ init is after that.

> > It would seem that moving the default location has more general
> > usefulness for existing board ports.
>
> Huh?  All of the existing board ports use it as it is today.  How
> can you say removing a useful feature would be useful to existing
> systems? :-)

I think we are talking two different things.  Kgdb does not work on
the vast number of 7xx/74xx designs with 16550's all at arbitrary
locations.  The ppc4xx_kgdb.c binding is non-functional is _devel
(relying on the old COM_PORT structure that is gone).

You've got me confused Dan, where did I suggest removing a useful
feature?

> > ....  IMHO, it is most important
> > to have features like kgdb functioning in a general purpose way
> > in the tree.
>
> I don't know what that statement means.  All of the other architectures
> use an early kgdb initialization, which is where we got the idea to
> do the same a while back.  The kgdb/xmon used to initialize later, and
> didn't make it very useful until a substantial amount of system initialization
> was done.
>
> > Is being expected to move kgdb_map_scc() to an earlier custom
> > location too much?
>
> Why don't you just use the normal serial port setup to enter kgdb
> on those ports that have trouble, and do nothing in this early function?

I don't understand what you are suggesting.  I don't poke a static
serial port mapping in (to be used in STD_SERIAL_DEFS) because
early_serial_init()/ioremap() can do it dynamically for me.

> >  ...  It only needs to be earlier until things
> > are functional past setup_arch.
>
> What board ports have trouble with the early initialization?  Any mostly
> standard programmed I/O uart should work.  It's only the high performance
> DMA only ports like 8xx and 8260 that seem to be the challenge.

Hrm, so are you suggesting a do an early mapping (I use one for
early boot text support) init kgdb, and not use early_serial_setup()?
I think kgdb should be able to work with early_serial_setup().

Regards,
--
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
