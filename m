Message-ID: <37D947AA.85EE4650@ne.mediaone.net>
Date: Fri, 10 Sep 1999 18:02:18 +0000
From: Vitaly Oratovsky <vitaly_oratovsky@ne.mediaone.net>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: altivec
References: <Pine.LNX.4.10.9909101030100.31612-100000@web1.turbolinux.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Brad Midgley wrote:

> the kernel needs to know how & when to stack and unstack the altivec
> registers.

To really do Altivec vector regs save/restore efficiently will require
cooperation between kernel and compiler.  Altivec architecture defines
a VRSAVE register, which is just a general purpose 32-bit wide bitmask.
The intention is for compiler to record usage of altivec registers in
the prologue of every function which uses them.  Likewise, the epilogue
is supposed to restore VRSAVE to the caller's state.  Of course, hand-
written assembly routines have to play by the same rules.

This approach permits saving/restoring the absolute minimum number of
vector unit regs, and [perhaps more importantly] only when the
interrupted
thread was truly using them.

A less ambitious approach which doesn't require the compiler to mock
with
VRSAVE would be to allow the kernel to discover whether a particular
process
uses the vector unit by "faulting" in the vector unit enable bit in MSR
for
each process individually.

Cheers, Vitaly.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
