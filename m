Return-Path: <elfring@users.sourceforge.net>
Received: from mout.web.de (mout.web.de [212.227.15.4])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v4q0R6BZZzDqgp
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Jan 2017 05:26:15 +1100 (AEDT)
Subject: [PATCH 07/11] KVM: PPC: Book3S HV: Improve size determinations in
 five functions
To: kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Alexander Graf <agraf@suse.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
References: <fc2c36e6-a453-ae09-89bf-98b3d74113a4@users.sourceforge.net>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <83004740-a092-4460-f211-607c5c711e82@users.sourceforge.net>
Date: Fri, 20 Jan 2017 19:25:54 +0100
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
Date: Fri, 20 Jan 2017 16:23:30 +0100

Replace the specification of data structures by pointer dereferences
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/powerpc/kvm/book3s_hv.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 596201b3f22e..9b7a5a8c9e4b 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -655,7 +655,7 @@ static void kvmppc_create_dtl_entry(struct kvm_vcpu *vcpu,
 	spin_unlock_irq(&vcpu->arch.tbacct_lock);
 	if (!dt || !vpa)
 		return;
-	memset(dt, 0, sizeof(struct dtl_entry));
+	memset(dt, 0, sizeof(*dt));
 	dt->dispatch_reason = 7;
 	dt->processor_id = cpu_to_be16(vc->pcpu + vcpu->arch.ptid);
 	dt->timebase = cpu_to_be64(now + vc->tb_offset);
@@ -1073,7 +1073,7 @@ static int kvm_arch_vcpu_ioctl_get_sregs_hv(struct kvm_vcpu *vcpu,
 {
 	int i;
 
-	memset(sregs, 0, sizeof(struct kvm_sregs));
+	memset(sregs, 0, sizeof(*sregs));
 	sregs->pvr = vcpu->arch.pvr;
 	for (i = 0; i < vcpu->arch.slb_max; i++) {
 		sregs->u.s.ppc64.slb[i].slbe = vcpu->arch.slb[i].orige;
@@ -1590,7 +1590,7 @@ static struct kvmppc_vcore *kvmppc_vcore_create(struct kvm *kvm, int core)
 {
 	struct kvmppc_vcore *vcore;
 
-	vcore = kzalloc(sizeof(struct kvmppc_vcore), GFP_KERNEL);
+	vcore = kzalloc(sizeof(*vcore), GFP_KERNEL);
 	if (!vcore)
 		return NULL;
 
@@ -3204,7 +3204,7 @@ void kvmppc_alloc_host_rm_ops(void)
 	if (kvmppc_host_rm_ops_hv)
 		return;
 
-	ops = kzalloc(sizeof(struct kvmppc_host_rm_ops), GFP_KERNEL);
+	ops = kzalloc(sizeof(*ops), GFP_KERNEL);
 	if (!ops)
 		return;
 
@@ -3713,13 +3713,13 @@ static int kvm_init_subcore_bitmap(void)
 			continue;
 
 		sibling_subcore_state =
-			kmalloc_node(sizeof(struct sibling_subcore_state),
-							GFP_KERNEL, node);
+			kmalloc_node(sizeof(*sibling_subcore_state), GFP_KERNEL,
+				     node);
 		if (!sibling_subcore_state)
 			return -ENOMEM;
 
 		memset(sibling_subcore_state, 0,
-				sizeof(struct sibling_subcore_state));
+		       sizeof(*sibling_subcore_state));
 
 		for (j = 0; j < threads_per_core; j++) {
 			int cpu = first_cpu + j;
-- 
2.11.0
