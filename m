Return-Path: <sjitindarsingh@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rV1H14hb7zDqjQ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jun 2016 19:21:33 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id c74so1394351pfb.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jun 2016 02:21:33 -0700 (PDT)
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: kvm-ppc@vger.kernel.org, mpe@ellerman.id.au, paulus@samba.org,
 benh@kernel.crashing.org, kvm@vger.kernel.org, pbonzini@redhat.com,
 agraf@suse.com, rkrcmar@redhat.com,
 Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Subject: [PATCH 2/4] kvm/ppc/book3s_hv: Implement halt polling in the kvm_hv
 kernel module
Date: Wed, 15 Jun 2016 19:21:06 +1000
Message-Id: <1465982468-18833-2-git-send-email-sjitindarsingh@gmail.com>
In-Reply-To: <1465982468-18833-1-git-send-email-sjitindarsingh@gmail.com>
References: <1465982468-18833-1-git-send-email-sjitindarsingh@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch introduces new halt polling functionality into the kvm_hv kernel
module. When a vcore is idle it will poll for some period of time before
scheduling itself out.

When all of the runnable vcpus on a vcore have ceded (and thus the vcore is
idle) we schedule ourselves out to allow something else to run. In the
event that we need to wake up very quickly (for example an interrupt
arrives), we are required to wait until we get scheduled again.

Implement halt polling so that when a vcore is idle, and before scheduling
ourselves, we poll for vcpus in the runnable_threads list which have
pending exceptions or which leave the ceded state. If we poll successfully
then we can get back into the guest very quickly without ever scheduling
ourselves, otherwise we schedule ourselves out as before.

Testing of this patch with a TCP round robin test between two guests with
virtio network interfaces has found a decrease in round trip time from
~140us to ~115us. A performance gain is only seen when going out of and
back into the guest often and quickly, otherwise there is no net benefit
from the polling. The polling interval is adjusted such that when we are
often scheduled out for long periods of time it is reduced, and when we
often poll successfully it is increased. The rate at which the polling
interval increases or decreases, and the maximum polling interval, can
be set through module parameters.

Based on the implementation in the generic kvm module by Wanpeng Li and
Paolo Bonzini, and on direction from Paul Mackerras.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 arch/powerpc/include/asm/kvm_host.h |   2 +
 arch/powerpc/kvm/book3s_hv.c        | 115 +++++++++++++++++++++++++++++++-----
 arch/powerpc/kvm/trace_hv.h         |  22 +++++++
 3 files changed, 125 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 4915443..b34efe8 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -308,6 +308,7 @@ struct kvmppc_vcore {
 	ulong pcr;
 	ulong dpdes;		/* doorbell state (POWER8) */
 	ulong conferring_threads;
+	unsigned int halt_poll_ns;
 };
 
 #define VCORE_ENTRY_MAP(vc)	((vc)->entry_exit_map & 0xff)
@@ -329,6 +330,7 @@ struct kvmppc_vcore {
 #define VCORE_SLEEPING	3
 #define VCORE_RUNNING	4
 #define VCORE_EXITING	5
+#define VCORE_POLLING	6
 
 /*
  * Struct used to manage memory for a virtual processor area
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 3bcf9e6..0d8ce14 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -94,6 +94,23 @@ module_param_cb(h_ipi_redirect, &module_param_ops, &h_ipi_redirect,
 MODULE_PARM_DESC(h_ipi_redirect, "Redirect H_IPI wakeup to a free host core");
 #endif
 
+/* Maximum halt poll interval defaults to KVM_HALT_POLL_NS_DEFAULT */
+static unsigned int halt_poll_max_ns = KVM_HALT_POLL_NS_DEFAULT;
+module_param(halt_poll_max_ns, uint, S_IRUGO | S_IWUSR);
+MODULE_PARM_DESC(halt_poll_max_ns, "Maximum halt poll time in ns");
+
+/* Factor by which the vcore halt poll interval is grown, default is to double
+ */
+static unsigned int halt_poll_ns_grow = 2;
+module_param(halt_poll_ns_grow, int, S_IRUGO);
+MODULE_PARM_DESC(halt_poll_ns_grow, "Factor halt poll time is grown by");
+
+/* Factor by which the vcore halt poll interval is shrunk, default is to reset
+ */
+static unsigned int halt_poll_ns_shrink;
+module_param(halt_poll_ns_shrink, int, S_IRUGO);
+MODULE_PARM_DESC(halt_poll_ns_shrink, "Factor halt poll time is shrunk by");
+
 static void kvmppc_end_cede(struct kvm_vcpu *vcpu);
 static int kvmppc_hv_setup_htab_rma(struct kvm_vcpu *vcpu);
 
@@ -2620,32 +2637,82 @@ static void kvmppc_wait_for_exec(struct kvmppc_vcore *vc,
 	finish_wait(&vcpu->arch.cpu_run, &wait);
 }
 
+static void grow_halt_poll_ns(struct kvmppc_vcore *vc)
+{
+	/* 10us base */
+	if (vc->halt_poll_ns == 0 && halt_poll_ns_grow)
+		vc->halt_poll_ns = 10000;
+	else
+		vc->halt_poll_ns *= halt_poll_ns_grow;
+
+	if (vc->halt_poll_ns > halt_poll_max_ns)
+		vc->halt_poll_ns = halt_poll_max_ns;
+}
+
+static void shrink_halt_poll_ns(struct kvmppc_vcore *vc)
+{
+	if (halt_poll_ns_shrink == 0)
+		vc->halt_poll_ns = 0;
+	else
+		vc->halt_poll_ns /= halt_poll_ns_shrink;
+}
+
+/* Check to see if any of the runnable vcpus on the vcore have pending
+ * exceptions or are no longer ceded
+ */
+static int kvmppc_vcore_check_block(struct kvmppc_vcore *vc)
+{
+	struct kvm_vcpu *vcpu;
+	int i;
+
+	for_each_runnable_thread(i, vcpu, vc) {
+		if (vcpu->arch.pending_exceptions || !vcpu->arch.ceded)
+			return 1;
+	}
+
+	return 0;
+}
+
 /*
  * All the vcpus in this vcore are idle, so wait for a decrementer
  * or external interrupt to one of the vcpus.  vc->lock is held.
  */
 static void kvmppc_vcore_blocked(struct kvmppc_vcore *vc)
 {
-	struct kvm_vcpu *vcpu;
-	int do_sleep = 1, i;
+	int do_sleep = 1;
+	ktime_t cur, start;
+	u64 block_ns;
 	DECLARE_SWAITQUEUE(wait);
 
-	prepare_to_swait(&vc->wq, &wait, TASK_INTERRUPTIBLE);
+	/* Poll for pending exceptions and ceded state */
+	cur = start = ktime_get();
+	if (vc->halt_poll_ns) {
+		ktime_t stop = ktime_add_ns(start, vc->halt_poll_ns);
 
-	/*
-	 * Check one last time for pending exceptions and ceded state after
-	 * we put ourselves on the wait queue
-	 */
-	for_each_runnable_thread(i, vcpu, vc) {
-		if (vcpu->arch.pending_exceptions || !vcpu->arch.ceded) {
-			do_sleep = 0;
-			break;
-		}
+		vc->vcore_state = VCORE_POLLING;
+		spin_unlock(&vc->lock);
+
+		do {
+			if (kvmppc_vcore_check_block(vc)) {
+				do_sleep = 0;
+				break;
+			}
+			cur = ktime_get();
+		} while (ktime_before(cur, stop));
+
+		spin_lock(&vc->lock);
+		vc->vcore_state = VCORE_INACTIVE;
+
+		if (!do_sleep)
+			goto out;
 	}
 
-	if (!do_sleep) {
+	prepare_to_swait(&vc->wq, &wait, TASK_INTERRUPTIBLE);
+
+	if (kvmppc_vcore_check_block(vc)) {
 		finish_swait(&vc->wq, &wait);
-		return;
+		do_sleep = 0;
+		goto out;
 	}
 
 	vc->vcore_state = VCORE_SLEEPING;
@@ -2656,6 +2723,26 @@ static void kvmppc_vcore_blocked(struct kvmppc_vcore *vc)
 	spin_lock(&vc->lock);
 	vc->vcore_state = VCORE_INACTIVE;
 	trace_kvmppc_vcore_blocked(vc, 1);
+
+	cur = ktime_get();
+
+out:
+	block_ns = ktime_to_ns(cur) - ktime_to_ns(start);
+
+	if (halt_poll_max_ns) {
+		if (block_ns <= vc->halt_poll_ns)
+			;
+		/* We slept and blocked for longer than the max halt time */
+		else if (vc->halt_poll_ns && block_ns > halt_poll_max_ns)
+			shrink_halt_poll_ns(vc);
+		/* We slept and our poll time is too small */
+		else if (vc->halt_poll_ns < halt_poll_max_ns &&
+				block_ns < halt_poll_max_ns)
+			grow_halt_poll_ns(vc);
+	} else
+		vc->halt_poll_ns = 0;
+
+	trace_kvmppc_vcore_wakeup(do_sleep, block_ns);
 }
 
 static int kvmppc_run_vcpu(struct kvm_run *kvm_run, struct kvm_vcpu *vcpu)
diff --git a/arch/powerpc/kvm/trace_hv.h b/arch/powerpc/kvm/trace_hv.h
index 33d9daf..fb21990 100644
--- a/arch/powerpc/kvm/trace_hv.h
+++ b/arch/powerpc/kvm/trace_hv.h
@@ -432,6 +432,28 @@ TRACE_EVENT(kvmppc_vcore_blocked,
 		   __entry->runner_vcpu, __entry->n_runnable, __entry->tgid)
 );
 
+TRACE_EVENT(kvmppc_vcore_wakeup,
+	TP_PROTO(int do_sleep, __u64 ns),
+
+	TP_ARGS(do_sleep, ns),
+
+	TP_STRUCT__entry(
+		__field(__u64,  ns)
+		__field(int,    waited)
+		__field(pid_t,  tgid)
+	),
+
+	TP_fast_assign(
+		__entry->ns     = ns;
+		__entry->waited = do_sleep;
+		__entry->tgid   = current->tgid;
+	),
+
+	TP_printk("%s time %lld ns, tgid=%d",
+		__entry->waited ? "wait" : "poll",
+		__entry->ns, __entry->tgid)
+);
+
 TRACE_EVENT(kvmppc_run_vcpu_enter,
 	TP_PROTO(struct kvm_vcpu *vcpu),
 
-- 
2.5.5
