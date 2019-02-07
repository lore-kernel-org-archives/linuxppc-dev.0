Return-Path: <SRS0=N2MO=QO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9734DC282C2
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 07:09:16 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 197A82084D
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 07:09:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 197A82084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43w8Z20YfBzDqQy
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 18:09:14 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 43w8RV1TFCzDqQg
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Feb 2019 18:03:33 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x176sLM5019134
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Feb 2019 02:03:32 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2qgd4cx5em-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 Feb 2019 02:03:31 -0500
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <anju@linux.vnet.ibm.com>;
 Thu, 7 Feb 2019 07:03:30 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 7 Feb 2019 07:03:26 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x1773PAI4063720
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 7 Feb 2019 07:03:25 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BC44EA4067;
 Thu,  7 Feb 2019 07:03:25 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A7600A405B;
 Thu,  7 Feb 2019 07:03:24 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.145.146.114])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu,  7 Feb 2019 07:03:24 +0000 (GMT)
From: Anju T Sudhakar <anju@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Subject: [PATCH v3 2/5] powerpc/perf: Rearrange setting of ldbar for thread-imc
Date: Thu,  7 Feb 2019 12:33:09 +0530
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190207070312.5150-1-anju@linux.vnet.ibm.com>
References: <20190207070312.5150-1-anju@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19020707-0008-0000-0000-000002BD77A9
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19020707-0009-0000-0000-000022298052
Message-Id: <20190207070312.5150-3-anju@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-07_05:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902070054
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

LDBAR holds the memory address allocated for each cpu. For thread-imc
the mode bit (i.e bit 1) of LDBAR is set to accumulation.
Currently, ldbar is loaded with per cpu memory address and mode set to
accumulation at boot time.

To enable trace-imc, the mode bit of ldbar should be set to 'trace'. So to
accommodate trace-mode of IMC, reposition setting of ldbar for thread-imc
to thread_imc_event_add(). Also reset ldbar at thread_imc_event_del().

Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>
Reviewed-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/perf/imc-pmu.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/perf/imc-pmu.c b/arch/powerpc/perf/imc-pmu.c
index f292a3f284f1..3bef46f8417d 100644
--- a/arch/powerpc/perf/imc-pmu.c
+++ b/arch/powerpc/perf/imc-pmu.c
@@ -806,8 +806,11 @@ static int core_imc_event_init(struct perf_event *event)
 }
 
 /*
- * Allocates a page of memory for each of the online cpus, and write the
- * physical base address of that page to the LDBAR for that cpu.
+ * Allocates a page of memory for each of the online cpus, and load
+ * LDBAR with 0.
+ * The physical base address of the page allocated for a cpu will be
+ * written to the LDBAR for that cpu, when the thread-imc event
+ * is added.
  *
  * LDBAR Register Layout:
  *
@@ -825,7 +828,7 @@ static int core_imc_event_init(struct perf_event *event)
  */
 static int thread_imc_mem_alloc(int cpu_id, int size)
 {
-	u64 ldbar_value, *local_mem = per_cpu(thread_imc_mem, cpu_id);
+	u64 *local_mem = per_cpu(thread_imc_mem, cpu_id);
 	int nid = cpu_to_node(cpu_id);
 
 	if (!local_mem) {
@@ -842,9 +845,7 @@ static int thread_imc_mem_alloc(int cpu_id, int size)
 		per_cpu(thread_imc_mem, cpu_id) = local_mem;
 	}
 
-	ldbar_value = ((u64)local_mem & THREAD_IMC_LDBAR_MASK) | THREAD_IMC_ENABLE;
-
-	mtspr(SPRN_LDBAR, ldbar_value);
+	mtspr(SPRN_LDBAR, 0);
 	return 0;
 }
 
@@ -995,6 +996,7 @@ static int thread_imc_event_add(struct perf_event *event, int flags)
 {
 	int core_id;
 	struct imc_pmu_ref *ref;
+	u64 ldbar_value, *local_mem = per_cpu(thread_imc_mem, smp_processor_id());
 
 	if (flags & PERF_EF_START)
 		imc_event_start(event, flags);
@@ -1003,6 +1005,9 @@ static int thread_imc_event_add(struct perf_event *event, int flags)
 		return -EINVAL;
 
 	core_id = smp_processor_id() / threads_per_core;
+	ldbar_value = ((u64)local_mem & THREAD_IMC_LDBAR_MASK) | THREAD_IMC_ENABLE;
+	mtspr(SPRN_LDBAR, ldbar_value);
+
 	/*
 	 * imc pmus are enabled only when it is used.
 	 * See if this is triggered for the first time.
@@ -1034,11 +1039,7 @@ static void thread_imc_event_del(struct perf_event *event, int flags)
 	int core_id;
 	struct imc_pmu_ref *ref;
 
-	/*
-	 * Take a snapshot and calculate the delta and update
-	 * the event counter values.
-	 */
-	imc_event_update(event);
+	mtspr(SPRN_LDBAR, 0);
 
 	core_id = smp_processor_id() / threads_per_core;
 	ref = &core_imc_refc[core_id];
@@ -1057,6 +1058,11 @@ static void thread_imc_event_del(struct perf_event *event, int flags)
 		ref->refc = 0;
 	}
 	mutex_unlock(&ref->lock);
+	/*
+	 * Take a snapshot and calculate the delta and update
+	 * the event counter values.
+	 */
+	imc_event_update(event);
 }
 
 /* update_pmu_ops : Populate the appropriate operations for "pmu" */
-- 
2.17.1

