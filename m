Return-Path: <linuxppc-dev+bounces-21866-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2721CD6E57
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Jun 2026 09:56:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gV5nr0vgFz2xmX;
	Tue, 02 Jun 2026 19:56:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780394192;
	cv=none; b=AE0qex/4EsGe431yxtDKrf5QWzhJ7MtBo4w/+nZms2vwZELzIjfgjfHXDKpL4wmQLv8R1jcqCTjO1f9OZKekGEYdfPdBiR/PSvA5nwvO4gFvS3o12WD9S6naos8nsr/6N0hr5MjyBMSDEHErGEpviJhX4PbPZY8tCRSsLRR10U2hO4QGr3AxdmePOnhWP5EGjNZe4T6uRJSrQ8LOQmqbu1PrVrI74tqaRQ49SClQgYtFIe/sA2Q2RCeCANqcX1bzClECMFGsT7haoyigK/OtPJh5WFIJkQQjHYKp93MSKyvG5LPA5gNMkYwyWm2WEeGOzShnqr+loafevdOLw9+Jpg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780394192; c=relaxed/relaxed;
	bh=6NFs1gcsoMPduIPGD27oeqFTMJU7vQMAEWOlMrAJQEY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OCd22mCsqv1ISRJnYJ8ZWPzcuJE1YGwQJH/v4yF5+OGHUjuJD+9HlrUHCPe1ocG0Bz9GhYl4hYDUuU9vcSHFUXT3kdJpl5m9jYMgaiiGwcU0Sf2mSqjEV1Ol20yoWpzgAudaLQt1WH1Iqg/dh8ln/rgiD+uzC88h8+At7iFen/joro07/07AdPXelcDrosSr0k4Nc+MnBb+4HTcAAkct2vYBchjT3O0k8nvYzf8qswKuQp6IHHwWO+8I6enSlvXq0U0JyJ7kQpNHCEFxnJqcIQrutcvsOCl/OsGv7AGFAeKptZQ3QLBOrmnoHyzySmTP8YbG5TEmGcaJWkf2QqQ9SQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=iixJAEGx; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=iixJAEGx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gV5np6mMCz2xmV
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Jun 2026 19:56:30 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6524ZqLH1259298;
	Tue, 2 Jun 2026 09:56:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=6NFs1g
	csoMPduIPGD27oeqFTMJU7vQMAEWOlMrAJQEY=; b=iixJAEGxzqz0hdc5E8Gr9Z
	qY/J1WoL1eaF683MA8+6/0FxNh3Srbzs1U6vG1atkJLtc6QAvtreyrzEGV/DhIEQ
	7KpFDuKckxFyLIZEfgYArNzfXnuTmhZ3qVNur1aTQG0ZBlZ8fNTrVSHHfTMpB6oc
	QOaGAZ6YulCzXv/FOa1pgvU9VVSZw0VaKAickEwO287pNyKZ271cckntMfS4wxOQ
	gxjsussOOM6CKgwE5gxsWFs/cdp6hUEeo+lktI+ViEjy/40sMK53pB3SM2pF7NGR
	NtQ/m3ejXvxXfCPyM8X1xysqAG3fR5OzNJidI4T/GzZJ79BxAjT/htN80laQzmXA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqd45asu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2026 09:56:20 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6529sAuZ011343;
	Tue, 2 Jun 2026 09:56:19 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egbqhagwu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2026 09:56:19 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6529uFOa15794574
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Jun 2026 09:56:15 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A4BA82004B;
	Tue,  2 Jun 2026 09:56:15 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 32C8720040;
	Tue,  2 Jun 2026 09:56:13 +0000 (GMT)
Received: from [9.124.223.169] (unknown [9.124.223.169])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  2 Jun 2026 09:56:12 +0000 (GMT)
Message-ID: <b0211b41-a41b-4367-ae85-86cc2d6dd4b6@linux.ibm.com>
Date: Tue, 2 Jun 2026 15:26:11 +0530
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
Subject: Re: [linux-next20260529] kernel BUG at kernel/sched/core.c:7512!
To: Peter Zijlstra <peterz@infradead.org>
Cc: Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>,
        Ritesh Harjani <ritesh.list@gmail.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Srikar Dronamraju <srikar@linux.ibm.com>
References: <7904105b-9dfa-4efd-a5ef-bc0276ed255d@linux.ibm.com>
 <2f8c3d75-de2c-48bf-bd05-46b816d55c69@linux.ibm.com>
 <20260601095601.GN3102624@noisy.programming.kicks-ass.net>
 <37e69c39-564b-4ca9-bb27-1b99faab540c@linux.ibm.com>
 <20260602081845.GX3126523@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <20260602081845.GX3126523@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDA5MCBTYWx0ZWRfX3XY8uOpm7468
 zgA+Z6d3lpX1MY7s4gREBvBuHvKROQhWbOeQEBbH439AmU1fWi8tngI0GJbOW74Htk4+/gojZsJ
 h71tT+ZqhFzpTzdWwjqpNAsoCH81cT735SPTrf+wNVw6Ejg8bHNSnHmNk9+q1ZvhuLAknb6xJCv
 ddG0sdl2eDyLJpw/NMHzpaaRJIdWWbOU4nF0WCvvw+aJjBXGRN5h0b53BJ1RxBCd88lDIzFMtcj
 16tCZu4BMRecZ3hfMIvQgY7ITJy6NyNf6nYGELU24/jg7zsVBhXMjqB2Oi/V/TABEIfnHWE91lT
 QEUdCs6EUfqy/C90annoZWH0sbecrb+LX47vbXacg8kb93oVXopurg3wDm0yxjUXiS0ekpAmYI4
 MBHyOuEP4PcvSBfdf8tZ4x6VbBrk21J6+8CoqWP5NMcgColtliO4DgY4th45yvhb9aFpLRZvjjB
 FAq3OdYquGMkL6wE/LQ==
X-Proofpoint-GUID: ruGf97Uv-JGjTxiVajl1mkY6n4H_8BJC
X-Proofpoint-ORIG-GUID: IIcQ8M5KWEZaUnXmnYGAsD_tZL6C7Ypu
X-Authority-Analysis: v=2.4 cv=DZknbPtW c=1 sm=1 tr=0 ts=6a1ea8c5 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=z7ihmpYCtxdEyqqbbYAA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-02_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 suspectscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606020090

Hi Peter.

On 6/2/26 1:48 PM, Peter Zijlstra wrote:
> On Tue, Jun 02, 2026 at 01:26:48PM +0530, Shrikanth Hegde wrote:
>>
>>
>> On 6/1/26 3:26 PM, Peter Zijlstra wrote:
>>> On Mon, Jun 01, 2026 at 02:46:24PM +0530, Shrikanth Hegde wrote:
>>>
>>>> Ritesh, Mukesh, Is below possible scenario?
>>>>
>>>> do_page_fault seems to enable irq's in the interrupt handler?
>>>> is that expected? if so, one might see
>>>>
>>>> -- do_page_fault (enter kernel mode)
>>>>      -- enables interrupts
>>>>      -- gets interrupt - Sets need_resched.
>>>>         -- irqentry_exit - Sees it is kernel mode. Just checks preempt count
>>>> 			 and calls preempt_schedule_irq, which catches both
>>>> 			 preempt_count and !irqs_disabled. Hence the panic?
>>>>
>>>> Should do_page_fault do preempt_disable when it enables the interrupts?
>>>
>>> No, it is expected for page-fault to be able to schedule. Specifically,
>>> it must be able to sleep to support loading pages from disk.
>>
>> Oh yes. Ok. Thanks for taking a look.
>>
>>>
>>> Please check the value of preempt_count() (does it perchance have
>>> HARDIRQ_OFFSET?). Also, if the fault handler does enable IRQs, it must
>>> also disable them again once done.
>>
>> Will check it.
>>
>>>
>>> Notably, I see ___do_page_fault() do interrupt_cond_loadl_irq_enable(),
>>> but I'm not seeing a local_irq_disable() to match!
>>
>> Yes, that's likely the culprit. It is possible that ___do_page_fault runs for longer
>> and it may set need_resched. If it was in kernel mode, then it may not disable the
>> interrupt and then subsequent irqentry_exit panics.
>>
>> BTW I was able to consistently repro this on P9 with hackbench as below.
>>
>> for i in {0..10}; do ./hackbench 10 process 10000 loops; done;
>> for i in {0..10}; do ./hackbench 20 process 10000 loops; done;
>> for i in {0..10}; do ./hackbench 30 process 10000 loops; done;
>> for i in {0..10}; do ./hackbench 40 process 10000 loops; done;    << usually panics here.
>> for i in {0..10}; do ./hackbench 10 thread 10000 loops; done;
>> for i in {0..10}; do ./hackbench 20 thread 10000 loops; done;
>> for i in {0..10}; do ./hackbench -pipe 10 process 10000 loops; done;
>> for i in {0..10}; do ./hackbench -pipe 20 process 10000 loops; done;
>> for i in {0..10}; do ./hackbench -pipe 30 process 10000 loops; done;
>> for i in {0..10}; do ./hackbench -pipe 40 process 10000 loops; done;
>> for i in {0..10}; do ./hackbench -pipe 10 thread 10000 loops; done;
>> for i in {0..10}; do ./hackbench -pipe 20 thread 10000 loops; done;
>>
>> Note, if i run ./hackbench 40 process 10000 loops alone, it doesn't panic.
>> Likely some continous stressing needed to get into this case.
>>
>> Below diff helps to fix it. With it see test passes. Hackbench numbers aren't super happy
>> about it. It is regressing a bit compared to baseline. But no panic atleast.
>> AND i have changed the BUG_ON to WARN_ON as irq_disabled right after. We could still fix the
>> call sites if the warning is seen.
>>
>> diff --git a/arch/powerpc/include/asm/entry-common.h b/arch/powerpc/include/asm/entry-common.h
>> index de5601282755..7da373a56813 100644
>> --- a/arch/powerpc/include/asm/entry-common.h
>> +++ b/arch/powerpc/include/asm/entry-common.h
>> @@ -253,16 +253,17 @@ static inline void arch_interrupt_enter_prepare(struct pt_regs *regs)
>>   static inline void arch_interrupt_exit_prepare(struct pt_regs *regs)
>>   {
>>          if (user_mode(regs)) {
>> -               BUG_ON(regs_is_unrecoverable(regs));
>> -               BUG_ON(regs_irqs_disabled(regs));
>> +               WARN_ON(regs_is_unrecoverable(regs));
>> +               WARN_ON(regs_irqs_disabled(regs));
>>                  /*
>>                   * We don't need to restore AMR on the way back to userspace for KUAP.
>>                   * AMR can only have been unlocked if we interrupted the kernel.
>>                   */
>>                  kuap_assert_locked();
>> -
>> -               local_irq_disable();
>>          }
>> +
>> +       /* irqentry_exit expects to be called with interrupts disabled */
>> +       local_irq_disable();
>>   }
>>   static inline void arch_interrupt_async_enter_prepare(struct pt_regs *regs)
>>
> 
> I would suggest trying something a little more focussed like so:
> 
> diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
> index 806c74e0d5ab..b002c179415c 100644
> --- a/arch/powerpc/mm/fault.c
> +++ b/arch/powerpc/mm/fault.c
> @@ -589,6 +589,7 @@ static __always_inline void __do_page_fault(struct pt_regs *regs)
>   	err = ___do_page_fault(regs, regs->dar, regs->dsisr);
>   	if (unlikely(err))
>   		bad_page_fault(regs, err);
> +	local_irq_disable();
>   }
>   
>   DEFINE_INTERRUPT_HANDLER(do_page_fault)
> 
> Since only ___do_page_fault() will enable interrupts, you only need to
> disable them again on its return path.
> 

Seems there are more...

do_program_check (called by program_check_exception, emulation_assist_interrupt)
alignment_exception
SPEFloatingPointException
facility_unavailable_exception


Many looks like it can recover only if hit in userspace.
Hence i though it would make sense to put it under arch_interrupt_exit_prepare
which is called just before irqentry_exit.

