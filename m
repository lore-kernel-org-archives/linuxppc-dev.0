Return-Path: <ehrhardt@linux.vnet.ibm.com>
Received: from mtagate8.de.ibm.com (mtagate8.de.ibm.com [195.212.29.157])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate8.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E0956DE086
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Sep 2008 16:29:09 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate8.de.ibm.com (8.13.8/8.13.8) with ESMTP id m8G6RwE3076902
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Sep 2008 06:27:58 GMT
Received: from d12av01.megacenter.de.ibm.com (d12av01.megacenter.de.ibm.com
	[9.149.165.212])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v9.1) with
	ESMTP id m8G6RweE4321416
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Sep 2008 08:27:58 +0200
Received: from d12av01.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av01.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id m8G6RtRJ025229
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Sep 2008 08:27:55 +0200
From: ehrhardt@linux.vnet.ibm.com
To: linuxppc-dev@ozlabs.org, kvm-ppc@vger.kernel.org
Subject: [PATCH 3/3] kvmppc: magic page paravirtualization - guest part
Date: Tue, 16 Sep 2008 08:27:30 +0200
Message-Id: <1221546450-15761-4-git-send-email-ehrhardt@linux.vnet.ibm.com>
In-Reply-To: <1221546450-15761-1-git-send-email-ehrhardt@linux.vnet.ibm.com>
References: <1221546450-15761-1-git-send-email-ehrhardt@linux.vnet.ibm.com>
Cc: hollisb@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>

This patch adds the guest handling for the magic page mechanism. A Hypervisor
can modify the device tree passed to the guest. Using that already existing
interface a guest can simply detect available hypervisor features and agree
on the supported ones using hypercalls.
In this example it is checked for the feature switch "feature,pv-magicpage"
in the hypervisor node and additional data which represents the size the
hypervisor requests in "data,pv-magicpage-size".
When the guest reads that data and wants to support it the memory is allocated
and passed to the hypervisor using the KVM_HCALL_RESERVE_MAGICPAGE hypercall.

Signed-off-by: Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>
---

[diffstat]
 arch/powerpc/kernel/kvm.c      |   53 +++++++++++++++++++++++++++++++++++++++++
 include/asm-powerpc/fixmap.h   |   10 ++++++-
 include/asm-powerpc/kvm_para.h |   26 ++++++++++++++++++++
 3 files changed, 88 insertions(+), 1 deletion(-)
[diff]

diff --git a/arch/powerpc/kernel/kvm.c b/arch/powerpc/kernel/kvm.c
--- a/arch/powerpc/kernel/kvm.c
+++ b/arch/powerpc/kernel/kvm.c
@@ -22,9 +22,62 @@
 #include <linux/percpu.h>
 #include <linux/mm.h>
 #include <linux/kvm_para.h>
+#include <linux/bootmem.h>
+#include <asm/fixmap.h>
+#include <asm/epapr_hcalls.h>
+
+/*
+ * this is guest memory granted to the hypervisor;
+ * the hypervisor can place data in this area and rewrite
+ * privileged instructions to read from this area without
+ * trapping.
+ * Only the Hypervisor needs to be aware of the structure layout
+ * which makes the guest more felxible - the guest only guarantees
+ * the size which is requested by the hypervisor and read from a
+ * device tree entry.
+ */
+static void *kvm_magicpage;
+
+static void __init kvmppc_register_magic_page(void)
+{
+	unsigned long gvaddr;
+	unsigned long gpaddr;
+	int size;
+	long err;
+
+	size = kvmppc_pv_read_data(KVM_PVDATA_MAGICPAGE_SIZE);
+	if (size < 0) {
+		printk(KERN_ERR "%s: couldn't read size for kvmppc style "
+			"paravirtualization support (got %d)\n",
+			__func__, size);
+		return;
+	}
+
+	/* FIXME Guest SMP needs that percpu which */
+	kvm_magicpage = alloc_bootmem(size);
+	if (!kvm_magicpage) {
+		printk(KERN_ERR "%s - failed to allocate %d bytes\n",
+			 __func__, size);
+		return;
+	}
+	gpaddr = (unsigned long)__pa(kvm_magicpage);
+	gvaddr = fix_to_virt(FIX_KVM_PV);
+
+	err = epapr_hypercall_2in_1out(KVM_HCALL_RESERVE_MAGICPAGE,
+					gvaddr, gpaddr);
+	if (err)
+		printk(KERN_ERR "%s: couldn't register pv mem\n", __func__);
+	else
+		printk(KERN_NOTICE "%s: registered %d bytes for pv mem support"
+			" (gvaddr 0x%08lx gpaddr 0x%08lx)\n",
+			 __func__, size, gvaddr, gpaddr);
+}
 
 void __init kvm_guest_init(void)
 {
 	if (!kvm_para_available())
 		return;
+
+	if (kvm_para_has_feature(KVM_FEATURE_PPCPV_MAGICPAGE))
+		kvmppc_register_magic_page();
 }
diff --git a/include/asm-powerpc/fixmap.h b/include/asm-powerpc/fixmap.h
--- a/include/asm-powerpc/fixmap.h
+++ b/include/asm-powerpc/fixmap.h
@@ -36,7 +36,7 @@
  *
  * these 'compile-time allocated' memory buffers are
  * fixed-size 4k pages. (or larger if used with an increment
- * highger than 1) use fixmap_set(idx,phys) to associate
+ * higher than 1) use fixmap_set(idx,phys) to associate
  * physical memory with fixmap indices.
  *
  * TLB entries of such buffers will not be flushed across
@@ -44,6 +44,14 @@
  */
 enum fixed_addresses {
 	FIX_HOLE,
+#ifdef CONFIG_KVM_GUEST
+	/*
+	 * reserved virtual address space for paravirtualization - needs to be
+	 *  <=32k away from base address 0 to be able to reach it with
+	 * immediate addressing using base 0 instead of needing a register.
+	 */
+	FIX_KVM_PV,
+#endif
 #ifdef CONFIG_HIGHMEM
 	FIX_KMAP_BEGIN,	/* reserved pte's for temporary kernel mappings */
 	FIX_KMAP_END = FIX_KMAP_BEGIN+(KM_TYPE_NR*NR_CPUS)-1,
diff --git a/include/asm-powerpc/kvm_para.h b/include/asm-powerpc/kvm_para.h
--- a/include/asm-powerpc/kvm_para.h
+++ b/include/asm-powerpc/kvm_para.h
@@ -26,10 +26,18 @@
 
 #include <linux/of.h>
 
+#define KVM_HCALL_RESERVE_MAGICPAGE	0
+
+#define KVM_PVDATA_MAGICPAGE_SIZE	"data,pv-magicpage-size"
+
+/* List of PV features supported, returned as a bitfield */
+#define KVM_FEATURE_PPCPV_MAGICPAGE	0
+
 static struct kvmppc_para_features {
 	char *dtcell;
 	int feature;
 } para_features[] = {
+	{ "feature,pv-magicpage", KVM_FEATURE_PPCPV_MAGICPAGE }
 };
 
 static inline int kvm_para_available(void)
@@ -67,6 +75,24 @@
 	return features;
 }
 
+/* reads the specified data field out of the hypervisor node */
+static inline int kvmppc_pv_read_data(char *dtcell)
+{
+	struct device_node *dn;
+	const int *dtval;
+
+	dn = of_find_node_by_path("/hypervisor");
+	if (!dn)
+		return -EINVAL;
+
+	dtval = of_get_property(dn, dtcell, NULL);
+	of_node_put(dn);
+	if (dtval)
+		return *dtval;
+	else
+		return -EINVAL;
+}
+
 void kvm_guest_init(void);
 
 #endif /* __KERNEL__ */
