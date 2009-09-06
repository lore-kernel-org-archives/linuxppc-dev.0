Return-Path: <wilbur512@gmail.com>
Received: from mail-yw0-f199.google.com (mail-yw0-f199.google.com
	[209.85.211.199])
	by bilbo.ozlabs.org (Postfix) with ESMTP id 637D7B70CF
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  7 Sep 2009 00:27:32 +1000 (EST)
Received: by ywh37 with SMTP id 37so3074865ywh.17
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 06 Sep 2009 07:27:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4A98317B.6050805@linutronix.de>
References: <e997b7420908011825n4ba2df16u71d53953d6774c21@mail.gmail.com>
	<20090804194135.GA19171@www.tglx.de>
	<e997b7420908250909k74208353v81240eebd3d0896a@mail.gmail.com>
	<4A98317B.6050805@linutronix.de>
Date: Sun, 6 Sep 2009 22:27:23 +0800
Message-ID: <e997b7420909060727i5e67d354k2670187fb2adab8@mail.gmail.com>
Subject: Re: [PATCH 1/2] powerpc: add kexec support on FSL-Book-E
From: "wilbur.chan" <wilbur512@gmail.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

2009/8/29, Sebastian Andrzej Siewior <bigeasy@linutronix.de>:

> If you send some patches I could add them to my tree so we have
> everything together.

Hmmm..I don't know how to make a patch like yours.. So , I just
manually  list my

codes below which are added to  machine_kexec_32.c and misc_32.S respectively.




1) machine_kexec_32.c (only test on MPC8572, MPC8541 , P2020DS, so I

used macro here, the param of image->segment[image->nr_segments - 1].mem

is the dtb address)

//default_machine_kexec

+ #if defined(CONFIG_MPC8572_PC) || defined(CONFIG_P2020) ||
defined(CONFIG_MPC8560_ADS)
+ (*rnk)(page_list, reboot_code_buffer, image->start,
image->segment[image->nr_segments - 1].mem);
 +#else
 rnk = (relocate_new_kernel_t) reboot_code_buffer;
	(*rnk)(page_list, reboot_code_buffer_phys, image->start);
 +#endif



2) misc_32.S:


 define macro to setup mapping:


+#define FSL_BOOKE_MAS0(tlbsel,esel,nv) \
+ (MAS0_TLBSEL(tlbsel) | MAS0_ESEL(esel) | MAS0_NV(nv))

+#define FSL_BOOKE_MAS1(v,iprot,tid,ts,tsize) \
 + ((((v) << 31) & MAS1_VALID)             |\
  +(((iprot) << 30) & MAS1_IPROT)          |\
 + (MAS1_TID(tid))    |\
  +(((ts) << 12) & MAS1_TS)                |\
 + (MAS1_TSIZE(tsize)))


+#define FSL_BOOKE_MAS2(epn, wimge) \
  +(((epn) & MAS3_RPN) | (wimge))

+#define FSL_BOOKE_MAS3(rpn, user, perms) \
 + (((rpn) & MAS3_RPN) | (user) | (perms))




+ #ifdef CONFIG_E500

/* 1. Find the index of the entry we're executing in */
 bl invstr   /* Find our address */
 invstr:
 mflr r6   /* Make it accessible */
 mfmsr r7
 rlwinm r4,r7,27,31,31  /* extract MSR[IS] */
 mfspr r7, SPRN_PID0
 slwi r7,r7,16
 or r7,r7,r4
 mtspr SPRN_MAS6,r7
 tlbsx 0,r6   /* search MSR[IS], SPID=PID0 */
 mfspr r7,SPRN_MAS1
 andis. r7,r7,MAS1_VALID@h
 bne match_TLB

 /*
  * We search just in PID0 because kernel's global mapping has to be
  * there. We simply return to the caller if we didn't find the mapping
  * since we didn't (yet) pass the point of no return. This should not
  * happen.
  */
 mtlr r28
 blr

match_TLB:
 mfspr r7,SPRN_MAS0
 rlwinm r3,r7,16,20,31  /* Extract MAS0(Entry) */

 mfspr r7,SPRN_MAS1  /* Insure IPROT set */
 oris r7,r7,MAS1_IPROT@h
 mtspr SPRN_MAS1,r7
 tlbwe

/* 2. Invalidate all entries except the entry we're executing in */
 mfspr r9,SPRN_TLB1CFG
 andi. r9,r9,0xfff
 li r6,0   /* Set Entry counter to 0 */
1:
 lis r7,0x1000  /* Set MAS0(TLBSEL) = 1 */
 rlwimi r7,r6,16,4,15  /* Setup MAS0 = TLBSEL | ESEL(r6) */
 mtspr   SPRN_MAS0,r7
 tlbre
 mfspr r7,SPRN_MAS1
 rlwinm  r7,r7,0,2,31  /* Clear MAS1 Valid and IPROT */
 cmpw r3,r6
 beq skpinv   /* Dont update the current execution TLB */
 mtspr SPRN_MAS1,r7
 tlbwe
 isync
skpinv:
 addi r6,r6,1   /* Increment */
 cmpw r6,r9   /* Are we done? */
 bne 1b   /* If not, repeat */

 /* Invalidate TLB0 */
 li r6,0x04
 tlbivax 0,r6
 TLBSYNC
 /* Invalidate TLB1 */
 li r6,0x0c
 tlbivax 0,r6
 TLBSYNC


+#ifdef  CONFIG_MPC8572_PC || CONFIG_P2020
+ lis     r6,FSL_BOOKE_MAS0(1, 13, 0)@h
+ ori     r6,r6,FSL_BOOKE_MAS0(1, 13, 0)@l

 +lis     r7,FSL_BOOKE_MAS1(1, 1, 0, 0, BOOKE_PAGESZ_1GB)@h
 +ori     r7,r7,FSL_BOOKE_MAS1(1, 1, 0, 0, BOOKE_PAGESZ_1GB)@l

+ lis     r8,FSL_BOOKE_MAS2(0x00000000, (MAS2_I|MAS2_G))@h
 +ori     r8,r8,FSL_BOOKE_MAS2(0x00000000, (MAS2_I|MAS2_G))@l

+ lis     r9,FSL_BOOKE_MAS3(0x00000000, 0, (MAS3_SX|MAS3_SW|MAS3_SR))@h
+ ori     r9,r9,FSL_BOOKE_MAS3(0x00000000, 0,  (MAS3_SX|MAS3_SW|MAS3_SR))@l

 +mtspr   SPRN_MAS0,r6
+ mtspr   SPRN_MAS1,r7
 +mtspr   SPRN_MAS2,r8
 +mtspr   SPRN_MAS3,r9
+ isync
+ msync
 +tlbwe

+ lis     r6,FSL_BOOKE_MAS0(1, 12, 0)@h
+ ori     r6,r6,FSL_BOOKE_MAS0(1, 12, 0)@l

 +lis     r7,FSL_BOOKE_MAS1(1, 1, 0, 0, BOOKE_PAGESZ_1GB)@h
 +ori     r7,r7,FSL_BOOKE_MAS1(1, 1, 0, 0, BOOKE_PAGESZ_1GB)@l

 +lis     r8,FSL_BOOKE_MAS2(0x40000000, (MAS2_I|MAS2_G))@h
 +ori     r8,r8,FSL_BOOKE_MAS2(0x40000000, (MAS2_I|MAS2_G))@l

 +lis     r9,FSL_BOOKE_MAS3(0x40000000, 0, (MAS3_SX|MAS3_SW|MAS3_SR))@h
 +ori     r9,r9,FSL_BOOKE_MAS3(0x40000000, 0, (MAS3_SX|MAS3_SW|MAS3_SR))@l

 +mtspr   SPRN_MAS0,r6
+ mtspr   SPRN_MAS1,r7
+ mtspr   SPRN_MAS2,r8
 +mtspr   SPRN_MAS3,r9
 +isync
 +msync
+ tlbwe

+#endif

+#ifdef  CONFIG_MPC8560_ADS
+ lis     r6,FSL_BOOKE_MAS0(1, 13, 0)@h
 +ori     r6,r6,FSL_BOOKE_MAS0(1, 13, 0)@l

+ lis     r7,FSL_BOOKE_MAS1(1, 1, 0, 0, BOOKE_PAGESZ_256M)@h
+ ori     r7,r7,FSL_BOOKE_MAS1(1, 1, 0, 0, BOOKE_PAGESZ_256M)@l

 +lis     r8,FSL_BOOKE_MAS2(0x00000000, (MAS2_I|MAS2_G))@h
 +ori     r8,r8,FSL_BOOKE_MAS2(0x00000000, (MAS2_I|MAS2_G))@l

+ lis     r9,FSL_BOOKE_MAS3(0x00000000, 0, (MAS3_SX|MAS3_SW|MAS3_SR))@h
 +ori     r9,r9,FSL_BOOKE_MAS3(0x00000000, 0, (MAS3_SX|MAS3_SW|MAS3_SR))@l

 +mtspr   SPRN_MAS0,r6
 +mtspr   SPRN_MAS1,r7
+ mtspr   SPRN_MAS2,r8
 +mtspr   SPRN_MAS3,r9
 +isync
+ msync
 +tlbwe

+ lis     r6,FSL_BOOKE_MAS0(1, 12, 0)@h
 +ori     r6,r6,FSL_BOOKE_MAS0(1, 12, 0)@l

 +lis     r7,FSL_BOOKE_MAS1(1, 1, 0, 0, BOOKE_PAGESZ_256M)@h
 +ori     r7,r7,FSL_BOOKE_MAS1(1, 1, 0, 0, BOOKE_PAGESZ_256M)@l

+ lis     r8,FSL_BOOKE_MAS2(0x10000000, (MAS2_I|MAS2_G))@h
+ ori     r8,r8,FSL_BOOKE_MAS2(0x10000000, (MAS2_I|MAS2_G))@l

 +lis     r9,FSL_BOOKE_MAS3(0x10000000, 0, (MAS3_SX|MAS3_SW|MAS3_SR))@h
 +ori     r9,r9,FSL_BOOKE_MAS3(0x10000000, 0, (MAS3_SX|MAS3_SW|MAS3_SR))@l

+ mtspr   SPRN_MAS0,r6
 +mtspr   SPRN_MAS1,r7
 +mtspr   SPRN_MAS2,r8
 +mtspr   SPRN_MAS3,r9
 +isync
 +msync
 +tlbwe


 +lis     r6,FSL_BOOKE_MAS0(1, 11, 0)@h
+ ori     r6,r6,FSL_BOOKE_MAS0(1, 11, 0)@l

+ lis     r7,FSL_BOOKE_MAS1(1, 1, 0, 0, BOOKE_PAGESZ_256M)@h
 +ori     r7,r7,FSL_BOOKE_MAS1(1, 1, 0, 0, BOOKE_PAGESZ_256M)@l

+ lis     r8,FSL_BOOKE_MAS2(0x20000000, (MAS2_I|MAS2_G))@h
+ ori     r8,r8,FSL_BOOKE_MAS2(0x20000000, (MAS2_I|MAS2_G))@l

+ lis     r9,FSL_BOOKE_MAS3(0x20000000, 0, (MAS3_SX|MAS3_SW|MAS3_SR))@h
 +ori     r9,r9,FSL_BOOKE_MAS3(0x20000000, 0, (MAS3_SX|MAS3_SW|MAS3_SR))@l

 +mtspr   SPRN_MAS0,r6
+ mtspr   SPRN_MAS1,r7
+ mtspr   SPRN_MAS2,r8
+ mtspr   SPRN_MAS3,r9
 +isync
+ msync
+ tlbwe

+ lis     r6,FSL_BOOKE_MAS0(1, 10, 0)@h
 +ori     r6,r6,FSL_BOOKE_MAS0(1, 10, 0)@l

 +lis     r7,FSL_BOOKE_MAS1(1, 1, 0, 0, BOOKE_PAGESZ_256M)@h
 +ori     r7,r7,FSL_BOOKE_MAS1(1, 1, 0, 0, BOOKE_PAGESZ_256M)@l

+ lis     r8,FSL_BOOKE_MAS2(0x30000000, (MAS2_I|MAS2_G))@h
 +ori     r8,r8,FSL_BOOKE_MAS2(0x30000000, (MAS2_I|MAS2_G))@l

 +lis     r9,FSL_BOOKE_MAS3(0x30000000, 0, (MAS3_SX|MAS3_SW|MAS3_SR))@h
 +ori     r9,r9,FSL_BOOKE_MAS3(0x30000000, 0, (MAS3_SX|MAS3_SW|MAS3_SR))@l

+ mtspr   SPRN_MAS0,r6
 +mtspr   SPRN_MAS1,r7
 +mtspr   SPRN_MAS2,r8
+ mtspr   SPRN_MAS3,r9
 +isync
 +msync
 +tlbwe
+#endif

+#endif

 mr r3, r29
 mr r5, r31
