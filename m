Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id 44533DDDF6
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Apr 2009 02:00:59 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1Lp1w0-0002ju-8t
	for linuxppc-dev@ozlabs.org; Wed, 01 Apr 2009 08:00:56 -0700
Message-ID: <22828498.post@talk.nabble.com>
Date: Wed, 1 Apr 2009 08:00:56 -0700 (PDT)
From: "Sauce.Cheng" <chmhou@sina.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: issue at the beginning of kernel booting
In-Reply-To: <20090327161522.GA7809@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <20090327083628.4C3E93EE530@mail2-203.sinamail.sina.com.cn>
	<20090327161522.GA7809@ld0162-tx32.am.freescale.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


thanks Scott!

> That is very old code; you're more likely to get help when running
> something up-to-date.

i have a latest u-boot-2009.03 updated instead of mine, and kernel version
is instead of 2.6.24.5

> This alternative was listed as text/plain.  &nbsp is not plaintext. 
> Please fix your mailer (and better yet, don't send HTML at all).

yeah, it is my fault. i am a newer of mail lists , i will be careful next
time.

> I doubt that it is actually halting here; more likely, you're just
> hitting a spot in the boot sequence where it's not safe to access your
> LEDs or other I/O, because you have the MMU off and the cache enabled.

> You'll typically be much better off leaving the very early code alone
> (it's almost never the culprit), except to ensure that you have a BAT
> mapping (cache-inhibited and guarded) for the I/O you want to use for
> debugging.  Then, only touch that I/O device *after* the MMU is on and
> your mapping is in place.

according to your point, i have moved the codes used for debuging to the
place where after mmu being on, then there is nothing happened. it indicated
that proforming had halt before this.

i dont think there may be likely had some wrong in kernel source. but
actually it halt there in early code.

first i guess the reason that before i boot kernel without fdt. it still
halt after wiht fdt.

now i show my early code with debug code, please check it what fault is more
likely. 


early code 


	/* initialize LEDs, used by Port B */
	lis	r8, (0x000000FF)@h
	ori	r8, r8, (0x000000FF)@l
	lis	r9, (M8247_IOP_PDIRB(0xF0000000))@h		//define 0x10D20 as
M8247_IOP_PDIRB(Port B dir)
	lis	r9, r9, (M8247_IOP_PDIRB(0xF0000000))@l		//define 0x10D30 as
M8247_IOP_PDATB(Port B dat)
	stw	r8, 0(r9)

	/* turn D1 , successful */
	lis	r8, (0xFFFFFFFE)@h
	ori	r8, r8, (0xFFFFFFFE)@l
	lis	r9, (M8247_IOP_PDATB(0xF0000000))@h		
	lis	r9, r9, (M8247_IOP_PDATB(0xF0000000))@l		
	stw	r8, 0(r9)

	bl	early_init
/* here : mmu off: */
 	addi	r4, r3, __after_mmu_off - _start
	mfmsr	r3
	andi.	r0,r3,MSR_DR|MSR_IR		/* MMU enabled? */
	beqlr
	andc	r3,r3,r0
	mtspr	SPRN_SRR0,r4
	mtspr	SPRN_SRR1,r3
	sync
	RFI
__after_mmu_off:
/* here : clear_bats: */ 
	li	r10,0
	mfspr	r9,SPRN_PVR
	rlwinm	r9,r9,16,16,31		/* r9 = 1 for 601, 4 for 604 */
	cmpwi	r9, 1	
	beq	1f			// my core is 603e, so both DBATx and IBATx should be initialized.

	mtspr	SPRN_DBAT0U,r10
		.
		.
		.
	mtspr	SPRN_DBAT3L,r10
1:
	mtspr	SPRN_IBAT0U,r10
		.
		.
		.
	mtspr	SPRN_IBAT3L,r10
BEGIN_FTR_SECTION			// CPU_FTR_HAS_HIGH_BATS is default feature for G2_LE
core
	mtspr	SPRN_DBAT4U,r10
		.
		.
		.
	mtspr	SPRN_IBAT7L,r10
END_FTR_SECTION_IFSET(CPU_FTR_HAS_HIGH_BATS)	
	blr

/* here: flush_tlbs: */
	lis	r10, 0x40
1:	addic.	r10, r10, -0x1000
	tlbie	r10
	blt	1b
	sync
	blr
/* here : initial_bats: */ 
	lis	r11,KERNELBASE@h
	mfspr	r9,SPRN_PVR
	rlwinm	r9,r9,16,16,31		/* r9 = 1 for 601, 4 for 604 */
	cmpwi	0,r9,1
	bne	4f
4:	tophys(r8,r11)
	ori	r8,r8,2			/* R/W access */
	ori	r11,r11,BL_16M<<2|0x2	/* set up BAT registers for 604 */
	mtspr	SPRN_DBAT0L,r8		/* N.B. 6xx (not 601) have valid */
	mtspr	SPRN_DBAT0U,r11		/* bit in upper BAT register */
	mtspr	SPRN_IBAT0L,r8
	mtspr	SPRN_IBAT0U,r11
	isync
	blr
	bl	reloc_offset
	li	r24,0			/* cpu# */
	bl	call_setup_cpu		/* Call setup_cpu for this CPU */
here jump to call_setup_cpu, actually invoked setup_common_caches.
setup_common_caches:
	/* turn D1 and D2 , successful */
	lis	r15, (0xFFFFFFFC)@h
	ori	r15, r15, (0xFFFFFFFC)@l
	lis	r16, (M8247_IOP_PDATB(0xF0000000))@h		
	lis	r16, r16, (M8247_IOP_PDATB(0xF0000000))@l		
	stw	r15, 0(r16)


	mfspr	r11,SPRN_HID0
	andi.	r0,r11,HID0_DCE
	ori	r11,r11,HID0_ICE|HID0_DCE
	ori	r8,r11,HID0_ICFI
	bne	1f			/* don't invalidate the D-cache */
	ori	r8,r8,HID0_DCI		/* unless it wasn't enabled */
1:	sync
	mtspr	SPRN_HID0,r8		/* enable and invalidate caches */

	/* turn D1,D2 and D3 , fault */
	lis	r15, (0xFFFFFFF8)@h
	ori	r15, r15, (0xFFFFFFF8)@l
	lis	r16, (M8247_IOP_PDATB(0xF0000000))@h		
	lis	r16, r16, (M8247_IOP_PDATB(0xF0000000))@l		
	stw	r15, 0(r16)
	sync
	mtspr	SPRN_HID0,r11		/* enable caches */
	sync
	isync
	blr
here, if i removed the HID0_DCE, will be normal. in this situation , at
turn_on_mmu:, after enter start_here, will halt there.

Sauce
-- 
View this message in context: http://www.nabble.com/issue-at-the-beginning-of-kernel-booting-tp22741532p22828498.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
