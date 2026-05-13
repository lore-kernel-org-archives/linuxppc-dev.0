Return-Path: <linuxppc-dev+bounces-20825-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 397F1CD4851
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2026 05:35:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFhy46vFfz2xpt;
	Wed, 13 May 2026 15:35:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778650540;
	cv=none; b=n6tC/+OiZXybBjTOc0+3RrSWYqkDsPcOVPWh3ey+Jis6tCi/JjjtQUi2PQnDUPnhUi0Ot7WGiqRf/LXU3rzA+bEiLKMRB0LQHQIMnYR6ZErDXDZzOWndx9wjExKsGm7pw3X5k8YXd2PvC7HSp8nANOYvGZkoPy7dgZZFJRgz+MW64VloSF6bSpbY2Jzq6jE3dv2MMoaLUMTEfF2tnHgCRDcDoIk/a9M3xMw2AdrtdUWa75mMEG0i6op+KJfb9Q/ab0Mqj7DAdTtGpKlBh+XMyFmn+QDIS7Qb6uZGMaQaq6qFhMY7c1W4f6CMZ5T+yry00l3gmUq53K+GFNCOu5YNtA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778650540; c=relaxed/relaxed;
	bh=zcoiNG9cEyP+nL4uxgFRnI+EezDV+bgUmox8t27Hpfo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZZgij6NRVy0ln9V27ET0s56FUY09HenWWsZO+jF/nGg9/r/pO8bxx20mwsyf2NZJsqbx/A9si5163eWtRJOcLCvhJlSQfpjYA7p41PsRgUPegY9gEjpvsWX6l7jY08pfRpuBAfulCFa+67kf6cPabcXjMoJJi+RsgeUmJzuLULaHnof3++xL6atC8KwKwSZ0EpjJK0CuKYkGoppLEmprYAR42JoqJlKunm9saXe5S0lmmvtfinB6WpVYRUq2b/yXZRT4L8Pv2LMTBHoR8W836uSoVdTcUd9IRgGPnFJ3oT0jwKBpapGhLqQfEJZwp/3mJGChq6wPYJqGPdYNmYd7cg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=VndogxBT; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=VndogxBT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gFhy36d2Fz2xn3
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 15:35:39 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64D23AZc3775682;
	Wed, 13 May 2026 05:35:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=zcoiNG
	9cEyP+nL4uxgFRnI+EezDV+bgUmox8t27Hpfo=; b=VndogxBTAo/YRD2Fv12IXU
	XwqzVbxsxgro0V20kUk2HEeMNVEmPNjDBSFaCNqXnaTylWBdK8tD64QunZHucKHk
	XHb+JNE/EpocfIpLeaGycefZzxK+9Z4EUObO5Odo9QYv+GWlgDEzBaRD9Yth1cZ7
	Jq/GAtwDB7cTsN1oD3k6OBWc4EcwnjG+9n7vP2J9UTzUxUS4vgWRBG8Pt5pfz6Fg
	qeSYCLIhUqKgnuAEhLg7tyKSGBQA58Yc29ssqOIMmLrirgsvQTf+7QdJ95VoD2YW
	FIrXaJCaG4wTixXrEHwGd5l9Oa7KZ1L2/se8ky8BTls00OJ1OAC9qc3BQlSqWnZQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e3nv6nx1b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 May 2026 05:35:34 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64D5OR5m031964;
	Wed, 13 May 2026 05:35:33 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e3nfgpbhn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 May 2026 05:35:33 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64D5ZUBc49086728
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 May 2026 05:35:30 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E6D1320040;
	Wed, 13 May 2026 05:35:29 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3C0632004B;
	Wed, 13 May 2026 05:35:28 +0000 (GMT)
Received: from [9.39.28.2] (unknown [9.39.28.2])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 13 May 2026 05:35:28 +0000 (GMT)
Message-ID: <e59776be-4a8b-4553-98dc-6283ebd5caad@linux.ibm.com>
Date: Wed, 13 May 2026 11:05:27 +0530
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
Subject: Re: [PATCH 1/3] powerpc/time: remove preempt_disable/enable from
 arch_irq_work_raise()
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Sayali Patil <sayalip@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com
Cc: linux-kernel@vger.kernel.org, Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        chleroy@kernel.org
References: <cover.1778057685.git.sayalip@linux.ibm.com>
 <a64fa7d86da51f78743bee26e16ae155c43016c7.1778057685.git.sayalip@linux.ibm.com>
 <pl30q6bq.ritesh.list@gmail.com>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <pl30q6bq.ritesh.list@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=KbvidwYD c=1 sm=1 tr=0 ts=6a040da6 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=pGLkceISAAAA:8 a=v7GjVOmr5oXViBslm-QA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDA0OSBTYWx0ZWRfX7qlmWm6eKoy5
 GI3SLg/3J/ripKfqpaoZNoGckZ4AThDaO8cJkSypTqFRzqhs1/bXr/o5tN7NY1BAI7iiDMDeKUu
 XQOXRuhLfEyDXcG5GQUHgKzcG+lJOl26/G8Y60yI594BO0YT9dQ9EHH9dj3CezZZUynjAtVfqcR
 6t3S5aOUDmeGmj9K2FbYN7lRQTRMvEaPRWFEgssURV30qaWcKziB2TAhzy97lnG8uKYMaCK2r2C
 +aSlHSWPuTcEgrKMa2CUzqN0CCf1yBfukLrefpS4G8cVGxsmysjOil7ScIEL7uTXkUhp5wsGT0o
 7TeS9OnvzYwdsmFL2y7wInUdFU7CehoCOOXNEOtgmURJ+iNtppDO6p/bFUReXVOcoZvXVdvSaKI
 /va++DYSbN54h3N9sDUet1GR5MxzvW+4hAGrLJBffGQEh+dZwU+l8PGDRuTJKKid0atCnGo8Udd
 fKkn6K1XY6rywR66toQ==
X-Proofpoint-GUID: D_itOF8TvEN-EncmPBTqyJg8dpN8gcKu
X-Proofpoint-ORIG-GUID: U3lz9non03QtN8HWEx95oSypQv83MXK7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 suspectscore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605130049



On 5/13/26 10:00 AM, Ritesh Harjani (IBM) wrote:
> Sayali Patil <sayalip@linux.ibm.com> writes:
> 
>> A kernel panic is observed when handling machine check exceptions from
>> real mode.
>>
>>    BUG: Unable to handle kernel data access on read at 0xc00000006be21300
>>    Oops: Kernel access of bad area, sig: 11 [#1]
>>    NIP [c000000000029e40] arch_irq_work_raise+0x10/0x70
>>    LR [c00000000003ffc8] machine_check_queue_event+0xa8/0x150
> 
> [14626.841925] MSR:  8000000000001003 <SF,ME,RI,LE>  CR: 88222248  XER: 00000005
> [14626.841939] CFAR: c00000000003ffc4 DAR: c00000006be21300 DSISR: 40000000 IRQMASK: 0
> 
> 
> Let's also add the above MSR state along with the call stack showing
> MSR[EE] was 0 when this triggered. This also shows the DAR as 0xc....
> while MSR[IR|DR] = 0.
> 
>>    Call Trace:
>>    [c0000000179d3c70] [c00000000003ff64] machine_check_queue_event+0x44/0x150
>>    [c0000000179d3d30] [c0000000000084e0] machine_check_early_common+0x1f0/0x2c0
>>
>> The crash occurs because arch_irq_work_raise() calls preempt_disable()
>> from machine check exception (MCE) handlers running in real mode. In
>> this context, accessing the preempt_count can fault, leading to the panic.
>>
>> The preempt_disable()/preempt_enable() pair in arch_irq_work_raise()
>> was originally added by commit 0fe1ac48bef0 ("powerpc/perf_event: Fix
>> oops due to perf_event_do_pending call") to avoid races while raising
>> irq work from exception context.
>>
>> Later, commit 471ba0e686cb ("irq_work: Do not raise an IPI when
>> queueing work on the local CPU") added preemption protection in
>> irq_work_queue() path, while commit 20b876918c06 ("irq_work: Use per
>> cpu atomics instead of regular atomics") added equivalent
>> protection in irq_work_queue_on() before reaching arch_irq_work_raise():
>>
>>    irq_work_queue() / irq_work_queue_on()
>>      -> preempt_disable()
>>        -> __irq_work_queue_local()
>>          -> irq_work_raise()
>>            -> arch_irq_work_raise()
>>
>> As a result, callers other than mce_irq_work_raise() already execute
>> with preemption disabled, making the additional
>> preempt_disable()/preempt_enable() pair in arch_irq_work_raise()
>> redundant.
>>
>> Remove it to avoid accessing preempt_count from real mode context.
>>
>> Fixes: cc15ff327569 ("powerpc/mce: Avoid using irq_work_queue() in realmode")
> 
> Agree with the Fixes tag. This patch actually moved mce to use
> arch_irq_work_raise(). It was ok until the CONFIG_PREEMPTION was
> disabled on powerpc since macros like preempt_enable|disable() were
> mostly a no-op. However, after lazy preemption got enabled, access to

Both full/lazy preemption. With upstream now, one can choose full or lazy only.
Leading to issue being discovered.

> preempt_count while in real mode can cause the issue you described.
> 
> 
> One more thing which we should add to the commit msg is:
> The arch_irq_work_raise() function executes in NMI context when called
> from MCE handler, hence we won't be preempted or scheduled out since we
> are in NMI context with MSR[EE]=0, hence it is safe to remove
> preempt_disable|enable() call from here.
> 
> And let's change the commit subject to:
>      powerpc/time: Remove redundant preempt_disable|enable() calls from arch_irq_work_raise()
> 
> 
> BTW, thanks for adding a nice commit msg with the sequence of events.
> With the above changes - pease feel free to add:
> 
> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> 
> 
>> Suggested-by: Mahesh Salgaonkar <mahesh@linux.ibm.com>
>> Signed-off-by: Sayali Patil <sayalip@linux.ibm.com>
>> ---
>>   arch/powerpc/kernel/time.c | 2 --
>>   1 file changed, 2 deletions(-)
>>
>> diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
>> index 4bbeb8644d3d..a99eb43f6ce9 100644
>> --- a/arch/powerpc/kernel/time.c
>> +++ b/arch/powerpc/kernel/time.c
>> @@ -471,10 +471,8 @@ void arch_irq_work_raise(void)
>>   	 * which could get tangled up if we're messing with the same state
>>   	 * here.
>>   	 */
>> -	preempt_disable();
>>   	set_irq_work_pending_flag();
>>   	set_dec(1);
>> -	preempt_enable();
>>   }
>>   
>>   static void set_dec_or_work(u64 val)
>> -- 
>> 2.52.0


