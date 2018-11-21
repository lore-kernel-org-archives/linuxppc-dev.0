Return-Path: <SRS0=wfsy=OA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF90C43441
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Nov 2018 19:23:04 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D039214DA
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Nov 2018 19:23:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D039214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 430XXh4xjkzF3dV
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Nov 2018 06:23:00 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 430XVY6Km7zF3cP
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Nov 2018 06:21:09 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wALJEkEp098273
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Nov 2018 14:21:07 -0500
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2nwc09kj03-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Nov 2018 14:21:06 -0500
Received: from localhost
 by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <leitao@debian.org>;
 Wed, 21 Nov 2018 19:21:06 -0000
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
 by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 21 Nov 2018 19:21:04 -0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com
 [9.57.199.110])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wALJL3P434603192
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 21 Nov 2018 19:21:03 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 103CBAE063;
 Wed, 21 Nov 2018 19:21:03 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 15EDCAE05C;
 Wed, 21 Nov 2018 19:21:02 +0000 (GMT)
Received: from debra.ibm.com (unknown [9.18.239.97])
 by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
 Wed, 21 Nov 2018 19:21:01 +0000 (GMT)
From: Breno Leitao <leitao@debian.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2] powerpc/tm: Set MSR[TS] just prior to recheckpoint
Date: Wed, 21 Nov 2018 17:21:09 -0200
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
x-cbid: 18112119-0072-0000-0000-000003CC9C96
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010095; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01120787; UDB=6.00577118; IPR=6.00900909; 
 MB=3.00024267; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-21 19:21:06
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18112119-0073-0000-0000-00004A2EEE74
Message-Id: <1542828069-29100-1-git-send-email-leitao@debian.org>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-11-21_09:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811210167
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
importantly, without TEXASR[FS] bit set also.

Since TEXASR might not have the FS bit set, and when the process is
scheduled back, it will try to reclaim, which will be aborted because of
the CPU is not in the suspended state, and, then, recheckpoint. This
recheckpoint will restore thread->texasr into TEXASR SPR, which might be
zero, hitting a BUG_ON().

	kernel BUG at /build/linux-sf3Co9/linux-4.9.30/arch/powerpc/kernel/tm.S:434!
	cpu 0xb: Vector: 700 (Program Check) at [c00000041f1576d0]
	    pc: c000000000054550: restore_gprs+0xb0/0x180
	    lr: 0000000000000000
	    sp: c00000041f157950
	   msr: 8000000100021033
	  current = 0xc00000041f143000
	  paca    = 0xc00000000fb86300	 softe: 0	 irq_happened: 0x01
	    pid   = 1021, comm = kworker/11:1
	kernel BUG at /build/linux-sf3Co9/linux-4.9.30/arch/powerpc/kernel/tm.S:434!
	Linux version 4.9.0-3-powerpc64le (debian-kernel@lists.debian.org) (gcc version 6.3.0 20170516 (Debian 6.3.0-18) ) #1 SMP Debian 4.9.30-2+deb9u2 (2017-06-26)
	enter ? for help
	[c00000041f157b30] c00000000001bc3c tm_recheckpoint.part.11+0x6c/0xa0
	[c00000041f157b70] c00000000001d184 __switch_to+0x1e4/0x4c0
	[c00000041f157bd0] c00000000082eeb8 __schedule+0x2f8/0x990
	[c00000041f157cb0] c00000000082f598 schedule+0x48/0xc0
	[c00000041f157ce0] c0000000000f0d28 worker_thread+0x148/0x610
	[c00000041f157d80] c0000000000f96b0 kthread+0x120/0x140
	[c00000041f157e30] c00000000000c0e0 ret_from_kernel_thread+0x5c/0x7c

This patch simply delays the MSR[TS] set, so, if there is any page fault in
the __get_user() section, it does not have regs->msr[TS] set, since the TM
structures are still invalid, thus avoiding doing TM operations for
in-kernel exceptions and possible process reschedule.

With this patch, the MSR[TS] will only be set just before recheckpointing
and setting TEXASR[FS] = 1, thus avoiding an interrupt with TM registers in
invalid state.

Other than that, if CONFIG_PREEMPT is set, there might be a preemption just
after setting MSR[TS] and before tm_recheckpoint(), thus, this block must
be atomic from a preemption perspective, thus, calling
preempt_disable/enable() on this code.

It is not possible to move tm_recheckpoint to happen earlier, because it is
required to get the checkpointed registers from userspace, with
__get_user(), thus, the only way to avoid this undesired behavior is
delaying the MSR[TS] set.

The 32-bits signal handler seems to be safe this current issue, but, it
might be exposed to the preemption issue, thus, disabling preemption in
this chunk of code.

Changes from v2:
 * Run the critical section with preempt_disable.

Fixes: 87b4e5393af7 ("powerpc/tm: Fix return of active 64bit signals")
Cc: stable@vger.kernel.org (v3.9+)
Signed-off-by: Breno Leitao <leitao@debian.org>

diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
index e6474a45cef5..fd59fef9931b 100644
--- a/arch/powerpc/kernel/signal_32.c
+++ b/arch/powerpc/kernel/signal_32.c
@@ -848,7 +848,23 @@ static long restore_tm_user_regs(struct pt_regs *regs,
 	/* If TM bits are set to the reserved value, it's an invalid context */
 	if (MSR_TM_RESV(msr_hi))
 		return 1;
-	/* Pull in the MSR TM bits from the user context */
+
+	/*
+	 * Disabling preemption, since it is unsafe to be preempted
+	 * with MSR[TS] set without recheckpointing.
+	 */
+	preempt_disable();
+
+	/*
+	 * CAUTION:
+	 * After regs->MSR[TS] being updated, make sure that get_user(),
+	 * put_user() or similar functions are *not* called. These
+	 * functions can generate page faults which will cause the process
+	 * to be de-scheduled with MSR[TS] set but without calling
+	 * tm_recheckpoint(). This can cause a bug.
+	 *
+	 * Pull in the MSR TM bits from the user context
+	 */
 	regs->msr = (regs->msr & ~MSR_TS_MASK) | (msr_hi & MSR_TS_MASK);
 	/* Now, recheckpoint.  This loads up all of the checkpointed (older)
 	 * registers, including FP and V[S]Rs.  After recheckpointing, the
@@ -873,6 +889,8 @@ static long restore_tm_user_regs(struct pt_regs *regs,
 	}
 #endif
 
+	preempt_enable();
+
 	return 0;
 }
 #endif
diff --git a/arch/powerpc/kernel/signal_64.c b/arch/powerpc/kernel/signal_64.c
index 83d51bf586c7..bbd1c73243d7 100644
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
 
@@ -572,6 +558,34 @@ static long restore_tm_sigcontexts(struct task_struct *tsk,
 	tm_enable();
 	/* Make sure the transaction is marked as failed */
 	tsk->thread.tm_texasr |= TEXASR_FS;
+
+	/*
+	 * Disabling preemption, since it is unsafe to be preempted
+	 * with MSR[TS] set without recheckpointing.
+	 */
+	preempt_disable();
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
+	 *
+	 * CAUTION:
+	 * After regs->MSR[TS] being updated, make sure that get_user(),
+	 * put_user() or similar functions are *not* called. These
+	 * functions can generate page faults which will cause the process
+	 * to be de-scheduled with MSR[TS] set but without calling
+	 * tm_recheckpoint(). This can cause a bug.
+	 */
+	regs->msr |= MSR_TM;
+
 	/* This loads the checkpointed FP/VEC state, if used */
 	tm_recheckpoint(&tsk->thread);
 
@@ -585,6 +599,8 @@ static long restore_tm_sigcontexts(struct task_struct *tsk,
 		regs->msr |= MSR_VEC;
 	}
 
+	preempt_enable();
+
 	return err;
 }
 #endif
-- 
2.19.0

