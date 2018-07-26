Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41bgz10Q4VzDqnG
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jul 2018 15:44:45 +1000 (AEST)
Date: Thu, 26 Jul 2018 15:44:34 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: kvm@vger.kernel.org, kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: Sam Bobroff <sbobroff@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH 2/2] KVM: PPC: Book3S HV: Read kvm->arch.emul_smt_mode under
 kvm->lock
Message-ID: <20180726054434.GC1672@fergus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit 1e175d2 ("KVM: PPC: Book3S HV: Pack VCORE IDs to access full
VCPU ID space", 2018-07-25) added code that uses kvm->arch.emul_smt_mode
before any VCPUs are created.  However, userspace can change
kvm->arch.emul_smt_mode at any time up until the first VCPU is created.
Hence it is (theoretically) possible for the check in
kvmppc_core_vcpu_create_hv() to race with another userspace thread
changing kvm->arch.emul_smt_mode.

This fixes it by moving the test that uses kvm->arch.emul_smt_mode into
the block where kvm->lock is held.

Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/kvm/book3s_hv.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 785245e..113f815 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -1989,16 +1989,10 @@ static struct kvm_vcpu *kvmppc_core_vcpu_create_hv(struct kvm *kvm,
 						   unsigned int id)
 {
 	struct kvm_vcpu *vcpu;
-	int err = -EINVAL;
+	int err;
 	int core;
 	struct kvmppc_vcore *vcore;
 
-	if (id >= (KVM_MAX_VCPUS * kvm->arch.emul_smt_mode) &&
-	    cpu_has_feature(CPU_FTR_ARCH_300)) {
-		pr_devel("DNCI: VCPU ID too high\n");
-		goto out;
-	}
-
 	err = -ENOMEM;
 	vcpu = kmem_cache_zalloc(kvm_vcpu_cache, GFP_KERNEL);
 	if (!vcpu)
@@ -2055,8 +2049,13 @@ static struct kvm_vcpu *kvmppc_core_vcpu_create_hv(struct kvm *kvm,
 	vcore = NULL;
 	err = -EINVAL;
 	if (cpu_has_feature(CPU_FTR_ARCH_300)) {
-		BUG_ON(kvm->arch.smt_mode != 1);
-		core = kvmppc_pack_vcpu_id(kvm, id);
+		if (id >= (KVM_MAX_VCPUS * kvm->arch.emul_smt_mode)) {
+			pr_devel("KVM: VCPU ID too high\n");
+			core = KVM_MAX_VCORES;
+		} else {
+			BUG_ON(kvm->arch.smt_mode != 1);
+			core = kvmppc_pack_vcpu_id(kvm, id);
+		}
 	} else {
 		core = id / kvm->arch.smt_mode;
 	}
-- 
2.7.4
