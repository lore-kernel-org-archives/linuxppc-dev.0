Return-Path: <linuxppc-dev+bounces-18970-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B49FF3D5FA
	for <linuxppc-dev@archiver.kernel.org>; Sun, 29 Mar 2026 09:18:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fk81f610yz2yYs;
	Sun, 29 Mar 2026 20:18:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774775894;
	cv=none; b=azXvRa3r3oafgahGJvg/gIhdDbf9KMXmskn7xMyE2nzwer5J5tfKukFYlaJgVjaRLM5ik9WGQsj1cXCjtcNz+YypRrX0HgsA2iUWtYi3kLtpH56U6FVbJLoN76ZZiUma680o8TOrxCEpQgO7cgyG4W8hivTsnt7cGPG4clRR2nz6qRF7G3Cv0j+Z39hTaSj59+J7XNtomskvBRsLzNKuqddrVNA35gXsqYC1MjD7cVs1r4Nr7dA+cjsphl7/AfsLSDCPDjrj89h1ADSdm5JH10w4mN3PFaTOUlSKXlSy9u6eXc1BhHVpPT1ixavgjPwNbIbRkKeeUI+KCsueFF/5Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774775894; c=relaxed/relaxed;
	bh=UsQXxPbm87yDctm8J27Q+AHlezFNkvrBWesRo6sfR8w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fRwDXHpdUEPrT2wCIIFdqtxnbSdEoXNySvCl/6lihhceCShUt05eoWDq5jdPDAf/r0W2jOvfN9a4nynzJeaSbqPBsLPWDZqoAl/EYZVuAELuGyCq4NXCrY9J64nIjYxeql7tRmrTQUT50lvdGbpYFLvBv1uphHFsivqgc+X+CLqQN1VJkwx2ErudJjaB0BJ52S1VDSgVMxS/CcukJ2QTmUjeD6Y8Izt7A8o5DAxewfJ7lt396uV8M6KNasutnthdUSAKjCMC9cKPHcSb4UjX+prP3+JDuYCnJflcHFLC2v3BIxr1hsrHA5UZnxNij2QhvZuBipF5F2v90tBNxi5iFg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=KkExcN9G; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=KkExcN9G;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fk81d6hH2z2xgv
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Mar 2026 20:18:13 +1100 (AEDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62T4MFqB2390841;
	Sun, 29 Mar 2026 09:18:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=UsQXxP
	bm87yDctm8J27Q+AHlezFNkvrBWesRo6sfR8w=; b=KkExcN9GaGz1AVBq7onA7Z
	EisnCJI7nfgilABmDfPh2F2clOCyUkWHv3CdJe7bdvGrG5fESyG6dBZzmilKeXY8
	sa470Od3sXhBtnD++Edx1M1KGzSsricbX2gcd2gx0DzYhqB7BiN/g6b7QeiYnyQS
	gbuw7A7KU6jg9AcpV4HDfEFatMYyNpUasG2cElZ6fF8Y+oIVRLM2A7MFbZhEN35V
	BCSyiLJwTa697xxwG0x2uvHO/zsmMuXt6TgQvJRnvCkG0m1nqGNrK+eYVlAZR+DD
	aslg0fPwVphp166HpiiPO7UaKrBLd6KSW1V64f34qbcylzQ8gtpcdFNwm+tylRcg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d64dgb59j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 29 Mar 2026 09:18:07 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62T83CjM005910;
	Sun, 29 Mar 2026 09:18:07 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d6spxs10f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 29 Mar 2026 09:18:07 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62T9I5sS56426990
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 29 Mar 2026 09:18:05 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 39B8120043;
	Sun, 29 Mar 2026 09:18:05 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DC14620040;
	Sun, 29 Mar 2026 09:18:03 +0000 (GMT)
Received: from [9.124.221.218] (unknown [9.124.221.218])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 29 Mar 2026 09:18:03 +0000 (GMT)
Message-ID: <59fc5aaf-6704-40f2-82bf-a2e6c7fa35ad@linux.ibm.com>
Date: Sun, 29 Mar 2026 14:48:03 +0530
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
Subject: Re: [PATCH 1/2] powerpc: Use cpumask_next_wrap instead
To: Yury Norov <ynorov@nvidia.com>
Cc: maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, yury.norov@gmail.com,
        linux@rasmusvillemoes.dk, linux-kernel@vger.kernel.org,
        chleroy@kernel.org
References: <20260327063129.127302-1-sshegde@linux.ibm.com>
 <20260327063129.127302-2-sshegde@linux.ibm.com> <acg9pa74Go58lq0O@yury>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <acg9pa74Go58lq0O@yury>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI5MDA3MSBTYWx0ZWRfXzCsqQOLFvtu0
 r0WzUeFTlJH3pTS+hUPkUsva6syZGts8r/ZH6iCBwGDJsOtDFFTQ7HGzeRl6bDWJQ/wPk259tsL
 I2UarEPToWdtSSUIY/n7yKFdz6BILFke08xSc/qo4gyBtqScgZf40U1z11UFojrkrZ0SFy7WQbv
 8RpByiivue6vGHIyUj8ufIuxi9SUhgkpInDf1w0SvP2eY6oWzoeqOzW3wGdWg7rRb13qJ6cVyWz
 EJjQwjCbypfmxJRcV0XuVbZi0AWf+DWa8C0zhTUlKZVI8y1q09A9YXMtsfbFGScYOm1GgGBirkp
 8gVjc76vyLkUgxtLqrsZCxF9zy6LSVROKwNhlrTz5uoLh5DkL6Y7ug/j6OexgQDiap/QKJsFkXY
 0YFwSJRIfoaRoOl5PT8AV+Pcs4olfGQePWglr9zs0yHHFda/BfGmDpy7Dc/c+IMdP7IFFZm5wmJ
 4e6uNEZyPuZiijUkqpg==
X-Authority-Analysis: v=2.4 cv=QKZlhwLL c=1 sm=1 tr=0 ts=69c8ee50 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=pGLkceISAAAA:8 a=A5xHZKZMv6EtbT0R9gcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 1f4AHuaSFWTL8hz0xvLHcwo4humqSzY4
X-Proofpoint-ORIG-GUID: bBM-3Q_wq_uDtBem9KGrAKBbnCve79tu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_02,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 adultscore=0 impostorscore=0 clxscore=1015
 spamscore=0 bulkscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603290071

Hi Yury.

On 3/29/26 2:14 AM, Yury Norov wrote:
> On Fri, Mar 27, 2026 at 12:01:28PM +0530, Shrikanth Hegde wrote:
>> cpu = cpumask_next(cpu, mask)
>> if (cpu >= nr_cpu_ids)
>>      cpu = cpumask_first(mask)
>>
>> Above block is identical to:
>> cpu = cpumask_next_wrap(cpu, mask)
>>
>> Replace it, No change in functionality or performance.
>> Slightly simpler code.
>>
>> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
>> ---
>>   arch/powerpc/kernel/irq.c             | 5 +----
>>   arch/powerpc/mm/book3s64/hash_utils.c | 4 +---
>>   arch/powerpc/sysdev/xive/common.c     | 5 +----
>>   3 files changed, 3 insertions(+), 11 deletions(-)
>>
>> diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
>> index a0e8b998c9b5..f69de08ad347 100644
>> --- a/arch/powerpc/kernel/irq.c
>> +++ b/arch/powerpc/kernel/irq.c
>> @@ -370,10 +370,7 @@ int irq_choose_cpu(const struct cpumask *mask)
>>   do_round_robin:
>>   		raw_spin_lock_irqsave(&irq_rover_lock, flags);
>>   
>> -		irq_rover = cpumask_next(irq_rover, cpu_online_mask);
>> -		if (irq_rover >= nr_cpu_ids)
>> -			irq_rover = cpumask_first(cpu_online_mask);
>> -
>> +		irq_rover = cpumask_next_wrap(irq_rover, cpu_online_mask);
>>   		cpuid = irq_rover;
>>   
>>   		raw_spin_unlock_irqrestore(&irq_rover_lock, flags);
>> diff --git a/arch/powerpc/mm/book3s64/hash_utils.c b/arch/powerpc/mm/book3s64/hash_utils.c
>> index 9dc5889d6ecb..e4fcf929cb33 100644
>> --- a/arch/powerpc/mm/book3s64/hash_utils.c
>> +++ b/arch/powerpc/mm/book3s64/hash_utils.c
>> @@ -1299,9 +1299,7 @@ static void stress_hpt_timer_fn(struct timer_list *timer)
>>   	if (!firmware_has_feature(FW_FEATURE_LPAR))
>>   		tlbiel_all();
>>   
>> -	next_cpu = cpumask_next(raw_smp_processor_id(), cpu_online_mask);
>> -	if (next_cpu >= nr_cpu_ids)
>> -		next_cpu = cpumask_first(cpu_online_mask);
>> +	next_cpu = cpumask_next_wrap(raw_smp_processor_id(), cpu_online_mask);
>>   	stress_hpt_timer.expires = jiffies + msecs_to_jiffies(10);
>>   	add_timer_on(&stress_hpt_timer, next_cpu);
>>   }
>> diff --git a/arch/powerpc/sysdev/xive/common.c b/arch/powerpc/sysdev/xive/common.c
>> index e1a4f8a97393..b6446abe29a6 100644
>> --- a/arch/powerpc/sysdev/xive/common.c
>> +++ b/arch/powerpc/sysdev/xive/common.c
>> @@ -577,10 +577,7 @@ static int xive_find_target_in_mask(const struct cpumask *mask,
>>   		 */
>>   		if (cpu_online(cpu) && xive_try_pick_target(cpu))
>>   			return cpu;
>> -		cpu = cpumask_next(cpu, mask);
>> -		/* Wrap around */
>> -		if (cpu >= nr_cpu_ids)
>> -			cpu = cpumask_first(mask);
>> +		cpu = cpumask_next_wrap(cpu, mask);
> 
> Again, for all except this:
> 
> Reviewed-by: Yury Norov <yury.norov@gmail.com>
> 

Thanks for the review.

> 
> Can you move my series for xive_find_target_in_mask() together with
> your patches?

Sure.
I can add your patch to this series and send it.

PS: Sorry, I hadn't seen your series.

