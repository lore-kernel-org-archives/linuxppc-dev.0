Return-Path: <paulus@ozlabs.org>
Date: Tue, 20 Dec 2011 21:22:57 +1100
From: Paul Mackerras <paulus@samba.org>
To: Alexander Graf <agraf@suse.de>
Subject: [RFC PATCH 1/2] KVM: PPC: Book3S HV: Make virtual processor area
 registration more robust
Message-ID: <20111220102257.GC5626@bloggs.ozlabs.ibm.com>
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

The PAPR API allows three sorts of per-virtual-processor areas to be
registered (VPA, SLB shadow buffer, and dispatch trace log), and
furthermore, these can be registered and unregistered for another
virtual CPU.  Currently we just update the vcpu fields pointing to
these areas at the time of registration or unregistration.  If this
is done on another vcpu, there is the possibility that the target vcpu
is using those fields at the time and could end up using a bogus
pointer and corrupting memory.

This fixes the race by making the target cpu itself do the update, so
we can be sure that the update happens at a time when the fields aren't
being used.  These are updated from a set of 'next_*' fields, which
are protected by a spinlock.  (We could have just taken the spinlock
when using the vpa, slb_shadow or dtl fields, but that would mean
taking the spinlock on every guest entry and exit.)

The code in do_h_register_vpa now takes the spinlock and updates the
'next_*' fields.  There is also a set of '*_pending' flags to indicate
that an update is pending.

This also changes 'struct dtl' (which was undefined) to 'struct dtl_entry',
which is what the rest of the kernel uses.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/include/asm/kvm_host.h |   15 +++-
 arch/powerpc/kvm/book3s_hv.c        |  167 +++++++++++++++++++++++++----------
 2 files changed, 131 insertions(+), 51 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 1cb6e52..b1126c1 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -82,7 +82,7 @@ struct kvm_vcpu;
 
 struct lppaca;
 struct slb_shadow;
-struct dtl;
+struct dtl_entry;
 
 struct kvm_vm_stat {
 	u32 remote_tlb_flush;
@@ -449,9 +449,18 @@ struct kvm_vcpu_arch {
 	u32 last_inst;
 
 	struct lppaca *vpa;
+	struct lppaca *next_vpa;
 	struct slb_shadow *slb_shadow;
-	struct dtl *dtl;
-	struct dtl *dtl_end;
+	struct slb_shadow *next_slb_shadow;
+	struct dtl_entry *dtl;
+	struct dtl_entry *dtl_end;
+	struct dtl_entry *dtl_ptr;
+	struct dtl_entry *next_dtl;
+	struct dtl_entry *next_dtl_end;
+	u8 vpa_pending;
+	u8 slb_shadow_pending;
+	u8 dtl_pending;
+	spinlock_t vpa_update_lock;
 
 	wait_queue_head_t *wqp;
 	struct kvmppc_vcore *vcore;
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index c11d960..6f6e88d 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -140,7 +140,7 @@ static unsigned long do_h_register_vpa(struct kvm_vcpu *vcpu,
 {
 	struct kvm *kvm = vcpu->kvm;
 	unsigned long len, nb;
-	void *va;
+	void *va, *free_va, *tvpa, *dtl, *ss;
 	struct kvm_vcpu *tvcpu;
 	int err = H_PARAMETER;
 
@@ -152,6 +152,8 @@ static unsigned long do_h_register_vpa(struct kvm_vcpu *vcpu,
 	flags &= 7;
 	if (flags == 0 || flags == 4)
 		return H_PARAMETER;
+	free_va = va = NULL;
+	len = 0;
 	if (flags < 4) {
 		if (vpa & 0x7f)
 			return H_PARAMETER;
@@ -165,65 +167,122 @@ static unsigned long do_h_register_vpa(struct kvm_vcpu *vcpu,
 			len = *(unsigned short *)(va + 4);
 		else
 			len = *(unsigned int *)(va + 4);
+		free_va = va;
 		if (len > nb)
 			goto out_unpin;
-		switch (flags) {
-		case 1:		/* register VPA */
-			if (len < 640)
-				goto out_unpin;
-			if (tvcpu->arch.vpa)
-				kvmppc_unpin_guest_page(kvm, vcpu->arch.vpa);
-			tvcpu->arch.vpa = va;
-			init_vpa(vcpu, va);
-			break;
-		case 2:		/* register DTL */
-			if (len < 48)
-				goto out_unpin;
-			len -= len % 48;
-			if (tvcpu->arch.dtl)
-				kvmppc_unpin_guest_page(kvm, vcpu->arch.dtl);
-			tvcpu->arch.dtl = va;
-			tvcpu->arch.dtl_end = va + len;
+	}
+
+	spin_lock(&tvcpu->arch.vpa_update_lock);
+
+	switch (flags) {
+	case 1:		/* register VPA */
+		if (len < 640)
 			break;
-		case 3:		/* register SLB shadow buffer */
-			if (len < 16)
-				goto out_unpin;
-			if (tvcpu->arch.slb_shadow)
-				kvmppc_unpin_guest_page(kvm, vcpu->arch.slb_shadow);
-			tvcpu->arch.slb_shadow = va;
+		free_va = tvcpu->arch.next_vpa;
+		tvcpu->arch.next_vpa = va;
+		tvcpu->arch.vpa_pending = 1;
+		init_vpa(tvcpu, va);
+		err = 0;
+		break;
+	case 2:		/* register DTL */
+		if (len < 48)
 			break;
+		len -= len % 48;
+		tvpa = tvcpu->arch.vpa;
+		if (tvcpu->arch.vpa_pending)
+			tvpa = tvcpu->arch.next_vpa;
+		err = H_RESOURCE;
+		if (tvpa) {
+			free_va = tvcpu->arch.next_dtl;
+			tvcpu->arch.next_dtl = va;
+			tvcpu->arch.next_dtl_end = va + len;
+			tvcpu->arch.dtl_pending = 1;
+			err = 0;
 		}
-	} else {
-		switch (flags) {
-		case 5:		/* unregister VPA */
-			if (tvcpu->arch.slb_shadow || tvcpu->arch.dtl)
-				return H_RESOURCE;
-			if (!tvcpu->arch.vpa)
-				break;
-			kvmppc_unpin_guest_page(kvm, tvcpu->arch.vpa);
-			tvcpu->arch.vpa = NULL;
-			break;
-		case 6:		/* unregister DTL */
-			if (!tvcpu->arch.dtl)
-				break;
-			kvmppc_unpin_guest_page(kvm, tvcpu->arch.dtl);
-			tvcpu->arch.dtl = NULL;
-			break;
-		case 7:		/* unregister SLB shadow buffer */
-			if (!tvcpu->arch.slb_shadow)
-				break;
-			kvmppc_unpin_guest_page(kvm, tvcpu->arch.slb_shadow);
-			tvcpu->arch.slb_shadow = NULL;
+		break;
+	case 3:		/* register SLB shadow buffer */
+		if (len < 16)
 			break;
+		tvpa = tvcpu->arch.vpa;
+		if (tvcpu->arch.vpa_pending)
+			tvpa = tvcpu->arch.next_vpa;
+		err = H_RESOURCE;
+		if (tvpa) {
+			free_va = tvcpu->arch.next_slb_shadow;
+			tvcpu->arch.next_slb_shadow = va;
+			tvcpu->arch.slb_shadow_pending = 1;
+			err = 0;
+		}
+		break;
+
+	case 5:		/* unregister VPA */
+		dtl = tvcpu->arch.dtl;
+		if (tvcpu->arch.dtl_pending)
+			dtl = tvcpu->arch.next_dtl;
+		ss = tvcpu->arch.slb_shadow;
+		if (tvcpu->arch.slb_shadow_pending)
+			ss = tvcpu->arch.next_slb_shadow;
+		err = H_RESOURCE;
+		if (!dtl && !ss) {
+			free_va = tvcpu->arch.next_vpa;
+			tvcpu->arch.next_vpa = NULL;
+			tvcpu->arch.vpa_pending = 1;
+			err = 0;
 		}
+		break;
+	case 6:		/* unregister DTL */
+		free_va = tvcpu->arch.next_dtl;
+		tvcpu->arch.next_dtl = NULL;
+		tvcpu->arch.dtl_pending = 1;
+		err = 0;
+		break;
+	case 7:		/* unregister SLB shadow buffer */
+		free_va = tvcpu->arch.next_slb_shadow;
+		tvcpu->arch.next_slb_shadow = NULL;
+		tvcpu->arch.slb_shadow_pending = 1;
+		err = 0;
+		break;
 	}
-	return H_SUCCESS;
 
+	spin_unlock(&tvcpu->arch.vpa_update_lock);
  out_unpin:
-	kvmppc_unpin_guest_page(kvm, va);
+	if (free_va)
+		kvmppc_unpin_guest_page(kvm, free_va);
 	return err;
 }
 
+static void kvmppc_update_vpas(struct kvm_vcpu *vcpu)
+{
+	struct kvm *kvm = vcpu->kvm;
+
+	spin_lock(&vcpu->arch.vpa_update_lock);
+	if (vcpu->arch.vpa_pending) {
+		if (vcpu->arch.vpa)
+			kvmppc_unpin_guest_page(kvm, vcpu->arch.vpa);
+		vcpu->arch.vpa = vcpu->arch.next_vpa;
+		vcpu->arch.next_vpa = NULL;
+		vcpu->arch.vpa_pending = 0;
+	}
+	if (vcpu->arch.slb_shadow_pending) {
+		if (vcpu->arch.slb_shadow)
+			kvmppc_unpin_guest_page(kvm, vcpu->arch.slb_shadow);
+		vcpu->arch.slb_shadow = vcpu->arch.next_slb_shadow;
+		vcpu->arch.next_slb_shadow = NULL;
+		vcpu->arch.slb_shadow_pending = 0;
+	}
+	if (vcpu->arch.dtl_pending) {
+		if (vcpu->arch.dtl)
+			kvmppc_unpin_guest_page(kvm, vcpu->arch.dtl);
+		vcpu->arch.dtl = vcpu->arch.dtl_ptr = vcpu->arch.next_dtl;
+		vcpu->arch.dtl_end = vcpu->arch.next_dtl_end;
+		vcpu->arch.next_dtl = NULL;
+		vcpu->arch.dtl_pending = 0;
+		if (vcpu->arch.vpa)	/* (should always be non-NULL) */
+			vcpu->arch.vpa->dtl_idx = 0;
+	}
+	spin_unlock(&vcpu->arch.vpa_update_lock);
+}
+
 int kvmppc_pseries_do_hcall(struct kvm_vcpu *vcpu)
 {
 	unsigned long req = kvmppc_get_gpr(vcpu, 3);
@@ -509,12 +568,20 @@ out:
 
 void kvmppc_core_vcpu_free(struct kvm_vcpu *vcpu)
 {
+	spin_lock(&vcpu->arch.vpa_update_lock);
 	if (vcpu->arch.dtl)
 		kvmppc_unpin_guest_page(vcpu->kvm, vcpu->arch.dtl);
+	if (vcpu->arch.dtl_pending && vcpu->arch.next_dtl)
+		kvmppc_unpin_guest_page(vcpu->kvm, vcpu->arch.next_dtl);
 	if (vcpu->arch.slb_shadow)
 		kvmppc_unpin_guest_page(vcpu->kvm, vcpu->arch.slb_shadow);
+	if (vcpu->arch.slb_shadow_pending && vcpu->arch.next_slb_shadow)
+		kvmppc_unpin_guest_page(vcpu->kvm, vcpu->arch.next_slb_shadow);
 	if (vcpu->arch.vpa)
 		kvmppc_unpin_guest_page(vcpu->kvm, vcpu->arch.vpa);
+	if (vcpu->arch.vpa_pending && vcpu->arch.next_vpa)
+		kvmppc_unpin_guest_page(vcpu->kvm, vcpu->arch.next_vpa);
+	spin_unlock(&vcpu->arch.vpa_update_lock);
 	kvm_vcpu_uninit(vcpu);
 	kfree(vcpu);
 }
@@ -681,8 +748,12 @@ static int kvmppc_run_core(struct kvmppc_vcore *vc)
 	vc->in_guest = 0;
 	vc->pcpu = smp_processor_id();
 	vc->napping_threads = 0;
-	list_for_each_entry(vcpu, &vc->runnable_threads, arch.run_list)
+	list_for_each_entry(vcpu, &vc->runnable_threads, arch.run_list) {
 		kvmppc_start_thread(vcpu);
+		if (vcpu->arch.vpa_pending || vcpu->arch.slb_shadow_pending ||
+		    vcpu->arch.dtl_pending)
+			kvmppc_update_vpas(vcpu);
+	}
 
 	preempt_disable();
 	spin_unlock(&vc->lock);
-- 
1.7.7.3
