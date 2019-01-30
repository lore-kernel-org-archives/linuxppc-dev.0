Return-Path: <SRS0=D1of=QG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8509C282D7
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Jan 2019 12:50:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5812C20882
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Jan 2019 12:50:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5812C20882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43qNVw5bQKzDqDQ
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Jan 2019 23:50:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=debian.org
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=leitao@debian.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=debian.org
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43qNQV40QQzDqDQ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Jan 2019 23:46:10 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x0UCibc3104968
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Jan 2019 07:46:07 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2qbaetn9cr-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Jan 2019 07:46:07 -0500
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <leitao@debian.org>;
 Wed, 30 Jan 2019 12:46:06 -0000
Received: from b03cxnp08026.gho.boulder.ibm.com (9.17.130.18)
 by e36.co.us.ibm.com (192.168.1.136) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 30 Jan 2019 12:46:04 -0000
Received: from b03ledav006.gho.boulder.ibm.com
 (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x0UCk3cS27001060
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 30 Jan 2019 12:46:03 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9F544C6057;
 Wed, 30 Jan 2019 12:46:03 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2CD14C6059;
 Wed, 30 Jan 2019 12:46:02 +0000 (GMT)
Received: from debra.ibm.com (unknown [9.80.205.30])
 by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
 Wed, 30 Jan 2019 12:46:01 +0000 (GMT)
From: Breno Leitao <leitao@debian.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH V2] powerpc/ptrace: Mitigate potential Spectre v1
Date: Wed, 30 Jan 2019 10:46:00 -0200
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
x-cbid: 19013012-0020-0000-0000-00000EB3FA42
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010503; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000277; SDB=6.01153916; UDB=6.00601639; IPR=6.00934290; 
 MB=3.00025353; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-30 12:46:05
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19013012-0021-0000-0000-0000649D5620
Message-Id: <1548852360-29886-1-git-send-email-leitao@debian.org>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-01-30_09:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=850 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901300102
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
Cc: Breno Leitao <leitao@debian.org>, gustavo@embeddedor.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

'regno' is directly controlled by user space, hence leading to a potential
exploitation of the Spectre variant 1 vulnerability.

On PTRACE_SETREGS and PTRACE_GETREGS requests, user space passes the
register number that would be read or written. This register number is
called 'regno' which is part of the 'addr' syscall parameter.

This 'regno' value is checked against the maximum pt_regs structure size,
and then used to dereference it, which matches the initial part of a
Spectre v1 (and Spectre v1.1) attack. The dereferenced value, then,
is returned to userspace in the GETREGS case.

This patch sanitizes 'regno' before using it to dereference pt_reg.

Notice that given that speculation windows are large, the policy is
to kill the speculation on the first load and not worry if it can be
completed with a dependent load/store [1].

[1] https://marc.info/?l=linux-kernel&m=152449131114778&w=2

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 arch/powerpc/kernel/ptrace.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index cdd5d1d3ae41..7535f89e08cd 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -33,6 +33,7 @@
 #include <linux/hw_breakpoint.h>
 #include <linux/perf_event.h>
 #include <linux/context_tracking.h>
+#include <linux/nospec.h>
 
 #include <linux/uaccess.h>
 #include <linux/pkeys.h>
@@ -274,6 +275,8 @@ static int set_user_trap(struct task_struct *task, unsigned long trap)
  */
 int ptrace_get_reg(struct task_struct *task, int regno, unsigned long *data)
 {
+	unsigned int regs_max;
+
 	if ((task->thread.regs == NULL) || !data)
 		return -EIO;
 
@@ -297,7 +300,9 @@ int ptrace_get_reg(struct task_struct *task, int regno, unsigned long *data)
 	}
 #endif
 
-	if (regno < (sizeof(struct user_pt_regs) / sizeof(unsigned long))) {
+	regs_max = sizeof(struct user_pt_regs) / sizeof(unsigned long);
+	if (regno < regs_max) {
+		regno = array_index_nospec(regno, regs_max);
 		*data = ((unsigned long *)task->thread.regs)[regno];
 		return 0;
 	}
@@ -321,6 +326,7 @@ int ptrace_put_reg(struct task_struct *task, int regno, unsigned long data)
 		return set_user_dscr(task, data);
 
 	if (regno <= PT_MAX_PUT_REG) {
+		regno = array_index_nospec(regno, PT_MAX_PUT_REG + 1);
 		((unsigned long *)task->thread.regs)[regno] = data;
 		return 0;
 	}
-- 
2.19.0

