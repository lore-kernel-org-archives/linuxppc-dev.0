Return-Path: <srs0=tbmk=jo=linux.vnet.ibm.com=mahesh@ozlabs.org>
Received: from ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41GcXw2vTszF1QZ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jun 2018 21:11:28 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 41GcXw2MySz8syV
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jun 2018 21:11:28 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 41GcXv5LvPz9ryt
 for <linuxppc-dev@ozlabs.org>; Thu, 28 Jun 2018 21:11:27 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w5SB9sDs051315
 for <linuxppc-dev@ozlabs.org>; Thu, 28 Jun 2018 07:11:26 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2jvtseb825-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 28 Jun 2018 07:11:25 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Thu, 28 Jun 2018 12:11:23 +0100
Subject: [PATCH v4 3/6] powerpc/pseries: Define MCE error event section.
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Laurent Dufour <ldufour@linux.vnet.ibm.com>
Date: Thu, 28 Jun 2018 16:41:18 +0530
In-Reply-To: <153018397703.31589.3105355336278825912.stgit@jupiter.in.ibm.com>
References: <153018397703.31589.3105355336278825912.stgit@jupiter.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <153018427229.31589.12921339716837969829.stgit@jupiter.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

On pseries, the machine check error details are part of RTAS extended
event log passed under Machine check exception section. This patch adds
the definition of rtas MCE event section and related helper
functions.

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/rtas.h |  111 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 111 insertions(+)

diff --git a/arch/powerpc/include/asm/rtas.h b/arch/powerpc/include/asm/rtas.h
index ec9dd79398ee..ceeed2dd489b 100644
--- a/arch/powerpc/include/asm/rtas.h
+++ b/arch/powerpc/include/asm/rtas.h
@@ -185,6 +185,13 @@ static inline uint8_t rtas_error_disposition(const struct rtas_error_log *elog)
 	return (elog->byte1 & 0x18) >> 3;
 }
 
+static inline
+void rtas_set_disposition_recovered(struct rtas_error_log *elog)
+{
+	elog->byte1 &= ~0x18;
+	elog->byte1 |= (RTAS_DISP_FULLY_RECOVERED << 3);
+}
+
 static inline uint8_t rtas_error_extended(const struct rtas_error_log *elog)
 {
 	return (elog->byte1 & 0x04) >> 2;
@@ -275,6 +282,7 @@ inline uint32_t rtas_ext_event_company_id(struct rtas_ext_event_log_v6 *ext_log)
 #define PSERIES_ELOG_SECT_ID_CALL_HOME		(('C' << 8) | 'H')
 #define PSERIES_ELOG_SECT_ID_USER_DEF		(('U' << 8) | 'D')
 #define PSERIES_ELOG_SECT_ID_HOTPLUG		(('H' << 8) | 'P')
+#define PSERIES_ELOG_SECT_ID_MCE		(('M' << 8) | 'C')
 
 /* Vendor specific Platform Event Log Format, Version 6, section header */
 struct pseries_errorlog {
@@ -326,6 +334,109 @@ struct pseries_hp_errorlog {
 #define PSERIES_HP_ELOG_ID_DRC_COUNT	3
 #define PSERIES_HP_ELOG_ID_DRC_IC	4
 
+/* RTAS pseries MCE errorlog section */
+#pragma pack(push, 1)
+struct pseries_mc_errorlog {
+	__be32	fru_id;
+	__be32	proc_id;
+	uint8_t	error_type;
+	union {
+		struct {
+			uint8_t	ue_err_type;
+			/* XXXXXXXX
+			 * X		1: Permanent or Transient UE.
+			 *  X		1: Effective address provided.
+			 *   X		1: Logical address provided.
+			 *    XX	2: Reserved.
+			 *      XXX	3: Type of UE error.
+			 */
+			uint8_t	reserved_1[6];
+			__be64	effective_address;
+			__be64	logical_address;
+		} ue_error;
+		struct {
+			uint8_t	soft_err_type;
+			/* XXXXXXXX
+			 * X		1: Effective address provided.
+			 *  XXXXX	5: Reserved.
+			 *       XX	2: Type of SLB/ERAT/TLB error.
+			 */
+			uint8_t	reserved_1[6];
+			__be64	effective_address;
+			uint8_t	reserved_2[8];
+		} soft_error;
+	} u;
+};
+#pragma pack(pop)
+
+/* RTAS pseries MCE error types */
+#define PSERIES_MC_ERROR_TYPE_UE		0x00
+#define PSERIES_MC_ERROR_TYPE_SLB		0x01
+#define PSERIES_MC_ERROR_TYPE_ERAT		0x02
+#define PSERIES_MC_ERROR_TYPE_TLB		0x04
+#define PSERIES_MC_ERROR_TYPE_D_CACHE		0x05
+#define PSERIES_MC_ERROR_TYPE_I_CACHE		0x07
+
+/* RTAS pseries MCE error sub types */
+#define PSERIES_MC_ERROR_UE_INDETERMINATE		0
+#define PSERIES_MC_ERROR_UE_IFETCH			1
+#define PSERIES_MC_ERROR_UE_PAGE_TABLE_WALK_IFETCH	2
+#define PSERIES_MC_ERROR_UE_LOAD_STORE			3
+#define PSERIES_MC_ERROR_UE_PAGE_TABLE_WALK_LOAD_STORE	4
+
+#define PSERIES_MC_ERROR_SLB_PARITY		0
+#define PSERIES_MC_ERROR_SLB_MULTIHIT		1
+#define PSERIES_MC_ERROR_SLB_INDETERMINATE	2
+
+#define PSERIES_MC_ERROR_ERAT_PARITY		1
+#define PSERIES_MC_ERROR_ERAT_MULTIHIT		2
+#define PSERIES_MC_ERROR_ERAT_INDETERMINATE	3
+
+#define PSERIES_MC_ERROR_TLB_PARITY		1
+#define PSERIES_MC_ERROR_TLB_MULTIHIT		2
+#define PSERIES_MC_ERROR_TLB_INDETERMINATE	3
+
+static inline uint8_t rtas_mc_error_type(const struct pseries_mc_errorlog *mlog)
+{
+	return mlog->error_type;
+}
+
+static inline uint8_t rtas_mc_error_sub_type(
+					const struct pseries_mc_errorlog *mlog)
+{
+	switch (mlog->error_type) {
+	case	PSERIES_MC_ERROR_TYPE_UE:
+		return (mlog->u.ue_error.ue_err_type & 0x07);
+	case	PSERIES_MC_ERROR_TYPE_SLB:
+	case	PSERIES_MC_ERROR_TYPE_ERAT:
+	case	PSERIES_MC_ERROR_TYPE_TLB:
+		return (mlog->u.soft_error.soft_err_type & 0x03);
+	default:
+		return 0;
+	}
+}
+
+static inline uint64_t rtas_mc_get_effective_addr(
+					const struct pseries_mc_errorlog *mlog)
+{
+	uint64_t addr = 0;
+
+	switch (mlog->error_type) {
+	case	PSERIES_MC_ERROR_TYPE_UE:
+		if (mlog->u.ue_error.ue_err_type & 0x40)
+			addr = mlog->u.ue_error.effective_address;
+		break;
+	case	PSERIES_MC_ERROR_TYPE_SLB:
+	case	PSERIES_MC_ERROR_TYPE_ERAT:
+	case	PSERIES_MC_ERROR_TYPE_TLB:
+		if (mlog->u.soft_error.soft_err_type & 0x80)
+			addr = mlog->u.soft_error.effective_address;
+	default:
+		break;
+	}
+	return be64_to_cpu(addr);
+}
+
 struct pseries_errorlog *get_pseries_errorlog(struct rtas_error_log *log,
 					      uint16_t section_id);
 
