Return-Path: <sam.bobroff@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40MBfz0fnmzDqnn
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Apr 2018 17:02:18 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w3C71K1u107399
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Apr 2018 03:02:16 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ha2f80kxw-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Apr 2018 03:02:15 -0400
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sam.bobroff@au1.ibm.com>;
 Thu, 12 Apr 2018 08:02:13 +0100
Date: Thu, 12 Apr 2018 17:02:06 +1000
From: Sam Bobroff <sam.bobroff@au1.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: kvm@vger.kernel.org, kvm-ppc@vger.kernel.org, paulus@samba.org,
 david@gibson.dropbear.id.au, clg@kaod.org
Subject: [PATCH RFC 1/1] KVM: PPC: Book3S HV: pack VCORE IDs to access full
 VCPU ID space
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <70974cfb62a7f09a53ec914d2909639884228244.1523516498.git.sam.bobroff@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

It is not currently possible to create the full number of possible
VCPUs (KVM_MAX_VCPUS) on Power9 with KVM-HV when the guest uses less
threads per core than it's core stride (or "VSMT mode"). This is
because the VCORE ID and XIVE offsets to grow beyond KVM_MAX_VCPUS
even though the VCPU ID is less than KVM_MAX_VCPU_ID.

To address this, "pack" the VCORE ID and XIVE offsets by using
knowledge of the way the VCPU IDs will be used when there are less
guest threads per core than the core stride. The primary thread of
each core will always be used first. Then, if the guest uses more than
one thread per core, these secondary threads will sequentially follow
the primary in each core.

So, the only way an ID above KVM_MAX_VCPUS can be seen, is if the
VCPUs are being spaced apart, so at least half of each core is empty
and IDs between KVM_MAX_VCPUS and (KVM_MAX_VCPUS * 2) can be mapped
into the second half of each core (4..7, in an 8-thread core).

Similarly, if IDs above KVM_MAX_VCPUS * 2 are seen, at least 3/4 of
each core is being left empty, and we can map down into the second and
third quarters of each core (2, 3 and 5, 6 in an 8-thread core).

Lastly, if IDs above KVM_MAX_VCPUS * 4 are seen, only the primary
threads are being used and 7/8 of the core is empty, allowing use of
the 1, 3, 5 and 7 thread slots.

(Strides less than 8 are handled similarly.)

This allows the VCORE ID or offset to be calculated quickly from the
VCPU ID or XIVE server numbers, without access to the VCPU structure.

Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
---
Hello everyone,

I've tested this on P8 and P9, in lots of combinations of host and guest
threading modes and it has been fine but it does feel like a "tricky"
approach, so I still feel somewhat wary about it.

I've posted it as an RFC because I have not tested it with guest native-XIVE,
and I suspect that it will take some work to support it.

 arch/powerpc/include/asm/kvm_book3s.h | 19 +++++++++++++++++++
 arch/powerpc/kvm/book3s_hv.c          | 14 ++++++++++----
 arch/powerpc/kvm/book3s_xive.c        |  9 +++++++--
 3 files changed, 36 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_book3s.h b/arch/powerpc/include/asm/kvm_book3s.h
index 376ae803b69c..1295056d564a 100644
--- a/arch/powerpc/include/asm/kvm_book3s.h
+++ b/arch/powerpc/include/asm/kvm_book3s.h
@@ -368,4 +368,23 @@ extern int kvmppc_h_logical_ci_store(struct kvm_vcpu *vcpu);
 #define SPLIT_HACK_MASK			0xff000000
 #define SPLIT_HACK_OFFS			0xfb000000
 
+/* Pack a VCPU ID from the [0..KVM_MAX_VCPU_ID) space down to the
+ * [0..KVM_MAX_VCPUS) space, while using knowledge of the guest's core stride
+ * (but not it's actual threading mode, which is not available) to avoid
+ * collisions.
+ */
+static inline u32 kvmppc_pack_vcpu_id(struct kvm *kvm, u32 id)
+{
+	const int block_offsets[MAX_SMT_THREADS] = {0, 4, 2, 6, 1, 5, 3, 7};
+	int stride = kvm->arch.emul_smt_mode > 1 ?
+		     kvm->arch.emul_smt_mode : kvm->arch.smt_mode;
+	int block = (id / KVM_MAX_VCPUS) * (MAX_SMT_THREADS / stride);
+	u32 packed_id;
+
+	BUG_ON(block >= MAX_SMT_THREADS);
+	packed_id = (id % KVM_MAX_VCPUS) + block_offsets[block];
+	BUG_ON(packed_id >= KVM_MAX_VCPUS);
+	return packed_id;
+}
+
 #endif /* __ASM_KVM_BOOK3S_H__ */
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 9cb9448163c4..49165cc90051 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -1762,7 +1762,7 @@ static int threads_per_vcore(struct kvm *kvm)
 	return threads_per_subcore;
 }
 
-static struct kvmppc_vcore *kvmppc_vcore_create(struct kvm *kvm, int core)
+static struct kvmppc_vcore *kvmppc_vcore_create(struct kvm *kvm, int id)
 {
 	struct kvmppc_vcore *vcore;
 
@@ -1776,7 +1776,7 @@ static struct kvmppc_vcore *kvmppc_vcore_create(struct kvm *kvm, int core)
 	init_swait_queue_head(&vcore->wq);
 	vcore->preempt_tb = TB_NIL;
 	vcore->lpcr = kvm->arch.lpcr;
-	vcore->first_vcpuid = core * kvm->arch.smt_mode;
+	vcore->first_vcpuid = id;
 	vcore->kvm = kvm;
 	INIT_LIST_HEAD(&vcore->preempt_list);
 
@@ -1992,12 +1992,18 @@ static struct kvm_vcpu *kvmppc_core_vcpu_create_hv(struct kvm *kvm,
 	mutex_lock(&kvm->lock);
 	vcore = NULL;
 	err = -EINVAL;
-	core = id / kvm->arch.smt_mode;
+	if (cpu_has_feature(CPU_FTR_ARCH_300)) {
+		BUG_ON(kvm->arch.smt_mode != 1);
+		core = kvmppc_pack_vcpu_id(kvm, id);
+	} else {
+		core = id / kvm->arch.smt_mode;
+	}
 	if (core < KVM_MAX_VCORES) {
 		vcore = kvm->arch.vcores[core];
+		BUG_ON(cpu_has_feature(CPU_FTR_ARCH_300) && vcore);
 		if (!vcore) {
 			err = -ENOMEM;
-			vcore = kvmppc_vcore_create(kvm, core);
+			vcore = kvmppc_vcore_create(kvm, id & ~(kvm->arch.smt_mode - 1));
 			kvm->arch.vcores[core] = vcore;
 			kvm->arch.online_vcores++;
 		}
diff --git a/arch/powerpc/kvm/book3s_xive.c b/arch/powerpc/kvm/book3s_xive.c
index f9818d7d3381..681dfe12a5f3 100644
--- a/arch/powerpc/kvm/book3s_xive.c
+++ b/arch/powerpc/kvm/book3s_xive.c
@@ -317,6 +317,11 @@ static int xive_select_target(struct kvm *kvm, u32 *server, u8 prio)
 	return -EBUSY;
 }
 
+static u32 xive_vp(struct kvmppc_xive *xive, u32 server)
+{
+	return xive->vp_base + kvmppc_pack_vcpu_id(xive->kvm, server);
+}
+
 static u8 xive_lock_and_mask(struct kvmppc_xive *xive,
 			     struct kvmppc_xive_src_block *sb,
 			     struct kvmppc_xive_irq_state *state)
@@ -1084,7 +1089,7 @@ int kvmppc_xive_connect_vcpu(struct kvm_device *dev,
 		pr_devel("Duplicate !\n");
 		return -EEXIST;
 	}
-	if (cpu >= KVM_MAX_VCPUS) {
+	if (cpu >= KVM_MAX_VCPU_ID) {
 		pr_devel("Out of bounds !\n");
 		return -EINVAL;
 	}
@@ -1098,7 +1103,7 @@ int kvmppc_xive_connect_vcpu(struct kvm_device *dev,
 	xc->xive = xive;
 	xc->vcpu = vcpu;
 	xc->server_num = cpu;
-	xc->vp_id = xive->vp_base + cpu;
+	xc->vp_id = xive_vp(xive, cpu);
 	xc->mfrr = 0xff;
 	xc->valid = true;
 
-- 
2.16.1.74.g9b0b1f47b
