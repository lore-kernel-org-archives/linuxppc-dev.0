Return-Path: <SRS0=Olcr=NC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F3D7C004D3
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Oct 2018 15:05:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C103420645
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Oct 2018 15:05:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C103420645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42f0Ft00DDzDrhS
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Oct 2018 02:05:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=debian.org
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=leitao@debian.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=debian.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42f011165czF1Cr
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Oct 2018 01:54:44 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w9MEsW7Y038006
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Oct 2018 10:54:43 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2n9ete6gj2-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Oct 2018 10:54:43 -0400
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <leitao@debian.org>;
 Mon, 22 Oct 2018 10:54:41 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
 by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 22 Oct 2018 10:54:39 -0400
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com
 [9.57.199.111])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w9MEscN720054164
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 22 Oct 2018 14:54:38 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A51C0AC059;
 Mon, 22 Oct 2018 14:54:38 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ADA30AC05B;
 Mon, 22 Oct 2018 14:54:37 +0000 (GMT)
Received: from debra.ibm.com (unknown [9.85.163.197])
 by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
 Mon, 22 Oct 2018 14:54:37 +0000 (GMT)
From: Breno Leitao <leitao@debian.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 8/9] powerpc/perf: Declare static identifier a such
Date: Mon, 22 Oct 2018 11:54:19 -0300
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1540220060-30162-1-git-send-email-leitao@debian.org>
References: <1540220060-30162-1-git-send-email-leitao@debian.org>
X-TM-AS-GCONF: 00
x-cbid: 18102214-0040-0000-0000-00000484A2D8
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009916; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000268; SDB=6.01106373; UDB=6.00572935; IPR=6.00886458; 
 MB=3.00023857; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-22 14:54:41
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18102214-0041-0000-0000-0000088CBC66
Message-Id: <1540220060-30162-8-git-send-email-leitao@debian.org>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-10-22_08:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=981 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810220128
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
Cc: Breno Leitao <leitao@debian.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

There are three symbols (two variables and a function) that are being used
solely in the same file (imc-pmu.c), thus, these symbols should be static,
but they are not. This was detected by sparse:

	arch/powerpc/perf/imc-pmu.c:31:20: warning: symbol 'nest_imc_refc' was not declared. Should it be static?
	arch/powerpc/perf/imc-pmu.c:37:20: warning: symbol 'core_imc_refc' was not declared. Should it be static?
	arch/powerpc/perf/imc-pmu.c:46:16: warning: symbol 'imc_event_to_pmu' was not declared. Should it be static?

This patch simply adds the 'static' storage-class definition to these
symbols, thus, restricting their usage only in the imc-pmu.c file.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 arch/powerpc/perf/imc-pmu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/perf/imc-pmu.c b/arch/powerpc/perf/imc-pmu.c
index 1fafc32b12a0..1c693c7726f7 100644
--- a/arch/powerpc/perf/imc-pmu.c
+++ b/arch/powerpc/perf/imc-pmu.c
@@ -28,13 +28,13 @@ static DEFINE_MUTEX(nest_init_lock);
 static DEFINE_PER_CPU(struct imc_pmu_ref *, local_nest_imc_refc);
 static struct imc_pmu **per_nest_pmu_arr;
 static cpumask_t nest_imc_cpumask;
-struct imc_pmu_ref *nest_imc_refc;
+static struct imc_pmu_ref *nest_imc_refc;
 static int nest_pmus;
 
 /* Core IMC data structures and variables */
 
 static cpumask_t core_imc_cpumask;
-struct imc_pmu_ref *core_imc_refc;
+static struct imc_pmu_ref *core_imc_refc;
 static struct imc_pmu *core_imc_pmu;
 
 /* Thread IMC data structures and variables */
@@ -43,7 +43,7 @@ static DEFINE_PER_CPU(u64 *, thread_imc_mem);
 static struct imc_pmu *thread_imc_pmu;
 static int thread_imc_mem_size;
 
-struct imc_pmu *imc_event_to_pmu(struct perf_event *event)
+static struct imc_pmu *imc_event_to_pmu(struct perf_event *event)
 {
 	return container_of(event->pmu, struct imc_pmu, pmu);
 }
-- 
2.19.0

