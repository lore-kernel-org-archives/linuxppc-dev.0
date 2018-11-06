Return-Path: <SRS0=FZqe=NR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAEA1C32789
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Nov 2018 13:09:52 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BAE12085B
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Nov 2018 13:09:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BAE12085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42q8z13TZQzF3Cl
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Nov 2018 00:09:49 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 42q8Kf369tzF1LM
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Nov 2018 23:40:54 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wA6CYSdQ110518
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Nov 2018 07:40:52 -0500
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2nkaejt0vf-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Nov 2018 07:40:51 -0500
Received: from localhost
 by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <leitao@debian.org>;
 Tue, 6 Nov 2018 12:40:51 -0000
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
 by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 6 Nov 2018 12:40:47 -0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com
 [9.57.199.111])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wA6Cekma44367988
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 6 Nov 2018 12:40:46 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CDDABAC05B;
 Tue,  6 Nov 2018 12:40:46 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8BB60AC059;
 Tue,  6 Nov 2018 12:40:45 +0000 (GMT)
Received: from debra.ibm.com (unknown [9.18.239.97])
 by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue,  6 Nov 2018 12:40:45 +0000 (GMT)
From: Breno Leitao <leitao@debian.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH 08/14] powerpc/tm: Recheckpoint at exit path
Date: Tue,  6 Nov 2018 10:40:22 -0200
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1541508028-31865-1-git-send-email-leitao@debian.org>
References: <1541508028-31865-1-git-send-email-leitao@debian.org>
X-TM-AS-GCONF: 00
x-cbid: 18110612-0060-0000-0000-000002CE0F6C
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009996; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000268; SDB=6.01113483; UDB=6.00577209; IPR=6.00893582; 
 MB=3.00024045; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-06 12:40:49
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18110612-0061-0000-0000-0000471B1B17
Message-Id: <1541508028-31865-9-git-send-email-leitao@debian.org>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-11-06_06:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=703 adultscore=0 classifier=spam adjust=0 reason=mlx
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

In the past, TIF_RESTORE_TM was being handled with the rest of the TIF workers,
but, that was too early, and can cause some IRQ to be replayed in suspended
state (after recheckpoint).

This patch moves TIF_RESTORE_TM handler to as late as possible, it also
forces the IRQ to be disabled, and it will continue to be until RFID, so,
no IRQ will be replayed at all. I.e, if trecheckpoint happens, it will RFID
to userspace.

This makes TIF_RESTORE_TM a special case that should not be handled
similarly to the _TIF_USER_WORK_MASK.

Since _TIF_RESTORE_TM is not part of _TIF_USER_WORK_MASK anymore, we
need to force system_call_exit to continue to leaves through
fast_exception_return, so, we add the flags together with
_TIF_USER_WORK_MASK at system_call_exist path.

If this flag is set at system_call_exit, it means that recheckpoint
will be called, and doing it through fast_exception_return is the only
way to do so.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 arch/powerpc/include/asm/thread_info.h |  2 +-
 arch/powerpc/kernel/entry_64.S         | 23 ++++++++++++++---------
 2 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/include/asm/thread_info.h b/arch/powerpc/include/asm/thread_info.h
index 544cac0474cb..2835d60bc9ef 100644
--- a/arch/powerpc/include/asm/thread_info.h
+++ b/arch/powerpc/include/asm/thread_info.h
@@ -139,7 +139,7 @@ void arch_setup_new_exec(void);
 
 #define _TIF_USER_WORK_MASK	(_TIF_SIGPENDING | _TIF_NEED_RESCHED | \
 				 _TIF_NOTIFY_RESUME | _TIF_UPROBE | \
-				 _TIF_RESTORE_TM | _TIF_PATCH_PENDING | \
+				 _TIF_PATCH_PENDING | \
 				 _TIF_FSCHECK)
 #define _TIF_PERSYSCALL_MASK	(_TIF_RESTOREALL|_TIF_NOERROR)
 
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 17484ebda66c..a86619edf29d 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -255,7 +255,7 @@ system_call_exit:
 
 	ld	r9,TI_FLAGS(r12)
 	li	r11,-MAX_ERRNO
-	andi.	r0,r9,(_TIF_SYSCALL_DOTRACE|_TIF_SINGLESTEP|_TIF_USER_WORK_MASK|_TIF_PERSYSCALL_MASK)
+	andi.   r0,r9,(_TIF_SYSCALL_DOTRACE|_TIF_SINGLESTEP|_TIF_USER_WORK_MASK|_TIF_PERSYSCALL_MASK |_TIF_RESTORE_TM)
 	bne-	.Lsyscall_exit_work
 
 	andi.	r0,r8,MSR_FP
@@ -784,14 +784,6 @@ _GLOBAL(ret_from_except_lite)
 	SCHEDULE_USER
 	b	ret_from_except_lite
 2:
-#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
-	andi.	r0,r4,_TIF_USER_WORK_MASK & ~_TIF_RESTORE_TM
-	bne	3f		/* only restore TM if nothing else to do */
-	addi	r3,r1,STACK_FRAME_OVERHEAD
-	bl	restore_tm_state
-	b	restore
-3:
-#endif
 	bl	save_nvgprs
 	/*
 	 * Use a non volatile GPR to save and restore our thread_info flags
@@ -938,6 +930,19 @@ ALT_FTR_SECTION_END_IFCLR(CPU_FTR_STCX_CHECKS_ADDRESS)
 	 */
 	.globl	fast_exception_return
 fast_exception_return:
+
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+	CURRENT_THREAD_INFO(r4, r1)
+	ld	r4,TI_FLAGS(r4)
+	andi.   r0,r4,_TIF_RESTORE_TM
+	beq	22f
+	ld	r4,_MSR(r1) 	/* TODO: MSR[!PR] shouldn't be here */
+	andi.	r0,r4,MSR_PR
+	beq	22f  /* Skip if Kernel thread */
+	addi	r3,r1,STACK_FRAME_OVERHEAD
+	bl	restore_tm_state
+22:
+#endif
 	ld	r3,_MSR(r1)
 	ld	r4,_CTR(r1)
 	ld	r0,_LINK(r1)
-- 
2.19.0

