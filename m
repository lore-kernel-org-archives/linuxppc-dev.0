Message-ID: <35C119252057D511BB9F0003476BF8A208E65F@freexc01.smartm.com>
From: "Prasad, Siva" <Siva.Prasad@smartm.com>
To: "'Matt Porter'" <mporter@mvista.com>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: kernel/head.S start_here
Date: Thu, 15 Nov 2001 12:18:55 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Thanks a lot for the reply Matt. I understood how virtual memory is enabled
with SRR0 and SRR1. Thanks for the help.

>Inserting the card is probably exposing a bug in your PCI enumeration
>software or the board port's handling of PCI host bridge setup.

I don't think it is going until PCI enumeration software. Last thing it
prints is "Now booting kernel". After that it stops, if I put the PMC card.

Based on my preliminary investigation, I think code hangs some where around
the following instructions.
~~~~~~~~~~~~~~~
start_here:
#ifndef CONFIG_PPC64BRIDGE
	bl	enable_caches
#endif

	/* ptr to current */
	lis	r2,init_task_union@h
	ori	r2,r2,init_task_union@l
	/* Set up for using our exception vectors */
	/* ptr to phys current thread */
	tophys(r4,r2)
	addi	r4,r4,THREAD	/* init task's THREAD */
	CLR_TOP32(r4)
	mtspr	SPRG3,r4
	li	r3,0
	mtspr	SPRG2,r3	/* 0 => r1 has kernel sp */

	/* stack */
	addi	r1,r2,TASK_UNION_SIZE
	li	r0,0
	stwu	r0,-STACK_FRAME_OVERHEAD(r1)
~~~~~~~~~~~~~~~~

What I don't understand is, how come this part of code is creating problem
with Linux booting if I plug in the other PMC card. How is this related to
PCI?.

Is there any way to debug where it hangs when virtual memory is ON. It hangs
if I call a C routine to printk in the middle of this code.

Thanks once again Matt.

-- Siva



-----Original Message-----
From: Matt Porter [mailto:mporter@mvista.com]
Sent: Wednesday, November 14, 2001 6:44 PM
To: Prasad, Siva
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: kernel/head.S start_here


On Wed, Nov 14, 2001 at 06:06:38PM -0800, Prasad, Siva wrote:
>
> Hi,
>
> I am using HHL2.0 PCore LSP to build my Embedded Linux on PPC 750.
>
> In the arch/ppc/kernel/head.S, there is a branch to
"start_here" using SRR0
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
> In the code above, address of start_here is moved to register
r0. Here it is
> moving the address "c00..." as value, and will not be changed
as the code is
> relocated.
> What beats me is ... How come it is able to go to label pointed by
> "start_here"?.

Huh?  It's pretty simple, SRR1 gets RMW'ed with MMU enable bits.  Then
SRR0 is loaded with the value of start_here.  In most people's world
that will be c00... since most people run with the classic PAGE_OFFSET
of 0xc0000000.  So, the rfi "restores" the MSR enabling the MMU and
"returns from interrupt" to "c00..." which is the address of
start_here.
There is no relocation, MMU comes on and you are accessing the code
at the virtual addresses that the kernel was actually linked at.

> Whole issue came because, When I plug in a PMC card into
another PMC slot,
> Linux doesn't boot (hangs after printing "Now booting
kernel"). I used JTAG
> to find out that, it is branching to "c000..." location
(because of the
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

> What I don't understand is... "How come Linux boots when this
card is not
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
