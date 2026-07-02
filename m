Return-Path: <linuxppc-dev+bounces-23363-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CCBBC43458
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Jul 2026 07:48:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4grTX2684Vz2ygh;
	Thu, 02 Jul 2026 17:48:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782978498;
	cv=none; b=CfJod4JHQn3DE9CUy0xgD+t3VnWGcaeI1bUOITQYJSw58pW8YGcgJTDrizqTf4Z7E1mTnPZKIdtvg6aZWScuQYY49oEfW7FdJm8gp4g1zXUg8NCg7IP0lVEyXSr4C1TrfoLAR0pgeCs9p0AjoLn/x4pZ8jF6FYnxx579kYngc1rfsO/Kp5+ySGI0JA6vEYmNx+TFVTJbA8eJdNxk7PEdUYDiW/Tfi26taa4Cyg7LY/lx0rVyeTI5uJcY0nIh/wkIUpzLBXcIn4p4ypwsM/wb9K9/Ykq1e4sL79Jy4d5hqIm01Az1KfDLYxluVIrRczEVhLzIXL5Mmm/wAk7O5PBsRw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782978498; c=relaxed/relaxed;
	bh=I/zSbLIoR7MbaWLql1wSkSpKivtB4xZ6nSWEwUqI4s8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VXhDVGv9ggZ9ShRKEHu5vc+kLqQmSGCzwDsjJIzpe5O/ryJ6oE9yppqfX2Jw6TX8fLINv3K6iPtgNms1oYzggQItn6tFKQmbwk1PcLD2XFCR4BfOM8a7r4qvlfljX2lE2ZHM6szyMGVa4Pw02Em415FGaZ5+sa6/fG+N6VmMN+hHP7mnl9axqL0WafKUIIrh+/Cj6GXqlM5Toi81/JkvUnvss+xaBsC+pg5b+pwFt0Pz+OJBunQg/ASd0A3K6kRonHEu4Qh0Y6MkxLkGlsbhDMov/WhqdMMap0YSpCHJBTGXTr+jrtyLWqTLjPxc9vB53LSabM2Oa6MBS05UGW52sw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Z6t5Gpro; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Z6t5Gpro;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4grTX14ND2z2ygg
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Jul 2026 17:48:17 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6621L4q62510488;
	Thu, 2 Jul 2026 07:47:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=I/zSbL
	IoR7MbaWLql1wSkSpKivtB4xZ6nSWEwUqI4s8=; b=Z6t5GprowXc6Y2Hp0lJtEe
	SSJ7SnMozIV1eZajwJs3YlURWYx3hqXHggBUm/VUF8atVfKkXwbZnOETttps+87d
	Z+Cda8VwibwLxtUy7wJI11mFAwDFekvty27xJghGyyL0gkdHrMrwHUah5874MnEL
	NjYULnzvgDos+U4nT5NeTlZxMEHjj6qs/AD4e0E69FOSWVCAMT8b5Ss5fthXdsSA
	4HhqI0u3dSyHN/Ff+bg3Q+8fF+9LdJWlCyqCHtSnJUN94O+KTs/Syp136hThQ9Sk
	vVYD72cL69/hEn6iyFd1DTmenPSJh92OG8yhRV0mQoyzErcQmeqVKWZFclnfHGDw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26pe8tmj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Jul 2026 07:47:39 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6627Yamk003445;
	Thu, 2 Jul 2026 07:47:38 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2sukb0m1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Jul 2026 07:47:37 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6627lYbE27984256
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 2 Jul 2026 07:47:34 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E7EB92004B;
	Thu,  2 Jul 2026 07:47:33 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 078A020040;
	Thu,  2 Jul 2026 07:47:31 +0000 (GMT)
Received: from [9.123.5.233] (unknown [9.123.5.233])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  2 Jul 2026 07:47:30 +0000 (GMT)
Message-ID: <092d5f46-9809-41bb-b332-aa51ad1ed04d@linux.ibm.com>
Date: Thu, 2 Jul 2026 13:17:30 +0530
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] KVM: powerpc: Use generic xfer to guest work
 function
To: Vishal Chourasia <vishalc@linux.ibm.com>, maddy@linux.ibm.com,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: npiggin@gmail.com, mpe@ellerman.id.au, chleroy@kernel.org,
        amachhiw@linux.ibm.com, vaibhav@linux.ibm.com, harshpb@linux.ibm.com,
        gautam@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260701183030.3610451-1-vishalc@linux.ibm.com>
 <20260701183030.3610451-2-vishalc@linux.ibm.com>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <20260701183030.3610451-2-vishalc@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: VysgVheLcDHz43FGtEnemMom3AAR9Ee4
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDA3MyBTYWx0ZWRfXz2LGW0w5rywB
 P/w1W+lLqo0mXY1Gm5jukg5O482b6Z6eduT76szH6yNWSZ2T5m41Tzx2z0zUhcIh0BtNP0/n6hn
 RXD3yH11ph7TAXge6GTwmSFCI9vGhyY=
X-Authority-Analysis: v=2.4 cv=edsNubEH c=1 sm=1 tr=0 ts=6a46179b cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=_k42mK2LSDdbbVhXwdsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDA3MyBTYWx0ZWRfXxbGXOpo4kRmT
 Kd4hocYD2tNjYzUJKRTrD2PDf2pi4ySIYP6hmjDW619AHZ43/wXPYNtQz9V7znLKX7KXbqOggA+
 Qd6WEDOuBzKZCtkSJVAQaQBThmCDCGbeENlUVz79aUrJnpu7bnP9RjPQCbpw36C6OdHcR1+B+om
 +V4IWineWOETZJvszwUUBsEZ0biM4La85y+yyuWnyTrPskGhtswPZ+kY9jLStJ2uKb+uYIPqDF5
 /gHsrmyy7RefiZ9DkQf7WQ6M/gSEjs5N9Z2X2WO+wcKagrTgRCkW8tucOt6zGqFA8y79AOl1AE2
 KUuh3l2bwdSs+o43YYLAwJED7dEeCG4Z90/GP3Gj5wXfQk4r4OyskvNWEvq5TBkleAE9rkfdJVn
 a0A7guB1vfLGXhSpSdo92A6A+kyuZpLYb+7i31mBkSnvHGJ67IiWBDdGrjpgmesRzWDy28CmPoe
 P5s/WNR2GPNOIDSQ3zg==
X-Proofpoint-ORIG-GUID: 5_lN5bB_ifBSnqUqFO5dsbIewHxFrOg1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0 bulkscore=0
 spamscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020073



On 7/2/26 12:00 AM, Vishal Chourasia wrote:
> Since commit 2cd571245b43 ("sched/fair: Add related data structure for
> task based throttle") in v6.18, CFS bandwidth throttling no longer
> dequeues a task directly; it queues task_work via TWA_RESUME and sets
> TIF_NOTIFY_RESUME, relying on that work running before the task returns
> to guest/user mode. The powerpc KVM run loops only checked for reschedule
> and signals, never TIF_NOTIFY_RESUME, so the deferred throttle never ran
> while a vCPU stayed in the run loop: a CPU-bound guest that rarely exits
> to userspace ran far past its cpu.max quota and then appeared frozen for
> minutes while the accrued throttle debt was repaid.
> 
> Use the generic infrastructure to check for and handle pending work
> before transitioning into guest mode, replacing the open-coded
> need_resched() and cond_resched() checks in the Book3S HV run loops and
> in the common kvmppc_prepare_to_enter() used by the Book3S PR and BookE
> run loops. The redundant signal_pending() recheck (and its sigpend label)
> in kvmhv_run_single_vcpu() is also dropped, as
> xfer_to_guest_mode_work_pending() is a superset of it.
> 
> This picks up handling for TIF_NOTIFY_RESUME, which was previously
> ignored, meaning task work will now be correctly handled on every
> guest re-entry.
> 
> In kvmppc_prepare_to_enter() the generic helper accounts the signal exit
> (vcpu->stat.signal_exits and KVM_EXIT_INTR) but does not set the exit
> type, so kvmppc_set_exit_type(SIGNAL_EXITS) is retained on the signal
> path to preserve the E500 CONFIG_KVM_EXIT_TIMING histogram; it is a no-op
> otherwise.
> 

With VIRT_XFER_TO_GUEST_WORK support,
you can take the HAVE_POSIX_CPU_TIMERS_TASK_WORK patch too?
https://lore.kernel.org/all/20250421102837.78515-3-sshegde@linux.ibm.com/

That would help in adding some of those remaining patches for PREEMPT_RT
on powernv system. the remaining ones are straighforward or already
merged in some form.

+Sebastian.

> Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
> ---
>   arch/powerpc/kvm/Kconfig     |  1 +
>   arch/powerpc/kvm/book3s_hv.c | 64 ++++++++++++++++++++++++++++--------
>   arch/powerpc/kvm/powerpc.c   | 34 ++++++++++++++-----
>   3 files changed, 77 insertions(+), 22 deletions(-)
> 
> diff --git a/arch/powerpc/kvm/Kconfig b/arch/powerpc/kvm/Kconfig
> index 9a0d1c1aca6c..b6bc2fc86dca 100644
> --- a/arch/powerpc/kvm/Kconfig
> +++ b/arch/powerpc/kvm/Kconfig
> @@ -22,6 +22,7 @@ config KVM
>   	select KVM_COMMON
>   	select KVM_VFIO
>   	select HAVE_KVM_IRQ_BYPASS
> +	select VIRT_XFER_TO_GUEST_WORK
>   
>   config KVM_BOOK3S_HANDLER
>   	bool
> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index 61dbeea317f3..a1b2077561bb 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -3850,10 +3850,20 @@ static noinline void kvmppc_run_core(struct kvmppc_vcore *vc)
>   	 * and return without going into the guest(s).
>   	 * If the mmu_ready flag has been cleared, don't go into the
>   	 * guest because that means a HPT resize operation is in progress.
> +	 *
> +	 * xfer_to_guest_mode_work_pending() is the IRQs-disabled recheck for
> +	 * pending guest-mode work (reschedule, signals, and TIF_NOTIFY_RESUME
> +	 * task_work such as the deferred CFS throttle). It is the pre-POWER9
> +	 * analog of the final gate in kvmhv_run_single_vcpu(), and a superset
> +	 * of the old need_resched() check: it catches work that raced in after
> +	 * the drain in kvmppc_run_vcpu(), so a CPU-bound vCPU is throttled here
> +	 * instead of running one more guest dispatch past its quota. IRQs are
> +	 * hard-disabled just above, so the non-__ variant (which asserts that)
> +	 * is the correct one.

IMO, These are good to go in a changelog. But not for comments.
Could you trim the comments not to describe
what xfer_to_guest_mode_work_pending does?

Similar comment for other big fat comments.

>   	 */
>   	local_irq_disable();
>   	hard_irq_disable();
> -	if (lazy_irq_pending() || need_resched() ||
> +	if (lazy_irq_pending() || xfer_to_guest_mode_work_pending() ||
>   	    recheck_signals_and_mmu(&core_info)) {
>   		local_irq_enable();
>   		vc->vcore_state = VCORE_INACTIVE;
> @@ -4824,10 +4834,24 @@ static int kvmppc_run_vcpu(struct kvm_vcpu *vcpu)
>   		vc->runner = vcpu;
>   		if (n_ceded == vc->n_runnable) {
>   			kvmppc_vcore_blocked(vc);
> -		} else if (need_resched()) {
> +		} else if (__xfer_to_guest_mode_work_pending()) {
>   			kvmppc_vcore_preempt(vc);
> -			/* Let something else run */
> -			cond_resched_lock(&vc->lock);
> +			/*
> +			 * Let something else run, and run pending guest-mode
> +			 * work (reschedule, and TIF_NOTIFY_RESUME task_work such
> +			 * as the deferred CFS throttle) before we would re-enter
> +			 * the guest, so a CPU-bound vCPU is actually throttled
> +			 * here instead of running past its quota. This is a
> +			 * superset of the old need_resched() check. Use the raw
> +			 * helper, not the kvm_ wrapper: signals (KVM_EXIT_INTR
> +			 * and the signal_exits stat) are accounted by this path's
> +			 * existing handling below, so going through the wrapper
> +			 * here would double-count them. The helper may schedule(),
> +			 * so the vcore lock is dropped around it.
> +			 */

reduce this blob.

> +			spin_unlock(&vc->lock);
> +			xfer_to_guest_mode_handle_work();
> +			spin_lock(&vc->lock);
>   			if (vc->vcore_state == VCORE_PREEMPT)
>   				kvmppc_vcore_end_preempt(vc);
>   		} else {
> @@ -4899,8 +4923,21 @@ int kvmhv_run_single_vcpu(struct kvm_vcpu *vcpu, u64 time_limit,
>   		}
>   	}
>   
> -	if (need_resched())
> -		cond_resched();
> +	/*
> +	 * Run pending work before (re-)entering the guest, most importantly
> +	 * task_work queued via TWA_RESUME (e.g. the deferred CFS bandwidth
> +	 * throttle, which only sets TIF_NOTIFY_RESUME). Without this a CPU-bound
> +	 * vCPU that keeps returning RESUME_GUEST never reaches an exit-to-user
> +	 * point, so the throttle is never enforced and the task runs far beyond
> +	 * its quota. The helper also handles reschedule and signals, replacing
> +	 * the cond_resched() that was here. It may schedule(), so it runs before
> +	 * preemption and IRQs are disabled, with no vcore/KVM locks held. This
> +	 * is the per-reentry site shared by the bare-metal and pseries (nested)
> +	 * paths, so both are covered.
> +	 */

reduce this blob.

> +	r = kvm_xfer_to_guest_mode_handle_work(vcpu);
> +	if (r)	/* -EINTR: signal pending, exit to userspace (KVM_EXIT_INTR) */
> +		return r;
>   
>   	kvmppc_update_vpas(vcpu);
>   
> @@ -4914,9 +4951,14 @@ int kvmhv_run_single_vcpu(struct kvm_vcpu *vcpu, u64 time_limit,
>   
>   	vcpu->arch.state = KVMPPC_VCPU_RUNNABLE;
>   
> -	if (signal_pending(current))
> -		goto sigpend;
> -	if (need_resched() || !kvm->arch.mmu_ready)
> +	/*
> +	 * Final IRQs-disabled check for pending guest-mode work or an MMU that
> +	 * is not ready. IRQs are disabled here, so bail to the outer loop,
> +	 * which re-enters and handles the pending work via
> +	 * kvm_xfer_to_guest_mode_handle_work() above (exiting with -EINTR on a
> +	 * signal).
> +	 */
> +	if (xfer_to_guest_mode_work_pending() || !kvm->arch.mmu_ready)
>   		goto out;
>   
>   	vcpu->cpu = pcpu;
> @@ -5068,10 +5110,6 @@ int kvmhv_run_single_vcpu(struct kvm_vcpu *vcpu, u64 time_limit,
>   
>   	return vcpu->arch.ret;
>   
> - sigpend:
> -	vcpu->stat.signal_exits++;
> -	run->exit_reason = KVM_EXIT_INTR;
> -	vcpu->arch.ret = -EINTR;
>    out:
>   	vcpu->cpu = -1;
>   	vcpu->arch.thread_cpu = -1;
> diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
> index 00302399fc37..ff1a9a8de5e0 100644
> --- a/arch/powerpc/kvm/powerpc.c
> +++ b/arch/powerpc/kvm/powerpc.c
> @@ -84,20 +84,36 @@ int kvmppc_prepare_to_enter(struct kvm_vcpu *vcpu)
>   	hard_irq_disable();
>   
>   	while (true) {
> -		if (need_resched()) {
> +		if (__xfer_to_guest_mode_work_pending()) {
> +			/*
> +			 * Handle pending guest-mode work before entering the
> +			 * guest: reschedule, signals, and TIF_NOTIFY_RESUME
> +			 * task_work such as the deferred CFS bandwidth throttle.
> +			 * The helper must run with interrupts enabled and may
> +			 * schedule(). This is a superset of the open-coded
> +			 * need_resched()/signal_pending() checks it replaces. On
> +			 * a pending signal it returns -EINTR after
> +			 * kvm_xfer_to_guest_mode_handle_work() has set
> +			 * run->exit_reason (KVM_EXIT_INTR) and bumped
> +			 * vcpu->stat.signal_exits, so just return to userspace.
> +			 */

Make this comment precise instead of describing __xfer_to_guest_mode_work_pending

>   			local_irq_enable();
> -			cond_resched();
> +			r = kvm_xfer_to_guest_mode_handle_work(vcpu);
>   			hard_irq_disable();
> +			if (r) {
> +				/*
> +				 * -EINTR: the generic helper does not set the
> +				 * exit type, so record it here for the E500
> +				 * CONFIG_KVM_EXIT_TIMING histogram (a no-op
> +				 * otherwise). Only the exit type is set;
> +				 * signal_exits was already accounted above.
> +				 */
> +				kvmppc_set_exit_type(vcpu, SIGNAL_EXITS);
> +				break;
> +			}
>   			continue;
>   		}
>   
> -		if (signal_pending(current)) {
> -			kvmppc_account_exit(vcpu, SIGNAL_EXITS);
> -			vcpu->run->exit_reason = KVM_EXIT_INTR;
> -			r = -EINTR;
> -			break;
> -		}
> -
>   		vcpu->mode = IN_GUEST_MODE;
>   
>   		/*


