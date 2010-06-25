Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by ozlabs.org (Postfix) with ESMTP id EDE7110084C
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 26 Jun 2010 09:25:18 +1000 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 19/26] KVM: PPC: PV instructions to loads and stores
Date: Sat, 26 Jun 2010 01:25:07 +0200
Message-Id: <1277508314-915-20-git-send-email-agraf@suse.de>
In-Reply-To: <1277508314-915-1-git-send-email-agraf@suse.de>
References: <1277508314-915-1-git-send-email-agraf@suse.de>
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

Some instructions can simply be replaced by load and store instructions to
or from the magic page.

This patch replaces often called instructions that fall into the above category.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/kernel/kvm.c |  111 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 111 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/kvm.c b/arch/powerpc/kernel/kvm.c
index d873bc6..b165b20 100644
--- a/arch/powerpc/kernel/kvm.c
+++ b/arch/powerpc/kernel/kvm.c
@@ -32,8 +32,65 @@
 #define KVM_MAGIC_PAGE		(-4096L)
 #define magic_var(x) KVM_MAGIC_PAGE + offsetof(struct kvm_vcpu_arch_shared, x)
 
+#define KVM_INST_LWZ		0x80000000
+#define KVM_INST_STW		0x90000000
+#define KVM_INST_LD		0xe8000000
+#define KVM_INST_STD		0xf8000000
+#define KVM_INST_NOP		0x60000000
+#define KVM_INST_B		0x48000000
+#define KVM_INST_B_MASK		0x03ffffff
+#define KVM_INST_B_MAX		0x01ffffff
+
+#define KVM_MASK_RT		0x03e00000
+#define KVM_INST_MFMSR		0x7c0000a6
+#define KVM_INST_MFSPR_SPRG0	0x7c1042a6
+#define KVM_INST_MFSPR_SPRG1	0x7c1142a6
+#define KVM_INST_MFSPR_SPRG2	0x7c1242a6
+#define KVM_INST_MFSPR_SPRG3	0x7c1342a6
+#define KVM_INST_MFSPR_SRR0	0x7c1a02a6
+#define KVM_INST_MFSPR_SRR1	0x7c1b02a6
+#define KVM_INST_MFSPR_DAR	0x7c1302a6
+#define KVM_INST_MFSPR_DSISR	0x7c1202a6
+
+#define KVM_INST_MTSPR_SPRG0	0x7c1043a6
+#define KVM_INST_MTSPR_SPRG1	0x7c1143a6
+#define KVM_INST_MTSPR_SPRG2	0x7c1243a6
+#define KVM_INST_MTSPR_SPRG3	0x7c1343a6
+#define KVM_INST_MTSPR_SRR0	0x7c1a03a6
+#define KVM_INST_MTSPR_SRR1	0x7c1b03a6
+#define KVM_INST_MTSPR_DAR	0x7c1303a6
+#define KVM_INST_MTSPR_DSISR	0x7c1203a6
+
 static bool kvm_patching_worked = true;
 
+static void kvm_patch_ins_ld(u32 *inst, long addr, u32 rt)
+{
+#ifdef CONFIG_64BIT
+	*inst = KVM_INST_LD | rt | (addr & 0x0000fffc);
+#else
+	*inst = KVM_INST_LWZ | rt | ((addr + 4) & 0x0000fffc);
+#endif
+}
+
+static void kvm_patch_ins_lwz(u32 *inst, long addr, u32 rt)
+{
+	*inst = KVM_INST_LWZ | rt | (addr & 0x0000ffff);
+}
+
+static void kvm_patch_ins_std(u32 *inst, long addr, u32 rt)
+{
+#ifdef CONFIG_64BIT
+	*inst = KVM_INST_STD | rt | (addr & 0x0000fffc);
+#else
+	*inst = KVM_INST_STW | rt | ((addr + 4) & 0x0000fffc);
+#endif
+}
+
+static void kvm_patch_ins_stw(u32 *inst, long addr, u32 rt)
+{
+	*inst = KVM_INST_STW | rt | (addr & 0x0000fffc);
+}
+
 static void kvm_map_magic_page(void *data)
 {
 	kvm_hypercall2(KVM_HC_PPC_MAP_MAGIC_PAGE,
@@ -48,6 +105,60 @@ static void kvm_check_ins(u32 *inst)
 	u32 inst_rt = _inst & KVM_MASK_RT;
 
 	switch (inst_no_rt) {
+	/* Loads */
+	case KVM_INST_MFMSR:
+		kvm_patch_ins_ld(inst, magic_var(msr), inst_rt);
+		break;
+	case KVM_INST_MFSPR_SPRG0:
+		kvm_patch_ins_ld(inst, magic_var(sprg0), inst_rt);
+		break;
+	case KVM_INST_MFSPR_SPRG1:
+		kvm_patch_ins_ld(inst, magic_var(sprg1), inst_rt);
+		break;
+	case KVM_INST_MFSPR_SPRG2:
+		kvm_patch_ins_ld(inst, magic_var(sprg2), inst_rt);
+		break;
+	case KVM_INST_MFSPR_SPRG3:
+		kvm_patch_ins_ld(inst, magic_var(sprg3), inst_rt);
+		break;
+	case KVM_INST_MFSPR_SRR0:
+		kvm_patch_ins_ld(inst, magic_var(srr0), inst_rt);
+		break;
+	case KVM_INST_MFSPR_SRR1:
+		kvm_patch_ins_ld(inst, magic_var(srr1), inst_rt);
+		break;
+	case KVM_INST_MFSPR_DAR:
+		kvm_patch_ins_ld(inst, magic_var(dar), inst_rt);
+		break;
+	case KVM_INST_MFSPR_DSISR:
+		kvm_patch_ins_lwz(inst, magic_var(dsisr), inst_rt);
+		break;
+
+	/* Stores */
+	case KVM_INST_MTSPR_SPRG0:
+		kvm_patch_ins_std(inst, magic_var(sprg0), inst_rt);
+		break;
+	case KVM_INST_MTSPR_SPRG1:
+		kvm_patch_ins_std(inst, magic_var(sprg1), inst_rt);
+		break;
+	case KVM_INST_MTSPR_SPRG2:
+		kvm_patch_ins_std(inst, magic_var(sprg2), inst_rt);
+		break;
+	case KVM_INST_MTSPR_SPRG3:
+		kvm_patch_ins_std(inst, magic_var(sprg3), inst_rt);
+		break;
+	case KVM_INST_MTSPR_SRR0:
+		kvm_patch_ins_std(inst, magic_var(srr0), inst_rt);
+		break;
+	case KVM_INST_MTSPR_SRR1:
+		kvm_patch_ins_std(inst, magic_var(srr1), inst_rt);
+		break;
+	case KVM_INST_MTSPR_DAR:
+		kvm_patch_ins_std(inst, magic_var(dar), inst_rt);
+		break;
+	case KVM_INST_MTSPR_DSISR:
+		kvm_patch_ins_stw(inst, magic_var(dsisr), inst_rt);
+		break;
 	}
 
 	switch (_inst) {
-- 
1.6.0.2
