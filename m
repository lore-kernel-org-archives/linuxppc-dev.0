Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp05.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0B76D2C0347
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Sep 2013 20:04:10 +1000 (EST)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 27 Sep 2013 15:34:08 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 4EBF61258055
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Sep 2013 15:34:19 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r8RA6M6v40304712
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Sep 2013 15:36:22 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r8RA44VV020367
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Sep 2013 15:34:04 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: agraf@suse.de, benh@kernel.crashing.org, paulus@samba.org
Subject: [RFC PATCH 11/11] kvm: powerpc: book3s: Fix module ownership
Date: Fri, 27 Sep 2013 15:33:53 +0530
Message-Id: <1380276233-17095-12-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1380276233-17095-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1380276233-17095-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

This moves /dev/kvm ownership to kvm.ko module. Depending on
which KVM mode we select during VM creation we take a reference
count on respective module

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/kvm_ppc.h |  1 +
 arch/powerpc/kvm/book3s.c          | 21 +++++++++++++++++++++
 arch/powerpc/kvm/book3s_hv.c       | 15 ++++++---------
 arch/powerpc/kvm/book3s_pr.c       | 15 +++++----------
 arch/powerpc/kvm/powerpc.c         | 19 +++++++++++++++----
 5 files changed, 48 insertions(+), 23 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
index a4a5893..2022720 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -171,6 +171,7 @@ extern int kvmppc_xics_int_on(struct kvm *kvm, u32 irq);
 extern int kvmppc_xics_int_off(struct kvm *kvm, u32 irq);
 
 struct kvmppc_ops {
+	struct module *owner;
 	bool is_hv_enabled;
 	int (*get_sregs)(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs);
 	int (*set_sregs)(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs);
diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
index 34e189c..363df6a 100644
--- a/arch/powerpc/kvm/book3s.c
+++ b/arch/powerpc/kvm/book3s.c
@@ -831,6 +831,10 @@ int kvm_arch_check_processor_compat(void *opaque)
 {
 	int r,cpu;
 	struct kvmppc_ops *kvm_ops = (struct kvmppc_ops *)opaque;
+
+	if (!kvm_ops)
+		return 0;
+
 	for_each_online_cpu(cpu) {
 		smp_call_function_single(cpu,
 					 kvm_ops->check_processor_compat,
@@ -840,6 +844,7 @@ int kvm_arch_check_processor_compat(void *opaque)
 	}
 	return r;
 }
+EXPORT_SYMBOL_GPL(kvm_arch_check_processor_compat);
 
 EXPORT_SYMBOL_GPL(kvm_get_dirty_log);
 EXPORT_SYMBOL_GPL(kvmppc_core_pending_dec);
@@ -851,3 +856,19 @@ EXPORT_SYMBOL_GPL(kvmppc_core_prepare_to_enter);
 EXPORT_SYMBOL_GPL(kvmppc_core_queue_dec);
 EXPORT_SYMBOL_GPL(kvmppc_free_lpid);
 
+static int kvmppc_book3s_init(void)
+{
+	int r;
+
+	r = kvm_init(NULL, sizeof(struct kvm_vcpu), 0, THIS_MODULE);
+	return r;
+}
+
+static void kvmppc_book3s_exit(void)
+{
+	kvm_exit();
+}
+
+module_init(kvmppc_book3s_init);
+module_exit(kvmppc_book3s_exit);
+
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 0a684a7..7bdc780 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -2092,23 +2092,20 @@ static int kvmppc_book3s_init_hv(void)
 {
 	int r;
 
-	if (!kvmppc_pr_ops) {
-		r = kvm_init(&kvm_ops_hv, sizeof(struct kvm_vcpu),
-			     0, THIS_MODULE);
-		if (r)
-			return r;
-	}
+	r = kvm_arch_check_processor_compat(&kvm_ops_hv);
+	if (r < 0)
+		return r;
+
+	kvm_ops_hv.owner = THIS_MODULE;
 	kvmppc_hv_ops = &kvm_ops_hv;
-	r = kvmppc_mmu_hv_init();
 
+	r = kvmppc_mmu_hv_init();
 	return r;
 }
 
 static void kvmppc_book3s_exit_hv(void)
 {
 	kvmppc_hv_ops = NULL;
-	if (!kvmppc_pr_ops)
-		kvm_exit();
 }
 
 module_init(kvmppc_book3s_init_hv);
diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
index e49e4b0..c79fada 100644
--- a/arch/powerpc/kvm/book3s_pr.c
+++ b/arch/powerpc/kvm/book3s_pr.c
@@ -1551,17 +1551,14 @@ static int kvmppc_book3s_init_pr(void)
 {
 	int r;
 
-	if (!kvmppc_hv_ops) {
-		r = kvm_init(&kvm_ops_pr, sizeof(struct kvm_vcpu),
-			     0, THIS_MODULE);
-		if (r)
-			return r;
-	}
-	/* Assign the global value */
+	r = kvm_arch_check_processor_compat(&kvm_ops_pr);
+	if (r < 0)
+		return r;
+
+	kvm_ops_pr.owner = THIS_MODULE;
 	kvmppc_pr_ops = &kvm_ops_pr;
 
 	r = kvmppc_mmu_hpte_sysinit();
-
 	return r;
 }
 
@@ -1569,8 +1566,6 @@ static void kvmppc_book3s_exit_pr(void)
 {
 	kvmppc_pr_ops = NULL;
 	kvmppc_mmu_hpte_sysexit();
-	if (!kvmppc_hv_ops)
-		kvm_exit();
 }
 
 module_init(kvmppc_book3s_init_pr);
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 1209229..677fa7e 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -26,6 +26,7 @@
 #include <linux/fs.h>
 #include <linux/slab.h>
 #include <linux/file.h>
+#include <linux/module.h>
 #include <asm/cputable.h>
 #include <asm/uaccess.h>
 #include <asm/kvm_ppc.h>
@@ -270,25 +271,32 @@ void kvm_arch_hardware_unsetup(void)
 
 int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 {
+	struct kvmppc_ops *kvm_ops = NULL;
 	/*
 	 * if we have both HV and PR enabled, default is HV
 	 */
 	if (type == 0) {
 		if (kvmppc_hv_ops)
-			kvm->arch.kvm_ops = kvmppc_hv_ops;
+			kvm_ops = kvmppc_hv_ops;
 		else
-			kvm->arch.kvm_ops = kvmppc_pr_ops;
+			kvm_ops = kvmppc_pr_ops;
+		if (!kvm_ops)
+			goto err_out;
 	} else	if (type == KVM_VM_PPC_HV) {
 		if (!kvmppc_hv_ops)
 			goto err_out;
-		kvm->arch.kvm_ops = kvmppc_hv_ops;
+		kvm_ops = kvmppc_hv_ops;
 	} else if (type == KVM_VM_PPC_PR) {
 		if (!kvmppc_pr_ops)
 			goto err_out;
-		kvm->arch.kvm_ops = kvmppc_pr_ops;
+		kvm_ops = kvmppc_pr_ops;
 	} else
 		goto err_out;
 
+	if (kvm_ops->owner && !try_module_get(kvm_ops->owner))
+		return -ENOENT;
+
+	kvm->arch.kvm_ops = kvm_ops;
 	return kvmppc_core_init_vm(kvm);
 err_out:
 	return -EINVAL;
@@ -311,6 +319,9 @@ void kvm_arch_destroy_vm(struct kvm *kvm)
 	kvmppc_core_destroy_vm(kvm);
 
 	mutex_unlock(&kvm->lock);
+
+	/* drop the module reference */
+	module_put(kvm->arch.kvm_ops->owner);
 }
 
 void kvm_arch_sync_events(struct kvm *kvm)
-- 
1.8.1.2
