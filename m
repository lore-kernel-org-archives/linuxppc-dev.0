Return-Path: <acahalan@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.187])
	by ozlabs.org (Postfix) with ESMTP id BC8A267BB6
	for <linuxppc-dev@ozlabs.org>; Sun, 13 Aug 2006 12:48:34 +1000 (EST)
Received: by nf-out-0910.google.com with SMTP id k27so2141380nfc
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Aug 2006 19:48:32 -0700 (PDT)
Message-ID: <787b0d920608121948rad24dc7le834f1b499543ace@mail.gmail.com>
Date: Sat, 12 Aug 2006 22:48:31 -0400
From: "Albert Cahalan" <acahalan@gmail.com>
To: "Paul Mackerras" <paulus@samba.org>
Subject: Re: PowerPC paxtest results w/ gcc-4.1
In-Reply-To: <17630.27174.711916.643790@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <787b0d920608112250q551c98f5j328183c31eebaf77@mail.gmail.com>
	<17629.48408.564322.747132@cargo.ozlabs.ibm.com>
	<787b0d920608120736n1ba0bc03jccf2964bf7ebb1d5@mail.gmail.com>
	<17630.27174.711916.643790@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org, debian-powerpc <debian-powerpc@lists.debian.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 8/12/06, Paul Mackerras <paulus@samba.org> wrote:
> Albert Cahalan writes:
>
> > gcc version 4.1.2 20060613 (prerelease) (Debian 4.1.1-5)
>
> OK, so I think that version should have the new -msecure-plt flag,

The flag matters not, even with the very latest binutils
that Debian offers, version 2.17-2:

$ md5sum default m*
5f8398f47793ae0eee635989825c8e6b  default
5f8398f47793ae0eee635989825c8e6b  mbss-plt
5f8398f47793ae0eee635989825c8e6b  msecure-plt

(the default needs to be secure of course, so that
all the Debian packages get it)

> To get the full benefit of -msecure-plt, every object file in your
> executable has to be compiled with it, and I think every shared
> library the program uses has to be compiled with it too.  On a system
> where everything has been compiled with -msecure-plt, I believe the
> heap and stack will automatically be made non-executable.

VM_STACK_DEFAULT_FLAGS32 is wrong. A fail-safe
default is important for security. If gcc on PowerPC ever
does generate code which puts trampolines on the stack,
then that can be fixed by converting to legal C code or
by adding the fragile marking to the defective executables.
Did gcc ever generate such code on PowerPC? If not,
then there is no reason to ever allow an executable stack.

In any case, I see no markings:

$ eu-readelf -n /lib/libc-2.3.6.so

Note segment of 32 bytes at offset 0x174:
  Owner          Data size  Type
  GNU                   16  VERSION
    OS: Linux, ABI: 2.4.1

$ eu-readelf -n a.out

Note segment of 32 bytes at offset 0x124:
  Owner          Data size  Type
  GNU                   16  VERSION
    OS: Linux, ABI: 2.4.1

> Of course, that won't make all that much difference on your Cube,
> because the G4 CPU doesn't have hardware support for non-executable
> pages (any readable page is executable).

No. Look in the segment registers. The granularity
isn't great, but the stack can be protected at least.
With a decent memory layout, as is done for using
the CS segment limit on i386, all but the bottom
256 MiB should be non-execute.

Counting executable pages per segment is reasonable.
I believe this is what OpenBSD does.

A better way would be to frequently mark the segments
as non-execute. (upon every context switch, mapping
change, or sleep) Then, upon taking a fault, only enable
execute in the segment if the instruction pointer is in an
area which is really supposed to be executable.

> As for the randomization, I'm surprised we got no stack randomization,
> since that appears to be handled generically (randomize_stack_stop()
> in fs/binfmt_elf.c).  What does cat /proc/sys/kernel/randomize_va_space
> give you?  (i386 also does arch-specific randomization of some low
> bits of the stack pointer, which we could do too.)

I get a 1.

> Shared library randomization is a glibc thing, I assume.  (It is
> incompatible with prelink, of course.)

It seems that glibc often asks for specific addresses,
which is bad. The rest of the time this is a kernel issue.

> I don't believe we can do
> ET_EXEC address randomization, and I don't think x86 can do it either.

Sure, but I just tried the other type (should be default)
and didn't get any improvement.
