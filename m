Message-ID: <A109131318C4D1119AC20060088DECE330F446@amwmail.adaptivemicro.com>
From: Lucinda Schafer <lucsch@adaptivemicro.com>
To: Michael Coy <mac12@po.cwru.edu>, linuxppc-embedded@lists.linuxppc.org
Subject: RE: PCMCIA ATA flash support?
Date: Tue, 20 Jun 2000 09:08:34 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Michael,

We are not using Montavista's Hardhat Linux or a RPX lite; but we are using
the tarball version of 2.2.13 and a board with a MPC823. We also are not
using a PCMCIA card, but we are experiencing occasional, but persistent,
KERNEL Mode Software FPU Emulation Panics. This error is unrelated to the
FPU emulation. It occurs upon an illegal access to a register or an illegal
execution of a nonsupported opcode. So far, all we have determined is that
it has something to to with the memory management and page switching.

Since it is so intermittent for us and usually occurs on boot-up, we are
having trouble debugging this. Perhaps you have found a case which
consistently forces this error. Please keep us updated on your findings.

Hint: add a backtrace print out to the traps.c file in the Software
Emulation routine where the panic is called. Use your System.map file to see
if you can find the last functions called, for example:
      		show_regs(regs);
	   		print_backtrace( (unsigned long *)regs->gpr[1] );
	   		instruction_dump((unsigned long *)regs->nip);
			panic("Kernel Mode Software FPU Emulation");

Lucinda Schafer

Adaptive Micro-Ware, Inc.


-----Original Message-----
From: Michael Coy [mailto:mac12@po.cwru.edu]
Sent: Tuesday, June 20, 2000 8:29 AM
To: linuxppc-embedded@lists.linuxppc.org
Subject: PCMCIA ATA flash support?



I'm trying to get PCMCIA support working on Montavista's Hardhat linux and
an RPX lite (MPC 823).  The PC card I'm using is a SanDisk ATA flashdisk,
if that makes a difference.

I've got the patches from absoval.com and followed all the instructions in
their doc.  I also have read the PCMCIA howto.

I can insmod the pcmcia drivers, and a cardctl ident does identify the
card to be a SunDisk fixed disk.

But as soon as I start cardmgr to attach the IDE device, I get:
kernel panic: Kernel Mode Software FPU Emulation

I've tried compiling the kernel both with and without FPU emulation, and
I've also tried changing the memory addresses, as suggested by the PCMCIA
howto.  I even tried replacing the card.  Nothing seems to make a
difference.

Any suggestions would be greatly appreciated.
Thanks,
mike


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
