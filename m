Return-Path: <SRS0=ZLNG=CD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CBD3C433DF
	for <linuxppc-dev@archiver.kernel.org>; Tue, 25 Aug 2020 04:52:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 981AD2072D
	for <linuxppc-dev@archiver.kernel.org>; Tue, 25 Aug 2020 04:52:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FQOfe1VX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 981AD2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BbGnh2g4XzDqTh
	for <linuxppc-dev@archiver.kernel.org>; Tue, 25 Aug 2020 14:52:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5;
 helo=mx0b-001b2d01.pphosted.com; envelope-from=ravi.bangoria@linux.ibm.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256
 header.s=pp1 header.b=FQOfe1VX; dkim-atps=neutral
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BbGRl2MvzzDqBl
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Aug 2020 14:37:07 +1000 (AEST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 07P4W0Ce058364; Tue, 25 Aug 2020 00:36:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=ALicwylMRdt++AkmiA3Lf+/Mg69vaDPZZtSuWe3nmYk=;
 b=FQOfe1VX828uK6NLUMHfd2pbOZeBHESUWhPJXJuH8NYuwRIhR44nWd9ofU6BZVFxGAln
 qR1JwOXVmiHVpwS4xrZ9Aoh2sopsKiSJECI5p9mqB5WjuEUvZT3js013Vwn4UmcFFovi
 Pa64bSQuJJx8mm1qU9WPetOo0poGsIUuTwfr8p9oXn2gWPAiw4wc26FHm7iUqbTvCl/t
 sG3WeGjAFG9zkj/AK0F8MtU1bc+aVWFLB/JcLYKFEFKpYtJsszWQ1q1sGYfom2IGZBzt
 7JmHOY45XHuFsQKKMM5ioLQrIQ37Mv5k4+RVBPbgdGIfI4LqPclG73bMwwf/UnxWTm4m aA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 334t8x9t4n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 25 Aug 2020 00:36:44 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07P4WMeJ059205;
 Tue, 25 Aug 2020 00:36:44 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.102])
 by mx0a-001b2d01.pphosted.com with ESMTP id 334t8x9t3t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 25 Aug 2020 00:36:44 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
 by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07P4Wdu9030786;
 Tue, 25 Aug 2020 04:36:41 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com
 (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
 by ppma06ams.nl.ibm.com with ESMTP id 332uk6b1cq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 25 Aug 2020 04:36:41 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 07P4ac2k65995118
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 25 Aug 2020 04:36:38 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C8CF3AE051;
 Tue, 25 Aug 2020 04:36:38 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 365CFAE04D;
 Tue, 25 Aug 2020 04:36:36 +0000 (GMT)
Received: from bangoria.ibmuc.com (unknown [9.199.33.167])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Tue, 25 Aug 2020 04:36:36 +0000 (GMT)
From: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
To: mpe@ellerman.id.au, christophe.leroy@c-s.fr
Subject: [PATCH v5 5/8] powerpc/watchpoint: Fix exception handling for
 CONFIG_HAVE_HW_BREAKPOINT=N
Date: Tue, 25 Aug 2020 10:06:14 +0530
Message-Id: <20200825043617.1073634-6-ravi.bangoria@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200825043617.1073634-1-ravi.bangoria@linux.ibm.com>
References: <20200825043617.1073634-1-ravi.bangoria@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-08-24_12:2020-08-24,
 2020-08-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0
 adultscore=0 spamscore=0 impostorscore=0 mlxscore=0 bulkscore=0
 mlxlogscore=965 lowpriorityscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008250030
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
Cc: ravi.bangoria@linux.ibm.com, mikey@neuling.org, jniethe5@gmail.com,
 pedromfc@linux.ibm.com, linux-kernel@vger.kernel.org, paulus@samba.org,
 rogealve@linux.ibm.com, naveen.n.rao@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On powerpc, ptrace watchpoint works in one-shot mode. i.e. kernel
disables event every time it fires and user has to re-enable it.
Also, in case of ptrace watchpoint, kernel notifies ptrace user
before executing instruction.

With CONFIG_HAVE_HW_BREAKPOINT=N, kernel is missing to disable
ptrace event and thus it's causing infinite loop of exceptions.
This is especially harmful when user watches on a data which is
also read/written by kernel, eg syscall parameters. In such case,
infinite exceptions happens in kernel mode which causes soft-lockup.

Fixes: 9422de3e953d ("powerpc: Hardware breakpoints rewrite to handle non DABR breakpoint registers")
Reported-by: Pedro Miraglia Franco de Carvalho <pedromfc@linux.ibm.com>
Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
---
 arch/powerpc/include/asm/hw_breakpoint.h  |  3 ++
 arch/powerpc/kernel/process.c             | 48 +++++++++++++++++++++++
 arch/powerpc/kernel/ptrace/ptrace-noadv.c |  5 +++
 3 files changed, 56 insertions(+)

diff --git a/arch/powerpc/include/asm/hw_breakpoint.h b/arch/powerpc/include/asm/hw_breakpoint.h
index 2eca3dd54b55..c72263214d3f 100644
--- a/arch/powerpc/include/asm/hw_breakpoint.h
+++ b/arch/powerpc/include/asm/hw_breakpoint.h
@@ -18,6 +18,7 @@ struct arch_hw_breakpoint {
 	u16		type;
 	u16		len; /* length of the target data symbol */
 	u16		hw_len; /* length programmed in hw */
+	u8		flags;
 };
 
 /* Note: Don't change the first 6 bits below as they are in the same order
@@ -37,6 +38,8 @@ struct arch_hw_breakpoint {
 #define HW_BRK_TYPE_PRIV_ALL	(HW_BRK_TYPE_USER | HW_BRK_TYPE_KERNEL | \
 				 HW_BRK_TYPE_HYP)
 
+#define HW_BRK_FLAG_DISABLED	0x1
+
 /* Minimum granularity */
 #ifdef CONFIG_PPC_8xx
 #define HW_BREAKPOINT_SIZE  0x4
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 016bd831908e..160fbbf41d40 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -636,6 +636,44 @@ void do_send_trap(struct pt_regs *regs, unsigned long address,
 				    (void __user *)address);
 }
 #else	/* !CONFIG_PPC_ADV_DEBUG_REGS */
+
+static void do_break_handler(struct pt_regs *regs)
+{
+	struct arch_hw_breakpoint null_brk = {0};
+	struct arch_hw_breakpoint *info;
+	struct ppc_inst instr = ppc_inst(0);
+	int type = 0;
+	int size = 0;
+	unsigned long ea;
+	int i;
+
+	/*
+	 * If underneath hw supports only one watchpoint, we know it
+	 * caused exception. 8xx also falls into this category.
+	 */
+	if (nr_wp_slots() == 1) {
+		__set_breakpoint(0, &null_brk);
+		current->thread.hw_brk[0] = null_brk;
+		current->thread.hw_brk[0].flags |= HW_BRK_FLAG_DISABLED;
+		return;
+	}
+
+	/* Otherwise findout which DAWR caused exception and disable it. */
+	wp_get_instr_detail(regs, &instr, &type, &size, &ea);
+
+	for (i = 0; i < nr_wp_slots(); i++) {
+		info = &current->thread.hw_brk[i];
+		if (!info->address)
+			continue;
+
+		if (wp_check_constraints(regs, instr, ea, type, size, info)) {
+			__set_breakpoint(i, &null_brk);
+			current->thread.hw_brk[i] = null_brk;
+			current->thread.hw_brk[i].flags |= HW_BRK_FLAG_DISABLED;
+		}
+	}
+}
+
 void do_break (struct pt_regs *regs, unsigned long address,
 		    unsigned long error_code)
 {
@@ -647,6 +685,16 @@ void do_break (struct pt_regs *regs, unsigned long address,
 	if (debugger_break_match(regs))
 		return;
 
+	/*
+	 * We reach here only when watchpoint exception is generated by ptrace
+	 * event (or hw is buggy!). Now if CONFIG_HAVE_HW_BREAKPOINT is set,
+	 * watchpoint is already handled by hw_breakpoint_handler() so we don't
+	 * have to do anything. But when CONFIG_HAVE_HW_BREAKPOINT is not set,
+	 * we need to manually handle the watchpoint here.
+	 */
+	if (!IS_ENABLED(CONFIG_HAVE_HW_BREAKPOINT))
+		do_break_handler(regs);
+
 	/* Deliver the signal to userspace */
 	force_sig_fault(SIGTRAP, TRAP_HWBKPT, (void __user *)address);
 }
diff --git a/arch/powerpc/kernel/ptrace/ptrace-noadv.c b/arch/powerpc/kernel/ptrace/ptrace-noadv.c
index 57a0ab822334..866597b407bc 100644
--- a/arch/powerpc/kernel/ptrace/ptrace-noadv.c
+++ b/arch/powerpc/kernel/ptrace/ptrace-noadv.c
@@ -286,11 +286,16 @@ long ppc_del_hwdebug(struct task_struct *child, long data)
 	}
 	return ret;
 #else /* CONFIG_HAVE_HW_BREAKPOINT */
+	if (child->thread.hw_brk[data - 1].flags & HW_BRK_FLAG_DISABLED)
+		goto del;
+
 	if (child->thread.hw_brk[data - 1].address == 0)
 		return -ENOENT;
 
+del:
 	child->thread.hw_brk[data - 1].address = 0;
 	child->thread.hw_brk[data - 1].type = 0;
+	child->thread.hw_brk[data - 1].flags = 0;
 #endif /* CONFIG_HAVE_HW_BREAKPOINT */
 
 	return 0;
-- 
2.26.2

