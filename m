Return-Path: <SRS0=spRZ=SR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F205EC10F0E
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Apr 2019 10:29:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AFB12070D
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Apr 2019 10:29:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AFB12070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44jPrH5cBtzDqHw
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Apr 2019 20:29:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=anju@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44jPSN2xqmzDqL4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Apr 2019 20:12:20 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x3FA91os178574
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Apr 2019 06:12:17 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2rvpaa5aca-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Apr 2019 06:12:17 -0400
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <anju@linux.vnet.ibm.com>;
 Mon, 15 Apr 2019 11:12:15 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 15 Apr 2019 11:12:14 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x3FACDH543974844
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 15 Apr 2019 10:12:13 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E81795206B;
 Mon, 15 Apr 2019 10:12:12 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.145.161.180])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 9312052059;
 Mon, 15 Apr 2019 10:12:11 +0000 (GMT)
From: Anju T Sudhakar <anju@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Subject: [PATCH v4 1/5] powerpc/include: Add data structures and macros for
 IMC trace mode
Date: Mon, 15 Apr 2019 15:42:00 +0530
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190415101204.15125-1-anju@linux.vnet.ibm.com>
References: <20190415101204.15125-1-anju@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19041510-0012-0000-0000-0000030EE981
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041510-0013-0000-0000-000021471D5F
Message-Id: <20190415101204.15125-2-anju@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-04-15_05:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904150072
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: maddy@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, anju@linux.vnet.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Add the macros needed for IMC (In-Memory Collection Counters) trace-mode
and data structure to hold the trace-imc record data.
Also, add the new type "OPAL_IMC_COUNTERS_TRACE" in 'opal-api.h', since
there is a new switch case added in the opal-calls for IMC.

Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>
Reviewed-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/imc-pmu.h  | 39 +++++++++++++++++++++++++++++
 arch/powerpc/include/asm/opal-api.h |  1 +
 2 files changed, 40 insertions(+)

diff --git a/arch/powerpc/include/asm/imc-pmu.h b/arch/powerpc/include/asm/imc-pmu.h
index 69f516ecb2fd..7c2ef0e42661 100644
--- a/arch/powerpc/include/asm/imc-pmu.h
+++ b/arch/powerpc/include/asm/imc-pmu.h
@@ -33,6 +33,7 @@
  */
 #define THREAD_IMC_LDBAR_MASK           0x0003ffffffffe000ULL
 #define THREAD_IMC_ENABLE               0x8000000000000000ULL
+#define TRACE_IMC_ENABLE		0x4000000000000000ULL
 
 /*
  * For debugfs interface for imc-mode and imc-command
@@ -59,6 +60,34 @@ struct imc_events {
 	char *scale;
 };
 
+/*
+ * Trace IMC hardware updates a 64bytes record on
+ * Core Performance Monitoring Counter (CPMC)
+ * overflow. Here is the layout for the trace imc record
+ *
+ * DW 0 : Timebase
+ * DW 1 : Program Counter
+ * DW 2 : PIDR information
+ * DW 3 : CPMC1
+ * DW 4 : CPMC2
+ * DW 5 : CPMC3
+ * Dw 6 : CPMC4
+ * DW 7 : Timebase
+ * .....
+ *
+ * The following is the data structure to hold trace imc data.
+ */
+struct trace_imc_data {
+	u64 tb1;
+	u64 ip;
+	u64 val;
+	u64 cpmc1;
+	u64 cpmc2;
+	u64 cpmc3;
+	u64 cpmc4;
+	u64 tb2;
+};
+
 /* Event attribute array index */
 #define IMC_FORMAT_ATTR		0
 #define IMC_EVENT_ATTR		1
@@ -68,6 +97,13 @@ struct imc_events {
 /* PMU Format attribute macros */
 #define IMC_EVENT_OFFSET_MASK	0xffffffffULL
 
+/*
+ * Macro to mask bits 0:21 of first double word(which is the timebase) to
+ * compare with 8th double word (timebase) of trace imc record data.
+ */
+#define IMC_TRACE_RECORD_TB1_MASK      0x3ffffffffffULL
+
+
 /*
  * Device tree parser code detects IMC pmu support and
  * registers new IMC pmus. This structure will hold the
@@ -113,6 +149,7 @@ struct imc_pmu_ref {
 
 enum {
 	IMC_TYPE_THREAD		= 0x1,
+	IMC_TYPE_TRACE		= 0x2,
 	IMC_TYPE_CORE		= 0x4,
 	IMC_TYPE_CHIP           = 0x10,
 };
@@ -123,6 +160,8 @@ enum {
 #define IMC_DOMAIN_NEST		1
 #define IMC_DOMAIN_CORE		2
 #define IMC_DOMAIN_THREAD	3
+/* For trace-imc the domain is still thread but it operates in trace-mode */
+#define IMC_DOMAIN_TRACE	4
 
 extern int init_imc_pmu(struct device_node *parent,
 				struct imc_pmu *pmu_ptr, int pmu_id);
diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
index 870fb7b239ea..a4130b21b159 100644
--- a/arch/powerpc/include/asm/opal-api.h
+++ b/arch/powerpc/include/asm/opal-api.h
@@ -1118,6 +1118,7 @@ enum {
 enum {
 	OPAL_IMC_COUNTERS_NEST = 1,
 	OPAL_IMC_COUNTERS_CORE = 2,
+	OPAL_IMC_COUNTERS_TRACE = 3,
 };
 
 
-- 
2.17.2

