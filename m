Return-Path: <clark@esteem.com>
Received: from mail5.hsphere.cc (mail5.hsphere.cc [216.157.145.25])
	by ozlabs.org (Postfix) with SMTP id 0E34867B24
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  6 May 2005 03:06:51 +1000 (EST)
Message-ID: <427A52A5.8020203@esteem.com>
Date: Thu, 05 May 2005 10:06:45 -0700
From: Conn Clark <clark@esteem.com>
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
References: <20050502204259.GB4065@logos.cnet> <4277BF8F.8040206@esteem.com>
	<20050504192238.GA3461@logos.cnet>
In-Reply-To: <20050504192238.GA3461@logos.cnet>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: CONFIG_PIN_TLB experiments
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Marcelo Tosatti wrote:
> Hi,
> 
> On Tue, May 03, 2005 at 11:14:39AM -0700, Conn Clark wrote:
> 
>>Marcelo Tosatti wrote:
>>
>>>Hi 8xx folks,
>>
>><SNIP>
>>
>>>Actually, CONFIG_PIN_TLB slowdowns the system, as expected (there are only 
>>>28 usable TLB's instead of 32).
>>>
>>>
>>>v2.6 CONFIG_PIN_TLB:
>>>I-TLB userspace misses: 162113
>>>I-TLB kernel misses: 135911
>>>D-TLB userspace misses: 289452
>>>D-TLB kernel misses: 257039
>>>
>>>v2.6 without CONFIG_PIN_TLB:
>>>I-TLB userspace misses: 160828
>>>I-TLB kernel misses: 134746
>>>D-TLB userspace misses: 253557
>>>D-TLB kernel misses: 227383
>>>
>>>
>>
>>Considering that the TLB kernel misses are higher with tlb pinning it 
>>appears as though the pinned TLBs are not marked as valid.
> 
> 
> Yep
> 
> 
>>>The following BDI output shows the pinned, 8MByte data page mapping 
>>>present,
>>>at 0xc0000000.
>>>
>>>BDI>rds 826
>>>SPR  826 : 0x00007f00        32512
>>>BDI>rms 792 0x0c001C00
>>>BDI>rms 824 1
>>>BDI>rds 824
>>>SPR  824 : 0xc00000f0  -1073741584
>>>BDI>rds 825
>>>SPR  825 : 0x00000fe0         4064
>>>BDI>rds 826
>>>SPR  826 : 0x00007fff        32767       <- "0x00007fff" was 0x00007f00" 
>>>initially. I tried enabling 
>>>				             usermode access without
>>>					     success.
>>>
>>>There are several 4Kb mappings inside the range covered by this 8Mb TLB 
>>>entry, for example: 
>>>
>>>BDI>rms 792 0x0c000200
>>>BDI>rms 824 1
>>>BDI>rds 824
>>>SPR  824 : 0xc0224f17  -1071493353
>>>BDI>rds 825
>>>SPR  825 : 0x002241e0      2245088
>>>BDI>rds 826
>>>SPR  826 : 0x00007f00        32512
>>>
>>>And more, without so much detail:
>>>SPR  824 : 0xc0224f17  -1071493353
>>>SPR  824 : 0xc01fbf17  -1071661289
>>>SPR  824 : 0xc0246f17  -1071354089
>>>SPR  824 : 0xc023ff17  -1071382761
>>>SPR  824 : 0xc7e35f17  - 941400297
>>>SPR  824 : 0xc0244f17  -1071362281
>>>SPR  824 : 0xc023ef17  -1071386857
>>>
>>>Note that protection (SPR 826) is exactly the same as the 8Mbyte page 
>>>protection. 
>>>Why is the translation mechanism rejection the pinned mappings? 
>>>
>>>Dan, have you ever seen this work? Am I misunderstanding how the pinned
>>>entries are supposed to work? 
>>
>>When you load the Mx_EPN of the pinned area is the EV bit being set?
> 
> 
> Yep.
> 
> 
> "MD_RAM1" (SPR 826) is set:  
> 
> SPR  826 : 0x00007fff        32767       <- "0x00007fff" was 0x00007f00"
> 					     
> Bits 17 and 18 are set. Their meaning is: "Change bit for DTLB entry" and 
> "Entry valid flag" respectively. 
> Bits 19...23 are also set, they represent supervisor access. Note that 
> bit 23 "supervisor access type" is set: 0 is read-only, 1 is read-write.
> 
> so everything looks OK here.
> 
> "MD_RAM0":
> 
> SPR  825 : 0x00000fe0         4064
> 
> Bits 20...26 are set. 
> 
> 20-22: 8Mbyte page set.
> 23-26: APGI (access protection group in 1's complement) set. It is 
> zero (1111 in 1's complement).
> 27: guarded memory not set.
> 
> "MD_CAM":
> 
> SPR  824 : 0xc00000f0  -1073741584
> 
> Bits 24-27 are set. 
> 
> 24-26 is "page size" (111 = 8Mb) and 27 indicates "shared page" 
> (ASID comparisong disabled). 
> 
> The 8Mbyte page is used at boot, from "start_here" until "MMU_init()" 
> gets called... 
> 
> The manual says, section "9.3 Address Translation" 
> 
> "When TLB logic detects that a new effective page number (EPN) overlaps 
> one in the TLB (when taking into account page sizes, subpage validity flags,
> user/supervisor state, etc. the new EPN is written and the old one is 
> invalidated." 
> 
> I'm trying to boot a kernel which does not create kernel pte's 
> from 0xc000000 till 0xc080000. 
> 

Well, looking at the sources I currently have, 2.6.8 and 2.4.27, I 
noticed that InstructionTLBMiss in 2.6 is missing some ifdefs that the 
2.4 has that pertain to TLB pinning. Otherwise the code appears 
basically the same.


**** begin 2.6.8 code ****

InstructionTLBMiss:
#ifdef CONFIG_8xx_CPU6
	stw	r3, 8(r0)
	li	r3, 0x3f80
	stw	r3, 12(r0)
	lwz	r3, 12(r0)
#endif
	mtspr	M_TW, r20	/* Save a couple of working registers */
	mfcr	r20
	stw	r20, 0(r0)
	stw	r21, 4(r0)
	mfspr	r20, SRR0	/* Get effective address of fault */
#ifdef CONFIG_8xx_CPU6
	li	r3, 0x3780
	stw	r3, 12(r0)
	lwz	r3, 12(r0)
#endif
	mtspr	MD_EPN, r20	/* Have to use MD_EPN for walk, MI_EPN can't */
	mfspr	r20, M_TWB	/* Get level 1 table entry address */

	/* If we are faulting a kernel address, we have to use the
	 * kernel page tables.
	 */
	andi.	r21, r20, 0x0800	/* Address >= 0x80000000 */
	beq	3f
	lis	r21, swapper_pg_dir@h
	ori	r21, r21, swapper_pg_dir@l
	rlwimi	r20, r21, 0, 2, 19
3:
	lwz	r21, 0(r20)	/* Get the level 1 entry */
	rlwinm.	r20, r21,0,0,19	/* Extract page descriptor page address */
	beq	2f		/* If zero, don't try to find a pte */

	/* We have a pte table, so load the MI_TWC with the attributes
	 * for this "segment."
	 */
	tophys(r21,r21)
	ori	r21,r21,1		/* Set valid bit */
#ifdef CONFIG_8xx_CPU6
	li	r3, 0x2b80
	stw	r3, 12(r0)
	lwz	r3, 12(r0)
#endif
	mtspr	MI_TWC, r21	/* Set segment attributes */
#ifdef CONFIG_8xx_CPU6
	li	r3, 0x3b80
	stw	r3, 12(r0)
	lwz	r3, 12(r0)
#endif
	mtspr	MD_TWC, r21	/* Load pte table base address */
	mfspr	r21, MD_TWC	/* ....and get the pte address */
	lwz	r20, 0(r21)	/* Get the pte */

	ori	r20, r20, _PAGE_ACCESSED
	stw	r20, 0(r21)

	/* The Linux PTE won't go exactly into the MMU TLB.
	 * Software indicator bits 21, 22 and 28 must be clear.
	 * Software indicator bits 24, 25, 26, and 27 must be
	 * set.  All other Linux PTE bits control the behavior
	 * of the MMU.
	 */
	li	r21, 0x00f0
	rlwimi	r20, r21, 0, 24, 28	/* Set 24-27, clear 28 */

#ifdef CONFIG_8xx_CPU6
	li	r3, 0x2d80
	stw	r3, 12(r0)
	lwz	r3, 12(r0)
#endif
	mtspr	MI_RPN, r20	/* Update TLB entry */

	mfspr	r20, M_TW	/* Restore registers */
	lwz	r21, 0(r0)
	mtcr	r21
	lwz	r21, 4(r0)
#ifdef CONFIG_8xx_CPU6
	lwz	r3, 8(r0)
#endif
	rfi

2:	mfspr	r20, M_TW	/* Restore registers */
	lwz	r21, 0(r0)
	mtcr	r21
	lwz	r21, 4(r0)
#ifdef CONFIG_8xx_CPU6
	lwz	r3, 8(r0)
#endif
	b	InstructionAccess

**** end 2.6.8 code ****










**** begin 2.4.27 code ****

InstructionTLBMiss:
#ifdef CONFIG_8xx_CPU6
	stw	r3, 8(r0)
	li	r3, 0x3f80
	stw	r3, 12(r0)
	lwz	r3, 12(r0)
#endif
	mtspr	M_TW, r20	/* Save a couple of working registers */
#if !defined(CONFIG_PIN_TLB) || defined(CONFIG_MODULES)
	mfcr	r20
	stw	r20, 0(r0)
#endif
	stw	r21, 4(r0)
	mfspr	r20, SRR0	/* Get effective address of fault */
#ifdef CONFIG_8xx_CPU6
	li	r3, 0x3780
	stw	r3, 12(r0)
	lwz	r3, 12(r0)
#endif
	mtspr	MD_EPN, r20	/* Have to use MD_EPN for walk, MI_EPN can't */
	mfspr	r20, M_TWB	/* Get level 1 table entry address */

#if !defined(CONFIG_PIN_TLB) || defined(CONFIG_MODULES)
	/* If we are faulting a kernel address, we have to use the
	 * kernel page tables.
	 */
	andi.	r21, r20, 0x0800	/* Address >= 0x80000000 */
	beq	3f
	lis	r21, swapper_pg_dir@h
	ori	r21, r21, swapper_pg_dir@l
	rlwimi	r20, r21, 0, 2, 19
3:
	lwz	r21, 0(r20)	/* Get the level 1 entry */
	rlwinm.	r20, r21,0,0,19	/* Extract page descriptor page address */
	beq	2f		/* If zero, don't try to find a pte */
#else
	lwz	r21, 0(r20)	/* Get the level 1 entry */
	mfcr	r20
	cmplwi	cr0, r21, 0x0fff /* Test page descriptor page address */
	bng-	2f		/* If zero, don't try to find a pte */
	mtcr	r20
#endif

	/* We have a pte table, so load the MI_TWC with the attributes
	 * for this "segment."
	 */
	tophys(r21,r21)
	ori	r21,r21,1		/* Set valid bit */
#ifdef CONFIG_8xx_CPU6
	li	r3, 0x2b80
	stw	r3, 12(r0)
	lwz	r3, 12(r0)
#endif
	mtspr	MI_TWC, r21	/* Set segment attributes */
#ifdef CONFIG_8xx_CPU6
	li	r3, 0x3b80
	stw	r3, 12(r0)
	lwz	r3, 12(r0)
#endif
	mtspr	MD_TWC, r21	/* Load pte table base address */
	mfspr	r21, MD_TWC	/* ....and get the pte address */
	lwz	r20, 0(r21)	/* Get the pte */

	ori	r20, r20, _PAGE_ACCESSED
	stw	r20, 0(r21)

	/* The Linux PTE won't go exactly into the MMU TLB.
	 * Software indicator bits 21, 22 and 28 must be clear.
	 * Software indicator bits 24, 25, 26, and 27 must be
	 * set.  All other Linux PTE bits control the behavior
	 * of the MMU.
	 */
	li	r21, 0x00f0
	rlwimi	r20, r21, 0, 24, 28	/* Set 24-27, clear 28 */

#ifdef CONFIG_8xx_CPU6
	li	r3, 0x2d80
	stw	r3, 12(r0)
	lwz	r3, 12(r0)
#endif
	mtspr	MI_RPN, r20	/* Update TLB entry */

	mfspr	r20, M_TW	/* Restore registers */
#if !defined(CONFIG_PIN_TLB) || defined(CONFIG_MODULES)
	lwz	r21, 0(r0)
	mtcr	r21
#endif
	lwz	r21, 4(r0)
#ifdef CONFIG_8xx_CPU6
	lwz	r3, 8(r0)
#endif
	rfi

2:		/* Restore registers
		*/
#if !defined(CONFIG_PIN_TLB) || defined(CONFIG_MODULES)
	lwz	r21, 0(r0)
	mtcr	r21
#else
	mtcr	r20
#endif
	mfspr	r20, M_TW
  	lwz	r21, 4(r0)
#ifdef CONFIG_8xx_CPU6
	lwz	r3, 8(r0)
#endif
	b	InstructionAccess


**** end 2.4.27 code ****

Does the current 2.6 kernel have these ifdefs in them?

-- Conn

*****************************************************************
Blessed be the heretic, for he causes some to think and unites
the rest against him.
*****************************************************************

Conn Clark
Engineering Assistant                clark@esteem.com
Electronic Systems Technology Inc.        www.esteem.com

Stock Ticker Symbol                ELST
