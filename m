Return-Path: <SRS0=FZqe=NR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5295C32789
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Nov 2018 12:56:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AE032083D
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Nov 2018 12:56:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AE032083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42q8gh1n12zDrHF
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Nov 2018 23:56:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=debian.org
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 42q8KQ1tbzzF39K
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Nov 2018 23:40:42 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wA6CYYNJ112514
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Nov 2018 07:40:39 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2nk94j5rda-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Nov 2018 07:40:39 -0500
Received: from localhost
 by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <leitao@debian.org>;
 Tue, 6 Nov 2018 12:40:38 -0000
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
 by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 6 Nov 2018 12:40:35 -0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com
 [9.57.199.111])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wA6CeYT334209928
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 6 Nov 2018 12:40:34 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 125E4AC05E;
 Tue,  6 Nov 2018 12:40:34 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C27E7AC059;
 Tue,  6 Nov 2018 12:40:32 +0000 (GMT)
Received: from debra.ibm.com (unknown [9.18.239.97])
 by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue,  6 Nov 2018 12:40:32 +0000 (GMT)
From: Breno Leitao <leitao@debian.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH 03/14] powerpc/tm: Recheckpoint when exiting from kernel
Date: Tue,  6 Nov 2018 10:40:17 -0200
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1541508028-31865-1-git-send-email-leitao@debian.org>
References: <1541508028-31865-1-git-send-email-leitao@debian.org>
X-TM-AS-GCONF: 00
x-cbid: 18110612-0052-0000-0000-000003512125
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009996; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000268; SDB=6.01113483; UDB=6.00577209; IPR=6.00893582; 
 MB=3.00024045; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-06 12:40:36
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18110612-0053-0000-0000-00005EAC23B6
Message-Id: <1541508028-31865-4-git-send-email-leitao@debian.org>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-11-06_06:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=513 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811060112
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
Cc: mikey@neuling.org, gromero@linux.vnet.ibm.com,
 Breno Leitao <leitao@debian.org>, ldufour@linux.vnet.ibm.com,
 cyrilbur@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This is the only place we are going to recheckpoint now. Now the task
needs to have TIF_RESTORE_TM flag set, which will get into
restore_tm_state() at exception exit path, and execute the recheckpoint
depending on the MSR.

Every time a task is required to recheckpoint, or just have the TM SPRs
restore, the TIF_RESTORE_TM flag should be set and the task MSR should
properly be in a transactional state, which will be checked by
restore_tm_state().

After the facility registers are recheckpointed, they are clobbered with
the values that were recheckpointed (and are now also in the checkpoint
area).

If facility is enabled at MSR that is being returned to user space, then
the facility registers need to be restored, otherwise userspace will see
invalid values.

This patch simplify the restore_tm_state() to just restore the facility
registers that are enabled when returning to userspace, i.e. the MSR will
be the same that will be put into SRR1, which will be the MSR after RFID.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 arch/powerpc/kernel/process.c | 38 ++++++++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 4d5322cfad25..c7e758a42b8f 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1049,8 +1049,6 @@ static inline void __switch_to_tm(struct task_struct *prev,
  */
 void restore_tm_state(struct pt_regs *regs)
 {
-	unsigned long msr_diff;
-
 	/*
 	 * This is the only moment we should clear TIF_RESTORE_TM as
 	 * it is here that ckpt_regs.msr and pt_regs.msr become the same
@@ -1061,19 +1059,35 @@ void restore_tm_state(struct pt_regs *regs)
 	if (!MSR_TM_ACTIVE(regs->msr))
 		return;
 
-	msr_diff = current->thread.ckpt_regs.msr & ~regs->msr;
-	msr_diff &= MSR_FP | MSR_VEC | MSR_VSX;
+	tm_enable();
+	/* The only place we recheckpoint */
+	tm_recheckpoint(&current->thread);
 
-	/* Ensure that restore_math() will restore */
-	if (msr_diff & MSR_FP)
-		current->thread.load_fp = 1;
+	/*
+	 * Restore the facility registers that were clobbered during
+	 * recheckpoint.
+	 */
+	if (regs->msr & MSR_FP) {
+		/*
+		 * Using load_fp_state() instead of restore_fp() because we
+		 * want to force the restore, independent of
+		 * tsk->thread.load_fp. Same for other cases below.
+		 */
+		load_fp_state(&current->thread.fp_state);
+	}
 #ifdef CONFIG_ALTIVEC
-	if (cpu_has_feature(CPU_FTR_ALTIVEC) && msr_diff & MSR_VEC)
-		current->thread.load_vec = 1;
+	if (cpu_has_feature(CPU_FTR_ALTIVEC) && regs->msr & MSR_VEC)
+		load_vr_state(&current->thread.vr_state);
+#endif
+#ifdef CONFIG_VSX
+	if (cpu_has_feature(CPU_FTR_VSX) && regs->msr & MSR_VSX) {
+		/*
+		 * If VSX is enabled, it is expected that VEC and FP are
+		 * also enabled and already restored the full register set.
+		 * Cause a warning if that is not the case.
+		 */
+		WARN_ON(!(regs->msr & MSR_VEC) || !(regs->msr & MSR_FP)); }
 #endif
-	restore_math(regs);
-
-	regs->msr |= msr_diff;
 }
 
 #else
-- 
2.19.0

