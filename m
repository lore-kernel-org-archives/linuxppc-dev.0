Return-Path: <SRS0=FZqe=NR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C0FBC32789
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Nov 2018 13:17:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 282F52085B
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Nov 2018 13:17:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 282F52085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42q97r29PxzF3Dl
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Nov 2018 00:17:28 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 42q8Kt4lthzF1LM
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Nov 2018 23:41:06 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wA6CYVuZ132382
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Nov 2018 07:41:03 -0500
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2nk9v13baj-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Nov 2018 07:41:02 -0500
Received: from localhost
 by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <leitao@debian.org>;
 Tue, 6 Nov 2018 12:41:01 -0000
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
 by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 6 Nov 2018 12:40:58 -0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com
 [9.57.199.111])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wA6CevfI26476764
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 6 Nov 2018 12:40:57 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 06971AC05E;
 Tue,  6 Nov 2018 12:40:57 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B9096AC059;
 Tue,  6 Nov 2018 12:40:55 +0000 (GMT)
Received: from debra.ibm.com (unknown [9.18.239.97])
 by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue,  6 Nov 2018 12:40:55 +0000 (GMT)
From: Breno Leitao <leitao@debian.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH 12/14] powerpc/tm: Restore transactional SPRs
Date: Tue,  6 Nov 2018 10:40:26 -0200
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1541508028-31865-1-git-send-email-leitao@debian.org>
References: <1541508028-31865-1-git-send-email-leitao@debian.org>
X-TM-AS-GCONF: 00
x-cbid: 18110612-0072-0000-0000-000003C404AA
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009996; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000268; SDB=6.01113483; UDB=6.00577118; IPR=6.00893582; 
 MB=3.00024045; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-06 12:41:00
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18110612-0073-0000-0000-00004A0461CC
Message-Id: <1541508028-31865-13-git-send-email-leitao@debian.org>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-11-06_06:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
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

In the previous TM code, trecheckpoint was being executed in the middle of
an exception, thus, SPRs were being restored to default kernel SPRs (as
DSCR) value after trecheckpoint was done.

With this current patchset, trecheckpoint is executed just before getting
to userspace, at ret_from_except_lite, for example. Thus, SPRs need to be
restored to transactional value.

In order to so, a function, called restore_sprs_after_recheckpoint(), was
created to restore the SPRs after recheckpoint. This function should be
called after trecheckpoint to restore transactional SPRs, otherwise the
SPRs will be clobbered (with checkpointed values) after recheckpoint. I
understand it is preferred to have it done as a C function instead of
embedding it in the ASM code.

This patch also changes tm_reclaim() that now always return with
transactional SPRs value (instead of checkpointed value), as NVGPRs.
Previously tm_reclaim() was returning with transactional NVGPRS and
checkpointed SPRS, intermixing them.  With the current patch, tm_reclaim()
just fill out thread->ck and thread->tm values, and return with
transactional values in a uniform way (for SPRS and NVGPRS). In this case,
a later save_spr() at switch_to() will not overwrite thread->sprs with
checkpointed values, but with transactional values.

Facility registers, as VEC and FP, continue to be clobbered after
tm_reclaim(), tho.

These are the SPRs that are checkpointed by the hardware: CR fields other
than CR0, LR, CTR, FPSCR, AMR, PPR, VRSAVE, VSCR, DSCR, and TAR.

This patch only cares about PPR, TAR and DSCR, because others SPRS either
volatiles, restored as part of facilities or not being handled currently as
AMR/CRs.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 arch/powerpc/kernel/asm-offsets.c |  4 ++++
 arch/powerpc/kernel/process.c     | 19 +++++++++++++++++++
 arch/powerpc/kernel/tm.S          | 19 ++++++++++++-------
 3 files changed, 35 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 9ffc72ded73a..93def2e23e68 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -109,6 +109,9 @@ int main(void)
 	OFFSET(THREAD_FPSAVEAREA, thread_struct, fp_save_area);
 	OFFSET(FPSTATE_FPSCR, thread_fp_state, fpscr);
 	OFFSET(THREAD_LOAD_FP, thread_struct, load_fp);
+	OFFSET(THREAD_DSCR, thread_struct, dscr);
+	OFFSET(THREAD_TAR, thread_struct, tar);
+
 #ifdef CONFIG_ALTIVEC
 	OFFSET(THREAD_VRSTATE, thread_struct, vr_state.vr);
 	OFFSET(THREAD_VRSAVEAREA, thread_struct, vr_save_area);
@@ -311,6 +314,7 @@ int main(void)
 	STACK_PT_REGS_OFFSET(ORIG_GPR3, orig_gpr3);
 	STACK_PT_REGS_OFFSET(RESULT, result);
 	STACK_PT_REGS_OFFSET(_TRAP, trap);
+	STACK_PT_REGS_OFFSET(_PPR, ppr);
 #ifndef CONFIG_PPC64
 	/*
 	 * The PowerPC 400-class & Book-E processors have neither the DAR
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 8a9c298928f9..3937408ff339 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -79,6 +79,9 @@
 #endif
 
 extern unsigned long _get_SP(void);
+static inline void save_sprs(struct thread_struct *t);
+static inline void restore_sprs_after_recheckpoint(struct thread_struct
+						   *thread);
 
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
 /*
@@ -883,6 +886,8 @@ static void tm_reclaim_thread(struct thread_struct *thr, uint8_t cause)
 		thr->regs->msr);
 	giveup_all(container_of(thr, struct task_struct, thread));
 
+	/* Save SPRS before reclaim */
+	save_sprs(thr);
 	tm_reclaim(thr, cause);
 
 	/* Tag it so restore_tm_state will pay attention to this task */
@@ -939,6 +944,7 @@ void tm_recheckpoint(struct thread_struct *thread)
 
 	__tm_recheckpoint(thread);
 
+	restore_sprs_after_recheckpoint(thread);
 	local_irq_restore(flags);
 }
 
@@ -1166,6 +1172,19 @@ static inline void restore_sprs(struct thread_struct *old_thread,
 	thread_pkey_regs_restore(new_thread, old_thread);
 }
 
+static inline void restore_sprs_after_recheckpoint(struct thread_struct *thread)
+{
+#ifdef CONFIG_PPC_BOOK3S_64
+	if (cpu_has_feature(CPU_FTR_DSCR))
+		mtspr(SPRN_DSCR, thread->dscr);
+
+	if (cpu_has_feature(CPU_FTR_ARCH_207S)) {
+		mtspr(SPRN_TAR, thread->tar);
+		mtspr(SPRN_FSCR, thread->fscr);
+	}
+#endif
+}
+
 #ifdef CONFIG_PPC_BOOK3S_64
 #define CP_SIZE 128
 static const u8 dummy_copy_buffer[CP_SIZE] __attribute__((aligned(CP_SIZE)));
diff --git a/arch/powerpc/kernel/tm.S b/arch/powerpc/kernel/tm.S
index 9fabdce255cd..e3090502061e 100644
--- a/arch/powerpc/kernel/tm.S
+++ b/arch/powerpc/kernel/tm.S
@@ -326,9 +326,18 @@ _GLOBAL(tm_reclaim)
 	mtlr	r0
 	ld	r2, STK_GOT(r1)
 
-	/* Load CPU's default DSCR */
-	ld	r0, PACA_DSCR_DEFAULT(r13)
-	mtspr	SPRN_DSCR, r0
+	/*
+	 * Load transactional SPRs, as all other registers have the
+	 * transacional value, which will be seen by save_sprs and so
+	 * forth. Checkpointed SPRs are in the thread->tm_tar/dscr.
+	 */
+	ld      r0, THREAD_DSCR(r12)
+	mtspr   SPRN_DSCR, r0
+	ld      r0, THREAD_TAR(r12)
+	mtspr   SPRN_TAR, r0
+	ld      r0, _PPR(r7)
+	mtspr   SPRN_PPR, r0
+
 
 	blr
 
@@ -518,10 +527,6 @@ restore_gprs:
 	mtlr	r0
 	ld	r2, STK_GOT(r1)
 
-	/* Load CPU's default DSCR */
-	ld	r0, PACA_DSCR_DEFAULT(r13)
-	mtspr	SPRN_DSCR, r0
-
 	blr
 
 	/* ****************************************************************** */
-- 
2.19.0

