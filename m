Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4B0D11A0CC8
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 22 Feb 2015 21:43:44 +1100 (AEDT)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sun, 22 Feb 2015 16:13:41 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 4DCBFE0045
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 22 Feb 2015 16:15:23 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1MAhcjD6029820
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 22 Feb 2015 16:13:38 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1MAhc65025420
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 22 Feb 2015 16:13:38 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: agraf@suse.de, benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH] KVM: PPC: BOOK3S: HV: remove rma related variables from code.
Date: Sun, 22 Feb 2015 16:13:31 +0530
Message-Id: <1424601811-2514-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We don't support real-mode areas now that 970 support is removed.
Remove the remaining details of rma from the code. Also rename
rma_setup_done to hpte_setup_done to better reflect the changes.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/kvm_host.h |  3 +--
 arch/powerpc/kvm/book3s_64_mmu_hv.c | 28 ++++++++++++++--------------
 arch/powerpc/kvm/book3s_hv.c        | 10 +++++-----
 3 files changed, 20 insertions(+), 21 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 7efd666a3fa7..833486a5734a 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -227,9 +227,8 @@ struct kvm_arch {
 	int tlbie_lock;
 	unsigned long lpcr;
 	unsigned long rmor;
-	struct kvm_rma_info *rma;
 	unsigned long vrma_slb_v;
-	int rma_setup_done;
+	int hpte_setup_done;
 	u32 hpt_order;
 	atomic_t vcpus_running;
 	u32 online_vcores;
diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
index 534acb3c6c3d..dbf127168ca4 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -116,12 +116,12 @@ long kvmppc_alloc_reset_hpt(struct kvm *kvm, u32 *htab_orderp)
 	long order;
 
 	mutex_lock(&kvm->lock);
-	if (kvm->arch.rma_setup_done) {
-		kvm->arch.rma_setup_done = 0;
-		/* order rma_setup_done vs. vcpus_running */
+	if (kvm->arch.hpte_setup_done) {
+		kvm->arch.hpte_setup_done = 0;
+		/* order hpte_setup_done vs. vcpus_running */
 		smp_mb();
 		if (atomic_read(&kvm->arch.vcpus_running)) {
-			kvm->arch.rma_setup_done = 1;
+			kvm->arch.hpte_setup_done = 1;
 			goto out;
 		}
 	}
@@ -1339,20 +1339,20 @@ static ssize_t kvm_htab_write(struct file *file, const char __user *buf,
 	unsigned long tmp[2];
 	ssize_t nb;
 	long int err, ret;
-	int rma_setup;
+	int hpte_setup;
 
 	if (!access_ok(VERIFY_READ, buf, count))
 		return -EFAULT;
 
 	/* lock out vcpus from running while we're doing this */
 	mutex_lock(&kvm->lock);
-	rma_setup = kvm->arch.rma_setup_done;
-	if (rma_setup) {
-		kvm->arch.rma_setup_done = 0;	/* temporarily */
-		/* order rma_setup_done vs. vcpus_running */
+	hpte_setup = kvm->arch.hpte_setup_done;
+	if (hpte_setup) {
+		kvm->arch.hpte_setup_done = 0;	/* temporarily */
+		/* order hpte_setup_done vs. vcpus_running */
 		smp_mb();
 		if (atomic_read(&kvm->arch.vcpus_running)) {
-			kvm->arch.rma_setup_done = 1;
+			kvm->arch.hpte_setup_done = 1;
 			mutex_unlock(&kvm->lock);
 			return -EBUSY;
 		}
@@ -1405,7 +1405,7 @@ static ssize_t kvm_htab_write(struct file *file, const char __user *buf,
 				       "r=%lx\n", ret, i, v, r);
 				goto out;
 			}
-			if (!rma_setup && is_vrma_hpte(v)) {
+			if (!hpte_setup && is_vrma_hpte(v)) {
 				unsigned long psize = hpte_base_page_size(v, r);
 				unsigned long senc = slb_pgsize_encoding(psize);
 				unsigned long lpcr;
@@ -1414,7 +1414,7 @@ static ssize_t kvm_htab_write(struct file *file, const char __user *buf,
 					(VRMA_VSID << SLB_VSID_SHIFT_1T);
 				lpcr = senc << (LPCR_VRMASD_SH - 4);
 				kvmppc_update_lpcr(kvm, lpcr, LPCR_VRMASD);
-				rma_setup = 1;
+				hpte_setup = 1;
 			}
 			++i;
 			hptp += 2;
@@ -1430,9 +1430,9 @@ static ssize_t kvm_htab_write(struct file *file, const char __user *buf,
 	}
 
  out:
-	/* Order HPTE updates vs. rma_setup_done */
+	/* Order HPTE updates vs. hpte_setup_done */
 	smp_wmb();
-	kvm->arch.rma_setup_done = rma_setup;
+	kvm->arch.hpte_setup_done = hpte_setup;
 	mutex_unlock(&kvm->lock);
 
 	if (err)
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index de4018a1bc4b..34e79b8e855c 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -2032,11 +2032,11 @@ static int kvmppc_vcpu_run_hv(struct kvm_run *run, struct kvm_vcpu *vcpu)
 	}
 
 	atomic_inc(&vcpu->kvm->arch.vcpus_running);
-	/* Order vcpus_running vs. rma_setup_done, see kvmppc_alloc_reset_hpt */
+	/* Order vcpus_running vs. hpte_setup_done, see kvmppc_alloc_reset_hpt */
 	smp_mb();
 
 	/* On the first time here, set up HTAB and VRMA */
-	if (!vcpu->kvm->arch.rma_setup_done) {
+	if (!vcpu->kvm->arch.hpte_setup_done) {
 		r = kvmppc_hv_setup_htab_rma(vcpu);
 		if (r)
 			goto out;
@@ -2238,7 +2238,7 @@ static int kvmppc_hv_setup_htab_rma(struct kvm_vcpu *vcpu)
 	int srcu_idx;
 
 	mutex_lock(&kvm->lock);
-	if (kvm->arch.rma_setup_done)
+	if (kvm->arch.hpte_setup_done)
 		goto out;	/* another vcpu beat us to it */
 
 	/* Allocate hashed page table (if not done already) and reset it */
@@ -2289,9 +2289,9 @@ static int kvmppc_hv_setup_htab_rma(struct kvm_vcpu *vcpu)
 
 	kvmppc_update_lpcr(kvm, lpcr, LPCR_VRMASD);
 
-	/* Order updates to kvm->arch.lpcr etc. vs. rma_setup_done */
+	/* Order updates to kvm->arch.lpcr etc. vs. hpte_setup_done */
 	smp_wmb();
-	kvm->arch.rma_setup_done = 1;
+	kvm->arch.hpte_setup_done = 1;
 	err = 0;
  out_srcu:
 	srcu_read_unlock(&kvm->srcu, srcu_idx);
-- 
2.1.0
