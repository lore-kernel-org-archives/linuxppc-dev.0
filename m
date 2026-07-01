Return-Path: <linuxppc-dev+bounces-23319-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50C60C43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Jul 2026 18:31:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gr7rJ5Pf6z2yk6;
	Thu, 02 Jul 2026 04:31:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782930672;
	cv=none; b=f3SjzHwjDls2Y99cx/cxNDkjmSCXvZ2mNOx33HBKwJtepsQ/RWrzeiuhPYz5xU2Vo8xrMVxjD5dIBxczFjYRM2AzwRKRcTIs+ayAY6LdMBobNDFVHoT4VENhpNoPONZ5sK4A6XXh4HeXS2mLAyDRIiVzZTIOAaC1v/ICa3i6Sse5rW1/coGw3TKT+QPr7sZDWRF2oNxMF/bL1H7QDbaedN218nMNGx37TjZZaZmnURiQ7xnvXruacAQX4rKu69ZecE+dIzQARQBWQccf3U6e0CqrLRION0I5lSz5ZvsI+t+8IOW5QQ6u/22iGgQV/krqo2pigDOoq3pvCGh2FUw5Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782930672; c=relaxed/relaxed;
	bh=NALsCpt2RDZ5bQjyWDJHlliFCSpzq/f0eoKFQT7hwAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QZAss8Xgy+tAJ9F2x1Ra+0KvSwty8cGgN/HPjuachKJhl6LZQh4sXgE9K7A2I49dq48oUGEipziiguj1f+SPuxuKPiyXm7yuMx5G4bjPA5Xp5x6IliO5lFOBkdPoKw9v3zSjmAEHeBeIcpqjNGwMuMPPdy1Ebu5Uj82LHfCEFMNnDxZWGOvZ+U6JjACI39P2L7cfEuZDkyElVZhKV5aeES+9gBCK7Y7PGM5kC85d+0gBSwJkhSbfcUGYqoZYG44o+nJMP/M0m+wnguhOeOG63P2QqjkH+CabqpnTq5lnKyygzI4XHp+aN1T/puN/TXvp9PXaZ2iY4MTQQqdkmVMggQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=IvVdiVHw; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=vishalc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=IvVdiVHw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=vishalc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gr7rH44Npz2ygL
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Jul 2026 04:31:11 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661GnU6D1296401;
	Wed, 1 Jul 2026 18:31:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=NALsCpt2RDZ5bQjyW
	DJHlliFCSpzq/f0eoKFQT7hwAU=; b=IvVdiVHw5mYhPf5hLP/Ud/wT8BqFiNeBk
	I+nQn9amIJaG6fQdFkodozkaWf/3Aunhu93N+Aed6aO1gCFgozzjznMJWwN/JU8f
	0ckHpcjNyrCRGJeh3cKh3petrKzksXY7GD8c05jFQcf9ezu8QIjEGiawGw1Bhn7P
	55r5msnmHGATmE6w4Fej211+bHG8/pD1T0TRC2UqqDAkj+As9TCS6hX1NBi+Xxy/
	wxZ3WUG3DiqEVh+WvkBNv8cXdtuxbgEisBp+GW8StjpfcUBatWNlaOiGYgJNRamr
	+p9X2DLX4WDqAFKQKqogDh7el2iGrPaitGvNj8h5OSM/F5I12WRLA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26mjwrrg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 18:31:00 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 661IJc3w029322;
	Wed, 1 Jul 2026 18:31:00 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2suk8kny-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 18:31:00 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 661IUuEN31064502
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Jul 2026 18:30:56 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3BACB2004B;
	Wed,  1 Jul 2026 18:30:56 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3C85320040;
	Wed,  1 Jul 2026 18:30:52 +0000 (GMT)
Received: from vishalc-ibm.ibm.com (unknown [9.39.23.199])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  1 Jul 2026 18:30:51 +0000 (GMT)
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: maddy@linux.ibm.com
Cc: npiggin@gmail.com, mpe@ellerman.id.au, chleroy@kernel.org,
        sshegde@linux.ibm.com, amachhiw@linux.ibm.com, vaibhav@linux.ibm.com,
        harshpb@linux.ibm.com, gautam@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vishal Chourasia <vishalc@linux.ibm.com>
Subject: [PATCH v2 1/1] KVM: powerpc: Use generic xfer to guest work function
Date: Thu,  2 Jul 2026 00:00:27 +0530
Message-ID: <20260701183030.3610451-2-vishalc@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701183030.3610451-1-vishalc@linux.ibm.com>
References: <20260701183030.3610451-1-vishalc@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDE5NiBTYWx0ZWRfX3yJ+5sgrA4bL
 beW8LEB9lB/DzRdQqjHklNCxxb0uhryR4HPcInu45PeTliX93UYh4jWisx0WvhTjj49v2t8A7vq
 E9Zi99mykuxPcgi01WN+TCqTA7GgrzR6flucIk+EQeAl2ZKZzgQnEVqNYXYXdNb04lIJJje3x/c
 R58Zw0v6576frsDmBdmB2ms67T3flQ7X+dvFOCUvyr/NpbhClagXR0jzb7iVjx0eP2C1xC4Z9Ci
 m5YkU/4MTvfj/zARuB+s+qzepHPeK8HE4RnCaitpfbxTwMWwgmSJTvGL8zAVJDezkJiUfUxbLCH
 8zpiXzCXzxf+i5NBpWzLTznyu9uBhjMUGqNbEu69kh4ipI5Qkh+5Q9CBygyjBlqjfF0iLEau9G8
 +aU+wU/9eBm1HNlkWITcdZMPHQTaqKHGjSJYiObIBIA01ZPWGtZTaAR1wB9Ms2Ncde9soItZFZj
 0dI5UeTJyL02fAZaqwg==
X-Proofpoint-GUID: 3Mrlj2r3lc6Utdep8qY8vRIkzeQ0Del9
X-Authority-Analysis: v=2.4 cv=Z8bc2nRA c=1 sm=1 tr=0 ts=6a455ce5 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=jCD_RTl0JyhR25mDuCMA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDE5NiBTYWx0ZWRfX6042ztv0atoq
 rVdadVWMKVN5VFuBtPhMcrMGIkryfzyO9fTnK/hsIHtCWyENpUECBMxG4zSIttRM5Q1rnWszz+p
 jBOY59gAH8m7Oc9zZAT/rgTNJk1AxdA=
X-Proofpoint-ORIG-GUID: Em0-rEhFozKvMi-kZY2GuZF5_MG27AEX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010196

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

In kvmppc_prepare_to_enter() the generic helper accounts the signal exit
(vcpu->stat.signal_exits and KVM_EXIT_INTR) but does not set the exit
type, so kvmppc_set_exit_type(SIGNAL_EXITS) is retained on the signal
path to preserve the E500 CONFIG_KVM_EXIT_TIMING histogram; it is a no-op
otherwise.

Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
---
 arch/powerpc/kvm/Kconfig     |  1 +
 arch/powerpc/kvm/book3s_hv.c | 64 ++++++++++++++++++++++++++++--------
 arch/powerpc/kvm/powerpc.c   | 34 ++++++++++++++-----
 3 files changed, 77 insertions(+), 22 deletions(-)

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
index 61dbeea317f3..a1b2077561bb 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -3850,10 +3850,20 @@ static noinline void kvmppc_run_core(struct kvmppc_vcore *vc)
 	 * and return without going into the guest(s).
 	 * If the mmu_ready flag has been cleared, don't go into the
 	 * guest because that means a HPT resize operation is in progress.
+	 *
+	 * xfer_to_guest_mode_work_pending() is the IRQs-disabled recheck for
+	 * pending guest-mode work (reschedule, signals, and TIF_NOTIFY_RESUME
+	 * task_work such as the deferred CFS throttle). It is the pre-POWER9
+	 * analog of the final gate in kvmhv_run_single_vcpu(), and a superset
+	 * of the old need_resched() check: it catches work that raced in after
+	 * the drain in kvmppc_run_vcpu(), so a CPU-bound vCPU is throttled here
+	 * instead of running one more guest dispatch past its quota. IRQs are
+	 * hard-disabled just above, so the non-__ variant (which asserts that)
+	 * is the correct one.
 	 */
 	local_irq_disable();
 	hard_irq_disable();
-	if (lazy_irq_pending() || need_resched() ||
+	if (lazy_irq_pending() || xfer_to_guest_mode_work_pending() ||
 	    recheck_signals_and_mmu(&core_info)) {
 		local_irq_enable();
 		vc->vcore_state = VCORE_INACTIVE;
@@ -4824,10 +4834,24 @@ static int kvmppc_run_vcpu(struct kvm_vcpu *vcpu)
 		vc->runner = vcpu;
 		if (n_ceded == vc->n_runnable) {
 			kvmppc_vcore_blocked(vc);
-		} else if (need_resched()) {
+		} else if (__xfer_to_guest_mode_work_pending()) {
 			kvmppc_vcore_preempt(vc);
-			/* Let something else run */
-			cond_resched_lock(&vc->lock);
+			/*
+			 * Let something else run, and run pending guest-mode
+			 * work (reschedule, and TIF_NOTIFY_RESUME task_work such
+			 * as the deferred CFS throttle) before we would re-enter
+			 * the guest, so a CPU-bound vCPU is actually throttled
+			 * here instead of running past its quota. This is a
+			 * superset of the old need_resched() check. Use the raw
+			 * helper, not the kvm_ wrapper: signals (KVM_EXIT_INTR
+			 * and the signal_exits stat) are accounted by this path's
+			 * existing handling below, so going through the wrapper
+			 * here would double-count them. The helper may schedule(),
+			 * so the vcore lock is dropped around it.
+			 */
+			spin_unlock(&vc->lock);
+			xfer_to_guest_mode_handle_work();
+			spin_lock(&vc->lock);
 			if (vc->vcore_state == VCORE_PREEMPT)
 				kvmppc_vcore_end_preempt(vc);
 		} else {
@@ -4899,8 +4923,21 @@ int kvmhv_run_single_vcpu(struct kvm_vcpu *vcpu, u64 time_limit,
 		}
 	}
 
-	if (need_resched())
-		cond_resched();
+	/*
+	 * Run pending work before (re-)entering the guest, most importantly
+	 * task_work queued via TWA_RESUME (e.g. the deferred CFS bandwidth
+	 * throttle, which only sets TIF_NOTIFY_RESUME). Without this a CPU-bound
+	 * vCPU that keeps returning RESUME_GUEST never reaches an exit-to-user
+	 * point, so the throttle is never enforced and the task runs far beyond
+	 * its quota. The helper also handles reschedule and signals, replacing
+	 * the cond_resched() that was here. It may schedule(), so it runs before
+	 * preemption and IRQs are disabled, with no vcore/KVM locks held. This
+	 * is the per-reentry site shared by the bare-metal and pseries (nested)
+	 * paths, so both are covered.
+	 */
+	r = kvm_xfer_to_guest_mode_handle_work(vcpu);
+	if (r)	/* -EINTR: signal pending, exit to userspace (KVM_EXIT_INTR) */
+		return r;
 
 	kvmppc_update_vpas(vcpu);
 
@@ -4914,9 +4951,14 @@ int kvmhv_run_single_vcpu(struct kvm_vcpu *vcpu, u64 time_limit,
 
 	vcpu->arch.state = KVMPPC_VCPU_RUNNABLE;
 
-	if (signal_pending(current))
-		goto sigpend;
-	if (need_resched() || !kvm->arch.mmu_ready)
+	/*
+	 * Final IRQs-disabled check for pending guest-mode work or an MMU that
+	 * is not ready. IRQs are disabled here, so bail to the outer loop,
+	 * which re-enters and handles the pending work via
+	 * kvm_xfer_to_guest_mode_handle_work() above (exiting with -EINTR on a
+	 * signal).
+	 */
+	if (xfer_to_guest_mode_work_pending() || !kvm->arch.mmu_ready)
 		goto out;
 
 	vcpu->cpu = pcpu;
@@ -5068,10 +5110,6 @@ int kvmhv_run_single_vcpu(struct kvm_vcpu *vcpu, u64 time_limit,
 
 	return vcpu->arch.ret;
 
- sigpend:
-	vcpu->stat.signal_exits++;
-	run->exit_reason = KVM_EXIT_INTR;
-	vcpu->arch.ret = -EINTR;
  out:
 	vcpu->cpu = -1;
 	vcpu->arch.thread_cpu = -1;
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 00302399fc37..ff1a9a8de5e0 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -84,20 +84,36 @@ int kvmppc_prepare_to_enter(struct kvm_vcpu *vcpu)
 	hard_irq_disable();
 
 	while (true) {
-		if (need_resched()) {
+		if (__xfer_to_guest_mode_work_pending()) {
+			/*
+			 * Handle pending guest-mode work before entering the
+			 * guest: reschedule, signals, and TIF_NOTIFY_RESUME
+			 * task_work such as the deferred CFS bandwidth throttle.
+			 * The helper must run with interrupts enabled and may
+			 * schedule(). This is a superset of the open-coded
+			 * need_resched()/signal_pending() checks it replaces. On
+			 * a pending signal it returns -EINTR after
+			 * kvm_xfer_to_guest_mode_handle_work() has set
+			 * run->exit_reason (KVM_EXIT_INTR) and bumped
+			 * vcpu->stat.signal_exits, so just return to userspace.
+			 */
 			local_irq_enable();
-			cond_resched();
+			r = kvm_xfer_to_guest_mode_handle_work(vcpu);
 			hard_irq_disable();
+			if (r) {
+				/*
+				 * -EINTR: the generic helper does not set the
+				 * exit type, so record it here for the E500
+				 * CONFIG_KVM_EXIT_TIMING histogram (a no-op
+				 * otherwise). Only the exit type is set;
+				 * signal_exits was already accounted above.
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
-- 
2.54.0


