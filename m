Return-Path: <aik@ozlabs.ru>
Received: from mail-gg0-x231.google.com (mail-gg0-x231.google.com
 [IPv6:2607:f8b0:4002:c02::231])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 462272C09F0
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 May 2013 17:26:44 +1000 (EST)
Received: by mail-gg0-f177.google.com with SMTP id j5so602789ggn.36
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 May 2013 00:26:41 -0700 (PDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 6/6] KVM: PPC: Add hugepage support for IOMMU in-kernel
 handling
Date: Mon,  6 May 2013 17:25:57 +1000
Message-Id: <1367825157-27231-7-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1367825157-27231-1-git-send-email-aik@ozlabs.ru>
References: <1367825157-27231-1-git-send-email-aik@ozlabs.ru>
Cc: kvm@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alexander Graf <agraf@suse.de>, kvm-ppc@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, Joerg Roedel <joerg.roedel@amd.com>,
 David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This adds special support for huge pages (16MB).  The reference
counting cannot be easily done for such pages in real mode (when
MMU is off) so we added a list of huge pages.  It is populated in
virtual mode and get_page is called just once per a huge page.
Real mode handlers check if the requested page is huge and in the list,
then no reference counting is done, otherwise an exit to virtual mode
happens.  The list is released at KVM exit.  At the moment the fastest
card available for tests uses up to 9 huge pages so walking through this
list is not very expensive.  However this can change and we may want
to optimize this.

Cc: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/include/asm/kvm_host.h |    2 +
 arch/powerpc/include/asm/kvm_ppc.h  |   24 +++++++++++
 arch/powerpc/kvm/book3s_64_vio.c    |   79 ++++++++++++++++++++++++++++++++++-
 arch/powerpc/kvm/book3s_64_vio_hv.c |   47 ++++++++++++++++++++-
 4 files changed, 149 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 2b70cbc..b6a047e 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -180,6 +180,8 @@ struct kvmppc_spapr_tce_table {
 	u32 window_size;
 	bool virtmode_only;
 	struct iommu_group *grp;    /* used for IOMMU groups */
+	struct list_head hugepages; /* used for IOMMU groups */
+	spinlock_t hugepages_lock;  /* used for IOMMU groups */
 	struct page *pages[0];
 };
 
diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
index bdfa140..3c95464 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -154,6 +154,30 @@ extern long kvmppc_virtmode_h_put_tce_indirect(struct kvm_vcpu *vcpu,
 extern long kvmppc_virtmode_h_stuff_tce(struct kvm_vcpu *vcpu,
 		unsigned long liobn, unsigned long ioba,
 		unsigned long tce_value, unsigned long npages);
+
+/*
+ * The KVM guest can be backed with 16MB pages (qemu switch
+ * -mem-path /var/lib/hugetlbfs/global/pagesize-16MB/).
+ * In this case, we cannot do page counting from the real mode
+ * as the compound pages are used - they are linked in a list
+ * with pointers as virtual addresses which are inaccessible
+ * in real mode.
+ *
+ * The code below keeps a 16MB pages list and uses page struct
+ * in real mode if it is already locked in RAM and inserted into
+ * the list or switches to the virtual mode where it can be
+ * handled in a usual manner.
+ */
+struct iommu_kvmppc_hugepage {
+	struct list_head list;
+	pte_t pte;		/* Huge page PTE */
+	unsigned long pa;	/* Base phys address used as a real TCE */
+	struct page *page;	/* page struct of the very first subpage */
+	unsigned long size;	/* Huge page size (always 16MB at the moment) */
+};
+extern struct iommu_kvmppc_hugepage *kvmppc_iommu_hugepage_find(
+		struct kvmppc_spapr_tce_table *tt, pte_t pte);
+
 extern long kvm_vm_ioctl_allocate_rma(struct kvm *kvm,
 				struct kvm_allocate_rma *rma);
 extern struct kvmppc_linear_info *kvm_alloc_rma(void);
diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_64_vio.c
index 98cf949..274458d 100644
--- a/arch/powerpc/kvm/book3s_64_vio.c
+++ b/arch/powerpc/kvm/book3s_64_vio.c
@@ -54,6 +54,59 @@ static bool kvmppc_tce_virt_only = false;
 module_param_named(virt_only, kvmppc_tce_virt_only, bool, S_IRUGO | S_IWUSR);
 MODULE_PARM_DESC(virt_only, "Disable realmode handling of IOMMU map/unmap");
 
+#ifdef CONFIG_IOMMU_API
+/*
+ * Adds a new huge page descriptor to the list.
+ */
+static struct iommu_kvmppc_hugepage *kvmppc_iommu_hugepage_add(
+		struct kvmppc_spapr_tce_table *tt,
+		pte_t pte, unsigned long va, unsigned long pg_size)
+{
+	int ret;
+	struct iommu_kvmppc_hugepage *hp;
+	struct page *p;
+
+	va = va & ~(pg_size - 1);
+	ret = get_user_pages_fast(va, 1, true/*write*/, &p);
+	if ((ret != 1) || !p)
+		return NULL;
+
+	hp = kzalloc(sizeof(*hp), GFP_KERNEL);
+	if (!hp)
+		return NULL;
+
+	hp->page = p;
+	hp->pte = pte;
+	hp->pa = __pa((unsigned long) page_address(hp->page));
+	hp->size = pg_size;
+
+	spin_lock(&tt->hugepages_lock);
+	list_add(&hp->list, &tt->hugepages);
+	spin_unlock(&tt->hugepages_lock);
+
+	return hp;
+}
+
+static void kvmppc_iommu_hugepages_init(struct kvmppc_spapr_tce_table *tt)
+{
+	INIT_LIST_HEAD(&tt->hugepages);
+	spin_lock_init(&tt->hugepages_lock);
+}
+
+static void kvmppc_iommu_hugepages_cleanup(struct kvmppc_spapr_tce_table *tt)
+{
+	struct iommu_kvmppc_hugepage *hp, *tmp;
+
+	spin_lock(&tt->hugepages_lock);
+	list_for_each_entry_safe(hp, tmp, &tt->hugepages, list) {
+		list_del(&hp->list);
+		put_page(hp->page);
+		kfree(hp);
+	}
+	spin_unlock(&tt->hugepages_lock);
+}
+#endif /* CONFIG_IOMMU_API */
+
 /*
  * TCE tables handlers.
  */
@@ -73,6 +126,7 @@ static void release_spapr_tce_table(struct kvmppc_spapr_tce_table *stt)
 #ifdef CONFIG_IOMMU_API
 	if (stt->grp) {
 		iommu_group_put(stt->grp);
+		kvmppc_iommu_hugepages_cleanup(stt);
 	} else
 #endif
 		for (i = 0; i < kvmppc_stt_npages(stt->window_size); i++)
@@ -211,6 +265,7 @@ long kvm_vm_ioctl_create_spapr_tce_iommu(struct kvm *kvm,
 	kvm_get_kvm(kvm);
 
 	mutex_lock(&kvm->lock);
+	kvmppc_iommu_hugepages_init(tt);
 	list_add(&tt->list, &kvm->arch.spapr_tce_tables);
 
 	mutex_unlock(&kvm->lock);
@@ -259,6 +314,8 @@ static int put_tce_virt_mode(struct kvmppc_spapr_tce_table *tt,
 {
 	int ret;
 	unsigned long entry = ioba >> IOMMU_PAGE_SHIFT;
+	struct iommu_kvmppc_hugepage *hp;
+	enum dma_data_direction direction = iommu_tce_direction(tce);
 
 	ret = iommu_tce_put_param_check(tbl, ioba, tce);
 	if (ret)
@@ -268,7 +325,27 @@ static int put_tce_virt_mode(struct kvmppc_spapr_tce_table *tt,
 	if (pg_size == PAGE_SIZE)
 		return iommu_put_tce_user_mode(tbl, entry, tce);
 
-	return -EAGAIN;
+	/*
+	 * Hugepages case - manage the hugepage list.
+	 * kvmppc_iommu_hugepage_find() may find a huge page if called
+	 * from h_put_tce_indirect call.
+	 */
+	hp = kvmppc_iommu_hugepage_find(tt, pte);
+	if (!hp) {
+		/* This is the first time usage of this huge page */
+		hp = kvmppc_iommu_hugepage_add(tt, pte, tce, pg_size);
+		if (!hp)
+			return -EFAULT;
+	}
+
+	tce = (unsigned long) __va(hp->pa) + (tce & (pg_size - 1));
+
+	ret = iommu_tce_build(tbl, entry, tce, direction);
+	if (ret < 0)
+		pr_err("iommu_tce: %s failed ioba=%lx, tce=%lx, ret=%d\n",
+				__func__, ioba, tce, ret);
+
+	return ret;
 }
 
 static pte_t va_to_linux_pte(struct kvm_vcpu *vcpu,
diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/book3s_64_vio_hv.c
index c5e5905..a91ff7b 100644
--- a/arch/powerpc/kvm/book3s_64_vio_hv.c
+++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
@@ -43,6 +43,29 @@
 #define TCES_PER_PAGE	(PAGE_SIZE / sizeof(u64))
 #define ERROR_ADDR      (~(unsigned long)0x0)
 
+#ifdef CONFIG_IOMMU_API
+/*
+ * Huge pages trick helper.
+ */
+struct iommu_kvmppc_hugepage *kvmppc_iommu_hugepage_find(
+		struct kvmppc_spapr_tce_table *tt, pte_t pte)
+{
+	struct iommu_kvmppc_hugepage *hp, *ret = NULL;
+
+	spin_lock(&tt->hugepages_lock);
+	list_for_each_entry(hp, &tt->hugepages, list) {
+		if (hp->pte == pte) {
+			ret = hp;
+			break;
+		}
+	}
+	spin_unlock(&tt->hugepages_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(kvmppc_iommu_hugepage_find);
+#endif /* CONFIG_IOMMU_API */
+
 /*
  * Finds a TCE table descriptor by LIOBN.
  */
@@ -191,6 +214,15 @@ static int clear_tce_real_mode(struct iommu_table *tbl,
 		if (oldtce & TCE_PCI_WRITE)
 			SetPageDirty(page);
 
+		/*
+		 * As get_page is called only once on a HUGE page,
+		 * and it is done in virtual mode,
+		 * we do not release it here, instead we postpone it
+		 * till the KVM exit.
+		 */
+		if (PageCompound(page))
+			continue;
+
 		ret = realmode_put_page(page);
 		if (ret)
 			break;
@@ -210,14 +242,25 @@ static int put_tce_real_mode(struct kvmppc_spapr_tce_table *tt,
 	int ret;
 	unsigned long entry = ioba >> IOMMU_PAGE_SHIFT;
 	struct page *page = NULL;
+	struct iommu_kvmppc_hugepage *hp = NULL;
 	enum dma_data_direction direction = iommu_tce_direction(tce);
 
 	ret = iommu_tce_put_param_check(tbl, ioba, tce);
 	if (ret)
 		return ret;
 
-	if (pg_size != PAGE_SIZE)
-		return -EAGAIN;
+	/* This is a huge page. we continue only if it is already in the list */
+	if (pg_size != PAGE_SIZE) {
+		hp = kvmppc_iommu_hugepage_find(tt, pte);
+
+		/* Go to virtual mode to add a hugepage to the list if not found */
+		if (!hp)
+			return -EAGAIN;
+
+		/* tce_build receives a kernel virtual addresses */
+		return iommu_tce_build(tbl, entry, (unsigned long) __va(tce),
+				direction);
+	}
 
 	/* Small page case, find page struct to increment a counter */
 	page = realmode_pfn_to_page(tce >> PAGE_SHIFT);
-- 
1.7.10.4
