From: kd@flaga.is
Subject: zeroing of bss segments
To: linuxppc-embedded@lists.linuxppc.org
Message-ID: <OFA20EA33C.C47E920B-ON002568C1.0056A7A4@flaga.is>
Date: Fri, 14 Apr 2000 16:00:40 +0000
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

It seems that many of the problems that I am seeing on our mpc823 board is
related to uninitialized static variables in the glibc library. What lead
my to this conclusion is that many of the programs are segfaulting and
always in the glibc library.
Tracking down the individual functions, such as gethostbyname and the
sunrpc functions and explicitly setting static pointers to NULL in the
library code cured many of the segfaults.

I asked about this on the glibc mailing lists (actully I sent some patch)
and they replied that the kernel should clear all static variables in the
bss segment of the executable before runnning it.

The funny thing is that if I write a small program that uses static
variables, they are all zeroed out . But the static variables in the
library seem to be in some uninitialized state (at least some of them).

I am in the process of trying to trace me thought the binfmt_elf.c file in
the kernel, but I am not shure how things are supposed to work. Should I be
looking at some specific function that does the cleaning of the bss segment
or is it a "distributed" job between many functions? E.G. should a do_mmap
() call return a zeroed out memory segment?

Should I perhaps be looking at the linker? Is the linker maybe putting
variables in wrong segments?

I am kind of lost here so all pointers are welcome.

Kernel 2.2.13
Glibc 2.1.3
gcc 2.95.2
Applications are dinamically linked

K.D.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
