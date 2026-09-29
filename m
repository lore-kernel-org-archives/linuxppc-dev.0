Return-Path: <linuxppc-dev+bounces-28468-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1797CA5FA1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Sep 2026 08:31:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hvBH80WS9z2yvy;
	Tue, 29 Sep 2026 18:31:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790670708;
	cv=none; b=Oajg7JMnifLIstVuIuqbWQjyBhebirdOi5kctoGVdHd6NJUukCrm/DQRqcwYkEfIC5b4jA7vzndm6J/1ldFGMObogdeTkhw262x01ZviKBlw6N7PAnMWs0Ixnq9ZOV0a12WL6XUAHHmGIkcagr4VjMjTlq9aNpL9xnDh8PmV+y42SoIeWaavIfT81D1/IqMeP4tzBU32M6Z1IjKvcoFMw5Yv98VrkVTBAzlauIGxFrQZno2bZYevIvRI49rNIy9oepHtsel4C6fa15qjDZwV/XgyplabdFYULaSGGb+2qS7wGER4/tqUeel4RIodIqK797AGHaE/UNXEqYeBx43zJA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790670708; c=relaxed/relaxed;
	bh=gxwwGHW4ohco8fUWvvnSOWi6ZbLEKy39PRTDGYvP9eY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mIVhOSpEYXN5V4YJ5rIkciZTpq3W9xC92Sij+5w3kPX4pBu7J7P2TRKaXqiJdzrhSrhthKl2mxBRBTCklWTE69V/2Ks/+w2bnlomSbwaQq9FLLQLFIg42MeeGIga7l36C9+Qcu3pOe0IeFoYHWWZ30SZpdiGF/Bu+/W+yBXYiRu9EwhHXBTLhHx4kYJljd7fmL4mgRhjSK6nflSXxvVo+1/yL7Pg1wKPbD1EwD8sWOv8gXCjBZ50/n6HbwkE7LukcVoJ5BEL3PN4rGgKWijIUpKLgx48F+UNaJOs+G4pZwZe5BBDwHvLqMtdsqY0FCkZXBfAg/SzcUQG0wBD5OaiSg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=WUfSCm5Z; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=WUfSCm5Z;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hvBH70T28z2xwZ
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2026 18:31:46 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68T46Fjx3076251;
	Tue, 29 Sep 2026 06:18:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=gxwwGH
	W4ohco8fUWvvnSOWi6ZbLEKy39PRTDGYvP9eY=; b=WUfSCm5ZBPEEVGpzTop0ZK
	jHYLrGmBVGc60X9Vpp6/whAHOibosrw2eg3/f2oBdjWhYH0dflYQrHKOZ5QOZdQQ
	fDyyYChEG9gDZ9zOdg0bifiAHNGoC5hWL50JN6DPF0Joa+kb+OxiOhyXF0lTN0CG
	YsSZuxMPaQ87eNyheDddCTZqHDQh4i1E2ULVHzuyhLL7UvxSwi+TtPt5cPIdrxUZ
	lO6IcZ0/RwaGjL49p1Y+QtF1KEn0YYWjRqBpaa8U4dkr8UGmGI3Qn9f/1FG0eVPP
	GYWivTwu0TQguFS01XlFCn1OIeVDQP30N4CQ8Uk4jKaHNIXsF3T8wxIotFUoGDSQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5j55ksb-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 29 Sep 2026 06:18:34 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68T4I45d1188915;
	Tue, 29 Sep 2026 06:18:34 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gxsvhgf3s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Sep 2026 06:18:33 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68T6ITq955968178
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Sep 2026 06:18:29 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B288C20043;
	Tue, 29 Sep 2026 06:18:29 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A8AC920040;
	Tue, 29 Sep 2026 06:18:25 +0000 (GMT)
Received: from [9.39.19.220] (unknown [9.39.19.220])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 29 Sep 2026 06:18:25 +0000 (GMT)
Message-ID: <57f589e4-b7cc-43d1-8d02-732d10118833@linux.ibm.com>
Date: Tue, 29 Sep 2026 11:48:24 +0530
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
Subject: Re: [RESEND PATCH 2/3] KVM: PPC: Book3S HV: Add preempt_disable()
 around virtual-mode HPTE bit-lock users
To: Amit Machhiwal <amachhiw@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman
 <mpe@ellerman.id.au>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        kvm-ppc@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Gautam Menghani <gautam@linux.ibm.com>,
        Harsh Prateek Bora <harshpb@linux.ibm.com>,
        R Nageswara Sastry <rnsastry@linux.ibm.com>,
        Alexander Graf <agraf@suse.de>, linux-hardening@vger.kernel.org,
        stable@vger.kernel.org, Avi Kivity <avi@redhat.com>
References: <20260928122837.8782-1-amachhiw@linux.ibm.com>
 <20260928122837.8782-3-amachhiw@linux.ibm.com>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <20260928122837.8782-3-amachhiw@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAyNCBTYWx0ZWRfX42I98ld1xBiT
 vcY5SI3mXT7NieF6LRXrO+LW8l9/xZbMcFORk/bebdDbwf7TuUddxX4c6a0UY4mGXDFbKBPuQn3
 HbYeAtvkJWneCoi4SQCSBRZji3hYcW0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAyNCBTYWx0ZWRfX6+jvuXh4Gy8t
 0IwRg0Ro1iENk0ogQzrL7MmiggU5wNARi7TnlOnYOqz7JAf75JLoSUd9/FUvuFUjiRbgpgafkjg
 fNF3iyZPsy4xW+aBdx/oie4C7BqqhpIcgGdnUBVkD0eYLxGgSA1IWRLpSssGk770ciXN1QDtqPy
 ePOz0WKk+iSl2qjag8T1Km+S6i/Bhk+gSAI4vRYwK4SUAWRZX9WSZZC6VrhoolXvYIGoHzJgjVB
 BgWhMNhBvdiDJGIBREhEjDb16ZupQYZxjjjBE9Z2T808/McRZTo9YsDDIM8QgRBzdLSYbQxxzI+
 WQRnR8Trfxy9D/cfDE1M0Hw27pGo0Ca1IYeKvnDgGDrnm9qCzIWYBhw01pY+zew+I5fOfMEysd/
 YubhVKS2Dd/yNXPdRy2Na+5S3551TqKT2tIbPhr/Sl5zAufy3OcFZCUYpR/qwQ5TVSqFkbiFIUD
 7YOEPaAI8UER+tvo87A==
X-Proofpoint-GUID: 59RRqs0-XAtym-ija4o2oJ5tEqrHS25i
X-Authority-Analysis: v=2.4 cv=RKcmjIi+ c=1 sm=1 tr=0 ts=6abb583b cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=c92rfblmAAAA:8
 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=TyTmfrqmqWBwd8b7ElYA:9 a=QEXdDO2ut3YA:10
 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-ORIG-GUID: ZvCRJwPSFiwqoE5BYJ4DQ09r_vyx-q-l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290024



On 9/28/26 5:58 PM, Amit Machhiwal wrote:
> kvmppc_hv_find_lock_hpte() requires virtual-mode callers to run with
> preemption disabled, because it can return with HPTE_V_HVLOCK still held
> until the caller later unlocks the HPTE.  Existing virtual-mode callers
> in book3s_64_mmu_hv.c already follow that rule.
> 
> Two virtual-mode call paths do not:
> 
> 1. kvmppc_handle_exit_hv() calls kvmppc_hpte_hv_fault() for hash-mode
>     data-side and instruction-side faults after guest exit, with
>     preemption already enabled.  kvmppc_hpte_hv_fault() calls
>     kvmppc_hv_find_lock_hpte() directly.
> 
> 2. kvmppc_pseries_do_hcall() executes virtual-mode handlers for HPT
>     hcalls via kvmppc_pseries_do_hpt_hcall() with preemption enabled.
>     The handlers for H_ENTER, H_REMOVE, H_READ, H_CLEAR_MOD, H_CLEAR_REF,
>     H_PROTECT, and H_BULK_REMOVE spin on try_lock_hpte() or lock_rmap(),
>     and H_ENTER also reaches kvmppc_do_h_enter(), which uses
>     arch_spin_lock() on kvm->mmu_lock.  That raw lock choice is
>     intentional because kvmppc_do_h_enter() is also used by real-mode
>     callers, so the correct fix is to establish the proper preemption
>     context at the virtual-mode caller boundary.
> 
> If a vCPU thread is preempted while holding HPTE_V_HVLOCK, any other
> thread on the same CPU trying to acquire the same bit-lock can spin
> indefinitely.  The same applies to lock_rmap() users and to the H_ENTER
> path while holding the raw mmu_lock.
> 
> Fix this by adding preempt_disable()/preempt_enable() pairs around the
> two kvmppc_hpte_hv_fault() call sites in kvmppc_handle_exit_hv(), and
> around the kvmppc_pseries_do_hpt_hcall() invocation in
> kvmppc_pseries_do_hcall().  Targeting only the HPT hcall helper avoids
> wrapping non-HPT hcalls (such as H_RTAS, H_CONFER, H_REGISTER_VPA) that
> perform page faults, blocking memory allocations, or context switches.
> 
> Fixes: 6165d5dd99db ("KVM: PPC: Book3S HV: add virtual mode handlers for HPT hcalls and page faults")
> Cc: stable@vger.kernel.org # v5.14+
> Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> ---
>   arch/powerpc/kvm/book3s_hv.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index aa51968e206a..52f72f30baf0 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -1212,9 +1212,11 @@ int kvmppc_pseries_do_hcall(struct kvm_vcpu *vcpu)
>   	case H_CLEAR_REF:
>   	case H_PROTECT:
>   	case H_BULK_REMOVE:
> +		preempt_disable();
>   		idx = srcu_read_lock(&kvm->srcu);

Please add a comment above kvmppc_pseries_do_hpt_hcall, saying preemption
is disabled and one cannot make any blocking call.

>   		ret = kvmppc_pseries_do_hpt_hcall(vcpu, req);
>   		srcu_read_unlock(&kvm->srcu, idx);
> +		preempt_enable();
>   		if (ret == H_TOO_HARD)
>   			return RESUME_HOST;
>   		break;
> @@ -1834,8 +1836,10 @@ static int kvmppc_handle_exit_hv(struct kvm_vcpu *vcpu,
>   		else
>   			vsid = vcpu->arch.fault_gpa;
>   
> +		preempt_disable();
>   		err = kvmppc_hpte_hv_fault(vcpu, vcpu->arch.fault_dar,
>   				vsid, vcpu->arch.fault_dsisr, true);
> +		preempt_enable();
>   		if (err == 0) {
>   			r = RESUME_GUEST;
>   		} else if (err == -1 || err == -2) {
> @@ -1881,8 +1885,10 @@ static int kvmppc_handle_exit_hv(struct kvm_vcpu *vcpu,
>   		else
>   			vsid = vcpu->arch.fault_gpa;
>   
> +		preempt_disable();
>   		err = kvmppc_hpte_hv_fault(vcpu, vcpu->arch.fault_dar,
>   				vsid, vcpu->arch.fault_dsisr, false);
> +		preempt_enable();
>   		if (err == 0) {
>   			r = RESUME_GUEST;
>   		} else if (err == -1) {

Please check if below is possible case.

https://sashiko.dev/#/patchset/20260928113704.48912-4-amachhiw%40linux.ibm.com

