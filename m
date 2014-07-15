Return-Path: <aik@ozlabs.ru>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 35E751A01B6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:25:47 +1000 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Tue, 15 Jul 2014 19:25:46 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 50BEC357804F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:25:43 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6F98uIl262560
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:08:57 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6F9PgY7022429
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:25:42 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v1 11/13] KVM: PPC: Associate IOMMU group with guest copy of
 TCE table
Date: Tue, 15 Jul 2014 19:25:31 +1000
Message-Id: <1405416333-12477-12-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1405416333-12477-1-git-send-email-aik@ozlabs.ru>
References: <1405416333-12477-1-git-send-email-aik@ozlabs.ru>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Paul Mackerras <paulus@samba.org>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
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

This adds iommu_group* and iommu_table* pointers to kvmppc_spapr_tce_table.

This adds kvm_spapr_tce_attach_iommu_group() helper to initialize
the pointers.

This puts the group when guest copy of TCE table is destroyed which
happens when TCE table fd is closed.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/include/asm/kvm_host.h |  2 ++
 arch/powerpc/include/asm/kvm_ppc.h  |  5 +++++
 arch/powerpc/kvm/book3s_64_vio.c    | 28 ++++++++++++++++++++++++++++
 3 files changed, 35 insertions(+)

diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 8a3b465..8d8eee9 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -184,6 +184,8 @@ struct kvmppc_spapr_tce_table {
 	u32 page_shift;
 	u64 offset;		/* in pages */
 	u64 size;		/* in pages */
+	struct iommu_table *tbl;
+	struct iommu_group *refgrp;/* reference counting only */
 	struct page *pages[0];
 };
 
diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
index 86f5015..92be7f5 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -129,6 +129,11 @@ extern int kvmppc_spapr_tce_init(struct kvm_vcpu *vcpu);
 extern void kvmppc_spapr_tce_free(struct kvm_vcpu *vcpu);
 extern void kvmppc_iommu_hugepages_init(struct kvm_arch *ka);
 extern void kvmppc_iommu_hugepages_cleanup(struct kvm_arch *ka);
+struct iommu_group;
+extern long kvm_spapr_tce_attach_iommu_group(struct kvm *kvm,
+				unsigned long liobn,
+				phys_addr_t start_addr,
+				struct iommu_group *grp);
 extern long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
 				struct kvm_create_spapr_tce_64 *args);
 extern struct kvmppc_spapr_tce_table *kvmppc_find_tce_table(
diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_64_vio.c
index 573fd6d..b7de38e 100644
--- a/arch/powerpc/kvm/book3s_64_vio.c
+++ b/arch/powerpc/kvm/book3s_64_vio.c
@@ -28,6 +28,7 @@
 #include <linux/hugetlb.h>
 #include <linux/list.h>
 #include <linux/anon_inodes.h>
+#include <linux/iommu.h>
 
 #include <asm/tlbflush.h>
 #include <asm/kvm_ppc.h>
@@ -205,6 +206,10 @@ static void release_spapr_tce_table(struct kvmppc_spapr_tce_table *stt)
 
 	mutex_lock(&kvm->lock);
 	list_del(&stt->list);
+
+	if (stt->refgrp)
+		iommu_group_put(stt->refgrp);
+
 	for (i = 0; i < npages; i++)
 		__free_page(stt->pages[i]);
 
@@ -253,6 +258,29 @@ static const struct file_operations kvm_spapr_tce_fops = {
 	.release	= kvm_spapr_tce_release,
 };
 
+extern long kvm_spapr_tce_attach_iommu_group(struct kvm *kvm,
+				unsigned long liobn,
+				phys_addr_t start_addr,
+				struct iommu_group *grp)
+{
+	struct kvmppc_spapr_tce_table *stt = NULL;
+
+	/* Check this LIOBN hasn't been previously allocated */
+	list_for_each_entry(stt, &kvm->arch.spapr_tce_tables, list) {
+		if (stt->liobn == liobn) {
+			struct spapr_tce_iommu_group *data;
+
+			data = iommu_group_get_iommudata(grp);
+			BUG_ON(!data);
+			stt->tbl = data->ops->get_table(data, start_addr);
+			stt->refgrp = grp;
+			return 0;
+		}
+	}
+
+	return -ENODEV;
+}
+
 long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
 				   struct kvm_create_spapr_tce_64 *args)
 {
-- 
2.0.0
