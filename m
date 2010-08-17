Return-Path: <agraf@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 70040B7161
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 17 Aug 2010 23:58:08 +1000 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 18/26] KVM: PPC: Make PV mtmsr work with r30 and r31
Date: Tue, 17 Aug 2010 15:57:53 +0200
Message-Id: <1282053481-18787-19-git-send-email-agraf@suse.de>
In-Reply-To: <1282053481-18787-1-git-send-email-agraf@suse.de>
References: <1282053481-18787-1-git-send-email-agraf@suse.de>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	KVM list <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

So far we've been restricting ourselves to r0-r29 as registers an mtmsr
instruction could use. This was bad, as there are some code paths in
Linux actually using r30.

So let's instead handle all registers gracefully and get rid of that
stupid limitation

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/kernel/kvm.c      |   39 ++++++++++++++++++++++++++++++++-------
 arch/powerpc/kernel/kvm_emul.S |   17 ++++++++---------
 2 files changed, 40 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/kernel/kvm.c b/arch/powerpc/kernel/kvm.c
index 43ec78a..517967d 100644
--- a/arch/powerpc/kernel/kvm.c
+++ b/arch/powerpc/kernel/kvm.c
@@ -43,6 +43,7 @@
 #define KVM_INST_B_MAX		0x01ffffff
 
 #define KVM_MASK_RT		0x03e00000
+#define KVM_RT_30		0x03c00000
 #define KVM_MASK_RB		0x0000f800
 #define KVM_INST_MFMSR		0x7c0000a6
 #define KVM_INST_MFSPR_SPRG0	0x7c1042a6
@@ -83,6 +84,15 @@ static inline void kvm_patch_ins(u32 *inst, u32 new_inst)
 	flush_icache_range((ulong)inst, (ulong)inst + 4);
 }
 
+static void kvm_patch_ins_ll(u32 *inst, long addr, u32 rt)
+{
+#ifdef CONFIG_64BIT
+	kvm_patch_ins(inst, KVM_INST_LD | rt | (addr & 0x0000fffc));
+#else
+	kvm_patch_ins(inst, KVM_INST_LWZ | rt | (addr & 0x0000fffc));
+#endif
+}
+
 static void kvm_patch_ins_ld(u32 *inst, long addr, u32 rt)
 {
 #ifdef CONFIG_64BIT
@@ -187,7 +197,6 @@ static void kvm_patch_ins_mtmsrd(u32 *inst, u32 rt)
 extern u32 kvm_emulate_mtmsr_branch_offs;
 extern u32 kvm_emulate_mtmsr_reg1_offs;
 extern u32 kvm_emulate_mtmsr_reg2_offs;
-extern u32 kvm_emulate_mtmsr_reg3_offs;
 extern u32 kvm_emulate_mtmsr_orig_ins_offs;
 extern u32 kvm_emulate_mtmsr_len;
 extern u32 kvm_emulate_mtmsr[];
@@ -217,9 +226,27 @@ static void kvm_patch_ins_mtmsr(u32 *inst, u32 rt)
 	/* Modify the chunk to fit the invocation */
 	memcpy(p, kvm_emulate_mtmsr, kvm_emulate_mtmsr_len * 4);
 	p[kvm_emulate_mtmsr_branch_offs] |= distance_end & KVM_INST_B_MASK;
-	p[kvm_emulate_mtmsr_reg1_offs] |= rt;
-	p[kvm_emulate_mtmsr_reg2_offs] |= rt;
-	p[kvm_emulate_mtmsr_reg3_offs] |= rt;
+
+	/* Make clobbered registers work too */
+	switch (get_rt(rt)) {
+	case 30:
+		kvm_patch_ins_ll(&p[kvm_emulate_mtmsr_reg1_offs],
+				 magic_var(scratch2), KVM_RT_30);
+		kvm_patch_ins_ll(&p[kvm_emulate_mtmsr_reg2_offs],
+				 magic_var(scratch2), KVM_RT_30);
+		break;
+	case 31:
+		kvm_patch_ins_ll(&p[kvm_emulate_mtmsr_reg1_offs],
+				 magic_var(scratch1), KVM_RT_30);
+		kvm_patch_ins_ll(&p[kvm_emulate_mtmsr_reg2_offs],
+				 magic_var(scratch1), KVM_RT_30);
+		break;
+	default:
+		p[kvm_emulate_mtmsr_reg1_offs] |= rt;
+		p[kvm_emulate_mtmsr_reg2_offs] |= rt;
+		break;
+	}
+
 	p[kvm_emulate_mtmsr_orig_ins_offs] = *inst;
 	flush_icache_range((ulong)p, (ulong)p + kvm_emulate_mtmsr_len * 4);
 
@@ -403,9 +430,7 @@ static void kvm_check_ins(u32 *inst, u32 features)
 		break;
 	case KVM_INST_MTMSR:
 	case KVM_INST_MTMSRD_L0:
-		/* We use r30 and r31 during the hook */
-		if (get_rt(inst_rt) < 30)
-			kvm_patch_ins_mtmsr(inst, inst_rt);
+		kvm_patch_ins_mtmsr(inst, inst_rt);
 		break;
 	}
 
diff --git a/arch/powerpc/kernel/kvm_emul.S b/arch/powerpc/kernel/kvm_emul.S
index a6e97e7..6530532 100644
--- a/arch/powerpc/kernel/kvm_emul.S
+++ b/arch/powerpc/kernel/kvm_emul.S
@@ -135,7 +135,8 @@ kvm_emulate_mtmsr:
 
 	/* Find the changed bits between old and new MSR */
 kvm_emulate_mtmsr_reg1:
-	xor	r31, r0, r31
+	ori	r30, r0, 0
+	xor	r31, r30, r31
 
 	/* Check if we need to really do mtmsr */
 	LOAD_REG_IMMEDIATE(r30, MSR_CRITICAL_BITS)
@@ -156,14 +157,17 @@ kvm_emulate_mtmsr_orig_ins:
 
 maybe_stay_in_guest:
 
+	/* Get the target register in r30 */
+kvm_emulate_mtmsr_reg2:
+	ori	r30, r0, 0
+
 	/* Check if we have to fetch an interrupt */
 	lwz	r31, (KVM_MAGIC_PAGE + KVM_MAGIC_INT)(0)
 	cmpwi	r31, 0
 	beq+	no_mtmsr
 
 	/* Check if we may trigger an interrupt */
-kvm_emulate_mtmsr_reg2:
-	andi.	r31, r0, MSR_EE
+	andi.	r31, r30, MSR_EE
 	beq	no_mtmsr
 
 	b	do_mtmsr
@@ -171,8 +175,7 @@ kvm_emulate_mtmsr_reg2:
 no_mtmsr:
 
 	/* Put MSR into magic page because we don't call mtmsr */
-kvm_emulate_mtmsr_reg3:
-	STL64(r0, KVM_MAGIC_PAGE + KVM_MAGIC_MSR, 0)
+	STL64(r30, KVM_MAGIC_PAGE + KVM_MAGIC_MSR, 0)
 
 	SCRATCH_RESTORE
 
@@ -193,10 +196,6 @@ kvm_emulate_mtmsr_reg1_offs:
 kvm_emulate_mtmsr_reg2_offs:
 	.long (kvm_emulate_mtmsr_reg2 - kvm_emulate_mtmsr) / 4
 
-.global kvm_emulate_mtmsr_reg3_offs
-kvm_emulate_mtmsr_reg3_offs:
-	.long (kvm_emulate_mtmsr_reg3 - kvm_emulate_mtmsr) / 4
-
 .global kvm_emulate_mtmsr_orig_ins_offs
 kvm_emulate_mtmsr_orig_ins_offs:
 	.long (kvm_emulate_mtmsr_orig_ins - kvm_emulate_mtmsr) / 4
-- 
1.6.0.2
