Message-ID: <3BEE9D33.F32035C3@midrivers.com>
Date: Sun, 11 Nov 2001 08:45:55 -0700
From: Mark Pilon <mpilon@midrivers.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Cc: jure@kom.org
Subject: crash in atexit()
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


our story thus far:

I'm attempting to port the development kernel to a custom controller
with a PPC405PM (that's 405GP + FPU).  I've built my own toolkit
and have built a small target filesystem w/ SELF (many thanks
Wolfgang).

the kernel boots and I can run sash as an init=/bin/sash ...
the kernel finds the filesystem and sash.

I've gotten beyond taking the first FPU-unavailable exception
by adding what appears necessary.

I'm SEGV'ing in atexit(), because of an apparently hard-coded
null pointer dereference: [ the call to atexit() is made by
__libc_start_main so I think I'm close to running ...]

/* Register FUNC to be executed by `exit'.  */
int
atexit (void (*func) (void))
{
  return __cxa_atexit ((void (*) (void *)) func, NULL,
                       &__dso_handle == NULL ? NULL : __dso_handle);
}

which has compiled to:
100004bc <atexit>:
100004bc:       94 21 ff f0     stwu    r1,-16(r1)
100004c0:       7c 08 02 a6     mflr    r0
100004c4:       90 01 00 14     stw     r0,20(r1)
100004c8:       3d 20 00 00     lis     r9,0
100004cc:       38 09 00 00     addi    r0,r9,0
100004d0:       81 69 00 00     lwz     r11,0(r9)
.
.
.

I suspect that this is centered around __dso_handle, but don't
know what this means.

I also suspect this has been covered before, but I've searched and
found references to some "atexit patches" but nothing specific --
If I need to patch my glibc where can I go for said patches?

any overview & context would be appreciated,

Mark
--
Mark Pilon

Minolta-QMS
P.O. Box 37
Fallon, MT.  59326-0037

1-406-853-0433

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
