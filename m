Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0236.outbound.protection.outlook.com [207.46.163.236])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9C5531A01AB
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Jul 2014 01:46:59 +1000 (EST)
From: Scott Wood <scottwood@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc/e6500: Work around erratum A-008139
Date: Mon, 28 Jul 2014 10:46:36 -0500
Message-ID: <1406562396-26410-1-git-send-email-scottwood@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Scott Wood <scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Erratum A-008139 can cause duplicate TLB entries if an indirect
entry is overwritten using tlbwe while the other thread is using it to
do a lookup.  Work around this by using tlbilx to invalidate prior
to overwriting.

To avoid the need to save another register to hold MAS1 during the
workaround code, TID clearing has been moved from tlb_miss_kernel_e6500
until after the SMT section.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/mm/tlb_low_64e.S | 68 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 56 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/mm/tlb_low_64e.S b/arch/powerpc/mm/tlb_low_64e.S
index 57c4d66..89bf95b 100644
--- a/arch/powerpc/mm/tlb_low_64e.S
+++ b/arch/powerpc/mm/tlb_low_64e.S
@@ -299,7 +299,9 @@ itlb_miss_fault_bolted:
  * r10 = crap (free to use)
  */
 tlb_miss_common_e6500:
-BEGIN_FTR_SECTION
+	crmove	cr2*4+2,cr0*4+2		/* cr2.eq != 0 if kernel address */
+
+BEGIN_FTR_SECTION		/* CPU_FTR_SMT */
 	/*
 	 * Search if we already have an indirect entry for that virtual
 	 * address, and if we do, bail out.
@@ -324,17 +326,62 @@ BEGIN_FTR_SECTION
 	b	1b
 	.previous
 
+	/*
+	 * Erratum A-008139 says that we can't use tlbwe to change
+	 * an indirect entry in any way (including replacing or
+	 * invalidating) if the other thread could be in the process
+	 * of a lookup.  The workaround is to invalidate the entry
+	 * with tlbilx before overwriting.
+	 */
+
+	lbz	r15,TCD_ESEL_NEXT(r11)
+	rlwinm	r10,r15,16,0xff0000
+	oris	r10,r10,MAS0_TLBSEL(1)@h
+	mtspr	SPRN_MAS0,r10
+	isync
+	tlbre
 	mfspr	r15,SPRN_MAS1
-	mfspr	r10,SPRN_MAS2
+	andis.	r15,r15,MAS1_VALID@h
+	beq	5f
+
+BEGIN_FTR_SECTION_NESTED(532)
+	mfspr	r10,SPRN_MAS8
+	rlwinm	r10,r10,0,0x80000fff  /* tgs,tlpid -> sgs,slpid */
+	mtspr	SPRN_MAS5,r10
+END_FTR_SECTION_NESTED(CPU_FTR_EMB_HV,CPU_FTR_EMB_HV,532)
 
-	tlbsx	0,r16
-	mtspr	SPRN_MAS2,r10
 	mfspr	r10,SPRN_MAS1
-	mtspr	SPRN_MAS1,r15
+	rlwinm	r15,r10,0,0x3fff0000  /* tid -> spid */
+	rlwimi	r15,r10,20,0x00000003 /* ind,ts -> sind,sas */
+	mfspr	r10,SPRN_MAS6
+	mtspr	SPRN_MAS6,r15
+
+	mfspr	r15,SPRN_MAS2
+	isync
+	tlbilxva 0,r15
+	isync
+
+	mtspr	SPRN_MAS6,r10
 
-	andis.	r10,r10,MAS1_VALID@h
+5:
+BEGIN_FTR_SECTION_NESTED(532)
+	li	r10,0
+	mtspr	SPRN_MAS8,r10
+	mtspr	SPRN_MAS5,r10
+END_FTR_SECTION_NESTED(CPU_FTR_EMB_HV,CPU_FTR_EMB_HV,532)
+
+	tlbsx	0,r16
+	mfspr	r10,SPRN_MAS1
+	andis.	r15,r10,MAS1_VALID@h
 	bne	tlb_miss_done_e6500
-END_FTR_SECTION_IFSET(CPU_FTR_SMT)
+FTR_SECTION_ELSE
+	mfspr	r10,SPRN_MAS1
+ALT_FTR_SECTION_END_IFSET(CPU_FTR_SMT)
+
+	oris	r10,r10,MAS1_VALID@h
+	beq	cr2,4f
+	rlwinm	r10,r10,0,16,1		/* Clear TID */
+4:	mtspr	SPRN_MAS1,r10
 
 	/* Now, we need to walk the page tables. First check if we are in
 	 * range.
@@ -410,12 +457,9 @@ END_FTR_SECTION_IFSET(CPU_FTR_SMT)
 	rfi
 
 tlb_miss_kernel_e6500:
-	mfspr	r10,SPRN_MAS1
 	ld	r14,PACA_KERNELPGD(r13)
-	cmpldi	cr0,r15,8		/* Check for vmalloc region */
-	rlwinm	r10,r10,0,16,1		/* Clear TID */
-	mtspr	SPRN_MAS1,r10
-	beq+	tlb_miss_common_e6500
+	cmpldi	cr1,r15,8		/* Check for vmalloc region */
+	beq+	cr1,tlb_miss_common_e6500
 
 tlb_miss_fault_e6500:
 	tlb_unlock_e6500
-- 
1.9.1
