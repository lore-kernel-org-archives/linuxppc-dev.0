Return-Path: <SRS0=K8Qv=N6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3BDDC43441
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Nov 2018 12:48:04 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F45720851
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Nov 2018 12:48:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F45720851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42z7ss5qQDzF3L8
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Nov 2018 23:48:01 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 42z7pK5X46zF3Kt
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Nov 2018 23:44:56 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wAJCdKUp014941
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Nov 2018 07:44:55 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2nuw34h8sm-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Nov 2018 07:44:54 -0500
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <leitao@debian.org>;
 Mon, 19 Nov 2018 12:44:54 -0000
Received: from b03cxnp08027.gho.boulder.ibm.com (9.17.130.19)
 by e31.co.us.ibm.com (192.168.1.131) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 19 Nov 2018 12:44:50 -0000
Received: from b03ledav004.gho.boulder.ibm.com
 (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wAJCinDb24641578
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 19 Nov 2018 12:44:49 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C33BB7805E;
 Mon, 19 Nov 2018 12:44:49 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D5CC37805C;
 Mon, 19 Nov 2018 12:44:47 +0000 (GMT)
Received: from debra.ibm.com (unknown [9.80.233.129])
 by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
 Mon, 19 Nov 2018 12:44:47 +0000 (GMT)
From: Breno Leitao <leitao@debian.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/tm: Set MSR[TS] just prior to recheckpoint
Date: Mon, 19 Nov 2018 10:44:54 -0200
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
x-cbid: 18111912-8235-0000-0000-00000E2A96C3
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010079; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01119695; UDB=6.00580952; IPR=6.00899817; 
 MB=3.00024229; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-19 12:44:52
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18111912-8236-0000-0000-000043693FBF
Message-Id: <1542631494-10344-1-git-send-email-leitao@debian.org>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-11-19_04:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=626 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811190118
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
 "v3.9+" <stable@vger.kernel.org>, gromero@linux.vnet.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On a signal handler return, the user could set a context with MSR[TS] bits
set, and these bits would be copied to task regs->msr.

At restore_tm_sigcontexts(), after current task regs->msr[TS] bits are set,
several __get_user() are called and then a recheckpoint is executed.

This is a problem since a page fault (in kernel space) could happen when
calling __get_user(). If it happens, the process MSR[TS] bits were
already set, but recheckpoint was not executed, and SPRs are still invalid.

The page fault can cause the current process to be de-scheduled, with
MSR[TS] active and without tm_recheckpoint() being called.  More
importantly, without TEXAR[FS] bit set also.

Since TEXASR might not have the FS bit set, and when the process is
scheduled back, it will try to reclaim, which will be aborted because of
the CPU is not in the suspended state, and, then, recheckpoint. This
recheckpoint will restore thread->texasr into TEXASR SPR, which might be
zero, hitting a BUG_ON().

	[ 2181.457997] kernel BUG at arch/powerpc/kernel/tm.S:446!

This patch simply delays the MSR[TS] set, so, if there is any page fault in
the __get_user() section, it does not have regs->msr[TS] set, since the TM
structures are still invalid, thus avoiding doing TM operations for
in-kernel exceptions and possible process reschedule.

With this patch, the MSR[TS] will only be set just before recheckpointing
and setting TEXASR[FS] = 1, thus avoiding an interrupt with TM registers in
invalid state.

It is not possible to move tm_recheckpoint to happen earlier, because it is
required to get the checkpointed registers from userspace, with
__get_user(), thus, the only way to avoid this undesired behavior is
delaying the MSR[TS] set, as done in this patch.

Fixes: 87b4e5393af7 ("powerpc/tm: Fix return of active 64bit signals")
Cc: stable@vger.kernel.org (v3.9+)
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 arch/powerpc/kernel/signal_64.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/kernel/signal_64.c b/arch/powerpc/kernel/signal_64.c
index 83d51bf586c7..15b153bdd826 100644
--- a/arch/powerpc/kernel/signal_64.c
+++ b/arch/powerpc/kernel/signal_64.c
@@ -467,20 +467,6 @@ static long restore_tm_sigcontexts(struct task_struct *tsk,
 	if (MSR_TM_RESV(msr))
 		return -EINVAL;
 
-	/* pull in MSR TS bits from user context */
-	regs->msr = (regs->msr & ~MSR_TS_MASK) | (msr & MSR_TS_MASK);
-
-	/*
-	 * Ensure that TM is enabled in regs->msr before we leave the signal
-	 * handler. It could be the case that (a) user disabled the TM bit
-	 * through the manipulation of the MSR bits in uc_mcontext or (b) the
-	 * TM bit was disabled because a sufficient number of context switches
-	 * happened whilst in the signal handler and load_tm overflowed,
-	 * disabling the TM bit. In either case we can end up with an illegal
-	 * TM state leading to a TM Bad Thing when we return to userspace.
-	 */
-	regs->msr |= MSR_TM;
-
 	/* pull in MSR LE from user context */
 	regs->msr = (regs->msr & ~MSR_LE) | (msr & MSR_LE);
 
@@ -572,6 +558,21 @@ static long restore_tm_sigcontexts(struct task_struct *tsk,
 	tm_enable();
 	/* Make sure the transaction is marked as failed */
 	tsk->thread.tm_texasr |= TEXASR_FS;
+
+	/* pull in MSR TS bits from user context */
+	regs->msr = (regs->msr & ~MSR_TS_MASK) | (msr & MSR_TS_MASK);
+
+	/*
+	 * Ensure that TM is enabled in regs->msr before we leave the signal
+	 * handler. It could be the case that (a) user disabled the TM bit
+	 * through the manipulation of the MSR bits in uc_mcontext or (b) the
+	 * TM bit was disabled because a sufficient number of context switches
+	 * happened whilst in the signal handler and load_tm overflowed,
+	 * disabling the TM bit. In either case we can end up with an illegal
+	 * TM state leading to a TM Bad Thing when we return to userspace.
+	 */
+	regs->msr |= MSR_TM;
+
 	/* This loads the checkpointed FP/VEC state, if used */
 	tm_recheckpoint(&tsk->thread);
 
-- 
2.19.0

