Return-Path: <agraf@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 29EC5B7235
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 17 Aug 2010 23:58:13 +1000 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 17/26] KVM: PPC: Add mtsrin PV code
Date: Tue, 17 Aug 2010 15:57:52 +0200
Message-Id: <1282053481-18787-18-git-send-email-agraf@suse.de>
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

This is the guest side of the mtsr acceleration. Using this a guest can now
call mtsrin with almost no overhead as long as it ensures that it only uses
it with (MSR_IR|MSR_DR) == 0. Linux does that, so we're good.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/kernel/asm-offsets.c |    1 +
 arch/powerpc/kernel/kvm.c         |   60 +++++++++++++++++++++++++++++++++++++
 arch/powerpc/kernel/kvm_emul.S    |   50 ++++++++++++++++++++++++++++++
 3 files changed, 111 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index e3e740b..5e54d0f 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -478,6 +478,7 @@ int main(void)
 	DEFINE(KVM_MAGIC_MSR, offsetof(struct kvm_vcpu_arch_shared, msr));
 	DEFINE(KVM_MAGIC_CRITICAL, offsetof(struct kvm_vcpu_arch_shared,
 					    critical));
+	DEFINE(KVM_MAGIC_SR, offsetof(struct kvm_vcpu_arch_shared, sr));
 #endif
 
 #ifdef CONFIG_44x
diff --git a/arch/powerpc/kernel/kvm.c b/arch/powerpc/kernel/kvm.c
index f48144f..43ec78a 100644
--- a/arch/powerpc/kernel/kvm.c
+++ b/arch/powerpc/kernel/kvm.c
@@ -43,6 +43,7 @@
 #define KVM_INST_B_MAX		0x01ffffff
 
 #define KVM_MASK_RT		0x03e00000
+#define KVM_MASK_RB		0x0000f800
 #define KVM_INST_MFMSR		0x7c0000a6
 #define KVM_INST_MFSPR_SPRG0	0x7c1042a6
 #define KVM_INST_MFSPR_SPRG1	0x7c1142a6
@@ -70,6 +71,8 @@
 #define KVM_INST_WRTEEI_0	0x7c000146
 #define KVM_INST_WRTEEI_1	0x7c008146
 
+#define KVM_INST_MTSRIN		0x7c0001e4
+
 static bool kvm_patching_worked = true;
 static char kvm_tmp[1024 * 1024];
 static int kvm_tmp_index;
@@ -265,6 +268,51 @@ static void kvm_patch_ins_wrteei(u32 *inst)
 
 #endif
 
+#ifdef CONFIG_PPC_BOOK3S_32
+
+extern u32 kvm_emulate_mtsrin_branch_offs;
+extern u32 kvm_emulate_mtsrin_reg1_offs;
+extern u32 kvm_emulate_mtsrin_reg2_offs;
+extern u32 kvm_emulate_mtsrin_orig_ins_offs;
+extern u32 kvm_emulate_mtsrin_len;
+extern u32 kvm_emulate_mtsrin[];
+
+static void kvm_patch_ins_mtsrin(u32 *inst, u32 rt, u32 rb)
+{
+	u32 *p;
+	int distance_start;
+	int distance_end;
+	ulong next_inst;
+
+	p = kvm_alloc(kvm_emulate_mtsrin_len * 4);
+	if (!p)
+		return;
+
+	/* Find out where we are and put everything there */
+	distance_start = (ulong)p - (ulong)inst;
+	next_inst = ((ulong)inst + 4);
+	distance_end = next_inst - (ulong)&p[kvm_emulate_mtsrin_branch_offs];
+
+	/* Make sure we only write valid b instructions */
+	if (distance_start > KVM_INST_B_MAX) {
+		kvm_patching_worked = false;
+		return;
+	}
+
+	/* Modify the chunk to fit the invocation */
+	memcpy(p, kvm_emulate_mtsrin, kvm_emulate_mtsrin_len * 4);
+	p[kvm_emulate_mtsrin_branch_offs] |= distance_end & KVM_INST_B_MASK;
+	p[kvm_emulate_mtsrin_reg1_offs] |= (rb << 10);
+	p[kvm_emulate_mtsrin_reg2_offs] |= rt;
+	p[kvm_emulate_mtsrin_orig_ins_offs] = *inst;
+	flush_icache_range((ulong)p, (ulong)p + kvm_emulate_mtsrin_len * 4);
+
+	/* Patch the invocation */
+	kvm_patch_ins_b(inst, distance_start);
+}
+
+#endif
+
 static void kvm_map_magic_page(void *data)
 {
 	u32 *features = data;
@@ -361,6 +409,18 @@ static void kvm_check_ins(u32 *inst, u32 features)
 		break;
 	}
 
+	switch (inst_no_rt & ~KVM_MASK_RB) {
+#ifdef CONFIG_PPC_BOOK3S_32
+	case KVM_INST_MTSRIN:
+		if (features & KVM_MAGIC_FEAT_SR) {
+			u32 inst_rb = _inst & KVM_MASK_RB;
+			kvm_patch_ins_mtsrin(inst, inst_rt, inst_rb);
+		}
+		break;
+		break;
+#endif
+	}
+
 	switch (_inst) {
 #ifdef CONFIG_BOOKE
 	case KVM_INST_WRTEEI_0:
diff --git a/arch/powerpc/kernel/kvm_emul.S b/arch/powerpc/kernel/kvm_emul.S
index 3199f65..a6e97e7 100644
--- a/arch/powerpc/kernel/kvm_emul.S
+++ b/arch/powerpc/kernel/kvm_emul.S
@@ -245,3 +245,53 @@ kvm_emulate_wrteei_ee_offs:
 .global kvm_emulate_wrteei_len
 kvm_emulate_wrteei_len:
 	.long (kvm_emulate_wrteei_end - kvm_emulate_wrteei) / 4
+
+
+.global kvm_emulate_mtsrin
+kvm_emulate_mtsrin:
+
+	SCRATCH_SAVE
+
+	LL64(r31, KVM_MAGIC_PAGE + KVM_MAGIC_MSR, 0)
+	andi.	r31, r31, MSR_DR | MSR_IR
+	beq	kvm_emulate_mtsrin_reg1
+
+	SCRATCH_RESTORE
+
+kvm_emulate_mtsrin_orig_ins:
+	nop
+	b	kvm_emulate_mtsrin_branch
+
+kvm_emulate_mtsrin_reg1:
+	/* rX >> 26 */
+	rlwinm  r30,r0,6,26,29
+
+kvm_emulate_mtsrin_reg2:
+	stw	r0, (KVM_MAGIC_PAGE + KVM_MAGIC_SR)(r30)
+
+	SCRATCH_RESTORE
+
+	/* Go back to caller */
+kvm_emulate_mtsrin_branch:
+	b	.
+kvm_emulate_mtsrin_end:
+
+.global kvm_emulate_mtsrin_branch_offs
+kvm_emulate_mtsrin_branch_offs:
+	.long (kvm_emulate_mtsrin_branch - kvm_emulate_mtsrin) / 4
+
+.global kvm_emulate_mtsrin_reg1_offs
+kvm_emulate_mtsrin_reg1_offs:
+	.long (kvm_emulate_mtsrin_reg1 - kvm_emulate_mtsrin) / 4
+
+.global kvm_emulate_mtsrin_reg2_offs
+kvm_emulate_mtsrin_reg2_offs:
+	.long (kvm_emulate_mtsrin_reg2 - kvm_emulate_mtsrin) / 4
+
+.global kvm_emulate_mtsrin_orig_ins_offs
+kvm_emulate_mtsrin_orig_ins_offs:
+	.long (kvm_emulate_mtsrin_orig_ins - kvm_emulate_mtsrin) / 4
+
+.global kvm_emulate_mtsrin_len
+kvm_emulate_mtsrin_len:
+	.long (kvm_emulate_mtsrin_end - kvm_emulate_mtsrin) / 4
-- 
1.6.0.2
