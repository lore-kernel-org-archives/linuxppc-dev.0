From: Matt Porter <mmporter@cox.net>
Date: Mon, 24 Jun 2002 22:10:20 -0700
To: linuxppc-dev@lists.linuxppc.org
Subject: Move kgdb init code?
Message-ID: <20020624221020.A14330@home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

I've created a generic ns16550 binding to kgdb in hopes of making
enabling kgdb support less of a per-board hack.  It utilizes the
information populated in rs_table to configure the UARTs (code
stolen from a number of our other polled 16550 code areas).  The
only problem is that for systems that use early_serial_init() to
configure serial port usage, the current location of the kgdb
init code is not suitable.  early_serial_init() is run during
during a port's ppc_md.setup_arch if it is being used and so
requires the the kgdb initialization be performed after
ppc_md.setup_arch runs.

Since I don't personally use kgdb on a day-to-day basis, I'm
wondering what most people use it for.  I would guess that it
is not typically used for board bringup since it is available
so late in init code (and progress messages are available even
earlier if one can't/won't use a hardware debugger).  If most
people are using it for device driver debug, then it doesn't
seem that moving the init code after ppc_md.setup_arch would
be a problem.  It would enable kgdb in a more general purpose
way with the generic 16550 support, and somebody doing new
bringup could always move the init code earlier for their
specific case.

Any objections or alternatives?

Thanks,
--
Matt "I use a BDI2000" Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
