Return-Path: <sbobroff@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41b4d9178XzDqnG
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jul 2018 16:12:12 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w6P6AGSW011900
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jul 2018 02:12:09 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2kejvq1305-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jul 2018 02:12:09 -0400
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sbobroff@linux.ibm.com>;
 Wed, 25 Jul 2018 07:12:07 +0100
From: Sam Bobroff <sbobroff@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: kvm@vger.kernel.org, kvm-ppc@vger.kernel.org, paulus@samba.org,
 david@gibson.dropbear.id.au, clg@kaod.org
Subject: [PATCH v4 1/1] KVM: PPC: Book3S HV: pack VCORE IDs to access full
 VCPU ID space
Date: Wed, 25 Jul 2018 16:12:02 +1000
Message-Id: <dc8e985d05d7de08cce080dfe6e70beeed2a50a1.1532499120.git.sbobroff@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Sam Bobroff <sam.bobroff@au1.ibm.com>

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
the 1, 5, 3 and 7 thread slots.

(Strides less than 8 are handled similarly.)

This allows the VCORE ID or offset to be calculated quickly from the
VCPU ID or XIVE server numbers, without access to the VCPU structure.

Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
---
Hello everyone,

Here's v4, addressing comments from Paul. See below for the changes.

Cheers,
Sam.

Patch set v4:
Patch 1/1: KVM: PPC: Book3S HV: pack VCORE IDs to access full VCPU ID space
* The block offsets are corrected for the vsmt=4 case (swap 3 and 5).
* The initial checks on the VCPU ID are changed to be against (KVM_MAX_VCPUS *
  emul_smt_mode) (a tigher bound).
* The BUG_ON()s in kvmppc_pack_vcpu_id() are changed to a WARN_ONCE(), and
  they'll return 0 in that case. KVM_MAX_VCPUS is another possible return value
  in this case, but it seemed safer to use 0 as it's not likely to cause a
  memory overrun if it's used. The warning shouldn't ever be triggered when
  VCPU IDs are allocate using the scheme that QEMU uses.
* The vcore creation code is adjusted to handle collisions by returning -EINVAL
  instead of bugging out.

Patch set v3:
Patch 1/1: KVM: PPC: Book3S HV: pack VCORE IDs to access full VCPU ID space

Patch set v2:
Patch 1/1: KVM: PPC: Book3S HV: pack VCORE IDs to access full VCPU ID space
* Corrected places in kvm/book3s_xive.c where IDs weren't packed.
* Because kvmppc_pack_vcpu_id() is only called on P9, there is no need to test "emul_smt_mode > 1", so remove it.
* Re-ordered block_offsets[] to be more ascending.
* Added more detailed description of the packing algorithm.

Patch set v1:
Patch 1/1: KVM: PPC: Book3S HV: pack VCORE IDs to access full VCPU ID space

 arch/powerpc/include/asm/kvm_book3s.h | 46 +++++++++++++++++++++++++++++++++++
 arch/powerpc/kvm/book3s_hv.c          | 25 ++++++++++++++-----
 arch/powerpc/kvm/book3s_xive.c        | 19 +++++++++------
 3 files changed, 77 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_book3s.h b/arch/powerpc/include/asm/kvm_book3s.h
index 1f345a0b6ba2..dc5f35c6a6eb 100644
--- a/arch/powerpc/include/asm/kvm_book3s.h
+++ b/arch/powerpc/include/asm/kvm_book3s.h
@@ -390,4 +390,50 @@ extern int kvmppc_h_logical_ci_store(struct kvm_vcpu *vcpu);
 #define SPLIT_HACK_MASK			0xff000000
 #define SPLIT_HACK_OFFS			0xfb000000
 
+/* Pack a VCPU ID from the [0..KVM_MAX_VCPU_ID) space down to the
+ * [0..KVM_MAX_VCPUS) space, while using knowledge of the guest's core stride
+ * (but not it's actual threading mode, which is not available) to avoid
+ * collisions.
+ *
+ * The implementation leaves VCPU IDs from the range [0..KVM_MAX_VCPUS) (block
+ * 0) unchanged: if the guest is filling each VCORE completely then it will be
+ * using consecutive IDs and it will fill the space without any packing.
+ *
+ * For higher VCPU IDs, the packed ID is based on the VCPU ID modulo
+ * KVM_MAX_VCPUS (effectively masking off the top bits) and then an offset is
+ * added to avoid collisions.
+ *
+ * VCPU IDs in the range [KVM_MAX_VCPUS..(KVM_MAX_VCPUS*2)) (block 1) are only
+ * possible if the guest is leaving at least 1/2 of each VCORE empty, so IDs
+ * can be safely packed into the second half of each VCORE by adding an offset
+ * of (stride / 2).
+ *
+ * Similarly, if VCPU IDs in the range [(KVM_MAX_VCPUS*2)..(KVM_MAX_VCPUS*4))
+ * (blocks 2 and 3) are seen, the guest must be leaving at least 3/4 of each
+ * VCORE empty so packed IDs can be offset by (stride / 4) and (stride * 3 / 4).
+ *
+ * Finally, VCPU IDs from blocks 5..7 will only be seen if the guest is using a
+ * stride of 8 and 1 thread per core so the remaining offsets of 1, 5, 3 and 7
+ * must be free to use.
+ *
+ * (The offsets for each block are stored in block_offsets[], indexed by the
+ * block number if the stride is 8. For cases where the guest's stride is less
+ * than 8, we can re-use the block_offsets array by multiplying the block
+ * number by (MAX_SMT_THREADS / stride) to reach the correct entry.)
+ */
+static inline u32 kvmppc_pack_vcpu_id(struct kvm *kvm, u32 id)
+{
+	const int block_offsets[MAX_SMT_THREADS] = {0, 4, 2, 6, 1, 5, 3, 7};
+	int stride = kvm->arch.emul_smt_mode;
+	int block = (id / KVM_MAX_VCPUS) * (MAX_SMT_THREADS / stride);
+	u32 packed_id;
+
+	if (WARN_ONCE(block >= MAX_SMT_THREADS, "VCPU ID too large to pack"))
+		return 0;
+	packed_id = (id % KVM_MAX_VCPUS) + block_offsets[block];
+	if (WARN_ONCE(packed_id >= KVM_MAX_VCPUS, "VCPU ID packing failed"))
+		return 0;
+	return packed_id;
+}
+
 #endif /* __ASM_KVM_BOOK3S_H__ */
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index de686b340f4a..4cfd3a137dfe 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -1816,7 +1816,7 @@ static int threads_per_vcore(struct kvm *kvm)
 	return threads_per_subcore;
 }
 
-static struct kvmppc_vcore *kvmppc_vcore_create(struct kvm *kvm, int core)
+static struct kvmppc_vcore *kvmppc_vcore_create(struct kvm *kvm, int id)
 {
 	struct kvmppc_vcore *vcore;
 
@@ -1830,7 +1830,7 @@ static struct kvmppc_vcore *kvmppc_vcore_create(struct kvm *kvm, int core)
 	init_swait_queue_head(&vcore->wq);
 	vcore->preempt_tb = TB_NIL;
 	vcore->lpcr = kvm->arch.lpcr;
-	vcore->first_vcpuid = core * kvm->arch.smt_mode;
+	vcore->first_vcpuid = id;
 	vcore->kvm = kvm;
 	INIT_LIST_HEAD(&vcore->preempt_list);
 
@@ -1989,10 +1989,15 @@ static struct kvm_vcpu *kvmppc_core_vcpu_create_hv(struct kvm *kvm,
 						   unsigned int id)
 {
 	struct kvm_vcpu *vcpu;
-	int err;
+	int err = -EINVAL;
 	int core;
 	struct kvmppc_vcore *vcore;
 
+	if (id >= (KVM_MAX_VCPUS * kvm->arch.emul_smt_mode)) {
+		WARN_ONCE(true, "DNCI: VCPU ID too high\n");
+		goto out;
+	}
+
 	err = -ENOMEM;
 	vcpu = kmem_cache_zalloc(kvm_vcpu_cache, GFP_KERNEL);
 	if (!vcpu)
@@ -2048,12 +2053,20 @@ static struct kvm_vcpu *kvmppc_core_vcpu_create_hv(struct kvm *kvm,
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
-		if (!vcore) {
+		if (WARN_ONCE(vcore && cpu_has_feature(CPU_FTR_ARCH_300),
+			      "collision on id %u", core)) {
+			vcore = NULL;
+		} else if (!vcore) {
 			err = -ENOMEM;
-			vcore = kvmppc_vcore_create(kvm, core);
+			vcore = kvmppc_vcore_create(kvm, id & ~(kvm->arch.smt_mode - 1));
 			kvm->arch.vcores[core] = vcore;
 			kvm->arch.online_vcores++;
 		}
diff --git a/arch/powerpc/kvm/book3s_xive.c b/arch/powerpc/kvm/book3s_xive.c
index f9818d7d3381..126f02b3ffb8 100644
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
@@ -362,7 +367,7 @@ static u8 xive_lock_and_mask(struct kvmppc_xive *xive,
 	 */
 	if (xd->flags & OPAL_XIVE_IRQ_MASK_VIA_FW) {
 		xive_native_configure_irq(hw_num,
-					  xive->vp_base + state->act_server,
+					  xive_vp(xive, state->act_server),
 					  MASKED, state->number);
 		/* set old_p so we can track if an H_EOI was done */
 		state->old_p = true;
@@ -418,7 +423,7 @@ static void xive_finish_unmask(struct kvmppc_xive *xive,
 	 */
 	if (xd->flags & OPAL_XIVE_IRQ_MASK_VIA_FW) {
 		xive_native_configure_irq(hw_num,
-					  xive->vp_base + state->act_server,
+					  xive_vp(xive, state->act_server),
 					  state->act_priority, state->number);
 		/* If an EOI is needed, do it here */
 		if (!state->old_p)
@@ -495,7 +500,7 @@ static int xive_target_interrupt(struct kvm *kvm,
 	kvmppc_xive_select_irq(state, &hw_num, NULL);
 
 	return xive_native_configure_irq(hw_num,
-					 xive->vp_base + server,
+					 xive_vp(xive, server),
 					 prio, state->number);
 }
 
@@ -883,7 +888,7 @@ int kvmppc_xive_set_mapped(struct kvm *kvm, unsigned long guest_irq,
 	 * which is fine for a never started interrupt.
 	 */
 	xive_native_configure_irq(hw_irq,
-				  xive->vp_base + state->act_server,
+				  xive_vp(xive, state->act_server),
 				  state->act_priority, state->number);
 
 	/*
@@ -959,7 +964,7 @@ int kvmppc_xive_clr_mapped(struct kvm *kvm, unsigned long guest_irq,
 
 	/* Reconfigure the IPI */
 	xive_native_configure_irq(state->ipi_number,
-				  xive->vp_base + state->act_server,
+				  xive_vp(xive, state->act_server),
 				  state->act_priority, state->number);
 
 	/*
@@ -1084,7 +1089,7 @@ int kvmppc_xive_connect_vcpu(struct kvm_device *dev,
 		pr_devel("Duplicate !\n");
 		return -EEXIST;
 	}
-	if (cpu >= KVM_MAX_VCPUS) {
+	if (cpu >= (KVM_MAX_VCPUS * vcpu->kvm->arch.emul_smt_mode)) {
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
