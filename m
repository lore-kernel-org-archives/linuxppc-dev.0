Return-Path: <alex@astech.at>
Received: from sun.astech.local (62-99-150-78.static.adsl-line.inode.at
	[62.99.150.78]) by ozlabs.org (Postfix) with ESMTP id 72820679E1
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  6 May 2006 18:50:23 +1000 (EST)
Subject: RE: Calculating virtual address from physical address
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Sat, 6 May 2006 10:43:53 +0200
Message-ID: <78A4D4CFEEA72D4D89EEAAD7AD8300BF3241@sun.astech.local>
From: "Alexander Szekely" <alex@astech.at>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> How is a virtual address=20
> calculated for a high address like 0x4F600000?

Add this to the MMU initialzation code (initial_mmu):

/* map leds - 1:1 phys=3Dvirt */
	lis	r3,0x4F600000@h
	ori	r3,r3,0x4F600000@l
	mr	r4,r3
	clrrwi	r4,r4,12
	ori	r4,r4,(TLB_WR|TLB_I|TLB_M|TLB_G)

	clrrwi	r3,r3,12
	ori	r3,r3,(TLB_VALID | TLB_PAGESZ(PAGESZ_4K))

	li	r0,0			/* TLB slot 0 */
	tlbwe	r4,r0,TLB_DATA
	tlbwe	r3,r0,TLB_TAG

Then you have a one to one mapping between physical and virtual memory,=20
and you can access the LEDs at the same address after turning one the
MMU.

BTW, we had a similar problem, but the reason was not turning on the
MMU. The MMU is enabled by writing MSR_KERNEL the status register. This
also enables the machine state exception interrupt.=20

Our hardware design produced PLB bus exceptions, which was unnoticed on
standalone applications. But this bus exceptions also trigger machine
state exceptions. So instead of jumping to start_here the processor
branched to 0x200 - unfortunatly the trap table is not set up at this
point in the boot process...

Alex=20
