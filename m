Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 892052C0316
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Feb 2014 18:28:57 +1100 (EST)
Received: from /spool/local
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Tue, 25 Feb 2014 00:28:55 -0700
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 71EAD1FF003B
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Feb 2014 00:28:53 -0700 (MST)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp08025.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s1P7Srwt4588000
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Feb 2014 08:28:53 +0100
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s1P7Sqd2018039
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Feb 2014 00:28:53 -0700
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 5/5] powerpc/powernv: Refactor PHB diag-data dump
Date: Tue, 25 Feb 2014 15:28:38 +0800
Message-Id: <1393313318-6341-6-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1393313318-6341-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1393313318-6341-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

As Ben suggested, the patch prints PHB diag-data with multiple
fields in one line and omits the line if the fields of that
line are all zero.

With the patch applied, the PHB3 diag-data dump looks like:

PHB3 PHB#3 Diag-data (Version: 1)

  brdgCtl:     00000002
  RootSts:     0000000f 00400000 b0830008 00100147 00002000
  nFir:        0000000000000000 0030006e00000000 0000000000000000
  PhbSts:      0000001c00000000 0000000000000000
  Lem:         0000000000100000 42498e327f502eae 0000000000000000
  InAErr:      8000000000000000 8000000000000000 0402030000000000 \
               0000000000000000
  PE[  8] A/B: 8480002b00000000 8000000000000000

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci.c |  220 +++++++++++++++++++---------------
 1 file changed, 125 insertions(+), 95 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index 3955fc0..114e1a7 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -134,57 +134,72 @@ static void pnv_pci_dump_p7ioc_diag_data(struct pci_controller *hose,
 	pr_info("P7IOC PHB#%d Diag-data (Version: %d)\n\n",
 		hose->global_number, common->version);
 
-	pr_info("  brdgCtl:              %08x\n", data->brdgCtl);
-
-	pr_info("  portStatusReg:        %08x\n", data->portStatusReg);
-	pr_info("  rootCmplxStatus:      %08x\n", data->rootCmplxStatus);
-	pr_info("  busAgentStatus:       %08x\n", data->busAgentStatus);
-
-	pr_info("  deviceStatus:         %08x\n", data->deviceStatus);
-	pr_info("  slotStatus:           %08x\n", data->slotStatus);
-	pr_info("  linkStatus:           %08x\n", data->linkStatus);
-	pr_info("  devCmdStatus:         %08x\n", data->devCmdStatus);
-	pr_info("  devSecStatus:         %08x\n", data->devSecStatus);
-
-	pr_info("  rootErrorStatus:      %08x\n", data->rootErrorStatus);
-	pr_info("  uncorrErrorStatus:    %08x\n", data->uncorrErrorStatus);
-	pr_info("  corrErrorStatus:      %08x\n", data->corrErrorStatus);
-	pr_info("  tlpHdr1:              %08x\n", data->tlpHdr1);
-	pr_info("  tlpHdr2:              %08x\n", data->tlpHdr2);
-	pr_info("  tlpHdr3:              %08x\n", data->tlpHdr3);
-	pr_info("  tlpHdr4:              %08x\n", data->tlpHdr4);
-	pr_info("  sourceId:             %08x\n", data->sourceId);
-	pr_info("  errorClass:           %016llx\n", data->errorClass);
-	pr_info("  correlator:           %016llx\n", data->correlator);
-	pr_info("  p7iocPlssr:           %016llx\n", data->p7iocPlssr);
-	pr_info("  p7iocCsr:             %016llx\n", data->p7iocCsr);
-	pr_info("  lemFir:               %016llx\n", data->lemFir);
-	pr_info("  lemErrorMask:         %016llx\n", data->lemErrorMask);
-	pr_info("  lemWOF:               %016llx\n", data->lemWOF);
-	pr_info("  phbErrorStatus:       %016llx\n", data->phbErrorStatus);
-	pr_info("  phbFirstErrorStatus:  %016llx\n", data->phbFirstErrorStatus);
-	pr_info("  phbErrorLog0:         %016llx\n", data->phbErrorLog0);
-	pr_info("  phbErrorLog1:         %016llx\n", data->phbErrorLog1);
-	pr_info("  mmioErrorStatus:      %016llx\n", data->mmioErrorStatus);
-	pr_info("  mmioFirstErrorStatus: %016llx\n", data->mmioFirstErrorStatus);
-	pr_info("  mmioErrorLog0:        %016llx\n", data->mmioErrorLog0);
-	pr_info("  mmioErrorLog1:        %016llx\n", data->mmioErrorLog1);
-	pr_info("  dma0ErrorStatus:      %016llx\n", data->dma0ErrorStatus);
-	pr_info("  dma0FirstErrorStatus: %016llx\n", data->dma0FirstErrorStatus);
-	pr_info("  dma0ErrorLog0:        %016llx\n", data->dma0ErrorLog0);
-	pr_info("  dma0ErrorLog1:        %016llx\n", data->dma0ErrorLog1);
-	pr_info("  dma1ErrorStatus:      %016llx\n", data->dma1ErrorStatus);
-	pr_info("  dma1FirstErrorStatus: %016llx\n", data->dma1FirstErrorStatus);
-	pr_info("  dma1ErrorLog0:        %016llx\n", data->dma1ErrorLog0);
-	pr_info("  dma1ErrorLog1:        %016llx\n", data->dma1ErrorLog1);
+	if (data->brdgCtl)
+		pr_info("  brdgCtl:     %08x\n",
+			data->brdgCtl);
+	if (data->portStatusReg || data->rootCmplxStatus ||
+	    data->busAgentStatus)
+		pr_info("  UtlSts:      %08x %08x %08x\n",
+			data->portStatusReg, data->rootCmplxStatus,
+			data->busAgentStatus);
+	if (data->deviceStatus || data->slotStatus   ||
+	    data->linkStatus   || data->devCmdStatus ||
+	    data->devSecStatus)
+		pr_info("  RootSts:     %08x %08x %08x %08x %08x\n",
+			data->deviceStatus, data->slotStatus,
+			data->linkStatus, data->devCmdStatus,
+			data->devSecStatus);
+	if (data->rootErrorStatus   || data->uncorrErrorStatus ||
+	    data->corrErrorStatus)
+		pr_info("  RootErrSts:  %08x %08x %08x\n",
+			data->rootErrorStatus, data->uncorrErrorStatus,
+			data->corrErrorStatus);
+	if (data->tlpHdr1 || data->tlpHdr2 ||
+	    data->tlpHdr3 || data->tlpHdr4)
+		pr_info("  RootErrLog:  %08x %08x %08x %08x\n",
+			data->tlpHdr1, data->tlpHdr2,
+			data->tlpHdr3, data->tlpHdr4);
+	if (data->sourceId || data->errorClass ||
+	    data->correlator)
+		pr_info("  RootErrLog1: %08x %016llx %016llx\n",
+			data->sourceId, data->errorClass,
+			data->correlator);
+	if (data->p7iocPlssr || data->p7iocCsr)
+		pr_info("  PhbSts:      %016llx %016llx\n",
+			data->p7iocPlssr, data->p7iocCsr);
+	if (data->lemFir || data->lemErrorMask ||
+	    data->lemWOF)
+		pr_info("  Lem:         %016llx %016llx %016llx\n",
+			data->lemFir, data->lemErrorMask,
+			data->lemWOF);
+	if (data->phbErrorStatus || data->phbFirstErrorStatus ||
+	    data->phbErrorLog0   || data->phbErrorLog1)
+		pr_info("  PhbErr:      %016llx %016llx %016llx %016llx\n",
+			data->phbErrorStatus, data->phbFirstErrorStatus,
+			data->phbErrorLog0, data->phbErrorLog1);
+	if (data->mmioErrorStatus || data->mmioFirstErrorStatus ||
+	    data->mmioErrorLog0   || data->mmioErrorLog1)
+		pr_info("  OutErr:      %016llx %016llx %016llx %016llx\n",
+			data->mmioErrorStatus, data->mmioFirstErrorStatus,
+			data->mmioErrorLog0, data->mmioErrorLog1);
+	if (data->dma0ErrorStatus || data->dma0FirstErrorStatus ||
+	    data->dma0ErrorLog0   || data->dma0ErrorLog1)
+		pr_info("  InAErr:      %016llx %016llx %016llx %016llx\n",
+			data->dma0ErrorStatus, data->dma0FirstErrorStatus,
+			data->dma0ErrorLog0, data->dma0ErrorLog1);
+	if (data->dma1ErrorStatus || data->dma1FirstErrorStatus ||
+	    data->dma1ErrorLog0   || data->dma1ErrorLog1)
+		pr_info("  InBErr:      %016llx %016llx %016llx %016llx\n",
+			data->dma1ErrorStatus, data->dma1FirstErrorStatus,
+			data->dma1ErrorLog0, data->dma1ErrorLog1);
 
 	for (i = 0; i < OPAL_P7IOC_NUM_PEST_REGS; i++) {
 		if ((data->pestA[i] >> 63) == 0 &&
 		    (data->pestB[i] >> 63) == 0)
 			continue;
 
-		pr_info("  PE[%3d] PESTA:        %016llx\n", i, data->pestA[i]);
-		pr_info("          PESTB:        %016llx\n", data->pestB[i]);
+		pr_info("  PE[%3d] A/B: %016llx %016llx\n",
+			i, data->pestA[i], data->pestB[i]);
 	}
 }
 
@@ -197,62 +212,77 @@ static void pnv_pci_dump_phb3_diag_data(struct pci_controller *hose,
 	data = (struct OpalIoPhb3ErrorData*)common;
 	pr_info("PHB3 PHB#%d Diag-data (Version: %d)\n\n",
 		hose->global_number, common->version);
-
-	pr_info("  brdgCtl:              %08x\n", data->brdgCtl);
-
-	pr_info("  portStatusReg:        %08x\n", data->portStatusReg);
-	pr_info("  rootCmplxStatus:      %08x\n", data->rootCmplxStatus);
-	pr_info("  busAgentStatus:       %08x\n", data->busAgentStatus);
-
-	pr_info("  deviceStatus:         %08x\n", data->deviceStatus);
-	pr_info("  slotStatus:           %08x\n", data->slotStatus);
-	pr_info("  linkStatus:           %08x\n", data->linkStatus);
-	pr_info("  devCmdStatus:         %08x\n", data->devCmdStatus);
-	pr_info("  devSecStatus:         %08x\n", data->devSecStatus);
-
-	pr_info("  rootErrorStatus:      %08x\n", data->rootErrorStatus);
-	pr_info("  uncorrErrorStatus:    %08x\n", data->uncorrErrorStatus);
-	pr_info("  corrErrorStatus:      %08x\n", data->corrErrorStatus);
-	pr_info("  tlpHdr1:              %08x\n", data->tlpHdr1);
-	pr_info("  tlpHdr2:              %08x\n", data->tlpHdr2);
-	pr_info("  tlpHdr3:              %08x\n", data->tlpHdr3);
-	pr_info("  tlpHdr4:              %08x\n", data->tlpHdr4);
-	pr_info("  sourceId:             %08x\n", data->sourceId);
-	pr_info("  errorClass:           %016llx\n", data->errorClass);
-	pr_info("  correlator:           %016llx\n", data->correlator);
-
-	pr_info("  nFir:                 %016llx\n", data->nFir);
-	pr_info("  nFirMask:             %016llx\n", data->nFirMask);
-	pr_info("  nFirWOF:              %016llx\n", data->nFirWOF);
-	pr_info("  PhbPlssr:             %016llx\n", data->phbPlssr);
-	pr_info("  PhbCsr:               %016llx\n", data->phbCsr);
-	pr_info("  lemFir:               %016llx\n", data->lemFir);
-	pr_info("  lemErrorMask:         %016llx\n", data->lemErrorMask);
-	pr_info("  lemWOF:               %016llx\n", data->lemWOF);
-	pr_info("  phbErrorStatus:       %016llx\n", data->phbErrorStatus);
-	pr_info("  phbFirstErrorStatus:  %016llx\n", data->phbFirstErrorStatus);
-	pr_info("  phbErrorLog0:         %016llx\n", data->phbErrorLog0);
-	pr_info("  phbErrorLog1:         %016llx\n", data->phbErrorLog1);
-	pr_info("  mmioErrorStatus:      %016llx\n", data->mmioErrorStatus);
-	pr_info("  mmioFirstErrorStatus: %016llx\n", data->mmioFirstErrorStatus);
-	pr_info("  mmioErrorLog0:        %016llx\n", data->mmioErrorLog0);
-	pr_info("  mmioErrorLog1:        %016llx\n", data->mmioErrorLog1);
-	pr_info("  dma0ErrorStatus:      %016llx\n", data->dma0ErrorStatus);
-	pr_info("  dma0FirstErrorStatus: %016llx\n", data->dma0FirstErrorStatus);
-	pr_info("  dma0ErrorLog0:        %016llx\n", data->dma0ErrorLog0);
-	pr_info("  dma0ErrorLog1:        %016llx\n", data->dma0ErrorLog1);
-	pr_info("  dma1ErrorStatus:      %016llx\n", data->dma1ErrorStatus);
-	pr_info("  dma1FirstErrorStatus: %016llx\n", data->dma1FirstErrorStatus);
-	pr_info("  dma1ErrorLog0:        %016llx\n", data->dma1ErrorLog0);
-	pr_info("  dma1ErrorLog1:        %016llx\n", data->dma1ErrorLog1);
+	if (data->brdgCtl)
+		pr_info("  brdgCtl:     %08x\n",
+			data->brdgCtl);
+	if (data->portStatusReg || data->rootCmplxStatus ||
+	    data->busAgentStatus)
+		pr_info("  UtlSts:      %08x %08x %08x\n",
+			data->portStatusReg, data->rootCmplxStatus,
+			data->busAgentStatus);
+	if (data->deviceStatus || data->slotStatus   ||
+	    data->linkStatus   || data->devCmdStatus ||
+	    data->devSecStatus)
+		pr_info("  RootSts:     %08x %08x %08x %08x %08x\n",
+			data->deviceStatus, data->slotStatus,
+			data->linkStatus, data->devCmdStatus,
+			data->devSecStatus);
+	if (data->rootErrorStatus || data->uncorrErrorStatus ||
+	    data->corrErrorStatus)
+		pr_info("  RootErrSts:  %08x %08x %08x\n",
+			data->rootErrorStatus, data->uncorrErrorStatus,
+			data->corrErrorStatus);
+	if (data->tlpHdr1 || data->tlpHdr2 ||
+	    data->tlpHdr3 || data->tlpHdr4)
+		pr_info("  RootErrLog:  %08x %08x %08x %08x\n",
+			data->tlpHdr1, data->tlpHdr2,
+			data->tlpHdr3, data->tlpHdr4);
+	if (data->sourceId || data->errorClass ||
+	    data->correlator)
+		pr_info("  RootErrLog1: %08x %016llx %016llx\n",
+			data->sourceId, data->errorClass,
+			data->correlator);
+	if (data->nFir || data->nFirMask ||
+	    data->nFirWOF)
+		pr_info("  nFir:        %016llx %016llx %016llx\n",
+			data->nFir, data->nFirMask,
+			data->nFirWOF);
+	if (data->phbPlssr || data->phbCsr)
+		pr_info("  PhbSts:      %016llx %016llx\n",
+			data->phbPlssr, data->phbCsr);
+	if (data->lemFir || data->lemErrorMask ||
+	    data->lemWOF)
+		pr_info("  Lem:         %016llx %016llx %016llx\n",
+			data->lemFir, data->lemErrorMask,
+			data->lemWOF);
+	if (data->phbErrorStatus || data->phbFirstErrorStatus ||
+	    data->phbErrorLog0   || data->phbErrorLog1)
+		pr_info("  PhbErr:      %016llx %016llx %016llx %016llx\n",
+			data->phbErrorStatus, data->phbFirstErrorStatus,
+			data->phbErrorLog0, data->phbErrorLog1);
+	if (data->mmioErrorStatus || data->mmioFirstErrorStatus ||
+	    data->mmioErrorLog0   || data->mmioErrorLog1)
+		pr_info("  OutErr:      %016llx %016llx %016llx %016llx\n",
+			data->mmioErrorStatus, data->mmioFirstErrorStatus,
+			data->mmioErrorLog0, data->mmioErrorLog1);
+	if (data->dma0ErrorStatus || data->dma0FirstErrorStatus ||
+	    data->dma0ErrorLog0   || data->dma0ErrorLog1)
+		pr_info("  InAErr:      %016llx %016llx %016llx %016llx\n",
+			data->dma0ErrorStatus, data->dma0FirstErrorStatus,
+			data->dma0ErrorLog0, data->dma0ErrorLog1);
+	if (data->dma1ErrorStatus || data->dma1FirstErrorStatus ||
+	    data->dma1ErrorLog0   || data->dma1ErrorLog1)
+		pr_info("  InBErr:      %016llx %016llx %016llx %016llx\n",
+			data->dma1ErrorStatus, data->dma1FirstErrorStatus,
+			data->dma1ErrorLog0, data->dma1ErrorLog1);
 
 	for (i = 0; i < OPAL_PHB3_NUM_PEST_REGS; i++) {
 		if ((data->pestA[i] >> 63) == 0 &&
 		    (data->pestB[i] >> 63) == 0)
 			continue;
 
-		pr_info("  PE[%3d] PESTA:        %016llx\n", i, data->pestA[i]);
-		pr_info("          PESTB:        %016llx\n", data->pestB[i]);
+		pr_info("  PE[%3d] A/B: %016llx %016llx\n",
+			i, data->pestA[i], data->pestB[i]);
 	}
 }
 
-- 
1.7.10.4
