Return-Path: <SRS0=3VWP=OF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20935C43441
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Nov 2018 20:18:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BBCF205C9
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Nov 2018 20:18:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BBCF205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 433dWy46YJzDqNK
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Nov 2018 07:18:06 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 433dP34PnVzDqWb
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Nov 2018 07:12:07 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wAQK8x1Q080283
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Nov 2018 15:12:05 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2p0mpuyxkq-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Nov 2018 15:12:05 -0500
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <leitao@debian.org>;
 Mon, 26 Nov 2018 20:12:03 -0000
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
 by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 26 Nov 2018 20:12:00 -0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com
 [9.57.199.110])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wAQKBxnU18677968
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 26 Nov 2018 20:11:59 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8C2D6AE060;
 Mon, 26 Nov 2018 20:11:59 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ED80DAE05F;
 Mon, 26 Nov 2018 20:11:57 +0000 (GMT)
Received: from debra.ibm.com (unknown [9.85.190.168])
 by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
 Mon, 26 Nov 2018 20:11:57 +0000 (GMT)
From: Breno Leitao <leitao@debian.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/4] powerpc/tm: Unset MSR[TS] if not recheckpointing
Date: Mon, 26 Nov 2018 18:12:00 -0200
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1543263121-9590-1-git-send-email-leitao@debian.org>
References: <1543263121-9590-1-git-send-email-leitao@debian.org>
X-TM-AS-GCONF: 00
x-cbid: 18112620-0040-0000-0000-000004989718
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010125; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01123160; UDB=6.00577119; IPR=6.00903290; 
 MB=3.00024341; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-26 20:12:01
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18112620-0041-0000-0000-000008A1AC02
Message-Id: <1543263121-9590-3-git-send-email-leitao@debian.org>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-11-26_15:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811260172
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
 Stable <stable@vger.kernel.org>, gromero@linux.vnet.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

There is a TM Bad Thing bug that can be caused when you return from a
signal context in a suspended transaction but with ucontext MSR[TS] unset.

This forces regs->msr[TS] to be set at syscall entrance (since the CPU
state is transactional). It also calls treclaim() to flush the transaction
state, which is done based on the live (mfmsr) MSR state.

Since user context MSR[TS] is not set, then restore_tm_sigcontexts() is not
called, thus, not executing recheckpoint, keeping the CPU state as not
transactional. When calling rfid, SRR1 will have MSR[TS] set, but the CPU
state is non transactional, causing the TM Bad Thing with the following
stack:

	[   33.862316] Bad kernel stack pointer 3fffd9dce3e0 at c00000000000c47c
	cpu 0x8: Vector: 700 (Program Check) at [c00000003ff7fd40]
	    pc: c00000000000c47c: fast_exception_return+0xac/0xb4
	    lr: 00003fff865f442c
	    sp: 3fffd9dce3e0
	   msr: 8000000102a03031
	  current = 0xc00000041f68b700
	  paca    = 0xc00000000fb84800   softe: 0        irq_happened: 0x01
	    pid   = 1721, comm = tm-signal-sigre
	Linux version 4.9.0-3-powerpc64le (debian-kernel@lists.debian.org) (gcc version 6.3.0 20170516 (Debian 6.3.0-18) ) #1 SMP Debian 4.9.30-2+deb9u2 (2017-06-26)
	WARNING: exception is not recoverable, can't continue

The same problem happens on 32-bits signal handler, and the fix is very
similar, if tm_recheckpoint() is not executed, then regs->msr[TS] should be
zeroed.

This patch also fixes a sparse warning related to lack of indentation when
CONFIG_PPC_TRANSACTIONAL_MEM is set.

Fixes: 2b0a576d15e0e ("powerpc: Add new transactional memory state to the signal context")
CC: Stable <stable@vger.kernel.org>	# 3.10+
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 arch/powerpc/kernel/signal_32.c | 18 +++++++++++++-----
 arch/powerpc/kernel/signal_64.c | 20 ++++++++++++++++----
 2 files changed, 29 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
index e6474a45cef5..6327fd79b0fb 100644
--- a/arch/powerpc/kernel/signal_32.c
+++ b/arch/powerpc/kernel/signal_32.c
@@ -1140,11 +1140,11 @@ SYSCALL_DEFINE0(rt_sigreturn)
 {
 	struct rt_sigframe __user *rt_sf;
 	struct pt_regs *regs = current_pt_regs();
+	int tm_restore = 0;
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
 	struct ucontext __user *uc_transact;
 	unsigned long msr_hi;
 	unsigned long tmp;
-	int tm_restore = 0;
 #endif
 	/* Always make any pending restarted system calls return -EINTR */
 	current->restart_block.fn = do_no_restart_syscall;
@@ -1192,11 +1192,19 @@ SYSCALL_DEFINE0(rt_sigreturn)
 				goto bad;
 		}
 	}
-	if (!tm_restore)
-		/* Fall through, for non-TM restore */
+	if (!tm_restore) {
+		/*
+		 * Unset regs->msr because ucontext MSR TS is not
+		 * set, and recheckpoint was not called. This avoid
+		 * hitting a TM Bad thing at RFID
+		 */
+		regs->msr &= ~MSR_TS_MASK;
+	}
+	/* Fall through, for non-TM restore */
 #endif
-	if (do_setcontext(&rt_sf->uc, regs, 1))
-		goto bad;
+	if (!tm_restore)
+		if (do_setcontext(&rt_sf->uc, regs, 1))
+			goto bad;
 
 	/*
 	 * It's not clear whether or why it is desirable to save the
diff --git a/arch/powerpc/kernel/signal_64.c b/arch/powerpc/kernel/signal_64.c
index 83d51bf586c7..daa28cb72272 100644
--- a/arch/powerpc/kernel/signal_64.c
+++ b/arch/powerpc/kernel/signal_64.c
@@ -740,11 +740,23 @@ SYSCALL_DEFINE0(rt_sigreturn)
 					   &uc_transact->uc_mcontext))
 			goto badframe;
 	}
-	else
-	/* Fall through, for non-TM restore */
 #endif
-	if (restore_sigcontext(current, NULL, 1, &uc->uc_mcontext))
-		goto badframe;
+	/* Fall through, for non-TM restore */
+	if (!MSR_TM_ACTIVE(msr)) {
+		/*
+		 * Unset MSR[TS] on the thread regs since MSR from user
+		 * context does not have MSR active, and recheckpoint was
+		 * not called since restore_tm_sigcontexts() was not called
+		 * also.
+		 *
+		 * If not unsetting it, the code can RFID to userspace with
+		 * MSR[TS] set, but without CPU in the proper state,
+		 * causing a TM bad thing.
+		 */
+		current->thread.regs->msr &= ~MSR_TS_MASK;
+		if (restore_sigcontext(current, NULL, 1, &uc->uc_mcontext))
+			goto badframe;
+	}
 
 	if (restore_altstack(&uc->uc_stack))
 		goto badframe;
-- 
2.19.0

