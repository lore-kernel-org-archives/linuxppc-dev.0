Return-Path: <cdumoulin@ics-ltd.com>
Received: from mx1.magmacom.com (mx1.magmacom.com [206.191.0.217])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AAC35679F8
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  6 May 2006 01:08:49 +1000 (EST)
Received: from mail3.magma.ca (mail3.magma.ca [206.191.0.221])
	by mx1.magmacom.com (8.13.6/8.13.0) with ESMTP id k45F8j4M030039
	for <linuxppc-embedded@ozlabs.org>; Fri, 5 May 2006 11:08:46 -0400
Received: from [192.9.200.156] ([64.26.174.130]) (authenticated bits=0)
	by mail3.magma.ca (Magma's Mail Server) with ESMTP id k45F8e5f009158
	for <linuxppc-embedded@ozlabs.org>; Fri, 5 May 2006 11:08:44 -0400
Message-ID: <445B6A80.2090202@ics-ltd.com>
Date: Fri, 05 May 2006 11:08:48 -0400
From: Chris Dumoulin <cdumoulin@ics-ltd.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Calculating virtual address from physical address
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I'm using a Virtex II Pro-based board with a PPC405. The board is 
hanging somewhere very early in the kernel boot process. I believe it 
may be dying at the point where the MMU is enabled. In order to 
determine the exact point at which my board hangs, I'm blinking two LEDs 
in the assembly code found in arch/ppc/kernel/head_4xx.S, . Currently I 
am only able to successfully access the LEDs before the MMU is turned 
on, but I can't be sure that I'm calculating the virtual address 
properly when I try to access the LED after the MMU is turned on.

My LEDs are at address 0x4F600000 and my CONFIG_KERNEL_START is 
0xC0000000. If this address were low enough, I would just add 0xC0000000 
to the address to get the virtual address, but since my LED address is 
so high, the sum will be well past the 32-bit maximum address value. How 
is a virtual address calculated for a high address like 0x4F600000?

BTW, he is the assembly code that I'm working with (from 
arch/ppc/kernel/head_4xx.S):

    .text
_GLOBAL(_stext)
_GLOBAL(_start)

    /* Save parameters we are passed.
    */
    mr    r31,r3
    mr    r30,r4
    mr    r29,r5
    mr    r28,r6
    mr    r27,r7
   
    /* CRD: set LED state here */
    lis    r26,0x4F600000@h
    ori    r26,r26,0x4F600000@l
    li  r25,LED_STATE_0
    stw r25,0(r26)
   
    /* We have to turn on the MMU right away so we get cache modes
     * set correctly.
     */
    bl    initial_mmu
   
    /* CRD: set LED state here */
    lis    r26,0x4F600000@h
    ori    r26,r26,0x4F600000@l
    li  r25,LED_STATE_1
    stw r25,0(r26)

/* We now have the lower 16 Meg mapped into TLB entries, and the caches
 * ready to work.
 */
turn_on_mmu:
    lis    r0,MSR_KERNEL@h
    ori    r0,r0,MSR_KERNEL@l
    mtspr    SPRN_SRR1,r0
    lis    r0,start_here@h
    ori    r0,r0,start_here@l
    mtspr    SPRN_SRR0,r0
    SYNC
   
    /* CRD: set LED state here */
    lis    r26,0x4F600000@h
    ori    r26,r26,0x4F600000@l
    li  r25,LED_STATE_2
    stw r25,0(r26)
   
    rfi                /* enables MMU */
   
    /* CRD: set LED state here */
    /* This address should be a virtual address */
    lis    r26,0x4F600000@h
    ori    r26,r26,0x4F600000@l
    li  r25,LED_STATE_3
    stw r25,0(r26)
   
    b    .            /* prevent prefetch past rfi */

Regards,
Chris Dumoulin
-- 
*--Christopher Dumoulin--*
Software Team Leader

<http://ics-ltd.com/>
<http://ics-ltd.com/>

Interactive Circuits and Systems Ltd.
5430 Canotek Road
Ottawa, ON
K1J 9G2
(613)749-9241
1-800-267-9794 (USA only)

------------------------------------------------------------------------
This e-mail is private and confidential and is for the addressee only. 
If misdirected, please notify us by telephone and confirm that it has 
been deleted from your system and any hard copies destroyed. You are 
strictly prohibited from using, printing, distributing or disseminating 
it or any information contained in it save to the intended recipient.
