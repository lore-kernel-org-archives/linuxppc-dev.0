Return-Path: <linuxppc-dev+bounces-26483-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68376C624D7
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Sep 2026 10:56:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hbGkJ5Prnz2xpv;
	Thu, 03 Sep 2026 20:56:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788433000;
	cv=none; b=jreFGTGc6Ui5HPJ1DSyF21Vp2hjG85hmpusjgJpc1z7aO9f0T4Dt6/iZ4WJMX7JhuTxiY36cSRZF4E3iXUOdevYXZocoSZBsBbW/pWuHOSDRfZ6HO8Q8GCtiju4y1LLyGoOQgD5/rXqOYiGw1VbyF41fkQj9RQj67/yzng93nviR8+aIkKgsZVojq+EetP2okSeFy1xVH/7rqpvyyESnt4P8KddX/8yg8nQeR2KktDSAfBKQU642bJal/TmTw/9te/kOdm+UCoGZSkOAlOBQeDpcAoVJCzrBzrTthfNz5hR/WiSb4jVkBQCLxEtqwambchvKkvKNaa3xxrA/9ey46w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788433000; c=relaxed/relaxed;
	bh=acbRkQxqFjUgG0zhY3IyDa148vhrf2N2kiaF8DvKkV4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cdnYqhSIrt0rPYC+69vwnW1qwViawj2IfzPjAfOw6SatYqsfeefyIdaBdlJTmdXHossJIo0ii6BdAl96Rf0Tw+7K8LQb4WS/Vf/9Nhh6RQH+VFMDzYGFexMtWd0718iF2Yko+OcMLJaQjqKSqNRLjsj/OAu3VikQba4sklpKbutrz2uVXsxm2vjCrszMmZr41BsuZl7Boi+d+TGhPrZEkvuBgsdvkmrrxrb+WjUnAp1tHIaDb1c0Ky8eLyfkbgHhwzVROdC10norLQL4yy0ymgww8qCZssEjOqsotNCCYQgdCwVyH9y4nF0Elijp8vK5Xzq5hs6hSsZDll3fGRTLoA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=WZQtLmS+; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=WZQtLmS+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hbGkH6dnJz2xmh
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 03 Sep 2026 20:56:39 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 683AVcPG2737657;
	Thu, 3 Sep 2026 10:56:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=acbRkQ
	xqFjUgG0zhY3IyDa148vhrf2N2kiaF8DvKkV4=; b=WZQtLmS+kOov/UB0HfkpcC
	61544+XeKSGcFH+slHD0QaRWuB0CqzwtXAIj+k4Qz0nz9odRl0chvrUnHuIvPkuX
	hWK2pqVJd/EI2EFg+igaZXoOAmMGRocaUXSyfXCGkBDxLiHdbhXDJdFR2K6ZDSAS
	kYnC7TIRVNUz6wVXsfW3ykfhiPwIoseN1/GaNaGyhcJcwfQef4cM/S7RykbUa4hG
	nYtNKqh3aCTySHCHBqyqEBltRLkhRqAg+F9tqKl8uPjQ0+KDc7EZgJqLPKtJuzi2
	I3nmFpFioBSnVlNVDedTt8LJHZWhg2M58jus4owU1hr0Anvam7lR6wDdRzqJOb0Q
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbpx5vd9t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 10:56:27 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 683AuJIj032102;
	Thu, 3 Sep 2026 10:56:26 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gcarkfaem-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 10:56:26 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 683AuOCj45613498
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 3 Sep 2026 10:56:24 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6743520040;
	Thu,  3 Sep 2026 10:56:24 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 49E7D2004E;
	Thu,  3 Sep 2026 10:56:22 +0000 (GMT)
Received: from [9.123.5.233] (unknown [9.123.5.233])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  3 Sep 2026 10:56:22 +0000 (GMT)
Message-ID: <9a58d944-405c-4519-852e-8fa04c22c2db@linux.ibm.com>
Date: Thu, 3 Sep 2026 16:26:21 +0530
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
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Christian Zigotzky <chzigotzky@xenosoft.de>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "R.T.Dickinson" <rtd2@xtra.co.nz>, hypexed@yahoo.com.au,
        mad skateman <madskateman@gmail.com>,
        Christian Zigotzky <info@xenosoft.de>
References: <40154f6a-39da-959d-e039-5ab9ff62db3c@xenosoft.de>
 <709b864f-9daa-4a48-b3d6-39baedce63b2@linux.ibm.com>
 <dbbb7998-5245-170f-626b-81bc75a32591@xenosoft.de>
 <843b7c60-23f1-47d0-b4e8-2147c3e40c23@linux.ibm.com>
 <2a27e6fc-7eb4-41a5-ba88-58f6a22625b5@xenosoft.de>
 <1d79ec6f-ce7f-4432-80e0-a54fa1668642@linux.ibm.com>
 <e425cd24-e19a-3860-aad2-11e91af8323f@xenosoft.de>
 <1c9b879a-7907-4849-a416-5df3db5617d6@kernel.org>
 <34112e67-85a5-a380-a42b-24c6562d65be@xenosoft.de>
 <8c6f2510-1dc5-4c45-9288-6b9c8f9b6b24@kernel.org>
 <aplDm-byYL79laYG@kunlun.suse.cz>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <aplDm-byYL79laYG@kunlun.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=PPc/P/qC c=1 sm=1 tr=0 ts=6a99525c cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=UqCG9HQmAAAA:8
 a=NEAV23lmAAAA:8 a=f8VtoK8Q69t1Vut3Nn4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 9Uo147u70E0cuh26PtQc0ASaAJ2uqScJ
X-Proofpoint-ORIG-GUID: 0djdRrmXgL0TvhmXOYfST6SnYlsaQHWQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA5MSBTYWx0ZWRfXzukDBqgTtEoM
 CNNagLCJkkSZ78O2Y7rV4QJo1s0KjSeA4h7b1BAQLze/i6+BkEn9fDFYftcFqjHagdSQlw8pRWU
 16y4Aryds+fAYyTLGaoQN/PwkPCJalQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA5MSBTYWx0ZWRfX66eYRWb0lCzC
 wUhdutK16PYNxXHqNip2eg1B43TyC4O3JiI9T5Al9Im+XKKJF4M32zMLVD7ACfx6f0T2dHF4Syr
 Fslq0nTJsBJleU8c4hDaCVeIEZIl4a2NLytqtxO0Yf8o/8+w/wdxRY2L1MfmTNPp1/HbI2EmbHh
 tt0enEEV9+3o+tp4LpFk9QfxmN6ZhOStWadSYW/gEkWiTax7FJi2SdeoMVLTVMX2pxQ3b8P9COQ
 RUFgs1x9/GON3ATBt8manOuw85JT3frRcxpaq20kYRyBtfweQEhpTuznCm2oDXOpbOH+7b2sJQy
 zRQ+Ci3/Ear8e4Lly2TomM6bqf3LbbQvM9rhA/dUbZ+K7IdgP1hS4g5N046uf243kMpdwkhVqv4
 imZuK2w9pCXIDcwl3kyNO/kNVUW+n2sP16DNjwRkzFOqDLS/6pkxEDgsIUvE8lD0OEMsb1506bd
 /jMu5Fb608RNh7zjNXQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609030091

Hi Michal.

On 9/3/26 3:23 PM, Michal Suchánek wrote:
> On Thu, Feb 26, 2026 at 02:24:50PM +0100, Christophe Leroy (CS GROUP) wrote:
>> Hi Christian,
>>
>> Le 26/02/2026 à 06:37, Christian Zigotzky a écrit :
>>> On 25/02/26 08:16, Christophe Leroy (CS GROUP) wrote:
>>>> +Peter
>>>>
>>>> Hi Christian,
>>>>
>>>> Le 25/02/2026 à 06:54, Christian Zigotzky a écrit :
>>>>> Hello,
>>>>>
>>>>> We were previously able to disable PREEMPT in the kernel
>>>>> configuration, but the latest kernels now enable it by default
>>>>> and it is no longer possible to disable it.
>>>>>
>>>>> Is it possible to let us decide whether to activate PREEMPT or not?
>>>>
>>>> Can you give more details on why you want to be able to deactivate
>>>> PREEMPT ?
>>>>
>>>> Read https://eur01.safelinks.protection.outlook.com/? url=https%3A%2F%2Fgithub.com%2Ftorvalds%2Flinux%2Fcommit%2F7dadeaa6e851e&data=05%7C02%7Cchristophe.leroy2%40cs-soprasteria.com%7C7006c8b4b98c4315a7e508de74f9388a%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639076810956939768%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=6xLB%2FOVSkmgZRamaBM9zaxm%2FUTk9ssf4409QJdiXkDg%3D&reserved=0
>>> I use PREEMPT_NONE kernels on my Linux PPC servers. (Without desktop)
>>
>> You are doing that today because it is possible. Tomorrow it will not be
>> possible anymore, for the reasons explained by Peter.
>>
>> My question was not to know what you are doing but why, and why you think
>> you still need PREEMPT_NONE and why the modern PREEMPT_LAZY is not good
>> enough for you.
> 
> Hello,
> 
> I tried to compile a kernel with preemption for pSeries, and while
> PREEMPT_VOLUNTARY works for me PREEMPT_LAZY crashes.
> 
> The kernel crashing is certainly a reason why a preemtion model would
> not be good enough for me.
> 

Is it the same issue that you said the bug which was discussed internally?
i.e around kvmhv_run_single_vcpu ? or is it different one?

> This is not the latest kernel so it might have been fixed in the
> meantime for the platform in question. Will need to check that.
> 

If possible run against current upstream and share the results.

> Nonethless, there are quite a few platforms. Originally no preemption
> was the only option, and that's the reason why many people run that.
> It's the conservative, known working option. And that's the reason a lot
> of platfrom code does not get tested with more aggressive preemtion
> models, and never gets fixed to work with them.
> 

Full preemption has been there for many years!.
Lazy is not that aggressive compared to that.

> Simply disabling the no preemtion option does not make the platform code
> ready.
> 

Let's understand your crash case. Let's see where it is going wrong. I am suspecting
it is some wrong usage of preemption api rather than arch can't support preemption.

> Thanks
> 
> Michal
> 
>>
>> Christophe
>>
>>>>
>>>>
>>>>>
>>>>> Currently we use the following revert patch for our non-preempt kernels.
>>>>>
>>>>> --- a/kernel/Kconfig.preempt    2026-02-14 10:06:32.000000000 +0000
>>>>> +++ b/kernel/Kconfig.preempt    2026-02-08 21:03:27.000000000 +0000
>>>>> @@ -16,13 +16,11 @@ config ARCH_HAS_PREEMPT_LAZY
>>>>>
>>>>>    choice
>>>>>        prompt "Preemption Model"
>>>>> -    default PREEMPT_LAZY if ARCH_HAS_PREEMPT_LAZY
>>>>>        default PREEMPT_NONE
>>>>>
>>>>>    config PREEMPT_NONE
>>>>>        bool "No Forced Preemption (Server)"
>>>>>        depends on !PREEMPT_RT
>>>>> -    depends on ARCH_NO_PREEMPT
>>>>>        select PREEMPT_NONE_BUILD if !PREEMPT_DYNAMIC
>>>>>        help
>>>>>          This is the traditional Linux preemption model, geared towards
>>>>> @@ -37,7 +35,6 @@ config PREEMPT_NONE
>>>>>
>>>>>    config PREEMPT_VOLUNTARY
>>>>>        bool "Voluntary Kernel Preemption (Desktop)"
>>>>> -    depends on !ARCH_HAS_PREEMPT_LAZY
>>>>>        depends on !ARCH_NO_PREEMPT
>>>>>        depends on !PREEMPT_RT
>>>>>        select PREEMPT_VOLUNTARY_BUILD if !PREEMPT_DYNAMIC
>>>>>
>>>>> ---
>>>>>
>>>>> Thanks in advance,
>>>>>
>>>>> Christian
>>>>>
>>>>
>>>
>>>
>>


