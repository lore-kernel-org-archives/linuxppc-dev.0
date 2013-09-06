Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e8.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 653582C00FB
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Sep 2013 11:00:20 +1000 (EST)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Fri, 6 Sep 2013 02:00:17 +0100
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 86EA238C8059
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Sep 2013 21:00:13 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by b01cxnp22034.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r8610D3p14942310
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 6 Sep 2013 01:00:13 GMT
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r8610CYv018442
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Sep 2013 21:00:12 -0400
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 5/6] powerpc/eeh: Output PHB3 diag-data
Date: Fri,  6 Sep 2013 09:00:04 +0800
Message-Id: <1378429205-16248-6-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1378429205-16248-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1378429205-16248-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch adds function ioda_eeh_phb3_phb_diag() to dump PHB3
PHB diag-data. That's called while detecting informative errors
or frozen PE on the specific PHB.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/opal.h           |   65 ++++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/eeh-ioda.c |   70 +++++++++++++++++++++++++++++
 2 files changed, 135 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 029fe85..fed4b7d 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -444,10 +444,12 @@ enum {
 
 enum {
 	OPAL_PHB_ERROR_DATA_TYPE_P7IOC = 1,
+	OPAL_PHB_ERROR_DATA_TYPE_PHB3 = 2
 };
 
 enum {
 	OPAL_P7IOC_NUM_PEST_REGS = 128,
+	OPAL_PHB3_NUM_PEST_REGS = 256
 };
 
 struct OpalIoPhbErrorCommon {
@@ -515,6 +517,69 @@ struct OpalIoP7IOCPhbErrorData {
 	uint64_t pestB[OPAL_P7IOC_NUM_PEST_REGS];
 };
 
+struct OpalIoPhb3ErrorData {
+	struct OpalIoPhbErrorCommon common;
+
+	uint32_t brdgCtl;
+
+	/* PHB3 UTL regs */
+	uint32_t portStatusReg;
+	uint32_t rootCmplxStatus;
+	uint32_t busAgentStatus;
+
+	/* PHB3 cfg regs */
+	uint32_t deviceStatus;
+	uint32_t slotStatus;
+	uint32_t linkStatus;
+	uint32_t devCmdStatus;
+	uint32_t devSecStatus;
+
+	/* cfg AER regs */
+	uint32_t rootErrorStatus;
+	uint32_t uncorrErrorStatus;
+	uint32_t corrErrorStatus;
+	uint32_t tlpHdr1;
+	uint32_t tlpHdr2;
+	uint32_t tlpHdr3;
+	uint32_t tlpHdr4;
+	uint32_t sourceId;
+
+	uint32_t rsv3;
+
+	/* Record data about the call to allocate a buffer */
+	uint64_t errorClass;
+	uint64_t correlator;
+
+	uint64_t nFir;			/* 000 */
+	uint64_t nFirMask;		/* 003 */
+	uint64_t nFirWOF;		/* 008 */
+
+	/* PHB3 MMIO Error Regs */
+	uint64_t phbPlssr;		/* 120 */
+	uint64_t phbCsr;		/* 110 */
+	uint64_t lemFir;		/* C00 */
+	uint64_t lemErrorMask;		/* C18 */
+	uint64_t lemWOF;		/* C40 */
+	uint64_t phbErrorStatus;	/* C80 */
+	uint64_t phbFirstErrorStatus;	/* C88 */
+	uint64_t phbErrorLog0;		/* CC0 */
+	uint64_t phbErrorLog1;		/* CC8 */
+	uint64_t mmioErrorStatus;	/* D00 */
+	uint64_t mmioFirstErrorStatus;	/* D08 */
+	uint64_t mmioErrorLog0;		/* D40 */
+	uint64_t mmioErrorLog1;		/* D48 */
+	uint64_t dma0ErrorStatus;	/* D80 */
+	uint64_t dma0FirstErrorStatus;	/* D88 */
+	uint64_t dma0ErrorLog0;		/* DC0 */
+	uint64_t dma0ErrorLog1;		/* DC8 */
+	uint64_t dma1ErrorStatus;	/* E00 */
+	uint64_t dma1FirstErrorStatus;	/* E08 */
+	uint64_t dma1ErrorLog0;		/* E40 */
+	uint64_t dma1ErrorLog1;		/* E48 */
+	uint64_t pestA[OPAL_PHB3_NUM_PEST_REGS];
+	uint64_t pestB[OPAL_PHB3_NUM_PEST_REGS];
+};
+
 typedef struct oppanel_line {
 	const char * 	line;
 	uint64_t 	line_len;
diff --git a/arch/powerpc/platforms/powernv/eeh-ioda.c b/arch/powerpc/platforms/powernv/eeh-ioda.c
index d60ba3b..be68fd8 100644
--- a/arch/powerpc/platforms/powernv/eeh-ioda.c
+++ b/arch/powerpc/platforms/powernv/eeh-ioda.c
@@ -754,6 +754,73 @@ static void ioda_eeh_p7ioc_phb_diag(struct pci_controller *hose,
 	}
 }
 
+static void ioda_eeh_phb3_phb_diag(struct pci_controller *hose,
+				    struct OpalIoPhbErrorCommon *common)
+{
+	struct OpalIoPhb3ErrorData *data;
+	int i;
+
+	data = (struct OpalIoPhb3ErrorData*)common;
+	pr_info("PHB3 PHB#%x Diag-data (Version: %d)\n\n",
+		hose->global_number, common->version);
+
+	pr_info("  brdgCtl:              %08x\n", data->brdgCtl);
+
+	pr_info("  portStatusReg:        %08x\n", data->portStatusReg);
+	pr_info("  rootCmplxStatus:      %08x\n", data->rootCmplxStatus);
+	pr_info("  busAgentStatus:       %08x\n", data->busAgentStatus);
+
+	pr_info("  deviceStatus:         %08x\n", data->deviceStatus);
+	pr_info("  slotStatus:           %08x\n", data->slotStatus);
+	pr_info("  linkStatus:           %08x\n", data->linkStatus);
+	pr_info("  devCmdStatus:         %08x\n", data->devCmdStatus);
+	pr_info("  devSecStatus:         %08x\n", data->devSecStatus);
+
+	pr_info("  rootErrorStatus:      %08x\n", data->rootErrorStatus);
+	pr_info("  uncorrErrorStatus:    %08x\n", data->uncorrErrorStatus);
+	pr_info("  corrErrorStatus:      %08x\n", data->corrErrorStatus);
+	pr_info("  tlpHdr1:              %08x\n", data->tlpHdr1);
+	pr_info("  tlpHdr2:              %08x\n", data->tlpHdr2);
+	pr_info("  tlpHdr3:              %08x\n", data->tlpHdr3);
+	pr_info("  tlpHdr4:              %08x\n", data->tlpHdr4);
+	pr_info("  sourceId:             %08x\n", data->sourceId);
+	pr_info("  errorClass:           %016llx\n", data->errorClass);
+	pr_info("  correlator:           %016llx\n", data->correlator);
+	pr_info("  nFir:                 %016llx\n", data->nFir);
+	pr_info("  nFirMask:             %016llx\n", data->nFirMask);
+	pr_info("  nFirWOF:              %016llx\n", data->nFirWOF);
+	pr_info("  PhbPlssr:             %016llx\n", data->phbPlssr);
+	pr_info("  PhbCsr:               %016llx\n", data->phbCsr);
+	pr_info("  lemFir:               %016llx\n", data->lemFir);
+	pr_info("  lemErrorMask:         %016llx\n", data->lemErrorMask);
+	pr_info("  lemWOF:               %016llx\n", data->lemWOF);
+	pr_info("  phbErrorStatus:       %016llx\n", data->phbErrorStatus);
+	pr_info("  phbFirstErrorStatus:  %016llx\n", data->phbFirstErrorStatus);
+	pr_info("  phbErrorLog0:         %016llx\n", data->phbErrorLog0);
+	pr_info("  phbErrorLog1:         %016llx\n", data->phbErrorLog1);
+	pr_info("  mmioErrorStatus:      %016llx\n", data->mmioErrorStatus);
+	pr_info("  mmioFirstErrorStatus: %016llx\n", data->mmioFirstErrorStatus);
+	pr_info("  mmioErrorLog0:        %016llx\n", data->mmioErrorLog0);
+	pr_info("  mmioErrorLog1:        %016llx\n", data->mmioErrorLog1);
+	pr_info("  dma0ErrorStatus:      %016llx\n", data->dma0ErrorStatus);
+	pr_info("  dma0FirstErrorStatus: %016llx\n", data->dma0FirstErrorStatus);
+	pr_info("  dma0ErrorLog0:        %016llx\n", data->dma0ErrorLog0);
+	pr_info("  dma0ErrorLog1:        %016llx\n", data->dma0ErrorLog1);
+	pr_info("  dma1ErrorStatus:      %016llx\n", data->dma1ErrorStatus);
+	pr_info("  dma1FirstErrorStatus: %016llx\n", data->dma1FirstErrorStatus);
+	pr_info("  dma1ErrorLog0:        %016llx\n", data->dma1ErrorLog0);
+	pr_info("  dma1ErrorLog1:        %016llx\n", data->dma1ErrorLog1);
+
+	for (i = 0; i < OPAL_PHB3_NUM_PEST_REGS; i++) {
+		if ((data->pestA[i] >> 63) == 0 &&
+		    (data->pestB[i] >> 63) == 0)
+			continue;
+
+		pr_info("  PE[%3d] PESTA:        %016llx\n", i, data->pestA[i]);
+		pr_info("          PESTB:        %016llx\n", data->pestB[i]);
+	}
+}
+
 static void ioda_eeh_phb_diag(struct pci_controller *hose)
 {
 	struct pnv_phb *phb = hose->private_data;
@@ -772,6 +839,9 @@ static void ioda_eeh_phb_diag(struct pci_controller *hose)
 	case OPAL_PHB_ERROR_DATA_TYPE_P7IOC:
 		ioda_eeh_p7ioc_phb_diag(hose, common);
 		break;
+	case OPAL_PHB_ERROR_DATA_TYPE_PHB3:
+		ioda_eeh_phb3_phb_diag(hose, common);
+		break;
 	default:
 		pr_warning("%s: Unrecognized I/O chip %d\n",
 			   __func__, common->ioType);
-- 
1.7.5.4
