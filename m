Message-ID: <39528FC7.DD7983BC@embeddededge.com>
Date: Thu, 22 Jun 2000 18:14:31 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Lucinda Schafer <lucsch@adaptivemicro.com>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Software Emulation Panic,
References: <A109131318C4D1119AC20060088DECE330F4C0@amwmail.adaptivemicro.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Lucinda Schafer wrote:
>
> When I get a kernel panic I see:
>
> NIP: 00001FFC XER: 8000FF7F LR: 00000988 REGS: c0e87c90 TRAP: 1000
> MSR: 00001000 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 00

Well, this one is pretty easy.  PR, IR, DR all zero.  So you were
executing in kernel space with the MMU disabled.  This is standard
context phase 1 exception processing.  Trap 0x1000 is an illegal
or unimplemented instruction.

The root of the problem is the kernel executed an illegal instruction
while exception processing.  I know there isn't any valid code at
00001ffc, so you need to determine how it got there.  Since the
kernel executes very little code in this state, you either have written
over some instructions, which isn't likely because the kernel is write
protected and you would get a different fault, or the memory subsystem
supplied some bogus bits during an instruction fetch, or while restoring
some processor context it read bad bits from memory.

I'd say, attach a logic analyzer, trigger on this trap, and determine
how it got those bits.



	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
