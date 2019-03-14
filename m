Return-Path: <SRS0=OgF1=RR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F4B3C43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 02:34:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8712D20651
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 02:34:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8712D20651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=au1.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44KXpH1mkSzDqMd
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 13:33:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=au1.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=alastair@au1.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=au1.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44KXmR5yQXzDqLM
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Mar 2019 13:32:23 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x2E2NxZp057428
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Mar 2019 22:32:21 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2r78s5mdve-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Mar 2019 22:32:21 -0400
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <alastair@au1.ibm.com>;
 Thu, 14 Mar 2019 02:32:19 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 14 Mar 2019 02:32:16 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x2E2WFVl57016402
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 14 Mar 2019 02:32:15 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 06EE911C04A;
 Thu, 14 Mar 2019 02:32:15 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6343311C052;
 Thu, 14 Mar 2019 02:32:14 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu, 14 Mar 2019 02:32:14 +0000 (GMT)
Received: from adsilva.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 42745A00E2;
 Thu, 14 Mar 2019 13:32:13 +1100 (AEDT)
From: "Alastair D'Silva" <alastair@au1.ibm.com>
To: alastair@d-silva.org
Subject: [PATCH v2]  arch/powerpc: Rework local_paca to avoid LTO warnings
Date: Thu, 14 Mar 2019 13:31:23 +1100
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190313034208.13134-1-alastair@au1.ibm.com>
References: <20190313034208.13134-1-alastair@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19031402-0008-0000-0000-000002CD09F2
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19031402-0009-0000-0000-000022390A2A
Message-Id: <20190314023125.10076-1-alastair@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-03-14_01:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903140014
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
Cc: Michal Hocko <mhocko@suse.com>,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 Nicholas Piggin <npiggin@gmail.com>, Mike Rapoport <rppt@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>,
 "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Andrew Morton <akpm@linux-foundation.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Alastair D'Silva <alastair@d-silva.org>

When building an LTO kernel, the existing code generates warnings:
    ./arch/powerpc/include/asm/paca.h:37:30: warning: register of
        ‘local_paca’ used for multiple global register variables
     register struct paca_struct *local_paca asm("r13");
                                  ^
    ./arch/powerpc/include/asm/paca.h:37:30: note: conflicts with
        ‘local_paca’

This patch reworks local_paca into an inline getter & setter function,
which addresses the warning.

Changelog:
V2
  - Address whitespace issues
  - keep new implementation close to where the old implementation was

Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 arch/powerpc/include/asm/paca.h | 37 +++++++++++++++++++++++++--------
 arch/powerpc/kernel/paca.c      |  2 +-
 2 files changed, 29 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
index e843bc5d1a0f..2fa0b43357c9 100644
--- a/arch/powerpc/include/asm/paca.h
+++ b/arch/powerpc/include/asm/paca.h
@@ -34,19 +34,38 @@
 #include <asm/cpuidle.h>
 #include <asm/atomic.h>
 
-register struct paca_struct *local_paca asm("r13");
-
 #if defined(CONFIG_DEBUG_PREEMPT) && defined(CONFIG_SMP)
 extern unsigned int debug_smp_processor_id(void); /* from linux/smp.h */
-/*
- * Add standard checks that preemption cannot occur when using get_paca():
- * otherwise the paca_struct it points to may be the wrong one just after.
- */
-#define get_paca()	((void) debug_smp_processor_id(), local_paca)
-#else
-#define get_paca()	local_paca
 #endif
 
+static inline struct paca_struct *get_paca_no_preempt_check(void)
+{
+	register struct paca_struct *paca asm("r13");
+
+	return paca;
+}
+
+static inline struct paca_struct *get_paca(void)
+{
+#if defined(CONFIG_DEBUG_PREEMPT) && defined(CONFIG_SMP)
+	/*
+	 * Add standard checks that preemption cannot occur when using get_paca():
+	 * otherwise the paca_struct it points to may be the wrong one just after.
+	 */
+	debug_smp_processor_id();
+#endif
+	return get_paca_no_preempt_check();
+}
+
+#define local_paca	get_paca_no_preempt_check()
+
+static inline void set_paca(struct paca_struct *new)
+{
+	register struct paca_struct *paca asm("r13");
+
+	paca = new;
+}
+
 #ifdef CONFIG_PPC_PSERIES
 #define get_lppaca()	(get_paca()->lppaca_ptr)
 #endif
diff --git a/arch/powerpc/kernel/paca.c b/arch/powerpc/kernel/paca.c
index 913bfca09c4f..ae5c243f9d5a 100644
--- a/arch/powerpc/kernel/paca.c
+++ b/arch/powerpc/kernel/paca.c
@@ -172,7 +172,7 @@ void __init initialise_paca(struct paca_struct *new_paca, int cpu)
 void setup_paca(struct paca_struct *new_paca)
 {
 	/* Setup r13 */
-	local_paca = new_paca;
+	set_paca(new_paca);
 
 #ifdef CONFIG_PPC_BOOK3E
 	/* On Book3E, initialize the TLB miss exception frames */
-- 
2.20.1

