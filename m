Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 11EDD1A066D
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 May 2015 18:06:03 +1000 (AEST)
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id DC1A0140786
 for <linuxppc-dev@ozlabs.org>; Tue,  5 May 2015 18:06:02 +1000 (AEST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Tue, 5 May 2015 18:06:01 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 94D3C2CE8040
 for <linuxppc-dev@ozlabs.org>; Tue,  5 May 2015 18:05:57 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4585mKY50004050
 for <linuxppc-dev@ozlabs.org>; Tue, 5 May 2015 18:05:57 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4585OLV030743
 for <linuxppc-dev@ozlabs.org>; Tue, 5 May 2015 18:05:24 +1000
Subject: [PATCH v2 1/2] powerpc/powernv: display reason for Malfunction
 Alert HMI.
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Date: Tue, 05 May 2015 13:34:58 +0530
Message-ID: <20150505080431.513.69688.stgit@mars.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

The V2 version of HMI event now carries additional information for
Malfunction Alert. It now contains error information about CORE and NX
checkstop. This patch checks and displays the check stop reason before
panic.

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
Acked-by: Stewart Smith <stewart@linux.vnet.ibm.com>
---
Changes in V2:
- Rebased it against opal-api.h

 arch/powerpc/include/asm/opal-api.h       |   61 +++++++++++++
 arch/powerpc/platforms/powernv/opal-hmi.c |  132 +++++++++++++++++++++++++++++
 2 files changed, 193 insertions(+)

diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
index 0321a90..ab245dd 100644
--- a/arch/powerpc/include/asm/opal-api.h
+++ b/arch/powerpc/include/asm/opal-api.h
@@ -428,6 +428,7 @@ struct OpalMemoryErrorData {
 /* HMI interrupt event */
 enum OpalHMI_Version {
 	OpalHMIEvt_V1 = 1,
+	OpalHMIEvt_V2 = 2,
 };
 
 enum OpalHMI_Severity {
@@ -458,6 +459,49 @@ enum OpalHMI_ErrType {
 	OpalHMI_ERROR_CAPP_RECOVERY,
 };
 
+enum OpalHMI_XstopType {
+	CHECKSTOP_TYPE_UNKNOWN	=	0,
+	CHECKSTOP_TYPE_CORE	=	1,
+	CHECKSTOP_TYPE_NX	=	2,
+};
+
+enum OpalHMI_CoreXstopReason {
+	CORE_CHECKSTOP_IFU_REGFILE		= 0x00000001,
+	CORE_CHECKSTOP_IFU_LOGIC		= 0x00000002,
+	CORE_CHECKSTOP_PC_DURING_RECOV		= 0x00000004,
+	CORE_CHECKSTOP_ISU_REGFILE		= 0x00000008,
+	CORE_CHECKSTOP_ISU_LOGIC		= 0x00000010,
+	CORE_CHECKSTOP_FXU_LOGIC		= 0x00000020,
+	CORE_CHECKSTOP_VSU_LOGIC		= 0x00000040,
+	CORE_CHECKSTOP_PC_RECOV_IN_MAINT_MODE	= 0x00000080,
+	CORE_CHECKSTOP_LSU_REGFILE		= 0x00000100,
+	CORE_CHECKSTOP_PC_FWD_PROGRESS		= 0x00000200,
+	CORE_CHECKSTOP_LSU_LOGIC		= 0x00000400,
+	CORE_CHECKSTOP_PC_LOGIC			= 0x00000800,
+	CORE_CHECKSTOP_PC_HYP_RESOURCE		= 0x00001000,
+	CORE_CHECKSTOP_PC_HANG_RECOV_FAILED	= 0x00002000,
+	CORE_CHECKSTOP_PC_AMBI_HANG_DETECTED	= 0x00004000,
+	CORE_CHECKSTOP_PC_DEBUG_TRIG_ERR_INJ	= 0x00008000,
+	CORE_CHECKSTOP_PC_SPRD_HYP_ERR_INJ	= 0x00010000,
+};
+
+enum OpalHMI_NestAccelXstopReason {
+	NX_CHECKSTOP_SHM_INVAL_STATE_ERR	= 0x00000001,
+	NX_CHECKSTOP_DMA_INVAL_STATE_ERR_1	= 0x00000002,
+	NX_CHECKSTOP_DMA_INVAL_STATE_ERR_2	= 0x00000004,
+	NX_CHECKSTOP_DMA_CH0_INVAL_STATE_ERR	= 0x00000008,
+	NX_CHECKSTOP_DMA_CH1_INVAL_STATE_ERR	= 0x00000010,
+	NX_CHECKSTOP_DMA_CH2_INVAL_STATE_ERR	= 0x00000020,
+	NX_CHECKSTOP_DMA_CH3_INVAL_STATE_ERR	= 0x00000040,
+	NX_CHECKSTOP_DMA_CH4_INVAL_STATE_ERR	= 0x00000080,
+	NX_CHECKSTOP_DMA_CH5_INVAL_STATE_ERR	= 0x00000100,
+	NX_CHECKSTOP_DMA_CH6_INVAL_STATE_ERR	= 0x00000200,
+	NX_CHECKSTOP_DMA_CH7_INVAL_STATE_ERR	= 0x00000400,
+	NX_CHECKSTOP_DMA_CRB_UE			= 0x00000800,
+	NX_CHECKSTOP_DMA_CRB_SUE		= 0x00001000,
+	NX_CHECKSTOP_PBI_ISN_UE			= 0x00002000,
+};
+
 struct OpalHMIEvent {
 	uint8_t		version;	/* 0x00 */
 	uint8_t		severity;	/* 0x01 */
@@ -468,6 +512,23 @@ struct OpalHMIEvent {
 	__be64		hmer;
 	/* TFMR register. Valid only for TFAC and TFMR_PARITY error type. */
 	__be64		tfmr;
+
+	/* version 2 and later */
+	union {
+		/*
+		 * checkstop info (Core/NX).
+		 * Valid for OpalHMI_ERROR_MALFUNC_ALERT.
+		 */
+		struct {
+			uint8_t	xstop_type;	/* enum OpalHMI_XstopType */
+			uint8_t reserved_1[3];
+			__be32  xstop_reason;
+			union {
+				__be32 pir;	/* for CHECKSTOP_TYPE_CORE */
+				__be32 chip_id;	/* for CHECKSTOP_TYPE_NX */
+			} u;
+		} xstop_error;
+	} u;
 };
 
 enum {
diff --git a/arch/powerpc/platforms/powernv/opal-hmi.c b/arch/powerpc/platforms/powernv/opal-hmi.c
index b322bfb..2668225 100644
--- a/arch/powerpc/platforms/powernv/opal-hmi.c
+++ b/arch/powerpc/platforms/powernv/opal-hmi.c
@@ -35,9 +35,134 @@ struct OpalHmiEvtNode {
 	struct list_head list;
 	struct OpalHMIEvent hmi_evt;
 };
+
+struct xstop_reason {
+	uint32_t xstop_reason;
+	const char *unit_failed;
+	const char *description;
+};
+
 static LIST_HEAD(opal_hmi_evt_list);
 static DEFINE_SPINLOCK(opal_hmi_evt_lock);
 
+static void print_core_checkstop_reason(const char *level,
+					struct OpalHMIEvent *hmi_evt)
+{
+	int i;
+	static const struct xstop_reason xstop_reason[] = {
+		{ CORE_CHECKSTOP_IFU_REGFILE, "IFU",
+				"RegFile core check stop" },
+		{ CORE_CHECKSTOP_IFU_LOGIC, "IFU", "Logic core check stop" },
+		{ CORE_CHECKSTOP_PC_DURING_RECOV, "PC",
+				"Core checkstop during recovery" },
+		{ CORE_CHECKSTOP_ISU_REGFILE, "ISU",
+				"RegFile core check stop (mapper error)" },
+		{ CORE_CHECKSTOP_ISU_LOGIC, "ISU", "Logic core check stop" },
+		{ CORE_CHECKSTOP_FXU_LOGIC, "FXU", "Logic core check stop" },
+		{ CORE_CHECKSTOP_VSU_LOGIC, "VSU", "Logic core check stop" },
+		{ CORE_CHECKSTOP_PC_RECOV_IN_MAINT_MODE, "PC",
+				"Recovery in maintenance mode" },
+		{ CORE_CHECKSTOP_LSU_REGFILE, "LSU",
+				"RegFile core check stop" },
+		{ CORE_CHECKSTOP_PC_FWD_PROGRESS, "PC",
+				"Forward Progress Error" },
+		{ CORE_CHECKSTOP_LSU_LOGIC, "LSU", "Logic core check stop" },
+		{ CORE_CHECKSTOP_PC_LOGIC, "PC", "Logic core check stop" },
+		{ CORE_CHECKSTOP_PC_HYP_RESOURCE, "PC",
+				"Hypervisor Resource error - core check stop" },
+		{ CORE_CHECKSTOP_PC_HANG_RECOV_FAILED, "PC",
+				"Hang Recovery Failed (core check stop)" },
+		{ CORE_CHECKSTOP_PC_AMBI_HANG_DETECTED, "PC",
+				"Ambiguous Hang Detected (unknown source)" },
+		{ CORE_CHECKSTOP_PC_DEBUG_TRIG_ERR_INJ, "PC",
+				"Debug Trigger Error inject" },
+		{ CORE_CHECKSTOP_PC_SPRD_HYP_ERR_INJ, "PC",
+				"Hypervisor check stop via SPRC/SPRD" },
+	};
+
+	/* Validity check */
+	if (!hmi_evt->u.xstop_error.xstop_reason) {
+		printk("%s	Unknown Core check stop.\n", level);
+		return;
+	}
+
+	printk("%s	CPU PIR: %08x\n", level,
+			be32_to_cpu(hmi_evt->u.xstop_error.u.pir));
+	for (i = 0; i < ARRAY_SIZE(xstop_reason); i++)
+		if (be32_to_cpu(hmi_evt->u.xstop_error.xstop_reason) &
+					xstop_reason[i].xstop_reason)
+			printk("%s	[Unit: %-3s] %s\n", level,
+					xstop_reason[i].unit_failed,
+					xstop_reason[i].description);
+}
+
+static void print_nx_checkstop_reason(const char *level,
+					struct OpalHMIEvent *hmi_evt)
+{
+	int i;
+	static const struct xstop_reason xstop_reason[] = {
+		{ NX_CHECKSTOP_SHM_INVAL_STATE_ERR, "DMA & Engine",
+					"SHM invalid state error" },
+		{ NX_CHECKSTOP_DMA_INVAL_STATE_ERR_1, "DMA & Engine",
+					"DMA invalid state error bit 15" },
+		{ NX_CHECKSTOP_DMA_INVAL_STATE_ERR_2, "DMA & Engine",
+					"DMA invalid state error bit 16" },
+		{ NX_CHECKSTOP_DMA_CH0_INVAL_STATE_ERR, "DMA & Engine",
+					"Channel 0 invalid state error" },
+		{ NX_CHECKSTOP_DMA_CH1_INVAL_STATE_ERR, "DMA & Engine",
+					"Channel 1 invalid state error" },
+		{ NX_CHECKSTOP_DMA_CH2_INVAL_STATE_ERR, "DMA & Engine",
+					"Channel 2 invalid state error" },
+		{ NX_CHECKSTOP_DMA_CH3_INVAL_STATE_ERR, "DMA & Engine",
+					"Channel 3 invalid state error" },
+		{ NX_CHECKSTOP_DMA_CH4_INVAL_STATE_ERR, "DMA & Engine",
+					"Channel 4 invalid state error" },
+		{ NX_CHECKSTOP_DMA_CH5_INVAL_STATE_ERR, "DMA & Engine",
+					"Channel 5 invalid state error" },
+		{ NX_CHECKSTOP_DMA_CH6_INVAL_STATE_ERR, "DMA & Engine",
+					"Channel 6 invalid state error" },
+		{ NX_CHECKSTOP_DMA_CH7_INVAL_STATE_ERR, "DMA & Engine",
+					"Channel 7 invalid state error" },
+		{ NX_CHECKSTOP_DMA_CRB_UE, "DMA & Engine",
+					"UE error on CRB(CSB address, CCB)" },
+		{ NX_CHECKSTOP_DMA_CRB_SUE, "DMA & Engine",
+					"SUE error on CRB(CSB address, CCB)" },
+		{ NX_CHECKSTOP_PBI_ISN_UE, "PowerBus Interface",
+		"CRB Kill ISN received while holding ISN with UE error" },
+	};
+
+	/* Validity check */
+	if (!hmi_evt->u.xstop_error.xstop_reason) {
+		printk("%s	Unknown NX check stop.\n", level);
+		return;
+	}
+
+	printk("%s	NX checkstop on CHIP ID: %x\n", level,
+			be32_to_cpu(hmi_evt->u.xstop_error.u.chip_id));
+	for (i = 0; i < ARRAY_SIZE(xstop_reason); i++)
+		if (be32_to_cpu(hmi_evt->u.xstop_error.xstop_reason) &
+					xstop_reason[i].xstop_reason)
+			printk("%s	[Unit: %-3s] %s\n", level,
+					xstop_reason[i].unit_failed,
+					xstop_reason[i].description);
+}
+
+static void print_checkstop_reason(const char *level,
+					struct OpalHMIEvent *hmi_evt)
+{
+	switch (hmi_evt->u.xstop_error.xstop_type) {
+	case CHECKSTOP_TYPE_CORE:
+		print_core_checkstop_reason(level, hmi_evt);
+		break;
+	case CHECKSTOP_TYPE_NX:
+		print_nx_checkstop_reason(level, hmi_evt);
+		break;
+	case CHECKSTOP_TYPE_UNKNOWN:
+		printk("%s	Unknown Malfunction Alert.\n", level);
+		break;
+	}
+}
+
 static void print_hmi_event_info(struct OpalHMIEvent *hmi_evt)
 {
 	const char *level, *sevstr, *error_info;
@@ -95,6 +220,13 @@ static void print_hmi_event_info(struct OpalHMIEvent *hmi_evt)
 		(hmi_evt->type == OpalHMI_ERROR_TFMR_PARITY))
 		printk("%s	TFMR: %016llx\n", level,
 						be64_to_cpu(hmi_evt->tfmr));
+
+	if (hmi_evt->version < OpalHMIEvt_V2)
+		return;
+
+	/* OpalHMIEvt_V2 and above provides reason for malfunction alert. */
+	if (hmi_evt->type == OpalHMI_ERROR_MALFUNC_ALERT)
+		print_checkstop_reason(level, hmi_evt);
 }
 
 static void hmi_event_handler(struct work_struct *work)
