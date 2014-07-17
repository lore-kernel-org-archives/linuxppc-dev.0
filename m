Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 39E701A03A6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Jul 2014 14:41:49 +1000 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 17 Jul 2014 14:41:48 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id ECD732BB0057
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Jul 2014 14:41:45 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6H4J1Z264749606
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Jul 2014 14:19:01 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6H4fjGI013366
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Jul 2014 14:41:45 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 5/6] powerpc/eeh: Make diag-data not endian dependent
Date: Thu, 17 Jul 2014 14:41:42 +1000
Message-Id: <1405572103-32152-6-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1405572103-32152-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1405572103-32152-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: Guo Chao <yan@linux.vnet.ibm.com>, Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

It's followup of commit ddf0322a ("powerpc/powernv: Fix endianness
problems in EEH"). The patch helps to get non-endian-dependent
diag-data.

Cc: Guo Chao <yan@linux.vnet.ibm.com>
Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/opal.h           | 128 +++++++++++++++---------------
 arch/powerpc/platforms/powernv/eeh-ioda.c |  51 +++++++-----
 arch/powerpc/platforms/powernv/pci.c      |  68 ++++++++++------
 3 files changed, 139 insertions(+), 108 deletions(-)

diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index edbfe1c..f0b5b40 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -520,40 +520,40 @@ enum {
 };
 
 struct OpalIoP7IOCErrorData {
-	uint16_t type;
+	__be16 type;
 
 	/* GEM */
-	uint64_t gemXfir;
-	uint64_t gemRfir;
-	uint64_t gemRirqfir;
-	uint64_t gemMask;
-	uint64_t gemRwof;
+	__be64 gemXfir;
+	__be64 gemRfir;
+	__be64 gemRirqfir;
+	__be64 gemMask;
+	__be64 gemRwof;
 
 	/* LEM */
-	uint64_t lemFir;
-	uint64_t lemErrMask;
-	uint64_t lemAction0;
-	uint64_t lemAction1;
-	uint64_t lemWof;
+	__be64 lemFir;
+	__be64 lemErrMask;
+	__be64 lemAction0;
+	__be64 lemAction1;
+	__be64 lemWof;
 
 	union {
 		struct OpalIoP7IOCRgcErrorData {
-			uint64_t rgcStatus;		/* 3E1C10 */
-			uint64_t rgcLdcp;		/* 3E1C18 */
+			__be64 rgcStatus;	/* 3E1C10 */
+			__be64 rgcLdcp;		/* 3E1C18 */
 		}rgc;
 		struct OpalIoP7IOCBiErrorData {
-			uint64_t biLdcp0;		/* 3C0100, 3C0118 */
-			uint64_t biLdcp1;		/* 3C0108, 3C0120 */
-			uint64_t biLdcp2;		/* 3C0110, 3C0128 */
-			uint64_t biFenceStatus;		/* 3C0130, 3C0130 */
+			__be64 biLdcp0;		/* 3C0100, 3C0118 */
+			__be64 biLdcp1;		/* 3C0108, 3C0120 */
+			__be64 biLdcp2;		/* 3C0110, 3C0128 */
+			__be64 biFenceStatus;	/* 3C0130, 3C0130 */
 
-			uint8_t  biDownbound;		/* BI Downbound or Upbound */
+			    u8 biDownbound;	/* BI Downbound or Upbound */
 		}bi;
 		struct OpalIoP7IOCCiErrorData {
-			uint64_t ciPortStatus;		/* 3Dn008 */
-			uint64_t ciPortLdcp;		/* 3Dn010 */
+			__be64 ciPortStatus;	/* 3Dn008 */
+			__be64 ciPortLdcp;	/* 3Dn010 */
 
-			uint8_t	 ciPort;		/* Index of CI port: 0/1 */
+			    u8 ciPort;		/* Index of CI port: 0/1 */
 		}ci;
 	};
 };
@@ -585,60 +585,60 @@ struct OpalIoPhbErrorCommon {
 struct OpalIoP7IOCPhbErrorData {
 	struct OpalIoPhbErrorCommon common;
 
-	uint32_t brdgCtl;
+	__be32 brdgCtl;
 
 	// P7IOC utl regs
-	uint32_t portStatusReg;
-	uint32_t rootCmplxStatus;
-	uint32_t busAgentStatus;
+	__be32 portStatusReg;
+	__be32 rootCmplxStatus;
+	__be32 busAgentStatus;
 
 	// P7IOC cfg regs
-	uint32_t deviceStatus;
-	uint32_t slotStatus;
-	uint32_t linkStatus;
-	uint32_t devCmdStatus;
-	uint32_t devSecStatus;
+	__be32 deviceStatus;
+	__be32 slotStatus;
+	__be32 linkStatus;
+	__be32 devCmdStatus;
+	__be32 devSecStatus;
 
 	// cfg AER regs
-	uint32_t rootErrorStatus;
-	uint32_t uncorrErrorStatus;
-	uint32_t corrErrorStatus;
-	uint32_t tlpHdr1;
-	uint32_t tlpHdr2;
-	uint32_t tlpHdr3;
-	uint32_t tlpHdr4;
-	uint32_t sourceId;
+	__be32 rootErrorStatus;
+	__be32 uncorrErrorStatus;
+	__be32 corrErrorStatus;
+	__be32 tlpHdr1;
+	__be32 tlpHdr2;
+	__be32 tlpHdr3;
+	__be32 tlpHdr4;
+	__be32 sourceId;
 
-	uint32_t rsv3;
+	__be32 rsv3;
 
 	// Record data about the call to allocate a buffer.
-	uint64_t errorClass;
-	uint64_t correlator;
+	__be64 errorClass;
+	__be64 correlator;
 
 	//P7IOC MMIO Error Regs
-	uint64_t p7iocPlssr;                // n120
-	uint64_t p7iocCsr;                  // n110
-	uint64_t lemFir;                    // nC00
-	uint64_t lemErrorMask;              // nC18
-	uint64_t lemWOF;                    // nC40
-	uint64_t phbErrorStatus;            // nC80
-	uint64_t phbFirstErrorStatus;       // nC88
-	uint64_t phbErrorLog0;              // nCC0
-	uint64_t phbErrorLog1;              // nCC8
-	uint64_t mmioErrorStatus;           // nD00
-	uint64_t mmioFirstErrorStatus;      // nD08
-	uint64_t mmioErrorLog0;             // nD40
-	uint64_t mmioErrorLog1;             // nD48
-	uint64_t dma0ErrorStatus;           // nD80
-	uint64_t dma0FirstErrorStatus;      // nD88
-	uint64_t dma0ErrorLog0;             // nDC0
-	uint64_t dma0ErrorLog1;             // nDC8
-	uint64_t dma1ErrorStatus;           // nE00
-	uint64_t dma1FirstErrorStatus;      // nE08
-	uint64_t dma1ErrorLog0;             // nE40
-	uint64_t dma1ErrorLog1;             // nE48
-	uint64_t pestA[OPAL_P7IOC_NUM_PEST_REGS];
-	uint64_t pestB[OPAL_P7IOC_NUM_PEST_REGS];
+	__be64 p7iocPlssr;                // n120
+	__be64 p7iocCsr;                  // n110
+	__be64 lemFir;                    // nC00
+	__be64 lemErrorMask;              // nC18
+	__be64 lemWOF;                    // nC40
+	__be64 phbErrorStatus;            // nC80
+	__be64 phbFirstErrorStatus;       // nC88
+	__be64 phbErrorLog0;              // nCC0
+	__be64 phbErrorLog1;              // nCC8
+	__be64 mmioErrorStatus;           // nD00
+	__be64 mmioFirstErrorStatus;      // nD08
+	__be64 mmioErrorLog0;             // nD40
+	__be64 mmioErrorLog1;             // nD48
+	__be64 dma0ErrorStatus;           // nD80
+	__be64 dma0FirstErrorStatus;      // nD88
+	__be64 dma0ErrorLog0;             // nDC0
+	__be64 dma0ErrorLog1;             // nDC8
+	__be64 dma1ErrorStatus;           // nE00
+	__be64 dma1FirstErrorStatus;      // nE08
+	__be64 dma1ErrorLog0;             // nE40
+	__be64 dma1ErrorLog1;             // nE48
+	__be64 pestA[OPAL_P7IOC_NUM_PEST_REGS];
+	__be64 pestB[OPAL_P7IOC_NUM_PEST_REGS];
 };
 
 struct OpalIoPhb3ErrorData {
diff --git a/arch/powerpc/platforms/powernv/eeh-ioda.c b/arch/powerpc/platforms/powernv/eeh-ioda.c
index edec622..bccdf60 100644
--- a/arch/powerpc/platforms/powernv/eeh-ioda.c
+++ b/arch/powerpc/platforms/powernv/eeh-ioda.c
@@ -639,18 +639,24 @@ static int ioda_eeh_configure_bridge(struct eeh_pe *pe)
 static void ioda_eeh_hub_diag_common(struct OpalIoP7IOCErrorData *data)
 {
 	/* GEM */
-	pr_info("  GEM XFIR:        %016llx\n", data->gemXfir);
-	pr_info("  GEM RFIR:        %016llx\n", data->gemRfir);
-	pr_info("  GEM RIRQFIR:     %016llx\n", data->gemRirqfir);
-	pr_info("  GEM Mask:        %016llx\n", data->gemMask);
-	pr_info("  GEM RWOF:        %016llx\n", data->gemRwof);
+	if (data->gemXfir || data->gemRfir ||
+	    data->gemRirqfir || data->gemMask || data->gemRwof)
+		pr_info("  GEM: %016llx %016llx %016llx %016llx %016llx\n",
+			be64_to_cpu(data->gemXfir),
+			be64_to_cpu(data->gemRfir),
+			be64_to_cpu(data->gemRirqfir),
+			be64_to_cpu(data->gemMask),
+			be64_to_cpu(data->gemRwof));
 
 	/* LEM */
-	pr_info("  LEM FIR:         %016llx\n", data->lemFir);
-	pr_info("  LEM Error Mask:  %016llx\n", data->lemErrMask);
-	pr_info("  LEM Action 0:    %016llx\n", data->lemAction0);
-	pr_info("  LEM Action 1:    %016llx\n", data->lemAction1);
-	pr_info("  LEM WOF:         %016llx\n", data->lemWof);
+	if (data->lemFir || data->lemErrMask ||
+	    data->lemAction0 || data->lemAction1 || data->lemWof)
+		pr_info("  LEM: %016llx %016llx %016llx %016llx %016llx\n",
+			be64_to_cpu(data->lemFir),
+			be64_to_cpu(data->lemErrMask),
+			be64_to_cpu(data->lemAction0),
+			be64_to_cpu(data->lemAction1),
+			be64_to_cpu(data->lemWof));
 }
 
 static void ioda_eeh_hub_diag(struct pci_controller *hose)
@@ -670,24 +676,31 @@ static void ioda_eeh_hub_diag(struct pci_controller *hose)
 	case OPAL_P7IOC_DIAG_TYPE_RGC:
 		pr_info("P7IOC diag-data for RGC\n\n");
 		ioda_eeh_hub_diag_common(data);
-		pr_info("  RGC Status:      %016llx\n", data->rgc.rgcStatus);
-		pr_info("  RGC LDCP:        %016llx\n", data->rgc.rgcLdcp);
+		if (data->rgc.rgcStatus || data->rgc.rgcLdcp)
+			pr_info("  RGC: %016llx %016llx\n",
+				be64_to_cpu(data->rgc.rgcStatus),
+				be64_to_cpu(data->rgc.rgcLdcp));
 		break;
 	case OPAL_P7IOC_DIAG_TYPE_BI:
 		pr_info("P7IOC diag-data for BI %s\n\n",
 			data->bi.biDownbound ? "Downbound" : "Upbound");
 		ioda_eeh_hub_diag_common(data);
-		pr_info("  BI LDCP 0:       %016llx\n", data->bi.biLdcp0);
-		pr_info("  BI LDCP 1:       %016llx\n", data->bi.biLdcp1);
-		pr_info("  BI LDCP 2:       %016llx\n", data->bi.biLdcp2);
-		pr_info("  BI Fence Status: %016llx\n", data->bi.biFenceStatus);
+		if (data->bi.biLdcp0 || data->bi.biLdcp1 ||
+		    data->bi.biLdcp2 || data->bi.biFenceStatus)
+			pr_info("  BI:  %016llx %016llx %016llx %016llx\n",
+				be64_to_cpu(data->bi.biLdcp0),
+				be64_to_cpu(data->bi.biLdcp1),
+				be64_to_cpu(data->bi.biLdcp2),
+				be64_to_cpu(data->bi.biFenceStatus));
 		break;
 	case OPAL_P7IOC_DIAG_TYPE_CI:
-		pr_info("P7IOC diag-data for CI Port %d\\nn",
+		pr_info("P7IOC diag-data for CI Port %d\n\n",
 			data->ci.ciPort);
 		ioda_eeh_hub_diag_common(data);
-		pr_info("  CI Port Status:  %016llx\n", data->ci.ciPortStatus);
-		pr_info("  CI Port LDCP:    %016llx\n", data->ci.ciPortLdcp);
+		if (data->ci.ciPortStatus || data->ci.ciPortLdcp)
+			pr_info("  CI:  %016llx %016llx\n",
+				be64_to_cpu(data->ci.ciPortStatus),
+				be64_to_cpu(data->ci.ciPortLdcp));
 		break;
 	case OPAL_P7IOC_DIAG_TYPE_MISC:
 		pr_info("P7IOC diag-data for MISC\n\n");
diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index 353e35b..97f515c 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -132,61 +132,78 @@ static void pnv_pci_dump_p7ioc_diag_data(struct pci_controller *hose,
 
 	data = (struct OpalIoP7IOCPhbErrorData *)common;
 	pr_info("P7IOC PHB#%d Diag-data (Version: %d)\n",
-		hose->global_number, common->version);
+		hose->global_number, be32_to_cpu(common->version));
 
 	if (data->brdgCtl)
 		pr_info("brdgCtl:     %08x\n",
-			data->brdgCtl);
+			be32_to_cpu(data->brdgCtl));
 	if (data->portStatusReg || data->rootCmplxStatus ||
 	    data->busAgentStatus)
 		pr_info("UtlSts:      %08x %08x %08x\n",
-			data->portStatusReg, data->rootCmplxStatus,
-			data->busAgentStatus);
+			be32_to_cpu(data->portStatusReg),
+			be32_to_cpu(data->rootCmplxStatus),
+			be32_to_cpu(data->busAgentStatus));
 	if (data->deviceStatus || data->slotStatus   ||
 	    data->linkStatus   || data->devCmdStatus ||
 	    data->devSecStatus)
 		pr_info("RootSts:     %08x %08x %08x %08x %08x\n",
-			data->deviceStatus, data->slotStatus,
-			data->linkStatus, data->devCmdStatus,
-			data->devSecStatus);
+			be32_to_cpu(data->deviceStatus),
+			be32_to_cpu(data->slotStatus),
+			be32_to_cpu(data->linkStatus),
+			be32_to_cpu(data->devCmdStatus),
+			be32_to_cpu(data->devSecStatus));
 	if (data->rootErrorStatus   || data->uncorrErrorStatus ||
 	    data->corrErrorStatus)
 		pr_info("RootErrSts:  %08x %08x %08x\n",
-			data->rootErrorStatus, data->uncorrErrorStatus,
-			data->corrErrorStatus);
+			be32_to_cpu(data->rootErrorStatus),
+			be32_to_cpu(data->uncorrErrorStatus),
+			be32_to_cpu(data->corrErrorStatus));
 	if (data->tlpHdr1 || data->tlpHdr2 ||
 	    data->tlpHdr3 || data->tlpHdr4)
 		pr_info("RootErrLog:  %08x %08x %08x %08x\n",
-			data->tlpHdr1, data->tlpHdr2,
-			data->tlpHdr3, data->tlpHdr4);
+			be32_to_cpu(data->tlpHdr1),
+			be32_to_cpu(data->tlpHdr2),
+			be32_to_cpu(data->tlpHdr3),
+			be32_to_cpu(data->tlpHdr4));
 	if (data->sourceId || data->errorClass ||
 	    data->correlator)
 		pr_info("RootErrLog1: %08x %016llx %016llx\n",
-			data->sourceId, data->errorClass,
-			data->correlator);
+			be32_to_cpu(data->sourceId),
+			be64_to_cpu(data->errorClass),
+			be64_to_cpu(data->correlator));
 	if (data->p7iocPlssr || data->p7iocCsr)
 		pr_info("PhbSts:      %016llx %016llx\n",
-			data->p7iocPlssr, data->p7iocCsr);
+			be64_to_cpu(data->p7iocPlssr),
+			be64_to_cpu(data->p7iocCsr));
 	if (data->lemFir)
 		pr_info("Lem:         %016llx %016llx %016llx\n",
-			data->lemFir, data->lemErrorMask,
-			data->lemWOF);
+			be64_to_cpu(data->lemFir),
+			be64_to_cpu(data->lemErrorMask),
+			be64_to_cpu(data->lemWOF));
 	if (data->phbErrorStatus)
 		pr_info("PhbErr:      %016llx %016llx %016llx %016llx\n",
-			data->phbErrorStatus, data->phbFirstErrorStatus,
-			data->phbErrorLog0, data->phbErrorLog1);
+			be64_to_cpu(data->phbErrorStatus),
+			be64_to_cpu(data->phbFirstErrorStatus),
+			be64_to_cpu(data->phbErrorLog0),
+			be64_to_cpu(data->phbErrorLog1));
 	if (data->mmioErrorStatus)
 		pr_info("OutErr:      %016llx %016llx %016llx %016llx\n",
-			data->mmioErrorStatus, data->mmioFirstErrorStatus,
-			data->mmioErrorLog0, data->mmioErrorLog1);
+			be64_to_cpu(data->mmioErrorStatus),
+			be64_to_cpu(data->mmioFirstErrorStatus),
+			be64_to_cpu(data->mmioErrorLog0),
+			be64_to_cpu(data->mmioErrorLog1));
 	if (data->dma0ErrorStatus)
 		pr_info("InAErr:      %016llx %016llx %016llx %016llx\n",
-			data->dma0ErrorStatus, data->dma0FirstErrorStatus,
-			data->dma0ErrorLog0, data->dma0ErrorLog1);
+			be64_to_cpu(data->dma0ErrorStatus),
+			be64_to_cpu(data->dma0FirstErrorStatus),
+			be64_to_cpu(data->dma0ErrorLog0),
+			be64_to_cpu(data->dma0ErrorLog1));
 	if (data->dma1ErrorStatus)
 		pr_info("InBErr:      %016llx %016llx %016llx %016llx\n",
-			data->dma1ErrorStatus, data->dma1FirstErrorStatus,
-			data->dma1ErrorLog0, data->dma1ErrorLog1);
+			be64_to_cpu(data->dma1ErrorStatus),
+			be64_to_cpu(data->dma1FirstErrorStatus),
+			be64_to_cpu(data->dma1ErrorLog0),
+			be64_to_cpu(data->dma1ErrorLog1));
 
 	for (i = 0; i < OPAL_P7IOC_NUM_PEST_REGS; i++) {
 		if ((data->pestA[i] >> 63) == 0 &&
@@ -194,7 +211,8 @@ static void pnv_pci_dump_p7ioc_diag_data(struct pci_controller *hose,
 			continue;
 
 		pr_info("PE[%3d] A/B: %016llx %016llx\n",
-			i, data->pestA[i], data->pestB[i]);
+			i, be64_to_cpu(data->pestA[i]),
+			be64_to_cpu(data->pestB[i]));
 	}
 }
 
-- 
1.8.3.2
