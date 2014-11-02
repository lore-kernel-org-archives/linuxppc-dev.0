Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 247151A0A09
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Nov 2014 02:42:13 +1100 (AEDT)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Mon, 3 Nov 2014 01:42:12 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 8B2603578048
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Nov 2014 02:42:11 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sA2Fi8NG37748802
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Nov 2014 02:44:08 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sA2FgAN5028455
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Nov 2014 02:42:11 +1100
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: bhelgaas@google.com, benh@au1.ibm.com, gwshan@linux.vnet.ibm.com,
 linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH V9 14/18] powerpc/powernv: Implement
 pcibios_iov_resource_size() on powernv
Date: Sun,  2 Nov 2014 23:41:30 +0800
Message-Id: <1414942894-17034-15-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1414942894-17034-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1414942894-17034-1-git-send-email-weiyang@linux.vnet.ibm.com>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On PowerNV platform, the PF's IOV BAR size would be expanded, which is
different from the normal case.

This patch retrieves the VF BAR size by total size dividing the expanded number
of VFs.

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/machdep.h        |    1 +
 arch/powerpc/kernel/pci-common.c          |    8 ++++++++
 arch/powerpc/platforms/powernv/pci-ioda.c |   15 +++++++++++++++
 3 files changed, 24 insertions(+)

diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
index 15a13e6..d971874 100644
--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -259,6 +259,7 @@ struct machdep_calls {
 	resource_size_t (*pcibios_iov_resource_alignment)(struct pci_dev *,
 			                                    int resno,
 							    resource_size_t align);
+	resource_size_t (*pcibios_iov_resource_size)(struct pci_dev *, int resno);
 #endif /* CONFIG_PCI_IOV */
 
 	/* Called to shutdown machine specific hardware not already controlled
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 581e67b..a2a96d3 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -143,6 +143,14 @@ resource_size_t pcibios_iov_resource_alignment(struct pci_dev *pdev,
 
 	return 0;
 }
+
+resource_size_t pcibios_iov_resource_size(struct pci_dev *pdev, int resno)
+{
+	if (ppc_md.pcibios_iov_resource_size)
+		return ppc_md.pcibios_iov_resource_size(pdev, resno);
+
+	return 0;
+}
 #endif /* CONFIG_PCI_IOV */
 
 static resource_size_t pcibios_io_size(const struct pci_controller *hose)
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 880d76d..f7abba3 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1847,6 +1847,20 @@ static resource_size_t pnv_pci_iov_resource_alignment(struct pci_dev *pdev,
 
 	return align;
 }
+
+static resource_size_t pnv_pci_iov_resource_size(struct pci_dev *pdev, int resno)
+{
+	struct pci_dn *pdn = pci_get_pdn(pdev);
+	resource_size_t size = 0;
+
+	if (!pdn->max_vfs)
+		return size;
+
+	size = resource_size(pdev->resource + resno);
+	do_div(size, pdn->max_vfs);
+
+	return size;
+}
 #endif /* CONFIG_PCI_IOV */
 
 /* Prevent enabling devices for which we couldn't properly
@@ -2058,6 +2072,7 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
 #ifdef CONFIG_PCI_IOV
 	ppc_md.pcibios_fixup_sriov = pnv_pci_ioda_fixup_sriov;
 	ppc_md.pcibios_iov_resource_alignment = pnv_pci_iov_resource_alignment;
+	ppc_md.pcibios_iov_resource_size = pnv_pci_iov_resource_size;
 #endif /* CONFIG_PCI_IOV */
 	pci_add_flags(PCI_REASSIGN_ALL_RSRC);
 
-- 
1.7.9.5
