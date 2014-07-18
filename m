Return-Path: <stewart@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8362C1A0058
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Jul 2014 14:18:58 +1000 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Thu, 17 Jul 2014 22:18:56 -0600
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 67FF738C8026
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Jul 2014 00:18:53 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp22036.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6I4IrVn62980214
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Jul 2014 04:18:53 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6I4Ir7t019537
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Jul 2014 00:18:53 -0400
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, paulus@samba.org, kvm-ppc@vger.kernel.org,
 Alexander Graf <agraf@suse.de>
Subject: [PATCH v4 1/2] Split out struct kvmppc_vcore creation to separate
 function
Date: Fri, 18 Jul 2014 14:18:42 +1000
Message-Id: <1405657123-20087-2-git-send-email-stewart@linux.vnet.ibm.com>
In-Reply-To: <1405657123-20087-1-git-send-email-stewart@linux.vnet.ibm.com>
References: <1405567197-23333-1-git-send-email-stewart@linux.vnet.ibm.com>
 <1405657123-20087-1-git-send-email-stewart@linux.vnet.ibm.com>
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

No code changes, just split it out to a function so that with the addition
of micro partition prefetch buffer allocation (in subsequent patch) looks
neater and doesn't require excessive indentation.

Signed-off-by: Stewart Smith <stewart@linux.vnet.ibm.com>
---
 arch/powerpc/kvm/book3s_hv.c |   31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 7a12edb..cfe14f8 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -1228,6 +1228,26 @@ static int kvmppc_set_one_reg_hv(struct kvm_vcpu *vcpu, u64 id,
 	return r;
 }
 
+static struct kvmppc_vcore *kvmppc_vcore_create(struct kvm *kvm, int core)
+{
+	struct kvmppc_vcore *vcore;
+
+	vcore = kzalloc(sizeof(struct kvmppc_vcore), GFP_KERNEL);
+
+	if (vcore == NULL)
+		return NULL;
+
+	INIT_LIST_HEAD(&vcore->runnable_threads);
+	spin_lock_init(&vcore->lock);
+	init_waitqueue_head(&vcore->wq);
+	vcore->preempt_tb = TB_NIL;
+	vcore->lpcr = kvm->arch.lpcr;
+	vcore->first_vcpuid = core * threads_per_subcore;
+	vcore->kvm = kvm;
+
+	return vcore;
+}
+
 static struct kvm_vcpu *kvmppc_core_vcpu_create_hv(struct kvm *kvm,
 						   unsigned int id)
 {
@@ -1279,16 +1299,7 @@ static struct kvm_vcpu *kvmppc_core_vcpu_create_hv(struct kvm *kvm,
 	mutex_lock(&kvm->lock);
 	vcore = kvm->arch.vcores[core];
 	if (!vcore) {
-		vcore = kzalloc(sizeof(struct kvmppc_vcore), GFP_KERNEL);
-		if (vcore) {
-			INIT_LIST_HEAD(&vcore->runnable_threads);
-			spin_lock_init(&vcore->lock);
-			init_waitqueue_head(&vcore->wq);
-			vcore->preempt_tb = TB_NIL;
-			vcore->lpcr = kvm->arch.lpcr;
-			vcore->first_vcpuid = core * threads_per_subcore;
-			vcore->kvm = kvm;
-		}
+		vcore = kvmppc_vcore_create(kvm, core);
 		kvm->arch.vcores[core] = vcore;
 		kvm->arch.online_vcores++;
 	}
-- 
1.7.10.4
