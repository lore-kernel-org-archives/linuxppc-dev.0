Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17630.27174.711916.643790@cargo.ozlabs.ibm.com>
Date: Sun, 13 Aug 2006 09:54:14 +1000
From: Paul Mackerras <paulus@samba.org>
To: "Albert Cahalan" <acahalan@gmail.com>
Subject: Re: PowerPC paxtest results w/ gcc-4.1
In-Reply-To: <787b0d920608120736n1ba0bc03jccf2964bf7ebb1d5@mail.gmail.com>
References: <787b0d920608112250q551c98f5j328183c31eebaf77@mail.gmail.com>
	<17629.48408.564322.747132@cargo.ozlabs.ibm.com>
	<787b0d920608120736n1ba0bc03jccf2964bf7ebb1d5@mail.gmail.com>
Cc: , linuxppc-dev@ozlabs.org, debian-powerpc@lists.debian.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Albert Cahalan writes:

> gcc version 4.1.2 20060613 (prerelease) (Debian 4.1.1-5)

OK, so I think that version should have the new -msecure-plt flag,
which changes the ppc32 ABI so that the PLT no longer has to be
writable and executable.  Previously the dynamic linker would rewrite
each PLT entry, the first time it is used, to jump directly to the
target routine.  That was the reason why the heap had to be
executable.

To get the full benefit of -msecure-plt, every object file in your
executable has to be compiled with it, and I think every shared
library the program uses has to be compiled with it too.  On a system
where everything has been compiled with -msecure-plt, I believe the
heap and stack will automatically be made non-executable.

Of course, that won't make all that much difference on your Cube,
because the G4 CPU doesn't have hardware support for non-executable
pages (any readable page is executable).  The G5 does, as do the 4xx
and Book E 32-bit CPUs, and any 64-bit CPU from POWER4 on.

As for the randomization, I'm surprised we got no stack randomization,
since that appears to be handled generically (randomize_stack_stop()
in fs/binfmt_elf.c).  What does cat /proc/sys/kernel/randomize_va_space
give you?  (i386 also does arch-specific randomization of some low
bits of the stack pointer, which we could do too.)

Shared library randomization is a glibc thing, I assume.  (It is
incompatible with prelink, of course.)  I don't believe we can do
ET_EXEC address randomization, and I don't think x86 can do it either.

Paul.
