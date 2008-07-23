Return-Path: <ehrhardt@linux.vnet.ibm.com>
Received: from mtagate4.de.ibm.com (mtagate4.de.ibm.com [195.212.29.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate4.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 92A90DDE1F
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jul 2008 18:37:07 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate4.de.ibm.com (8.13.8/8.13.8) with ESMTP id m6N8amnb264658
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jul 2008 08:36:48 GMT
Received: from d12av03.megacenter.de.ibm.com (d12av03.megacenter.de.ibm.com
	[9.149.165.213])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v9.0) with
	ESMTP id m6N8alMQ2285604
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jul 2008 10:36:47 +0200
Received: from d12av03.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av03.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id m6N8alsu021877
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jul 2008 10:36:47 +0200
From: ehrhardt@linux.vnet.ibm.com
To: kvm-ppc@vger.kernel.org, embedded-hypervisor@power.org,
	linuxppc-dev@ozlabs.org
Subject: [PATCH 5/6] kvmppc: magic page paravirtualization - guest part
Date: Wed, 23 Jul 2008 10:36:46 +0200
Message-Id: <1216802207-32675-6-git-send-email-ehrhardt@linux.vnet.ibm.com>
In-Reply-To: <1216802207-32675-1-git-send-email-ehrhardt@linux.vnet.ibm.com>
References: <1216802207-32675-1-git-send-email-ehrhardt@linux.vnet.ibm.com>
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
When the guest read that data and wants to support it the memory is allocated
and passed to the hypervisor using the KVM_HCALL_RESERVE_MAGICPAGE hypercall.

Signed-off-by: Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>
---

[diffstat]
 arch/powerpc/kernel/kvm.c      |   48 +++++++++++++++++++++++++++++++++++++++++
 include/asm-powerpc/kvm_para.h |   27 ++++++++++++++++++++++-
 2 files changed, 74 insertions(+), 1 deletion(-)

[diff]
diff --git a/arch/powerpc/kernel/kvm.c b/arch/powerpc/kernel/kvm.c
--- a/arch/powerpc/kernel/kvm.c
+++ b/arch/powerpc/kernel/kvm.c
@@ -22,9 +22,57 @@
 #include <linux/percpu.h>
 #include <linux/mm.h>
 #include <linux/kvm_para.h>
+#include <linux/bootmem.h>
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
+void *kvm_magicpage;
+
+static void __init kvmppc_register_magic_page(void)
+{
+	unsigned long paddr;
+	int size;
+	long err;
+
+	size = kvmppc_pv_read_data(KVM_PVDATA_MAGICPAGE_SIZE);
+	if (size < 0) {
+		printk(KERN_ERR"%s: couldn't read size for kvmppc style "
+			"paravirtualization support (got %d)\n",
+			__func__, size);
+		return;
+	}
+
+	/* FIXME Guest SMP needs that percpu
+	 * On SMP we might also need a free implementation */
+	kvm_magicpage = alloc_bootmem(size);
+	if (!kvm_magicpage) {
+		printk(KERN_ERR"%s - failed to allocate %d bytes\n",
+			 __func__, size);
+		return;
+	}
+
+	paddr = (unsigned long)__pa(kvm_magicpage);
+	err = kvm_hypercall1(KVM_HCALL_RESERVE_MAGICPAGE, paddr);
+	if (err)
+		printk(KERN_ERR"%s: couldn't register magic page\n", __func__);
+	else
+		printk(KERN_NOTICE"%s: registered %d bytes for "
+			"virtualization support\n", __func__, size);
+}
 
 void __init kvm_guest_init(void)
 {
 	if (!kvm_para_available())
 		return;
+
+	if (kvm_para_has_feature(KVM_FEATURE_PPCPV_MAGICPAGE))
+		kvmppc_register_magic_page();
 }
diff --git a/include/asm-powerpc/kvm_para.h b/include/asm-powerpc/kvm_para.h
--- a/include/asm-powerpc/kvm_para.h
+++ b/include/asm-powerpc/kvm_para.h
@@ -28,10 +28,18 @@
 
 #define KVM_HYPERCALL_BIN 0x03ffffff
 
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
@@ -54,13 +62,30 @@
 	if (!dn)
 		return 0;
 
-	for (i = 0; i < ARRAY_SIZE(para_features)-1; i++) {
+	for (i = 0; i < ARRAY_SIZE(para_features); i++) {
 		dtval = of_get_property(dn, para_features[i].dtcell, NULL);
 		if (dtval && *dtval == 1)
 			features |= (1 << para_features[i].feature);
 	}
 
 	return features;
+}
+
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
+	if (dtval)
+		return *dtval;
+	else
+		return -EINVAL;
 }
 
 void kvm_guest_init(void);
