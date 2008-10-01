Return-Path: <bigeasy@Chamillionaire.breakpoint.cc>
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc
	[85.10.199.196])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8BC60DE132
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Oct 2008 07:20:51 +1000 (EST)
From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
To: linuxppc-dev@ozlabs.org
Subject: [RFC] powerpc: add kexec support on Book-E
Date: Wed,  1 Oct 2008 23:20:22 +0200
Message-Id: <1222896024-22172-2-git-send-email-sebastian@breakpoint.cc>
In-Reply-To: <1222896024-22172-1-git-send-email-sebastian@breakpoint.cc>
References: <1222896024-22172-1-git-send-email-sebastian@breakpoint.cc>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	kexec@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

The relocate_new_kernel() code usually disables the MMU and the small code
operates on physicall addresses while moving the kernel to its final
position. Book-E doesn't support this so a 1:1 mapping must be created.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/powerpc/include/asm/kexec.h       |    4 +
 arch/powerpc/kernel/machine_kexec_32.c |   16 +++-
 arch/powerpc/kernel/misc_32.S          |  139 ++++++++++++++++++++++++++++++-
 3 files changed, 151 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/include/asm/kexec.h b/arch/powerpc/include/asm/kexec.h
index 3736d9b..3907b24 100644
--- a/arch/powerpc/include/asm/kexec.h
+++ b/arch/powerpc/include/asm/kexec.h
@@ -31,6 +31,9 @@
 #define KEXEC_ARCH KEXEC_ARCH_PPC
 #endif
 
+#define KEXEC_MODE_NOMMU 1
+#define KEXEC_MODE_BOOKE 2
+
 #ifndef __ASSEMBLY__
 #include <linux/cpumask.h>
 
@@ -124,6 +127,7 @@ struct kimage;
 struct pt_regs;
 extern void default_machine_kexec(struct kimage *image);
 extern int default_machine_kexec_prepare(struct kimage *image);
+extern int booke_machine_kexec_prepare(struct kimage *image);
 extern void default_machine_crash_shutdown(struct pt_regs *regs);
 extern int crash_shutdown_register(crash_shutdown_t handler);
 extern int crash_shutdown_unregister(crash_shutdown_t handler);
diff --git a/arch/powerpc/kernel/machine_kexec_32.c b/arch/powerpc/kernel/machine_kexec_32.c
index ae63a96..6611002 100644
--- a/arch/powerpc/kernel/machine_kexec_32.c
+++ b/arch/powerpc/kernel/machine_kexec_32.c
@@ -16,11 +16,13 @@
 #include <asm/hw_irq.h>
 #include <asm/io.h>
 
-typedef NORET_TYPE void (*relocate_new_kernel_t)(
+typedef void (*relocate_new_kernel_t)(
 				unsigned long indirection_page,
 				unsigned long reboot_code_buffer,
-				unsigned long start_address) ATTRIB_NORET;
+				unsigned long start_address,
+				unsigned long mmu_mode);
 
+static unsigned long mmu_mode;
 /*
  * This is a generic machine_kexec function suitable at least for
  * non-OpenFirmware embedded platforms.
@@ -56,10 +58,18 @@ void default_machine_kexec(struct kimage *image)
 
 	/* now call it */
 	rnk = (relocate_new_kernel_t) reboot_code_buffer;
-	(*rnk)(page_list, reboot_code_buffer_phys, image->start);
+	(*rnk)(page_list, reboot_code_buffer_phys, image->start, mmu_mode);
+	BUG();
 }
 
 int default_machine_kexec_prepare(struct kimage *image)
 {
+	mmu_mode = KEXEC_MODE_NOMMU;
+	return 0;
+}
+
+int booke_machine_kexec_prepare(struct kimage *image)
+{
+	mmu_mode = KEXEC_MODE_BOOKE;
 	return 0;
 }
diff --git a/arch/powerpc/kernel/misc_32.S b/arch/powerpc/kernel/misc_32.S
index 7a6dfbc..519d752 100644
--- a/arch/powerpc/kernel/misc_32.S
+++ b/arch/powerpc/kernel/misc_32.S
@@ -877,9 +877,131 @@ relocate_new_kernel:
 	/* r3 = page_list   */
 	/* r4 = reboot_code_buffer */
 	/* r5 = start_address      */
+	/* r6 = mmu handling	*/
 
-	li	r0, 0
+	mflr	r28
+	mr	r29, r3
+	mr	r30, r4
+	mr	r31, r5
+
+	li	r0, KEXEC_MODE_NOMMU
+	cmpw	r0, r6
+	beq	disable_mmu
+
+	li	r0, KEXEC_MODE_BOOKE
+	cmpw	r0, r6
+	beq	create_linear_mapping
+
+	blr
 
+create_linear_mapping:
+	li	r25, 0			/* phys kernel start (low) */
+
+/* 1. Find the index of the entry we're executing in */
+	bl	invstr			/* Find our address */
+invstr:
+	mflr	r6			/* Make it accessible */
+	mfmsr	r7
+	rlwinm	r4,r7,27,31,31		/* extract MSR[IS] */
+	mfspr	r7, SPRN_PID0
+	slwi	r7,r7,16
+	or	r7,r7,r4
+	mtspr	SPRN_MAS6,r7
+	tlbsx	0,r6			/* search MSR[IS], SPID=PID0 */
+	mfspr	r7,SPRN_MAS1
+	andis.	r7,r7,MAS1_VALID@h
+	bne	match_TLB
+	
+	/*
+	 * We search just in PID0 because kernel's global mapping has to be
+	 * there. We simply return to the caller if we didn't find the mapping
+	 * since we didn't (yet) pass the point of no return. This should not
+	 * happen.
+	 */
+	mtlr	r28
+	blr
+
+match_TLB:
+	mfspr	r7,SPRN_MAS0
+	rlwinm	r3,r7,16,20,31		/* Extract MAS0(Entry) */
+
+	mfspr	r7,SPRN_MAS1		/* Insure IPROT set */
+	oris	r7,r7,MAS1_IPROT@h
+	mtspr	SPRN_MAS1,r7
+	tlbwe
+
+/* 2. Invalidate all entries except the entry we're executing in */
+	mfspr	r9,SPRN_TLB1CFG
+	andi.	r9,r9,0xfff
+	li	r6,0			/* Set Entry counter to 0 */
+1:
+	lis	r7,0x1000		/* Set MAS0(TLBSEL) = 1 */
+	rlwimi	r7,r6,16,4,15		/* Setup MAS0 = TLBSEL | ESEL(r6) */
+	mtspr   SPRN_MAS0,r7
+	tlbre
+	mfspr	r7,SPRN_MAS1
+	rlwinm  r7,r7,0,2,31		/* Clear MAS1 Valid and IPROT */
+	cmpw	r3,r6
+	beq	skpinv			/* Dont update the current execution TLB */
+	mtspr	SPRN_MAS1,r7
+	tlbwe
+	isync
+skpinv:
+	addi	r6,r6,1			/* Increment */
+	cmpw	r6,r9			/* Are we done? */
+	bne	1b			/* If not, repeat */
+
+	/* Invalidate TLB0 */
+	li	r6,0x04
+	tlbivax	0,r6
+	TLBSYNC
+	/* Invalidate TLB1 */
+	li	r6,0x0c
+	tlbivax	0,r6
+	TLBSYNC
+
+/* 3. Setup a temp mapping and jump to it */
+	andi.	r5, r3, 0x1		/* Find an entry not used and is non-zero */
+	addi	r5, r5, 0x1
+	lis	r7, 0x1000		/* Set MAS0(TLBSEL) = 1 */
+	rlwimi	r7, r3, 16, 4, 15	/* Setup MAS0 = TLBSEL | ESEL(r3) */
+	mtspr	SPRN_MAS0,r7
+	tlbre
+
+	/* Just modify the entry ID and EPN for the temp mapping */
+	lis	r7,0x1000		/* Set MAS0(TLBSEL) = 1 */
+	rlwimi	r7,r5,16,4,15		/* Setup MAS0 = TLBSEL | ESEL(r5) */
+	mtspr	SPRN_MAS0,r7
+
+	xori	r6,r4,1			/* Setup TMP mapping in the other Address space */
+	slwi	r6,r6,12
+	oris	r6,r6,(MAS1_VALID|MAS1_IPROT)@h
+	ori	r6,r6,(MAS1_TSIZE(BOOKE_PAGESZ_1GB))@l
+	mtspr	SPRN_MAS1,r6
+
+	lis	r7, MAS2_I | MAS2_G
+	mtspr	SPRN_MAS2,r7
+
+	li	r8, 0
+	ori	r8,r25,(MAS3_SX|MAS3_SW|MAS3_SR)
+	mtspr   SPRN_MAS3,r8
+
+	tlbwe
+
+	xori	r6, r4, 1
+	slwi	r5, r6, 4		/* DS setup new context with other address space */
+	slwi	r6, r6, 5		/* IS setup new context with other address space */
+	or	r6, r6, r5
+
+	/* find our address */
+	addi	r7, r30, final_copy_code - relocate_new_kernel
+
+	mtspr	SPRN_SRR0,r7
+	mtspr	SPRN_SRR1,r6
+	rfi
+
+disable_mmu:
+	li	r0, 0
 	/*
 	 * Set Machine Status Register to a known status,
 	 * switch the MMU off and jump to 1: in a single step.
@@ -888,14 +1010,21 @@ relocate_new_kernel:
 	mr	r8, r0
 	ori     r8, r8, MSR_RI|MSR_ME
 	mtspr	SPRN_SRR1, r8
-	addi	r8, r4, 1f - relocate_new_kernel
+	addi	r8, r4, final_copy_code - relocate_new_kernel
 	mtspr	SPRN_SRR0, r8
 	sync
 	rfi
 
-1:
-	/* from this point address translation is turned off */
-	/* and interrupts are disabled */
+final_copy_code:
+
+	mr	r3, r29
+	mr	r4, r30
+	mr	r5, r31
+
+	li	r0, 0
+
+	/* from this point address translation is turned off or we have  */
+	/* a 1:1 mapping and interrupts are disabled */
 
 	/* set a new stack at the bottom of our page... */
 	/* (not really needed now) */
-- 
1.5.6.5
