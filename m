Return-Path: <SRS0=DRoX=MN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42516C43143
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Oct 2018 19:49:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85F402146D
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Oct 2018 19:49:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85F402146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42PCYC0xZNzF3Bj
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 05:49:51 +1000 (AEST)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 42PCW44f0wzF37n
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Oct 2018 05:48:00 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w91JdHhN112152
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 1 Oct 2018 15:47:57 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2murm7bcy2-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 Oct 2018 15:47:57 -0400
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <leitao@debian.org>;
 Mon, 1 Oct 2018 13:47:56 -0600
Received: from b03cxnp08027.gho.boulder.ibm.com (9.17.130.19)
 by e31.co.us.ibm.com (192.168.1.131) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 1 Oct 2018 13:47:54 -0600
Received: from b03ledav005.gho.boulder.ibm.com
 (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w91Jlr9G46923982
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 1 Oct 2018 12:47:53 -0700
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7A0BBBE04F;
 Mon,  1 Oct 2018 13:47:53 -0600 (MDT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DA178BE051;
 Mon,  1 Oct 2018 13:47:51 -0600 (MDT)
Received: from debra.ibm.com (unknown [9.80.236.140])
 by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
 Mon,  1 Oct 2018 13:47:51 -0600 (MDT)
From: Breno Leitao <leitao@debian.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/2] powerpc/tm: Move tm_enable definition
Date: Mon,  1 Oct 2018 16:47:49 -0300
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
x-cbid: 18100119-8235-0000-0000-00000E0AC43C
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009804; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000267; SDB=6.01096445; UDB=6.00566952; IPR=6.00876488; 
 MB=3.00023577; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-01 19:47:56
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18100119-8236-0000-0000-000042D70EEE
Message-Id: <1538423270-17527-1-git-send-email-leitao@debian.org>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-10-01_10:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810010188
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
Cc: Breno Leitao <leitao@debian.org>, mikey@neuling.org,
 gromero@linux.vnet.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The goal of this patch is to move function tm_enabled() to tm.h in order
to allow this function to be used by other files as an inline function.

This patch also removes the double inclusion of tm.h in the traps.c
source code. One inclusion is inside a CONFIG_PPC64 ifdef block, and
another one is in the generic part. This double inclusion causes a
redefinition of tm_enable(), that is why it is being fixed here.

There is generic code (non CONFIG_PPC64, thus, non
CONFIG_PPC_TRANSACTIONAL_MEM also) using some TM definitions, which
explains why tm.h is being imported in the generic code. This is
not correct, and this code is now surrounded by a
CONFIG_PPC_TRANSACTIONAL_MEM ifdef block.

These ifdef inclusion will avoid calling tm_abort_check() completely,
but it is not a problem since this function is just returning 'false' if
CONFIG_PPC_TRANSACTIONAL_MEM is not defined.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 arch/powerpc/include/asm/tm.h | 5 +++++
 arch/powerpc/kernel/process.c | 5 -----
 arch/powerpc/kernel/traps.c   | 5 ++++-
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/tm.h b/arch/powerpc/include/asm/tm.h
index e94f6db5e367..646d45a2aaae 100644
--- a/arch/powerpc/include/asm/tm.h
+++ b/arch/powerpc/include/asm/tm.h
@@ -19,4 +19,9 @@ extern void tm_restore_sprs(struct thread_struct *thread);
 
 extern bool tm_suspend_disabled;
 
+static inline bool tm_enabled(struct task_struct *tsk)
+{
+	return tsk && tsk->thread.regs && (tsk->thread.regs->msr & MSR_TM);
+}
+
 #endif /* __ASSEMBLY__ */
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 913c5725cdb2..c1ca2451fa3b 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -862,11 +862,6 @@ static inline bool hw_brk_match(struct arch_hw_breakpoint *a,
 
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
 
-static inline bool tm_enabled(struct task_struct *tsk)
-{
-	return tsk && tsk->thread.regs && (tsk->thread.regs->msr & MSR_TM);
-}
-
 static void tm_reclaim_thread(struct thread_struct *thr, uint8_t cause)
 {
 	/*
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index c85adb858271..a3d6298b8074 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -64,7 +64,6 @@
 #include <asm/rio.h>
 #include <asm/fadump.h>
 #include <asm/switch_to.h>
-#include <asm/tm.h>
 #include <asm/debug.h>
 #include <asm/asm-prototypes.h>
 #include <asm/hmi.h>
@@ -1276,9 +1275,11 @@ static int emulate_instruction(struct pt_regs *regs)
 
 	/* Emulate load/store string insn. */
 	if ((instword & PPC_INST_STRING_GEN_MASK) == PPC_INST_STRING) {
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
 		if (tm_abort_check(regs,
 				   TM_CAUSE_EMULATE | TM_CAUSE_PERSISTENT))
 			return -EINVAL;
+#endif
 		PPC_WARN_EMULATED(string, regs);
 		return emulate_string_inst(regs, instword);
 	}
@@ -1508,8 +1509,10 @@ void alignment_exception(struct pt_regs *regs)
 	if (!arch_irq_disabled_regs(regs))
 		local_irq_enable();
 
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
 	if (tm_abort_check(regs, TM_CAUSE_ALIGNMENT | TM_CAUSE_PERSISTENT))
 		goto bail;
+#endif
 
 	/* we don't implement logging of alignment exceptions */
 	if (!(current->thread.align_ctl & PR_UNALIGN_SIGBUS))
-- 
2.19.0

