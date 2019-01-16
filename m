Return-Path: <SRS0=yyDT=PY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 255ADC43387
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Jan 2019 16:49:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35962205C9
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Jan 2019 16:49:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35962205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43ftTh6HcgzDqlY
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Jan 2019 03:49:28 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 43ftRt5bMYzDql6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Jan 2019 03:47:54 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 x0GGht1U017639
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jan 2019 11:47:51 -0500
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2q26rb5a16-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jan 2019 11:47:51 -0500
Received: from localhost
 by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <leitao@debian.org>;
 Wed, 16 Jan 2019 16:47:50 -0000
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
 by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 16 Jan 2019 16:47:48 -0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com
 [9.57.199.109])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x0GGll0m25034784
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 16 Jan 2019 16:47:47 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 28DF8112063;
 Wed, 16 Jan 2019 16:47:47 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9A762112061;
 Wed, 16 Jan 2019 16:47:45 +0000 (GMT)
Received: from debra.ibm.com (unknown [9.85.149.121])
 by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
 Wed, 16 Jan 2019 16:47:45 +0000 (GMT)
From: Breno Leitao <leitao@debian.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/tm: Avoid machine crash on rt_sigreturn
Date: Wed, 16 Jan 2019 14:47:44 -0200
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
x-cbid: 19011616-0072-0000-0000-000003EAD516
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010418; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000274; SDB=6.01147372; UDB=6.00597665; IPR=6.00927667; 
 MB=3.00025158; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-16 16:47:49
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19011616-0073-0000-0000-00004AD523C2
Message-Id: <1547657264-28761-1-git-send-email-leitao@debian.org>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-01-16_06:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901160135
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
 gromero@linux.vnet.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

There is a kernel crash that happens if rt_sigreturn is called inside a
transactional block.

This crash happens if the kernel hits an in-kernel page fault when
accessing userspace memory, usually through copy_ckvsx_to_user(). A major
page fault calls might_sleep() function, which can cause a task reschedule.
A task reschedule (switch_to()) reclaim and recheckpoint the TM states,
but, in the signal return path, the checkpointed memory was already
reclaimed, thus the exception stack has MSR that points to MSR[TS]=0.

When the code returns from might_sleep() and a task reschedule happened,
then this task is returned with the memory recheckpointed, and
CPU MSR[TS] = suspended.

This means that there is a side effect at might_sleep() if it is called
with CPU MSR[TS] = 0 and the task has regs->msr[TS] != 0.

This side effect can cause a TM bad thing, since at the exception entrance,
the stack saves MSR[TS]=0, and this is what will be used at RFID, but,
the processor has MSR[TS] = Suspended, and this transition will be invalid
and a TM Bad thing will be raised, causing the following crash:

	Unexpected TM Bad Thing exception at c00000000000e9ec (msr 0x8000000302a03031) tm_scratch=800000010280b033
	cpu 0xc: Vector: 700 (Program Check) at [c00000003ff1fd70]
	    pc: c00000000000e9ec: fast_exception_return+0x100/0x1bc
	    lr: c000000000032948: handle_rt_signal64+0xb8/0xaf0
	    sp: c0000004263ebc40
	   msr: 8000000302a03031
	  current = 0xc000000415050300
	  paca    = 0xc00000003ffc4080	 irqmask: 0x03	 irq_happened: 0x01
	    pid   = 25006, comm = sigfuz
	Linux version 5.0.0-rc1-00001-g3bd6e94bec12 (breno@debian) (gcc version 8.2.0 (Debian 8.2.0-3)) #899 SMP Mon Jan 7 11:30:07 EST 2019
	WARNING: exception is not recoverable, can't continue
	enter ? for help
	[c0000004263ebc40] c000000000032948 handle_rt_signal64+0xb8/0xaf0 (unreliable)
	[c0000004263ebd30] c000000000022780 do_notify_resume+0x2f0/0x430
	[c0000004263ebe20] c00000000000e844 ret_from_except_lite+0x70/0x74
	--- Exception: c00 (System Call) at 00007fffbaac400c
	SP (7fffeca90f40) is in userspace

The solution for this problem is running the sigreturn code with
regs->msr[TS] disabled, thus, avoiding hitting the side effect above. This
does not seem to be a problem since regs->msr will be replaced by the
ucontext value, so, it is being flushed already. In this case, it is
flushed earlier.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 arch/powerpc/kernel/signal_64.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/signal_64.c b/arch/powerpc/kernel/signal_64.c
index 6794466f6420..06c299ef6132 100644
--- a/arch/powerpc/kernel/signal_64.c
+++ b/arch/powerpc/kernel/signal_64.c
@@ -565,7 +565,7 @@ static long restore_tm_sigcontexts(struct task_struct *tsk,
 	preempt_disable();
 
 	/* pull in MSR TS bits from user context */
-	regs->msr = (regs->msr & ~MSR_TS_MASK) | (msr & MSR_TS_MASK);
+	regs->msr |= msr & MSR_TS_MASK;
 
 	/*
 	 * Ensure that TM is enabled in regs->msr before we leave the signal
@@ -745,6 +745,31 @@ SYSCALL_DEFINE0(rt_sigreturn)
 	if (MSR_TM_SUSPENDED(mfmsr()))
 		tm_reclaim_current(0);
 
+	/*
+	 * Disable MSR[TS] bit also, so, if there is an exception in the
+	 * code below (as a page fault in copy_ckvsx_to_user()), it does
+	 * not recheckpoint this task if there was a context switch inside
+	 * the exception.
+	 *
+	 * A major page fault can indirectly call schedule(). A reschedule
+	 * process in the middle of an exception can have a side effect
+	 * (Changing the CPU MSR[TS] state), since schedule() is called
+	 * with the CPU MSR[TS] disable and returns with MSR[TS]=Suspended
+	 * (switch_to() calls tm_recheckpoint() for the 'new' process). In
+	 * this case, the process continues to be the same in the CPU, but
+	 * the CPU state just changed.
+	 *
+	 * This can cause a TM Bad Thing, since the MSR in the stack will
+	 * have the MSR[TS]=0, and this is what will be used to RFID.
+	 *
+	 * Clearing MSR[TS] state here will avoid a recheckpoint if there
+	 * is any process reschedule in kernel space. The MSR[TS] state
+	 * does not need to be saved also, since it will be replaced with
+	 * the MSR[TS] that came from user context later, at
+	 * restore_tm_sigcontexts.
+	 */
+	regs->msr &= ~MSR_TS_MASK;
+
 	if (__get_user(msr, &uc->uc_mcontext.gp_regs[PT_MSR]))
 		goto badframe;
 	if (MSR_TM_ACTIVE(msr)) {
-- 
2.19.0

