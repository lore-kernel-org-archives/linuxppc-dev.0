Date: Sun, 23 Mar 2003 21:22:21 -0600 (CST)
From: "Milton D. Miller II" <miltonm@realtime.net>
Message-Id: <200303240322.h2O3MLhG023213@sullivan.realtime.net>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re:  Kenal Panic
Cc: kamarajp@future.futsoft.com
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Kamaraj wrote:
>I am getting this Kernel Panic message when I invoke ping flood from MPC8xx
>Oops: Kernel Mode Software FPU Emulation, sig: 8
>NIP: C00292BC XER: C0001D7F LR: C00292BC SP: C3A07BC0 REGS: c3a07b10

A floating point trap could be one of several things, including

1) a device driver that specifies floating point numbers (the kernel is
   not allowed to use floating point).

2) a compiler mis-configured to use floating point registers for structure
   copy

3) A device or driver is scribling on memory

4) Your memory bus or controller is not configured correctly or your board
   is getting noise, corrupting memory.

1 and 2 can be eliminated by checking the instruction at NIP in your vmlinux,
possibly by objdump.   3 would tend to be unlikely at the low address but
not impossible.

milton

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
