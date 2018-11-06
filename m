Return-Path: <SRS0=FZqe=NR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 326E4C32789
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Nov 2018 13:02:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A523B2083D
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Nov 2018 13:02:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A523B2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42q8p06RGpzF3Cl
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Nov 2018 00:02:00 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 42q8KY4Zc2zF39Q
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Nov 2018 23:40:49 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wA6CYghD120775
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Nov 2018 07:40:47 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2nk818fytn-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Nov 2018 07:40:47 -0500
Received: from localhost
 by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <leitao@debian.org>;
 Tue, 6 Nov 2018 12:40:45 -0000
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
 by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 6 Nov 2018 12:40:42 -0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com
 [9.57.199.111])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wA6CefL145940792
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 6 Nov 2018 12:40:41 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B817FAC059;
 Tue,  6 Nov 2018 12:40:41 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 76107AC05B;
 Tue,  6 Nov 2018 12:40:40 +0000 (GMT)
Received: from debra.ibm.com (unknown [9.18.239.97])
 by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue,  6 Nov 2018 12:40:40 +0000 (GMT)
From: Breno Leitao <leitao@debian.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH 06/14] powerpc/tm: Do not recheckpoint at sigreturn
Date: Tue,  6 Nov 2018 10:40:20 -0200
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1541508028-31865-1-git-send-email-leitao@debian.org>
References: <1541508028-31865-1-git-send-email-leitao@debian.org>
X-TM-AS-GCONF: 00
x-cbid: 18110612-2213-0000-0000-000003121E07
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009996; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000268; SDB=6.01113483; UDB=6.00577209; IPR=6.00893582; 
 MB=3.00024045; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-06 12:40:44
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18110612-2214-0000-0000-00005C289544
Message-Id: <1541508028-31865-7-git-send-email-leitao@debian.org>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-11-06_06:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=870 adultscore=0 classifier=spam adjust=0 reason=mlx
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

Do not recheckpoint at signal code return. Just make sure TIF_RESTORE_TM is
set, which will restore on the exit to userspace by restore_tm_state.

All the FP and VEC lazy restore was already done by tm_reclaim_current(),
where it checked if FP/VEC was set, and filled out the ckfp and ckvr
registers area to the expected value.

The load_fp_state() and load_vr_state() is being called to restore the
clobbered registers after tm_recheckpoint(). This is not necessary anymore,
since restore_tm_state() does it already, so, this is only required to be
done after trecheckpoint(), and the only place calling it is
restore_tm_state().

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 arch/powerpc/kernel/signal_32.c | 38 +++++++++------------------------
 arch/powerpc/kernel/signal_64.c | 30 ++++++++------------------
 2 files changed, 19 insertions(+), 49 deletions(-)

diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
index e6474a45cef5..046030d7921e 100644
--- a/arch/powerpc/kernel/signal_32.c
+++ b/arch/powerpc/kernel/signal_32.c
@@ -850,28 +850,11 @@ static long restore_tm_user_regs(struct pt_regs *regs,
 		return 1;
 	/* Pull in the MSR TM bits from the user context */
 	regs->msr = (regs->msr & ~MSR_TS_MASK) | (msr_hi & MSR_TS_MASK);
-	/* Now, recheckpoint.  This loads up all of the checkpointed (older)
-	 * registers, including FP and V[S]Rs.  After recheckpointing, the
-	 * transactional versions should be loaded.
-	 */
-	tm_enable();
+
 	/* Make sure the transaction is marked as failed */
 	current->thread.tm_texasr |= TEXASR_FS;
-	/* This loads the checkpointed FP/VEC state, if used */
-	tm_recheckpoint(&current->thread);
-
-	/* This loads the speculative FP/VEC state, if used */
-	msr_check_and_set(msr & (MSR_FP | MSR_VEC));
-	if (msr & MSR_FP) {
-		load_fp_state(&current->thread.fp_state);
-		regs->msr |= (MSR_FP | current->thread.fpexc_mode);
-	}
-#ifdef CONFIG_ALTIVEC
-	if (msr & MSR_VEC) {
-		load_vr_state(&current->thread.vr_state);
-		regs->msr |= MSR_VEC;
-	}
-#endif
+	/* Make sure restore_tm_state will be called */
+	set_thread_flag(TIF_RESTORE_TM);
 
 	return 0;
 }
@@ -1156,16 +1139,15 @@ SYSCALL_DEFINE0(rt_sigreturn)
 
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
 	/*
-	 * If there is a transactional state then throw it away.
-	 * The purpose of a sigreturn is to destroy all traces of the
-	 * signal frame, this includes any transactional state created
-	 * within in. We only check for suspended as we can never be
-	 * active in the kernel, we are active, there is nothing better to
-	 * do than go ahead and Bad Thing later.
-	 * The cause is not important as there will never be a
+	 * If the transaction is active at this point, it means that
+	 * TM_KERNEL_ENTRY was not invoked properly and it is a bug.
+	 * If this is the case, print a warning and try to work around,
+	 * calling tm_reclaim_current() to discard the footprint.
+	 *
+	 * The failure cause is not important as there will never be a
 	 * recheckpoint so it's not user visible.
 	 */
-	if (MSR_TM_SUSPENDED(mfmsr()))
+	if (WARN_ON(MSR_TM_SUSPENDED(mfmsr())))
 		tm_reclaim_current(0);
 
 	if (__get_user(tmp, &rt_sf->uc.uc_link))
diff --git a/arch/powerpc/kernel/signal_64.c b/arch/powerpc/kernel/signal_64.c
index 83d51bf586c7..487c3b6aa2e3 100644
--- a/arch/powerpc/kernel/signal_64.c
+++ b/arch/powerpc/kernel/signal_64.c
@@ -569,21 +569,10 @@ static long restore_tm_sigcontexts(struct task_struct *tsk,
 		}
 	}
 #endif
-	tm_enable();
 	/* Make sure the transaction is marked as failed */
 	tsk->thread.tm_texasr |= TEXASR_FS;
-	/* This loads the checkpointed FP/VEC state, if used */
-	tm_recheckpoint(&tsk->thread);
-
-	msr_check_and_set(msr & (MSR_FP | MSR_VEC));
-	if (msr & MSR_FP) {
-		load_fp_state(&tsk->thread.fp_state);
-		regs->msr |= (MSR_FP | tsk->thread.fpexc_mode);
-	}
-	if (msr & MSR_VEC) {
-		load_vr_state(&tsk->thread.vr_state);
-		regs->msr |= MSR_VEC;
-	}
+	/* Guarantee that restore_tm_state() will be called */
+	set_thread_flag(TIF_RESTORE_TM);
 
 	return err;
 }
@@ -717,16 +706,15 @@ SYSCALL_DEFINE0(rt_sigreturn)
 
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
 	/*
-	 * If there is a transactional state then throw it away.
-	 * The purpose of a sigreturn is to destroy all traces of the
-	 * signal frame, this includes any transactional state created
-	 * within in. We only check for suspended as we can never be
-	 * active in the kernel, we are active, there is nothing better to
-	 * do than go ahead and Bad Thing later.
-	 * The cause is not important as there will never be a
+	 * If the transaction is active at this point, it means that
+	 * TM_KERNEL_ENTRY was not invoked properly and it is a bug.
+	 * If this is the case, print a warning and try to work around,
+	 * calling tm_reclaim_current() to discard the footprint.
+	 *
+	 * The failure cause is not important as there will never be a
 	 * recheckpoint so it's not user visible.
 	 */
-	if (MSR_TM_SUSPENDED(mfmsr()))
+	if (WARN_ON(MSR_TM_SUSPENDED(mfmsr())))
 		tm_reclaim_current(0);
 
 	if (__get_user(msr, &uc->uc_mcontext.gp_regs[PT_MSR]))
-- 
2.19.0

