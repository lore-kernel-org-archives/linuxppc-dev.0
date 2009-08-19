Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id B5E19B7D94
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 19 Aug 2009 15:08:46 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EA789DDD1B
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Aug 2009 15:08:45 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 5/5] powerpc/book3e-64: Add support to initial_tlb_book3e for
	non-HES TLB
Date: Wed, 19 Aug 2009 00:08:33 -0500
Message-Id: <1250658513-13009-5-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1250658513-13009-4-git-send-email-galak@kernel.crashing.org>
References: <1250658513-13009-1-git-send-email-galak@kernel.crashing.org>
	<1250658513-13009-2-git-send-email-galak@kernel.crashing.org>
	<1250658513-13009-3-git-send-email-galak@kernel.crashing.org>
	<1250658513-13009-4-git-send-email-galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We now search through TLBnCFG looking for the first array that has IPROT
support (we assume that there is only one).  If that TLB has hardware
entry select (HES) support we use the existing code and with the proper
TLB select (the HES code still needs to clean up bolted entries from
firmware).  The non-HES code is pretty similiar to the 32-bit FSL Book-E
code but does make some new assumtions (like that we have tlbilx) and
simplifies things down a bit.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---

Ben,

One concern I had with this patch was the fact that I'm using
r5..r8 w/o saving them off in head_64.S.

- k

 arch/powerpc/include/asm/reg_booke.h |    2 +
 arch/powerpc/kernel/exceptions-64e.S |  204 +++++++++++++++++++++++++++++++++-
 2 files changed, 202 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/reg_booke.h b/arch/powerpc/include/asm/reg_booke.h
index 2c9c706..e204de6 100644
--- a/arch/powerpc/include/asm/reg_booke.h
+++ b/arch/powerpc/include/asm/reg_booke.h
@@ -108,6 +108,8 @@
 #define SPRN_PID2	0x27A	/* Process ID Register 2 */
 #define SPRN_TLB0CFG	0x2B0	/* TLB 0 Config Register */
 #define SPRN_TLB1CFG	0x2B1	/* TLB 1 Config Register */
+#define SPRN_TLB2CFG	0x2B2	/* TLB 2 Config Register */
+#define SPRN_TLB3CFG	0x2B3	/* TLB 3 Config Register */
 #define SPRN_EPR	0x2BE	/* External Proxy Register */
 #define SPRN_CCR1	0x378	/* Core Configuration Register 1 */
 #define SPRN_ZPR	0x3B0	/* Zone Protection Register (40x) */
diff --git a/arch/powerpc/kernel/exceptions-64e.S b/arch/powerpc/kernel/exceptions-64e.S
index 662236c..9048f96 100644
--- a/arch/powerpc/kernel/exceptions-64e.S
+++ b/arch/powerpc/kernel/exceptions-64e.S
@@ -616,18 +616,214 @@ bad_stack_book3e:
  * Setup the initial TLB for a core. This current implementation
  * assume that whatever we are running off will not conflict with
  * the new mapping at PAGE_OFFSET.
- * We also make various assumptions about the processor we run on,
- * this might have to be made more flexible based on the content
- * of MMUCFG and friends.
  */
 _GLOBAL(initial_tlb_book3e)
 
+	/* Look for the first TLB with IPROT set */
+	mfspr	r4,SPRN_TLB0CFG
+	andi.	r3,r4,TLBnCFG_IPROT
+	lis	r3,MAS0_TLBSEL(0)@h
+	bne	found_iprot
+
+	mfspr	r4,SPRN_TLB1CFG
+	andi.	r3,r4,TLBnCFG_IPROT
+	lis	r3,MAS0_TLBSEL(1)@h
+	bne	found_iprot
+
+	mfspr	r4,SPRN_TLB2CFG
+	andi.	r3,r4,TLBnCFG_IPROT
+	lis	r3,MAS0_TLBSEL(2)@h
+	bne	found_iprot
+
+	lis	r3,MAS0_TLBSEL(3)@h
+	mfspr	r4,SPRN_TLB3CFG
+	/* fall through */
+
+found_iprot:
+	andi.	r5,r4,TLBnCFG_HES
+	bne	have_hes
+
+	mflr	r8				/* save LR */
+/* 1. Find the index of the entry we're executing in
+ *
+ * r3 = MAS0_TLBSEL (for the iprot array)
+ * r4 = SPRN_TLBnCFG
+ */
+	bl	invstr				/* Find our address */
+invstr:	mflr	r6				/* Make it accessible */
+	mfmsr	r7
+	rlwinm	r5,r7,27,31,31			/* extract MSR[IS] */
+	mfspr	r7,SPRN_PID
+	slwi	r7,r7,16
+	or	r7,r7,r5
+	mtspr	SPRN_MAS6,r7
+	tlbsx	0,r6				/* search MSR[IS], SPID=PID */
+
+	mfspr	r3,SPRN_MAS0
+	rlwinm	r5,r3,16,20,31			/* Extract MAS0(Entry) */
+
+	mfspr	r7,SPRN_MAS1			/* Insure IPROT set */
+	oris	r7,r7,MAS1_IPROT@h
+	mtspr	SPRN_MAS1,r7
+	tlbwe
+
+/* 2. Invalidate all entries except the entry we're executing in
+ *
+ * r3 = MAS0 w/TLBSEL & ESEL for the entry we are running in
+ * r4 = SPRN_TLBnCFG
+ * r5 = ESEL of entry we are running in
+ */
+	andi.	r4,r4,TLBnCFG_N_ENTRY		/* Extract # entries */
+	li	r6,0				/* Set Entry counter to 0 */
+1:	mr	r7,r3				/* Set MAS0(TLBSEL) */
+	rlwimi	r7,r6,16,4,15			/* Setup MAS0 = TLBSEL | ESEL(r6) */
+	mtspr	SPRN_MAS0,r7
+	tlbre
+	mfspr	r7,SPRN_MAS1
+	rlwinm	r7,r7,0,2,31			/* Clear MAS1 Valid and IPROT */
+	cmpw	r5,r6
+	beq	skpinv				/* Dont update the current execution TLB */
+	mtspr	SPRN_MAS1,r7
+	tlbwe
+	isync
+skpinv:	addi	r6,r6,1				/* Increment */
+	cmpw	r6,r4				/* Are we done? */
+	bne	1b				/* If not, repeat */
+
+	/* Invalidate all TLBs */
+	PPC_TLBILX_ALL(0,0)
+	sync
+	isync
+
+/* 3. Setup a temp mapping and jump to it
+ *
+ * r3 = MAS0 w/TLBSEL & ESEL for the entry we are running in
+ * r5 = ESEL of entry we are running in
+ */
+	andi.	r7,r5,0x1	/* Find an entry not used and is non-zero */
+	addi	r7,r7,0x1
+	mr	r4,r3		/* Set MAS0(TLBSEL) = 1 */
+	mtspr	SPRN_MAS0,r4
+	tlbre
+
+	rlwimi	r4,r7,16,4,15	/* Setup MAS0 = TLBSEL | ESEL(r7) */
+	mtspr	SPRN_MAS0,r4
+
+	mfspr	r7,SPRN_MAS1
+	xori	r6,r7,MAS1_TS		/* Setup TMP mapping in the other Address space */
+	mtspr	SPRN_MAS1,r6
+
+	tlbwe
+
+	mfmsr	r6
+	xori	r6,r6,MSR_IS
+	mtspr	SPRN_SRR1,r6
+	bl	1f		/* Find our address */
+1:	mflr	r6
+	addi	r6,r6,(2f - 1b)
+	mtspr	SPRN_SRR0,r6
+	rfi
+2:
+
+/* 4. Clear out PIDs & Search info
+ *
+ * r3 = MAS0 w/TLBSEL & ESEL for the entry we started in
+ * r4 = MAS0 w/TLBSEL & ESEL for the temp mapping
+ * r5 = MAS3
+ */
+	li	r6,0
+	mtspr   SPRN_MAS6,r6
+	mtspr	SPRN_PID,r6
+
+/* 5. Invalidate mapping we started in
+ *
+ * r3 = MAS0 w/TLBSEL & ESEL for the entry we started in
+ * r4 = MAS0 w/TLBSEL & ESEL for the temp mapping
+ * r5 = MAS3
+ */
+	mtspr	SPRN_MAS0,r3
+	tlbre
+	mfspr	r6,SPRN_MAS1
+	rlwinm	r6,r6,0,2,0	/* clear IPROT */
+	mtspr	SPRN_MAS1,r6
+	tlbwe
+
+	/* Invalidate TLB1 */
+	PPC_TLBILX_ALL(0,0)
+	sync
+	isync
+
+/* The mapping only needs to be cache-coherent on SMP */
+#ifdef CONFIG_SMP
+#define M_IF_SMP	MAS2_M
+#else
+#define M_IF_SMP	0
+#endif
+
+/* 6. Setup KERNELBASE mapping in TLB[0]
+ *
+ * r3 = MAS0 w/TLBSEL & ESEL for the entry we started in
+ * r4 = MAS0 w/TLBSEL & ESEL for the temp mapping
+ * r5 = MAS3
+ */
+	rlwinm	r3,r3,0,16,3	/* clear ESEL */
+	mtspr	SPRN_MAS0,r3
+	lis	r6,(MAS1_VALID|MAS1_IPROT)@h
+	ori	r6,r6,(MAS1_TSIZE(BOOK3E_PAGESZ_1GB))@l
+	mtspr	SPRN_MAS1,r6
+
+	LOAD_REG_IMMEDIATE(r6, PAGE_OFFSET | M_IF_SMP)
+	mtspr	SPRN_MAS2,r6
+
+	rlwinm	r5,r5,0,0,25
+	ori	r5,r5,MAS3_SR | MAS3_SW | MAS3_SX
+	mtspr	SPRN_MAS3,r5
+	li	r5,-1
+	rlwinm	r5,r5,0,0,25
+
+	tlbwe
+
+/* 7. Jump to KERNELBASE mapping
+ *
+ * r4 = MAS0 w/TLBSEL & ESEL for the temp mapping
+ */
+	/* Now we branch the new virtual address mapped by this entry */
+	LOAD_REG_IMMEDIATE(r6,2f)
+	lis	r7,MSR_KERNEL@h
+	ori	r7,r7,MSR_KERNEL@l
+	mtspr	SPRN_SRR0,r6
+	mtspr	SPRN_SRR1,r7
+	rfi				/* start execution out of TLB1[0] entry */
+2:
+
+/* 8. Clear out the temp mapping
+ *
+ * r4 = MAS0 w/TLBSEL & ESEL for the entry we are running in
+ */
+	mtspr	SPRN_MAS0,r4
+	tlbre
+	mfspr	r5,SPRN_MAS1
+	rlwinm	r5,r5,0,2,0	/* clear IPROT */
+	mtspr	SPRN_MAS1,r5
+	tlbwe
+
+	/* Invalidate TLB1 */
+	PPC_TLBILX_ALL(0,0)
+	sync
+	isync
+
+	/* We translate LR and return */
+	tovirt(r8,r8)
+	mtlr	r8
+	blr
+
+have_hes:
 	/* Setup MAS 0,1,2,3 and 7 for tlbwe of a 1G entry that maps the
 	 * kernel linear mapping. We also set MAS8 once for all here though
 	 * that will have to be made dependent on whether we are running under
 	 * a hypervisor I suppose.
 	 */
-	li	r3,MAS0_HES | MAS0_WQ_ALLWAYS
+	ori	r3,r3,MAS0_HES | MAS0_WQ_ALLWAYS
 	mtspr	SPRN_MAS0,r3
 	lis	r3,(MAS1_VALID | MAS1_IPROT)@h
 	ori	r3,r3,BOOK3E_PAGESZ_1GB << MAS1_TSIZE_SHIFT
-- 
1.6.0.6
