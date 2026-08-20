Return-Path: <linuxppc-dev+bounces-26024-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85297C5DF81
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Aug 2026 16:06:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hQpGP6r7qz2xT6;
	Fri, 21 Aug 2026 02:06:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787241997;
	cv=none; b=b9FIywxDi9tu6ID7Up1+sAhVtRTUkYNOBCcYDFFez3sTK8RK/hIaOYHbpwcjmCOUJgeNmUtJnujzDk/xVYIo4aHV4NFaUKfnlyTlGTPHk4QTdXYoSBboa2Grcc5Q6Daf75wwMgBZDfBkEh8qo+CUqom/1nspZBTaFt3FO/2fnK+ZBSsQJH9q9pg2TxSb3QQwYg6uDlOb6IRDcbjwYtR7aYgWiRKK6Y3BrRkC0KzVm3mYTddza4//jZquLXz8ITFkPGE1WHFn/zZV4z7ox2xXO0pYoafHJ/XjVR4YqtZQX8Og0aWRVWDwvZZW8RF1wnqqYfglm0mOcetuT921us91AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787241997; c=relaxed/relaxed;
	bh=OmDGCLOLvz9twqmNhvVULGwHz+Mhciv2KBabJXzZfCw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hplTJYzHDaJ+fXLHF1RSxYL/LNojycLD7L7UZTYD9srmPXHNK4uuo5qzH71vAOAgJP/IB6Dyl/+rjUMlSvXcedXfHxIUl5YSTOZlI2tsif+HR5OfZxrdpvRyqv6Gt6xwZv3CZXCK/PuuUKvGT0uOx/3PLRmajcd46+aNRM2oHNYbufUbqXGafmEPvmYqyq60mx7CBrpFN6ytP6UW1of9NdwwtMlJyJKrJkaAp9g+TMbf/SJSA9bWsriwprw7G2FUrqLh9pDw/J2B+G/iWSVnFS1f18yG573vvU0rvUuU16i0Uvo93Wng20pNt6iKMiGgFvQwpS8CjJ9WnhNQm1OW5A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=AaDD6BW2; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=AaDD6BW2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hQpGN5bHDz2xRw
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Aug 2026 02:06:35 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67KEVl3G2771358;
	Thu, 20 Aug 2026 16:06:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=OmDGCL
	OLvz9twqmNhvVULGwHz+Mhciv2KBabJXzZfCw=; b=AaDD6BW2aK5JA/Lv25mZaT
	MLHWPmO39PXdXT8ONZBZHln/gg0hL5ahh9xrk/YqdoTzUvEm+5cHPLlDcp3PisZ6
	3i1YNGL1RuOWaZDRk826RU9iuCKiq+NZFfX48KacZA1aWulAkakVaqdiXrl+QYpu
	bJCb5EDZfKeVijHPbHr2/6WOaWGV+7TFyI+jxxXdg81whtO8UO1N52/yzAJxQpNL
	IGPrQSkr/1zeAXeKyzsENRj48sFzIT+ICVWsC2TNnv60XwkuZruv+rXKDa9zRWI0
	BrP2nK687qyAr35j9+OiIFwtF7VXs7IRkZitrhh6xpRR1lW77r0Bs1B4z/DnXIMQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu4b9rj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Aug 2026 16:06:23 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67KFuJU0008714;
	Thu, 20 Aug 2026 16:06:22 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g34ngq8xd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Aug 2026 16:06:22 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67KG6M1m47972680
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Aug 2026 16:06:22 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F1E8658059;
	Thu, 20 Aug 2026 16:06:21 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1AC4358057;
	Thu, 20 Aug 2026 16:06:19 +0000 (GMT)
Received: from [9.61.245.245] (unknown [9.61.245.245])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 20 Aug 2026 16:06:18 +0000 (GMT)
Message-ID: <09660675-05db-4a06-8d1f-4697f45b0752@linux.ibm.com>
Date: Thu, 20 Aug 2026 21:36:17 +0530
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
Subject: Re: [PATCH V2] powerpc/entry: Fix irq_soft_mask corruption on
 replayed interrupt exit
Content-Language: en-GB
To: Shrikanth Hegde <sshegde@linux.ibm.com>,
        "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        chleroy@kernel.org, mchauras@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20260820134718.2176411-1-mkchauras@gmail.com>
 <2e16b624-be55-4127-8ec8-db9479957f96@linux.ibm.com>
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
In-Reply-To: <2e16b624-be55-4127-8ec8-db9479957f96@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=CpuPtH4D c=1 sm=1 tr=0 ts=6a872600 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8 a=aLwFzr78qqh7rE2BBSIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Vfr3wVg2-YYIcKAa1YzkQWfAyIbXSYnR
X-Proofpoint-GUID: yMgSVNtu2OSdhaicQ_x5jg_8km_3xFdz
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDEyMSBTYWx0ZWRfX68HiTtc2N2gt
 YjZ9GnM03enubWQpnpeM5guWhx4BLr4TW7GUp6/VMrrYeTzJXA5aVBJIhjsBcYfF3llP5tawlWW
 HoYVN4Kms/90dKSp9w4lYeRIynG4jpg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDEyMSBTYWx0ZWRfXzQ+4QftW4O2I
 zDio5+z9TN6AXlpcUg53m+6TcbEobrViJMJAMAdzAZbqiBZGhMqjEF16VM0obt17zIallfW4vzd
 iC2V7UwmJB+kGkWbaYNPuby47bJ1xvb+r8Qe4LA237INcYLlvLIlJBn2lOTtaHGCOz1mDK4bjuo
 pNxkA905F2BNETg9xIghZKXRmQFDFlXzCw5i1M3jMiBB+kWgNFx0QHXZ7blL4ynQX5y+Iyn/tSR
 lsbpiyNL1BPJBBPpIIoOj6E38YU8fl9sAjj/k1WMrygg5QmdFqCJoS3+JK3WsO9xEMBZpo3CQ9H
 0bIBSXkHB4nYGf+/yOWmzB4URPSOE2WqCweecq5e37E687v8wrTzvViouTHlwmksJQmcrYPqfV3
 gh6svS+E2RpzY2UfpxzSwh1nZ5sWLvGo1T2j5Qt/KB96q4nwhNYzVu1kKApho2zo9UN0IDu3McN
 ctTlP+C180Wa8UFJJ9g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608200121


On 20/08/26 8:17 pm, Shrikanth Hegde wrote:
>
>
> On 8/20/26 7:17 PM, Mukesh Kumar Chaurasiya (IBM) wrote:
>> When __replay_soft_interrupts() replays a pending interrupt (e.g.
>> PACA_IRQ_DEC → timer_interrupt), it calls the handler directly with a
>> synthetic pt_regs. The DEFINE_INTERRUPT_HANDLER_ASYNC wrapper around
>> each handler calls arch_interrupt_async_exit_prepare() on the way out,
>> which calls arch_interrupt_exit_prepare() → local_irq_disable() →
>> arch_local_irq_disable(), which does:
>>
>>      irq_soft_mask_set(IRQS_DISABLED)   /* 0x1 */
>>
>> This unconditionally overwrites irq_soft_mask with IRQS_DISABLED (0x1),
>> stripping the IRQS_PMI_DISABLED (0x2) bit. The result is that
>> irq_soft_mask is 0x1 instead of IRQS_ALL_DISABLED (0x3) when the
>> handler returns to __replay_soft_interrupts().
>>
>> For a normally-taken interrupt this is harmless: the next interrupt
>> always enters through arch_interrupt_enter_prepare() which
>> unconditionally sets irq_soft_mask to IRQS_ALL_DISABLED.
>> But during replay, next_interrupt() is called
>> directly between replayed handlers without going back through
>> arch_interrupt_enter_prepare(), so the stripped bit is never restored.
>> next_interrupt() then fires a WARNING:
>>
>>      WARNING: arch/powerpc/kernel/irq_64.c:75
>>      WARN_ON(irq_soft_mask_return() != IRQS_ALL_DISABLED)
>>
>> This was introduced by commit bee25f97ad24 ("powerpc: Enable
>> GENERIC_ENTRY feature"). Before that commit, the old
>> interrupt_async_exit_prepare() called irq_exit() followed by an empty
>> interrupt_exit_prepare() stub and never touched irq_soft_mask at all,
>> so the soft mask was left at IRQS_ALL_DISABLED throughout replay.
>>
>> The root cause: arch_interrupt_exit_prepare() uses local_irq_disable()
>> whose only job is to set the IRQS_DISABLED bit; it has no knowledge of
>> IRQS_PMI_DISABLED. It is there to satisfy irqentry_exit()'s
>> requirement that interrupts be disabled, but using the plain
>> irq_soft_mask_set(IRQS_ALL_DISABLED) is the right primitive:
>>
>>    - irq_soft_mask_set(IRQS_ALL_DISABLED): sets soft mask to 0x3
>>      (both IRQS_DISABLED and IRQS_PMI_DISABLED). Touches only the soft
>>      mask. MSR[EE] and PACA_IRQ_HARD_DIS are already correct because
>>      hard interrupts were never re-enabled during replay
>>      (PACA_IRQ_REPLAYING is in PACA_IRQ_MUST_HARD_MASK, which blocks
>>      should_hard_irq_enable()).
>>
>>    - local_irq_disable() / arch_local_irq_disable(): sets soft mask to
>>      IRQS_DISABLED (0x1) only, silently dropping IRQS_PMI_DISABLED.
>>
>>    - hard_irq_disable(): also issues __mtmsrd to clear MSR[EE] in
>>      hardware and sets PACA_IRQ_HARD_DIS — redundant and wrong here
>>      since both are already set.
>>
>> Fix by replacing local_irq_disable() with 
>> irq_soft_mask_set(IRQS_ALL_DISABLED)
>> in arch_interrupt_exit_prepare(), making the exit symmetric with the
>> entry path in arch_interrupt_enter_prepare() which always sets
>> IRQS_ALL_DISABLED.
>>
>> The warning was observed early in boot on a POWER10 pseries guest
>> during kmem_cache_init_late(), where a spinlock release triggers
>> interrupt replay that processes a pending timer interrupt.
>>
>> Debugger state confirming the bug:
>>    Before timer_interrupt(&regs):
>>      irq_soft_mask = 0x3 (IRQS_ALL_DISABLED)   correct
>>      irq_happened  = 0x41 (HARD_DIS|REPLAYING)  correct
>>    After timer_interrupt(&regs) returns:
>>      irq_soft_mask = 0x1 (IRQS_DISABLED)        WRONG — PMI bit stripped
>>      irq_happened  = 0x41                        unchanged
>>
>
> Indeed. Thanks for the fix and good explanation.
>
> Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>
>> Fixes: 334f3f6d7a16 ("powerpc/entry: Disable interrupts before 
>> irqentry_exit")
>> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
>> Closes: 
>> https://lore.kernel.org/all/6f9bfb0f-b14c-468e-bb9f-c157d120d0dc@linux.ibm.com/
>> Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
>> ---


This patch fixes the reported issue.

Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>


Regards,

Venkat.


>> Change log:
>> V1 -> V2:
>>     - Instead of using hard_irq_disable use irq_soft_mask_set
>> V1: 
>> https://lore.kernel.org/all/20260812152035.1661781-1-mkchauras@gmail.com
>>
>>   arch/powerpc/include/asm/entry-common.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/include/asm/entry-common.h 
>> b/arch/powerpc/include/asm/entry-common.h
>> index c5adb5006361..2a153dca962c 100644
>> --- a/arch/powerpc/include/asm/entry-common.h
>> +++ b/arch/powerpc/include/asm/entry-common.h
>> @@ -270,7 +270,7 @@ static inline void 
>> arch_interrupt_exit_prepare(struct pt_regs *regs)
>>       }
>>         /* irqentry_exit expects to be called with interrupts 
>> disabled */
>> -    local_irq_disable();
>> +    irq_soft_mask_set(IRQS_ALL_DISABLED);
>>   }
>>     static inline void arch_interrupt_async_enter_prepare(struct 
>> pt_regs *regs)
>
>

