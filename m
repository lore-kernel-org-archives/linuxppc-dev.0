Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-wm0-x242.google.com (mail-wm0-x242.google.com
 [IPv6:2a00:1450:400c:c09::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 406dgN1wy7zF1yG
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Mar 2018 07:34:07 +1100 (AEDT)
Received: by mail-wm0-x242.google.com with SMTP id h76so18387479wme.4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2018 13:34:07 -0700 (PDT)
Sender: Mathieu Malaterre <mathieu.malaterre@gmail.com>
From: Mathieu Malaterre <malat@debian.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Mathieu Malaterre <malat@debian.org>
Subject: [PATCH] PCI/IOV: Add missing prototype for powerpc specific
Date: Thu, 22 Mar 2018 21:33:55 +0100
Message-Id: <20180322203355.26448-1-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Some prototypes for weak functions were missing for powerpc specific
functions. Add the missing prototypes to the CONFIG_PCI_IOV block. This
fixes the following three warnings treated as error when using W=1:

  arch/powerpc/kernel/pci-common.c:236:17: error: no previous prototype for ‘pcibios_default_alignment’ [-Werror=missing-prototypes]
  arch/powerpc/kernel/pci-common.c:253:5: error: no previous prototype for ‘pcibios_sriov_enable’ [-Werror=missing-prototypes]
  arch/powerpc/kernel/pci-common.c:261:5: error: no previous prototype for ‘pcibios_sriov_disable’ [-Werror=missing-prototypes]

Also in commit 978d2d683123 ("PCI: Add pcibios_iov_resource_alignment()
interface") a new function was added but the prototype was located in the
main header instead of the CONFIG_PCI_IOV specific section. Move this
function next to the newly added ones.

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 include/linux/pci.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 024a1beda008..f43b43b9b643 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1295,7 +1295,6 @@ unsigned char pci_bus_max_busnr(struct pci_bus *bus);
 void pci_setup_bridge(struct pci_bus *bus);
 resource_size_t pcibios_window_alignment(struct pci_bus *bus,
 					 unsigned long type);
-resource_size_t pcibios_iov_resource_alignment(struct pci_dev *dev, int resno);
 
 #define PCI_VGA_STATE_CHANGE_BRIDGE (1 << 0)
 #define PCI_VGA_STATE_CHANGE_DECODES (1 << 1)
@@ -1923,6 +1922,7 @@ void pcibios_release_device(struct pci_dev *dev);
 void pcibios_penalize_isa_irq(int irq, int active);
 int pcibios_alloc_irq(struct pci_dev *dev);
 void pcibios_free_irq(struct pci_dev *dev);
+resource_size_t pcibios_default_alignment(void);
 
 #ifdef CONFIG_HIBERNATE_CALLBACKS
 extern struct dev_pm_ops pcibios_pm_ops;
@@ -1955,6 +1955,11 @@ int pci_sriov_set_totalvfs(struct pci_dev *dev, u16 numvfs);
 int pci_sriov_get_totalvfs(struct pci_dev *dev);
 resource_size_t pci_iov_resource_size(struct pci_dev *dev, int resno);
 void pci_vf_drivers_autoprobe(struct pci_dev *dev, bool probe);
+
+/* Arch may override these (weak) */
+int pcibios_sriov_enable(struct pci_dev *pdev, u16 num_vfs);
+int pcibios_sriov_disable(struct pci_dev *pdev);
+resource_size_t pcibios_iov_resource_alignment(struct pci_dev *dev, int resno);
 #else
 static inline int pci_iov_virtfn_bus(struct pci_dev *dev, int id)
 {
-- 
2.11.0
