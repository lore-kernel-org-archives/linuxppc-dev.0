Return-Path: <ruscur@russell.cc>
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wnYMJ6VpczDqKy
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Jun 2017 14:20:12 +1000 (AEST)
From: Russell Currey <ruscur@russell.cc>
To: linuxppc-dev@lists.ozlabs.org
Cc: Russell Currey <ruscur@russell.cc>
Subject: [PATCH v2 1/3] powerpc/powernv/pci: Reduce spam when dumping PEST
Date: Wed, 14 Jun 2017 14:19:58 +1000
Message-Id: <20170614042000.1258-1-ruscur@russell.cc>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dumping the PE State Tables (PEST) can be highly verbose if a number of PEs
are affected, especially in the case where the whole PHB is frozen and 512
lines get printed.  Check for duplicates when dumping the PEST to reduce
useless output.

For example:

    PE[0f8] A/B: 9700002600000000 80000080d00000f8
    PE[0f9] A/B: 8000000000000000 0000000000000000
    PE[..0fe] A/B: as above
    PE[0ff] A/B: 8440002b00000000 0000000000000000

instead of:

    PE[0f8] A/B: 9700002600000000 80000080d00000f8
    PE[0f9] A/B: 8000000000000000 0000000000000000
    PE[0fa] A/B: 8000000000000000 0000000000000000
    PE[0fb] A/B: 8000000000000000 0000000000000000
    PE[0fc] A/B: 8000000000000000 0000000000000000
    PE[0fd] A/B: 8000000000000000 0000000000000000
    PE[0fe] A/B: 8000000000000000 0000000000000000
    PE[0ff] A/B: 8440002b00000000 0000000000000000

and you can imagine how much worse it can get for 512 PEs.

Signed-off-by: Russell Currey <ruscur@russell.cc>
---
v2: Made a constant instead of ">> 63" grossness thanks to mpe & ajd
---
 arch/powerpc/platforms/powernv/pci.c | 51 ++++++++++++++++++++++--------------
 arch/powerpc/platforms/powernv/pci.h |  3 +++
 2 files changed, 34 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index 935ccb249a8a..40071ad0bc42 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -227,11 +227,39 @@ void pnv_teardown_msi_irqs(struct pci_dev *pdev)
 }
 #endif /* CONFIG_PCI_MSI */
 
+/* Nicely print the contents of the PE State Tables (PEST). */
+static void pnv_pci_dump_pest(__be64 pestA[], __be64 pestB[], int pest_size)
+{
+	__be64 prevA = ULONG_MAX, prevB = ULONG_MAX;
+	bool dup = false;
+	int i;
+
+	for (i = 0; i < pest_size; i++) {
+		__be64 peA = be64_to_cpu(pestA[i]);
+		__be64 peB = be64_to_cpu(pestB[i]);
+
+		if (peA != prevA || peB != prevB) {
+			if (dup) {
+				pr_info("PE[..%03x] A/B: as above\n", i-1);
+				dup = false;
+			}
+			prevA = peA;
+			prevB = peB;
+			if (peA & PNV_IODA_STOPPED_STATE ||
+			    peB & PNV_IODA_STOPPED_STATE)
+				pr_info("PE[%03x] A/B: %016llx %016llx\n",
+					i, peA, peB);
+		} else if (!dup && (peA & PNV_IODA_STOPPED_STATE ||
+				    peB & PNV_IODA_STOPPED_STATE)) {
+			dup = true;
+		}
+	}
+}
+
 static void pnv_pci_dump_p7ioc_diag_data(struct pci_controller *hose,
 					 struct OpalIoPhbErrorCommon *common)
 {
 	struct OpalIoP7IOCPhbErrorData *data;
-	int i;
 
 	data = (struct OpalIoP7IOCPhbErrorData *)common;
 	pr_info("P7IOC PHB#%x Diag-data (Version: %d)\n",
@@ -308,22 +336,13 @@ static void pnv_pci_dump_p7ioc_diag_data(struct pci_controller *hose,
 			be64_to_cpu(data->dma1ErrorLog0),
 			be64_to_cpu(data->dma1ErrorLog1));
 
-	for (i = 0; i < OPAL_P7IOC_NUM_PEST_REGS; i++) {
-		if ((be64_to_cpu(data->pestA[i]) >> 63) == 0 &&
-		    (be64_to_cpu(data->pestB[i]) >> 63) == 0)
-			continue;
-
-		pr_info("PE[%3d] A/B: %016llx %016llx\n",
-			i, be64_to_cpu(data->pestA[i]),
-			be64_to_cpu(data->pestB[i]));
-	}
+	pnv_pci_dump_pest(data->pestA, data->pestB, OPAL_P7IOC_NUM_PEST_REGS);
 }
 
 static void pnv_pci_dump_phb3_diag_data(struct pci_controller *hose,
 					struct OpalIoPhbErrorCommon *common)
 {
 	struct OpalIoPhb3ErrorData *data;
-	int i;
 
 	data = (struct OpalIoPhb3ErrorData*)common;
 	pr_info("PHB3 PHB#%x Diag-data (Version: %d)\n",
@@ -404,15 +423,7 @@ static void pnv_pci_dump_phb3_diag_data(struct pci_controller *hose,
 			be64_to_cpu(data->dma1ErrorLog0),
 			be64_to_cpu(data->dma1ErrorLog1));
 
-	for (i = 0; i < OPAL_PHB3_NUM_PEST_REGS; i++) {
-		if ((be64_to_cpu(data->pestA[i]) >> 63) == 0 &&
-		    (be64_to_cpu(data->pestB[i]) >> 63) == 0)
-			continue;
-
-		pr_info("PE[%3d] A/B: %016llx %016llx\n",
-				i, be64_to_cpu(data->pestA[i]),
-				be64_to_cpu(data->pestB[i]));
-	}
+	pnv_pci_dump_pest(data->pestA, data->pestB, OPAL_PHB3_NUM_PEST_REGS);
 }
 
 void pnv_pci_dump_phb_diag_data(struct pci_controller *hose,
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index 18c8a2fa03b8..6abc77dd9261 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -33,6 +33,9 @@ enum pnv_phb_model {
 #define PNV_IODA_PE_SLAVE	(1 << 4)	/* Slave PE in compound case	*/
 #define PNV_IODA_PE_VF		(1 << 5)	/* PE for one VF 		*/
 
+/* Indicates operations are frozen for a PE: MMIO in PESTA & DMA in PESTB. */
+#define PNV_IODA_STOPPED_STATE	0x8000000000000000
+
 /* Data associated with a PE, including IOMMU tracking etc.. */
 struct pnv_phb;
 struct pnv_ioda_pe {
-- 
2.13.1
