Return-Path: <linuxppc-dev+bounces-24918-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DF48C54F4C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Jul 2026 05:12:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h8Nr11w9Wz2yRl;
	Tue, 28 Jul 2026 15:12:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785215537;
	cv=none; b=e4Il0pQTkVPM8avfcP4RmC14olEHCxpz1whUcjgAPEWJwffQgZM6pmt37A80WK2VFtZrhIzSRCfNVmSD3/q9YDKbk0cTq99+cncvjdlyM8zAlH3l1kj/pGsRNqLv+QpN0pZovS6R4TDL5bT0/sTZOfAHM1RlZcR11MVAmCnsljr0vUqgJDWCuRLbR9UGhpAfuTBGQQfavCtDHHV5DB0RZtZzUhVbhrXj69ZZaZN/meYBroc21tb2sWhfOJfTXew4QBldRIVSQkIE/G1PH+FjaPY7N4YHAdzmFzopQIGU1f7KKagbusBoxqgvcZu+DrLkTrOaOAqEAhupSclxL0RQxw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785215537; c=relaxed/relaxed;
	bh=Cy1tyTRW10bQOL6p1MjhtU1R/YgFeWt4qDQo1lGq2uM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k0DjIujaL2DJy6uHWBHaz7ZPXprri6xGellx/grhlR8fuP9kdIYr6p8ObZuHFv/qdLIiTe08Ocea94TOB8TvdBFgDEshO1ZJgQogFii2nNfwH757A2B7IuA0DjYAV8zvg5SM1/37VHdSWIvVkM9Zr2UumL6CGe+wNNNFnXlGIOubKv/2I6MIIp4jnxWVY9hp4eidqKN5HNrHzU07x24IDi6FO3WKsD2WiNXeYgbjNlG3FIy6K9HeW+PwoDUbxnw8Cefja/aAH0X/Nc4lwoyzLhQAEkWyZu2xQg0EWp0GsKTHRoLg8tmNRwcODqpP+8GEqWLj3NEskj3CoBvr3yYd+A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=WyJBT9Z0; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=WyJBT9Z0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h8Nqz43ysz2xLq
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jul 2026 15:12:14 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66S3m8jx4109738;
	Tue, 28 Jul 2026 05:11:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Cy1tyT
	RW10bQOL6p1MjhtU1R/YgFeWt4qDQo1lGq2uM=; b=WyJBT9Z0m4LJ2QO7Ig1UPi
	bQX8sEwVPqRfXI7HQOJYJmLyVgVL1bh9rDANmkUqTcZF6QuK5OQQVAJXnsqiEW1D
	+B63hrG/rT+2dFavHXFfb5a0KZE2O3yU4R3VagbVOLhCeDYEfWA4Pt8mqGSl01wP
	xlxdBB322fcFPJH5KO2OBRlAKgdz3IsfaA6wO55mwyqBnmXW7HiArmZyhiZBnX9f
	+7YFhlngev/dBCWnXZdGzLVHM+Kf3MNEyYan2DC0p+fedg3J+Yo0PqTF+ujQBkcT
	nvDDb4JYggp6A2uVD9OUir3qSgIRRX392J/TuGRz08uGhF76vWAlmtZdjcGodxhQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuw7bjfb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 05:11:57 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66S5BGHX029648;
	Tue, 28 Jul 2026 05:11:56 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fna5y03pf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 05:11:56 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66S5Bs3P23986794
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Jul 2026 05:11:54 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3CFF520088;
	Tue, 28 Jul 2026 05:11:54 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EC31D200B0;
	Tue, 28 Jul 2026 05:11:41 +0000 (GMT)
Received: from [9.39.22.42] (unknown [9.39.22.42])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Jul 2026 05:11:41 +0000 (GMT)
Message-ID: <a1e04751-eab5-465b-8238-c9f4cd40e472@linux.ibm.com>
Date: Tue, 28 Jul 2026 10:41:40 +0530
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
Subject: Re: [PATCH v4 1/1] powerpc: enable dynamic preemption
To: Jirka Hladky <jhladky@redhat.com>
Cc: paulmck@kernel.org, maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
        christophe.leroy@csgroup.eu, mpe@ellerman.id.au, npiggin@gmail.com,
        bigeasy@linutronix.de, will@kernel.org, linux-kernel@vger.kernel.org
References: <20250210184334.567383-1-sshegde@linux.ibm.com>
 <20250210184334.567383-2-sshegde@linux.ibm.com>
 <CAE4VaGBwMp3Ke1+Bt11-v6CCE0h=mPm8k_Cf8DazFSQNT9Mz8g@mail.gmail.com>
 <c0f51eda-21c4-4e9d-95e9-75b2740c3f43@linux.ibm.com>
 <500d8e8c-088c-4e6d-ab53-868ade6b0eda@paulmck-laptop>
 <CAE4VaGDGS8wkZj4SF5XVC3-1yDmvJxjUjThTPqVw3kxg56ssQA@mail.gmail.com>
 <e013e88a-6137-4de8-9dfd-925b707f2e01@linux.ibm.com>
 <CAE4VaGAJ9mT8-V=GRPYj8h0RXuNf6S5icrmqeOOFDnkpPMQjaw@mail.gmail.com>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <CAE4VaGAJ9mT8-V=GRPYj8h0RXuNf6S5icrmqeOOFDnkpPMQjaw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 1IjJrW3xNxJtyn1LYRX03tvMFuRywWwd
X-Proofpoint-ORIG-GUID: 5vkhcPQ2Rm-bK_RdVTIeZgi5yFQiVI2L
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA0MSBTYWx0ZWRfXyMzhptyadmxH
 kHM1bn9ThxEEdyfZSr7GWnmYpnCuAKGOhwN7KWRQhLREGA8UW9dCsiPVGJmIRgV/kCp8Tu1Sy46
 3PhueFkSt4n0NJd4Eftcb4jt/6IYLa8NKXVfQb2dIOS4cOF9nlmWblRQgzxZ5e7e65gEoWESLNm
 BXD3D9rnRoMyMDYJfDu3BEAKs/0dJ0l8VYeM6bhjPrFPWsk+2zZ1FvnLhlM3xOphP7F0fq4hnBa
 a5ekoHtybazMkQcsuUDprXQ5+J18S82DlIrsJgJqqXbST3GBUhMyThPuzHfmla6CQoRiOPFi04A
 TdxPLnbMZmmVp7fU2a3eostrsIk+WOHd1w10wNudkT1LgjezQQkZZHwUrEWD2P4B8/aNyiIKbPg
 oud4u9pSzJxhEefJyB5K1j95iE/8ToW6cAZPdXvj4tZkdqSN55/AQXuxY15/D8c9hADNtGw/sxA
 JTpdLFQERTce3rzvkSQ==
X-Authority-Analysis: v=2.4 cv=SKFykuvH c=1 sm=1 tr=0 ts=6a683a1d cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=1BA2qzOtpjeWqlwniW0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA0MSBTYWx0ZWRfX0jmp9cONgbR1
 8P9q9B5SFBByjjBxoLJOCBDSOFjqec66zan7AMaKXaCjjHo4MdsEs+hFzp6QmCvNRS4Jj34XN8B
 JjeTAAmJNuyva5ULfVeHb+BiNqiHjVc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607280041

Hi Jirka,
Thanks for these experiments.

On 7/28/26 5:56 AM, Jirka Hladky wrote:
> On Mon, Jul 27, 2026 at 7:10 PM Shrikanth Hegde <sshegde@linux.ibm.com> wrote:
>> That's full preemption mode.
>>
>> When preemption mode changes preempt_enable/disable which were just a
>> barrier earlier now become real preemption points. If the code path
>> repeatedly does the exact same thing, it might pop up.
>> But, can we say is that number expected? it is difficult to put a
>> number to it.
> 
> You were right -- my previous test conflated two variables. I've now
> built a third kernel to separate them. All three are from the same
> 6.15-rc6 source, same machine (POWER10 lp11), no PREEMPT_DYNAMIC:
> 
> Config                                    Mode        PREEMPT_RCU
> kill bogo-ops/sec
> ------------------------------------   ----------  -----------
> -----------------
> PREEMPT_VOLUNTARY=y   voluntary   no            105,014
> PREEMPT_LAZY=y                lazy           no              86,878
> PREEMPT=y                           full             yes             73,317
> 
> voluntary -> lazy                                  -17.3%
> lazy -> full+PREEMPT_RCU               -15.6%
> voluntary -> full+PREEMPT_RCU       -30.2%
> 
> The regression splits roughly 55/45 between the preemption mode
> change and PREEMPT_RCU:
> 
> 1) voluntary -> lazy (-17.3%): preempt_disable/enable becoming real
>     preemption points, as you predicted. On ppc64le this is expensive
>     because the kill() syscall path is very tight and hits these
>     points heavily.
That's true for all archs. Please check your preemption mode in your x86 experiment.
If it remained same, then that small difference could PREEMPT_RCU cost.

even preempt_enable/disable has barriers.

> 
> 2) lazy -> full+PREEMPT_RCU (-15.6%): __rcu_read_lock/__rcu_read_unlock
>     requiring lwsync/isync barriers on ppc64le.
> 

Full is more aggressive in setting in the need_resched bit and
PREEMPT_RCU doing more than just barriers specially __rcu_read_unlock.

>> What I was asking is below. (You can do this only with below 7.0)
>>
>> Config A: CONFIG_PREEMPT_VOLUNTARY=y (CONFIG_PREEMPT_DYNAMIC=n)
>> Config B: CONFIG_PREEMPT_VOLUNTARY=y (CONFIG_PREEMPT_DYNAMIC=y)
> 
> I couldn't do this exact test because 6.15-rc6 doesn't have
> HAVE_PREEMPT_DYNAMIC_KEY for powerpc (that's your 6.16 patch), so
> CONFIG_PREEMPT_DYNAMIC=y would be silently ignored. I would need a
> 6.16-6.19 kernel for this, which is before 7dadeaa6e851 removed
> voluntary as an option.
> 
> But the PREEMPT_LAZY test above achieves the same goal: it isolates
> the preemption mode cost without PREEMPT_RCU.
> 

No. It doesn't confirm. I would recommend you do that case to find out
the cost of PREEMPT_RCU alone.

The reason being, lazy is a real preemption mode. All the callsites of preempt_enable
could force a context switch.

Whereas,
>> Config A: CONFIG_PREEMPT_VOLUNTARY=y (CONFIG_PREEMPT_DYNAMIC=n)
>> Config B: CONFIG_PREEMPT_VOLUNTARY=y (CONFIG_PREEMPT_DYNAMIC=y)

Both are expected to same/similar w.r.t preempt_enable. But as we have discovered
PREEMPT_DYNAMIC in additions enables PREEMPT_RCU. If we get the above data,
then we can quantify the cost due to PREEMPT_RCU alone.


Preemption mode cost is one thing, i.e preempt enable/disable cost,
additional cost is call to schedule itself if need resched is set, that
will likely over weigh the preemption cost.
That is observed in your experiments too.
full is more aggressive in setting the need_resched bit. Plus additional cost of
PREEMPT_RCU which too can set need_resched bits.

>> Are you saying you see regression with voluntary with
>> CONFIG_PREEMPT_DYNAMIC=y?
> 
> Yes. On the ELN kernels with CONFIG_PREEMPT_DYNAMIC=y, the regression
> appears at 6.16 when HAVE_PREEMPT_DYNAMIC_KEY is added, because:
> 1) PREEMPT_DYNAMIC forces the runtime mode to lazy/full (voluntary
>     is no longer available on architectures with ARCH_HAS_PREEMPT_LAZY)

1. Is not true. PREEMPT_DYNAMIC doesn't force the preemption mode switch. You can still choose
voluntary even with PREEMPT_DYNAMIC on 6.16 to 6.19 kernel.

Forced mode switch to lazy/full due to ARCH_HAS_PREEMPT_LAZY has happened in 7.0.


> 2) PREEMPT_DYNAMIC pulls in PREEMPT_RCU
>

This looks it can set need_resched bit aggressive to force a quiescent state?
Concerns i see with this config, I have put it in other thread.

> Both contribute to the ~30% total regression.
> 
> Jirka
> 


