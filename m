Return-Path: <SRS0=D1of=QG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 011CCC282D8
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Jan 2019 21:25:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FC02218AF
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Jan 2019 21:24:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FC02218AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43qbx431z3zDqQR
	for <linuxppc-dev@archiver.kernel.org>; Thu, 31 Jan 2019 08:24:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=mwb@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43qbvL2QfjzDqTJ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Jan 2019 08:23:25 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x0ULJKT2052291
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Jan 2019 16:23:23 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2qbjtyaj7v-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Jan 2019 16:23:22 -0500
Received: from localhost
 by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Wed, 30 Jan 2019 21:23:22 -0000
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
 by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 30 Jan 2019 21:23:20 -0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com
 [9.57.199.107])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x0ULNJfU21758110
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 30 Jan 2019 21:23:19 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2E4E1124055;
 Wed, 30 Jan 2019 21:23:19 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 11628124054;
 Wed, 30 Jan 2019 21:23:19 +0000 (GMT)
Received: from ltcalpine2-lp20.aus.stglabs.ibm.com (unknown [9.40.195.203])
 by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
 Wed, 30 Jan 2019 21:23:19 +0000 (GMT)
Received: from ltcalpine2-lp20.aus.stglabs.ibm.com (localhost [IPv6:::1])
 by ltcalpine2-lp20.aus.stglabs.ibm.com (Postfix) with ESMTP id 9C7154260173;
 Wed, 30 Jan 2019 15:23:18 -0600 (CST)
Subject: [PATCH v02] powerpc/pseries: Check for ceded CPU's during LPAR
 migration
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, Juliet Kim <minkim@us.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Thomas Falcon <tlfalcon@linux.vnet.ibm.com>,
 Nathan Lynch <nathanl@linux.vnet.ibm.com>,
 Gustavo Walbon <gwalbon@linux.vnet.ibm.com>, mwb@linux.vnet.ibm.com
Date: Wed, 30 Jan 2019 15:23:18 -0600
User-Agent: StGit/0.18-105-g416a-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19013021-2213-0000-0000-00000347DAFB
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010506; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000277; SDB=6.01154086; UDB=6.00601742; IPR=6.00934463; 
 MB=3.00025360; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-30 21:23:21
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19013021-2214-0000-0000-00005D2C8916
Message-Id: <20190130212220.11315.76901.stgit@ltcalpine2-lp20.aus.stglabs.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-01-30_16:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901300157
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This patch is to check for cede'ed CPUs during LPM.  Some extreme
tests encountered a problem ehere Linux has put some threads to
sleep (possibly to save energy or something), LPM was attempted,
and the Linux kernel didn't awaken the sleeping threads, but issued
the H_JOIN for the active threads.  Since the sleeping threads
are not awake, they can not issue the expected H_JOIN, and the
partition would never suspend.  This patch wakes the sleeping
threads back up.

Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Signed-off-by: Gustavo Walbon <gwalbon@linux.vnet.ibm.com>
---
Changes in v02:
   -- Rebase to latest powerpc kernel source.
---
 arch/powerpc/include/asm/plpar_wrappers.h |    6 ++----
 arch/powerpc/kernel/rtas.c                |    8 +++++++-
 arch/powerpc/platforms/pseries/setup.c    |   18 ++++++++++++++++++
 3 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/plpar_wrappers.h b/arch/powerpc/include/asm/plpar_wrappers.h
index cff5a41..8292eff 100644
--- a/arch/powerpc/include/asm/plpar_wrappers.h
+++ b/arch/powerpc/include/asm/plpar_wrappers.h
@@ -26,10 +26,8 @@ static inline void set_cede_latency_hint(u8 latency_hint)
 	get_lppaca()->cede_latency_hint = latency_hint;
 }
 
-static inline long cede_processor(void)
-{
-	return plpar_hcall_norets(H_CEDE);
-}
+int cpu_is_ceded(int cpu);
+long cede_processor(void);
 
 static inline long extended_cede_processor(unsigned long latency_hint)
 {
diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
index de35bd8f..fea3d21 100644
--- a/arch/powerpc/kernel/rtas.c
+++ b/arch/powerpc/kernel/rtas.c
@@ -44,6 +44,7 @@
 #include <asm/time.h>
 #include <asm/mmu.h>
 #include <asm/topology.h>
+#include <asm/plpar_wrappers.h>
 
 /* This is here deliberately so it's only used in this file */
 void enter_rtas(unsigned long);
@@ -942,7 +943,7 @@ int rtas_ibm_suspend_me(u64 handle)
 	struct rtas_suspend_me_data data;
 	DECLARE_COMPLETION_ONSTACK(done);
 	cpumask_var_t offline_mask;
-	int cpuret;
+	int cpuret, cpu;
 
 	if (!rtas_service_present("ibm,suspend-me"))
 		return -ENOSYS;
@@ -991,6 +992,11 @@ int rtas_ibm_suspend_me(u64 handle)
 		goto out_hotplug_enable;
 	}
 
+	for_each_present_cpu(cpu) {
+		if (cpu_is_ceded(cpu))
+			plpar_hcall_norets(H_PROD, get_hard_smp_processor_id(cpu));
+	}
+
 	/* Call function on all CPUs.  One of us will make the
 	 * rtas call
 	 */
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 41f62ca2..48ae6d4 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -331,6 +331,24 @@ static int alloc_dispatch_log_kmem_cache(void)
 }
 machine_early_initcall(pseries, alloc_dispatch_log_kmem_cache);
 
+static DEFINE_PER_CPU(int, cpu_ceded);
+
+int cpu_is_ceded(int cpu)
+{
+	return per_cpu(cpu_ceded, cpu);
+}
+
+long cede_processor(void)
+{
+	long rc;
+
+	per_cpu(cpu_ceded, raw_smp_processor_id()) = 1;
+	rc = plpar_hcall_norets(H_CEDE);
+	per_cpu(cpu_ceded, raw_smp_processor_id()) = 0;
+
+	return rc;
+}
+
 static void pseries_lpar_idle(void)
 {
 	/*

