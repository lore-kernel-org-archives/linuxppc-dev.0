Return-Path: <ruscur@russell.cc>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wcMy56wCLzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 May 2017 15:45:01 +1000 (AEST)
From: Russell Currey <ruscur@russell.cc>
To: linuxppc-dev@lists.ozlabs.org
Cc: Russell Currey <ruscur@russell.cc>
Subject: [PATCH 1/3] powerpc/powernv/pci: Reduce spam when dumping PEST
Date: Tue, 30 May 2017 15:44:38 +1000
Message-Id: <20170530054440.9297-1-ruscur@russell.cc>
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
This is essentially V2 of a previous patch I submitted, with some changes
thanks to feedback from Gavin.
---
 arch/powerpc/platforms/powernv/pci.c | 50 +++++++++++++++++++++---------------
 1 file changed, 30 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index 935ccb249a8a..4852ac8d0b4d 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -227,11 +227,38 @@ void pnv_teardown_msi_irqs(struct pci_dev *pdev)
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
+			if (peA >> 63 || peB >> 63)
+				pr_info("PE[%03x] A/B: %016llx %016llx\n",
+					i, peA, peB);
+		} else if (!dup && (peA >> 63 || peB >> 63)) {
+			/* Don't need to track zeroes */
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
@@ -308,22 +335,13 @@ static void pnv_pci_dump_p7ioc_diag_data(struct pci_controller *hose,
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
@@ -404,15 +422,7 @@ static void pnv_pci_dump_phb3_diag_data(struct pci_controller *hose,
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
-- 
2.13.0
