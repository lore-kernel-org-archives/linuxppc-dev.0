Return-Path: <linuxppc-dev+bounces-27143-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24752C88E53
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Sep 2026 17:09:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hhLd56vk0z2ypW;
	Sat, 12 Sep 2026 03:09:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789146585;
	cv=none; b=Fg+EC0ZLSKmm78pB4yeI8cMGGgdpcR+Om6bT/eZFP62ZJ/+3Ayg4aT9ZdMSlDxRlbeF4mkv9bG9XAQJ3P47MR9lBauIIXOJ9vkmyfoH0Z5kX/w/ddKrnFIcqhbaLwaAVUdYLSJ9TSXETlrn49UHPpfNb8GNWKMLNt6m7TX/mnBVlXmR4U3Iruagwq0lqkMHKoSeaUUGWgecGO37JkymCNBZnrlWRu4+yaCDXQu5tLV/e3+c+lmhek0VWEFoxChJNlzFtZ4Ihofccz7OuPwVXzdp7mG7jVvKSVYbHS6TzE/tqvsTlyNfsupTVA62Kegv2N1dXgB6fHv2Y5XTSK8k/uw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789146585; c=relaxed/relaxed;
	bh=lKgwG1Kwds6pceD1MsUcXpTwjFZ9Cxamm2HzFxDq8xc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KwYLbzRHWi5dn4S2mKmF8pS8lW/UYuLL0uR2YPXXBa/YBO69x4jo7uOPol+SRwFUIt9bTJnRVmfCzNH9LsujxGovY7GZfBJQZLaJwQh3H3wQP1WVWkOcnD/8rHIHJ0oqGi5Q3A8QMVhFZVJjdU1b7wjgCNBjuPS0QDtEIKIqh99OrUwBuGAOUzl2FG8rb8KtVLUxMg2YT00p6ZvYAqfSO28lCwbNHj6NZtxPLlWfgujfsH2sRbRLj9NWoG+DxfOgGZ8of3Udl0PJUQ0qWt6sqyqUJHHXFFXEaQkFAFLHHqTwXCTt0ARYGVQRCDHq2ZwyiXwv3AepJJ3G6+V8A3TSvQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=SjE/J4xu; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=SjE/J4xu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hhLd46XW3z2ygK
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Sep 2026 03:09:44 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68BF1XnI235555;
	Fri, 11 Sep 2026 17:09:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=lKgwG1
	Kwds6pceD1MsUcXpTwjFZ9Cxamm2HzFxDq8xc=; b=SjE/J4xuMtRZe4+JoUu7/V
	FMnZMSiLHQDu5VdQRhyhoHHRv4T5Glgm1UkbQtK1zi33P8rFFafQSRNjyZrRG17J
	OZwEpNNX98PP3LfdmZzh2IZAHRybJ7Z7hGM15fEl45OuJ7hIPLFvEfmKo7yTxuph
	dntlUbYCt7fADjsaTfPBNC5eXVxdUlQ9pqU0CVte2B+e8FVs12VFnM4P9A6EOorO
	4PaTi/zah80Up99Kr+pSFS9KPpxajgvvv6n8k19/v0CJPrjTdQy+CQJ9Q2EtQHwb
	vzZlWXcxeplpctdD4bvDw4Y3cuhASfPzdqWKAn/73hThVZLXKvF5IF++ofLOXE0g
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gkd8ncxbh-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 11 Sep 2026 17:09:21 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68BEo7WA1808711;
	Fri, 11 Sep 2026 17:09:20 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gkvq2yknd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Sep 2026 17:09:20 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68BH9G6K52494600
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Sep 2026 17:09:17 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CC8F52004B;
	Fri, 11 Sep 2026 17:09:16 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A448420043;
	Fri, 11 Sep 2026 17:09:11 +0000 (GMT)
Received: from [9.39.18.14] (unknown [9.39.18.14])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 11 Sep 2026 17:09:11 +0000 (GMT)
Message-ID: <baeb1ae4-7c0f-4e4e-8fc5-09367cb7c4e9@linux.ibm.com>
Date: Fri, 11 Sep 2026 22:39:10 +0530
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
Subject: Re: [Linux PPC] Disable PREEMPT
To: =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc: harshpb@linux.ibm.com, Gautam Menghani <gautam@linux.ibm.com>,
        amachhiw@linux.ibm.com, Christian Zigotzky <chzigotzky@xenosoft.de>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "R.T.Dickinson" <rtd2@xtra.co.nz>, hypexed@yahoo.com.au,
        mad skateman <madskateman@gmail.com>,
        Christian Zigotzky <info@xenosoft.de>, nnmlinux@linux.ibm.com,
        Samir M <samir@linux.ibm.com>,
        Venkat Rao Bagalkote <venkat88@linux.ibm.com>
References: <8c6f2510-1dc5-4c45-9288-6b9c8f9b6b24@kernel.org>
 <aplDm-byYL79laYG@kunlun.suse.cz>
 <9a58d944-405c-4519-852e-8fa04c22c2db@linux.ibm.com>
 <aplZNFMJUkfs-BFs@kunlun.suse.cz>
 <5ed38c3e-4aaa-4a91-9eda-e31d09b44abc@linux.ibm.com>
 <app0zGv9bvtL4nHm@kunlun.suse.cz>
 <4eef1f0b-0c02-4377-b950-43c3b120865a@linux.ibm.com>
 <aqJxcWC1dWKITCav@kunlun.suse.cz>
 <393117bc-094e-4c47-b061-f255f5bff937@linux.ibm.com>
 <aqKUhHb9UTfVq4As@kunlun.suse.cz> <aqKfsVArHHaIK6M9@kunlun.suse.cz>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <aqKfsVArHHaIK6M9@kunlun.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=NMVAaE6g c=1 sm=1 tr=0 ts=6aa435c2 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VLc2VSdLAAAA:20
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=UnJG9Kv-_lNK3tyJmKwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-GUID: rYgrNJH_2eNU-oIEzKGwczCd-_0DKhTs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDIzOCBTYWx0ZWRfXwFSDZlc7aKTo
 QY4r4kaifQXhbPz1mhsfEBkKvDsQj6FcxnyRSB92bhD0FHA/x9lTu093GmUcemFiZG66yFziEoe
 EliufTI2mIZgOQWokRug6JWeLc6jQdtl4GFxky90Xm10pi5PIBUMdGC3kdQQihsQkRwFV0ecdLh
 cX6GxSONUVSW7/Q+m2/F5CkARE48vDK4bVJ94lBJMVT68e0GlzjSTBMdE/4fwpRQyaHGlUrgcbu
 dD/CDxH+J3i34Wka8ExZRvnTInWJxNgS8MSOFWj1qf8gP+/Glvvz5OQR/rvW0rORsVJZq+UeKNM
 yqQj86IdBfkCc0m9FrPdYAWneUPkcC9kFavqpD2Bw51SEC4ipL+49vDyBGxoL0hOuIFfsOBNM/A
 ONvFGrpsihcWKKrciSdQAZ4gJ7qbjrLltq0teYlUXc6wStJr9Ri528KtBjM8pzIzv7imJ9MT3Sc
 r0oogHIR++PDGJRwryw==
X-Proofpoint-ORIG-GUID: QTP_TfbHqzirFHtrQW5RH79sGT4T4ZE_
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDIzOCBTYWx0ZWRfXzCHeoB8j4VnM
 ynvFq9sObr8bxK0ZVBGumaGdz55PU61zJP88hiDpEypDAMrTRet5xSB1BdWfB7mQ7rmsSjTdEFY
 1j4XKouhybdlneirMgozomvTMRFkTWY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_05,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609110238

Hi Michal,

On 9/10/26 5:46 PM, Michal Suchánek wrote:
> On Thu, Sep 10, 2026 at 01:29:08PM +0200, Michal Suchánek wrote:
>> On Thu, Sep 10, 2026 at 04:11:20PM +0530, Shrikanth Hegde wrote:
>>>
>>>
>>> On 9/10/26 2:29 PM, Michal Suchánek wrote:
>>>> On Fri, Sep 04, 2026 at 02:34:21PM +0530, Shrikanth Hegde wrote:
>>>>>
>>>>>
>>>>> On 9/4/26 1:05 PM, Michal Suchánek wrote:
>>>>>> On Thu, Sep 03, 2026 at 10:52:59PM +0530, Shrikanth Hegde wrote:
>>>>>>>
>>>>>>>>> If possible run against current upstream and share the results.
>>>>>>>>
>>>>>>>> https://github.com/openSUSE/kernel-source/blob/6824496d1801f73def615dca8794202eeb7b0d86/config/ppc64le/default
>>>>>>>>
>>>>>>>> [  472.091531][ T6181] Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: kvmhv_run_single_vcpu+0x19d4/0x1b50 [kvm_hv]
>>>>>>>> [  472.091598][ T6181] CPU: 29 UID: 107 PID: 6181 Comm: CPU 112/KVM Not tainted 7.2.2-5.g6824496-default #1 PREEMPT(full) openSUSE Tumbleweed (unreleased)  61871a5f06863b4006f5ef27cd9f18e8a7a2edad
>>>>>>>> [  472.091612][ T6181] Hardware name: IBM,9824-42A Power11 (architected) 0x820200 0xf000007 of:IBM,FW1110.20 (OB1110_130) hv:phyp pSeries
>>>>>>>> [  472.091624][ T6181] Call Trace:
>>>>>>>> [  472.091630][ T6181] [c00000000fdfb680] [c00000000134ce90] dump_stack_lvl+0x84/0xc0 (unreliable)
>>>>>>>> [  472.091653][ T6181] [c00000000fdfb6b0] [c00000000022e7c8] vpanic+0x324/0x5e4
>>>>>>>> [  472.091666][ T6181] [c00000000fdfb760] [c00000000022eac4] do_panic_on_target_cpu+0x0/0x2c
>>>>>>>> [  472.091677][ T6181] [c00000000fdfb780] [c0000000013c1ff8] __stack_chk_fail+0x48/0x60
>>>>>>>> [  472.091689][ T6181] [c00000000fdfb7f0] [c00800001aae219c] kvmhv_run_single_vcpu+0x19d4/0x1b50 [kvm_hv]
>>>>>>>> [  472.091712][ T6181] [c00000000fdfb940] [c00800001aae24b4] kvmppc_vcpu_run_hv+0x19c/0x12f0 [kvm_hv]
>>>>>>>> [  472.091732][ T6181] [c00000000fdfba10] [c00800001aeeed18] kvmppc_vcpu_run+0x30/0x48 [kvm]
>>>>>>>> [  472.091779][ T6181] [c00000000fdfba30] [c00800001aee9ef4] kvm_arch_vcpu_ioctl_run+0x35c/0x4a0 [kvm]
>>>>>>>> [  472.091813][ T6181] [c00000000fdfbac0] [c00800001aedaac4] kvm_vcpu_ioctl+0x1ac/0xad8 [kvm]
>>>>>>>> [  472.091844][ T6181] [c00000000fdfbca0] [c0000000007f1244] sys_ioctl+0x374/0x1060
>>>>>>>> [  472.091857][ T6181] [c00000000fdfbdb0] [c00000000002f7f8] system_call_exception+0x188/0x430
>>>>>>>> [  472.091871][ T6181] [c00000000fdfbe50] [c00000000000cfdc] system_call_vectored_common+0x15c/0x2ec
>>>>>>>> [  472.091886][ T6181] ---- interrupt: 3000 at 0x7fffb5565fac
>>>>>>>> [  472.091896][ T6181] NIP:  00007fffb5565fac LR: 00007fffb5565fac CTR: 0000000000000000
>>>>>>>> [  472.091904][ T6181] REGS: c00000000fdfbe80 TRAP: 3000   Not tainted  (7.2.2-5.g6824496-default)
>>>>>>>> [  472.091911][ T6181] MSR:  800000000280f033 <SF,VEC,VSX,EE,PR,FP,ME,IR,DR,RI,LE>  CR: 42044402  XER: 00000000
>>>>>>>> [  472.091938][ T6181] IRQMASK: 0
>>>>>>>> [  472.091938][ T6181] GPR00: 0000000000000036 00007fbfa77ed7a0 00007fffb5677100 00000000000000fa
>>>>>>>> [  472.091938][ T6181] GPR04: 000000002000ae80 0000000000000000 0000000000000000 0000000000000000
>>>>>>>> [  472.091938][ T6181] GPR08: 00000000000000fa 0000000000000000 0000000000000000 0000000000000000
>>>>>>>> [  472.091938][ T6181] GPR12: 0000000000000000 00007fbfa77f5ec0 000000014676f000 00007fbfa77ee7c0
>>>>>>>> [  472.091938][ T6181] GPR16: 000000014674e8d0 00007fbfa77eeec0 00007fbfa77eeec0 fffffffffffffff7
>>>>>>>> [  472.091938][ T6181] GPR20: 00007fffb71210d0 0000000000000001 00007fbfa77eeec0 0000000000000000
>>>>>>>> [  472.091938][ T6181] GPR24: 00007fbfa77ed8e8 0000000105971428 000000002000ae80 0000000105f77a70
>>>>>>>> [  472.091938][ T6181] GPR28: 0000000000000000 0000000000000000 000000002000ae80 000000014674f000
>>>>>>>> [  472.092020][ T6181] NIP [00007fffb5565fac] 0x7fffb5565fac
>>>>>>>> [  472.092027][ T6181] LR [00007fffb5565fac] 0x7fffb5565fac
>>>>>>>> [  472.092033][ T6181] ---- interrupt: 3000
>>>>>>>> [  472.098256][ T6181] pstore: backend (nvram) writing error (-1)
>>>>>>>>
>>>>>>>> This is the host, cannot run the kernel as guest because it fails to boot most
>>>>>>>> of the time inside KVM.
>>>>>>>>
>>>>>>>>>
>>>>>>>>>> Nonethless, there are quite a few platforms. Originally no preemption
>>>>>>>>>> was the only option, and that's the reason why many people run that.
>>>>>>>>>> It's the conservative, known working option. And that's the reason a lot
>>>>>>>>>> of platfrom code does not get tested with more aggressive preemtion
>>>>>>>>>> models, and never gets fixed to work with them.
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Full preemption has been there for many years!.
>>>>>>>>
>>>>>>>> Possible for years, forced only recently.
>>>>>>>>
>>>>>>>>> Lazy is not that aggressive compared to that.
>>>>>>>>>
>>>>>>>>>> Simply disabling the no preemtion option does not make the platform code
>>>>>>>>>> ready.
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Let's understand your crash case. Let's see where it is going wrong. I am suspecting
>>>>>>>>> it is some wrong usage of preemption api rather than arch can't support preemption.
>>>>>>>>
>>>>>>>> Very likely some wrong use of the preemption API by the arch code, or no
>>>>>>>> use where it should have been used. It did not matter so long as people
>>>>>>>> could run their no preempt configs and ignore the problem.
>>>>>>>>
>>>>>>>> Thanks
>>>>>>>
>>>>>>>
>>>>>>> Friendly LLM analysis says preemption is enabled too early and before
>>>>>>> completing kvmppc_handle_exit_hv() / kvmppc_handle_nested_exit()
>>>>>>>
>>>>>>> Below is ONLY a speculation and completely UNTESTED.
>>>>>>> Maybe worth a try.
>>>>>>
>>>>>> The patch is munged by the e-mail client, and it causes immediate
>>>>>> voluntary preemprion in rcu critical section and hard lockup on starting
>>>>>> a KVM VM.
>>>>>>
>>>>>> Also it would be sort of bad news if it worked because that would be
>>>>>> specific to book3s KVM HV and would not help with the KVM HV from the
>>>>>> original report which likely is not book3s, nor with KVM PR.
>>>>>>
>>>>>
>>>>> Thanks for trying. We will try a local repro and look into it why stack is
>>>>> getting corrupted.
>>>>

As we discussed offlist, samir helped to run a similar test on his machine, and he didn't
run into issue so far. we will try more.

I am just wondering what different in your case?
By any chance we are running into below one? Can you check your gcc version?

https://lore.kernel.org/all/CAABZP2z=xu+07-y5fqFLidZz1VpSgrSwXa1mFHPb=b3Ezr3OtA@mail.gmail.com/

Maybe CONFIG_DEBUG_PREEMPT worth a try to if it shows up anything.

>>>> There is also stack corruption when idling. At this point the machine is
>>>> stuck half-dead and would not go through with the panic, it requires
>>>> dump from the hyprvisor side to capture this.
>>>>
>>>> Thanks
>>>>
>>>> Michal
>>>>
>>>
>>>
>>> is this on host with kvm running or this is without kvm running anything?
>>
>> Difficult to say after the fact. Given running KVM VMs is crashing with
>> this kernel most likely no VM was running.
>>
>>>
>>> Do you see corruption if you don't have kvm module loaded?
>>
>> Difficult to say, this takes hours to days to reproduce, and the module
>> is normally loaded by default. I can blacklist it to make sure it does
>> not get loaded.
>>
We might need exact vmlinux and if possible vmcore to see the paca saving into
specific register or why it could possibly go wrong.

Michael, Christophe, anything rings a bell? What might be going wrong here?

