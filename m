Message-ID: <385FA53A.95617562@mvista.com>
Date: Tue, 21 Dec 1999 10:05:14 -0600
From: Jim Lewis <jlewis@mvista.com>
MIME-Version: 1.0
To: kd@flaga.is
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: gdbserver
References: <OFFF644F53.7F60D0CE-ON0025684E.0050176B@flaga.is>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


kd@flaga.is wrote:

> Hi,
>
> I am trying to get gdbserver to run on my mpc823 board. (The precompiled
> gdbserver is not working for me, it does not seem to get argc and argv
> correctly into main() and always terminates with "usage info".
>
> Using the vanilla gdb-4.18 is of no use, since it has not support for ppc.
> Using the gdbserver source that Dan posted here a few weeks back results in
> the
> the following undefined symbols,
> PTRACE_POKEUSR

I ran into build problems as well. Apparently, ptrace.h must have changed. The
macros are now called
PTRACE_POKEUSER
PTRACE_PEEKUSER

In my build, KERNEL_U_ADDR is defined in xm.h, which is a link:
xm.h -> ./../config/powerpc/xm-linux.h
#define KERNEL_U_ADDR 0x0


I built gdbserver in a 4.17 tree from the SRC RPM on the LinuxPPC CD.
xm-linux.h in 4.18 does not have that definition.


>
> PTRACE_PEEKUSR
> KERNEL_U_ADDR
> when compiling low-linux.c
> If I define these symbols to 6, 3 and 0 respectively, everything compiles
> fine, but the linker fails with the error,
> undefined referenve to REGISTER_U_ADDR in function register_addr.
>
> These are defined (for some of the other targets) in directory gdb/config/.
> Any idea what is missing?
>
> K.D.

--
Jim Lewis


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
