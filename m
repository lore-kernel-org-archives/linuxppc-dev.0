Date: Sat, 19 Aug 2000 20:39:31 -0500
From: Steven Bytnar <sbytnar@users.sourceforge.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: Pseudo Oops for ppc
Message-ID: <20000819203931.A15224@openprojects.rarcoa.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


http://www.stg.com/udi/ppc-oops-1.patch

This simple patch improves the default panic backtraceing
by walking the kernel symbol table to find function names.

It also attempts to kill and cleanup the task that caused
the panic by calling do_exit(SIGKILL). This seems to work
most of the time and leaves the machine in a mostly
usable state, although you should probably reboot soon
thereafter.

The end result... you can panic the machine and keep
working after waiting about 10 seconds. (So you can see
the panic message.)

You will want to tune the delay loop value. Why is there a
delay loop?! I didn't feel like figuring out how to read the
USB keyboard driver.

This patch isn't very useful if you have kgdb or xmon
enabled. Hopefully someone will find this useful. It's
been a time saver for me while I've been working on
developing kernel modules on a G4.

Enjoy,
--Steve


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
