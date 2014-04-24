Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 68848140122
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 18:00:30 +1000 (EST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 24 Apr 2014 18:00:29 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 7816D3578047
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 18:00:26 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s3O80BZZ4063610
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 18:00:11 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s3O80PeK014801
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 18:00:26 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: [PATCH 04/25] powerpc/powernv: Remove fields in PHB diag-data dump
Date: Thu, 24 Apr 2014 18:00:10 +1000
Message-Id: <1398326431-24305-5-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1398326431-24305-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1398326431-24305-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

For some fields (e.g. LEM, MMIO, DMA) in PHB diag-data dump, it's
meaningless to print them if they have non-zero value in the
corresponding mask registers because we always have non-zero values
in the mask registers. The patch only prints those fieds if we
have non-zero values in the primary registers (e.g. LEM, MMIO, DMA
status) so that we can save couple of lines. The patch also removes
unnecessary spare line before "brdgCtl:" and two leading spaces as
prefix in each line as Ben suggested.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci.c | 91 ++++++++++++++++--------------------
 1 file changed, 40 insertions(+), 51 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index 114e1a7..2de283d 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -131,65 +131,60 @@ static void pnv_pci_dump_p7ioc_diag_data(struct pci_controller *hose,
 	int i;
 
 	data = (struct OpalIoP7IOCPhbErrorData *)common;
-	pr_info("P7IOC PHB#%d Diag-data (Version: %d)\n\n",
+	pr_info("P7IOC PHB#%d Diag-data (Version: %d)\n",
 		hose->global_number, common->version);
 
 	if (data->brdgCtl)
-		pr_info("  brdgCtl:     %08x\n",
+		pr_info("brdgCtl:     %08x\n",
 			data->brdgCtl);
 	if (data->portStatusReg || data->rootCmplxStatus ||
 	    data->busAgentStatus)
-		pr_info("  UtlSts:      %08x %08x %08x\n",
+		pr_info("UtlSts:      %08x %08x %08x\n",
 			data->portStatusReg, data->rootCmplxStatus,
 			data->busAgentStatus);
 	if (data->deviceStatus || data->slotStatus   ||
 	    data->linkStatus   || data->devCmdStatus ||
 	    data->devSecStatus)
-		pr_info("  RootSts:     %08x %08x %08x %08x %08x\n",
+		pr_info("RootSts:     %08x %08x %08x %08x %08x\n",
 			data->deviceStatus, data->slotStatus,
 			data->linkStatus, data->devCmdStatus,
 			data->devSecStatus);
 	if (data->rootErrorStatus   || data->uncorrErrorStatus ||
 	    data->corrErrorStatus)
-		pr_info("  RootErrSts:  %08x %08x %08x\n",
+		pr_info("RootErrSts:  %08x %08x %08x\n",
 			data->rootErrorStatus, data->uncorrErrorStatus,
 			data->corrErrorStatus);
 	if (data->tlpHdr1 || data->tlpHdr2 ||
 	    data->tlpHdr3 || data->tlpHdr4)
-		pr_info("  RootErrLog:  %08x %08x %08x %08x\n",
+		pr_info("RootErrLog:  %08x %08x %08x %08x\n",
 			data->tlpHdr1, data->tlpHdr2,
 			data->tlpHdr3, data->tlpHdr4);
 	if (data->sourceId || data->errorClass ||
 	    data->correlator)
-		pr_info("  RootErrLog1: %08x %016llx %016llx\n",
+		pr_info("RootErrLog1: %08x %016llx %016llx\n",
 			data->sourceId, data->errorClass,
 			data->correlator);
 	if (data->p7iocPlssr || data->p7iocCsr)
-		pr_info("  PhbSts:      %016llx %016llx\n",
+		pr_info("PhbSts:      %016llx %016llx\n",
 			data->p7iocPlssr, data->p7iocCsr);
-	if (data->lemFir || data->lemErrorMask ||
-	    data->lemWOF)
-		pr_info("  Lem:         %016llx %016llx %016llx\n",
+	if (data->lemFir)
+		pr_info("Lem:         %016llx %016llx %016llx\n",
 			data->lemFir, data->lemErrorMask,
 			data->lemWOF);
-	if (data->phbErrorStatus || data->phbFirstErrorStatus ||
-	    data->phbErrorLog0   || data->phbErrorLog1)
-		pr_info("  PhbErr:      %016llx %016llx %016llx %016llx\n",
+	if (data->phbErrorStatus)
+		pr_info("PhbErr:      %016llx %016llx %016llx %016llx\n",
 			data->phbErrorStatus, data->phbFirstErrorStatus,
 			data->phbErrorLog0, data->phbErrorLog1);
-	if (data->mmioErrorStatus || data->mmioFirstErrorStatus ||
-	    data->mmioErrorLog0   || data->mmioErrorLog1)
-		pr_info("  OutErr:      %016llx %016llx %016llx %016llx\n",
+	if (data->mmioErrorStatus)
+		pr_info("OutErr:      %016llx %016llx %016llx %016llx\n",
 			data->mmioErrorStatus, data->mmioFirstErrorStatus,
 			data->mmioErrorLog0, data->mmioErrorLog1);
-	if (data->dma0ErrorStatus || data->dma0FirstErrorStatus ||
-	    data->dma0ErrorLog0   || data->dma0ErrorLog1)
-		pr_info("  InAErr:      %016llx %016llx %016llx %016llx\n",
+	if (data->dma0ErrorStatus)
+		pr_info("InAErr:      %016llx %016llx %016llx %016llx\n",
 			data->dma0ErrorStatus, data->dma0FirstErrorStatus,
 			data->dma0ErrorLog0, data->dma0ErrorLog1);
-	if (data->dma1ErrorStatus || data->dma1FirstErrorStatus ||
-	    data->dma1ErrorLog0   || data->dma1ErrorLog1)
-		pr_info("  InBErr:      %016llx %016llx %016llx %016llx\n",
+	if (data->dma1ErrorStatus)
+		pr_info("InBErr:      %016llx %016llx %016llx %016llx\n",
 			data->dma1ErrorStatus, data->dma1FirstErrorStatus,
 			data->dma1ErrorLog0, data->dma1ErrorLog1);
 
@@ -198,7 +193,7 @@ static void pnv_pci_dump_p7ioc_diag_data(struct pci_controller *hose,
 		    (data->pestB[i] >> 63) == 0)
 			continue;
 
-		pr_info("  PE[%3d] A/B: %016llx %016llx\n",
+		pr_info("PE[%3d] A/B: %016llx %016llx\n",
 			i, data->pestA[i], data->pestB[i]);
 	}
 }
@@ -210,69 +205,63 @@ static void pnv_pci_dump_phb3_diag_data(struct pci_controller *hose,
 	int i;
 
 	data = (struct OpalIoPhb3ErrorData*)common;
-	pr_info("PHB3 PHB#%d Diag-data (Version: %d)\n\n",
+	pr_info("PHB3 PHB#%d Diag-data (Version: %d)\n",
 		hose->global_number, common->version);
 	if (data->brdgCtl)
-		pr_info("  brdgCtl:     %08x\n",
+		pr_info("brdgCtl:     %08x\n",
 			data->brdgCtl);
 	if (data->portStatusReg || data->rootCmplxStatus ||
 	    data->busAgentStatus)
-		pr_info("  UtlSts:      %08x %08x %08x\n",
+		pr_info("UtlSts:      %08x %08x %08x\n",
 			data->portStatusReg, data->rootCmplxStatus,
 			data->busAgentStatus);
 	if (data->deviceStatus || data->slotStatus   ||
 	    data->linkStatus   || data->devCmdStatus ||
 	    data->devSecStatus)
-		pr_info("  RootSts:     %08x %08x %08x %08x %08x\n",
+		pr_info("RootSts:     %08x %08x %08x %08x %08x\n",
 			data->deviceStatus, data->slotStatus,
 			data->linkStatus, data->devCmdStatus,
 			data->devSecStatus);
 	if (data->rootErrorStatus || data->uncorrErrorStatus ||
 	    data->corrErrorStatus)
-		pr_info("  RootErrSts:  %08x %08x %08x\n",
+		pr_info("RootErrSts:  %08x %08x %08x\n",
 			data->rootErrorStatus, data->uncorrErrorStatus,
 			data->corrErrorStatus);
 	if (data->tlpHdr1 || data->tlpHdr2 ||
 	    data->tlpHdr3 || data->tlpHdr4)
-		pr_info("  RootErrLog:  %08x %08x %08x %08x\n",
+		pr_info("RootErrLog:  %08x %08x %08x %08x\n",
 			data->tlpHdr1, data->tlpHdr2,
 			data->tlpHdr3, data->tlpHdr4);
 	if (data->sourceId || data->errorClass ||
 	    data->correlator)
-		pr_info("  RootErrLog1: %08x %016llx %016llx\n",
+		pr_info("RootErrLog1: %08x %016llx %016llx\n",
 			data->sourceId, data->errorClass,
 			data->correlator);
-	if (data->nFir || data->nFirMask ||
-	    data->nFirWOF)
-		pr_info("  nFir:        %016llx %016llx %016llx\n",
+	if (data->nFir)
+		pr_info("nFir:        %016llx %016llx %016llx\n",
 			data->nFir, data->nFirMask,
 			data->nFirWOF);
 	if (data->phbPlssr || data->phbCsr)
-		pr_info("  PhbSts:      %016llx %016llx\n",
+		pr_info("PhbSts:      %016llx %016llx\n",
 			data->phbPlssr, data->phbCsr);
-	if (data->lemFir || data->lemErrorMask ||
-	    data->lemWOF)
-		pr_info("  Lem:         %016llx %016llx %016llx\n",
+	if (data->lemFir)
+		pr_info("Lem:         %016llx %016llx %016llx\n",
 			data->lemFir, data->lemErrorMask,
 			data->lemWOF);
-	if (data->phbErrorStatus || data->phbFirstErrorStatus ||
-	    data->phbErrorLog0   || data->phbErrorLog1)
-		pr_info("  PhbErr:      %016llx %016llx %016llx %016llx\n",
+	if (data->phbErrorStatus)
+		pr_info("PhbErr:      %016llx %016llx %016llx %016llx\n",
 			data->phbErrorStatus, data->phbFirstErrorStatus,
 			data->phbErrorLog0, data->phbErrorLog1);
-	if (data->mmioErrorStatus || data->mmioFirstErrorStatus ||
-	    data->mmioErrorLog0   || data->mmioErrorLog1)
-		pr_info("  OutErr:      %016llx %016llx %016llx %016llx\n",
+	if (data->mmioErrorStatus)
+		pr_info("OutErr:      %016llx %016llx %016llx %016llx\n",
 			data->mmioErrorStatus, data->mmioFirstErrorStatus,
 			data->mmioErrorLog0, data->mmioErrorLog1);
-	if (data->dma0ErrorStatus || data->dma0FirstErrorStatus ||
-	    data->dma0ErrorLog0   || data->dma0ErrorLog1)
-		pr_info("  InAErr:      %016llx %016llx %016llx %016llx\n",
+	if (data->dma0ErrorStatus)
+		pr_info("InAErr:      %016llx %016llx %016llx %016llx\n",
 			data->dma0ErrorStatus, data->dma0FirstErrorStatus,
 			data->dma0ErrorLog0, data->dma0ErrorLog1);
-	if (data->dma1ErrorStatus || data->dma1FirstErrorStatus ||
-	    data->dma1ErrorLog0   || data->dma1ErrorLog1)
-		pr_info("  InBErr:      %016llx %016llx %016llx %016llx\n",
+	if (data->dma1ErrorStatus)
+		pr_info("InBErr:      %016llx %016llx %016llx %016llx\n",
 			data->dma1ErrorStatus, data->dma1FirstErrorStatus,
 			data->dma1ErrorLog0, data->dma1ErrorLog1);
 
@@ -281,7 +270,7 @@ static void pnv_pci_dump_phb3_diag_data(struct pci_controller *hose,
 		    (data->pestB[i] >> 63) == 0)
 			continue;
 
-		pr_info("  PE[%3d] A/B: %016llx %016llx\n",
+		pr_info("PE[%3d] A/B: %016llx %016llx\n",
 			i, data->pestA[i], data->pestB[i]);
 	}
 }
-- 
1.8.3.2
