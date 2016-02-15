Return-Path: <aik@ozlabs.ru>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2DBC01A004E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Feb 2016 12:56:23 +1100 (AEDT)
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Mon, 15 Feb 2016 11:56:22 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id D16E62CE805E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Feb 2016 12:56:15 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1F1u6cQ3146140
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Feb 2016 12:56:15 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1F1tgoX006491
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Feb 2016 12:55:42 +1100
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Alexander Graf <agraf@suse.com>,
 Paul Mackerras <paulus@samba.org>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
Subject: [PATCH kernel v3 3/7] KVM: PPC: Use RCU for arch.spapr_tce_tables
Date: Mon, 15 Feb 2016 12:55:05 +1100
Message-Id: <1455501309-47200-4-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1455501309-47200-1-git-send-email-aik@ozlabs.ru>
References: <1455501309-47200-1-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

At the moment only spapr_tce_tables updates are protected against races
but not lookups. This fixes missing protection by using RCU for the list.
As lookups also happen in real mode, this uses
list_for_each_entry_lockless() (which is expected not to access any
vmalloc'd memory).

This converts release_spapr_tce_table() to a RCU scheduled handler.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
---
Changes:
v3:
* moved list_for_each_entry_lockless() from the previous patch here
* clarified in the commit what is and what is not protected against races
---
 arch/powerpc/include/asm/kvm_host.h |  1 +
 arch/powerpc/kvm/book3s.c           |  2 +-
 arch/powerpc/kvm/book3s_64_vio.c    | 20 +++++++++++---------
 arch/powerpc/kvm/book3s_64_vio_hv.c |  2 +-
 4 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 9d08d8c..ffdbc2d 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -183,6 +183,7 @@ struct kvmppc_spapr_tce_table {
 	struct kvm *kvm;
 	u64 liobn;
 	u32 window_size;
+	struct rcu_head rcu;
 	struct page *pages[0];
 };
 
diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
index 638c6d9..b34220d 100644
--- a/arch/powerpc/kvm/book3s.c
+++ b/arch/powerpc/kvm/book3s.c
@@ -807,7 +807,7 @@ int kvmppc_core_init_vm(struct kvm *kvm)
 {
 
 #ifdef CONFIG_PPC64
-	INIT_LIST_HEAD(&kvm->arch.spapr_tce_tables);
+	INIT_LIST_HEAD_RCU(&kvm->arch.spapr_tce_tables);
 	INIT_LIST_HEAD(&kvm->arch.rtas_tokens);
 #endif
 
diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_64_vio.c
index 54cf9bc..9526c34 100644
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
+
 	kfree(stt);
-	mutex_unlock(&kvm->lock);
-
-	kvm_put_kvm(kvm);
 }
 
 static int kvm_spapr_tce_fault(struct vm_area_struct *vma, struct vm_fault *vmf)
@@ -88,7 +85,12 @@ static int kvm_spapr_tce_release(struct inode *inode, struct file *filp)
 {
 	struct kvmppc_spapr_tce_table *stt = filp->private_data;
 
-	release_spapr_tce_table(stt);
+	list_del_rcu(&stt->list);
+
+	kvm_put_kvm(stt->kvm);
+
+	call_rcu(&stt->rcu, release_spapr_tce_table);
+
 	return 0;
 }
 
@@ -131,7 +133,7 @@ long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
 	kvm_get_kvm(kvm);
 
 	mutex_lock(&kvm->lock);
-	list_add(&stt->list, &kvm->arch.spapr_tce_tables);
+	list_add_rcu(&stt->list, &kvm->arch.spapr_tce_tables);
 
 	mutex_unlock(&kvm->lock);
 
diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/book3s_64_vio_hv.c
index f29ba2c..124d692 100644
--- a/arch/powerpc/kvm/book3s_64_vio_hv.c
+++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
@@ -51,7 +51,7 @@ static struct kvmppc_spapr_tce_table *kvmppc_find_table(struct kvm_vcpu *vcpu,
 	struct kvm *kvm = vcpu->kvm;
 	struct kvmppc_spapr_tce_table *stt;
 
-	list_for_each_entry(stt, &kvm->arch.spapr_tce_tables, list)
+	list_for_each_entry_lockless(stt, &kvm->arch.spapr_tce_tables, list)
 		if (stt->liobn == liobn)
 			return stt;
 
-- 
2.5.0.rc3
