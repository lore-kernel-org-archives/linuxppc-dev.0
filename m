Message-ID: <3D18DA5A.D6C7E033@mvista.com>
Date: Tue, 25 Jun 2002 14:02:18 -0700
From: Frank Rowand <frowand@mvista.com>
Reply-To: frowand@mvista.com
MIME-Version: 1.0
To: Matt Porter <porter@cox.net>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Move kgdb init code?
References: <20020624221020.A14330@home.com> <3D1897FC.D7D7C5B2@mvista.com> <20020625135008.A15298@home.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Matt Porter wrote:
>
> On Tue, Jun 25, 2002 at 09:19:08AM -0700, Frank Rowand wrote:
> > Matt Porter wrote:
> > >
> > > Hi all,
> > >
> > > I've created a generic ns16550 binding to kgdb in hopes of making
> > > enabling kgdb support less of a per-board hack.  It utilizes the
> > > information populated in rs_table to configure the UARTs (code
> > > stolen from a number of our other polled 16550 code areas).  The
> > > only problem is that for systems that use early_serial_init() to
> > > configure serial port usage, the current location of the kgdb
> > > init code is not suitable.  early_serial_init() is run during
> > > during a port's ppc_md.setup_arch if it is being used and so
> > > requires the the kgdb initialization be performed after
> > > ppc_md.setup_arch runs.
> >
> > Is the concern that early_serial_init() will change the UART's
> > configuration, if kgdb initializes it earlier?  Or something
> > else?
>
> Actually, some ports have no virtual mapping prior to
> early_serial_init() so the current location of kgdb is
> unsuitable (as a general purpose case).
>
> > > Since I don't personally use kgdb on a day-to-day basis, I'm
> > > wondering what most people use it for.  I would guess that it
> > > is not typically used for board bringup since it is available
> > > so late in init code (and progress messages are available even
> > > earlier if one can't/won't use a hardware debugger).  If most
> >
> > When I was doing board bringups, I used kgdb for 95% of my debugging.
> > It has always been a struggle (in various OSs that I have worked
> > on) to get a software based kernel debugger initialized as early
> > as possible in the boot sequence.  For 4xx and 8xx, kgdb is
> > available fairly early (very soon after going virtual).
>
> That doesn't seem to be the general purpose case, though.  When
> you have kgdb functionality in the kernel for functional board
> ports, later debug seems to be the general use of it.
>
> When doing a board bringup, one is always going to want to move
> the init from even its current location.   Not a big deal, since
> the developer is already adding progress messages, printks, etc
> as he walks the thing into a running state.
>
> It would seem that moving the default location has more general
> usefulness for existing board ports.  IMHO, it is most important
> to have features like kgdb functioning in a general purpose way
> in the tree.
>
> > > people are using it for device driver debug, then it doesn't
> > > seem that moving the init code after ppc_md.setup_arch would
> > > be a problem.  It would enable kgdb in a more general purpose
> > > way with the generic 16550 support, and somebody doing new
> > > bringup could always move the init code earlier for their
> > > specific case.
> > >
> > > Any objections or alternatives?
> >
> > yes (objection).
>
> Is being expected to move kgdb_map_scc() to an earlier custom
> location too much?  It only needs to be earlier until things
> are functional past setup_arch.

It sounds like you are trying to move kgdb_map_scc() to a board
and processor independent place (just PPC dependent), which is
certainly easier than having a processor dependent implementation
that may need a lot of maintainance.

In older kernels, the call to ppc_md.setup_arch() isn't much
later than where kgdb was initialized...  Hopefully that is
still the case.  If so, your proposed change won't affect
the ability to debug early bringup much at all.  Sorry I didn't
dig deeper into exactly where you proposed moving to before
answering.

I'm just used to the common effort (in multiple OSs, in multiple
companies) to move kernel debugger initialization later and later
in the boot sequence, so I figured I would pipe up with a not too
loud voice.

I'm not trying to voice a strong opinion, just trying to give
some insight as someone who has used kgdb extensively.

-Frank
--
Frank Rowand <frank_rowand@mvista.com>
MontaVista Software, Inc

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
