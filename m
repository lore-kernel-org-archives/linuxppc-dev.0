Return-Path: <srs0=ktuc=lz=linux.vnet.ibm.com=mahesh@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 428nKz70Q6zF37s
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2018 00:27:03 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 428nKz5tP2z8tRT
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2018 00:27:03 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 428nKz0LTYz9s1x
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Sep 2018 00:27:02 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w8BEORvd139400
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Sep 2018 10:26:59 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2medg05uf0-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Sep 2018 10:26:58 -0400
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Tue, 11 Sep 2018 15:26:57 +0100
Subject: [PATCH v10 1/5] powerpc/pseries: Define MCE error event section.
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Cc: Michal Suchanek <msuchanek@suse.com>, Ananth Narayan <ananth@in.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Laurent Dufour <ldufour@linux.vnet.ibm.com>
Date: Tue, 11 Sep 2018 19:56:52 +0530
In-Reply-To: <153667588649.24785.4453485245076541196.stgit@jupiter.in.ibm.com>
References: <153667588649.24785.4453485245076541196.stgit@jupiter.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <153667601213.24785.10591974977547181565.stgit@jupiter.in.ibm.com>
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
---
 arch/powerpc/include/asm/rtas.h      |    8 +++
 arch/powerpc/platforms/pseries/ras.c |   95 ++++++++++++++++++++++++++++++++++
 2 files changed, 103 insertions(+)

diff --git a/arch/powerpc/include/asm/rtas.h b/arch/powerpc/include/asm/rtas.h
index 71e393c46a49..adefa6493d29 100644
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
diff --git a/arch/powerpc/platforms/pseries/ras.c b/arch/powerpc/platforms/pseries/ras.c
index 851ce326874a..3500ad982706 100644
--- a/arch/powerpc/platforms/pseries/ras.c
+++ b/arch/powerpc/platforms/pseries/ras.c
@@ -50,6 +50,101 @@ static irqreturn_t ras_hotplug_interrupt(int irq, void *dev_id);
 static irqreturn_t ras_epow_interrupt(int irq, void *dev_id);
 static irqreturn_t ras_error_interrupt(int irq, void *dev_id);
 
+/* RTAS pseries MCE errorlog section. */
+struct pseries_mc_errorlog {
+	__be32	fru_id;
+	__be32	proc_id;
+	u8	error_type;
+	/*
+	 * sub_err_type (1 byte). Bit fields depends on error_type
+	 *
+	 *   MSB0
+	 *   |
+	 *   V
+	 *   01234567
+	 *   XXXXXXXX
+	 *
+	 * For error_type == MC_ERROR_TYPE_UE
+	 *   XXXXXXXX
+	 *   X		1: Permanent or Transient UE.
+	 *    X		1: Effective address provided.
+	 *     X	1: Logical address provided.
+	 *      XX	2: Reserved.
+	 *        XXX	3: Type of UE error.
+	 *
+	 * For error_type != MC_ERROR_TYPE_UE
+	 *   XXXXXXXX
+	 *   X		1: Effective address provided.
+	 *    XXXXX	5: Reserved.
+	 *         XX	2: Type of SLB/ERAT/TLB error.
+	 */
+	u8	sub_err_type;
+	u8	reserved_1[6];
+	__be64	effective_address;
+	__be64	logical_address;
+} __packed;
+
+/* RTAS pseries MCE error types */
+#define MC_ERROR_TYPE_UE		0x00
+#define MC_ERROR_TYPE_SLB		0x01
+#define MC_ERROR_TYPE_ERAT		0x02
+#define MC_ERROR_TYPE_TLB		0x04
+#define MC_ERROR_TYPE_D_CACHE		0x05
+#define MC_ERROR_TYPE_I_CACHE		0x07
+
+/* RTAS pseries MCE error sub types */
+#define MC_ERROR_UE_INDETERMINATE		0
+#define MC_ERROR_UE_IFETCH			1
+#define MC_ERROR_UE_PAGE_TABLE_WALK_IFETCH	2
+#define MC_ERROR_UE_LOAD_STORE			3
+#define MC_ERROR_UE_PAGE_TABLE_WALK_LOAD_STORE	4
+
+#define MC_ERROR_SLB_PARITY		0
+#define MC_ERROR_SLB_MULTIHIT		1
+#define MC_ERROR_SLB_INDETERMINATE	2
+
+#define MC_ERROR_ERAT_PARITY		1
+#define MC_ERROR_ERAT_MULTIHIT		2
+#define MC_ERROR_ERAT_INDETERMINATE	3
+
+#define MC_ERROR_TLB_PARITY		1
+#define MC_ERROR_TLB_MULTIHIT		2
+#define MC_ERROR_TLB_INDETERMINATE	3
+
+static inline u8 rtas_mc_error_sub_type(const struct pseries_mc_errorlog *mlog)
+{
+	switch (mlog->error_type) {
+	case	MC_ERROR_TYPE_UE:
+		return (mlog->sub_err_type & 0x07);
+	case	MC_ERROR_TYPE_SLB:
+	case	MC_ERROR_TYPE_ERAT:
+	case	MC_ERROR_TYPE_TLB:
+		return (mlog->sub_err_type & 0x03);
+	default:
+		return 0;
+	}
+}
+
+static
+inline u64 rtas_mc_get_effective_addr(const struct pseries_mc_errorlog *mlog)
+{
+	__be64 addr = 0;
+
+	switch (mlog->error_type) {
+	case	MC_ERROR_TYPE_UE:
+		if (mlog->sub_err_type & 0x40)
+			addr = mlog->effective_address;
+		break;
+	case	MC_ERROR_TYPE_SLB:
+	case	MC_ERROR_TYPE_ERAT:
+	case	MC_ERROR_TYPE_TLB:
+		if (mlog->sub_err_type & 0x80)
+			addr = mlog->effective_address;
+	default:
+		break;
+	}
+	return be64_to_cpu(addr);
+}
 
 /*
  * Enable the hotplug interrupt late because processing them may touch other
