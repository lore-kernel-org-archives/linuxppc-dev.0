Return-Path: <aik@ozlabs.ru>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0BEBF1A2C73
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2015 20:51:04 +1000 (AEST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Tue, 15 Sep 2015 20:51:01 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id A4B913578052
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2015 20:50:58 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8FAoqwb49676524
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2015 20:51:00 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8FAoQoC028826
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2015 20:50:26 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Paul Mackerras <paulus@samba.org>,
 Alexander Graf <agraf@suse.com>,
 David Gibson <david@gibson.dropbear.id.au>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
Subject: [PATCH kernel 4/9] KVM: PPC: Use RCU for arch.spapr_tce_tables
Date: Tue, 15 Sep 2015 20:49:34 +1000
Message-Id: <1442314179-9706-5-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1442314179-9706-1-git-send-email-aik@ozlabs.ru>
References: <1442314179-9706-1-git-send-email-aik@ozlabs.ru>
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
 arch/powerpc/include/asm/kvm_host.h |  1 +
 arch/powerpc/kvm/book3s.c           |  2 +-
 arch/powerpc/kvm/book3s_64_vio.c    | 20 +++++++++++---------
 3 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 98eebbf6..e19d412 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -178,6 +178,7 @@ struct kvmppc_spapr_tce_table {
 	struct kvm *kvm;
 	u64 liobn;
 	u32 window_size;
+	struct rcu_head rcu;
 	struct page *pages[0];
 };
 
diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
index 53285d5..3418f7c 100644
--- a/arch/powerpc/kvm/book3s.c
+++ b/arch/powerpc/kvm/book3s.c
@@ -806,7 +806,7 @@ int kvmppc_core_init_vm(struct kvm *kvm)
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
 
-- 
2.4.0.rc3.8.gfb3e7d5
