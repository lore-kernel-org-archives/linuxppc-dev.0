Return-Path: <SRS0=Jq0w=TK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF56CC04A6B
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 May 2019 16:29:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6750320896
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 May 2019 16:29:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6750320896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 450wdq2DHCzDqST
	for <linuxppc-dev@archiver.kernel.org>; Sat, 11 May 2019 02:29:19 +1000 (AEST)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 450wZq3LgqzDqRg
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 May 2019 02:26:43 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x4AGLZPN054277
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 May 2019 12:26:41 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2sdc6y1fhs-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 May 2019 12:26:41 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Fri, 10 May 2019 17:26:39 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 10 May 2019 17:26:38 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x4AGQaml51118250
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 10 May 2019 16:26:36 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6F108A4051;
 Fri, 10 May 2019 16:26:36 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F2DD8A405E;
 Fri, 10 May 2019 16:26:34 +0000 (GMT)
Received: from naverao1-tp.ibm.com (unknown [9.79.183.144])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 10 May 2019 16:26:34 +0000 (GMT)
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 1/8] powerpc/pseries: Use macros for referring to the DTL
 enable mask
Date: Fri, 10 May 2019 21:56:16 +0530
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1557502887.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1557502887.git.naveen.n.rao@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19051016-4275-0000-0000-0000033379C3
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19051016-4276-0000-0000-00003842F0F5
Message-Id: <e0600b1eb8e4c03f9c68db9afdf88b026c37b389.1557502887.git.naveen.n.rao@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-05-09_02:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=699 adultscore=0 classifier=spam adjust=0 reason=mlx
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

Introduce macros to encode the DTL enable mask fields and use those
instead of hardcoding numbers.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/lppaca.h      | 11 +++++++++++
 arch/powerpc/platforms/pseries/dtl.c   |  8 +-------
 arch/powerpc/platforms/pseries/lpar.c  |  2 +-
 arch/powerpc/platforms/pseries/setup.c |  2 +-
 4 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/include/asm/lppaca.h b/arch/powerpc/include/asm/lppaca.h
index 7c23ce8a5a4c..2c7e31187726 100644
--- a/arch/powerpc/include/asm/lppaca.h
+++ b/arch/powerpc/include/asm/lppaca.h
@@ -154,6 +154,17 @@ struct dtl_entry {
 #define DISPATCH_LOG_BYTES	4096	/* bytes per cpu */
 #define N_DISPATCH_LOG		(DISPATCH_LOG_BYTES / sizeof(struct dtl_entry))
 
+/*
+ * Dispatch trace log event enable mask:
+ *   0x1: voluntary virtual processor waits
+ *   0x2: time-slice preempts
+ *   0x4: virtual partition memory page faults
+ */
+#define DTL_LOG_CEDE		0x1
+#define DTL_LOG_PREEMPT		0x2
+#define DTL_LOG_FAULT		0x4
+#define DTL_LOG_ALL		(DTL_LOG_CEDE | DTL_LOG_PREEMPT | DTL_LOG_FAULT)
+
 extern struct kmem_cache *dtl_cache;
 
 /*
diff --git a/arch/powerpc/platforms/pseries/dtl.c b/arch/powerpc/platforms/pseries/dtl.c
index ef6595153642..051ea2de1e1a 100644
--- a/arch/powerpc/platforms/pseries/dtl.c
+++ b/arch/powerpc/platforms/pseries/dtl.c
@@ -40,13 +40,7 @@ struct dtl {
 };
 static DEFINE_PER_CPU(struct dtl, cpu_dtl);
 
-/*
- * Dispatch trace log event mask:
- * 0x7: 0x1: voluntary virtual processor waits
- *      0x2: time-slice preempts
- *      0x4: virtual partition memory page faults
- */
-static u8 dtl_event_mask = 0x7;
+static u8 dtl_event_mask = DTL_LOG_ALL;
 
 
 /*
diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index 1034ef1fe2b4..23f2ac6793b7 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -126,7 +126,7 @@ void vpa_init(int cpu)
 			pr_err("WARNING: DTL registration of cpu %d (hw %d) "
 			       "failed with %ld\n", smp_processor_id(),
 			       hwcpu, ret);
-		lppaca_of(cpu).dtl_enable_mask = 2;
+		lppaca_of(cpu).dtl_enable_mask = DTL_LOG_PREEMPT;
 	}
 }
 
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index e4f0dfd4ae33..fabaefff8399 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -316,7 +316,7 @@ static int alloc_dispatch_logs(void)
 		pr_err("WARNING: DTL registration of cpu %d (hw %d) failed "
 		       "with %d\n", smp_processor_id(),
 		       hard_smp_processor_id(), ret);
-	get_paca()->lppaca_ptr->dtl_enable_mask = 2;
+	get_paca()->lppaca_ptr->dtl_enable_mask = DTL_LOG_PREEMPT;
 
 	return 0;
 }
-- 
2.21.0

