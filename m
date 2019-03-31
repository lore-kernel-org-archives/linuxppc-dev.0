Return-Path: <SRS0=rJbe=SC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57709C43381
	for <linuxppc-dev@archiver.kernel.org>; Sun, 31 Mar 2019 19:20:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 372F120870
	for <linuxppc-dev@archiver.kernel.org>; Sun, 31 Mar 2019 19:20:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 372F120870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44XQKX4mctzDqPX
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Apr 2019 06:20:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=maddy@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44XQHr6WgqzDqM3
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Apr 2019 06:18:48 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x2VJIjp9005652
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 31 Mar 2019 15:18:45 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2rk2gs9tu2-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 31 Mar 2019 15:18:44 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Sun, 31 Mar 2019 20:18:43 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Sun, 31 Mar 2019 20:18:42 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x2VJIfsx43647206
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 31 Mar 2019 19:18:41 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 36BD611C04C;
 Sun, 31 Mar 2019 19:18:41 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 163DD11C04A;
 Sun, 31 Mar 2019 19:18:40 +0000 (GMT)
Received: from SrihariSrinidhi.in.ibm.com (unknown [9.124.214.21])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Sun, 31 Mar 2019 19:18:39 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Subject: [PATCH 1/2] powerpc/perf: init platform pmu driver from core-book3s
Date: Mon,  1 Apr 2019 00:48:32 +0530
X-Mailer: git-send-email 2.7.4
X-TM-AS-GCONF: 00
x-cbid: 19033119-4275-0000-0000-00000321F30A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19033119-4276-0000-0000-00003830F9D7
Message-Id: <1554059913-20335-1-git-send-email-maddy@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-03-31_11:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903310147
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
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Currenty pmu driver file for each ppc64 generation processor
has a __init call in itself. Refactor the code by moving the
__init call to core-books.c. This also clean's up compat mode
pmu driver registration.

Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/perf_event_server.h |  8 ++++++++
 arch/powerpc/perf/core-book3s.c              | 22 ++++++++++++++++++++++
 arch/powerpc/perf/power5+-pmu.c              |  4 +---
 arch/powerpc/perf/power5-pmu.c               |  4 +---
 arch/powerpc/perf/power6-pmu.c               |  4 +---
 arch/powerpc/perf/power7-pmu.c               |  4 +---
 arch/powerpc/perf/power8-pmu.c               |  3 +--
 arch/powerpc/perf/power9-pmu.c               |  3 +--
 arch/powerpc/perf/ppc970-pmu.c               |  4 +---
 9 files changed, 37 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/include/asm/perf_event_server.h b/arch/powerpc/include/asm/perf_event_server.h
index e60aeb46d6a0..c5022f2c62a4 100644
--- a/arch/powerpc/include/asm/perf_event_server.h
+++ b/arch/powerpc/include/asm/perf_event_server.h
@@ -87,6 +87,14 @@ struct pt_regs;
 extern unsigned long perf_misc_flags(struct pt_regs *regs);
 extern unsigned long perf_instruction_pointer(struct pt_regs *regs);
 extern unsigned long int read_bhrb(int n);
+extern int init_ppc970_pmu(void);
+extern int init_power5_pmu(void);
+extern int init_power5p_pmu(void);
+extern int init_power6_pmu(void);
+extern int init_power7_pmu(void);
+extern int init_power8_pmu(void);
+extern int init_power9_pmu(void);
+
 
 /*
  * Only override the default definitions in include/linux/perf_event.h
diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index b0723002a396..9ba39a69b0ec 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -2294,3 +2294,25 @@ int register_power_pmu(struct power_pmu *pmu)
 			  power_pmu_prepare_cpu, NULL);
 	return 0;
 }
+
+static int __init init_ppc64_pmu(void)
+{
+	/* run through all the pmu drivers one at a time */
+	if (!init_power5_pmu())
+		return 0;
+	else if (!init_power5p_pmu())
+		return 0;
+	else if (!init_power6_pmu())
+		return 0;
+	else if (!init_power7_pmu())
+		return 0;
+	else if (!init_power8_pmu())
+		return 0;
+	else if (!init_power9_pmu())
+		return 0;
+	else if (!init_ppc970_pmu())
+		return 0;
+	else
+		return -ENODEV;
+}
+early_initcall(init_ppc64_pmu);
diff --git a/arch/powerpc/perf/power5+-pmu.c b/arch/powerpc/perf/power5+-pmu.c
index 0526dac66007..9aa803504cb2 100644
--- a/arch/powerpc/perf/power5+-pmu.c
+++ b/arch/powerpc/perf/power5+-pmu.c
@@ -677,7 +677,7 @@ static struct power_pmu power5p_pmu = {
 	.cache_events		= &power5p_cache_events,
 };
 
-static int __init init_power5p_pmu(void)
+int init_power5p_pmu(void)
 {
 	if (!cur_cpu_spec->oprofile_cpu_type ||
 	    (strcmp(cur_cpu_spec->oprofile_cpu_type, "ppc64/power5+")
@@ -686,5 +686,3 @@ static int __init init_power5p_pmu(void)
 
 	return register_power_pmu(&power5p_pmu);
 }
-
-early_initcall(init_power5p_pmu);
diff --git a/arch/powerpc/perf/power5-pmu.c b/arch/powerpc/perf/power5-pmu.c
index 4dc99f9f7962..30cb13d081a9 100644
--- a/arch/powerpc/perf/power5-pmu.c
+++ b/arch/powerpc/perf/power5-pmu.c
@@ -618,7 +618,7 @@ static struct power_pmu power5_pmu = {
 	.flags			= PPMU_HAS_SSLOT,
 };
 
-static int __init init_power5_pmu(void)
+int init_power5_pmu(void)
 {
 	if (!cur_cpu_spec->oprofile_cpu_type ||
 	    strcmp(cur_cpu_spec->oprofile_cpu_type, "ppc64/power5"))
@@ -626,5 +626,3 @@ static int __init init_power5_pmu(void)
 
 	return register_power_pmu(&power5_pmu);
 }
-
-early_initcall(init_power5_pmu);
diff --git a/arch/powerpc/perf/power6-pmu.c b/arch/powerpc/perf/power6-pmu.c
index 9c9d646b68a1..80ec48632cfe 100644
--- a/arch/powerpc/perf/power6-pmu.c
+++ b/arch/powerpc/perf/power6-pmu.c
@@ -540,7 +540,7 @@ static struct power_pmu power6_pmu = {
 	.cache_events		= &power6_cache_events,
 };
 
-static int __init init_power6_pmu(void)
+int init_power6_pmu(void)
 {
 	if (!cur_cpu_spec->oprofile_cpu_type ||
 	    strcmp(cur_cpu_spec->oprofile_cpu_type, "ppc64/power6"))
@@ -548,5 +548,3 @@ static int __init init_power6_pmu(void)
 
 	return register_power_pmu(&power6_pmu);
 }
-
-early_initcall(init_power6_pmu);
diff --git a/arch/powerpc/perf/power7-pmu.c b/arch/powerpc/perf/power7-pmu.c
index 6dbae9884ec4..bb6efd5d2530 100644
--- a/arch/powerpc/perf/power7-pmu.c
+++ b/arch/powerpc/perf/power7-pmu.c
@@ -445,7 +445,7 @@ static struct power_pmu power7_pmu = {
 	.cache_events		= &power7_cache_events,
 };
 
-static int __init init_power7_pmu(void)
+int init_power7_pmu(void)
 {
 	if (!cur_cpu_spec->oprofile_cpu_type ||
 	    strcmp(cur_cpu_spec->oprofile_cpu_type, "ppc64/power7"))
@@ -456,5 +456,3 @@ static int __init init_power7_pmu(void)
 
 	return register_power_pmu(&power7_pmu);
 }
-
-early_initcall(init_power7_pmu);
diff --git a/arch/powerpc/perf/power8-pmu.c b/arch/powerpc/perf/power8-pmu.c
index d12a2db26353..bcc3409a06de 100644
--- a/arch/powerpc/perf/power8-pmu.c
+++ b/arch/powerpc/perf/power8-pmu.c
@@ -379,7 +379,7 @@ static struct power_pmu power8_pmu = {
 	.bhrb_nr		= 32,
 };
 
-static int __init init_power8_pmu(void)
+int init_power8_pmu(void)
 {
 	int rc;
 
@@ -399,4 +399,3 @@ static int __init init_power8_pmu(void)
 
 	return 0;
 }
-early_initcall(init_power8_pmu);
diff --git a/arch/powerpc/perf/power9-pmu.c b/arch/powerpc/perf/power9-pmu.c
index 030544e35959..3a31ac6f4805 100644
--- a/arch/powerpc/perf/power9-pmu.c
+++ b/arch/powerpc/perf/power9-pmu.c
@@ -437,7 +437,7 @@ static struct power_pmu power9_pmu = {
 	.bhrb_nr		= 32,
 };
 
-static int __init init_power9_pmu(void)
+int init_power9_pmu(void)
 {
 	int rc = 0;
 	unsigned int pvr = mfspr(SPRN_PVR);
@@ -467,4 +467,3 @@ static int __init init_power9_pmu(void)
 
 	return 0;
 }
-early_initcall(init_power9_pmu);
diff --git a/arch/powerpc/perf/ppc970-pmu.c b/arch/powerpc/perf/ppc970-pmu.c
index 8b6a8a36fa38..1d3370914022 100644
--- a/arch/powerpc/perf/ppc970-pmu.c
+++ b/arch/powerpc/perf/ppc970-pmu.c
@@ -490,7 +490,7 @@ static struct power_pmu ppc970_pmu = {
 	.flags			= PPMU_NO_SIPR | PPMU_NO_CONT_SAMPLING,
 };
 
-static int __init init_ppc970_pmu(void)
+int init_ppc970_pmu(void)
 {
 	if (!cur_cpu_spec->oprofile_cpu_type ||
 	    (strcmp(cur_cpu_spec->oprofile_cpu_type, "ppc64/970")
@@ -499,5 +499,3 @@ static int __init init_ppc970_pmu(void)
 
 	return register_power_pmu(&ppc970_pmu);
 }
-
-early_initcall(init_ppc970_pmu);
-- 
2.7.4

