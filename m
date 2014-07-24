Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5E9FD1A0979
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Jul 2014 16:23:00 +1000 (EST)
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Thu, 24 Jul 2014 11:52:58 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id C2F47125804F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Jul 2014 11:52:47 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6O6NEGc2883846
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Jul 2014 11:53:14 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6O6MrXU007977
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Jul 2014 11:52:53 +0530
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
 bhelgaas@google.com, benh@au1.ibm.com, gwshan@linux.vnet.ibm.com,
 yan@linux.vnet.ibm.com, qiudayu@linux.vnet.ibm.com
Subject: [PATCH V7 13/17] powerpc/powernv: Implement
 pcibios_sriov_resource_alignment on powernv
Date: Thu, 24 Jul 2014 14:22:23 +0800
Message-Id: <1406182947-11302-14-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1406182947-11302-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1406182947-11302-1-git-send-email-weiyang@linux.vnet.ibm.com>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch implements the pcibios_sriov_resource_alignment() on powernv
platform.

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/machdep.h        |    3 +++
 arch/powerpc/kernel/pci-common.c          |   14 ++++++++++++++
 arch/powerpc/platforms/powernv/pci-ioda.c |   18 ++++++++++++++++++
 3 files changed, 35 insertions(+)

diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
index fabb8016..5c023be 100644
--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -254,6 +254,9 @@ struct machdep_calls {
 
 #ifdef CONFIG_PCI_IOV
 	void (*pcibios_fixup_sriov)(struct pci_bus *bus);
+	resource_size_t (*pcibios_sriov_resource_alignment)(struct pci_dev *,
+			                                    int resno,
+							    resource_size_t align);
 #endif /* CONFIG_PCI_IOV */
 
 	/* Called to shutdown machine specific hardware not already controlled
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index c2b7930..942a3e5 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -140,6 +140,20 @@ void pcibios_reset_secondary_bus(struct pci_dev *dev)
 	ssleep(1);
 }
 
+#ifdef CONFIG_PCI_IOV
+resource_size_t pcibios_sriov_resource_alignment(struct pci_dev *pdev,
+						 int resno,
+						 resource_size_t align)
+{
+	if (ppc_md.pcibios_sriov_resource_alignment)
+		return ppc_md.pcibios_sriov_resource_alignment(pdev,
+							       resno,
+							       align);
+
+	return 0;
+}
+#endif /* CONFIG_PCI_IOV */
+
 static resource_size_t pcibios_io_size(const struct pci_controller *hose)
 {
 #ifdef CONFIG_PPC64
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 6fd2377..3aeb87b 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1767,6 +1767,23 @@ resource_size_t pnv_pci_sriov_resource_size(struct pci_dev *pdev, int resno)
 
 	return size;
 }
+
+static resource_size_t pnv_pcibios_sriov_resource_alignment(struct pci_dev *pdev,
+							    int resno,
+							    resource_size_t align)
+{
+	struct pci_dn *pdn = pci_get_pdn(pdev);
+	resource_size_t iov_align;
+
+	iov_align = resource_size(&pdev->resource[resno]);
+	if (iov_align)
+		return iov_align;
+
+	if (pdn->vfs)
+		return pdn->vfs * align;
+
+	return align;
+}
 #endif /* CONFIG_PCI_IOV */
 
 /* Prevent enabling devices for which we couldn't properly
@@ -1976,6 +1993,7 @@ void __init pnv_pci_init_ioda_phb(struct device_node *np,
 	ppc_md.pcibios_reset_secondary_bus = pnv_pci_reset_secondary_bus;
 #ifdef CONFIG_PCI_IOV
 	ppc_md.pcibios_fixup_sriov = pnv_pci_ioda_fixup_sriov;
+	ppc_md.pcibios_sriov_resource_alignment = pnv_pcibios_sriov_resource_alignment;
 #endif /* CONFIG_PCI_IOV */
 	pci_add_flags(PCI_REASSIGN_ALL_RSRC);
 
-- 
1.7.9.5
