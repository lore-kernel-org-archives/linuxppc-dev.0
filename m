Date: Fri, 22 Jan 1999 11:14:09 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: Marc Dejardin <Marc.Dejardin@cern.ch>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Kernel panic with Xpmac (and XFree86) using recent kernel
 2.2.0-pre7
In-Reply-To: <Pine.A41.3.95a.990122092204.43606A-200000@rsplus13.cern.ch>
Message-ID: <Pine.LNX.4.03.9901221109160.13526-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 22 Jan 1999, Marc Dejardin wrote:
> On Thu, 21 Jan 1999, Geert Uytterhoeven wrote:
> > > Linux version 2.2.0-pre7 (dejard1@xxxxxx.xxxxxx.xxx.fr) (gcc version
> > > egcs-2.91.57 19980901 (egcs-1.1 release)) #1 Fri Jan 15 15:50:46 CET 1999
> > > 
> > > ONE KERNEL PANIC :
> > > 
> > > Jan 18 09:26:21 xxxxxx kernel: NIP: C00CDF9C XER: E000BE6F LR: C00347CC REGS: c2535cb0 TRAP: 0300
> >                                       ^^^^^^^^
> > > Jan 18 09:26:21 xxxxxx kernel: MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
> > > Jan 18 09:26:21 xxxxxx kernel: TASK = c2534000[304] 'X' mm->pgd c245e000 Last syscall: 142 
> > > Jan 18 09:26:21 xxxxxx kernel: last math c2534000
> > > Jan 18 09:26:21 xxxxxx kernel: GPR00: C00347CC C2535DA0 C2534000 00000407 00000000 00000000 00000000 C23006C4 
> > > Jan 18 09:26:21 xxxxxx kernel: GPR08: 00000010 C0160000 00000004 C24E5A40 95533E39 01A87568 01A80000 6C7A336E 
> > > Jan 18 09:26:21 xxxxxx kernel: GPR16: 01A8B3AC 01A8B52C 00000000 553DBE39 533DBE39 C2F58280 C2535E18 00000001 
> > > Jan 18 09:26:21 xxxxxx kernel: GPR24: 00002ECD C2F58000 0000000F 00000000 C015A39C C2F58000 00000407 C1E8E000 
> > > Jan 18 09:26:21 xxxxxx kernel: Call backtrace: 
> > > Jan 18 09:26:21 xxxxxx kernel: C2F58000 C00347CC C0034BB8 C0007A70 C0003898 01837B64 0180E1D4 
> >                                  ^^^^^^^^ ^^^^^^^^ ^^^^^^^^ ^^^^^^^^ ^^^^^^^^ ^^^^^^^^ ^^^^^^^^
> > > Jan 18 09:26:21 xxxxxx kernel: 01822310 01801BD4 
> >                                  ^^^^^^^^ ^^^^^^^^
> > Please look up these numbers in your System.map.
> > 
> > > Jan 18 09:26:21 xxxxxx kernel: Instruction DUMP: 41820028  3d20c019  83a94558 <4bf5b87d> 7c641b78  7f85e378  7fa3eb78  4bf44fa5  38000001 
> > > Jan 18 09:26:21 xxxxxx kernel: Kernel panic: kernel access of bad area pc c00cdf9c lr c00347cc address 453 tsk X/304
> >                                                                                                          ^^^
> > 0x453, makes me think of a NULL pointer dereference for a struct.
> > 
> Hello,
> I have join my System.map in attached document, because I don't really know how
> to use it in order to debug my problem...

Just look for addresses in System.map that are equal or lower than the ones
mentioned in `NIP' and `Call backtrace':

    C00CDF9C	c00cdf44 t tty_poll
    C2F58000
    C00347CC	c00346a8 T do_select
    C0034BB8	c00348c8 T sys_select
    C0007A70	c00079cc T ppc_select
    C0003898	c0003898 T syscall_ret_1

> By the way, to check if it is due to the old Xpmac X server I have installed
> XFree86 and run XF68_FBDev but I got the same kernel panic after a while :
> (I am running afterstep-1.0-7a)
> 
> Jan 21 17:40:14 xxxxxx kernel: NIP: C00D1D24 XER: C000BE6F LR: C00CDFF0 REGS: c0e7bc80 TRAP: 0300
> Jan 21 17:40:14 xxxxxx kernel: MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
> Jan 21 17:40:14 xxxxxx kernel: TASK = c0e7a000[689] 'X' mm->pgd c0923000 Last syscall: 142 
> Jan 21 17:40:14 xxxxxx kernel: last math c0e7a000
> Jan 21 17:40:14 xxxxxx kernel: GPR00: 00000000 C0E7BD70 C0E7A000 C417C390 C417C360 00000000 00000000 00000000 
> Jan 21 17:40:14 xxxxxx kernel: GPR08: C0945970 00000043 00000003 00000000 95533E33 01A74968 01A7E204 01A7E384 
> Jan 21 17:40:14 xxxxxx kernel: GPR16: 7DB169DC 01A80000 00000000 553DBE33 533DBE33 C1B0C280 C0E7BE18 00000001 
> Jan 21 17:40:14 xxxxxx kernel: GPR24: 0000E7AC C1B0C000 C417C360 00000000 00000001 C417C390 C417C360 C0945000 
> Jan 21 17:40:14 xxxxxx kernel: Call backtrace: 
> Jan 21 17:40:14 xxxxxx kernel: C1B0C000 C00CDFF0 C00347CC C0034BB8 C0007A70 C0003898 018699B4 
> Jan 21 17:40:14 xxxxxx kernel: 0183F6A4 01853E84 01821A30 
> Jan 21 17:40:14 xxxxxx kernel: Instruction DUMP: 7f800038  7c1c4b78  41820024 <817f0130> 63890043  880b012d  3000ffff  7c000110  7d290078 
> Jan 21 17:40:14 xxxxxx kernel: Kernel panic: kernel access of bad area pc c00d1d24 lr c00cdff0 address 12D tsk X/689
> Jan 21 17:44:42 xxxxxx syslogd 1.3-3: restart.

    C00D1D24	c00d1ae0 t normal_poll
    C1B0C000
    C00CDFF0	c00cdf44 t tty_poll
    C00347CC	c00346a8 T do_select
    C0034BB8	c00348c8 T sys_select
    C0007A70	c00079cc T ppc_select
    C0003898	c0003898 T syscall_ret_1

But this doesn't ring a bell for me...

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
