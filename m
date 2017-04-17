Return-Path: <helgaas@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w6M6L1ql4zDqJX
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Apr 2017 07:36:58 +1000 (AEST)
Subject: [PATCH v11 4/7] powerpc/powernv: Override
 pcibios_default_alignment() to force PCI devices to be page aligned
From: Bjorn Helgaas <bhelgaas@google.com>
To: Yongji Xie <elohimes@gmail.com>
Cc: zhong@linux.vnet.ibm.com, Alexey Kardashevskiy <aik@ozlabs.ru>,
 linux-pci@vger.kernel.org, Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
Date: Mon, 17 Apr 2017 16:36:53 -0500
Message-ID: <20170417213653.21092.27784.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20170417212705.21092.90222.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20170417212705.21092.90222.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Yongji Xie <elohimes@gmail.com>

This overrides pcibios_default_alignment() to set default alignment
to PAGE_SIZE for all PCI devices on PowerNV platform. Thus sub-page
BARs would not share a page and could be mapped into guest when VFIO
passthrough them.

Signed-off-by: Yongji Xie <elohimes@gmail.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/powerpc/include/asm/machdep.h        |    2 ++
 arch/powerpc/kernel/pci-common.c          |    8 ++++++++
 arch/powerpc/platforms/powernv/pci-ioda.c |    7 +++++++
 3 files changed, 17 insertions(+)

diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
index 5011b69107a7..a82c1925ff43 100644
--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -173,6 +173,8 @@ struct machdep_calls {
 	/* Called after scan and before resource survey */
 	void (*pcibios_fixup_phb)(struct pci_controller *hose);
 
+	resource_size_t (*pcibios_default_alignment)(struct pci_dev *);
+
 #ifdef CONFIG_PCI_IOV
 	void (*pcibios_fixup_sriov)(struct pci_dev *pdev);
 	resource_size_t (*pcibios_iov_resource_alignment)(struct pci_dev *, int resno);
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index ffda24a38dda..ceda57484e8e 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -233,6 +233,14 @@ void pcibios_reset_secondary_bus(struct pci_dev *dev)
 	pci_reset_secondary_bus(dev);
 }
 
+resource_size_t pcibios_default_alignment(struct pci_dev *pdev)
+{
+	if (ppc_md.pcibios_default_alignment)
+		return ppc_md.pcibios_default_alignment(pdev);
+
+	return 0;
+}
+
 #ifdef CONFIG_PCI_IOV
 resource_size_t pcibios_iov_resource_alignment(struct pci_dev *pdev, int resno)
 {
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 6901a06da2f9..b724487cbd0f 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -3287,6 +3287,11 @@ static void pnv_pci_setup_bridge(struct pci_bus *bus, unsigned long type)
 	}
 }
 
+static resource_size_t pnv_pci_default_alignment(struct pci_dev *pdev)
+{
+	return PAGE_SIZE;
+}
+
 #ifdef CONFIG_PCI_IOV
 static resource_size_t pnv_pci_iov_resource_alignment(struct pci_dev *pdev,
 						      int resno)
@@ -3820,6 +3825,8 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
 		hose->controller_ops = pnv_pci_ioda_controller_ops;
 	}
 
+	ppc_md.pcibios_default_alignment = pnv_pci_default_alignment;
+
 #ifdef CONFIG_PCI_IOV
 	ppc_md.pcibios_fixup_sriov = pnv_pci_ioda_fixup_iov_resources;
 	ppc_md.pcibios_iov_resource_alignment = pnv_pci_iov_resource_alignment;
