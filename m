Return-Path: <aik@ozlabs.ru>
Received: from mail-yh0-x22c.google.com (mail-yh0-x22c.google.com
 [IPv6:2607:f8b0:4002:c01::22c])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0EE982C0531
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 May 2013 17:26:38 +1000 (EST)
Received: by mail-yh0-f44.google.com with SMTP id b41so681258yha.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 May 2013 00:26:36 -0700 (PDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 5/6] KVM: PPC: Add support for IOMMU in-kernel handling
Date: Mon,  6 May 2013 17:25:56 +1000
Message-Id: <1367825157-27231-6-git-send-email-aik@ozlabs.ru>
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

This allows the host kernel to handle H_PUT_TCE, H_PUT_TCE_INDIRECT
and H_STUFF_TCE requests without passing them to QEMU, which should
save time on switching to QEMU and back.

Both real and virtual modes are supported - whenever the kernel
fails to handle TCE request, it passes it to the virtual mode.
If it the virtual mode handlers fail, then the request is passed
to the user mode, for example, to QEMU.

This adds a new KVM_CAP_SPAPR_TCE_IOMMU ioctl to asssociate
a virtual PCI bus ID (LIOBN) with an IOMMU group, which enables
in-kernel handling of IOMMU map/unmap.

This adds a special case for huge pages (16MB).  The reference
counting cannot be easily done for such pages in real mode (when
MMU is off) so we added a list of huge pages.  It is populated in
virtual mode and get_page is called just once per a huge page.
Real mode handlers check if the requested page is huge and in the list,
then no reference counting is done, otherwise an exit to virtual mode
happens.  The list is released at KVM exit.  At the moment the fastest
card available for tests uses up to 9 huge pages so walking through this
list is not very expensive.  However this can change and we may want
to optimize this.

This also adds the virt_only parameter to the KVM module
for debug and performance check purposes.

Tests show that this patch increases transmission speed from 220MB/s
to 750..1020MB/s on 10Gb network (Chelsea CXGB3 10Gb ethernet card).

Cc: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 Documentation/virtual/kvm/api.txt   |   28 ++++
 arch/powerpc/include/asm/kvm_host.h |    2 +
 arch/powerpc/include/asm/kvm_ppc.h  |    2 +
 arch/powerpc/include/uapi/asm/kvm.h |    7 +
 arch/powerpc/kvm/book3s_64_vio.c    |  242 ++++++++++++++++++++++++++++++++++-
 arch/powerpc/kvm/book3s_64_vio_hv.c |  192 +++++++++++++++++++++++++++
 arch/powerpc/kvm/powerpc.c          |   12 ++
 include/uapi/linux/kvm.h            |    2 +
 8 files changed, 485 insertions(+), 2 deletions(-)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index f621cd6..2039767 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -2127,6 +2127,34 @@ written, then `n_invalid' invalid entries, invalidating any previously
 valid entries found.
 
 
+4.79 KVM_CREATE_SPAPR_TCE_IOMMU
+
+Capability: KVM_CAP_SPAPR_TCE_IOMMU
+Architectures: powerpc
+Type: vm ioctl
+Parameters: struct kvm_create_spapr_tce_iommu (in)
+Returns: 0 on success, -1 on error
+
+This creates a link between IOMMU group and a hardware TCE (translation
+control entry) table. This link lets the host kernel know what IOMMU
+group (i.e. TCE table) to use for the LIOBN number passed with
+H_PUT_TCE, H_PUT_TCE_INDIRECT, H_STUFF_TCE hypercalls.
+
+/* for KVM_CAP_SPAPR_TCE_IOMMU */
+struct kvm_create_spapr_tce_iommu {
+	__u64 liobn;
+	__u32 iommu_id;
+	__u32 flags;
+};
+
+No flag is supported at the moment.
+
+When the guest issues TCE call on a liobn for which a TCE table has been
+registered, the kernel will handle it in real mode, updating the hardware
+TCE table. TCE table calls for other liobns will cause a vm exit and must
+be handled by userspace.
+
+
 5. The kvm_run structure
 ------------------------
 
diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 36ceb0d..2b70cbc 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -178,6 +178,8 @@ struct kvmppc_spapr_tce_table {
 	struct kvm *kvm;
 	u64 liobn;
 	u32 window_size;
+	bool virtmode_only;
+	struct iommu_group *grp;    /* used for IOMMU groups */
 	struct page *pages[0];
 };
 
diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
index d501246..bdfa140 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -139,6 +139,8 @@ extern void kvmppc_xics_free(struct kvm *kvm);
 
 extern long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
 				struct kvm_create_spapr_tce *args);
+extern long kvm_vm_ioctl_create_spapr_tce_iommu(struct kvm *kvm,
+				struct kvm_create_spapr_tce_iommu *args);
 extern struct kvmppc_spapr_tce_table *kvmppc_find_tce_table(
 		struct kvm_vcpu *vcpu, unsigned long liobn);
 extern long kvmppc_emulated_h_put_tce(struct kvmppc_spapr_tce_table *stt,
diff --git a/arch/powerpc/include/uapi/asm/kvm.h b/arch/powerpc/include/uapi/asm/kvm.h
index 681b314..b67d44b 100644
--- a/arch/powerpc/include/uapi/asm/kvm.h
+++ b/arch/powerpc/include/uapi/asm/kvm.h
@@ -291,6 +291,13 @@ struct kvm_create_spapr_tce {
 	__u32 window_size;
 };
 
+/* for KVM_CAP_SPAPR_TCE_IOMMU */
+struct kvm_create_spapr_tce_iommu {
+	__u64 liobn;
+	__u32 iommu_id;
+	__u32 flags;
+};
+
 /* for KVM_ALLOCATE_RMA */
 struct kvm_allocate_rma {
 	__u64 rma_size;
diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_64_vio.c
index 643ac1e..98cf949 100644
--- a/arch/powerpc/kvm/book3s_64_vio.c
+++ b/arch/powerpc/kvm/book3s_64_vio.c
@@ -27,6 +27,9 @@
 #include <linux/hugetlb.h>
 #include <linux/list.h>
 #include <linux/anon_inodes.h>
+#include <linux/pci.h>
+#include <linux/iommu.h>
+#include <linux/module.h>
 
 #include <asm/tlbflush.h>
 #include <asm/kvm_ppc.h>
@@ -38,10 +41,19 @@
 #include <asm/kvm_host.h>
 #include <asm/udbg.h>
 #include <asm/iommu.h>
+#include <asm/tce.h>
+
+#define DRIVER_VERSION	"0.1"
+#define DRIVER_AUTHOR	"Paul Mackerras, IBM Corp. <paulus@au1.ibm.com>"
+#define DRIVER_DESC	"POWERPC KVM driver"
 
 #define TCES_PER_PAGE	(PAGE_SIZE / sizeof(u64))
 #define ERROR_ADDR      (~(unsigned long)0x0)
 
+static bool kvmppc_tce_virt_only = false;
+module_param_named(virt_only, kvmppc_tce_virt_only, bool, S_IRUGO | S_IWUSR);
+MODULE_PARM_DESC(virt_only, "Disable realmode handling of IOMMU map/unmap");
+
 /*
  * TCE tables handlers.
  */
@@ -58,8 +70,13 @@ static void release_spapr_tce_table(struct kvmppc_spapr_tce_table *stt)
 
 	mutex_lock(&kvm->lock);
 	list_del(&stt->list);
-	for (i = 0; i < kvmppc_stt_npages(stt->window_size); i++)
-		__free_page(stt->pages[i]);
+#ifdef CONFIG_IOMMU_API
+	if (stt->grp) {
+		iommu_group_put(stt->grp);
+	} else
+#endif
+		for (i = 0; i < kvmppc_stt_npages(stt->window_size); i++)
+			__free_page(stt->pages[i]);
 	kfree(stt);
 	mutex_unlock(&kvm->lock);
 
@@ -155,9 +172,127 @@ fail:
 	return ret;
 }
 
+#ifdef CONFIG_IOMMU_API
+static const struct file_operations kvm_spapr_tce_iommu_fops = {
+	.release	= kvm_spapr_tce_release,
+};
+
+long kvm_vm_ioctl_create_spapr_tce_iommu(struct kvm *kvm,
+		struct kvm_create_spapr_tce_iommu *args)
+{
+	struct kvmppc_spapr_tce_table *tt = NULL;
+	struct iommu_group *grp;
+	struct iommu_table *tbl;
+
+	/* Find an IOMMU table for the given ID */
+	grp = iommu_group_get_by_id(args->iommu_id);
+	if (!grp)
+		return -ENXIO;
+
+	tbl = iommu_group_get_iommudata(grp);
+	if (!tbl)
+		return -ENXIO;
+
+	/* Check this LIOBN hasn't been previously allocated */
+	list_for_each_entry(tt, &kvm->arch.spapr_tce_tables, list) {
+		if (tt->liobn == args->liobn)
+			return -EBUSY;
+	}
+
+	tt = kzalloc(sizeof(*tt), GFP_KERNEL);
+	if (!tt)
+		return -ENOMEM;
+
+	tt->liobn = args->liobn;
+	tt->kvm = kvm;
+	tt->virtmode_only = kvmppc_tce_virt_only;
+	tt->grp = grp;
+
+	kvm_get_kvm(kvm);
+
+	mutex_lock(&kvm->lock);
+	list_add(&tt->list, &kvm->arch.spapr_tce_tables);
+
+	mutex_unlock(&kvm->lock);
+
+	pr_debug("LIOBN=%llX hooked to IOMMU %d, flags=%u\n",
+			args->liobn, args->iommu_id, args->flags);
+
+	return anon_inode_getfd("kvm-spapr-tce-iommu",
+			&kvm_spapr_tce_iommu_fops, tt, O_RDWR);
+}
+#else
+long kvm_vm_ioctl_create_spapr_tce_iommu(struct kvm *kvm,
+		struct kvm_create_spapr_tce_iommu *args)
+{
+	return -ENOSYS;
+}
+#endif /* CONFIG_IOMMU_API */
+
+#ifdef CONFIG_IOMMU_API
 /*
  * Virtual mode handling of IOMMU map/unmap.
  */
+static int clear_tce_virt_mode(struct iommu_table *tbl,
+		unsigned long ioba, unsigned long tce_value,
+		unsigned long npages)
+{
+	int ret;
+	unsigned long entry = ioba >> IOMMU_PAGE_SHIFT;
+
+	ret = iommu_tce_clear_param_check(tbl, ioba, tce_value, npages);
+	if (ret)
+		return ret;
+
+	ret = iommu_clear_tces_and_put_pages(tbl, entry, npages);
+	if (ret < 0)
+		pr_err("iommu_tce: %s failed ioba=%lx, tce_value=%lx ret=%d\n",
+				__func__, ioba, tce_value, ret);
+
+	return ret;
+}
+
+static int put_tce_virt_mode(struct kvmppc_spapr_tce_table *tt,
+		struct iommu_table *tbl,
+		unsigned long ioba, unsigned long tce,
+		pte_t pte, unsigned long pg_size)
+{
+	int ret;
+	unsigned long entry = ioba >> IOMMU_PAGE_SHIFT;
+
+	ret = iommu_tce_put_param_check(tbl, ioba, tce);
+	if (ret)
+		return ret;
+
+	/* System page size case, easy to handle */
+	if (pg_size == PAGE_SIZE)
+		return iommu_put_tce_user_mode(tbl, entry, tce);
+
+	return -EAGAIN;
+}
+
+static pte_t va_to_linux_pte(struct kvm_vcpu *vcpu,
+		unsigned long hva, bool writing, unsigned long *pg_sizep)
+{
+#ifdef CONFIG_KVM_BOOK3S_64_HV
+	/* Find out the page pte and size if requested */
+	pte_t pte;
+	unsigned long pg_size = 0;
+
+	pte = lookup_linux_pte(vcpu->arch.pgdir, hva,
+			writing, &pg_size);
+	if (!pte_present(pte))
+		return 0;
+
+	*pg_sizep = pg_size;
+
+	return pte;
+#else
+	return 0;
+#endif
+}
+#endif /* CONFIG_IOMMU_API */
+
 /* Converts guest physical address into host virtual */
 static unsigned long get_virt_address(struct kvm_vcpu *vcpu,
 		unsigned long gpa)
@@ -188,6 +323,43 @@ long kvmppc_virtmode_h_put_tce(struct kvm_vcpu *vcpu,
 	if (!tt)
 		return H_TOO_HARD;
 
+#ifdef CONFIG_IOMMU_API
+	if (tt->grp) {
+		long ret;
+		struct iommu_table *tbl = iommu_group_get_iommudata(tt->grp);
+
+		/* Return error if the group is being destroyed */
+		if (!tbl)
+			return H_RESCINDED;
+
+		if (tce & (TCE_PCI_READ | TCE_PCI_WRITE)) {
+			unsigned long hpa, pg_size = 0;
+			pte_t pte;
+
+			hpa = get_virt_address(vcpu, tce);
+			if (hpa == ERROR_ADDR)
+				return -EFAULT;
+
+			pte = va_to_linux_pte(vcpu, hpa, tce & TCE_PCI_WRITE,
+					&pg_size);
+			if (!pte)
+				return -EFAULT;
+
+			ret = put_tce_virt_mode(tt, tbl, ioba, hpa,
+					pte, pg_size);
+		} else {
+			ret = clear_tce_virt_mode(tbl, ioba, 0, 1);
+		}
+		iommu_flush_tce(tbl);
+
+		WARN_ON(ret == -EAGAIN);
+		if (ret < 0)
+			return H_PARAMETER;
+
+		return H_SUCCESS;
+	}
+#endif
+
 	/* Emulated IO */
 	return kvmppc_emulated_h_put_tce(tt, ioba, tce);
 }
@@ -213,6 +385,52 @@ long kvmppc_virtmode_h_put_tce_indirect(struct kvm_vcpu *vcpu,
 	if (tces == ERROR_ADDR)
 		return H_TOO_HARD;
 
+#ifdef CONFIG_IOMMU_API
+	if (tt->grp) {
+		long ret = 0;
+		struct iommu_table *tbl = iommu_group_get_iommudata(tt->grp);
+
+		/* Return error if the group is being destroyed */
+		if (!tbl)
+			return H_RESCINDED;
+
+		for (i = 0; i < npages; ++i) {
+			unsigned long hpa, pg_size = 0;
+			pte_t pte = 0;
+			unsigned long tce;
+			unsigned long ptce = tces + i * sizeof(unsigned long);
+
+			if (get_user(tce, (unsigned long __user *)ptce))
+				break;
+
+			hpa = get_virt_address(vcpu, tce);
+			if (hpa == ERROR_ADDR)
+				return -EFAULT;
+
+			pte = va_to_linux_pte(vcpu, hpa,
+					tce & TCE_PCI_WRITE, &pg_size);
+			if (!pte)
+				return -EFAULT;
+
+			ret = put_tce_virt_mode(tt, tbl,
+					ioba + (i << IOMMU_PAGE_SHIFT),
+					hpa, pte, pg_size);
+			if (ret)
+				break;
+		}
+		if (ret)
+			clear_tce_virt_mode(tbl, ioba, 0, i);
+
+		iommu_flush_tce(tbl);
+
+		WARN_ON(ret == -EAGAIN);
+		if (ret < 0)
+			return H_PARAMETER;
+
+		return H_SUCCESS;
+	}
+#endif
+
 	/* Emulated IO */
 	if ((ioba + (npages << IOMMU_PAGE_SHIFT)) > tt->window_size)
 		return H_PARAMETER;
@@ -253,6 +471,26 @@ long kvmppc_virtmode_h_stuff_tce(struct kvm_vcpu *vcpu,
 	if (!tt)
 		return H_TOO_HARD;
 
+#ifdef CONFIG_IOMMU_API
+	if (tt->grp) {
+		long ret;
+		struct iommu_table *tbl = iommu_group_get_iommudata(tt->grp);
+
+		/* Return error if the group is being destroyed */
+		if (!tbl)
+			return H_RESCINDED;
+
+		ret = clear_tce_virt_mode(tbl, ioba,
+				tce_value, npages);
+
+		WARN_ON(ret == -EAGAIN);
+		if (ret < 0)
+			return H_PARAMETER;
+
+		return H_SUCCESS;
+	}
+#endif
+
 	/* Emulated IO */
 	if ((ioba + (npages << IOMMU_PAGE_SHIFT)) > tt->window_size)
 		return H_PARAMETER;
diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/book3s_64_vio_hv.c
index 55fdf7a..c5e5905 100644
--- a/arch/powerpc/kvm/book3s_64_vio_hv.c
+++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
@@ -26,6 +26,7 @@
 #include <linux/slab.h>
 #include <linux/hugetlb.h>
 #include <linux/list.h>
+#include <linux/iommu.h>
 
 #include <asm/tlbflush.h>
 #include <asm/kvm_ppc.h>
@@ -161,6 +162,85 @@ static unsigned long get_real_address(struct kvm_vcpu *vcpu,
 	return hwaddr;
 }
 
+#ifdef CONFIG_IOMMU_API
+static int clear_tce_real_mode(struct iommu_table *tbl,
+		unsigned long ioba,
+		unsigned long tce_value, unsigned long npages)
+{
+	int ret;
+	unsigned long entry = ioba >> IOMMU_PAGE_SHIFT;
+
+	ret = iommu_tce_clear_param_check(tbl, ioba, tce_value, npages);
+	if (ret)
+		return ret;
+
+	for ( ; npages; --npages, ++entry) {
+		struct page *page;
+		unsigned long oldtce;
+
+		oldtce = iommu_clear_tce(tbl, entry);
+		if (!oldtce)
+			continue;
+
+		page = realmode_pfn_to_page(oldtce >> PAGE_SHIFT);
+		if (!page) {
+			ret = -EAGAIN;
+			break;
+		}
+
+		if (oldtce & TCE_PCI_WRITE)
+			SetPageDirty(page);
+
+		ret = realmode_put_page(page);
+		if (ret)
+			break;
+	}
+	/* if (ret < 0)
+		pr_err("iommu_tce: %s failed ioba=%lx, tce_value=%lx ret=%d\n",
+				__func__, ioba, tce_value, ret); */
+
+	return ret;
+}
+
+static int put_tce_real_mode(struct kvmppc_spapr_tce_table *tt,
+		struct iommu_table *tbl,
+		unsigned long ioba, unsigned long tce,
+		pte_t pte, unsigned long pg_size)
+{
+	int ret;
+	unsigned long entry = ioba >> IOMMU_PAGE_SHIFT;
+	struct page *page = NULL;
+	enum dma_data_direction direction = iommu_tce_direction(tce);
+
+	ret = iommu_tce_put_param_check(tbl, ioba, tce);
+	if (ret)
+		return ret;
+
+	if (pg_size != PAGE_SIZE)
+		return -EAGAIN;
+
+	/* Small page case, find page struct to increment a counter */
+	page = realmode_pfn_to_page(tce >> PAGE_SHIFT);
+	if (!page)
+		return -EAGAIN;
+
+	ret = realmode_get_page(page);
+	if (ret)
+		return ret;
+
+	/* tce_build accepts virtual addresses */
+	ret = iommu_tce_build(tbl, entry, (unsigned long) __va(tce), direction);
+	if (ret)
+		realmode_put_page(page);
+
+	/* if (ret < 0)
+		pr_err("iommu_tce: %s failed ioba=%lx, tce=%lx, ret=%d\n",
+				__func__, ioba, tce, ret); */
+
+	return ret;
+}
+#endif /* CONFIG_IOMMU_API */
+
 long kvmppc_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
 		      unsigned long ioba, unsigned long tce)
 {
@@ -171,6 +251,44 @@ long kvmppc_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
 	if (!tt)
 		return H_TOO_HARD;
 
+	if (tt->virtmode_only)
+		return H_TOO_HARD;
+
+#ifdef CONFIG_IOMMU_API
+	if (tt->grp) {
+		long ret;
+		struct iommu_table *tbl = iommu_group_get_iommudata(tt->grp);
+
+		/* Return error if the group is being destroyed */
+		if (!tbl)
+			return H_RESCINDED;
+
+		if (tce & (TCE_PCI_READ | TCE_PCI_WRITE)) {
+			unsigned long hpa, pg_size = 0;
+			pte_t pte = 0;
+
+			hpa = get_real_address(vcpu, tce, tce & TCE_PCI_WRITE,
+					&pte, &pg_size);
+			if (hpa == ERROR_ADDR)
+				return H_TOO_HARD;
+
+			ret = put_tce_real_mode(tt, tbl, ioba,
+					hpa, pte, pg_size);
+		} else {
+			ret = clear_tce_real_mode(tbl, ioba, 0, 1);
+		}
+		iommu_flush_tce(tbl);
+
+		if (ret == -EAGAIN)
+			return H_TOO_HARD;
+
+		if (ret < 0)
+			return H_PARAMETER;
+
+		return H_SUCCESS;
+	}
+#endif
+
 	/* Emulated IO */
 	return kvmppc_emulated_h_put_tce(tt, ioba, tce);
 }
@@ -192,10 +310,58 @@ long kvmppc_h_put_tce_indirect(struct kvm_vcpu *vcpu,
 	if (!tt)
 		return H_TOO_HARD;
 
+	if (tt->virtmode_only)
+		return H_TOO_HARD;
+
 	tces = get_real_address(vcpu, tce_list, false, NULL, NULL);
 	if (tces == ERROR_ADDR)
 		return H_TOO_HARD;
 
+#ifdef CONFIG_IOMMU_API
+	if (tt->grp) {
+		long ret = 0;
+		struct iommu_table *tbl = iommu_group_get_iommudata(tt->grp);
+
+		/* Return error if the group is being destroyed */
+		if (!tbl)
+			return H_RESCINDED;
+
+		for (i = 0; i < npages; ++i) {
+			unsigned long hpa, pg_size = 0;
+			pte_t pte = 0;
+			unsigned long tce;
+			unsigned long ptce = tces + i * sizeof(unsigned long);
+
+			if (get_user(tce, (unsigned long __user *)ptce))
+				break;
+
+			hpa = get_real_address(vcpu, tce,
+					tce & TCE_PCI_WRITE,
+					&pte, &pg_size);
+			if (hpa == ERROR_ADDR)
+				ret = -EAGAIN;
+			else
+				ret = put_tce_real_mode(tt, tbl,
+						ioba + (i << IOMMU_PAGE_SHIFT),
+						hpa, pte, pg_size);
+			if (ret)
+				break;
+		}
+		if (ret)
+			clear_tce_real_mode(tbl, ioba, 0, i);
+
+		iommu_flush_tce(tbl);
+
+		if (ret == -EAGAIN)
+			return H_TOO_HARD;
+
+		if (ret < 0)
+			return H_PARAMETER;
+
+		return H_SUCCESS;
+	}
+#endif
+
 	/* Emulated IO */
 	if ((ioba + (npages << IOMMU_PAGE_SHIFT)) > tt->window_size)
 		return H_PARAMETER;
@@ -236,6 +402,32 @@ long kvmppc_h_stuff_tce(struct kvm_vcpu *vcpu,
 	if (!tt)
 		return H_TOO_HARD;
 
+	if (tt->virtmode_only)
+		return H_TOO_HARD;
+
+#ifdef CONFIG_IOMMU_API
+	if (tt->grp) {
+		long ret;
+		struct iommu_table *tbl = iommu_group_get_iommudata(tt->grp);
+
+		/* Return error if the group is being destroyed */
+		if (!tbl)
+			return H_RESCINDED;
+
+		ret = clear_tce_real_mode(tbl, ioba,
+				tce_value, npages);
+		iommu_flush_tce(tbl);
+
+		if (ret == -EAGAIN)
+			return H_TOO_HARD;
+
+		if (ret < 0)
+			return H_PARAMETER;
+
+		return H_SUCCESS;
+	}
+#endif
+
 	/* Emulated IO */
 	if ((ioba + (npages << IOMMU_PAGE_SHIFT)) > tt->window_size)
 		return H_PARAMETER;
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index b7ad589..269b0f6 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -385,6 +385,7 @@ int kvm_dev_ioctl_check_extension(long ext)
 		break;
 #endif
 	case KVM_CAP_SPAPR_MULTITCE:
+	case KVM_CAP_SPAPR_TCE_IOMMU:
 		r = 1;
 		break;
 	default:
@@ -935,6 +936,17 @@ long kvm_arch_vm_ioctl(struct file *filp,
 		r = kvm_vm_ioctl_create_spapr_tce(kvm, &create_tce);
 		goto out;
 	}
+	case KVM_CREATE_SPAPR_TCE_IOMMU: {
+		struct kvm_create_spapr_tce_iommu create_tce_iommu;
+		struct kvm *kvm = filp->private_data;
+
+		r = -EFAULT;
+		if (copy_from_user(&create_tce_iommu, argp,
+				sizeof(create_tce_iommu)))
+			goto out;
+		r = kvm_vm_ioctl_create_spapr_tce_iommu(kvm, &create_tce_iommu);
+		goto out;
+	}
 #endif /* CONFIG_PPC_BOOK3S_64 */
 
 #ifdef CONFIG_KVM_BOOK3S_64_HV
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 6c04da1..161e1d3 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -641,6 +641,7 @@ struct kvm_ppc_smmu_info {
 #define KVM_CAP_PPC_RTAS (0x100000 + 87)
 #define KVM_CAP_SPAPR_XICS (0x100000 + 88)
 #define KVM_CAP_SPAPR_MULTITCE (0x110000 + 89)
+#define KVM_CAP_SPAPR_TCE_IOMMU (0x110000 + 90)
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
@@ -885,6 +886,7 @@ struct kvm_s390_ucas_mapping {
 #define KVM_PPC_GET_HTAB_FD	  _IOW(KVMIO,  0xaa, struct kvm_get_htab_fd)
 /* Available with KVM_CAP_PPC_RTAS */
 #define KVM_PPC_RTAS_DEFINE_TOKEN _IOW(KVMIO,  0xdc, struct kvm_rtas_token_args)
+#define KVM_CREATE_SPAPR_TCE_IOMMU _IOW(KVMIO,  0xaf, struct kvm_create_spapr_tce_iommu)
 
 /*
  * ioctls for vcpu fds
-- 
1.7.10.4
