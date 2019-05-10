Return-Path: <SRS0=Jq0w=TK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CCF3C04A6B
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 May 2019 16:38:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED19A21479
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 May 2019 16:38:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED19A21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 450wr65zKdzDqRw
	for <linuxppc-dev@archiver.kernel.org>; Sat, 11 May 2019 02:38:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=naveen.n.rao@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 450wb41GSZzDqS0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 May 2019 02:26:55 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x4AGLb78009086
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 May 2019 12:26:54 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2sdc161ybr-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 May 2019 12:26:53 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Fri, 10 May 2019 17:26:51 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 10 May 2019 17:26:50 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x4AGQm9t49283134
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 10 May 2019 16:26:48 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8FD64A4055;
 Fri, 10 May 2019 16:26:48 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1FABDA4053;
 Fri, 10 May 2019 16:26:47 +0000 (GMT)
Received: from naverao1-tp.ibm.com (unknown [9.79.183.144])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 10 May 2019 16:26:46 +0000 (GMT)
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 7/8] powerpc/pseries: Protect against hogging the cpu while
 setting up the stats
Date: Fri, 10 May 2019 21:56:22 +0530
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1557502887.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1557502887.git.naveen.n.rao@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19051016-4275-0000-0000-0000033379C5
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19051016-4276-0000-0000-00003842F0F7
Message-Id: <47fb6282080bd8d61d24e0cbe8b014b0da9ef1a8.1557502887.git.naveen.n.rao@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-05-09_02:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905100111
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
Cc: Nathan Lynch <nathanl@linux.ibm.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Mingming Cao <mingming.cao@ibm.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

When enabling or disabling the vcpu dispatch statistics, we do a lot of
work including allocating/deallocating memory across all possible cpus
for the DTL buffer. In order to guard against hogging the cpu for too
long, track the time we're taking and yield the processor if necessary.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/plpar_wrappers.h |  2 +-
 arch/powerpc/platforms/pseries/lpar.c     | 29 ++++++++++++++++-------
 arch/powerpc/platforms/pseries/setup.c    |  2 +-
 3 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/include/asm/plpar_wrappers.h b/arch/powerpc/include/asm/plpar_wrappers.h
index ab7dd454b6eb..d01bf0036e4d 100644
--- a/arch/powerpc/include/asm/plpar_wrappers.h
+++ b/arch/powerpc/include/asm/plpar_wrappers.h
@@ -91,7 +91,7 @@ static inline long register_dtl(unsigned long cpu, unsigned long vpa)
 extern bool register_dtl_buffer_access(bool global);
 extern void unregister_dtl_buffer_access(bool global);
 extern void register_dtl_buffer(int cpu);
-extern void alloc_dtl_buffers(void);
+extern void alloc_dtl_buffers(unsigned long *time_limit);
 extern void vpa_init(int cpu);
 
 static inline long plpar_pte_enter(unsigned long flags,
diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index b808a70cc253..8bc1b950cfd0 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -257,7 +257,7 @@ static void process_dtl_buffer(struct work_struct *work)
 					HZ / vcpudispatch_stats_freq);
 }
 
-void alloc_dtl_buffers(void)
+void alloc_dtl_buffers(unsigned long *time_limit)
 {
 	int cpu;
 	struct paca_struct *pp;
@@ -281,10 +281,15 @@ void alloc_dtl_buffers(void)
 		pp->dispatch_log = dtl;
 		pp->dispatch_log_end = dtl + N_DISPATCH_LOG;
 		pp->dtl_curr = dtl;
+
+		if (time_limit && time_after(jiffies, *time_limit)) {
+			cond_resched();
+			*time_limit = jiffies + HZ;
+		}
 	}
 }
 
-static void free_dtl_buffers(void)
+static void free_dtl_buffers(unsigned long *time_limit)
 {
 #ifndef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
 	int cpu;
@@ -299,6 +304,11 @@ static void free_dtl_buffers(void)
 		pp->dispatch_log = 0;
 		pp->dispatch_log_end = 0;
 		pp->dtl_curr = 0;
+
+		if (time_limit && time_after(jiffies, *time_limit)) {
+			cond_resched();
+			*time_limit = jiffies + HZ;
+		}
 	}
 #endif
 }
@@ -381,7 +391,7 @@ static void reset_global_dtl_mask(void)
 		lppaca_of(cpu).dtl_enable_mask = dtl_mask;
 }
 
-static int dtl_worker_enable(void)
+static int dtl_worker_enable(unsigned long *time_limit)
 {
 	int rc = 0, state;
 
@@ -400,13 +410,13 @@ static int dtl_worker_enable(void)
 	set_global_dtl_mask(DTL_LOG_ALL);
 
 	/* Setup dtl buffers and register those */
-	alloc_dtl_buffers();
+	alloc_dtl_buffers(time_limit);
 
 	state = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "powerpc/dtl:online",
 					dtl_worker_online, dtl_worker_offline);
 	if (state < 0) {
 		pr_err("vcpudispatch_stats: unable to setup workqueue for DTL processing\n");
-		free_dtl_buffers();
+		free_dtl_buffers(time_limit);
 		reset_global_dtl_mask();
 		unregister_dtl_buffer_access(1);
 		rc = -EINVAL;
@@ -420,14 +430,14 @@ static int dtl_worker_enable(void)
 	return rc;
 }
 
-static void dtl_worker_disable(void)
+static void dtl_worker_disable(unsigned long *time_limit)
 {
 	mutex_lock(&dtl_worker_mutex);
 	dtl_worker_refctr--;
 	if (!dtl_worker_refctr) {
 		cpuhp_remove_state(dtl_worker_state);
 		dtl_worker_state = 0;
-		free_dtl_buffers();
+		free_dtl_buffers(time_limit);
 		reset_global_dtl_mask();
 		unregister_dtl_buffer_access(1);
 	}
@@ -437,6 +447,7 @@ static void dtl_worker_disable(void)
 static ssize_t vcpudispatch_stats_write(struct file *file, const char __user *p,
 		size_t count, loff_t *ppos)
 {
+	unsigned long time_limit = jiffies + HZ;
 	struct vcpu_dispatch_data *disp;
 	int rc, cmd, cpu;
 	char buf[16];
@@ -469,13 +480,13 @@ static ssize_t vcpudispatch_stats_write(struct file *file, const char __user *p,
 			disp->last_disp_cpu = -1;
 		}
 
-		rc = dtl_worker_enable();
+		rc = dtl_worker_enable(&time_limit);
 		if (rc) {
 			destroy_cpu_associativity();
 			return rc;
 		}
 	} else {
-		dtl_worker_disable();
+		dtl_worker_disable(&time_limit);
 		destroy_cpu_associativity();
 	}
 
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index b6995e5cc5c9..c98246343752 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -283,7 +283,7 @@ static int alloc_dispatch_logs(void)
 	if (!dtl_cache)
 		return 0;
 
-	alloc_dtl_buffers();
+	alloc_dtl_buffers(0);
 
 	/* Register the DTL for the current (boot) cpu */
 	register_dtl_buffer(smp_processor_id());
-- 
2.21.0

