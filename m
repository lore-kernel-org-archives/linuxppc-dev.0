Return-Path: <elfring@users.sourceforge.net>
Received: from mout.web.de (mout.web.de [212.227.15.4])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v4pzy3GRNzDqWX
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Jan 2017 05:25:50 +1100 (AEDT)
Subject: [PATCH 05/11] KVM: PPC: Book3S HV: Adjust nine checks for null
 pointers
To: kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Alexander Graf <agraf@suse.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
References: <fc2c36e6-a453-ae09-89bf-98b3d74113a4@users.sourceforge.net>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <161c8660-d204-5190-9bda-c5a801abe0ab@users.sourceforge.net>
Date: Fri, 20 Jan 2017 19:23:59 +0100
MIME-Version: 1.0
In-Reply-To: <fc2c36e6-a453-ae09-89bf-98b3d74113a4@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 20 Jan 2017 11:25:48 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The script "checkpatch.pl" pointed information out like the following.

Comparison to NULL could be written …

Thus fix affected source code places.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/powerpc/kvm/book3s_hv.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index cfc7699d05df..3122998f6a32 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -458,7 +458,7 @@ static unsigned long do_h_register_vpa(struct kvm_vcpu *vcpu,
 
 		/* convert logical addr to kernel addr and read length */
 		va = kvmppc_pin_guest_page(kvm, vpa, &nb);
-		if (va == NULL)
+		if (!va)
 			return H_PARAMETER;
 		if (subfunc == H_VPA_REG_VPA)
 			len = be16_to_cpu(((struct reg_vpa *)va)->length.hword);
@@ -1591,8 +1591,7 @@ static struct kvmppc_vcore *kvmppc_vcore_create(struct kvm *kvm, int core)
 	struct kvmppc_vcore *vcore;
 
 	vcore = kzalloc(sizeof(struct kvmppc_vcore), GFP_KERNEL);
-
-	if (vcore == NULL)
+	if (!vcore)
 		return NULL;
 
 	spin_lock_init(&vcore->lock);
@@ -2221,7 +2220,7 @@ static void collect_piggybacks(struct core_info *cip, int target_threads)
 		prepare_threads(pvc);
 		if (!pvc->n_runnable) {
 			list_del_init(&pvc->preempt_list);
-			if (pvc->runner == NULL) {
+			if (!pvc->runner) {
 				pvc->vcore_state = VCORE_INACTIVE;
 				kvmppc_core_end_stolen(pvc);
 			}
@@ -2287,7 +2286,7 @@ static void post_guest_process(struct kvmppc_vcore *vc, bool is_master)
 		} else {
 			vc->vcore_state = VCORE_INACTIVE;
 		}
-		if (vc->n_runnable > 0 && vc->runner == NULL) {
+		if (vc->n_runnable > 0 && !vc->runner) {
 			/* make sure there's a candidate runner awake */
 			i = -1;
 			vcpu = next_runnable_thread(vc, &i);
@@ -2786,7 +2785,7 @@ static int kvmppc_run_vcpu(struct kvm_run *kvm_run, struct kvm_vcpu *vcpu)
 
 	while (vcpu->arch.state == KVMPPC_VCPU_RUNNABLE &&
 	       !signal_pending(current)) {
-		if (vc->vcore_state == VCORE_PREEMPT && vc->runner == NULL)
+		if (vc->vcore_state == VCORE_PREEMPT && !vc->runner)
 			kvmppc_vcore_end_preempt(vc);
 
 		if (vc->vcore_state != VCORE_INACTIVE) {
@@ -2833,7 +2832,7 @@ static int kvmppc_run_vcpu(struct kvm_run *kvm_run, struct kvm_vcpu *vcpu)
 		vc->vcore_state == VCORE_PIGGYBACK))
 		kvmppc_wait_for_exec(vc, vcpu, TASK_UNINTERRUPTIBLE);
 
-	if (vc->vcore_state == VCORE_PREEMPT && vc->runner == NULL)
+	if (vc->vcore_state == VCORE_PREEMPT && !vc->runner)
 		kvmppc_vcore_end_preempt(vc);
 
 	if (vcpu->arch.state == KVMPPC_VCPU_RUNNABLE) {
@@ -3203,7 +3202,7 @@ void kvmppc_alloc_host_rm_ops(void)
 	int size;
 
 	/* Not the first time here ? */
-	if (kvmppc_host_rm_ops_hv != NULL)
+	if (kvmppc_host_rm_ops_hv)
 		return;
 
 	ops = kzalloc(sizeof(struct kvmppc_host_rm_ops), GFP_KERNEL);
@@ -3430,10 +3429,10 @@ static int kvmppc_set_passthru_irq(struct kvm *kvm, int host_irq, int guest_gsi)
 	mutex_lock(&kvm->lock);
 
 	pimap = kvm->arch.pimap;
-	if (pimap == NULL) {
+	if (!pimap) {
 		/* First call, allocate structure to hold IRQ map */
 		pimap = kvmppc_alloc_pimap();
-		if (pimap == NULL) {
+		if (!pimap) {
 			mutex_unlock(&kvm->lock);
 			return -ENOMEM;
 		}
-- 
2.11.0
