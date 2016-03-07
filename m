Return-Path: <aik@ozlabs.ru>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8B2201A038E
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Mar 2016 14:42:44 +1100 (AEDT)
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Mon, 7 Mar 2016 13:42:42 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 73EEA2CE805C
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Mar 2016 14:42:39 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u273gVNf5702068
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Mar 2016 14:42:39 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u273g7Fm028560
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Mar 2016 14:42:07 +1100
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Paul Mackerras <paulus@samba.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
Subject: [PATCH kernel 6/9] KVM: PPC: Associate IOMMU group with guest view of
 TCE table
Date: Mon,  7 Mar 2016 14:41:14 +1100
Message-Id: <1457322077-26640-7-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1457322077-26640-1-git-send-email-aik@ozlabs.ru>
References: <1457322077-26640-1-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The existing in-kernel TCE table for emulated devices contains
guest physical addresses which are accesses by emulated devices.
Since we need to keep this information for VFIO devices too
in order to implement H_GET_TCE, we are reusing it.

This adds IOMMU group list to kvmppc_spapr_tce_table. Each group
will have an iommu_table pointer.

This adds kvm_spapr_tce_attach_iommu_group() helper and its detach
counterpart to manage the lists.

This puts a group when:
- guest copy of TCE table is destroyed when TCE table fd is closed;
- kvm_spapr_tce_detach_iommu_group() is called from
the KVM_DEV_VFIO_GROUP_DEL ioctl handler in the case vfio-pci hotunplug
(will be added in the following patch).

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/include/asm/kvm_host.h |   8 +++
 arch/powerpc/include/asm/kvm_ppc.h  |   6 ++
 arch/powerpc/kvm/book3s_64_vio.c    | 108 ++++++++++++++++++++++++++++++++++++
 3 files changed, 122 insertions(+)

diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 2e7c791..2c5c823 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -178,6 +178,13 @@ struct kvmppc_pginfo {
 	atomic_t refcnt;
 };
 
+struct kvmppc_spapr_tce_group {
+	struct list_head next;
+	struct rcu_head rcu;
+	struct iommu_group *refgrp;/* for reference counting only */
+	struct iommu_table *tbl;
+};
+
 struct kvmppc_spapr_tce_table {
 	struct list_head list;
 	struct kvm *kvm;
@@ -186,6 +193,7 @@ struct kvmppc_spapr_tce_table {
 	u32 page_shift;
 	u64 offset;		/* in pages */
 	u64 size;		/* window size in pages */
+	struct list_head groups;
 	struct page *pages[0];
 };
 
diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
index 2544eda..d1482dc 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -164,6 +164,12 @@ extern void kvmppc_map_vrma(struct kvm_vcpu *vcpu,
 			struct kvm_memory_slot *memslot, unsigned long porder);
 extern int kvmppc_pseries_do_hcall(struct kvm_vcpu *vcpu);
 
+extern long kvm_spapr_tce_attach_iommu_group(struct kvm *kvm,
+				unsigned long liobn,
+				phys_addr_t start_addr,
+				struct iommu_group *grp);
+extern void kvm_spapr_tce_detach_iommu_group(struct kvm *kvm,
+				struct iommu_group *grp);
 extern long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
 				struct kvm_create_spapr_tce_64 *args);
 extern struct kvmppc_spapr_tce_table *kvmppc_find_table(
diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_64_vio.c
index 2c2d103..846d16d 100644
--- a/arch/powerpc/kvm/book3s_64_vio.c
+++ b/arch/powerpc/kvm/book3s_64_vio.c
@@ -27,6 +27,7 @@
 #include <linux/hugetlb.h>
 #include <linux/list.h>
 #include <linux/anon_inodes.h>
+#include <linux/iommu.h>
 
 #include <asm/tlbflush.h>
 #include <asm/kvm_ppc.h>
@@ -95,10 +96,18 @@ static void release_spapr_tce_table(struct rcu_head *head)
 	struct kvmppc_spapr_tce_table *stt = container_of(head,
 			struct kvmppc_spapr_tce_table, rcu);
 	unsigned long i, npages = kvmppc_tce_pages(stt->size);
+	struct kvmppc_spapr_tce_group *kg;
 
 	for (i = 0; i < npages; i++)
 		__free_page(stt->pages[i]);
 
+	while (!list_empty(&stt->groups)) {
+		kg = list_first_entry(&stt->groups,
+				struct kvmppc_spapr_tce_group, next);
+		list_del(&kg->next);
+		kfree(kg);
+	}
+
 	kfree(stt);
 }
 
@@ -129,9 +138,15 @@ static int kvm_spapr_tce_mmap(struct file *file, struct vm_area_struct *vma)
 static int kvm_spapr_tce_release(struct inode *inode, struct file *filp)
 {
 	struct kvmppc_spapr_tce_table *stt = filp->private_data;
+	struct kvmppc_spapr_tce_group *kg;
 
 	list_del_rcu(&stt->list);
 
+	list_for_each_entry_rcu(kg, &stt->groups, next)	{
+		iommu_group_put(kg->refgrp);
+		kg->refgrp = NULL;
+	}
+
 	kvm_put_kvm(stt->kvm);
 
 	kvmppc_account_memlimit(
@@ -146,6 +161,98 @@ static const struct file_operations kvm_spapr_tce_fops = {
 	.release	= kvm_spapr_tce_release,
 };
 
+extern long kvm_spapr_tce_attach_iommu_group(struct kvm *kvm,
+				unsigned long liobn,
+				phys_addr_t start_addr,
+				struct iommu_group *grp)
+{
+	struct kvmppc_spapr_tce_table *stt = NULL;
+	struct iommu_table_group *table_group;
+	long i;
+	bool found = false;
+	struct kvmppc_spapr_tce_group *kg;
+	struct iommu_table *tbltmp;
+
+	/* Check this LIOBN hasn't been previously allocated */
+	list_for_each_entry_rcu(stt, &kvm->arch.spapr_tce_tables, list) {
+		if (stt->liobn == liobn) {
+			if ((stt->offset << stt->page_shift) != start_addr)
+				return -EINVAL;
+
+			found = true;
+			break;
+		}
+	}
+
+	if (!found)
+		return -ENODEV;
+
+	/* Find IOMMU group and table at @start_addr */
+	table_group = iommu_group_get_iommudata(grp);
+	if (!table_group)
+		return -EFAULT;
+
+	tbltmp = NULL;
+	for (i = 0; i < IOMMU_TABLE_GROUP_MAX_TABLES; ++i) {
+		struct iommu_table *tbl = table_group->tables[i];
+
+		if (!tbl)
+			continue;
+
+		if ((tbl->it_page_shift == stt->page_shift) &&
+				(tbl->it_offset == stt->offset)) {
+			tbltmp = tbl;
+			break;
+		}
+	}
+	if (!tbltmp)
+		return -ENODEV;
+
+	list_for_each_entry_rcu(kg, &stt->groups, next) {
+		if (kg->refgrp == grp)
+			return -EBUSY;
+	}
+
+	kg = kzalloc(sizeof(*kg), GFP_KERNEL);
+	kg->refgrp = grp;
+	kg->tbl = tbltmp;
+	list_add_rcu(&kg->next, &stt->groups);
+
+	return 0;
+}
+
+static void kvm_spapr_tce_put_group(struct rcu_head *head)
+{
+	struct kvmppc_spapr_tce_group *kg = container_of(head,
+			struct kvmppc_spapr_tce_group, rcu);
+
+	iommu_group_put(kg->refgrp);
+	kg->refgrp = NULL;
+	kfree(kg);
+}
+
+extern void kvm_spapr_tce_detach_iommu_group(struct kvm *kvm,
+				struct iommu_group *grp)
+{
+	struct kvmppc_spapr_tce_table *stt;
+	struct iommu_table_group *table_group;
+	struct kvmppc_spapr_tce_group *kg;
+
+	table_group = iommu_group_get_iommudata(grp);
+	if (!table_group)
+		return;
+
+	list_for_each_entry_rcu(stt, &kvm->arch.spapr_tce_tables, list) {
+		list_for_each_entry_rcu(kg, &stt->groups, next) {
+			if (kg->refgrp == grp) {
+				list_del_rcu(&kg->next);
+				call_rcu(&kg->rcu, kvm_spapr_tce_put_group);
+				break;
+			}
+		}
+	}
+}
+
 long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
 				   struct kvm_create_spapr_tce_64 *args)
 {
@@ -181,6 +288,7 @@ long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
 	stt->offset = args->offset;
 	stt->size = size;
 	stt->kvm = kvm;
+	INIT_LIST_HEAD_RCU(&stt->groups);
 
 	for (i = 0; i < npages; i++) {
 		stt->pages[i] = alloc_page(GFP_KERNEL | __GFP_ZERO);
-- 
2.5.0.rc3
