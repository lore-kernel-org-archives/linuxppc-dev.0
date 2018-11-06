Return-Path: <SRS0=FZqe=NR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C234DC32789
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Nov 2018 12:54:16 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4270C2083D
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Nov 2018 12:54:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4270C2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42q8d22CHzzF3CK
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Nov 2018 23:54:14 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 42q8KN3szHzF39Q
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Nov 2018 23:40:40 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wA6CYTdW050535
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Nov 2018 07:40:37 -0500
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2nk9x3kfc5-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Nov 2018 07:40:36 -0500
Received: from localhost
 by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <leitao@debian.org>;
 Tue, 6 Nov 2018 12:40:35 -0000
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
 by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 6 Nov 2018 12:40:32 -0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com
 [9.57.199.111])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wA6CeVxF34209920
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 6 Nov 2018 12:40:31 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 807F7AC05B;
 Tue,  6 Nov 2018 12:40:31 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3F286AC059;
 Tue,  6 Nov 2018 12:40:30 +0000 (GMT)
Received: from debra.ibm.com (unknown [9.18.239.97])
 by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue,  6 Nov 2018 12:40:30 +0000 (GMT)
From: Breno Leitao <leitao@debian.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH 02/14] powerpc/tm: Reclaim on unavailable exception
Date: Tue,  6 Nov 2018 10:40:16 -0200
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1541508028-31865-1-git-send-email-leitao@debian.org>
References: <1541508028-31865-1-git-send-email-leitao@debian.org>
X-TM-AS-GCONF: 00
x-cbid: 18110612-0072-0000-0000-000003C404A3
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009996; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000268; SDB=6.01113483; UDB=6.00577118; IPR=6.00893582; 
 MB=3.00024045; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-06 12:40:34
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18110612-0073-0000-0000-00004A04619C
Message-Id: <1541508028-31865-3-git-send-email-leitao@debian.org>
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

If there is a FP/VEC/Altivec touch inside a transaction and the facility is
disabled, then a facility unavailable exception is raised and ends up
calling {fp,vec,vsx}_unavailable_tm, which was reclaiming and
recheckpointing.

This is not required anymore, since the checkpointed state was reclaimed in
the exception entrance, and it will be recheckpointed by restore_tm_state
later.

Adding a WARN_ON() warning if we hit the _unavailable_tm() in suspended
mode, i.e, the reclaim was not executed somehow in the trap entrance, and
this is a bug.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 arch/powerpc/include/asm/exception-64s.h |  4 ++++
 arch/powerpc/kernel/exceptions-64s.S     |  3 +++
 arch/powerpc/kernel/traps.c              | 22 ++++------------------
 3 files changed, 11 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index 931a74ba037b..80f01d5683c3 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -711,6 +711,10 @@ END_FTR_SECTION_IFSET(CPU_FTR_CTRL)
 	 * Soft disable the IRQs, otherwise it might cause a CPU hang.	\
 	 */								\
 	RECONCILE_IRQ_STATE(r10, r11);					\
+	/*								\
+	 * Although this cause will be set initially, it might be	\
+	 * updated later, once the exception is better understood	\
+	 */								\
 	li      r3, cause;						\
 	bl      tm_reclaim_current;					\
 	li      r3, 1;		/* Reclaim happened */			\
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 5c685a46202d..47e05b09eed6 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -786,6 +786,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_TM)
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
 2:	/* User process was in a transaction */
 	bl	save_nvgprs
+	TM_KERNEL_ENTRY(TM_CAUSE_FAC_UNAV)
 	RECONCILE_IRQ_STATE(r10, r11)
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	bl	fp_unavailable_tm
@@ -1128,6 +1129,7 @@ BEGIN_FTR_SECTION
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
 2:	/* User process was in a transaction */
 	bl	save_nvgprs
+	TM_KERNEL_ENTRY(TM_CAUSE_FAC_UNAV)
 	RECONCILE_IRQ_STATE(r10, r11)
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	bl	altivec_unavailable_tm
@@ -1164,6 +1166,7 @@ BEGIN_FTR_SECTION
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
 2:	/* User process was in a transaction */
 	bl	save_nvgprs
+	TM_KERNEL_ENTRY(TM_CAUSE_FAC_UNAV)
 	RECONCILE_IRQ_STATE(r10, r11)
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	bl	vsx_unavailable_tm
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 9a86572db1ef..e74b735e974c 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -1742,23 +1742,10 @@ void fp_unavailable_tm(struct pt_regs *regs)
          * transaction, and probably retry but now with FP enabled.  So the
          * checkpointed FP registers need to be loaded.
 	 */
-	tm_reclaim_current(TM_CAUSE_FAC_UNAV);
-
-	/*
-	 * Reclaim initially saved out bogus (lazy) FPRs to ckfp_state, and
-	 * then it was overwrite by the thr->fp_state by tm_reclaim_thread().
-	 *
-	 * At this point, ck{fp,vr}_state contains the exact values we want to
-	 * recheckpoint.
-	 */
+	WARN_ON(MSR_TM_SUSPENDED(mfmsr()));
 
 	/* Enable FP for the task: */
 	current->thread.load_fp = 1;
-
-	/*
-	 * Recheckpoint all the checkpointed ckpt, ck{fp, vr}_state registers.
-	 */
-	tm_recheckpoint(&current->thread);
 }
 
 void altivec_unavailable_tm(struct pt_regs *regs)
@@ -1770,10 +1757,10 @@ void altivec_unavailable_tm(struct pt_regs *regs)
 	TM_DEBUG("Vector Unavailable trap whilst transactional at 0x%lx,"
 		 "MSR=%lx\n",
 		 regs->nip, regs->msr);
-	tm_reclaim_current(TM_CAUSE_FAC_UNAV);
+	WARN_ON(MSR_TM_SUSPENDED(mfmsr()));
 	current->thread.load_vec = 1;
-	tm_recheckpoint(&current->thread);
 	current->thread.used_vr = 1;
+
 }
 
 void vsx_unavailable_tm(struct pt_regs *regs)
@@ -1792,12 +1779,11 @@ void vsx_unavailable_tm(struct pt_regs *regs)
 	current->thread.used_vsr = 1;
 
 	/* This reclaims FP and/or VR regs if they're already enabled */
-	tm_reclaim_current(TM_CAUSE_FAC_UNAV);
+	WARN_ON(MSR_TM_SUSPENDED(mfmsr()));
 
 	current->thread.load_vec = 1;
 	current->thread.load_fp = 1;
 
-	tm_recheckpoint(&current->thread);
 }
 #endif /* CONFIG_PPC_TRANSACTIONAL_MEM */
 
-- 
2.19.0

