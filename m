Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tKqP10qBlzDvt1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Nov 2016 18:28:53 +1100 (AEDT)
From: Paul Mackerras <paulus@ozlabs.org>
To: kvm@vger.kernel.org,
	kvm-ppc@vger.kernel.org,
	linuxppc-dev@ozlabs.org
Subject: [PATCH 07/13] KVM: PPC: Book3S HV: Adjust host/guest context switch
 for POWER9
Date: Fri, 18 Nov 2016 18:28:36 +1100
Message-Id: <1479454122-26994-8-git-send-email-paulus@ozlabs.org>
In-Reply-To: <1479454122-26994-1-git-send-email-paulus@ozlabs.org>
References: <1479454122-26994-1-git-send-email-paulus@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Some special-purpose registers that were present and accessible
by guests on POWER8 no longer exist on POWER9, so this adds
feature sections to ensure that we don't try to context-switch
them when going into or out of a guest on POWER9.  These are
all relatively obscure, rarely-used registers, but we had to
context-switch them on POWER8 to avoid creating a covert channel.
They are: SPMC1, SPMC2, MMCRS, CSIGR, TACR, TCSCR, and ACOP.

Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/kvm/book3s_hv_rmhandlers.S | 50 ++++++++++++++++++++-------------
 1 file changed, 30 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index dc25467..d422014 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -752,14 +752,16 @@ END_FTR_SECTION_IFSET(CPU_FTR_PMAO_BUG)
 BEGIN_FTR_SECTION
 	ld	r5, VCPU_MMCR + 24(r4)
 	ld	r6, VCPU_SIER(r4)
+	mtspr	SPRN_MMCR2, r5
+	mtspr	SPRN_SIER, r6
+BEGIN_FTR_SECTION_NESTED(96)
 	lwz	r7, VCPU_PMC + 24(r4)
 	lwz	r8, VCPU_PMC + 28(r4)
 	ld	r9, VCPU_MMCR + 32(r4)
-	mtspr	SPRN_MMCR2, r5
-	mtspr	SPRN_SIER, r6
 	mtspr	SPRN_SPMC1, r7
 	mtspr	SPRN_SPMC2, r8
 	mtspr	SPRN_MMCRS, r9
+END_FTR_SECTION_NESTED(CPU_FTR_ARCH_300, 0, 96)
 END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
 	mtspr	SPRN_MMCR0, r3
 	isync
@@ -815,20 +817,22 @@ END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_207S)
 	mtspr	SPRN_EBBHR, r8
 	ld	r5, VCPU_EBBRR(r4)
 	ld	r6, VCPU_BESCR(r4)
-	ld	r7, VCPU_CSIGR(r4)
-	ld	r8, VCPU_TACR(r4)
+	lwz	r7, VCPU_GUEST_PID(r4)
+	ld	r8, VCPU_WORT(r4)
 	mtspr	SPRN_EBBRR, r5
 	mtspr	SPRN_BESCR, r6
-	mtspr	SPRN_CSIGR, r7
-	mtspr	SPRN_TACR, r8
+	mtspr	SPRN_PID, r7
+	mtspr	SPRN_WORT, r8
+BEGIN_FTR_SECTION
 	ld	r5, VCPU_TCSCR(r4)
 	ld	r6, VCPU_ACOP(r4)
-	lwz	r7, VCPU_GUEST_PID(r4)
-	ld	r8, VCPU_WORT(r4)
+	ld	r7, VCPU_CSIGR(r4)
+	ld	r8, VCPU_TACR(r4)
 	mtspr	SPRN_TCSCR, r5
 	mtspr	SPRN_ACOP, r6
-	mtspr	SPRN_PID, r7
-	mtspr	SPRN_WORT, r8
+	mtspr	SPRN_CSIGR, r7
+	mtspr	SPRN_TACR, r8
+END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_300)
 8:
 
 	/*
@@ -1343,20 +1347,22 @@ END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_207S)
 	std	r8, VCPU_EBBHR(r9)
 	mfspr	r5, SPRN_EBBRR
 	mfspr	r6, SPRN_BESCR
-	mfspr	r7, SPRN_CSIGR
-	mfspr	r8, SPRN_TACR
+	mfspr	r7, SPRN_PID
+	mfspr	r8, SPRN_WORT
 	std	r5, VCPU_EBBRR(r9)
 	std	r6, VCPU_BESCR(r9)
-	std	r7, VCPU_CSIGR(r9)
-	std	r8, VCPU_TACR(r9)
+	stw	r7, VCPU_GUEST_PID(r9)
+	std	r8, VCPU_WORT(r9)
+BEGIN_FTR_SECTION
 	mfspr	r5, SPRN_TCSCR
 	mfspr	r6, SPRN_ACOP
-	mfspr	r7, SPRN_PID
-	mfspr	r8, SPRN_WORT
+	mfspr	r7, SPRN_CSIGR
+	mfspr	r8, SPRN_TACR
 	std	r5, VCPU_TCSCR(r9)
 	std	r6, VCPU_ACOP(r9)
-	stw	r7, VCPU_GUEST_PID(r9)
-	std	r8, VCPU_WORT(r9)
+	std	r7, VCPU_CSIGR(r9)
+	std	r8, VCPU_TACR(r9)
+END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_300)
 	/*
 	 * Restore various registers to 0, where non-zero values
 	 * set by the guest could disrupt the host.
@@ -1365,12 +1371,14 @@ END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_207S)
 	mtspr	SPRN_IAMR, r0
 	mtspr	SPRN_CIABR, r0
 	mtspr	SPRN_DAWRX, r0
-	mtspr	SPRN_TCSCR, r0
 	mtspr	SPRN_WORT, r0
+BEGIN_FTR_SECTION
+	mtspr	SPRN_TCSCR, r0
 	/* Set MMCRS to 1<<31 to freeze and disable the SPMC counters */
 	li	r0, 1
 	sldi	r0, r0, 31
 	mtspr	SPRN_MMCRS, r0
+END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_300)
 8:
 
 	/* Save and reset AMR and UAMOR before turning on the MMU */
@@ -1504,15 +1512,17 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
 	stw	r8, VCPU_PMC + 20(r9)
 BEGIN_FTR_SECTION
 	mfspr	r5, SPRN_SIER
+	std	r5, VCPU_SIER(r9)
+BEGIN_FTR_SECTION_NESTED(96)
 	mfspr	r6, SPRN_SPMC1
 	mfspr	r7, SPRN_SPMC2
 	mfspr	r8, SPRN_MMCRS
-	std	r5, VCPU_SIER(r9)
 	stw	r6, VCPU_PMC + 24(r9)
 	stw	r7, VCPU_PMC + 28(r9)
 	std	r8, VCPU_MMCR + 32(r9)
 	lis	r4, 0x8000
 	mtspr	SPRN_MMCRS, r4
+END_FTR_SECTION_NESTED(CPU_FTR_ARCH_300, 0, 96)
 END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
 22:
 	/* Clear out SLB */
-- 
2.7.4
