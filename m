Message-ID: <39CFB68A.816F6737@emc.com>
Date: Mon, 25 Sep 2000 16:33:14 -0400
From: Zhaobin Zhu <zzhu@emc.com>
MIME-Version: 1.0
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Question regarding PowerPC routine compilation.
References: <006d01bfc716$3017b050$4a1f76d8@washington>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

This is a newbie question regarding (PowerPC) calling a C routine within a .S
file:

Let me take an example:

in arch/ppc/kernel/head.S,
...
        mr      r3,r31
        mr      r4,r30
        mr      r5,r29
        mr      r6,r28
        mr      r7,r27
        bl      identify_machine
...
The code calls rountine identify_machine(..) in setup.c.

Questions:

   The identify_machine(..) in setup.c will certainly use some of the registers
(r0-r31).
   Will the compiler protect the registers used in the routine (for example
   push them into stack before entering the routine and pop them out
   after exiting the routine ) ?

   If yes, how the compiler does the protection ? Will it simply save all the
regs
   into stack before entering routine and restore them after returning from the

   routine (except R3 wiich may be used as a pointer to some returned value).

   If compiler does no reg protection, then there is no gurantee that the
register set
   will be the same before and after calling a C routine. It's the calling
code's
   responsibility to make sure some important regs will not be altered after
return
   from a C routine.

Thanks,

--
 Zhaobin Zhu
 zzhu@emc.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
