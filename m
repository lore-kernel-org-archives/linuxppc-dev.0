Return-Path: <suzuki@in.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp05.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D137FB7197
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Mar 2012 21:25:15 +1100 (EST)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <suzuki@in.ibm.com>;
 Wed, 14 Mar 2012 15:54:49 +0530
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q2EANdY92453656
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Mar 2012 15:53:41 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q2EFqiG1010966
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Mar 2012 02:52:45 +1100
From: "Suzuki K. Poulose" <suzuki@in.ibm.com>
Subject: [PATCH 1/2] [47x] Kernel support for KEXEC
To: jwboyer@gmail.com
Date: Wed, 14 Mar 2012 15:53:06 +0530
Message-ID: <20120314102251.675.63705.stgit@suzukikp.in.ibm.com>
In-Reply-To: <20120314102121.675.92862.stgit@suzukikp.in.ibm.com>
References: <20120314102121.675.92862.stgit@suzukikp.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch adds support for creating 1:1 mapping for the
PPC_47x during a KEXEC. The implementation is similar
to that of the PPC440x which is described here :

	http://patchwork.ozlabs.org/patch/104323/

PPC_47x MMU :

The 47x uses Unified TLB 1024 entries, with 4-way associative
mapping (4 x 256 entries). The index to be used is calculated
by the MMU by hashing the PID, EPN and TS. The software can
choose to specify the way by setting bit 0(enable way select)
 and the way in bits 1-2 in the TLB Word 0.

Implementation:

The patch erases all the UTLB entries which includes the tlb
covering the mapping for our code. The shadow TLB caches the
mapping for the running code which helps us to continue the
execution until we do isync/rfi. We then create a tmp mapping
for the current code in the other address space (TS) and switch
to it.

Then we create a 1:1 mapping(EPN=RPN) for 0-2GiB in the original
address space and switch to the new mapping.

TODO: Add SMP support.

Signed-off-by: Suzuki K. Poulose <suzuki@in.ibm.com>
---

 arch/powerpc/Kconfig          |    2 
 arch/powerpc/kernel/misc_32.S |  197 ++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 192 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index fe56229..975aae5 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -346,7 +346,7 @@ config ARCH_ENABLE_MEMORY_HOTREMOVE
 
 config KEXEC
 	bool "kexec system call (EXPERIMENTAL)"
-	depends on (PPC_BOOK3S || FSL_BOOKE || (44x && !SMP && !PPC_47x)) && EXPERIMENTAL
+	depends on (PPC_BOOK3S || FSL_BOOKE || (44x && !SMP)) && EXPERIMENTAL
 	help
 	  kexec is a system call that implements the ability to shutdown your
 	  current kernel, and to start another kernel.  It is like a reboot
diff --git a/arch/powerpc/kernel/misc_32.S b/arch/powerpc/kernel/misc_32.S
index 7cd07b4..3e7154b 100644
--- a/arch/powerpc/kernel/misc_32.S
+++ b/arch/powerpc/kernel/misc_32.S
@@ -738,8 +738,23 @@ relocate_new_kernel:
 	mr      r5, r31
 
 	li	r0, 0
-#elif defined(CONFIG_44x)  && !defined(CONFIG_PPC_47x)
+#elif defined(CONFIG_44x)
 
+	/* Save our parameters */
+	mr	r29, r3
+	mr	r30, r4
+	mr	r31, r5
+
+#ifdef CONFIG_PPC_47x
+	/* Check for 47x cores */
+	mfspr	r3,SPRN_PVR
+	srwi	r3,r3,16
+	cmplwi	cr0,r3,PVR_476@h
+	beq	setup_map_47x
+	cmplwi	cr0,r3,PVR_476_ISS@h
+	beq	setup_map_47x
+#endif /* CONFIG_PPC_47x */
+	
 /*
  * Code for setting up 1:1 mapping for PPC440x for KEXEC
  *
@@ -753,13 +768,8 @@ relocate_new_kernel:
  * 5) Invalidate the tmp mapping.
  *
  * - Based on the kexec support code for FSL BookE
- * - Doesn't support 47x yet.
  *
  */
-	/* Save our parameters */
-	mr	r29, r3
-	mr	r30, r4
-	mr	r31, r5
 
 	/* Load our MSR_IS and TID to MMUCR for TLB search */
 	mfspr	r3,SPRN_PID
@@ -900,6 +910,181 @@ next_tlb:
 	li	r3, 0
 	tlbwe	r3, r24, PPC44x_TLB_PAGEID
 	sync
+	b	ppc44x_map_done
+
+#ifdef CONFIG_PPC_47x
+
+	/* 1:1 mapping for 47x */
+
+setup_map_47x:
+
+	/* Load our current PID->MMUCR TID and MSR IS->MMUCR STS */
+	mfspr	r3, SPRN_PID			/* Get PID */
+	mfmsr	r4				/* Get MSR */
+	andi.	r4, r4, MSR_IS@l		/* TS=1? */
+	beq	1f				/* If not, leave STS=0 */
+	oris	r3, r3, PPC47x_MMUCR_STS@h	/* Set STS=1 */
+1:	mtspr	SPRN_MMUCR, r3			/* Put MMUCR */
+	sync
+
+	/* Find the entry we are running from */
+	bl	2f
+2:	mflr	r23
+	tlbsx	r23, 0, r23
+	tlbre	r24, r23, 0			/* TLB Word 0 */
+	tlbre	r25, r23, 1			/* TLB Word 1 */
+	tlbre	r26, r23, 2			/* TLB Word 2 */
+
+
+	/* Initialize MMUCR */
+	li	r5, 0
+	mtspr	SPRN_MMUCR, r5
+	sync
+
+
+	/*
+	 * Invalidates all the tlb entries by writing to 256 RPNs(r4)
+	 * of 4k page size in all  4 ways (0-3 in r3).
+	 * This would invalidate the entire UTLB including the one we are
+	 * running from. However the shadow TLB entries would help us 
+	 * to continue the execution, until we flush them (rfi/isync).
+	 */
+	addis	r3, 0, 0x8000			/* specify the way */
+	addi	r4, 0, 0			/* TLB Word0 = (EPN=0, VALID = 0) */
+	addi	r5, 0, 0
+	b	clear_utlb_entry
+
+	/* Align the loop to speed things up. from head_44x.S */
+	.align	6
+
+clear_utlb_entry:
+
+	tlbwe	r4, r3, 0
+	tlbwe	r5, r3, 1
+	tlbwe	r5, r3, 2
+	addis	r3, r3, 0x2000			/* Increment the way */
+	cmpwi	r3, 0
+	bne	clear_utlb_entry
+	addis	r3, 0, 0x8000
+	addis	r4, r4, 0x100			/* Increment the EPN */
+	cmpwi	r4, 0
+	bne	clear_utlb_entry
+
+	/* Create the entries in the other address space */
+	mfmsr	r5
+	rlwinm	r7, r5, 27, 31, 31		/* Get the TS (Bit 26) from MSR */
+	xori	r7, r7, 1			/* r7 = !TS */
+
+	insrwi	r24, r7, 1, 21			/* Change the TS in the saved TLB word 0 */
+
+	/* 
+	 * write out the TLB entries for the tmp mapping
+	 * Use way '0' so that we could easily invalidate it later.
+	 */
+	lis	r3, 0x8000			/* Way '0' */ 
+
+	tlbwe	r24, r3, 0
+	tlbwe	r25, r3, 1
+	tlbwe	r26, r3, 2
+
+	/* Update the msr to the new TS */
+	insrwi	r5, r7, 1, 26
+
+	bl	1f
+1:	mflr	r6
+	addi	r6, r6, (2f-1b)
+
+	mtspr	SPRN_SRR0, r6
+	mtspr	SPRN_SRR1, r5
+	rfi
+
+	/* 
+	 * Now we are in the tmp address space.
+	 * Create a 1:1 mapping for 0-2GiB in the original TS.
+	 */
+2:
+	li	r3, 0
+	li	r4, 0				/* TLB Word 0 */
+	li	r5, 0				/* TLB Word 1 */
+	li	r6, 0
+	ori	r6, r6, PPC47x_TLB2_S_RWX	/* TLB word 2 */
+
+	li	r8, 0				/* PageIndex */
+
+	xori	r7, r7, 1			/* revert back to original TS */
+
+write_utlb:
+	rotlwi	r5, r8, 28			/* RPN = PageIndex * 256M */
+						/* ERPN = 0 as we don't use memory above 2G */
+
+	mr	r4, r5				/* EPN = RPN */
+	ori	r4, r4, (PPC47x_TLB0_VALID | PPC47x_TLB0_256M)
+	insrwi	r4, r7, 1, 21			/* Insert the TS to Word 0 */
+
+	tlbwe	r4, r3, 0			/* Write out the entries */
+	tlbwe	r5, r3, 1
+	tlbwe	r6, r3, 2
+	addi	r8, r8, 1
+	cmpwi	r8, 8				/* Have we completed ? */
+	bne	write_utlb
+
+	/* make sure we complete the TLB write up */
+	isync
+
+	/* 
+	 * Prepare to jump to the 1:1 mapping.
+	 * 1) Extract page size of the tmp mapping
+	 *    DSIZ = TLB_Word0[22:27]
+	 * 2) Calculate the physical address of the address
+	 *    to jump to.
+	 */
+	rlwinm	r10, r24, 0, 22, 27
+
+	cmpwi	r10, PPC47x_TLB0_4K
+	bne	0f
+	li	r10, 0x1000			/* r10 = 4k */
+	bl	1f
+
+0:
+	/* Defaults to 256M */
+	lis	r10, 0x1000
+	
+	bl	1f
+1:	mflr	r4
+	addi	r4, r4, (2f-1b)			/* virtual address  of 2f */
+
+	subi	r11, r10, 1			/* offsetmask = Pagesize - 1 */
+	not	r10, r11			/* Pagemask = ~(offsetmask) */
+
+	and	r5, r25, r10			/* Physical page */
+	and	r6, r4, r11			/* offset within the current page */
+
+	or	r5, r5, r6			/* Physical address for 2f */
+
+	/* Switch the TS in MSR to the original one */
+	mfmsr	r8
+	insrwi	r8, r7, 1, 26
+
+	mtspr	SPRN_SRR1, r8
+	mtspr	SPRN_SRR0, r5
+	rfi
+
+2:
+	/* Invalidate the tmp mapping */
+	lis	r3, 0x8000			/* Way '0' */
+
+	clrrwi	r24, r24, 12			/* Clear the valid bit */
+	tlbwe	r24, r3, 0
+	tlbwe	r25, r3, 1
+	tlbwe	r26, r3, 2
+
+	/* Make sure we complete the TLB write and flush the shadow TLB */
+	isync
+
+#endif
+
+ppc44x_map_done:
+
 
 	/* Restore the parameters */
 	mr	r3, r29
