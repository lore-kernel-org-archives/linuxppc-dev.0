Return-Path: <SRS0=FZqe=NR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BD6EC32789
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Nov 2018 12:52:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AEDB2083D
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Nov 2018 12:52:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AEDB2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42q8Zp4TWmzF3DW
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Nov 2018 23:52:18 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 42q8KL0s8yzF39K
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Nov 2018 23:40:37 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wA6CYUZv132321
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Nov 2018 07:40:33 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2nk9v13aq5-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Nov 2018 07:40:33 -0500
Received: from localhost
 by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <leitao@debian.org>;
 Tue, 6 Nov 2018 12:40:32 -0000
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
 by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 6 Nov 2018 12:40:30 -0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com
 [9.57.199.111])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wA6CeT7A27131970
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 6 Nov 2018 12:40:29 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F06C7AC05B;
 Tue,  6 Nov 2018 12:40:28 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AE891AC059;
 Tue,  6 Nov 2018 12:40:27 +0000 (GMT)
Received: from debra.ibm.com (unknown [9.18.239.97])
 by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue,  6 Nov 2018 12:40:27 +0000 (GMT)
From: Breno Leitao <leitao@debian.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH 01/14] powerpc/tm: Reclaim transaction on kernel entry
Date: Tue,  6 Nov 2018 10:40:15 -0200
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1541508028-31865-1-git-send-email-leitao@debian.org>
References: <1541508028-31865-1-git-send-email-leitao@debian.org>
X-TM-AS-GCONF: 00
x-cbid: 18110612-0052-0000-0000-000003512124
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009996; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000268; SDB=6.01113483; UDB=6.00577209; IPR=6.00893582; 
 MB=3.00024045; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-06 12:40:31
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18110612-0053-0000-0000-00005EAC23AC
Message-Id: <1541508028-31865-2-git-send-email-leitao@debian.org>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-11-06_06:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=958 adultscore=0 classifier=spam adjust=0 reason=mlx
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

This patch creates a macro that will be invoked on all entrance to the
kernel, so, in kernel space the transaction will be completely reclaimed
and not suspended anymore.

This patchset checks if we are coming from PR, if not, skip. This is useful
when there is a irq_replay() being called after recheckpoint, when the IRQ
is re-enable. In this case, we do not want to re-reclaim and
re-recheckpoint, thus, if not coming from PR, skip it completely.

This macro does not care about TM SPR also, it will only be saved and
restore in the context switch code now on.

This macro will return 0 or 1 in r3 register, to specify if a reclaim was
executed or not.

This patchset is based on initial work done by Cyril:
https://patchwork.ozlabs.org/cover/875341/

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 arch/powerpc/include/asm/exception-64s.h | 46 ++++++++++++++++++++++++
 arch/powerpc/kernel/entry_64.S           | 10 ++++++
 arch/powerpc/kernel/exceptions-64s.S     | 12 +++++--
 3 files changed, 66 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index 3b4767ed3ec5..931a74ba037b 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -36,6 +36,7 @@
  */
 #include <asm/head-64.h>
 #include <asm/feature-fixups.h>
+#include <asm/tm.h>
 
 /* PACA save area offsets (exgen, exmc, etc) */
 #define EX_R9		0
@@ -677,10 +678,54 @@ BEGIN_FTR_SECTION				\
 	beql	ppc64_runlatch_on_trampoline;	\
 END_FTR_SECTION_IFSET(CPU_FTR_CTRL)
 
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+
+/*
+ * This macro will reclaim a transaction if called when coming from userspace
+ * (MSR.PR = 1) and if the transaction state is active or suspended.
+ *
+ * Since we don't want to reclaim when coming from kernel, for instance after
+ * a trechkpt. or a IRQ replay, the live MSR is not useful and instead of it the
+ * MSR from thread stack is used to check the MSR.PR bit.
+ * This macro has one argument which is the cause that will be used by treclaim.
+ * and returns in r3 '1' if the reclaim happens or '0' if reclaim didn't
+ * happen, which is useful to know what registers were clobbered.
+ *
+ * NOTE: If addition registers are clobbered here, make sure the callee
+ * function restores them before proceeding.
+ */
+#define TM_KERNEL_ENTRY(cause)						\
+	ld      r3, _MSR(r1);						\
+	andi.   r0, r3, MSR_PR;	/* Coming from userspace? */		\
+	beq     1f;		/* Skip reclaim if MSR.PR != 1 */	\
+	rldicl. r0, r3, (64-MSR_TM_LG), 63; /* Is TM enabled? */	\
+	beq     1f;		/* Skip reclaim if TM is off */		\
+	rldicl. r0, r3, (64-MSR_TS_LG), 62;	/* Is active */		\
+	beq     1f;		/* Skip reclaim if neither */		\
+	/*								\
+	 * If there is a transaction active or suspended, save the	\
+	 * non-volatile GPRs if they are not already saved.		\
+	 */								\
+	bl      save_nvgprs;						\
+	/*								\
+	 * Soft disable the IRQs, otherwise it might cause a CPU hang.	\
+	 */								\
+	RECONCILE_IRQ_STATE(r10, r11);					\
+	li      r3, cause;						\
+	bl      tm_reclaim_current;					\
+	li      r3, 1;		/* Reclaim happened */			\
+	b       2f;							\
+1:	li      r3, 0;		/* Reclaim didn't happen */		\
+2:
+#else
+#define TM_KERNEL_ENTRY(cause)
+#endif
+
 #define EXCEPTION_COMMON(area, trap, label, hdlr, ret, additions) \
 	EXCEPTION_PROLOG_COMMON(trap, area);			\
 	/* Volatile regs are potentially clobbered here */	\
 	additions;						\
+	TM_KERNEL_ENTRY(TM_CAUSE_MISC);					\
 	addi	r3,r1,STACK_FRAME_OVERHEAD;			\
 	bl	hdlr;						\
 	b	ret
@@ -695,6 +740,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_CTRL)
 	EXCEPTION_PROLOG_COMMON_3(trap);			\
 	/* Volatile regs are potentially clobbered here */	\
 	additions;						\
+	TM_KERNEL_ENTRY(TM_CAUSE_MISC);				\
 	addi	r3,r1,STACK_FRAME_OVERHEAD;			\
 	bl	hdlr
 
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 7b1693adff2a..17484ebda66c 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -131,6 +131,16 @@ BEGIN_FW_FTR_SECTION
 END_FW_FTR_SECTION_IFSET(FW_FEATURE_SPLPAR)
 #endif /* CONFIG_VIRT_CPU_ACCOUNTING_NATIVE && CONFIG_PPC_SPLPAR */
 
+#if CONFIG_PPC_TRANSACTIONAL_MEM
+	TM_KERNEL_ENTRY(TM_CAUSE_SYSCALL)
+	cmpdi	r3, 0x1
+	bne	44f
+	/* Restore from r4 to r12 */
+	REST_8GPRS(4,r1)
+44:	/* treclaim was not called, just restore r3 and r0 */
+	REST_GPR(3, r1)
+	REST_GPR(0, r1)
+#endif
 	/*
 	 * A syscall should always be called with interrupts enabled
 	 * so we just unconditionally hard-enable here. When some kind
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 89d32bb79d5e..5c685a46202d 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -717,6 +717,7 @@ EXC_COMMON_BEGIN(alignment_common)
 	std	r3,_DAR(r1)
 	std	r4,_DSISR(r1)
 	bl	save_nvgprs
+	TM_KERNEL_ENTRY(TM_CAUSE_ALIGNMENT)
 	RECONCILE_IRQ_STATE(r10, r11)
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	bl	alignment_exception
@@ -751,6 +752,8 @@ EXC_COMMON_BEGIN(program_check_common)
 	b 3f				/* Jump into the macro !!	*/
 1:	EXCEPTION_PROLOG_COMMON(0x700, PACA_EXGEN)
 	bl	save_nvgprs
+	ld      r3, _MSR(r1)
+	TM_KERNEL_ENTRY(TM_CAUSE_FAC_UNAV)
 	RECONCILE_IRQ_STATE(r10, r11)
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	bl	program_check_exception
@@ -1650,7 +1653,9 @@ do_hash_page:
 
 /* Here we have a page fault that hash_page can't handle. */
 handle_page_fault:
-11:	andis.  r0,r4,DSISR_DABRMATCH@h
+11:	TM_KERNEL_ENTRY(TM_CAUSE_TLBI)
+	ld      r4,_DSISR(r1)
+	andis.  r0,r4,DSISR_DABRMATCH@h
 	bne-    handle_dabr_fault
 	ld	r4,_DAR(r1)
 	ld	r5,_DSISR(r1)
@@ -1681,6 +1686,8 @@ handle_dabr_fault:
  */
 13:	bl	save_nvgprs
 	mr	r5,r3
+	TM_KERNEL_ENTRY(TM_CAUSE_TLBI)
+	REST_GPR(3,r1)
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	ld	r4,_DAR(r1)
 	bl	low_hash_fault
@@ -1695,7 +1702,8 @@ handle_dabr_fault:
  * the access, or panic if there isn't a handler.
  */
 77:	bl	save_nvgprs
-	mr	r4,r3
+	TM_KERNEL_ENTRY(TM_CAUSE_TLBI)
+	ld      r4,_DAR(r1)
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	li	r5,SIGSEGV
 	bl	bad_page_fault
-- 
2.19.0

