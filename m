Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t3XMD2N6jzDvJH
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Oct 2016 12:22:48 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u9Q1J9jI090258
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Oct 2016 21:22:46 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0b-001b2d01.pphosted.com with ESMTP id 26abfe6k9s-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Oct 2016 21:22:46 -0400
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 26 Oct 2016 11:22:43 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 7498A2CE8061
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Oct 2016 12:22:40 +1100 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u9Q1MePZ18743298
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Oct 2016 12:22:40 +1100
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u9Q1MdJN000967
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Oct 2016 12:22:40 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, bhelgaas@google.com,
 benh@kernel.crashing.org, mpe@ellerman.id.au, clsoto@us.ibm.com,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v3 2/2] PCI: Disable VF's memory space on updating IOV BAR in
 pci_update_resource()
Date: Wed, 26 Oct 2016 12:15:36 +1100
In-Reply-To: <1477444536-29612-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1477444536-29612-1-git-send-email-gwshan@linux.vnet.ibm.com>
Message-Id: <1477444536-29612-3-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

pci_update_resource() might be called to update (shift) IOV BARs
in PPC PowerNV specific pcibios_sriov_enable() when enabling PF's
SRIOV capability. At that point, the PF have been functional if
the SRIOV is enabled through sysfs entry "sriov_numvfs". The PF's
memory decoding (0x2 in PCI_COMMAND) shouldn't be disabled when
updating its IOV BARs with pci_update_resource(). Otherwise, we
receives EEH error caused by MMIO access to PF's memory BARs during
the window when PF's memory decoding is disabled.

   sriov_numvfs_store
   pdev->driver->sriov_configure
   mlx5_core_sriov_configure
   pci_enable_sriov
   sriov_enable
   pcibios_sriov_enable
   pnv_pci_sriov_enable
   pnv_pci_vf_resource_shift
   pci_update_resource

This disables VF's memory space instead of PF's memory decoding
when 64-bits IOV BARs are updated in pci_update_resource().

Reported-by: Carol Soto <clsoto@us.ibm.com>
Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
Tested-by: Carol Soto <clsoto@us.ibm.com>
---
 drivers/pci/setup-res.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index 66c4d8f..1456896 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -29,10 +29,10 @@
 void pci_update_resource(struct pci_dev *dev, int resno)
 {
 	struct pci_bus_region region;
-	bool disable;
-	u16 cmd;
+	bool disable = false;
+	u16 cmd, bit;
 	u32 new, check, mask;
-	int reg;
+	int reg, cmd_reg;
 	enum pci_bar_type type;
 	struct resource *res = dev->resource + resno;
 
@@ -81,11 +81,23 @@ void pci_update_resource(struct pci_dev *dev, int resno)
 	 * disable decoding so that a half-updated BAR won't conflict
 	 * with another device.
 	 */
-	disable = (res->flags & IORESOURCE_MEM_64) && !dev->mmio_always_on;
+	if (res->flags & IORESOURCE_MEM_64) {
+		if (resno <= PCI_ROM_RESOURCE) {
+			disable = !dev->mmio_always_on;
+			cmd_reg = PCI_COMMAND;
+			bit = PCI_COMMAND_MEMORY;
+		} else {
+#ifdef CONFIG_PCI_IOV
+			disable = true;
+			cmd_reg = dev->sriov->pos + PCI_SRIOV_CTRL;
+			bit = PCI_SRIOV_CTRL_MSE;
+#endif
+		}
+	}
+
 	if (disable) {
-		pci_read_config_word(dev, PCI_COMMAND, &cmd);
-		pci_write_config_word(dev, PCI_COMMAND,
-				      cmd & ~PCI_COMMAND_MEMORY);
+		pci_read_config_word(dev, cmd_reg, &cmd);
+		pci_write_config_word(dev, cmd_reg, cmd & ~bit);
 	}
 
 	pci_write_config_dword(dev, reg, new);
@@ -107,7 +119,7 @@ void pci_update_resource(struct pci_dev *dev, int resno)
 	}
 
 	if (disable)
-		pci_write_config_word(dev, PCI_COMMAND, cmd);
+		pci_write_config_word(dev, cmd_reg, cmd);
 }
 
 int pci_claim_resource(struct pci_dev *dev, int resource)
-- 
2.1.0
