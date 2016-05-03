Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qzVSw3SbdzDqCM
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 May 2016 15:43:12 +1000 (AEST)
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 3 May 2016 15:43:11 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 1693C2BB0059
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 May 2016 15:43:09 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u435h1Lq5243224
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 May 2016 15:43:09 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u435gZdE019394
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 May 2016 15:42:36 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au, aik@ozlabs.ru,
 alistair@popple.id.au, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v9 06/26] powerpc/powernv: Data type unsigned int for PE number
Date: Tue,  3 May 2016 15:41:25 +1000
Message-Id: <1462254105-24128-7-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1462254105-24128-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1462254105-24128-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This changes the data type of PE number from "int" to "unsigned int"
in order to match the fact PE number is never negative:

   * The number of PE to which the specified PCI device is attached.
   * The PE number map for SRIOV VFs.
   * The returned PE number from pnv_ioda_alloc_pe().
   * The returned PE number from pnv_ioda2_pick_m64_pe().

Suggested-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/pci-bridge.h     | 6 +++---
 arch/powerpc/platforms/powernv/pci-ioda.c | 8 ++++----
 arch/powerpc/platforms/powernv/pci.c      | 2 +-
 arch/powerpc/platforms/powernv/pci.h      | 2 +-
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index 023c8c8..220129f 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -209,14 +209,14 @@ struct pci_dn {
 #ifdef CONFIG_EEH
 	struct eeh_dev *edev;		/* eeh device */
 #endif
-#define IODA_INVALID_PE		(-1)
+#define IODA_INVALID_PE		0xFFFFFFFF
 #ifdef CONFIG_PPC_POWERNV
-	int	pe_number;
+	unsigned int pe_number;
 	int     vf_index;		/* VF index in the PF */
 #ifdef CONFIG_PCI_IOV
 	u16     vfs_expanded;		/* number of VFs IOV BAR expanded */
 	u16     num_vfs;		/* number of VFs enabled*/
-	int     *pe_num_map;		/* PE# for the first VF PE or array */
+	unsigned int *pe_num_map;	/* PE# for the first VF PE or array */
 	bool    m64_single_mode;	/* Use M64 BAR in Single Mode */
 #define IODA_INVALID_M64        (-1)
 	int     (*m64_map)[PCI_SRIOV_NUM_BARS];
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 1d2514f..4aa6cdf 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -138,7 +138,7 @@ static void pnv_ioda_reserve_pe(struct pnv_phb *phb, int pe_no)
 	phb->ioda.pe_array[pe_no].pe_number = pe_no;
 }
 
-static int pnv_ioda_alloc_pe(struct pnv_phb *phb)
+static unsigned int pnv_ioda_alloc_pe(struct pnv_phb *phb)
 {
 	unsigned long pe;
 
@@ -261,7 +261,7 @@ static void pnv_ioda2_reserve_m64_pe(struct pci_bus *bus,
 	}
 }
 
-static int pnv_ioda2_pick_m64_pe(struct pci_bus *bus, bool all)
+static unsigned int pnv_ioda2_pick_m64_pe(struct pci_bus *bus, bool all)
 {
 	struct pci_controller *hose = pci_bus_to_host(bus);
 	struct pnv_phb *phb = hose->private_data;
@@ -919,7 +919,7 @@ static struct pnv_ioda_pe *pnv_ioda_setup_dev_PE(struct pci_dev *dev)
 	struct pnv_phb *phb = hose->private_data;
 	struct pci_dn *pdn = pci_get_pdn(dev);
 	struct pnv_ioda_pe *pe;
-	int pe_num;
+	unsigned int pe_num;
 
 	if (!pdn) {
 		pr_err("%s: Device tree node not associated properly\n",
@@ -1010,7 +1010,7 @@ static void pnv_ioda_setup_bus_PE(struct pci_bus *bus, bool all)
 	struct pci_controller *hose = pci_bus_to_host(bus);
 	struct pnv_phb *phb = hose->private_data;
 	struct pnv_ioda_pe *pe;
-	int pe_num = IODA_INVALID_PE;
+	unsigned int pe_num = IODA_INVALID_PE;
 
 	/* Check if PE is determined by M64 */
 	if (phb->pick_m64_pe)
diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index afbaa1c..8827461 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -370,7 +370,7 @@ static void pnv_pci_config_check_eeh(struct pci_dn *pdn)
 	struct pnv_phb *phb = pdn->phb->private_data;
 	u8	fstate;
 	__be16	pcierr;
-	int	pe_no;
+	unsigned int pe_no;
 	s64	rc;
 
 	/*
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index 784882a..66f2569 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -113,7 +113,7 @@ struct pnv_phb {
 	int (*init_m64)(struct pnv_phb *phb);
 	void (*reserve_m64_pe)(struct pci_bus *bus,
 			       unsigned long *pe_bitmap, bool all);
-	int (*pick_m64_pe)(struct pci_bus *bus, bool all);
+	unsigned int (*pick_m64_pe)(struct pci_bus *bus, bool all);
 	int (*get_pe_state)(struct pnv_phb *phb, int pe_no);
 	void (*freeze_pe)(struct pnv_phb *phb, int pe_no);
 	int (*unfreeze_pe)(struct pnv_phb *phb, int pe_no, int opt);
-- 
2.1.0
