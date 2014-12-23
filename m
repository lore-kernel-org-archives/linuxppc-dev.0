Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 80A911A09C3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Dec 2014 18:12:42 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc/kvm: Create proper names for the kvm_host_state PMU
 fields
Date: Tue, 23 Dec 2014 18:12:33 +1100
Message-Id: <1419318753-4396-1-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <53BE67EA.8000206@suse.de>
References: <53BE67EA.8000206@suse.de>
Cc: agraf@suse.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We have two arrays in kvm_host_state that contain register values for
the PMU. Currently we only create an asm-offsets symbol for the base of
the arrays, and do the array offset in the assembly code.

Creating an asm-offsets symbol for each field individually makes the
code much nicer to read, particularly for the MMCRx/SIxR/SDAR fields, and
might have helped us notice the recent double restore bug we had in this
code.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Acked-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/kernel/asm-offsets.c       | 15 +++++++++++++--
 arch/powerpc/kvm/book3s_hv_interrupts.S | 26 +++++++++++++-------------
 arch/powerpc/kvm/book3s_hv_rmhandlers.S | 28 ++++++++++++++--------------
 3 files changed, 40 insertions(+), 29 deletions(-)


Looks like this fell through the cracks between the powerpc & kvm trees.

It needed a rework to go on top of the 970 HV removal, this is the result. I'll
put it in the powerpc tree.

cheers


diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index e624f9646350..4717859fdd04 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -644,8 +644,19 @@ int main(void)
 	HSTATE_FIELD(HSTATE_SAVED_XIRR, saved_xirr);
 	HSTATE_FIELD(HSTATE_HOST_IPI, host_ipi);
 	HSTATE_FIELD(HSTATE_PTID, ptid);
-	HSTATE_FIELD(HSTATE_MMCR, host_mmcr);
-	HSTATE_FIELD(HSTATE_PMC, host_pmc);
+	HSTATE_FIELD(HSTATE_MMCR0, host_mmcr[0]);
+	HSTATE_FIELD(HSTATE_MMCR1, host_mmcr[1]);
+	HSTATE_FIELD(HSTATE_MMCRA, host_mmcr[2]);
+	HSTATE_FIELD(HSTATE_SIAR, host_mmcr[3]);
+	HSTATE_FIELD(HSTATE_SDAR, host_mmcr[4]);
+	HSTATE_FIELD(HSTATE_MMCR2, host_mmcr[5]);
+	HSTATE_FIELD(HSTATE_SIER, host_mmcr[6]);
+	HSTATE_FIELD(HSTATE_PMC1, host_pmc[0]);
+	HSTATE_FIELD(HSTATE_PMC2, host_pmc[1]);
+	HSTATE_FIELD(HSTATE_PMC3, host_pmc[2]);
+	HSTATE_FIELD(HSTATE_PMC4, host_pmc[3]);
+	HSTATE_FIELD(HSTATE_PMC5, host_pmc[4]);
+	HSTATE_FIELD(HSTATE_PMC6, host_pmc[5]);
 	HSTATE_FIELD(HSTATE_PURR, host_purr);
 	HSTATE_FIELD(HSTATE_SPURR, host_spurr);
 	HSTATE_FIELD(HSTATE_DSCR, host_dscr);
diff --git a/arch/powerpc/kvm/book3s_hv_interrupts.S b/arch/powerpc/kvm/book3s_hv_interrupts.S
index 36540a99d178..0fdc4a28970b 100644
--- a/arch/powerpc/kvm/book3s_hv_interrupts.S
+++ b/arch/powerpc/kvm/book3s_hv_interrupts.S
@@ -93,15 +93,15 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
 	mfspr	r5, SPRN_MMCR1
 	mfspr	r9, SPRN_SIAR
 	mfspr	r10, SPRN_SDAR
-	std	r7, HSTATE_MMCR(r13)
-	std	r5, HSTATE_MMCR + 8(r13)
-	std	r6, HSTATE_MMCR + 16(r13)
-	std	r9, HSTATE_MMCR + 24(r13)
-	std	r10, HSTATE_MMCR + 32(r13)
+	std	r7, HSTATE_MMCR0(r13)
+	std	r5, HSTATE_MMCR1(r13)
+	std	r6, HSTATE_MMCRA(r13)
+	std	r9, HSTATE_SIAR(r13)
+	std	r10, HSTATE_SDAR(r13)
 BEGIN_FTR_SECTION
 	mfspr	r9, SPRN_SIER
-	std	r8, HSTATE_MMCR + 40(r13)
-	std	r9, HSTATE_MMCR + 48(r13)
+	std	r8, HSTATE_MMCR2(r13)
+	std	r9, HSTATE_SIER(r13)
 END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
 	mfspr	r3, SPRN_PMC1
 	mfspr	r5, SPRN_PMC2
@@ -109,12 +109,12 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
 	mfspr	r7, SPRN_PMC4
 	mfspr	r8, SPRN_PMC5
 	mfspr	r9, SPRN_PMC6
-	stw	r3, HSTATE_PMC(r13)
-	stw	r5, HSTATE_PMC + 4(r13)
-	stw	r6, HSTATE_PMC + 8(r13)
-	stw	r7, HSTATE_PMC + 12(r13)
-	stw	r8, HSTATE_PMC + 16(r13)
-	stw	r9, HSTATE_PMC + 20(r13)
+	stw	r3, HSTATE_PMC1(r13)
+	stw	r5, HSTATE_PMC2(r13)
+	stw	r6, HSTATE_PMC3(r13)
+	stw	r7, HSTATE_PMC4(r13)
+	stw	r8, HSTATE_PMC5(r13)
+	stw	r9, HSTATE_PMC6(r13)
 31:
 
 	/*
diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index 10554df13852..bb94e6f20c81 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -83,35 +83,35 @@ END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_207S)
 	cmpwi	r4, 0
 	beq	23f			/* skip if not */
 BEGIN_FTR_SECTION
-	ld	r3, HSTATE_MMCR(r13)
+	ld	r3, HSTATE_MMCR0(r13)
 	andi.	r4, r3, MMCR0_PMAO_SYNC | MMCR0_PMAO
 	cmpwi	r4, MMCR0_PMAO
 	beql	kvmppc_fix_pmao
 END_FTR_SECTION_IFSET(CPU_FTR_PMAO_BUG)
-	lwz	r3, HSTATE_PMC(r13)
-	lwz	r4, HSTATE_PMC + 4(r13)
-	lwz	r5, HSTATE_PMC + 8(r13)
-	lwz	r6, HSTATE_PMC + 12(r13)
-	lwz	r8, HSTATE_PMC + 16(r13)
-	lwz	r9, HSTATE_PMC + 20(r13)
+	lwz	r3, HSTATE_PMC1(r13)
+	lwz	r4, HSTATE_PMC2(r13)
+	lwz	r5, HSTATE_PMC3(r13)
+	lwz	r6, HSTATE_PMC4(r13)
+	lwz	r8, HSTATE_PMC5(r13)
+	lwz	r9, HSTATE_PMC6(r13)
 	mtspr	SPRN_PMC1, r3
 	mtspr	SPRN_PMC2, r4
 	mtspr	SPRN_PMC3, r5
 	mtspr	SPRN_PMC4, r6
 	mtspr	SPRN_PMC5, r8
 	mtspr	SPRN_PMC6, r9
-	ld	r3, HSTATE_MMCR(r13)
-	ld	r4, HSTATE_MMCR + 8(r13)
-	ld	r5, HSTATE_MMCR + 16(r13)
-	ld	r6, HSTATE_MMCR + 24(r13)
-	ld	r7, HSTATE_MMCR + 32(r13)
+	ld	r3, HSTATE_MMCR0(r13)
+	ld	r4, HSTATE_MMCR1(r13)
+	ld	r5, HSTATE_MMCRA(r13)
+	ld	r6, HSTATE_SIAR(r13)
+	ld	r7, HSTATE_SDAR(r13)
 	mtspr	SPRN_MMCR1, r4
 	mtspr	SPRN_MMCRA, r5
 	mtspr	SPRN_SIAR, r6
 	mtspr	SPRN_SDAR, r7
 BEGIN_FTR_SECTION
-	ld	r8, HSTATE_MMCR + 40(r13)
-	ld	r9, HSTATE_MMCR + 48(r13)
+	ld	r8, HSTATE_MMCR2(r13)
+	ld	r9, HSTATE_SIER(r13)
 	mtspr	SPRN_MMCR2, r8
 	mtspr	SPRN_SIER, r9
 END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
-- 
2.1.0
