Return-Path: <linuxppc-dev+bounces-23898-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76EC1C43458
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 Jul 2026 06:32:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwlWn1RhDz3c9k;
	Thu, 09 Jul 2026 16:32:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783578773;
	cv=none; b=Cx2Gj45wZgX3yEjwppPW+xvQnVZy45SFj9o/B4lujpMZ8WjOMaaAVsfXOCKJkQ+0YLC8yQp9xIk0UPH93hrH0lyDX7ykbZ3oE1+Dh+GH7UNu1UiESKV6auIinsGC5HRDzNDqr6CcHIdD1G+tgIKL+6RSx8R+9W73FiTNJfATUO4nhxxCfWmIkVeXCSS27sS0vX1sj1tU4sQkK5spkvDhYdgxUKdtJ5MJyxAFL0oS3Om3EcXhp+2ZNQz4j3bgtIODJ73XDSczZ2/eQMIgTaztUCa//BclhIjd43qLLbPuUT/qhVvdKp5WMi73pj442VBiKv9uBYPAxL0oI3u5BCvPRw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783578773; c=relaxed/relaxed;
	bh=9bIyUR11Eycrc6/0mNEFw+74+55ukNW0rU8t3fxJfuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WWtRE4Ckp1/MnWkOkhhuOIXJxy1WH68ElF+kEQ/si+OxR9DWkKSjDK81VWSZreLnU5fJKXud3sEwfs1PWPD06mZ0j/uWrNUjapUbw38XlqiZ4mi1GWjvZgYZLzBjajIYsHw0O1i5SH+AZqmzxsG+vsiSJhLmYLxCSon/z3iPAjz14UDbkHp6Q6P1NI8ZkXby2IQkVAy4fsPAX9i8ShpNA36sxV/xEmIJSnBej07pUr+6cvDqmtJrdGVnpeq1HxKbr9a9K6msXglqjQyKN6OdDMizsU1suLh09sPNNp8ODujR8WI0iA/gn+SfTSOffI3ITaDxRK7BsCF8MoFxqJIpfg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=OyAVekRO; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=vishalc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=OyAVekRO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=vishalc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwlWm3XfNz3byZ
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 16:32:52 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6696IJwM1391148;
	Thu, 9 Jul 2026 06:32:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=9bIyUR11Eycrc6/0m
	NEFw+74+55ukNW0rU8t3fxJfuA=; b=OyAVekRO+XWTkEkK6aLQ91wM0U9dIoYWX
	aHhsbZJkI9YFPiSDHyiLVWW52E2RNIWFCa5j4WPwMHS+6b32QUhxLjgUhjC7rCYJ
	FhecyBpVATglG2bxzRCp2MI5/RKUaajf8g3KSf/xd+tVjvG0GFy09RiisxcabDIN
	UlPFqGZGbFXhbeE2Y7KnrNh0OlkKQhplyfEqWAqXgOYaKtBcgQHm6AkSffGiZTur
	+6Y3JNvvf1O4/Bh9jT4rU/0fKCYlkrRCTnIfWelsOIdXmFLExKtM2UHQGFGWqKvI
	Vo0oUJSCpItIqeIRRg+Q11PMXU3USj8A02woM91qUYOkpoyi+Wc6w==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sp40e4v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jul 2026 06:32:40 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6696Jm0m011593;
	Thu, 9 Jul 2026 06:32:39 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7f6ybk56-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jul 2026 06:32:39 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6696WauD60490042
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Jul 2026 06:32:36 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E2F912004B;
	Thu,  9 Jul 2026 06:32:35 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 54F8E20040;
	Thu,  9 Jul 2026 06:32:32 +0000 (GMT)
Received: from vishalc-ibm.bl1-in.ibm.com (unknown [9.123.2.84])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  9 Jul 2026 06:32:32 +0000 (GMT)
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: maddy@linux.ibm.com
Cc: peterz@infradead.org, frederic@kernel.org, npiggin@gmail.com,
        mpe@ellerman.id.au, chleroy@kernel.org, sshegde@linux.ibm.com,
        amachhiw@linux.ibm.com, vaibhav@linux.ibm.com, harshpb@linux.ibm.com,
        gautam@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vishal Chourasia <vishalc@linux.ibm.com>
Subject: [PATCH v3 1/2] KVM: powerpc: Use generic xfer to guest work function
Date: Thu,  9 Jul 2026 11:59:40 +0530
Message-ID: <20260709062940.1679427-4-vishalc@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260709062940.1679427-2-vishalc@linux.ibm.com>
References: <20260709062940.1679427-2-vishalc@linux.ibm.com>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=KsJ9H2WN c=1 sm=1 tr=0 ts=6a4f4089 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=PgQh_DqA1R2i0zMqUqAA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDA1NyBTYWx0ZWRfX3XY9NzII449C
 UhYBZ4gqLQ3XNo3x1GC3wwIY3tF+noRwaDIKrLDZXH56QiqwIevA6/3Xtqkvb3O3yByncrleC4H
 4CJgL7hbdwcynWR+ep8lQvdKPg25wSk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDA1NyBTYWx0ZWRfX7/uDtKV4OLcK
 6oT6t44MXT5iBoB+ZsoRZ2YSyarAPoO7qanBu2QR4McODMaef7ox1flOwqcbBd/48hisa/FUJKH
 sm34iyI/AycClS6d91ySmfskL4VeWTYRDByVZUHtXZaAugTh0c4k00mTKd2Ip9PII0UzWZ3iiX9
 7UgkRnj7eVCgJ2z/ri8t2gQDPSQUraNmaT0g6XiEVo2FM9l5ofdEx/pexzcVI0Reo9pwp1OHh/m
 DKp/+cIE2YdIZnz0LcCsQngypOENRqBbdfxwsoWfNsbeCvKrT5EJAfnp5nYkfxuc0o7f3DNINrC
 HGql1mGeYSl+mppm1Hkcek/Tv8IMh52Dig7ZVYXOCPDdzFK90GaSJUJkk/Px5MTcAS4NFsvU542
 jx6mEM9hmFm3Rq3THxcq+iqKUXG/cag5SmWp9yxC++ou/xp7K1VFygTcG1gv95Yjms3mN8zXFTL
 rfKQSRbjfw1Nk+A0qxw==
X-Proofpoint-ORIG-GUID: HtyxLAVgoVvj4BMK3bjRoyEP8gdkH0AG
X-Proofpoint-GUID: kO3KAesDjfmyxY0pJomrkMES_yEAER1z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_01,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 adultscore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090057

Since commit 2cd571245b43 ("sched/fair: Add related data structure for
task based throttle") in v6.18, CFS bandwidth throttling no longer
dequeues a task directly; it queues task_work via TWA_RESUME and sets
TIF_NOTIFY_RESUME, relying on that work running before the task returns
to guest/user mode. The powerpc KVM run loops only checked for reschedule
and signals, never TIF_NOTIFY_RESUME, so the deferred throttle never ran
while a vCPU stayed in the run loop: a CPU-bound guest that rarely exits
to userspace ran far past its cpu.max quota and then appeared frozen for
minutes while the accrued throttle debt was repaid.

Use the generic infrastructure to check for and handle pending work
before transitioning into guest mode, replacing the open-coded
need_resched() and cond_resched() checks in the Book3S HV run loops and
in the common kvmppc_prepare_to_enter() used by the Book3S PR and BookE
run loops. The redundant signal_pending() recheck (and its sigpend label)
in kvmhv_run_single_vcpu() is also dropped, as
xfer_to_guest_mode_work_pending() is a superset of it.

This picks up handling for TIF_NOTIFY_RESUME, which was previously
ignored, meaning task work will now be correctly handled on every
guest re-entry.

Selecting VIRT_XFER_TO_GUEST_WORK disables RCU's last-resort self-IPI
fallback for vCPU tasks (see rcu_irq_work_resched()), which on
nohz_full CPUs was what forced a reschedule for deferred rcuog wakeups
queued right before guest entry. Take over that obligation the same way
x86 and s390 do: call xfer_to_guest_mode_prepare() with IRQs disabled
immediately before the final xfer_to_guest_mode_work_pending() check at
each guest-entry gate (kvmhv_run_single_vcpu(), kvmppc_run_core() and
kvmppc_prepare_to_enter()).

In kvmppc_prepare_to_enter(), IRQs are now disabled with
local_irq_disable() before hard_irq_disable(): on 32-bit,
hard_irq_disable() is a raw MSR[EE] clear that bypasses the
lockdep/irq-tracing state, and the strict xfer_to_guest_mode helpers
assert that IRQs are seen as disabled. This also allows upgrading the
racy __xfer_to_guest_mode_work_pending() check to the asserting
variant, as this loop is the terminal gate for the PR and BookE paths.

In kvmhv_run_single_vcpu(), the -EINTR exit and the pre-existing
kvmhv_setup_mmu() failure exit now leave via the done label instead of
returning directly, keeping the run_vcpu enter/exit tracepoints
balanced and vcpu->arch.ret consistent with the returned value.

In kvmppc_prepare_to_enter() the generic helper accounts the signal exit
(vcpu->stat.signal_exits and KVM_EXIT_INTR) but does not set the exit
type, so kvmppc_set_exit_type(SIGNAL_EXITS) is retained on the signal
path to preserve the E500 CONFIG_KVM_EXIT_TIMING histogram; it is a no-op
otherwise.

Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
---
 arch/powerpc/kvm/Kconfig     |  1 +
 arch/powerpc/kvm/book3s_hv.c | 39 +++++++++++++++++++++++-------------
 arch/powerpc/kvm/powerpc.c   | 37 +++++++++++++++++++++++++---------
 3 files changed, 54 insertions(+), 23 deletions(-)

diff --git a/arch/powerpc/kvm/Kconfig b/arch/powerpc/kvm/Kconfig
index 9a0d1c1aca6c..b6bc2fc86dca 100644
--- a/arch/powerpc/kvm/Kconfig
+++ b/arch/powerpc/kvm/Kconfig
@@ -22,6 +22,7 @@ config KVM
 	select KVM_COMMON
 	select KVM_VFIO
 	select HAVE_KVM_IRQ_BYPASS
+	select VIRT_XFER_TO_GUEST_WORK
 
 config KVM_BOOK3S_HANDLER
 	bool
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 61dbeea317f3..3cfe9a7be9c6 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -3853,7 +3853,8 @@ static noinline void kvmppc_run_core(struct kvmppc_vcore *vc)
 	 */
 	local_irq_disable();
 	hard_irq_disable();
-	if (lazy_irq_pending() || need_resched() ||
+	xfer_to_guest_mode_prepare();
+	if (lazy_irq_pending() || xfer_to_guest_mode_work_pending() ||
 	    recheck_signals_and_mmu(&core_info)) {
 		local_irq_enable();
 		vc->vcore_state = VCORE_INACTIVE;
@@ -4824,10 +4825,16 @@ static int kvmppc_run_vcpu(struct kvm_vcpu *vcpu)
 		vc->runner = vcpu;
 		if (n_ceded == vc->n_runnable) {
 			kvmppc_vcore_blocked(vc);
-		} else if (need_resched()) {
+		} else if (__xfer_to_guest_mode_work_pending()) {
 			kvmppc_vcore_preempt(vc);
-			/* Let something else run */
-			cond_resched_lock(&vc->lock);
+			/*
+			 * Let something else run. The raw helper is used as
+			 * signal exits are accounted by this path already;
+			 * it may schedule(), so drop the vcore lock.
+			 */
+			spin_unlock(&vc->lock);
+			xfer_to_guest_mode_handle_work();
+			spin_lock(&vc->lock);
 			if (vc->vcore_state == VCORE_PREEMPT)
 				kvmppc_vcore_end_preempt(vc);
 		} else {
@@ -4895,12 +4902,16 @@ int kvmhv_run_single_vcpu(struct kvm_vcpu *vcpu, u64 time_limit,
 			run->exit_reason = KVM_EXIT_FAIL_ENTRY;
 			run->fail_entry.hardware_entry_failure_reason = 0;
 			vcpu->arch.ret = r;
-			return r;
+			goto done;
 		}
 	}
 
-	if (need_resched())
-		cond_resched();
+	r = kvm_xfer_to_guest_mode_handle_work(vcpu);
+	if (r) {
+		/* -EINTR: signal pending, exit to userspace (KVM_EXIT_INTR) */
+		vcpu->arch.ret = r;
+		goto done;
+	}
 
 	kvmppc_update_vpas(vcpu);
 
@@ -4914,9 +4925,13 @@ int kvmhv_run_single_vcpu(struct kvm_vcpu *vcpu, u64 time_limit,
 
 	vcpu->arch.state = KVMPPC_VCPU_RUNNABLE;
 
-	if (signal_pending(current))
-		goto sigpend;
-	if (need_resched() || !kvm->arch.mmu_ready)
+	xfer_to_guest_mode_prepare();
+
+	/*
+	 * IRQs are disabled here, so on pending work bail to the outer loop,
+	 * which handles it via kvm_xfer_to_guest_mode_handle_work() above.
+	 */
+	if (xfer_to_guest_mode_work_pending() || !kvm->arch.mmu_ready)
 		goto out;
 
 	vcpu->cpu = pcpu;
@@ -5068,10 +5083,6 @@ int kvmhv_run_single_vcpu(struct kvm_vcpu *vcpu, u64 time_limit,
 
 	return vcpu->arch.ret;
 
- sigpend:
-	vcpu->stat.signal_exits++;
-	run->exit_reason = KVM_EXIT_INTR;
-	vcpu->arch.ret = -EINTR;
  out:
 	vcpu->cpu = -1;
 	vcpu->arch.thread_cpu = -1;
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 00302399fc37..be5e48ae0c6c 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -81,23 +81,41 @@ int kvmppc_prepare_to_enter(struct kvm_vcpu *vcpu)
 	int r;
 
 	WARN_ON(irqs_disabled());
+	/*
+	 * local_irq_disable() first: on 32-bit, hard_irq_disable() alone is a
+	 * raw MSR[EE] clear that bypasses the lockdep/irq-tracing state, and
+	 * the xfer_to_guest_mode helpers assert IRQs are seen as disabled.
+	 */
+	local_irq_disable();
 	hard_irq_disable();
 
 	while (true) {
-		if (need_resched()) {
+		xfer_to_guest_mode_prepare();
+
+		if (xfer_to_guest_mode_work_pending()) {
+			/*
+			 * The helper must run with IRQs enabled and may
+			 * schedule(). On a pending signal it returns -EINTR
+			 * with run->exit_reason and vcpu->stat.signal_exits
+			 * already set, so just return to userspace.
+			 */
 			local_irq_enable();
-			cond_resched();
+			r = kvm_xfer_to_guest_mode_handle_work(vcpu);
+			local_irq_disable();
 			hard_irq_disable();
+			if (r) {
+				/*
+				 * The generic helper does not set the exit
+				 * type; record it for the E500
+				 * CONFIG_KVM_EXIT_TIMING histogram (a no-op
+				 * otherwise).
+				 */
+				kvmppc_set_exit_type(vcpu, SIGNAL_EXITS);
+				break;
+			}
 			continue;
 		}
 
-		if (signal_pending(current)) {
-			kvmppc_account_exit(vcpu, SIGNAL_EXITS);
-			vcpu->run->exit_reason = KVM_EXIT_INTR;
-			r = -EINTR;
-			break;
-		}
-
 		vcpu->mode = IN_GUEST_MODE;
 
 		/*
@@ -116,6 +134,7 @@ int kvmppc_prepare_to_enter(struct kvm_vcpu *vcpu)
 			local_irq_enable();
 			trace_kvm_check_requests(vcpu);
 			r = kvmppc_core_check_requests(vcpu);
+			local_irq_disable();
 			hard_irq_disable();
 			if (r > 0)
 				continue;
-- 
2.54.0


