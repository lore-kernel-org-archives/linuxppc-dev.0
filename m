Return-Path: <xyjxie@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [125.16.236.6])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A21871A02ED
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Dec 2015 19:52:13 +1100 (AEDT)
Received: from localhost
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xyjxie@linux.vnet.ibm.com>;
 Thu, 31 Dec 2015 14:22:10 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id DC4121258061
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Dec 2015 14:22:46 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tBV8q77t9306546
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Dec 2015 14:22:07 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tBV8q6oN027061
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Dec 2015 14:22:07 +0530
From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-doc@vger.kernel.org
Cc: bhelgaas@google.com, corbet@lwn.net, aik@ozlabs.ru,
 alex.williamson@redhat.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, warrier@linux.vnet.ibm.com,
 zhong@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com,
 Yongji Xie <xyjxie@linux.vnet.ibm.com>
Subject: [RFC PATCH v2 1/3] PCI: Add support for enforcing all MMIO BARs to be
 page aligned
Date: Thu, 31 Dec 2015 16:50:42 +0800
Message-Id: <1451551844-11732-2-git-send-email-xyjxie@linux.vnet.ibm.com>
In-Reply-To: <1451551844-11732-1-git-send-email-xyjxie@linux.vnet.ibm.com>
References: <1451551844-11732-1-git-send-email-xyjxie@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When vfio passthrough a PCI device of which MMIO BARs
are smaller than PAGE_SIZE, guest will not handle the
mmio accesses to the BARs which leads to mmio emulations
in host.

This is because vfio will not allow to passthrough one
BAR's mmio page which may be shared with other BARs.

To solve this performance issue, this patch adds a kernel
parameter "pci=resource_page_aligned=on" to enforce
the alignments of all MMIO BARs to be at least PAGE_SIZE,
so that one BAR's mmio page would not be shared with other
BARs. We can also disable it through kernel parameter
"pci=resource_page_aligned=off".

For the default value of this parameter, we think it should be
arch-independent, so we add a macro PCI_RESOURCE_PAGE_ALIGNED
to change it. And we define this macro to enable this parameter
by default on PPC64 platform which can easily hit this
performance issue because its PAGE_SIZE is 64KB.

Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
---
 Documentation/kernel-parameters.txt |    4 ++++
 arch/powerpc/include/asm/pci.h      |   11 +++++++++++
 drivers/pci/pci.c                   |   17 +++++++++++++++++
 drivers/pci/pci.h                   |    7 ++++++-
 include/linux/pci.h                 |    2 ++
 5 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 742f69d..a53aaee 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -2857,6 +2857,10 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 				PAGE_SIZE is used as alignment.
 				PCI-PCI bridge can be specified, if resource
 				windows need to be expanded.
+		resource_page_aligned=	Enable/disable enforcing the alignment
+				of all PCI devices' memory resources to be
+				at least PAGE_SIZE.
+				Format: { "on" | "off" }
 		ecrc=		Enable/disable PCIe ECRC (transaction layer
 				end-to-end CRC checking).
 				bios: Use BIOS/firmware settings. This is the
diff --git a/arch/powerpc/include/asm/pci.h b/arch/powerpc/include/asm/pci.h
index 3453bd8..27bff59 100644
--- a/arch/powerpc/include/asm/pci.h
+++ b/arch/powerpc/include/asm/pci.h
@@ -136,6 +136,17 @@ extern pgprot_t	pci_phys_mem_access_prot(struct file *file,
 					 unsigned long pfn,
 					 unsigned long size,
 					 pgprot_t prot);
+#ifdef CONFIG_PPC64
+
+/* For PPC64, We enforce all PCI MMIO BARs to be page aligned
+ * by default. This would be helpful to improve performance
+ * when we passthrough a PCI device of which BARs are smaller
+ * than PAGE_SIZE(64KB). And we can use bootcmd
+ * "pci=resource_page_aligned=off" to disable it.
+ */
+#define PCI_ENABLE_RESOURCE_PAGE_ALIGNED
+
+#endif
 
 #define HAVE_ARCH_PCI_RESOURCE_TO_USER
 extern void pci_resource_to_user(const struct pci_dev *dev, int bar,
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 314db8c..9f14ba5 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -99,6 +99,13 @@ u8 pci_cache_line_size;
  */
 unsigned int pcibios_max_latency = 255;
 
+#ifdef PCI_ENABLE_RESOURCE_PAGE_ALIGNED
+bool pci_resource_page_aligned = true;
+#else
+bool pci_resource_page_aligned;
+#endif
+EXPORT_SYMBOL(pci_resource_page_aligned);
+
 /* If set, the PCIe ARI capability will not be used. */
 static bool pcie_ari_disabled;
 
@@ -4746,6 +4753,14 @@ static ssize_t pci_resource_alignment_store(struct bus_type *bus,
 BUS_ATTR(resource_alignment, 0644, pci_resource_alignment_show,
 					pci_resource_alignment_store);
 
+static void pci_resource_get_page_aligned(char *str)
+{
+	if (!strncmp(str, "off", 3))
+		pci_resource_page_aligned = false;
+	else if (!strncmp(str, "on", 2))
+		pci_resource_page_aligned = true;
+}
+
 static int __init pci_resource_alignment_sysfs_init(void)
 {
 	return bus_create_file(&pci_bus_type,
@@ -4859,6 +4874,8 @@ static int __init pci_setup(char *str)
 			} else if (!strncmp(str, "resource_alignment=", 19)) {
 				pci_set_resource_alignment_param(str + 19,
 							strlen(str + 19));
+			} else if (!strncmp(str, "resource_page_aligned=", 22)) {
+				pci_resource_get_page_aligned(str + 22);
 			} else if (!strncmp(str, "ecrc=", 5)) {
 				pcie_ecrc_get_policy(str + 5);
 			} else if (!strncmp(str, "hpiosize=", 9)) {
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index d390fc1..e16e48c 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -312,11 +312,16 @@ static inline resource_size_t pci_resource_alignment(struct pci_dev *dev,
 #ifdef CONFIG_PCI_IOV
 	int resno = res - dev->resource;
 
-	if (resno >= PCI_IOV_RESOURCES && resno <= PCI_IOV_RESOURCE_END)
+	if (resno >= PCI_IOV_RESOURCES && resno <= PCI_IOV_RESOURCE_END) {
+		if (pci_resource_page_aligned && res->flags & IORESOURCE_MEM)
+			return PAGE_ALIGN(pci_sriov_resource_alignment(dev, resno));
 		return pci_sriov_resource_alignment(dev, resno);
+	}
 #endif
 	if (dev->class >> 8  == PCI_CLASS_BRIDGE_CARDBUS)
 		return pci_cardbus_resource_alignment(res);
+	if (pci_resource_page_aligned && res->flags & IORESOURCE_MEM)
+		return PAGE_ALIGN(resource_alignment(res));
 	return resource_alignment(res);
 }
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 6ae25aa..0ca57f1 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1517,6 +1517,8 @@ static inline int pci_get_new_domain_nr(void) { return -ENOSYS; }
 
 #include <asm/pci.h>
 
+extern bool pci_resource_page_aligned;
+
 /* these helpers provide future and backwards compatibility
  * for accessing popular PCI BAR info */
 #define pci_resource_start(dev, bar)	((dev)->resource[(bar)].start)
-- 
1.7.9.5
