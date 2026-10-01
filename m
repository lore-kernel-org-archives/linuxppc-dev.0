Return-Path: <linuxppc-dev+bounces-28645-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C147CA5FCB
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Oct 2026 11:54:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hwVgl20Rsz2yTQ;
	Thu, 01 Oct 2026 21:54:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790855651;
	cv=none; b=Co4hBt/uyKdMzO+tMbNWyZELyetXv516edygMHt2KpLGts+/u8ZV2fIqh1Ufm4I+Myt1bXei8QCE9p7caOL5qRYo2u6yKQ0obMkGOs2k8vx+lm1XPnB6Yu5aH6YZsX5ryHOlG5qLArlHXXaiM/A/ZfloD9oaupZfx0KTAHxE8HAqqTiKJB5geoUnezLxuktIbMxq+0NJD8tsRWeXRx+2GHSTZs+U5dQAsWK8CLfGGbq+Hu8kGG1LSv0m/1S7GO3QuCTGixgunPTLFus4fAbqBvtxIusdotvC+gKZIFuiK5FoZZz1+G6u/dFJx2WdVoDIeHfrrcpeqCpw6p2IlvFiMA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790855651; c=relaxed/relaxed;
	bh=AM5/kkiDnPkkN007F7bZwVMu40gWfmJpauZ1LAygkmk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FUOWV1Vesh8klu3VHhdgxo9nv/RAMgpX7TB73C0TWK1/QUpfTW+itnegY2wi0quzLk6vvZ2F2dRU4nbDUpb+U3cgdknuB6Bv8qfs4sRSCOjVLRfmU1pZHkv969hvE4fH2/vaJsrSpMr1EluRtWOnkz7IspHVyKBJiQPQVbQD3wKoCnyMpyKKY/y70K1+PjCvHC4QrKg4UOJNRSVF6M+VW/opn1cafXqwbyotU6QHcUcL2qrzh+41lB6qrjbDX1eqzI2tdXUy6qHAAeSqj99nIsJq6M8r1QcxX3mGL716vkFREPaoPAoBcMw33GqUZOgA5yHpPkV1Dqb+4TGNproAIA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=jb/1o05v; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=jb/1o05v;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hwVgj5226z2y2Z
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Oct 2026 21:54:09 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69175eBK1119381;
	Thu, 1 Oct 2026 11:53:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=AM5/kk
	iDnPkkN007F7bZwVMu40gWfmJpauZ1LAygkmk=; b=jb/1o05vfyTKYeEL4WVrWr
	5iIr8CTmrc8TMrdulN0f8L6z630IWQIGEyvagjKhcxBhDqKj9RLu2eF4xO7ySHMr
	aP7/3vYxluS2GVNH9PA+oUzEVmm2pnZoqoSKWl501VnY3Uz30JLAlFeZtS7vqRBb
	1KMXg7p05OtTWLZ65pvNoPQCX9CoHWOA0G1/H7I45gcWmlIIUI5tXtKF2IzB8u9y
	vW1DLgWOvYtQEHAVjwk9hDiq2RVifXcUQV1/QYgEH4vtWkhQfv8WzhEiHjyAO7vM
	012UXKOMAV5utE0xpZwEt54W8cbHjO5cuQY5VgVMU9kVv+k3mlFUtsMIsoRuSTrA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5j5k2td-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 11:53:58 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 691BAF9s589661;
	Thu, 1 Oct 2026 11:53:57 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h1aa7tqf6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 11:53:57 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 691Brre542336570
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 1 Oct 2026 11:53:53 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B295620043;
	Thu,  1 Oct 2026 11:53:53 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3D80320040;
	Thu,  1 Oct 2026 11:53:51 +0000 (GMT)
Received: from [9.123.5.233] (unknown [9.123.5.233])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  1 Oct 2026 11:53:51 +0000 (GMT)
Message-ID: <2a75097f-6b49-456a-bfef-d5e559ce719a@linux.ibm.com>
Date: Thu, 1 Oct 2026 17:23:50 +0530
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
Subject: Re: [PATCH 1/2] KVM: PPC: BookE: Disable preemption before loading
 guest FP and Altivec
To: Narayana Murty N <nnmlinux@linux.ibm.com>, maddy@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org, chzigotzky@xenosoft.de
Cc: mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        linux-kernel@vger.kernel.org, msuchanek@suse.de, ritesh.list@gmail.com,
        harshpb@linux.ibm.com, gautam@linux.ibm.com, amachhiw@linux.ibm.com,
        venkat88@linux.ibm.com
References: <20260928110411.844582-1-sshegde@linux.ibm.com>
 <20260928110411.844582-2-sshegde@linux.ibm.com>
 <9d83e196-4d6b-4be1-811c-eb72527d3cdd@linux.ibm.com>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <9d83e196-4d6b-4be1-811c-eb72527d3cdd@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA0NiBTYWx0ZWRfX/8pgtH/Ud1wU
 u/y3VX5GgOqDwFHqk2eYWLuFbpQ8XlKxPmMhveaNx/SkAKaiZaTWTh7FrcpZvAbrI3DHG4bYrqG
 EpmSbB1E7Zqu/xNU3AACthEpowB/KLw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA0NiBTYWx0ZWRfXw1RPIUQWrhmB
 1EoNf31m67poo/99ihEN+nUSknStiVw93SK63yCqHx9EEZhF09kKf/PG3Z4kdEZ/zwZX/s3VCY7
 oYL5RvaJ//nyDgiV0/DKjDT4z5ucT8jbm8MKYQrHklZx7NY7Tu2qBwgNQaAuWzrxMN7jZx4uDiS
 fjmIGfolmq+4PPY0SI/qpfTSpN7sXgAS6dvkA7z0veKx+aAe6sTZep2MPxEFhSSmtW8jMbXU/51
 Svc9Hj2vw/h8GBZArntyHS/lT69oM1d7OaPPSzq1CCMc6//5oFAVuhlqxkaGBg9jk2aWLAOI18Z
 VdoWSHlaVQxnANe6t9lMLRl7d7Cg8gvugB2GKxARC0k10xfXf4eyuMyqBG8EM5mQsoeh6U6N7J8
 5rv9GDs6n0Rn0g2I458F406En6S6UaQIzacTBP8G7sCqkcnwGlltg3p9NHhqfOuCaGM+vtxde81
 mlKsT6e/6bEou7FC71Q==
X-Proofpoint-GUID: -goUR-A0nxh6fhN1cWHmVSwncqr8OVgv
X-Authority-Analysis: v=2.4 cv=RKcmjIi+ c=1 sm=1 tr=0 ts=6abe49d7 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=aKqlADSCJPk8I_5TKKQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 81A0Hy3citkg-fWJjm21Qx6wwIF3JUoi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010046

Hi Narayana.

On 10/1/26 4:56 PM, Narayana Murty N wrote:
> Hi Shrikanth,
> Thanks for the fixes. I had one question on patch 1.

See response below.

> 
>> diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
>> index 13ad4cf5fa71..5b9118eefe1d 100644
>> --- a/arch/powerpc/kvm/booke.c
>> +++ b/arch/powerpc/kvm/booke.c
>> @@ -1404,10 +1404,17 @@ int kvmppc_handle_exit(struct kvm_vcpu *vcpu, unsigned int exit_nr)
>>           if (s <= 0)
>>               r = (s << 2) | RESUME_HOST | (r & RESUME_FLAG_NV);
>>           else {
>> -            /* interrupts now hard-disabled */
>> +            /*
>> +             * kvmppc_fix_ee_before_entry() marks the software
>> +             * IRQ state enabled while interrupts are still
>> +             * hard-disabled. So disable preemption while loading
>> +             * guest FP and Altivec.
>> +             */
>>               kvmppc_fix_ee_before_entry();
>> +            preempt_disable();
>>               kvmppc_load_guest_fp(vcpu);
>>               kvmppc_load_guest_altivec(vcpu);
>> +            preempt_enable_no_resched();
> Would it be simpler to move kvmppc_fix_ee_before_entry() after the
> FP/Altivec loads instead?
> 
> The normal kvmppc_vcpu_run() entry path already loads the guest
> FP/Altivec state while interrupts are still disabled and calls
> kvmppc_fix_ee_before_entry() immediately before entering the guest.
> 
> So could this path follow the same ordering:
> 
> kvmppc_load_guest_fp(vcpu);
> kvmppc_load_guest_altivec(vcpu);
> kvmppc_fix_ee_before_entry();
> 
> That would avoid making the software IRQ state enabled before loading
> the guest FP/Altivec state, and also avoid the additional
> preempt_disable()/preempt_enable_no_resched() pair.
> 
> Thanks,
> Narayana Murty.
>>           }
>>       }
> 

I thought I had put that for discussion after ---, but looks like I forgot.

I don't mind the above too.  but I didn't have a way to test it.
So kept it as is based on what Christian said works for him.

If you have a way to test the patches, please let me know.
We can try that too.

