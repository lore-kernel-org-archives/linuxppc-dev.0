Return-Path: <ruscur@russell.cc>
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com
 [66.111.4.221])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w1fgw5P7rzDq7Z
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Apr 2017 16:01:16 +1000 (AEST)
From: Russell Currey <ruscur@russell.cc>
To: linuxppc-dev@lists.ozlabs.org
Cc: Russell Currey <ruscur@russell.cc>
Subject: [PATCH] powerpc/powernv/pci: Reduce spam when dumping PEST
Date: Mon, 10 Apr 2017 15:53:28 +1000
Message-Id: <20170410055328.11727-1-ruscur@russell.cc>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dumping the PE State Tables (PEST) can be highly verbose if a number of PEs
are affected, especially in the case where the whole PHB is frozen and 255
lines get printed.  Check for duplicates when dumping the PEST to reduce
useless output.

For example:

    PE[f8] A/B: 9700002600000000 80000080d00000f8
    PE[f9] A/B: 8000000000000000 0000000000000000
    PE[..fe] A/B: as above
    PE[ff] A/B: 8440002b00000000 0000000000000000

instead of:

    PE[f8] A/B: 9700002600000000 80000080d00000f8
    PE[f9] A/B: 8000000000000000 0000000000000000
    PE[fa] A/B: 8000000000000000 0000000000000000
    PE[fb] A/B: 8000000000000000 0000000000000000
    PE[fc] A/B: 8000000000000000 0000000000000000
    PE[fd] A/B: 8000000000000000 0000000000000000
    PE[fe] A/B: 8000000000000000 0000000000000000
    PE[ff] A/B: 8440002b00000000 0000000000000000

and you can imagine how much worse it can get for 255 PEs.

Signed-off-by: Russell Currey <ruscur@russell.cc>
---
 arch/powerpc/platforms/powernv/pci.c | 52 ++++++++++++++++++++++--------------
 1 file changed, 32 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index eb835e977e33..303c9d84d3d4 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -227,11 +227,40 @@ void pnv_teardown_msi_irqs(struct pci_dev *pdev)
 }
 #endif /* CONFIG_PCI_MSI */
 
+/* Nicely print the contents of the PE State Tables (PEST). */
+static void pnv_pci_dump_pest(__be64 pestA[], __be64 pestB[], int pest_size)
+{
+	int i;
+	__be64 prevA, prevB;
+	bool dup = false;
+	prevA = prevB = ~0;
+
+	for (i = 0; i < pest_size; i++) {
+		__be64 peA = be64_to_cpu(pestA[i]);
+		__be64 peB = be64_to_cpu(pestB[i]);
+
+		if (peA != prevA || peB != prevB) {
+			if (dup) {
+				pr_info("PE[..%x] A/B: as above\n", i-1);
+				dup = false;
+			}
+			prevA = peA;
+			prevB = peB;
+			if (peA || peB)
+				pr_info("PE[%2x] A/B: %016llx %016llx\n",
+					i, peA, peB);
+		} else {
+			/* Don't need to track zeroes */
+			if (!dup && (peA || peB))
+				dup = true;
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
@@ -308,22 +337,13 @@ static void pnv_pci_dump_p7ioc_diag_data(struct pci_controller *hose,
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
@@ -404,15 +424,7 @@ static void pnv_pci_dump_phb3_diag_data(struct pci_controller *hose,
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
2.12.2
