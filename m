Message-ID: <35C119252057D511BB9F0003476BF8A208E65C@freexc01.smartm.com>
From: "Prasad, Siva" <Siva.Prasad@smartm.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: kernel/head.S start_here
Date: Wed, 14 Nov 2001 18:06:38 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="GB2312"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I am using HHL2.0 PCore LSP to build my Embedded Linux on PPC 750.

In the arch/ppc/kernel/head.S, there is a branch to "start_here" using SRR0
and SRR1.
~~~~~~~~~~~~~~~~
turn_on_mmu:
	mfmsr	r0
	ori	r0,r0,MSR_DR|MSR_IR
	mtspr	SRR1,r0
	lis	r0,start_here@h
	ori	r0,r0,start_here@l
	mtspr	SRR0,r0
	SYNC
	RFI				/* enables MMU */
~~~~~~~~~~~~~~~~

In the code above, address of start_here is moved to register r0. Here it is
moving the address "c00..." as value, and will not be changed as the code is
relocated.
What beats me is ... How come it is able to go to label pointed by
"start_here"?.

Whole issue came because, When I plug in a PMC card into another PMC slot,
Linux doesn't boot (hangs after printing "Now booting kernel"). I used JTAG
to find out that, it is branching to "c000..." location (because of the
above mentioned problem), instead of going to correct locations after
relocation. Those "c00..." locations are PCI locations.
What I don't understand is... "How come Linux boots when this card is not
plugged in, even though it branches to "c00...".

Any pointers would be great.

Thanks,
-- Siva Prasad

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
