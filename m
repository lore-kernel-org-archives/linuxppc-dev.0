Message-ID: <3D1897FC.D7D7C5B2@mvista.com>
Date: Tue, 25 Jun 2002 09:19:08 -0700
From: Frank Rowand <frowand@mvista.com>
Reply-To: frowand@mvista.com
MIME-Version: 1.0
To: Matt Porter <mmporter@cox.net>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Move kgdb init code?
References: <20020624221020.A14330@home.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Matt Porter wrote:
>
> Hi all,
>
> I've created a generic ns16550 binding to kgdb in hopes of making
> enabling kgdb support less of a per-board hack.  It utilizes the
> information populated in rs_table to configure the UARTs (code
> stolen from a number of our other polled 16550 code areas).  The
> only problem is that for systems that use early_serial_init() to
> configure serial port usage, the current location of the kgdb
> init code is not suitable.  early_serial_init() is run during
> during a port's ppc_md.setup_arch if it is being used and so
> requires the the kgdb initialization be performed after
> ppc_md.setup_arch runs.

Is the concern that early_serial_init() will change the UART's
configuration, if kgdb initializes it earlier?  Or something
else?


>
> Since I don't personally use kgdb on a day-to-day basis, I'm
> wondering what most people use it for.  I would guess that it
> is not typically used for board bringup since it is available
> so late in init code (and progress messages are available even
> earlier if one can't/won't use a hardware debugger).  If most

When I was doing board bringups, I used kgdb for 95% of my debugging.
It has always been a struggle (in various OSs that I have worked
on) to get a software based kernel debugger initialized as early
as possible in the boot sequence.  For 4xx and 8xx, kgdb is
available fairly early (very soon after going virtual).


> people are using it for device driver debug, then it doesn't
> seem that moving the init code after ppc_md.setup_arch would
> be a problem.  It would enable kgdb in a more general purpose
> way with the generic 16550 support, and somebody doing new
> bringup could always move the init code earlier for their
> specific case.
>
> Any objections or alternatives?

yes (objection).

>
> Thanks,
> --
> Matt "I use a BDI2000" Porter
> porter@cox.net
> This is Linux Country. On a quiet night, you can hear Windows reboot.


-Frank
--
Frank Rowand <frank_rowand@mvista.com>
MontaVista Software, Inc

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
