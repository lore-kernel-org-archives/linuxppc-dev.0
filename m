Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp04.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8FB3F2C0141
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Oct 2013 03:48:52 +1100 (EST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 8 Oct 2013 02:48:51 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 505CD2BB005E
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Oct 2013 03:48:48 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r97Gmau35243268
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 8 Oct 2013 03:48:36 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r97GmcfL024862
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 8 Oct 2013 03:48:38 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: agraf@suse.de, benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH -V2 06/14] kvm: powerpc: booke: Convert BOOKE to use
 kvmppc_ops callbacks
Date: Mon,  7 Oct 2013 22:17:54 +0530
Message-Id: <1381164482-31001-7-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1381164482-31001-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1381164482-31001-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

Make required changes to get BOOKE configs to build with
the introduction of kvmppc_ops callback

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/kvm_ppc.h |  4 +--
 arch/powerpc/kvm/44x.c             | 55 +++++++++++++++++++++++++++-----------
 arch/powerpc/kvm/44x_emulate.c     |  8 +++---
 arch/powerpc/kvm/44x_tlb.c         |  2 +-
 arch/powerpc/kvm/booke.c           | 47 +++++++++++++++++++++++++++-----
 arch/powerpc/kvm/booke.h           | 24 +++++++++++++++++
 arch/powerpc/kvm/e500.c            | 53 +++++++++++++++++++++++++-----------
 arch/powerpc/kvm/e500_emulate.c    |  8 +++---
 arch/powerpc/kvm/e500_mmu.c        |  2 +-
 arch/powerpc/kvm/e500mc.c          | 54 ++++++++++++++++++++++++++-----------
 10 files changed, 194 insertions(+), 63 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
index 1d22b53..326033c 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -285,10 +285,10 @@ static inline u32 kvmppc_set_field(u64 inst, int msb, int lsb, int value)
 	__v;					\
 })
 
-void kvmppc_core_get_sregs(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs);
+int kvmppc_core_get_sregs(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs);
 int kvmppc_core_set_sregs(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs);
 
-void kvmppc_get_sregs_ivor(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs);
+int kvmppc_get_sregs_ivor(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs);
 int kvmppc_set_sregs_ivor(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs);
 
 int kvm_vcpu_ioctl_get_one_reg(struct kvm_vcpu *vcpu, struct kvm_one_reg *reg);
diff --git a/arch/powerpc/kvm/44x.c b/arch/powerpc/kvm/44x.c
index 2f5c6b6..a765bcd 100644
--- a/arch/powerpc/kvm/44x.c
+++ b/arch/powerpc/kvm/44x.c
@@ -31,13 +31,13 @@
 #include "44x_tlb.h"
 #include "booke.h"
 
-void kvmppc_core_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
+static void kvmppc_core_vcpu_load_44x(struct kvm_vcpu *vcpu, int cpu)
 {
 	kvmppc_booke_vcpu_load(vcpu, cpu);
 	kvmppc_44x_tlb_load(vcpu);
 }
 
-void kvmppc_core_vcpu_put(struct kvm_vcpu *vcpu)
+static void kvmppc_core_vcpu_put_44x(struct kvm_vcpu *vcpu)
 {
 	kvmppc_44x_tlb_put(vcpu);
 	kvmppc_booke_vcpu_put(vcpu);
@@ -114,29 +114,32 @@ int kvmppc_core_vcpu_translate(struct kvm_vcpu *vcpu,
 	return 0;
 }
 
-void kvmppc_core_get_sregs(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs)
+static int kvmppc_core_get_sregs_44x(struct kvm_vcpu *vcpu,
+				      struct kvm_sregs *sregs)
 {
-	kvmppc_get_sregs_ivor(vcpu, sregs);
+	return kvmppc_get_sregs_ivor(vcpu, sregs);
 }
 
-int kvmppc_core_set_sregs(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs)
+static int kvmppc_core_set_sregs_44x(struct kvm_vcpu *vcpu,
+				     struct kvm_sregs *sregs)
 {
 	return kvmppc_set_sregs_ivor(vcpu, sregs);
 }
 
-int kvmppc_get_one_reg(struct kvm_vcpu *vcpu, u64 id,
-			union kvmppc_one_reg *val)
+static int kvmppc_get_one_reg_44x(struct kvm_vcpu *vcpu, u64 id,
+				  union kvmppc_one_reg *val)
 {
 	return -EINVAL;
 }
 
-int kvmppc_set_one_reg(struct kvm_vcpu *vcpu, u64 id,
-		       union kvmppc_one_reg *val)
+static int kvmppc_set_one_reg_44x(struct kvm_vcpu *vcpu, u64 id,
+				  union kvmppc_one_reg *val)
 {
 	return -EINVAL;
 }
 
-struct kvm_vcpu *kvmppc_core_vcpu_create(struct kvm *kvm, unsigned int id)
+static struct kvm_vcpu *kvmppc_core_vcpu_create_44x(struct kvm *kvm,
+						    unsigned int id)
 {
 	struct kvmppc_vcpu_44x *vcpu_44x;
 	struct kvm_vcpu *vcpu;
@@ -167,7 +170,7 @@ out:
 	return ERR_PTR(err);
 }
 
-void kvmppc_core_vcpu_free(struct kvm_vcpu *vcpu)
+static void kvmppc_core_vcpu_free_44x(struct kvm_vcpu *vcpu)
 {
 	struct kvmppc_vcpu_44x *vcpu_44x = to_44x(vcpu);
 
@@ -176,24 +179,46 @@ void kvmppc_core_vcpu_free(struct kvm_vcpu *vcpu)
 	kmem_cache_free(kvm_vcpu_cache, vcpu_44x);
 }
 
-int kvmppc_core_init_vm(struct kvm *kvm)
+static int kvmppc_core_init_vm_44x(struct kvm *kvm)
 {
 	return 0;
 }
 
-void kvmppc_core_destroy_vm(struct kvm *kvm)
+static void kvmppc_core_destroy_vm_44x(struct kvm *kvm)
 {
 }
 
+static struct kvmppc_ops kvm_ops_44x = {
+	.get_sregs = kvmppc_core_get_sregs_44x,
+	.set_sregs = kvmppc_core_set_sregs_44x,
+	.get_one_reg = kvmppc_get_one_reg_44x,
+	.set_one_reg = kvmppc_set_one_reg_44x,
+	.vcpu_load   = kvmppc_core_vcpu_load_44x,
+	.vcpu_put    = kvmppc_core_vcpu_put_44x,
+	.vcpu_create = kvmppc_core_vcpu_create_44x,
+	.vcpu_free   = kvmppc_core_vcpu_free_44x,
+	.mmu_destroy  = kvmppc_mmu_destroy_44x,
+	.init_vm = kvmppc_core_init_vm_44x,
+	.destroy_vm = kvmppc_core_destroy_vm_44x,
+	.emulate_op = kvmppc_core_emulate_op_44x,
+	.emulate_mtspr = kvmppc_core_emulate_mtspr_44x,
+	.emulate_mfspr = kvmppc_core_emulate_mfspr_44x,
+};
+
 static int __init kvmppc_44x_init(void)
 {
 	int r;
 
 	r = kvmppc_booke_init();
 	if (r)
-		return r;
+		goto err_out;
 
-	return kvm_init(NULL, sizeof(struct kvmppc_vcpu_44x), 0, THIS_MODULE);
+	r = kvm_init(&kvm_ops_44x, sizeof(struct kvmppc_vcpu_44x),
+		     0, THIS_MODULE);
+	if (r)
+		goto err_out;
+err_out:
+	return r;
 }
 
 static void __exit kvmppc_44x_exit(void)
diff --git a/arch/powerpc/kvm/44x_emulate.c b/arch/powerpc/kvm/44x_emulate.c
index 35ec0a8..92c9ab4 100644
--- a/arch/powerpc/kvm/44x_emulate.c
+++ b/arch/powerpc/kvm/44x_emulate.c
@@ -91,8 +91,8 @@ static int emulate_mfdcr(struct kvm_vcpu *vcpu, int rt, int dcrn)
 	return EMULATE_DONE;
 }
 
-int kvmppc_core_emulate_op(struct kvm_run *run, struct kvm_vcpu *vcpu,
-                           unsigned int inst, int *advance)
+int kvmppc_core_emulate_op_44x(struct kvm_run *run, struct kvm_vcpu *vcpu,
+			       unsigned int inst, int *advance)
 {
 	int emulated = EMULATE_DONE;
 	int dcrn = get_dcrn(inst);
@@ -152,7 +152,7 @@ int kvmppc_core_emulate_op(struct kvm_run *run, struct kvm_vcpu *vcpu,
 	return emulated;
 }
 
-int kvmppc_core_emulate_mtspr(struct kvm_vcpu *vcpu, int sprn, ulong spr_val)
+int kvmppc_core_emulate_mtspr_44x(struct kvm_vcpu *vcpu, int sprn, ulong spr_val)
 {
 	int emulated = EMULATE_DONE;
 
@@ -172,7 +172,7 @@ int kvmppc_core_emulate_mtspr(struct kvm_vcpu *vcpu, int sprn, ulong spr_val)
 	return emulated;
 }
 
-int kvmppc_core_emulate_mfspr(struct kvm_vcpu *vcpu, int sprn, ulong *spr_val)
+int kvmppc_core_emulate_mfspr_44x(struct kvm_vcpu *vcpu, int sprn, ulong *spr_val)
 {
 	int emulated = EMULATE_DONE;
 
diff --git a/arch/powerpc/kvm/44x_tlb.c b/arch/powerpc/kvm/44x_tlb.c
index ed03854..0deef10 100644
--- a/arch/powerpc/kvm/44x_tlb.c
+++ b/arch/powerpc/kvm/44x_tlb.c
@@ -268,7 +268,7 @@ static void kvmppc_44x_shadow_release(struct kvmppc_vcpu_44x *vcpu_44x,
 	trace_kvm_stlb_inval(stlb_index);
 }
 
-void kvmppc_mmu_destroy(struct kvm_vcpu *vcpu)
+void kvmppc_mmu_destroy_44x(struct kvm_vcpu *vcpu)
 {
 	struct kvmppc_vcpu_44x *vcpu_44x = to_44x(vcpu);
 	int i;
diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index 8b6a790..e5f8ba7 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -1415,7 +1415,7 @@ static int set_sregs_arch206(struct kvm_vcpu *vcpu,
 	return 0;
 }
 
-void kvmppc_get_sregs_ivor(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs)
+int kvmppc_get_sregs_ivor(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs)
 {
 	sregs->u.e.features |= KVM_SREGS_E_IVOR;
 
@@ -1435,6 +1435,7 @@ void kvmppc_get_sregs_ivor(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs)
 	sregs->u.e.ivor_low[13] = vcpu->arch.ivor[BOOKE_IRQPRIO_DTLB_MISS];
 	sregs->u.e.ivor_low[14] = vcpu->arch.ivor[BOOKE_IRQPRIO_ITLB_MISS];
 	sregs->u.e.ivor_low[15] = vcpu->arch.ivor[BOOKE_IRQPRIO_DEBUG];
+	return 0;
 }
 
 int kvmppc_set_sregs_ivor(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs)
@@ -1469,8 +1470,7 @@ int kvm_arch_vcpu_ioctl_get_sregs(struct kvm_vcpu *vcpu,
 
 	get_sregs_base(vcpu, sregs);
 	get_sregs_arch206(vcpu, sregs);
-	kvmppc_core_get_sregs(vcpu, sregs);
-	return 0;
+	return kvmppc_ops->get_sregs(vcpu, sregs);
 }
 
 int kvm_arch_vcpu_ioctl_set_sregs(struct kvm_vcpu *vcpu,
@@ -1489,7 +1489,7 @@ int kvm_arch_vcpu_ioctl_set_sregs(struct kvm_vcpu *vcpu,
 	if (ret < 0)
 		return ret;
 
-	return kvmppc_core_set_sregs(vcpu, sregs);
+	return kvmppc_ops->set_sregs(vcpu, sregs);
 }
 
 int kvm_vcpu_ioctl_get_one_reg(struct kvm_vcpu *vcpu, struct kvm_one_reg *reg)
@@ -1546,7 +1546,7 @@ int kvm_vcpu_ioctl_get_one_reg(struct kvm_vcpu *vcpu, struct kvm_one_reg *reg)
 		val = get_reg_val(reg->id, vcpu->arch.vrsave);
 		break;
 	default:
-		r = kvmppc_get_one_reg(vcpu, reg->id, &val);
+		r = kvmppc_ops->get_one_reg(vcpu, reg->id, &val);
 		break;
 	}
 
@@ -1629,7 +1629,7 @@ int kvm_vcpu_ioctl_set_one_reg(struct kvm_vcpu *vcpu, struct kvm_one_reg *reg)
 		vcpu->arch.vrsave = set_reg_val(reg->id, val);
 		break;
 	default:
-		r = kvmppc_set_one_reg(vcpu, reg->id, &val);
+		r = kvmppc_ops->set_one_reg(vcpu, reg->id, &val);
 		break;
 	}
 
@@ -1907,6 +1907,41 @@ void kvmppc_booke_vcpu_put(struct kvm_vcpu *vcpu)
 	kvmppc_clear_dbsr();
 }
 
+void kvmppc_mmu_destroy(struct kvm_vcpu *vcpu)
+{
+	kvmppc_ops->mmu_destroy(vcpu);
+}
+
+int kvmppc_core_init_vm(struct kvm *kvm)
+{
+	return kvmppc_ops->init_vm(kvm);
+}
+
+struct kvm_vcpu *kvmppc_core_vcpu_create(struct kvm *kvm, unsigned int id)
+{
+	return kvmppc_ops->vcpu_create(kvm, id);
+}
+
+void kvmppc_core_vcpu_free(struct kvm_vcpu *vcpu)
+{
+	kvmppc_ops->vcpu_free(vcpu);
+}
+
+void kvmppc_core_destroy_vm(struct kvm *kvm)
+{
+	kvmppc_ops->destroy_vm(kvm);
+}
+
+void kvmppc_core_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
+{
+	kvmppc_ops->vcpu_load(vcpu, cpu);
+}
+
+void kvmppc_core_vcpu_put(struct kvm_vcpu *vcpu)
+{
+	kvmppc_ops->vcpu_put(vcpu);
+}
+
 int __init kvmppc_booke_init(void)
 {
 #ifndef CONFIG_KVM_BOOKE_HV
diff --git a/arch/powerpc/kvm/booke.h b/arch/powerpc/kvm/booke.h
index a1ff67d..09bfd9b 100644
--- a/arch/powerpc/kvm/booke.h
+++ b/arch/powerpc/kvm/booke.h
@@ -99,6 +99,30 @@ enum int_class {
 
 void kvmppc_set_pending_interrupt(struct kvm_vcpu *vcpu, enum int_class type);
 
+extern void kvmppc_mmu_destroy_44x(struct kvm_vcpu *vcpu);
+extern int kvmppc_core_emulate_op_44x(struct kvm_run *run, struct kvm_vcpu *vcpu,
+				      unsigned int inst, int *advance);
+extern int kvmppc_core_emulate_mtspr_44x(struct kvm_vcpu *vcpu, int sprn,
+					 ulong spr_val);
+extern int kvmppc_core_emulate_mfspr_44x(struct kvm_vcpu *vcpu, int sprn,
+					 ulong *spr_val);
+extern void kvmppc_mmu_destroy_e500(struct kvm_vcpu *vcpu);
+extern int kvmppc_core_emulate_op_e500(struct kvm_run *run,
+				       struct kvm_vcpu *vcpu,
+				       unsigned int inst, int *advance);
+extern int kvmppc_core_emulate_mtspr_e500(struct kvm_vcpu *vcpu, int sprn,
+					  ulong spr_val);
+extern int kvmppc_core_emulate_mfspr_e500(struct kvm_vcpu *vcpu, int sprn,
+					  ulong *spr_val);
+extern void kvmppc_mmu_destroy_e500(struct kvm_vcpu *vcpu);
+extern int kvmppc_core_emulate_op_e500(struct kvm_run *run,
+				       struct kvm_vcpu *vcpu,
+				       unsigned int inst, int *advance);
+extern int kvmppc_core_emulate_mtspr_e500(struct kvm_vcpu *vcpu, int sprn,
+					  ulong spr_val);
+extern int kvmppc_core_emulate_mfspr_e500(struct kvm_vcpu *vcpu, int sprn,
+					  ulong *spr_val);
+
 /*
  * Load up guest vcpu FP state if it's needed.
  * It also set the MSR_FP in thread so that host know
diff --git a/arch/powerpc/kvm/e500.c b/arch/powerpc/kvm/e500.c
index ce6b73c..d225d5e 100644
--- a/arch/powerpc/kvm/e500.c
+++ b/arch/powerpc/kvm/e500.c
@@ -305,7 +305,7 @@ void kvmppc_core_load_guest_debugstate(struct kvm_vcpu *vcpu)
 {
 }
 
-void kvmppc_core_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
+static void kvmppc_core_vcpu_load_e500(struct kvm_vcpu *vcpu, int cpu)
 {
 	kvmppc_booke_vcpu_load(vcpu, cpu);
 
@@ -313,7 +313,7 @@ void kvmppc_core_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 	kvmppc_e500_recalc_shadow_pid(to_e500(vcpu));
 }
 
-void kvmppc_core_vcpu_put(struct kvm_vcpu *vcpu)
+static void kvmppc_core_vcpu_put_e500(struct kvm_vcpu *vcpu)
 {
 #ifdef CONFIG_SPE
 	if (vcpu->arch.shadow_msr & MSR_SPE)
@@ -367,7 +367,8 @@ int kvmppc_core_vcpu_setup(struct kvm_vcpu *vcpu)
 	return 0;
 }
 
-void kvmppc_core_get_sregs(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs)
+static int kvmppc_core_get_sregs_e500(struct kvm_vcpu *vcpu,
+				      struct kvm_sregs *sregs)
 {
 	struct kvmppc_vcpu_e500 *vcpu_e500 = to_e500(vcpu);
 
@@ -388,9 +389,11 @@ void kvmppc_core_get_sregs(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs)
 
 	kvmppc_get_sregs_ivor(vcpu, sregs);
 	kvmppc_get_sregs_e500_tlb(vcpu, sregs);
+	return 0;
 }
 
-int kvmppc_core_set_sregs(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs)
+static int kvmppc_core_set_sregs_e500(struct kvm_vcpu *vcpu,
+				      struct kvm_sregs *sregs)
 {
 	struct kvmppc_vcpu_e500 *vcpu_e500 = to_e500(vcpu);
 	int ret;
@@ -425,21 +428,22 @@ int kvmppc_core_set_sregs(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs)
 	return kvmppc_set_sregs_ivor(vcpu, sregs);
 }
 
-int kvmppc_get_one_reg(struct kvm_vcpu *vcpu, u64 id,
-			union kvmppc_one_reg *val)
+static int kvmppc_get_one_reg_e500(struct kvm_vcpu *vcpu, u64 id,
+				   union kvmppc_one_reg *val)
 {
 	int r = kvmppc_get_one_reg_e500_tlb(vcpu, id, val);
 	return r;
 }
 
-int kvmppc_set_one_reg(struct kvm_vcpu *vcpu, u64 id,
-		       union kvmppc_one_reg *val)
+static int kvmppc_set_one_reg_e500(struct kvm_vcpu *vcpu, u64 id,
+				   union kvmppc_one_reg *val)
 {
 	int r = kvmppc_get_one_reg_e500_tlb(vcpu, id, val);
 	return r;
 }
 
-struct kvm_vcpu *kvmppc_core_vcpu_create(struct kvm *kvm, unsigned int id)
+static struct kvm_vcpu *kvmppc_core_vcpu_create_e500(struct kvm *kvm,
+						     unsigned int id)
 {
 	struct kvmppc_vcpu_e500 *vcpu_e500;
 	struct kvm_vcpu *vcpu;
@@ -481,7 +485,7 @@ out:
 	return ERR_PTR(err);
 }
 
-void kvmppc_core_vcpu_free(struct kvm_vcpu *vcpu)
+static void kvmppc_core_vcpu_free_e500(struct kvm_vcpu *vcpu)
 {
 	struct kvmppc_vcpu_e500 *vcpu_e500 = to_e500(vcpu);
 
@@ -492,15 +496,32 @@ void kvmppc_core_vcpu_free(struct kvm_vcpu *vcpu)
 	kmem_cache_free(kvm_vcpu_cache, vcpu_e500);
 }
 
-int kvmppc_core_init_vm(struct kvm *kvm)
+static int kvmppc_core_init_vm_e500(struct kvm *kvm)
 {
 	return 0;
 }
 
-void kvmppc_core_destroy_vm(struct kvm *kvm)
+static void kvmppc_core_destroy_vm_e500(struct kvm *kvm)
 {
 }
 
+static struct kvmppc_ops kvm_ops_e500 = {
+	.get_sregs = kvmppc_core_get_sregs_e500,
+	.set_sregs = kvmppc_core_set_sregs_e500,
+	.get_one_reg = kvmppc_get_one_reg_e500,
+	.set_one_reg = kvmppc_set_one_reg_e500,
+	.vcpu_load   = kvmppc_core_vcpu_load_e500,
+	.vcpu_put    = kvmppc_core_vcpu_put_e500,
+	.vcpu_create = kvmppc_core_vcpu_create_e500,
+	.vcpu_free   = kvmppc_core_vcpu_free_e500,
+	.mmu_destroy  = kvmppc_mmu_destroy_e500,
+	.init_vm = kvmppc_core_init_vm_e500,
+	.destroy_vm = kvmppc_core_destroy_vm_e500,
+	.emulate_op = kvmppc_core_emulate_op_e500,
+	.emulate_mtspr = kvmppc_core_emulate_mtspr_e500,
+	.emulate_mfspr = kvmppc_core_emulate_mfspr_e500,
+};
+
 static int __init kvmppc_e500_init(void)
 {
 	int r, i;
@@ -512,11 +533,11 @@ static int __init kvmppc_e500_init(void)
 
 	r = kvmppc_core_check_processor_compat();
 	if (r)
-		return r;
+		goto err_out;
 
 	r = kvmppc_booke_init();
 	if (r)
-		return r;
+		goto err_out;
 
 	/* copy extra E500 exception handlers */
 	ivor[0] = mfspr(SPRN_IVOR32);
@@ -534,7 +555,9 @@ static int __init kvmppc_e500_init(void)
 	flush_icache_range(kvmppc_booke_handlers, kvmppc_booke_handlers +
 			   ivor[max_ivor] + handler_len);
 
-	return kvm_init(NULL, sizeof(struct kvmppc_vcpu_e500), 0, THIS_MODULE);
+	r = kvm_init(&kvm_ops_e500, sizeof(struct kvmppc_vcpu_e500), 0, THIS_MODULE);
+err_out:
+	return r;
 }
 
 static void __exit kvmppc_e500_exit(void)
diff --git a/arch/powerpc/kvm/e500_emulate.c b/arch/powerpc/kvm/e500_emulate.c
index 6163a03..89b7f82 100644
--- a/arch/powerpc/kvm/e500_emulate.c
+++ b/arch/powerpc/kvm/e500_emulate.c
@@ -103,8 +103,8 @@ static int kvmppc_e500_emul_ehpriv(struct kvm_run *run, struct kvm_vcpu *vcpu,
 	return emulated;
 }
 
-int kvmppc_core_emulate_op(struct kvm_run *run, struct kvm_vcpu *vcpu,
-                           unsigned int inst, int *advance)
+int kvmppc_core_emulate_op_e500(struct kvm_run *run, struct kvm_vcpu *vcpu,
+				unsigned int inst, int *advance)
 {
 	int emulated = EMULATE_DONE;
 	int ra = get_ra(inst);
@@ -172,7 +172,7 @@ int kvmppc_core_emulate_op(struct kvm_run *run, struct kvm_vcpu *vcpu,
 	return emulated;
 }
 
-int kvmppc_core_emulate_mtspr(struct kvm_vcpu *vcpu, int sprn, ulong spr_val)
+int kvmppc_core_emulate_mtspr_e500(struct kvm_vcpu *vcpu, int sprn, ulong spr_val)
 {
 	struct kvmppc_vcpu_e500 *vcpu_e500 = to_e500(vcpu);
 	int emulated = EMULATE_DONE;
@@ -263,7 +263,7 @@ int kvmppc_core_emulate_mtspr(struct kvm_vcpu *vcpu, int sprn, ulong spr_val)
 	return emulated;
 }
 
-int kvmppc_core_emulate_mfspr(struct kvm_vcpu *vcpu, int sprn, ulong *spr_val)
+int kvmppc_core_emulate_mfspr_e500(struct kvm_vcpu *vcpu, int sprn, ulong *spr_val)
 {
 	struct kvmppc_vcpu_e500 *vcpu_e500 = to_e500(vcpu);
 	int emulated = EMULATE_DONE;
diff --git a/arch/powerpc/kvm/e500_mmu.c b/arch/powerpc/kvm/e500_mmu.c
index 6d6f153..d25bb75 100644
--- a/arch/powerpc/kvm/e500_mmu.c
+++ b/arch/powerpc/kvm/e500_mmu.c
@@ -536,7 +536,7 @@ gpa_t kvmppc_mmu_xlate(struct kvm_vcpu *vcpu, unsigned int index,
 	return get_tlb_raddr(gtlbe) | (eaddr & pgmask);
 }
 
-void kvmppc_mmu_destroy(struct kvm_vcpu *vcpu)
+void kvmppc_mmu_destroy_e500(struct kvm_vcpu *vcpu)
 {
 }
 
diff --git a/arch/powerpc/kvm/e500mc.c b/arch/powerpc/kvm/e500mc.c
index 19c8379..db6a383 100644
--- a/arch/powerpc/kvm/e500mc.c
+++ b/arch/powerpc/kvm/e500mc.c
@@ -110,7 +110,7 @@ void kvmppc_mmu_msr_notify(struct kvm_vcpu *vcpu, u32 old_msr)
 
 static DEFINE_PER_CPU(struct kvm_vcpu *, last_vcpu_on_cpu);
 
-void kvmppc_core_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
+static void kvmppc_core_vcpu_load_e500mc(struct kvm_vcpu *vcpu, int cpu)
 {
 	struct kvmppc_vcpu_e500 *vcpu_e500 = to_e500(vcpu);
 
@@ -147,7 +147,7 @@ void kvmppc_core_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 	kvmppc_load_guest_fp(vcpu);
 }
 
-void kvmppc_core_vcpu_put(struct kvm_vcpu *vcpu)
+static void kvmppc_core_vcpu_put_e500mc(struct kvm_vcpu *vcpu)
 {
 	vcpu->arch.eplc = mfspr(SPRN_EPLC);
 	vcpu->arch.epsc = mfspr(SPRN_EPSC);
@@ -204,7 +204,8 @@ int kvmppc_core_vcpu_setup(struct kvm_vcpu *vcpu)
 	return 0;
 }
 
-void kvmppc_core_get_sregs(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs)
+static int kvmppc_core_get_sregs_e500mc(struct kvm_vcpu *vcpu,
+					struct kvm_sregs *sregs)
 {
 	struct kvmppc_vcpu_e500 *vcpu_e500 = to_e500(vcpu);
 
@@ -224,10 +225,11 @@ void kvmppc_core_get_sregs(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs)
 	sregs->u.e.ivor_high[4] = vcpu->arch.ivor[BOOKE_IRQPRIO_DBELL];
 	sregs->u.e.ivor_high[5] = vcpu->arch.ivor[BOOKE_IRQPRIO_DBELL_CRIT];
 
-	kvmppc_get_sregs_ivor(vcpu, sregs);
+	return kvmppc_get_sregs_ivor(vcpu, sregs);
 }
 
-int kvmppc_core_set_sregs(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs)
+static int kvmppc_core_set_sregs_e500mc(struct kvm_vcpu *vcpu,
+					struct kvm_sregs *sregs)
 {
 	struct kvmppc_vcpu_e500 *vcpu_e500 = to_e500(vcpu);
 	int ret;
@@ -260,21 +262,22 @@ int kvmppc_core_set_sregs(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs)
 	return kvmppc_set_sregs_ivor(vcpu, sregs);
 }
 
-int kvmppc_get_one_reg(struct kvm_vcpu *vcpu, u64 id,
-			union kvmppc_one_reg *val)
+static int kvmppc_get_one_reg_e500mc(struct kvm_vcpu *vcpu, u64 id,
+			      union kvmppc_one_reg *val)
 {
 	int r = kvmppc_get_one_reg_e500_tlb(vcpu, id, val);
 	return r;
 }
 
-int kvmppc_set_one_reg(struct kvm_vcpu *vcpu, u64 id,
-		       union kvmppc_one_reg *val)
+static int kvmppc_set_one_reg_e500mc(struct kvm_vcpu *vcpu, u64 id,
+			      union kvmppc_one_reg *val)
 {
 	int r = kvmppc_set_one_reg_e500_tlb(vcpu, id, val);
 	return r;
 }
 
-struct kvm_vcpu *kvmppc_core_vcpu_create(struct kvm *kvm, unsigned int id)
+static struct kvm_vcpu *kvmppc_core_vcpu_create_e500mc(struct kvm *kvm,
+						       unsigned int id)
 {
 	struct kvmppc_vcpu_e500 *vcpu_e500;
 	struct kvm_vcpu *vcpu;
@@ -315,7 +318,7 @@ out:
 	return ERR_PTR(err);
 }
 
-void kvmppc_core_vcpu_free(struct kvm_vcpu *vcpu)
+static void kvmppc_core_vcpu_free_e500mc(struct kvm_vcpu *vcpu)
 {
 	struct kvmppc_vcpu_e500 *vcpu_e500 = to_e500(vcpu);
 
@@ -325,7 +328,7 @@ void kvmppc_core_vcpu_free(struct kvm_vcpu *vcpu)
 	kmem_cache_free(kvm_vcpu_cache, vcpu_e500);
 }
 
-int kvmppc_core_init_vm(struct kvm *kvm)
+static int kvmppc_core_init_vm_e500mc(struct kvm *kvm)
 {
 	int lpid;
 
@@ -337,23 +340,44 @@ int kvmppc_core_init_vm(struct kvm *kvm)
 	return 0;
 }
 
-void kvmppc_core_destroy_vm(struct kvm *kvm)
+static void kvmppc_core_destroy_vm_e500mc(struct kvm *kvm)
 {
 	kvmppc_free_lpid(kvm->arch.lpid);
 }
 
+static struct kvmppc_ops kvm_ops_e500mc = {
+	.get_sregs = kvmppc_core_get_sregs_e500mc,
+	.set_sregs = kvmppc_core_set_sregs_e500mc,
+	.get_one_reg = kvmppc_get_one_reg_e500mc,
+	.set_one_reg = kvmppc_set_one_reg_e500mc,
+	.vcpu_load   = kvmppc_core_vcpu_load_e500mc,
+	.vcpu_put    = kvmppc_core_vcpu_put_e500mc,
+	.vcpu_create = kvmppc_core_vcpu_create_e500mc,
+	.vcpu_free   = kvmppc_core_vcpu_free_e500mc,
+	.mmu_destroy  = kvmppc_mmu_destroy_e500,
+	.init_vm = kvmppc_core_init_vm_e500mc,
+	.destroy_vm = kvmppc_core_destroy_vm_e500mc,
+	.emulate_op = kvmppc_core_emulate_op_e500,
+	.emulate_mtspr = kvmppc_core_emulate_mtspr_e500,
+	.emulate_mfspr = kvmppc_core_emulate_mfspr_e500,
+};
+
 static int __init kvmppc_e500mc_init(void)
 {
 	int r;
 
 	r = kvmppc_booke_init();
 	if (r)
-		return r;
+		goto err_out;
 
 	kvmppc_init_lpid(64);
 	kvmppc_claim_lpid(0); /* host */
 
-	return kvm_init(NULL, sizeof(struct kvmppc_vcpu_e500), 0, THIS_MODULE);
+	r = kvm_init(&kvm_ops_e500mc, sizeof(struct kvmppc_vcpu_e500), 0, THIS_MODULE);
+	if (r)
+		goto err_out;
+err_out:
+	return r;
 }
 
 static void __exit kvmppc_e500mc_exit(void)
-- 
1.8.1.2
