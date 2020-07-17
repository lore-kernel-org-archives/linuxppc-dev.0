Return-Path: <SRS0=mPqZ=A4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74F04C433E3
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 Jul 2020 15:23:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2ECF32065D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 Jul 2020 15:23:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ECF32065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4B7Zdp6Wf2zDqGv
	for <linuxppc-dev@archiver.kernel.org>; Sat, 18 Jul 2020 01:23:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record)
 smtp.mailfrom=linux.vnet.ibm.com (client-ip=148.163.156.1;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=atrajeev@linux.vnet.ibm.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4B7YfY0SmMzDrNj
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Jul 2020 00:39:16 +1000 (AEST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 06HEWMUR076546; Fri, 17 Jul 2020 10:39:10 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 32792yb85j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 Jul 2020 10:39:10 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
 by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06HEUr9N021699;
 Fri, 17 Jul 2020 14:39:06 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by ppma03ams.nl.ibm.com with ESMTP id 327527xtjp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 Jul 2020 14:39:06 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 06HEd4aP31785448
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 17 Jul 2020 14:39:04 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 01AD94C046;
 Fri, 17 Jul 2020 14:39:04 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 630554C04A;
 Fri, 17 Jul 2020 14:39:01 +0000 (GMT)
Received: from localhost.localdomain.localdomain (unknown [9.77.207.73])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 17 Jul 2020 14:39:01 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Subject: [v3 10/15] powerpc/perf: Add Power10 BHRB filter support for
 PERF_SAMPLE_BRANCH_IND_CALL/COND
Date: Fri, 17 Jul 2020 10:38:22 -0400
Message-Id: <1594996707-3727-11-git-send-email-atrajeev@linux.vnet.ibm.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1594996707-3727-1-git-send-email-atrajeev@linux.vnet.ibm.com>
References: <1594996707-3727-1-git-send-email-atrajeev@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-07-17_06:2020-07-17,
 2020-07-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=1
 mlxlogscore=975 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 adultscore=0 impostorscore=0 spamscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007170103
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
Cc: ego@linux.vnet.ibm.com, mikey@neuling.org, maddy@linux.vnet.ibm.com,
 kvm@vger.kernel.org, kvm-ppc@vger.kernel.org, svaidyan@in.ibm.com,
 acme@kernel.org, jolsa@kernel.org, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

PowerISA v3.1 introduce filtering support for
PERF_SAMPLE_BRANCH_IND_CALL/COND. The patch adds BHRB filter
support for "ind_call" and "cond" in power10_bhrb_filter_map().

Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
---
 arch/powerpc/perf/power10-pmu.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/perf/power10-pmu.c b/arch/powerpc/perf/power10-pmu.c
index ba19f40..b02aabb 100644
--- a/arch/powerpc/perf/power10-pmu.c
+++ b/arch/powerpc/perf/power10-pmu.c
@@ -83,6 +83,8 @@
 
 /* MMCRA IFM bits - POWER10 */
 #define POWER10_MMCRA_IFM1		0x0000000040000000UL
+#define POWER10_MMCRA_IFM2		0x0000000080000000UL
+#define POWER10_MMCRA_IFM3		0x00000000C0000000UL
 #define POWER10_MMCRA_BHRB_MASK		0x00000000C0000000UL
 
 /* Table of alternatives, sorted by column 0 */
@@ -233,8 +235,15 @@ static u64 power10_bhrb_filter_map(u64 branch_sample_type)
 	if (branch_sample_type & PERF_SAMPLE_BRANCH_ANY_RETURN)
 		return -1;
 
-	if (branch_sample_type & PERF_SAMPLE_BRANCH_IND_CALL)
-		return -1;
+	if (branch_sample_type & PERF_SAMPLE_BRANCH_IND_CALL) {
+		pmu_bhrb_filter |= POWER10_MMCRA_IFM2;
+		return pmu_bhrb_filter;
+	}
+
+	if (branch_sample_type & PERF_SAMPLE_BRANCH_COND) {
+		pmu_bhrb_filter |= POWER10_MMCRA_IFM3;
+		return pmu_bhrb_filter;
+	}
 
 	if (branch_sample_type & PERF_SAMPLE_BRANCH_CALL)
 		return -1;
-- 
1.8.3.1

