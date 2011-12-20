Return-Path: <paulus@ozlabs.org>
Date: Tue, 20 Dec 2011 21:37:24 +1100
From: Paul Mackerras <paulus@samba.org>
To: Alexander Graf <agraf@suse.de>
Subject: [KVM PATCH 2/2] KVM: PPC: Book3S HV: Report stolen time to guest
 through dispatch trace log
Message-ID: <20111220103723.GD5626@bloggs.ozlabs.ibm.com>
References: <20111220102142.GB5626@bloggs.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20111220102142.GB5626@bloggs.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This adds code to measure "stolen" time per virtual core in units of
timebase ticks, and to report the stolen time to the guest using the
dispatch trace log (DTL).  The guest can register an area of memory
for the DTL for a given vcpu.  The DTL is a ring buffer where KVM
fills in one entry every time it enters the guest for that vcpu.

Stolen time is measured as time when the virtual core is not running,
either because the vcore is not runnable (e.g. some of its vcpus are
executing elsewhere in the kernel or in userspace), or when the vcpu
thread that is running the vcore is preempted.  This includes time
when all the vcpus are idle (i.e. have executed the H_CEDE hypercall),
which is OK because the guest accounts stolen time while idle as idle
time.

Each vcpu keeps a record of how much stolen time has been reported to
the guest for that vcpu so far.  When we are about to enter the guest,
we create a new DTL entry (if the guest vcpu has a DTL) and report the
difference between total stolen time for the vcore and stolen time
reported so far for the vcpu as the "enqueue to dispatch" time in the
DTL entry.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/include/asm/kvm_host.h |    4 +++
 arch/powerpc/kvm/book3s_hv.c        |   43 ++++++++++++++++++++++++++++++++++-
 2 files changed, 46 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index b1126c1..3c5ec79 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -258,6 +258,9 @@ struct kvmppc_vcore {
 	struct list_head runnable_threads;
 	spinlock_t lock;
 	wait_queue_head_t wq;
+	u64 stolen_tb;
+	u64 preempt_tb;
+	struct kvm_vcpu *runner;
 };
 
 #define VCORE_ENTRY_COUNT(vc)	((vc)->entry_exit_count & 0xff)
@@ -461,6 +464,7 @@ struct kvm_vcpu_arch {
 	u8 slb_shadow_pending;
 	u8 dtl_pending;
 	spinlock_t vpa_update_lock;
+	u64 stolen_logged;
 
 	wait_queue_head_t *wqp;
 	struct kvmppc_vcore *vcore;
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 6f6e88d..b835df7 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -60,12 +60,20 @@ static int kvmppc_hv_setup_rma(struct kvm_vcpu *vcpu);
 
 void kvmppc_core_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 {
+	struct kvmppc_vcore *vc = vcpu->arch.vcore;
+
 	local_paca->kvm_hstate.kvm_vcpu = vcpu;
-	local_paca->kvm_hstate.kvm_vcore = vcpu->arch.vcore;
+	local_paca->kvm_hstate.kvm_vcore = vc;
+	if (vc->runner == vcpu && vc->vcore_state != VCORE_INACTIVE)
+		vc->stolen_tb += mftb() - vc->preempt_tb;
 }
 
 void kvmppc_core_vcpu_put(struct kvm_vcpu *vcpu)
 {
+	struct kvmppc_vcore *vc = vcpu->arch.vcore;
+
+	if (vc->runner == vcpu && vc->vcore_state != VCORE_INACTIVE)
+		vc->preempt_tb = mftb();
 }
 
 void kvmppc_set_msr(struct kvm_vcpu *vcpu, u64 msr)
@@ -283,6 +291,31 @@ static void kvmppc_update_vpas(struct kvm_vcpu *vcpu)
 	spin_unlock(&vcpu->arch.vpa_update_lock);
 }
 
+static void kvmppc_create_dtl_entry(struct kvm_vcpu *vcpu,
+				    struct kvmppc_vcore *vc)
+{
+	struct dtl_entry *dt;
+	struct lppaca *vpa;
+
+	dt = vcpu->arch.dtl_ptr;
+	vpa = vcpu->arch.vpa;
+	if (!dt || !vpa)
+		return;
+	memset(dt, 0, sizeof(struct dtl_entry));
+	dt->dispatch_reason = 7;
+	dt->processor_id = vc->pcpu + vcpu->arch.ptid;
+	dt->timebase = mftb();
+	dt->enqueue_to_dispatch_time = vc->stolen_tb - vcpu->arch.stolen_logged;
+	dt->srr0 = kvmppc_get_pc(vcpu);
+	dt->srr1 = vcpu->arch.shregs.msr;
+	vcpu->arch.stolen_logged = vc->stolen_tb;
+	++dt;
+	if (dt == vcpu->arch.dtl_end)
+		dt = vcpu->arch.dtl;
+	vcpu->arch.dtl_ptr = dt;
+	++vpa->dtl_idx;
+}
+
 int kvmppc_pseries_do_hcall(struct kvm_vcpu *vcpu)
 {
 	unsigned long req = kvmppc_get_gpr(vcpu, 3);
@@ -542,6 +575,7 @@ struct kvm_vcpu *kvmppc_core_vcpu_create(struct kvm *kvm, unsigned int id)
 			INIT_LIST_HEAD(&vcore->runnable_threads);
 			spin_lock_init(&vcore->lock);
 			init_waitqueue_head(&vcore->wq);
+			vcore->preempt_tb = mftb();
 		}
 		kvm->arch.vcores[core] = vcore;
 	}
@@ -554,6 +588,7 @@ struct kvm_vcpu *kvmppc_core_vcpu_create(struct kvm *kvm, unsigned int id)
 	++vcore->num_threads;
 	spin_unlock(&vcore->lock);
 	vcpu->arch.vcore = vcore;
+	vcpu->arch.stolen_logged = vcore->stolen_tb;
 
 	vcpu->arch.cpu_type = KVM_CPU_3S_64;
 	kvmppc_sanity_check(vcpu);
@@ -745,6 +780,7 @@ static int kvmppc_run_core(struct kvmppc_vcore *vc)
 	vc->nap_count = 0;
 	vc->entry_exit_count = 0;
 	vc->vcore_state = VCORE_RUNNING;
+	vc->stolen_tb += mftb() - vc->preempt_tb;
 	vc->in_guest = 0;
 	vc->pcpu = smp_processor_id();
 	vc->napping_threads = 0;
@@ -753,6 +789,8 @@ static int kvmppc_run_core(struct kvmppc_vcore *vc)
 		if (vcpu->arch.vpa_pending || vcpu->arch.slb_shadow_pending ||
 		    vcpu->arch.dtl_pending)
 			kvmppc_update_vpas(vcpu);
+		if (vcpu->arch.dtl_ptr)
+			kvmppc_create_dtl_entry(vcpu, vc);
 	}
 
 	preempt_disable();
@@ -805,6 +843,7 @@ static int kvmppc_run_core(struct kvmppc_vcore *vc)
 	spin_lock(&vc->lock);
  out:
 	vc->vcore_state = VCORE_INACTIVE;
+	vc->preempt_tb = mftb();
 	list_for_each_entry_safe(vcpu, vnext, &vc->runnable_threads,
 				 arch.run_list) {
 		if (vcpu->arch.ret != RESUME_GUEST) {
@@ -903,6 +942,7 @@ static int kvmppc_run_vcpu(struct kvm_run *kvm_run, struct kvm_vcpu *vcpu)
 			spin_lock(&vc->lock);
 			continue;
 		}
+		vc->runner = vcpu;
 		n_ceded = 0;
 		list_for_each_entry(v, &vc->runnable_threads, arch.run_list)
 			n_ceded += v->arch.ceded;
@@ -922,6 +962,7 @@ static int kvmppc_run_vcpu(struct kvm_run *kvm_run, struct kvm_vcpu *vcpu)
 				wake_up(&v->arch.cpu_run);
 			}
 		}
+		vc->runner = NULL;
 	}
 
 	if (signal_pending(current)) {
-- 
1.7.7.3
