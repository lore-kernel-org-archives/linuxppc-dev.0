Return-Path: <linuxppc-dev+bounces-25985-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E654DC5DF81
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Aug 2026 17:46:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hQDWs2Rp7z2ygL;
	Thu, 20 Aug 2026 03:46:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787161577;
	cv=none; b=gHXc6Y+QF/FiBqNfHkAooYM0BTB1cyWC7NYWjw53MmklpntFIUGQo1LxhNANJvQ8gtRACoKoYEMWPGdba9wWRk5odTVbV2LnNfiq+FcifiAIVBB6YjetNiChB5vmUWlbJb1OOyPYLeMjnQCf2bOZAmVxGQF99bvBG7NFHigjeinhnIrnZ5Nlevv0CbyJ6iSWru25trkm9f1kzQNj//cFPelJ1q7RXkAmgKj6PKKQTItBKl6M3/pa30z160hKH+VgoRQi5CKJzxivvpQhPnXpTUUd6jidxhUg0RSEeqqnLzAr6V78e1cXV2NzCVyn8KyB9kJ04Rtj7AFpmfcTZmVchA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787161577; c=relaxed/relaxed;
	bh=DzqVhyptumsgVPFBzfP968AfP8hcKmWvp03n9RY0vSs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mZJRMAGaC3laLQ/kSXqPxHxeJyEVzQuNBrpByo3+iygYF1nnwuwmkpDq6kYsV/nxwXA7j94EmzXvinfM9bKFrqbltdTdLB4MB9B73f026F2EuRWGKS+4UZ9tcH1J5ZZlYY0wOAh/5xz7WdQVo8Wnv0fTgC/Ov5MhzoH/PyRyeKQpH/4pK5R1T8j3ftj/gPQ7xMDic5QNvG3eEYVeRkFmIGnlwbRApOFO9FB9B5HTi8jrPsNKPswRIXzHUf6YybuRWh1i4OBDfw7XtVAKgexdytPADxi0HalJN7O1Qg1Airzm9sRS1mzof+5Cge7x3BnXirz2a+2yPoHolvF2apS5ng==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=rBmaRB6s; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=anushree.mathur@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=rBmaRB6s;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=anushree.mathur@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hQDWr2Lxcz2yT0
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Aug 2026 03:46:16 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67JF1pDj3802082;
	Wed, 19 Aug 2026 17:46:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=DzqVhy
	ptumsgVPFBzfP968AfP8hcKmWvp03n9RY0vSs=; b=rBmaRB6sAqonr2fUyG1gp0
	4+8kKjp/WlUHwDpUXEPKacUR7Iu3F20lwupmku6BJzLBD5qIrjIrcfQ4kpezUNB1
	IjE6B+8BTcKX7EMp2Liy9Cg+RKlTJs3As3Vg8La2gsSXRGtTpGtfzBh8FVKFUm+z
	y4/TpJqW+zZpXq60hGms4k1maYXZz7kfzEQ+kO7yqkIb+3aDKauwUAghYLg1V5ID
	TBwTlKt1IvzLBxZRGE+6GPJpxg09/iJTJt3j+Lsj/L5XAwwRfBKWVTgcFwz5MhsY
	HBmJ/3aJghxYbkZQ8g2rVAjaYpUbN9B2d+0pPtahWrppEXyAfMzKxfGp/Yb3W+Zg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu0dby6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Aug 2026 17:46:08 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67JHfNpp029249;
	Wed, 19 Aug 2026 17:46:07 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g354yhwy4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Aug 2026 17:46:07 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67JHk5P014549618
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Aug 2026 17:46:06 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BDE1B5805D;
	Wed, 19 Aug 2026 17:46:05 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4FC0758057;
	Wed, 19 Aug 2026 17:46:03 +0000 (GMT)
Received: from [9.61.252.205] (unknown [9.61.252.205])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 19 Aug 2026 17:46:02 +0000 (GMT)
Message-ID: <8dd35d81-93b8-412d-81f3-82380f57f68d@linux.ibm.com>
Date: Wed, 19 Aug 2026 23:16:01 +0530
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
Subject: Re: [PATCH v2] KVM: PPC: Book3S HV: Don't drop pending doorbell
 across L2 entry
To: Vaibhav Jain <vaibhav@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
References: <20260812034628.1122115-1-vaibhav@linux.ibm.com>
Content-Language: en-US
From: Anushree Mathur <anushree.mathur@linux.ibm.com>
In-Reply-To: <20260812034628.1122115-1-vaibhav@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=MthiLWae c=1 sm=1 tr=0 ts=6a85ebe0 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=mXvVHTAJ997E8FGdE58A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 2yjIeJqpd8aRX0-n1dJL3FCXPNMoBL7V
X-Proofpoint-GUID: 2yjIeJqpd8aRX0-n1dJL3FCXPNMoBL7V
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDEzNiBTYWx0ZWRfXz/xSjLRlzrT/
 MXaxax3DTZUn8tpjWku6CbW3X+H6WYgT04WUVZg1sIrXj+BsTva58iaBAnVGceCIMkvCgTvfxel
 m6Fgb/EeKiQuhhdtiFeavAJHW/G7YPo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDEzNiBTYWx0ZWRfX4L5EYL2hQXyl
 g9yaJKO5Clsf1aJ/aZon8YNghlADCtBHIGCjioPFrxFegoC2HqkUr+jNsiE+0XJqAvRCmVy+X1f
 2Al3RY3E8fWfzJzkjTIa6DKDgm3o2hP3jSLkC99iTlaBDlCr2jOr87Q9IEB/gi45/KpTpiYXn5y
 mDmgjw1htcexsRul7Nkn2DS5Xer7PAz37Y6cKlbaqJftZpinibuQTsR5WI6ul4NJ8SvcAZ/oGMf
 CCVmFRDw1GKopPR8XDAsW96eW9s+otFHQp4sQyHTGFHs1tWrrWKQpOyd2g//iSEiUTl5h5pOSAF
 Z64oQRScTYnbe6qi23bHdeQyKR08Mbq7rBGMpr9kPNA8eP/Hfknbj/Ga3hvlc1SgS63cIBi7TKq
 SfUO5WOQ9cv2YdmobdsuaUQYZcpG98X9czYO2bnwtuTPrmHVS9lFZhPWZDrEb9kP9wYPsALNKm4
 788ltpCqGcFJMthMCuQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_04,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 bulkscore=0 phishscore=0 clxscore=1015
 spamscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190136



On 12/08/26 9:16 AM, Vaibhav Jain wrote:
> On nestedv2 the L1 converts a pending doorbell into guest DPDES state at
> the top of kvmhv_vcpu_entry_nestedv2() and immediately forgets about it:
>
> 	if (vcpu->arch.doorbell_request) {
> 		vcpu->arch.doorbell_request = 0;
> 		kvmppc_set_dpdes(vcpu, 1);
> 	}
>
> Clearing 'doorbell_request' at this point assumes that handing DPDES to the
> L0 is equivalent to the L2 having taken the doorbell. That is not true, and
> the doorbell can be lost in two ways:
>
>    - The block runs before the lazy_irq_pending() check, so the doorbell is
>      consumed even on the path that returns 0 without ever calling
>      H_GUEST_RUN_VCPU.
>
>    - DPDES stays pending in the L2 until it is actually delivered. The L2
>      may exit for an unrelated reason (hcall, page fault, HDEC) with the
>      doorbell still set, typically because it was running with MSR[EE]=0.
>      Nothing reloads DPDES afterwards, so the L1 never learns this.
>
> Once 'doorbell_request' has been cleared, the L1 has no record of the
> pending doorbell. kvmppc_doorbell_pending() returns false, so
> kvmppc_read_dpdes() reports the target thread as idle when a sibling vCPU
> emulates 'mfspr DPDES', and the vCPU can be treated as having no work
> pending and blocked. From the L2's point of view the doorbell is silently
> lost, which shows up as an SMT guest hanging on a doorbell-based IPI.
>
> Fix this by converting 'doorbell_request' to an atomic to track the L2's
> DPDES rather than being consumed by entry. This also enables new doorbells
> to be queued up on a vcpu while and active doorbell request is being
> handled.
>
> Since kvm_vcpu_arch 'doorbell_request' is also shared across APIv1 and
> Bare-Metal KVM infrastructure on PPC64, the patch also updates these
> paths to use kernel's 'atomic_t' helpers.
>
> With this following changes to kvmhv_vcpu_entry_nestedv2() code flow are
> done:
>
>    - inject DPDES after the early-return paths and before
>      kvmhv_nestedv2_flush_vcpu() serializes it into the vcpu run input
>      buffer, and no longer clear 'doorbell_request' there,
>
>    - after H_GUEST_RUN_VCPU, reload DPDES from the L0. The run output only
>      carries the state the L0 chose to return and the 'valids' bitmap is
>      zeroed on exit, so an explicit kvmhv_nestedv2_cached_reload() is
>      needed to see the L2's current value,
>
>    - if DPDES is still set the doorbell was not delivered, so keep
>      'doorbell_request' pending so that it is re-injected on the next
>      entry; otherwise clear it.
>
> This keeps a pending doorbell visible to the L1 for as long as the L2 has
> not consumed it, so vCPU wakeup and DPDES emulation on sibling vCPUs stay
> consistent with the L2's actual state.
>
> Testing
> =======
> This patch has been tested with continuous migration for a APIv2 KVM guest
> running stress-ng workload with lots of IPIs flying around, top of a
> PowerVM-LPAR and seems to work. Without the patch the migration loop used
> to eventually endup in KVM guest reporting lockups, which arent seen
> anymore with this patch.
>
> I haven't tested it yet with Bare-Metal nor APIv1 based PPC64 KVM
> guests. Will be able to share their results (Hopefully) in next version of
> this patch.
>
> Fixes: 54ec2bd9e017 ("KVM: PPC: Book3S HV nestedv2: Fix doorbell emulation")
> Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> Assisted-by: Claude:Opus-5
>
> ---
> Change-log:
> Since V1:
> https://lore.kernel.org/linuxppc-dev/20260803034426.44249-1-vaibhav@linux.ibm.com/T/#u
> * Address review comments around a typo [Shashiko]
> * Address a race condition which Shashiko had pointed to [Shashiko]
> * Updated the patch description and added test results
> * Refactored 'doorbell_request' to an 'atomic_t'
> * Updated code to use atomic_t helpers
> ---
>   arch/powerpc/include/asm/kvm_host.h   |  2 +-
>   arch/powerpc/kvm/book3s_hv.c          | 39 ++++++++++++++++-----------
>   arch/powerpc/kvm/book3s_hv_builtin.c  |  3 +--
>   arch/powerpc/kvm/book3s_hv_nested.c   |  9 ++++---
>   arch/powerpc/kvm/book3s_hv_p9_entry.c |  7 +++--
>   5 files changed, 34 insertions(+), 26 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
> index 2d139c807577..03fac7422aa2 100644
> --- a/arch/powerpc/include/asm/kvm_host.h
> +++ b/arch/powerpc/include/asm/kvm_host.h
> @@ -775,7 +775,7 @@ struct kvm_vcpu_arch {
>   	unsigned long pending_exceptions;
>   	u8 ceded;
>   	u8 prodded;
> -	u8 doorbell_request;
> +	atomic_t doorbell_request;
>   	u8 irq_pending; /* Used by XIVE to signal pending guest irqs */
>   	unsigned long last_inst;
>   
> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index 61dbeea317f3..fb80c13dbb29 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -15,6 +15,7 @@
>    * by Alexander Graf <agraf@suse.de>.
>    */
>   
> +#include "asm/guest-state-buffer.h"
>   #include <linux/kvm_host.h>
>   #include <linux/kernel.h>
>   #include <linux/err.h>
> @@ -881,7 +882,7 @@ static bool kvmppc_doorbell_pending(struct kvm_vcpu *vcpu)
>   	int thr;
>   	struct kvmppc_vcore *vc;
>   
> -	if (vcpu->arch.doorbell_request)
> +	if (atomic_read(&vcpu->arch.doorbell_request))
>   		return true;
>   	if (cpu_has_feature(CPU_FTR_ARCH_300))
>   		return false;
> @@ -1557,17 +1558,16 @@ static int kvmppc_emulate_doorbell_instr(struct kvm_vcpu *vcpu)
>   		tvcpu = kvmppc_find_vcpu(kvm, vcpu->vcpu_id - thr + arg);
>   		if (!tvcpu)
>   			break;
> -		if (!tvcpu->arch.doorbell_request) {
> -			tvcpu->arch.doorbell_request = 1;
> +		if (atomic_inc_return(&tvcpu->arch.doorbell_request) >= 1)
>   			kvmppc_fast_vcpu_kick_hv(tvcpu);
> -		}
>   		break;
>   	case OP_31_XOP_MSGCLRP:
>   		arg = kvmppc_get_gpr(vcpu, rb);
>   		if (((arg >> 27) & 0x1f) != PPC_DBELL_SERVER)
>   			break;
> -		vcpu->arch.vcore->dpdes = 0;
> -		vcpu->arch.doorbell_request = 0;
> +
> +		if (atomic_dec_return(&vcpu->arch.doorbell_request) <= 0)
> +			vcpu->arch.vcore->dpdes = 0;
>   		break;
>   	case OP_31_XOP_MFSPR:
>   		switch (get_sprn(inst)) {
> @@ -2313,7 +2313,7 @@ static int kvmppc_get_one_reg_hv(struct kvm_vcpu *vcpu, u64 id,
>   		 * On POWER8, doorbell_request is 0.
>   		 */
>   		if (cpu_has_feature(CPU_FTR_ARCH_300))
> -			*val = get_reg_val(id, vcpu->arch.doorbell_request);
> +			*val = get_reg_val(id, atomic_read(&vcpu->arch.doorbell_request));
>   		else
>   			*val = get_reg_val(id, vcpu->arch.vcore->dpdes);
>   		break;
> @@ -2565,7 +2565,7 @@ static int kvmppc_set_one_reg_hv(struct kvm_vcpu *vcpu, u64 id,
>   		break;
>   	case KVM_REG_PPC_DPDES:
>   		if (cpu_has_feature(CPU_FTR_ARCH_300))
> -			vcpu->arch.doorbell_request = set_reg_val(id, *val) & 1;
> +			atomic_inc(&vcpu->arch.doorbell_request);
>   		else
>   			vcpu->arch.vcore->dpdes = set_reg_val(id, *val);
>   		break;
> @@ -4253,10 +4253,6 @@ static int kvmhv_vcpu_entry_nestedv2(struct kvm_vcpu *vcpu, u64 time_limit,
>   	int trap;
>   	long rc;
>   
> -	if (vcpu->arch.doorbell_request) {
> -		vcpu->arch.doorbell_request = 0;
> -		kvmppc_set_dpdes(vcpu, 1);
> -	}
>   
>   	io = &vcpu->arch.nestedv2_io;
>   
> @@ -4265,6 +4261,10 @@ static int kvmhv_vcpu_entry_nestedv2(struct kvm_vcpu *vcpu, u64 time_limit,
>   	if (lazy_irq_pending())
>   		return 0;
>   
> +	/* Set DPDES if any doorbell is requested */
> +	if (atomic_read(&vcpu->arch.doorbell_request) > 0)
> +		kvmppc_set_dpdes(vcpu, 1);
> +
>   	rc = kvmhv_nestedv2_flush_vcpu(vcpu, time_limit);
>   	if (rc < 0)
>   		return -EINVAL;
> @@ -4298,6 +4298,17 @@ static int kvmhv_vcpu_entry_nestedv2(struct kvm_vcpu *vcpu, u64 time_limit,
>   
>   	timer_rearm_host_dec(*tb);
>   
> +	/* Check if privileged door bell was requested and handled */
> +	if (atomic_read(&vcpu->arch.doorbell_request) > 0) {
> +		/* In case PHYP doesn't return updated dpdes in output gsb */
> +		if (vcpu->arch.vcore->dpdes)
> +			kvmhv_nestedv2_cached_reload(vcpu,
> +						     KVMPPC_GSID_DPDES);
> +		/* if dpdes was handled then reduce the doorbell count */
> +		if (!vcpu->arch.vcore->dpdes)
> +			atomic_dec(&vcpu->arch.doorbell_request);
> +	}
> +
>   	/* Record context switch and guest_run_time data */
>   	if (kvmhv_get_l2_counters_status())
>   		do_trace_nested_cs_time(vcpu);
> @@ -4356,9 +4367,7 @@ static int kvmhv_vcpu_entry_p9_nested(struct kvm_vcpu *vcpu, u64 time_limit, uns
>   	 * enables us to receive doorbells when H_ENTER_NESTED is
>   	 * in progress for this vCPU
>   	 */
> -
> -	if (vcpu->arch.doorbell_request)
> -		vcpu->arch.doorbell_request = 0;
> +	atomic_set(&vcpu->arch.doorbell_request, 0);
>   
>   	/*
>   	 * When setting DEC, we must always deal with irq_work_raise
> diff --git a/arch/powerpc/kvm/book3s_hv_builtin.c b/arch/powerpc/kvm/book3s_hv_builtin.c
> index fa0e3a22cac0..76bda278cff9 100644
> --- a/arch/powerpc/kvm/book3s_hv_builtin.c
> +++ b/arch/powerpc/kvm/book3s_hv_builtin.c
> @@ -594,11 +594,10 @@ void kvmppc_guest_entry_inject_int(struct kvm_vcpu *vcpu)
>   		}
>   	}
>   
> -	if (vcpu->arch.doorbell_request) {
> +	if (atomic_dec_if_positive(&vcpu->arch.doorbell_request) >= 0) {
>   		mtspr(SPRN_DPDES, 1);
>   		vcpu->arch.vcore->dpdes = 1;
>   		smp_wmb();
> -		vcpu->arch.doorbell_request = 0;
>   	}
>   }
>   
> diff --git a/arch/powerpc/kvm/book3s_hv_nested.c b/arch/powerpc/kvm/book3s_hv_nested.c
> index 22e616662255..cc81089b2bcd 100644
> --- a/arch/powerpc/kvm/book3s_hv_nested.c
> +++ b/arch/powerpc/kvm/book3s_hv_nested.c
> @@ -32,7 +32,7 @@ void kvmhv_save_hv_regs(struct kvm_vcpu *vcpu, struct hv_guest_state *hr)
>   	struct kvmppc_vcore *vc = vcpu->arch.vcore;
>   
>   	hr->pcr = vc->pcr | PCR_MASK;
> -	hr->dpdes = vcpu->arch.doorbell_request;
> +	hr->dpdes = atomic_read(&vcpu->arch.doorbell_request);
>   	hr->hfscr = vcpu->arch.hfscr;
>   	hr->tb_offset = vc->tb_offset;
>   	hr->dawr0 = vcpu->arch.dawr0;
> @@ -105,7 +105,7 @@ static void save_hv_return_state(struct kvm_vcpu *vcpu,
>   {
>   	struct kvmppc_vcore *vc = vcpu->arch.vcore;
>   
> -	hr->dpdes = vcpu->arch.doorbell_request;
> +	hr->dpdes = atomic_read(&vcpu->arch.doorbell_request);
>   	hr->purr = vcpu->arch.purr;
>   	hr->spurr = vcpu->arch.spurr;
>   	hr->ic = vcpu->arch.ic;
> @@ -143,7 +143,7 @@ static void restore_hv_regs(struct kvm_vcpu *vcpu, const struct hv_guest_state *
>   	struct kvmppc_vcore *vc = vcpu->arch.vcore;
>   
>   	vc->pcr = hr->pcr | PCR_MASK;
> -	vcpu->arch.doorbell_request = hr->dpdes;
> +	atomic_set(&vcpu->arch.doorbell_request, hr->dpdes);
>   	vcpu->arch.hfscr = hr->hfscr;
>   	vcpu->arch.dawr0 = hr->dawr0;
>   	vcpu->arch.dawrx0 = hr->dawrx0;
> @@ -176,7 +176,8 @@ void kvmhv_restore_hv_return_state(struct kvm_vcpu *vcpu,
>   	 *   a) Sent after H_ENTER_NESTED was called on this vCPU (arch.doorbell_request would be 1)
>   	 *   b) Doorbell was not handled and L2 exited for some other reason (hr->dpdes would be 1)
>   	 */
> -	vcpu->arch.doorbell_request = vcpu->arch.doorbell_request | hr->dpdes;
> +	if (hr->dpdes)
> +		atomic_inc(&vcpu->arch.doorbell_request);
>   	vcpu->arch.hfscr = hr->hfscr;
>   	vcpu->arch.purr = hr->purr;
>   	vcpu->arch.spurr = hr->spurr;
> diff --git a/arch/powerpc/kvm/book3s_hv_p9_entry.c b/arch/powerpc/kvm/book3s_hv_p9_entry.c
> index 34bc0a8a1288..fc44d8aa7a6a 100644
> --- a/arch/powerpc/kvm/book3s_hv_p9_entry.c
> +++ b/arch/powerpc/kvm/book3s_hv_p9_entry.c
> @@ -610,10 +610,9 @@ int kvmhv_vcpu_entry_p9(struct kvm_vcpu *vcpu, u64 time_limit, unsigned long lpc
>   
>   	if (vc->pcr)
>   		mtspr(SPRN_PCR, vc->pcr | PCR_MASK);
> -	if (vcpu->arch.doorbell_request) {
> -		vcpu->arch.doorbell_request = 0;
> +
> +	if (atomic_dec_if_positive(&vcpu->arch.doorbell_request) >= 0)
>   		mtspr(SPRN_DPDES, 1);
> -	}
>   
>   	if (dawr_enabled()) {
>   		if (vcpu->arch.dawr0 != host_dawr0)
> @@ -838,7 +837,7 @@ int kvmhv_vcpu_entry_p9(struct kvm_vcpu *vcpu, u64 time_limit, unsigned long lpc
>   
>   	dpdes = mfspr(SPRN_DPDES);
>   	if (dpdes)
> -		vcpu->arch.doorbell_request = 1;
> +		atomic_inc(&vcpu->arch.doorbell_request);
>   
>   	vc->vtb = mfspr(SPRN_VTB);
>   
Hi Vaibhav,

I have tested this v2 patch and it is still giving me the issue I 
reported, so here is my analysis:

a) Without applying the patch :

1) Start the guest and run stress-ng as below for sometime
localhost:~ # stress-ng --cpu 4 --vm 2 --vm-bytes 1G --hdd 2 --hdd-bytes 
1G --sched other --timeout 3600000s
stress-ng: info:  [1464] setting to a 41 days, 16 hours, 0 secs run per 
stressor
stress-ng: info:  [1464] dispatching hogs: 4 cpu, 2 vm, 2 hdd



2) Start the migration from H1 to H2:

ltc-lp7:~ # virsh migrate --live --domain sles16_anu 
qemu+ssh://10.xx.xx.xx/system --verbose --undefinesource --persistent 
--auto-converge --postcopy
(root@10.xx.xx.xx) Password:
Migration: [100.00 %]

3) Migration got completed but guest is not getting recovered from 
continuous softlockups

[ 1336.003836][    C1] watchdog: BUG: soft lockup - CPU#1 stuck for 
977s! [htxd_monitor:1337]
[ 1336.006834][    C4] watchdog: BUG: soft lockup - CPU#4 stuck for 
1002s! [rcu_exp_par_gp_:19]
[ 1346.015839][    C0] BUG: workqueue lockup - pool cpus=1 node=0 
flags=0x0 nice=0 stuck for 1090s!
[ 1346.016355][    C0] BUG: workqueue lockup - pool cpus=3 node=0 
flags=0x0 nice=0 stuck for 1107s!
[ 1346.016874][    C0] BUG: workqueue lockup - pool cpus=7 node=0 
flags=0x0 nice=0 stuck for 1093s!
[ 1356.007835][    C6] watchdog: BUG: soft lockup - CPU#6 stuck for 
912s! [systemd:1353]
[ 1356.008835][    C7] watchdog: BUG: soft lockup - CPU#7 stuck for 
998s! [systemd-journal:570]
[ 1360.003836][    C1] watchdog: BUG: soft lockup - CPU#1 stuck for 
999s! [htxd_monitor:1337]
[ 1360.006834][    C4] watchdog: BUG: soft lockup - CPU#4 stuck for 
1024s! [rcu_exp_par_gp_:19]
[ 1368.933835][    C4] rcu: INFO: rcu_preempt self-detected stall on CPU
[ 1368.933973][    C4] rcu:     4-....: (1129830 ticks this GP) 
idle=afc4/1/0x4000000000000002 softirq=3694/428556 fqs=259639
[ 1368.934106][    C4] rcu:              hardirqs   softirqs  csw/system
[ 1368.934188][    C4] rcu:      number:        1     444039 0
[ 1368.934271][    C4] rcu:     cputime:        3          8 1096165  
  ==> 1110021(ms)
[ 1368.934373][    C4] rcu:     (t=1140022 jiffies g=6177 q=1684 ncpus=8)
[ 1376.224839][    C0] BUG: workqueue lockup - pool cpus=1 node=0 
flags=0x0 nice=0 stuck for 1120s!
[ 1376.225307][    C0] BUG: workqueue lockup - pool cpus=3 node=0 
flags=0x0 nice=0 stuck for 1138s!
[ 1376.225428][    C0] BUG: workqueue lockup - pool cpus=5 node=0 
flags=0x0 nice=0 stuck for 715s!
[ 1376.225548][    C0] BUG: workqueue lockup - pool cpus=6 node=0 
flags=0x0 nice=0 stuck for 1027s!
[ 1376.225667][    C0] BUG: workqueue lockup - pool cpus=7 node=0 
flags=0x0 nice=0 stuck for 1123s!
[ 1444.006835][    C4] watchdog: BUG: soft lockup - CPU#4 stuck for 
1100s! [rcu_exp_par_gp_:19]


b) Even after applying the patch also it is giving same softlockup issue 
as mentioned above:
Though I have enough vcpus and memory on the guest (16 vcpus , 13Gi of 
memory)  and ample amount of memory and cpus
present on host still these softlockups are happening after applying the 
patch too. I tried reducing stress also on the guest
but still this issue is seen.

stress-ng --cpu 4 --vm 2 --vm-bytes 1G --hdd 2 --hdd-bytes 1G --sched 
other --timeout 3600000s

If you are planning to send next version of this patch,
Please do add my reported-by:
Reported-by: Anushree Mathur <anushree.mathur@linux.ibm.com>

