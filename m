Subject: more problems running gdb on an embedded target
To: linuxppc-embedded@lists.linuxppc.org (LinuxPPC Embedded Mailing List)
Date: Thu, 17 Feb 2000 18:28:28 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20000217072828.868391B699@elph.research.canon.com.au>
From: greyham@research.canon.com.au (Graham Stoney)
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Jeff Millar writes:
> you need Dan Malek's sash patch. In addition, complicated terminal I/O might
> be affected by a bug that Pavel Roskin fixed a few days ago (and posted
> here).

Thanks for the tips guys. I've applied the sash.patch from Wolfgang's CDK, and
sure enough this fixes the tcsetpgrp problem. Unfortunately though, it was a
red herring. I still have the problem where gdb-4.16.97 hangs after hitting a
breakpoint in my application...

So I've tried cross-compiling the latest release of gdb (4.18), but configure
fails while configuring readline with:
    configure: cross-compiling for a non-cygwin target is not supported

OK, so instead I try the latest snapshot of gdb (gdb-000217). This builds OK
(after commenting gnu-regex.c out in the Makefile because it conflicts with
the one in glibc-2.1.2) but it dies with a Segmentation fault on startup.
I haven't got very in debugging this problem in my gdb-000217 build with
gdb-4.16.97 either:

    # /usr/bin/gdb ./gdb
    GNU gdb 4.16.97
    ...
    This GDB was configured ... "powerpc-unknown-linux-gnulibc1"...
    (gdb) b main
    Breakpoint 1 at 0x10000f94: file ../../../gdb-000216/gdb/main.c, line 747.
    (gdb) run
    Starting program: /home/./gdb

    Program received signal SIGSEGV, Segmentation fault.
    0x100000c0 in _start ()

Nasty. It hasn't even got to main yet. Anyone know what would cause a program
to die with e SIGSEGV in _start?

Furthermore, even just quitting gdb at this point brings the system down:

    (gdb) q
    The program is running.  Exit anyway? (y or n) y
    Software Emulation sh/7 NIP: 18551a4 *NIP: 0x0 code: ffffffda<0>
    Kernel panic: No init found.  Try passing init= option to kernel.
    Rebooting in 180 seconds..

Any one have any suggestions on any one of this myriad of problems? :-)

Thanks,
Graham

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
