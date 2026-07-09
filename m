Return-Path: <linuxppc-dev+bounces-23922-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68F46C43458
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 Jul 2026 09:23:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwqJr0YGbz3c9w;
	Thu, 09 Jul 2026 19:23:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783589020;
	cv=none; b=TCFniryekAA9Gd3tCgU8jtiXBr1yDpkwVmWiTPayRfZi4nYIxp9aqwt7GoZBUm5t3g6D2/aC5+WNF1Nifpxy0jGGV68bnqY51TSBmAUZpcemFMKv8DCl7xpfLhYNtVUS7OdNwAdO4/I/Wab1AUGVh57LW4zsD2o7Sqp+t9qunwXYyJZ0x1vewJemFPtob2H9PLgWHi6zPMgV0Xk5Q0NF8ssOGFb7X0eMZz8tKI6VhuaXNXtzY1LBsA1xD6Bne51KM/azNpXlTgOPHUx/z4wKit7emGF+hg4DbrYWM/LlbviiP91VfhvSec6wC+gw3E4y6NlVTBuDxYd3bQ0QEPZ/NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783589020; c=relaxed/relaxed;
	bh=Y/gwPnB26hr5gbc9Ct90t57n9SJMGHuhyniotn6dcg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hh7caqTpNk+5vVKkoUXyHA3nJhg02xZ7fdPNtL0jEsoRv1R4io6ieDaghldZrkijRPLTAELi8i5vzk04fQEP4dBVU4l2kyVpJFT7EnjC6YNJeRObl/tCNfTrYVzzV2O+6uSs5k9NHxosxWwWwFRO2Hu//53GP2xWIDRGh+LmhWrePNN72k9olvCLRChqOiDXqpuAuP1hpWwVnXjoo7IdBTh1eNoyG+aKJ/BmH2v2FxM0zIMTy4D1N6UNlFNWE1ihzaAw+UEbJ9ebsNegX8gT6et1uU6ex4lRXLXzVHXhb5wTL0mB+McyOrX9AgBHRaxm8NdPRLEA8QAvVxnuXGqtrg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=OFEL9etB; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=vishalc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=OFEL9etB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=vishalc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwqJq107mz3c8C
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 19:23:38 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6696K0511900344;
	Thu, 9 Jul 2026 09:23:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Y/gwPnB26hr5gbc9C
	t90t57n9SJMGHuhyniotn6dcg8=; b=OFEL9etBK0UgRCASWNJ+RmSrWeGRS0pYq
	yEx6psz4AdMEv8a/ELZ7yevRL2X17x4k1PQfJrezEQ563BnRPCUVsfR0lP3JkfcT
	pPHyzeEg/Dp6ARuQoxbtSeEqtqGI6CXJpr1W9bNue7WKYqjzCHJ0t/5EGHoKqzMS
	AZf5ysBJSwnNQw9YvukTDUHgpgrtHhlxwt5QDlnCV3YWAccSEhYQZCMDZTSC7Cys
	raLQOjhxBnGgj3MKtu/Gbs1HLeh7uSJFoeOQpvDgf9HWNJnefSbzL78fVQAuElh2
	8dEj/tmGM/WemkGyH4LvpSV4cM7Azq9b7WZTzCg0zX17sXn34RNPQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sur0pmq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jul 2026 09:23:25 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6699Jbai005114;
	Thu, 9 Jul 2026 09:23:24 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7cgqcp8d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jul 2026 09:23:24 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6699NLui27459978
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Jul 2026 09:23:21 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DE1572004B;
	Thu,  9 Jul 2026 09:23:20 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6D27B20043;
	Thu,  9 Jul 2026 09:23:17 +0000 (GMT)
Received: from vishalc-ibm.bl1-in.ibm.com (unknown [9.123.2.84])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  9 Jul 2026 09:23:17 +0000 (GMT)
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: maddy@linux.ibm.com
Cc: peterz@infradead.org, frederic@kernel.org, npiggin@gmail.com,
        mpe@ellerman.id.au, chleroy@kernel.org, sshegde@linux.ibm.com,
        amachhiw@linux.ibm.com, vaibhav@linux.ibm.com, harshpb@linux.ibm.com,
        gautam@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vishal Chourasia <vishalc@linux.ibm.com>
Subject: [PATCH v4 1/2] KVM: powerpc: Use generic xfer to guest work function
Date: Thu,  9 Jul 2026 14:51:40 +0530
Message-ID: <20260709092140.1753715-4-vishalc@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260709092140.1753715-2-vishalc@linux.ibm.com>
References: <20260709092140.1753715-2-vishalc@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDA4OSBTYWx0ZWRfXxlcdhWGtgC2j
 cy91f3TIocjdXJJlExyb9EwvoBOqhnTyy5Su5TsFWj49euq8xkcwYkg6aJiomT+xSL7nZ+N2Hcw
 N0I0kbOF0nhl+4I2BSGUlyDkyIMdaGo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDA4OSBTYWx0ZWRfX1qZFvGKZcGac
 Sl//GvbOAAby70z5FMu8pUKIbiLtgRXgbXyBvkFtcQy7n/iCkUuEoDKTHB/8Jtz2ZxoVp0qQaQ6
 MmasaKu5haXLW1vRVoeetXby2CybwmiOx5fYrHD7DKfPhVJZkNfZTci9LgyshIu4Wyjg+3f8w/r
 1sFz7Id7wDqWmGygMzWPtoAG5+XQ7Rl7hBD9CCtjitSul2CG+WpXToRzFVg77uP//Q/bPLgqpww
 agAPQA+XY5hz+dqeCRVFve/LOYwhymAxlhLFfHvqJ/dr/AOfmOfgP0TO6cRxi9CjddBCrfBzJnX
 eZGVh8z2hEGWp+xdrcctMWHTpp65ZVgx8Cc22mWeAqcU3dZRYgQzzzCdj3Y3NuslIl7EpzxxzQ8
 sewQsOGHpHDYHg5u8ZjymtKn1VcDJz8HSPmJc9gJ/Aa4s1EoOTlmEhKI4UePZUsZHWAvbas4YU7
 k62qUQbA52+hqowkkBw==
X-Proofpoint-GUID: FuPyIvm2AqZWMfDKBJ1qaGwvVp5vYncD
X-Authority-Analysis: v=2.4 cv=Oot/DS/t c=1 sm=1 tr=0 ts=6a4f688e cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=BPghGADv5-0yqcIHFMsA:9
X-Proofpoint-ORIG-GUID: UCGXwaMEvJ6VeHCpqqLoIJ3jgobix2HG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_01,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090089

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
 arch/powerpc/kvm/booke.c     |  1 +
 arch/powerpc/kvm/powerpc.c   | 37 +++++++++++++++++++++++++---------
 4 files changed, 55 insertions(+), 23 deletions(-)

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
diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index f3ddb24ece74..5fba199dfdd6 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -722,6 +722,7 @@ int kvmppc_core_prepare_to_enter(struct kvm_vcpu *vcpu)
 	if (vcpu->arch.shared->msr & MSR_WE) {
 		local_irq_enable();
 		kvm_vcpu_halt(vcpu);
+		local_irq_disable();
 		hard_irq_disable();
 
 		kvmppc_set_exit_type(vcpu, EMULATED_MTMSRWE_EXITS);
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


