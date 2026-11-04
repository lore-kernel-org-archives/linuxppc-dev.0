Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E792606D825
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Nov 2026 17:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=DjXlxgd5
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKXf70wM2z2xnQ;
	Thu, 05 Nov 2026 04:35:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793813743;
	cv=none; b=bATQ0RXR/+XwUIerQSlTGMRvi+upDn2I45miHN2VVx0S+F0Slg9O93wWbTV8iPMH0obxQJApEDbn62vfk/pSf9ggzfyDWM5I2/cc7vOFaM/VCMjiiMbfeD2JBWPhM2MQD14o1INMQiAiqixhZskGc7vSHLKpKSzsMDrhVv3VPiW+niSuBtRUA/MEtryyVzFh79ROKzGgAZ91qeuxjH54KZuFHW3dLYvmJfanEOJ8l+EInDewRW9DdRF7/Y9B4NOdBuxiF+d5HXn8HxGcSC3da2ktD/FuUq8ZN2aiV0ngyI/82pdl1o5n3iAhYIUghnObn7Wah6qhm1/8omFTdivBUA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793813743; c=relaxed/relaxed;
	bh=m06/Z+wSj59Lj3STeXezEGxBP0eygnMgmS4pExrvRFg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SmUzj414f+Q0+4g+p2AICc/OuCtkKI1lQWjcQNlNUXFBt6wPw2s0T1STCEtxY7gh33iEhxDHejY/LSld8MYUFogAAxAHYBIyIzFIFs5lSZW9n2ui9weGx2e2LqtmlFU/KO4nZ2Uuy1t+A//9CLiTGykMIZ5hYbagLON/49uTewLu2VkSCVP/GoDtrMTLp82LfeXdlPICI4SPEBdeUvHJuNGnd9zaV8KK7rKZkJHE45ea9/tVcdk3emzzdhC2r3jHO8Gy6gOcyfItUf+WXqW8KCRsbwEmcECNSlZSM4/7K1Ph1rLts7btYd7sl7l/ltTilOBddUvryJ3M7qQ+u4wGcQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=DjXlxgd5; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=DjXlxgd5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKXf62M1Gz2xlk
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 04:35:42 +1100 (AEDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A4FiAJD966810;
	Wed, 4 Nov 2026 17:35:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=m06/Z+
	wSj59Lj3STeXezEGxBP0eygnMgmS4pExrvRFg=; b=DjXlxgd5MWc41a4+sgXoZu
	8todMlWfwXpkdM30W1AmcMbcIhlJc0MAgdISIE7vh2Mlf7rBM+7QePhUzJaolCIy
	2lCJiaCGz/sht0YqGR4voYiVJTQUJqK7Vo26tjJfzcj3eQJblZFOInADce2O6XoN
	cTSzb50Dj8/pjd79lmZoSz8OFnbcl5zjsyT9EVbqEQGrxKNM2o4V7caIMbzGt3ny
	egxPiZ947dWQ6bHOVI925c8f+grOsfqaZkSRampTf6UfwxVUE0iTLgzpabGCjhCJ
	TafzDNhqUBlu/+Hmvw+sclQFUWzj6tsTxWSTJ9DN1awcNbmDHYf1CoJMAo0n312g
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn7ys4yvp-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 04 Nov 2026 17:35:37 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A4Fnxva204445;
	Wed, 4 Nov 2026 17:35:36 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hqf0geskx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Nov 2026 17:35:36 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A4HZY9W52560158
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 4 Nov 2026 17:35:34 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1E8802004D;
	Wed,  4 Nov 2026 17:35:34 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C8FCA20040;
	Wed,  4 Nov 2026 17:35:31 +0000 (GMT)
Received: from [9.39.27.115] (unknown [9.39.27.115])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  4 Nov 2026 17:35:31 +0000 (GMT)
Message-ID: <54afe357-b6f0-4d72-a2eb-474087aa880c@linux.ibm.com>
Date: Wed, 4 Nov 2026 23:05:30 +0530
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/23] KVM: PPC: Flush/zap all memslots on
 kvm_arch_flush_shadow_all()
To: Sean Christopherson <seanjc@google.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jim Mattson <jmattson@google.com>,
        James Houghton <jthoughton@google.com>, Chris Mason <mason@kernel.org>
References: <20261030212112.2598640-1-seanjc@google.com>
 <20261030212112.2598640-4-seanjc@google.com>
 <5bd7e8e9-3614-4006-a3d7-a51416ba5507@linux.ibm.com>
 <ausz4VZWa_4Vr03v@google.com>
Content-Language: en-US
From: Narayana Murty N <nnmlinux@linux.ibm.com>
In-Reply-To: <ausz4VZWa_4Vr03v@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=Mcr5KJ/f c=1 sm=1 tr=0 ts=6aeb6ce9 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=1XWaLZrsAAAA:8 a=6Y2wuOs38zrcC-dcLCAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA2OCBTYWx0ZWRfX6zr4fUBHmFzo
 xy+p4saVE8hRJAQb0i89tY29WU0L7JKvwsHhtRfT/ReA/vC8wvXYN+z3T/b7EZw+FkAduyVF9FI
 15ZYGrzyDLVkU+IIlAG7ofbdzBbxEl4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA2OCBTYWx0ZWRfX2oXXojsH1RnK
 DJlJ1/FLSJwZicC1aLKjh1HDAayBinpqsb+pXCc3B0eotXovHOjGKjrYrxaZuqaHmuKBvsj/HYC
 btwqXGZ7x6V02Yb8vThO2rHX5tzmQpqAiqPi+ZjZsyXMMy5UPqRMjxKaVrYzjS5UVc4vcbz3Xix
 iRLXpFpGURIqtFaZZYV7TQgED+HEjFQXAkqFt3hd9JFwFjs9zUdpszo83T6BcZRr9QvehjaNmlf
 NyI35HrHmqqd37dk3aGXGC4SleZN+BFbHYy1EYtlRRzuReRvNvuz2VxRDKegruQnWUHS4YkOZoa
 XS8/BxNMLZ0uLZQbsQNLNEygsaV6r7AKiCDzxW0QV8m08IU5BxTIQnwzRg333CYeCS+E/OAc4Fx
 RBjWFppagwUyLMHqEXt3P0Cr4YrytOu+qZ+ZjIJx3q3tyPres1mFz/ftuANsz4uQZDa1sG0LCqW
 dw2JPcagYbnG+fZBNQA==
X-Proofpoint-GUID: la8gAgS5o34WXMxf9_vSgnP6iEte2qja
X-Proofpoint-ORIG-GUID: udZeEeBj7KLIqpRh3DUf2gkqGXZD_-8L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_05,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611040068
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Thanks Sean,

On 04/11/26 7:02 PM, Sean Christopherson wrote:
> On Wed, Nov 04, 2026, Narayana Murty N wrote:
>> Hi Sean,
>>
>> On 31/10/26 2:50 AM, Sean Christopherson wrote:
>>> Flush/zap every memslot in kvm_arch_flush_shadow_all(), i.e. when the
>>> owning userspace process is exiting, as KVM must ensure all associated
>>> memory is unmapped from the guest.
>>>
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Sean Christopherson <seanjc@google.com>
>>> ---
>>>    arch/powerpc/include/asm/kvm_host.h |  1 -
>>>    arch/powerpc/kvm/powerpc.c          | 11 +++++++++++
>>>    2 files changed, 11 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
>>> index 708a32f89776..50a42f80e5f1 100644
>>> --- a/arch/powerpc/include/asm/kvm_host.h
>>> +++ b/arch/powerpc/include/asm/kvm_host.h
>>> @@ -910,7 +910,6 @@ struct kvm_vcpu_arch {
>>>    #define __KVM_HAVE_CREATE_DEVICE
>>>    static inline void kvm_arch_memslots_updated(struct kvm *kvm, u64 gen) {}
>>> -static inline void kvm_arch_flush_shadow_all(struct kvm *kvm) {}
>>>    static inline void kvm_arch_vcpu_blocking(struct kvm_vcpu *vcpu) {}
>>>    static inline void kvm_arch_vcpu_unblocking(struct kvm_vcpu *vcpu) {}
>>> diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
>>> index 9194cf492d1c..9e9d0865c2f6 100644
>>> --- a/arch/powerpc/kvm/powerpc.c
>>> +++ b/arch/powerpc/kvm/powerpc.c
>>> @@ -764,6 +764,17 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
>>>    	kvmppc_core_commit_memory_region(kvm, old, new, change);
>>>    }
>>> +void kvm_arch_flush_shadow_all(struct kvm *kvm)
>>> +{
>>> +	struct kvm_memory_slot *slot;
>>> +	struct kvm_memslots *slots;
>>> +	int bkt;
>>> +
>>> +	slots = kvm_memslots(kvm);
>>> +	kvm_for_each_memslot(slot, bkt, slots)
>>> +		kvmppc_core_flush_memslot(kvm, slot);
>>
>> For Book3S HV/hash, I am not sure the existing flush_memslot helper can
>> be used on an active memslot like this.
>>
>> The normal memslot invalidation path seems to deliberately establish
>> the opposite ordering.  kvm_invalidate_memslot() first installs an
>> INVALID slot and makes it active:
>>
>> 	invalid_slot->flags |= KVM_MEMSLOT_INVALID;
>> 	kvm_replace_memslot(kvm, old, invalid_slot);
>> 	kvm_swap_active_memslots(kvm, old->as_id);
>> and only then does kvm_arch_flush_shadow_memslot(kvm, old);.
>>
>> The comment there explicitly states:
>> /*
>>   * From this point no new shadow pages pointing to a deleted,
>>   * or moved, memslot will be created.
>>   */
>>
>> Similarly, kvmppc_core_flush_memslot_hv() in
>> arch/powerpc/kvm/book3s_64_mmu_hv.c relies on the memslot already being
>> invalid when testing KVMPPC_RMAP_PRESENT without locking, as no new HPTEs
>> can be created.
>>
>> However, kvm_arch_flush_shadow_all() in arch/powerpc/kvm/powerpc.c now
>> invokes the same helper while walking active memslots.
>>
>> Is there any serialization in the mmu_notifier.release() path that provides
>> the same guarantee against new HPTE creation?
> 
> There can't be any outstanding *usable* references to vCPUs at this point.
> mmu_notifier.release() is only invoked if the process is exiting or the VM is
> dying (which requires the associated file to have been released).
> 
> If the process is existing, KVM_RUN (and most ioctls) are unreachable due to the
> "dev->kvm->mm != current->mm" checks.  Not to mention that if the process is
> exiting, doing anything with a memslot is completely broken because it means
> things like hva_to_pfn() are somehow operating on the wrong mm.
> 
> If the VM is dying, there can't be any references to vCPU FDs, because each vCPU
> holds a reference to the VM.
That makes sense.

I was considering the normal memslot invalidation path, where vCPUs
can still be running, and overlooked the lifecycle guarantees of
mmu_notifier.release().

Given that KVM_RUN cannot be invoked once the owning mm is gone, and
that VM destruction requires all vCPU references to be dropped, there
should be no path to create new HPTEs while the flush is in progress.

That addresses my concern about the unlocked rmap check.

Thanks,
Narayana.>
>> Otherwise, couldn't an H_ENTER or fault path create a new HPTE while the
>> rmap is being scanned, or after it has already been examined?


