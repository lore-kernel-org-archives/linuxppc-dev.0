Date: Wed, 14 Nov 2001 19:44:30 -0700
From: Matt Porter <mporter@mvista.com>
To: "Prasad, Siva" <Siva.Prasad@smartm.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: kernel/head.S start_here
Message-ID: <20011114194429.A16189@cx258813-a.chnd1.az.home.com>
References: <35C119252057D511BB9F0003476BF8A208E65C@freexc01.smartm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <35C119252057D511BB9F0003476BF8A208E65C@freexc01.smartm.com>; from Siva.Prasad@smartm.com on Wed, Nov 14, 2001 at 06:06:38PM -0800
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Nov 14, 2001 at 06:06:38PM -0800, Prasad, Siva wrote:
>
> Hi,
>
> I am using HHL2.0 PCore LSP to build my Embedded Linux on PPC 750.
>
> In the arch/ppc/kernel/head.S, there is a branch to "start_here" using SRR0
> and SRR1.
> ~~~~~~~~~~~~~~~~
> turn_on_mmu:
> 	mfmsr	r0
> 	ori	r0,r0,MSR_DR|MSR_IR
> 	mtspr	SRR1,r0
> 	lis	r0,start_here@h
> 	ori	r0,r0,start_here@l
> 	mtspr	SRR0,r0
> 	SYNC
> 	RFI				/* enables MMU */
> ~~~~~~~~~~~~~~~~
>
> In the code above, address of start_here is moved to register r0. Here it is
> moving the address "c00..." as value, and will not be changed as the code is
> relocated.
> What beats me is ... How come it is able to go to label pointed by
> "start_here"?.

Huh?  It's pretty simple, SRR1 gets RMW'ed with MMU enable bits.  Then
SRR0 is loaded with the value of start_here.  In most people's world
that will be c00... since most people run with the classic PAGE_OFFSET
of 0xc0000000.  So, the rfi "restores" the MSR enabling the MMU and
"returns from interrupt" to "c00..." which is the address of start_here.
There is no relocation, MMU comes on and you are accessing the code
at the virtual addresses that the kernel was actually linked at.

> Whole issue came because, When I plug in a PMC card into another PMC slot,
> Linux doesn't boot (hangs after printing "Now booting kernel"). I used JTAG
> to find out that, it is branching to "c000..." location (because of the
> above mentioned problem), instead of going to correct locations after
> relocation. Those "c00..." locations are PCI locations.

Are you confusing the difference between virtual, physical, PCI I/O,
and PCI Mem spaces?  They are all different.  You might have a
CHRP-like memory map (most good designs do) and PCI mem space and
CPU physical address space will be mapped 1:1 (i.e. no address
translation).  In a CHRP-like map you're basically talking about
0x80000000-0xfXXXXXXX CPU physical and PCI mem being the same. You're
claiming that it is branching to a "c000..." location that is
PCI but that's not the case since the execution addresses are
virtual addresses, not the 1:1 mapped CPU physical and PCI mem
addresses.

> What I don't understand is... "How come Linux boots when this card is not
> plugged in, even though it branches to "c00...".

See above summary.  Your booting problem has nothing to do with
how the MMU is utilized in Linux.  If you've always worked on flat
memory model RTOSes then you should do some reading on the Linux VM
model if you really want to understand what you are working on.

> Any pointers would be great.

Inserting the card is probably exposing a bug in your PCI enumeration
software or the board port's handling of PCI host bridge setup.

--
Matt Porter
MontaVista Software, Inc.
mporter@mvista.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
