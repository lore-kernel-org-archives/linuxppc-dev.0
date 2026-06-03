Return-Path: <linuxppc-dev+bounces-21971-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03BDBCD6E4A
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Jun 2026 11:56:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gVmQD3wmNz2yZZ;
	Wed, 03 Jun 2026 21:56:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780487812;
	cv=none; b=Q3BWs1gop77ODFrWOU0s5YHkEZ3/UnJrB+ZSwJ3fAOBBgQkfX3d0J7suciyrjV1mzxUDwpnkynGX3r+EdUU5YmMLzl3B1THfcukkaDcl6Kw79O/L6qJjwW/3WWHLQRY+ZzJq5xbcTezOMXpzaHRTkksMEL3E0irKcVc5hSwv11sZHmUROEis8uUcaSce0f4/eamQYL04fI/7wNgp3khudllYoNSB4Su/xkIcP/ZdZjGigeVANy17yXetvaRUIRnUSyqoGinBUvzK/4OLUviGqXRBXkJUuPjmDlBXGWi/Is+weatkM/oXQ+jjeyi5qZk/EeTDHQYNBqk5OVLRJTuXPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780487812; c=relaxed/relaxed;
	bh=UO3MIFfhccw12p0CdbER19mA1q+lmi84NbpI5QdiWfs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f8aJ+qZjE47vzh80kktg+yryswcBOywQGJmCTPt4JuHnL982t6FiDzs6qeQfEesOS/SlGHVii32xVJxJ1QzxgBlqH1g90Q/3EuDjO7z8ML+kJz0gYfCcbhNm7calLcUP8LEtWEhIzzisrtshJ64CdW8D1ho+Sc5OrbuUawMlxDVxZdHI6Zfz6kFUCwqYGZK4oGzK5eHVH0If4AEmFeaSOXevrfGGBY7OlsDiGU+70WANW2M58PNordd/D7+pEEMP32D9+M5DXco5gclgfxa7iGtBbymNXmXTWzE/JS1zOzS0yepCY+FKeZ0p1xFyjssWQcC2/ya0ZN1hyXfbqMAgPw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=GjRcMIc2; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=GjRcMIc2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gVmQC2BNqz2yL8
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Jun 2026 21:56:50 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 652KqxIN3662646;
	Wed, 3 Jun 2026 11:56:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=UO3MIF
	fhccw12p0CdbER19mA1q+lmi84NbpI5QdiWfs=; b=GjRcMIc2Gj/2jxk2Zp+Sdu
	g8Ce/FNgI7xsiJI4vLJHuhO7ylZglfrWAIcm9X/MI1ZCk+WhbubFRoFIRf2IK+1Q
	rgAJEL2YEMvO6B7+WxUsKmdJTimugDVHK6+sZ8vh7PT4vjar/VO1d52TSq+gbE7K
	xN5gUYMMu/AU6wO1pCW1bwdt1OT6eLBWXXsTXCZGIQEJ5bzUEwSj6f6LqQKtUgmf
	gRQhgQ6b29imjRYgjCd0bx+gjoX8dsjbjJdBbwSYGctHdgZUQrEm9o98rrP9NE60
	bJvVG5lnxvPgXEQ8ecLKxHNXn2Jwkywo50NiBYWSQOKrx2U+/n1xAsxuEF9+7+Ng
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqjqampf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jun 2026 11:56:38 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 653BsBqc014467;
	Wed, 3 Jun 2026 11:56:37 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egakw03j0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jun 2026 11:56:36 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 653BuXKn49152280
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 3 Jun 2026 11:56:33 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4283E20040;
	Wed,  3 Jun 2026 11:56:33 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 52C0420043;
	Wed,  3 Jun 2026 11:56:31 +0000 (GMT)
Received: from [9.124.223.153] (unknown [9.124.223.153])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  3 Jun 2026 11:56:31 +0000 (GMT)
Message-ID: <bb77de91-7f7c-4127-b796-7af91df23634@linux.ibm.com>
Date: Wed, 3 Jun 2026 17:26:30 +0530
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
Subject: Re: [PATCH] powerpc/entry: Disable interrupts before irqentry_exit
To: Peter Zijlstra <peterz@infradead.org>
Cc: maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, tglx@kernel.org,
        christophe.leroy@csgroup.eu, linux-kernel@vger.kernel.org,
        venkat88@linux.ibm.com, mkchauras@gmail.com
References: <20260603095521.198267-1-sshegde@linux.ibm.com>
 <20260603101155.GV3493090@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <20260603101155.GV3493090@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: itt5-Q3ZKYhE6XXQKz5728e62fOQv5mg
X-Proofpoint-GUID: c7x6ZE-xp8GOn9VvslhlKlFsj_z8oMx8
X-Authority-Analysis: v=2.4 cv=bcVbluPB c=1 sm=1 tr=0 ts=6a201676 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=wueMUnZoocIZ5A2Ub7QA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDExMSBTYWx0ZWRfX+XwJFN4kUhow
 sN1+7LnADpjW9Sb2N3icDjXuztodW04azIrUHxB+lhUJrXEmYW9R85nXV/u/9NSo1X5ncg88Spi
 dT5H44sM/rJbOn/4U00+8xNCoh/VnE3wa0tERj/UgiI3KbFvNvFbn8npNOR1lpjNUcI3lIlnERY
 M7lsNyPH8P54p+h+zzgdn1j/fh3elx/w1VDef/xbTUtCVKKypSsqE/fMsEsOVCFtrMVzdazfnEV
 eo8cDggjGGzd3bkT4AKmgbLNM0d69lqOy/CrGNZVFgNbrPC2mgv9UMBlBLjXSZ8w0Wq+PTgRUVR
 crQ9CXpRLbq7x4I03qfOxO2aMH2RwF3DcMeOreitwuj2PBA2VNzZ7eRk6aQOLZBqpnLlivXlUai
 O6HFmOcGXykUTYEKaAwSAg4TaZ5iVpVn8gsjVSQuakgMbmq9UGInceJVCYmyA8f5J/Js3wtoBlj
 lyfQ8/C1iv6fwA4AMsg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 adultscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030111

Hi Peter. Thanks for taking a look at it.

On 6/3/26 3:41 PM, Peter Zijlstra wrote:
> On Wed, Jun 03, 2026 at 03:25:21PM +0530, Shrikanth Hegde wrote:
>> Venkat reported a panic on powerpc-next tree where GENERIC_ENTRY has
>> been enabled.
>>
>> kernel BUG at kernel/sched/core.c:7512!
>> NIP  preempt_schedule_irq+0x44/0x118
>> LR   dynamic_irqentry_exit_cond_resched+0x40/0x1a4
>> Call Trace:
>>   dynamic_irqentry_exit_cond_resched+0x40/0x1a4
>>   do_page_fault+0xc0/0x104
>>   data_access_common_virt+0x210/0x220
>>
>> This happens since __do_page_fault ends up enabling the interrupts and
>> it could take significant time such that need_resched could be set. This
>> leads to schedule call in irqentry_exit leading to the bug.
>>
>> There are many such irq handlers which enables the interrupts.
>> Fix it by disabling the irq before calling irqentry_exit. The same
>> pattern exists today in interrupt_exit_kernel_prepare.
>>
>> While there, make those BUG_ON into WARN_ON. Interrupt is disabled right
>> after so it is not that severe. This will still help to catch the
>> offending callsites.
>>
>> Fixes: bee25f97ad24 ("powerpc: Enable GENERIC_ENTRY feature")
>> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
>> Closes: https://lore.kernel.org/all/7904105b-9dfa-4efd-a5ef-bc0276ed255d@linux.ibm.com/
>> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
>> ---
>>
>> This applies on top on powerpc/next tree.
>> base: 6ed60999d33d '("powerpc: Remove unused functions")'
>>
>>   arch/powerpc/include/asm/entry-common.h | 9 +++++----
>>   1 file changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/powerpc/include/asm/entry-common.h b/arch/powerpc/include/asm/entry-common.h
>> index de5601282755..7da373a56813 100644
>> --- a/arch/powerpc/include/asm/entry-common.h
>> +++ b/arch/powerpc/include/asm/entry-common.h
>> @@ -253,16 +253,17 @@ static inline void arch_interrupt_enter_prepare(struct pt_regs *regs)
>>   static inline void arch_interrupt_exit_prepare(struct pt_regs *regs)
>>   {
>>   	if (user_mode(regs)) {
>> -		BUG_ON(regs_is_unrecoverable(regs));
>> -		BUG_ON(regs_irqs_disabled(regs));
>> +		WARN_ON(regs_is_unrecoverable(regs));
>> +		WARN_ON(regs_irqs_disabled(regs));
> 
> So while you will indeed disable IRQs righ below. This checks the IRQ
> state of regs, not the current state.
> 
> What you are allowing through it a *userspace* state that has IRQs
> disabled. That is an invalid state.

Ok. I should have seen it closely. Let me keep them as is.

> 
>>   		/*
>>   		 * We don't need to restore AMR on the way back to userspace for KUAP.
>>   		 * AMR can only have been unlocked if we interrupted the kernel.
>>   		 */
>>   		kuap_assert_locked();
>> -
>> -		local_irq_disable();
>>   	}
>> +
>> +	/* irqentry_exit expects to be called with interrupts disabled */
>> +	local_irq_disable();
>>   }
>>   
>>   static inline void arch_interrupt_async_enter_prepare(struct pt_regs *regs)
>> -- 
>> 2.47.3
>>


