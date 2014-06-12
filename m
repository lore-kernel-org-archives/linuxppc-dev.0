Return-Path: <anton@samba.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0416E1A0464
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jun 2014 18:15:12 +1000 (EST)
Date: Thu, 12 Jun 2014 18:15:10 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, agraf@suse.de, clg@fr.ibm.com
Subject: [PATCH 2/4] KVM: PPC: Book3S HV: Fix ABIv2 issues
Message-ID: <20140612181510.5ea60635@kryten>
In-Reply-To: <20140612181420.65b05675@kryten>
References: <20140612181420.65b05675@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

binutils knows that a branch to a function descriptor is actually
a branch to the function text. By removing the explicit branch to
dot symbols, we maintain both ABIv1 and ABIv2 compatibility.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
===================================================================
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -675,9 +675,9 @@ END_FTR_SECTION_IFCLR(CPU_FTR_TM)
 
 	mr	r31, r4
 	addi	r3, r31, VCPU_FPRS_TM
-	bl	.load_fp_state
+	bl	load_fp_state
 	addi	r3, r31, VCPU_VRS_TM
-	bl	.load_vr_state
+	bl	load_vr_state
 	mr	r4, r31
 	lwz	r7, VCPU_VRSAVE_TM(r4)
 	mtspr	SPRN_VRSAVE, r7
@@ -1421,9 +1421,9 @@ END_FTR_SECTION_IFCLR(CPU_FTR_TM)
 
 	/* Save FP/VSX. */
 	addi	r3, r9, VCPU_FPRS_TM
-	bl	.store_fp_state
+	bl	store_fp_state
 	addi	r3, r9, VCPU_VRS_TM
-	bl	.store_vr_state
+	bl	store_vr_state
 	mfspr	r6, SPRN_VRSAVE
 	stw	r6, VCPU_VRSAVE_TM(r9)
 1:
@@ -2421,11 +2421,11 @@ END_FTR_SECTION_IFSET(CPU_FTR_VSX)
 	mtmsrd	r8
 	isync
 	addi	r3,r3,VCPU_FPRS
-	bl	.store_fp_state
+	bl	store_fp_state
 #ifdef CONFIG_ALTIVEC
 BEGIN_FTR_SECTION
 	addi	r3,r31,VCPU_VRS
-	bl	.store_vr_state
+	bl	store_vr_state
 END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
 #endif
 	mfspr	r6,SPRN_VRSAVE
@@ -2457,11 +2457,11 @@ END_FTR_SECTION_IFSET(CPU_FTR_VSX)
 	mtmsrd	r8
 	isync
 	addi	r3,r4,VCPU_FPRS
-	bl	.load_fp_state
+	bl	load_fp_state
 #ifdef CONFIG_ALTIVEC
 BEGIN_FTR_SECTION
 	addi	r3,r31,VCPU_VRS
-	bl	.load_vr_state
+	bl	load_vr_state
 END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
 #endif
 	lwz	r7,VCPU_VRSAVE(r31)
