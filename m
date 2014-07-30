Return-Path: <aik@ozlabs.ru>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1F47F1A01A4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Jul 2014 19:31:44 +1000 (EST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Wed, 30 Jul 2014 19:31:23 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 6B5912BB0057
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Jul 2014 19:31:39 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6U9VFx523134388
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Jul 2014 19:31:15 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6U9VcE4026586
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Jul 2014 19:31:39 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v4 02/16] KVM: PPC: Use RCU for arch.spapr_tce_tables
Date: Wed, 30 Jul 2014 19:31:21 +1000
Message-Id: <1406712695-9491-3-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1406712695-9491-1-git-send-email-aik@ozlabs.ru>
References: <1406712695-9491-1-git-send-email-aik@ozlabs.ru>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Michael Ellerman <michael@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

At the moment spapr_tce_tables is not protected against races. This makes
use of RCU-variants of list helpers. As some bits are executed in real
mode, this makes use of just introduced list_for_each_entry_rcu_notrace().

This converts release_spapr_tce_table() to a RCU scheduled handler.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
Changes:
* total rework
* kfree() for kvmppc_spapr_tce_table is moved to call_rcu_sched() callback
* used new list_for_each_entry_rcu_notrace
---
 arch/powerpc/include/asm/kvm_host.h |  1 +
 arch/powerpc/kvm/book3s.c           |  2 +-
 arch/powerpc/kvm/book3s_64_vio.c    | 23 +++++++++++++----------
 arch/powerpc/kvm/book3s_64_vio_hv.c |  6 ++++--
 4 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index bb66d8b..cd22c31 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -180,6 +180,7 @@ struct kvmppc_spapr_tce_table {
 	struct kvm *kvm;
 	u64 liobn;
 	u32 window_size;
+	struct rcu_head rcu;
 	struct page *pages[0];
 };
 
diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
index c254c27..9e17d19 100644
--- a/arch/powerpc/kvm/book3s.c
+++ b/arch/powerpc/kvm/book3s.c
@@ -886,7 +886,7 @@ int kvmppc_core_init_vm(struct kvm *kvm)
 {
 
 #ifdef CONFIG_PPC64
-	INIT_LIST_HEAD(&kvm->arch.spapr_tce_tables);
+	INIT_LIST_HEAD_RCU(&kvm->arch.spapr_tce_tables);
 	INIT_LIST_HEAD(&kvm->arch.rtas_tokens);
 #endif
 
diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_64_vio.c
index 54cf9bc..5958f7d 100644
--- a/arch/powerpc/kvm/book3s_64_vio.c
+++ b/arch/powerpc/kvm/book3s_64_vio.c
@@ -45,19 +45,16 @@ static long kvmppc_stt_npages(unsigned long window_size)
 		     * sizeof(u64), PAGE_SIZE) / PAGE_SIZE;
 }
 
-static void release_spapr_tce_table(struct kvmppc_spapr_tce_table *stt)
+static void release_spapr_tce_table(struct rcu_head *head)
 {
-	struct kvm *kvm = stt->kvm;
+	struct kvmppc_spapr_tce_table *stt = container_of(head,
+			struct kvmppc_spapr_tce_table, rcu);
 	int i;
 
-	mutex_lock(&kvm->lock);
-	list_del(&stt->list);
 	for (i = 0; i < kvmppc_stt_npages(stt->window_size); i++)
 		__free_page(stt->pages[i]);
+	kvm_put_kvm(stt->kvm);
 	kfree(stt);
-	mutex_unlock(&kvm->lock);
-
-	kvm_put_kvm(kvm);
 }
 
 static int kvm_spapr_tce_fault(struct vm_area_struct *vma, struct vm_fault *vmf)
@@ -87,8 +84,13 @@ static int kvm_spapr_tce_mmap(struct file *file, struct vm_area_struct *vma)
 static int kvm_spapr_tce_release(struct inode *inode, struct file *filp)
 {
 	struct kvmppc_spapr_tce_table *stt = filp->private_data;
+	struct kvm *kvm = stt->kvm;
+
+	mutex_lock(&kvm->lock);
+	list_del_rcu(&stt->list);
+	call_rcu_sched(&stt->rcu, release_spapr_tce_table);
+	mutex_unlock(&kvm->lock);
 
-	release_spapr_tce_table(stt);
 	return 0;
 }
 
@@ -106,7 +108,8 @@ long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
 	int i;
 
 	/* Check this LIOBN hasn't been previously allocated */
-	list_for_each_entry(stt, &kvm->arch.spapr_tce_tables, list) {
+	list_for_each_entry_rcu_notrace(stt, &kvm->arch.spapr_tce_tables,
+			list) {
 		if (stt->liobn == args->liobn)
 			return -EBUSY;
 	}
@@ -131,7 +134,7 @@ long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
 	kvm_get_kvm(kvm);
 
 	mutex_lock(&kvm->lock);
-	list_add(&stt->list, &kvm->arch.spapr_tce_tables);
+	list_add_rcu(&stt->list, &kvm->arch.spapr_tce_tables);
 
 	mutex_unlock(&kvm->lock);
 
diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/book3s_64_vio_hv.c
index 89e96b3..b1914d9 100644
--- a/arch/powerpc/kvm/book3s_64_vio_hv.c
+++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
@@ -50,7 +50,8 @@ long kvmppc_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
 	/* udbg_printf("H_PUT_TCE(): liobn=0x%lx ioba=0x%lx, tce=0x%lx\n", */
 	/* 	    liobn, ioba, tce); */
 
-	list_for_each_entry(stt, &kvm->arch.spapr_tce_tables, list) {
+	list_for_each_entry_rcu_notrace(stt, &kvm->arch.spapr_tce_tables,
+			list) {
 		if (stt->liobn == liobn) {
 			unsigned long idx = ioba >> SPAPR_TCE_SHIFT;
 			struct page *page;
@@ -82,7 +83,8 @@ long kvmppc_h_get_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
 	struct kvm *kvm = vcpu->kvm;
 	struct kvmppc_spapr_tce_table *stt;
 
-	list_for_each_entry(stt, &kvm->arch.spapr_tce_tables, list) {
+	list_for_each_entry_rcu_notrace(stt, &kvm->arch.spapr_tce_tables,
+			list) {
 		if (stt->liobn == liobn) {
 			unsigned long idx = ioba >> SPAPR_TCE_SHIFT;
 			struct page *page;
-- 
2.0.0
