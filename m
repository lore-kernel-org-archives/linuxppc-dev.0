Date: Thu, 21 Jan 1999 16:44:29 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: Marc Dejardin <Marc.Dejardin@cern.ch>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Kernel panic with Xpmac using recent kernel 2.2.0-pre7 
In-Reply-To: <Pine.A41.3.95a.990121093109.145812A-100000@rsplus07.cern.ch>
Message-ID: <Pine.LNX.4.03.9901211642250.1033-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 21 Jan 1999, Marc Dejardin wrote:
> Kernel panic with Xpmac using recent kernel 2.2.0-pre7 (or all > 2.1.24).
> 
> Recently I have tryed to update my kernel to recent ones (I was using 2.1.24 
> witout any problem) and I encounter problem when I use Xwindow. In general I
> have a kernel panic after some seconds or minutes when I launch an application
> which uses X11 (xearth, gv, netscape, ...)
> The problem does not occur always at the same time. It seems linked to the fact
> that recent kernels for linuxppc are optimised for XFree86 and the

The kernel is not optimised for XFree86.

> compatibility with the old Xpmac is not perfect.

That's possible.

> Linux version 2.2.0-pre7 (dejard1@xxxxxx.xxxxxx.xxx.fr) (gcc version
> egcs-2.91.57 19980901 (egcs-1.1 release)) #1 Fri Jan 15 15:50:46 CET 1999
> 
> ONE KERNEL PANIC :
> 
> Jan 18 09:26:21 xxxxxx kernel: NIP: C00CDF9C XER: E000BE6F LR: C00347CC REGS: c2535cb0 TRAP: 0300
                                      ^^^^^^^^
> Jan 18 09:26:21 xxxxxx kernel: MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
> Jan 18 09:26:21 xxxxxx kernel: TASK = c2534000[304] 'X' mm->pgd c245e000 Last syscall: 142 
> Jan 18 09:26:21 xxxxxx kernel: last math c2534000
> Jan 18 09:26:21 xxxxxx kernel: GPR00: C00347CC C2535DA0 C2534000 00000407 00000000 00000000 00000000 C23006C4 
> Jan 18 09:26:21 xxxxxx kernel: GPR08: 00000010 C0160000 00000004 C24E5A40 95533E39 01A87568 01A80000 6C7A336E 
> Jan 18 09:26:21 xxxxxx kernel: GPR16: 01A8B3AC 01A8B52C 00000000 553DBE39 533DBE39 C2F58280 C2535E18 00000001 
> Jan 18 09:26:21 xxxxxx kernel: GPR24: 00002ECD C2F58000 0000000F 00000000 C015A39C C2F58000 00000407 C1E8E000 
> Jan 18 09:26:21 xxxxxx kernel: Call backtrace: 
> Jan 18 09:26:21 xxxxxx kernel: C2F58000 C00347CC C0034BB8 C0007A70 C0003898 01837B64 0180E1D4 
                                 ^^^^^^^^ ^^^^^^^^ ^^^^^^^^ ^^^^^^^^ ^^^^^^^^ ^^^^^^^^ ^^^^^^^^
> Jan 18 09:26:21 xxxxxx kernel: 01822310 01801BD4 
                                 ^^^^^^^^ ^^^^^^^^
Please look up these numbers in your System.map.

> Jan 18 09:26:21 xxxxxx kernel: Instruction DUMP: 41820028  3d20c019  83a94558 <4bf5b87d> 7c641b78  7f85e378  7fa3eb78  4bf44fa5  38000001 
> Jan 18 09:26:21 xxxxxx kernel: Kernel panic: kernel access of bad area pc c00cdf9c lr c00347cc address 453 tsk X/304
                                                                                                         ^^^
0x453, makes me think of a NULL pointer dereference for a struct.

Greetings,

						Geert

--
Geert Uytterhoeven                     Geert.Uytterhoeven@cs.kuleuven.ac.be
Wavelets, Linux/{m68k~Amiga,PPC~CHRP}  http://www.cs.kuleuven.ac.be/~geert/
Department of Computer Science -- Katholieke Universiteit Leuven -- Belgium

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
