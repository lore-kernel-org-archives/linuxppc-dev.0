Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by ozlabs.org (Postfix) with ESMTP id 620DFB7158
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 17 Aug 2010 23:58:08 +1000 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 13/26] KVM: PPC: Add feature bitmap for magic page
Date: Tue, 17 Aug 2010 15:57:48 +0200
Message-Id: <1282053481-18787-14-git-send-email-agraf@suse.de>
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

We will soon add SR PV support to the shared page, so we need some
infrastructure that allows the guest to query for features KVM exports.

This patch adds a second return value to the magic mapping that
indicated to the guest which features are available.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/include/asm/kvm_para.h |    2 ++
 arch/powerpc/kernel/kvm.c           |   21 +++++++++++++++------
 arch/powerpc/kvm/powerpc.c          |    5 ++++-
 3 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_para.h b/arch/powerpc/include/asm/kvm_para.h
index 7438ab3..43c1b22 100644
--- a/arch/powerpc/include/asm/kvm_para.h
+++ b/arch/powerpc/include/asm/kvm_para.h
@@ -47,6 +47,8 @@ struct kvm_vcpu_arch_shared {
 
 #define KVM_FEATURE_MAGIC_PAGE	1
 
+#define KVM_MAGIC_FEAT_SR	(1 << 0)
+
 #ifdef __KERNEL__
 
 #ifdef CONFIG_KVM_GUEST
diff --git a/arch/powerpc/kernel/kvm.c b/arch/powerpc/kernel/kvm.c
index e936817..f48144f 100644
--- a/arch/powerpc/kernel/kvm.c
+++ b/arch/powerpc/kernel/kvm.c
@@ -267,12 +267,20 @@ static void kvm_patch_ins_wrteei(u32 *inst)
 
 static void kvm_map_magic_page(void *data)
 {
-	kvm_hypercall2(KVM_HC_PPC_MAP_MAGIC_PAGE,
-		       KVM_MAGIC_PAGE,  /* Physical Address */
-		       KVM_MAGIC_PAGE); /* Effective Address */
+	u32 *features = data;
+
+	ulong in[8];
+	ulong out[8];
+
+	in[0] = KVM_MAGIC_PAGE;
+	in[1] = KVM_MAGIC_PAGE;
+
+	kvm_hypercall(in, out, HC_VENDOR_KVM | KVM_HC_PPC_MAP_MAGIC_PAGE);
+
+	*features = out[0];
 }
 
-static void kvm_check_ins(u32 *inst)
+static void kvm_check_ins(u32 *inst, u32 features)
 {
 	u32 _inst = *inst;
 	u32 inst_no_rt = _inst & ~KVM_MASK_RT;
@@ -368,9 +376,10 @@ static void kvm_use_magic_page(void)
 	u32 *p;
 	u32 *start, *end;
 	u32 tmp;
+	u32 features;
 
 	/* Tell the host to map the magic page to -4096 on all CPUs */
-	on_each_cpu(kvm_map_magic_page, NULL, 1);
+	on_each_cpu(kvm_map_magic_page, &features, 1);
 
 	/* Quick self-test to see if the mapping works */
 	if (__get_user(tmp, (u32*)KVM_MAGIC_PAGE)) {
@@ -383,7 +392,7 @@ static void kvm_use_magic_page(void)
 	end = (void*)_etext;
 
 	for (p = start; p < end; p++)
-		kvm_check_ins(p);
+		kvm_check_ins(p, features);
 
 	printk(KERN_INFO "KVM: Live patching for a fast VM %s\n",
 			 kvm_patching_worked ? "worked" : "failed");
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 6a53a3f..496d7a5 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -66,6 +66,8 @@ int kvmppc_kvm_pv(struct kvm_vcpu *vcpu)
 		vcpu->arch.magic_page_pa = param1;
 		vcpu->arch.magic_page_ea = param2;
 
+		r2 = 0;
+
 		r = HC_EV_SUCCESS;
 		break;
 	}
@@ -76,13 +78,14 @@ int kvmppc_kvm_pv(struct kvm_vcpu *vcpu)
 #endif
 
 		/* Second return value is in r4 */
-		kvmppc_set_gpr(vcpu, 4, r2);
 		break;
 	default:
 		r = HC_EV_UNIMPLEMENTED;
 		break;
 	}
 
+	kvmppc_set_gpr(vcpu, 4, r2);
+
 	return r;
 }
 
-- 
1.6.0.2
