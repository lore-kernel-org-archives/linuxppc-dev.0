Return-Path: <linuxppc-dev+bounces-27811-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62FFDC982DE
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Sep 2026 06:53:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hpDTb6ZJsz2xk7;
	Mon, 21 Sep 2026 16:53:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789973619;
	cv=none; b=Bg+D2C2bOq8p3+qUwNkTYjpEQSBdZra4JVvRdEVS9vxnsd4k5I2DC3BwizdpGa2H8L5PtGvD0+r3fNJVs2i2wUekzJPuIJ7uRR1dCUZKjsMXVkxkj09IdIY1fR0c09noRS6H/7Xe4h42vaxSmN898gM3IATGGpxoS6G3/wtXQ1jffB7mmTtvuyMBj63U+ooMV4W0ONd1tyI+DTpBEvK26UcScHC13XNYWKmZFjle5FPrbwaiKFnI9ojEvkFGyqXM0q/+N4TfDHp+sPP74605J9N56CeQV8N4wxukWb5ElHRzIfZT16DAHj8mXxMEUjefc9kM3L430R8NzqQGVaJY0A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789973619; c=relaxed/relaxed;
	bh=VK5a2KS2S+bmw3jNmEBZ0KEWcR1V3rhpzXlXmQG6Y3I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fG2DWDK0AFT5bKE99l4VUymxyVT262zpz5q7W9PQh/CS6PNtkZaGIJt4A/Ht3p9zgzM1s9r4tjdaxPI2sjcoI1gB6VZ9TSMGwFMZz4/wjgVugWAALt+d23uFvwCKAKthARPz0rTnhml4RPSBKs/pEurA+U+XyPuz0+kfRRW03Fy4dQE1pXiq4wQkFlmE8QVT6mYeXTtfyJe891a5H/6ZxSgWN2z0PZ/ixt2D4xWYtDQUabETXwHsmJorhCaxex+x7OZO40m7TEuOh0AgKuqFK33TJJmrektQ1SHPcSCj4F0/gxOdTm9bzeWiM5QkMraDs9NnUoCa4WS9NpDsvXoSQQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=I64v42iE; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=I64v42iE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hpDTZ66RGz2xCC
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2026 16:53:37 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68L3aUMc122428;
	Mon, 21 Sep 2026 06:53:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=VK5a2K
	S2S+bmw3jNmEBZ0KEWcR1V3rhpzXlXmQG6Y3I=; b=I64v42iEa3aAaoivcyjD8d
	6vLj+Z36bZ9pxzOrUXr7NpMv6w0FS5Hqei0d20zXdPp3aIj9mMflvmxXCwuEltjL
	F73Mev3pZfMnNd+TjKTYvPz50rJveEZy13SZ2uHwnKiNA0CGAYABrhOPbSwYl6Vw
	E6Tbr9/MslP6Nuhu768+xPbTMES8o4mPk4hJYuZE4KVBlnIgzRaW5jWzLcHbOZG7
	okdq0PWvTL2JgiGHtwdZbnDUPXLsmzilCcyULiXpiVZvZuLsBwqnRoZoXDuC9Ucv
	srARC5gpuYQJ46kLkxPAvy2/8GbWSZVpFSF7ZJ7YJ6oQGHfSrCgZTeMvSuzYO0fw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske1719x-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 06:53:25 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68L3XWnm1596405;
	Mon, 21 Sep 2026 06:53:24 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gt7dy3wmj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 06:53:24 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68L6rLMT47251800
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Sep 2026 06:53:21 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1EC6420043;
	Mon, 21 Sep 2026 06:53:21 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 56A1220040;
	Mon, 21 Sep 2026 06:53:18 +0000 (GMT)
Received: from [9.124.208.199] (unknown [9.124.208.199])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 21 Sep 2026 06:53:18 +0000 (GMT)
Message-ID: <8202e4e2-db26-4c9f-88b1-af5f0ffd5421@linux.ibm.com>
Date: Mon, 21 Sep 2026 12:23:17 +0530
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
Subject: Re: [PATCH] powerpc/ftrace: Don't restore r13 during
 ftrace_regs_caller
To: Hari Bathini <hbathini@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        linux-kernel@vger.kernel.org, msuchanek@suse.de, ritesh.list@gmail.com,
        maddy@linux.ibm.com
References: <20260918150811.1743769-1-sshegde@linux.ibm.com>
 <2a1d71ab-dab1-42c8-8c55-f131a4b6e48b@linux.ibm.com>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <2a1d71ab-dab1-42c8-8c55-f131a4b6e48b@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: 8bj0RpOxCWc4pV9R8ni2UBhnqxXWzraS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDA5MyBTYWx0ZWRfXw3IeEKfSVCJj
 5d+7rL8olPAPjrXjJrASXbPctu6sA4ewOpc7CcZL2Z7E0LuwC8PcdIJj9UhE4Gj6bhwR7V1jKQz
 fq4iXKhjwO70lcDz7fch/orE+iQ+Lqgpr3qaWx8Nlm9Ii6Zo/tyC5caRGvOVHEqq1oOZM26J5aE
 ardWptqHutmsKDLX73LCMM49X3JGasHfyY8uNUuRAjTpFOaXSKgcZcY75epH4S2vkQZlJlRrZeC
 MRsjRWR9H0rDXbtGOzJ28QM0Kd6NVz73Th+JMkRituXIqbgr4qUCc8xw3oyOyb4hsXLvOXaMU9L
 BXnx4iWjHBP5ZdEqp7WT9Aox3UUOhff35aOCBgps5NopXz7+J5KIPYz+5N+r+/0NGqp+ziSvHY2
 sNmi4KKYYthRajI+t1YaAnyagSWWgfhsKxOW1l6MtAvXJPrp0Q1U46IA0+AkNEOmcql9veaMHxS
 COx7umGONQFmiQBNEJQ==
X-Authority-Analysis: v=2.4 cv=O/KsLx9W c=1 sm=1 tr=0 ts=6ab0d466 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=JUkP1JpbfgDRSIa_JCsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDA5MyBTYWx0ZWRfXzQveNL7b8rT5
 DmzJZb2dr6RSiFabHrmnFsYPdHDweN/gcXtZcje9kfj2jB3WGdM9mXPU7b++pP7iegsgkSGrf5n
 DR6jZa8SN/NcbntG1xNzWAWlFsEWRFQ=
X-Proofpoint-GUID: ITwgG5khZ8iUZKUE4ZgSfASF08WfkleL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210093

Hi Hari,

On 9/21/26 12:07 PM, Hari Bathini wrote:
> 
> 
> On 18/09/26 8:38 pm, Shrikanth Hegde wrote:
>> Michal reported a stack-protector failure and subsequent panic when
>> running kernel builds. This was observed with full/lazy preemption.
>> Initially it was suspected as KVM, but later turned out to be due
>> to a bcc tool running in parallel.
>>
>> Issue was recreated using a bcc tool.
>> For example, running below in parallel leads to crash.
>> ./funccount sched* -d 100 and make -j 64
>>
>> The same crash was observed when running kprobe for schedule() function,
>> while simpler function tracer for schedule() didn't cause the crash.
>> This helped to narrow it down to ftrace backed kprobes area.
>>
>> The crash occurs as follows:
>>
>> ftrace_regs_caller entry on CPU A
>>      |
>>      +-> save r13 = CPU A PACA into pt_regs
>>      |
>>      +-> call kprobe_ftrace_handler()
>>              |
>>              +-> ftrace_test_recursion_unlock()
>>                      |
>>                      +-> preempt_enable
>>                      +-> task can schedule and migrate to CPU B
>>                      +-> task resumes with live r13 = CPU B PACA
>>      |
>>      +-> REST_GPRS(2, 31)
>>              |
>>              +-> restore saved r13 = CPU A PACA
>>      |
>>      |-> The task then continues running on CPU B with r13 pointing
>>      |   to CPU A's PACA.
>>
>> The stack-protector canary is accessed through the PACA. After the task
>> migrates, CPU A may run a different task and update its PACA with that
>> task's canary. Restoring the saved r13 then causes the migrated task's
>> saved stack canary to be compared against the canary in CPU A's PACA,
>> resulting in a stack-protector failure.
>>
>> Similarly, current is resolved through the PACA. With a stale r13,
>> preempt_count() can access the state of the task referenced by CPU A's
>> PACA instead of the task running on CPU B. This results in corrupted
>> preempt-count warnings and scheduling-while-atomic failures.
>>
>> This path for example is called when using kprobes and parallel kernel builds
>> can cause preemptions during ftrace_test_recursion_unlock.
>>
>> Do not restore r13 from the saved register frame. If the task did not
>> migrate, the live r13 already has the saved value. If it migrated, the
>> live r13 contains the correct PACA pointer for the CPU on which the task
>> resumed.
>>
> 
> Looks good to me except for a minor nit below.
> 
> Reviewed-by: Hari Bathini <hbathini@linux.ibm.com>
> 
>> Fixes: 153086644fd1 ("powerpc/ftrace: Add support for -mprofile-kernel ftrace ABI")
>> Reported-by: Michal Suchánek <msuchanek@suse.de>
>> Closes: https://lore.kernel.org/all/aqKfsVArHHaIK6M9@kunlun.suse.cz/
>> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
>> ---
>> PS:
>> Fixes is the initial commit that introduced this restore regs almost
>> 10 years ago, all commit afterwords are code refactors changing the
>> code layout. Also backporting all the way maybe tricky.
>> Backport can easily happen till aebd1fb45c622.
>>
>>   arch/powerpc/kernel/trace/ftrace_entry.S | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/kernel/trace/ftrace_entry.S b/arch/powerpc/kernel/trace/ftrace_entry.S
>> index 6599fe3c6234..54c8727b48cd 100644
>> --- a/arch/powerpc/kernel/trace/ftrace_entry.S
>> +++ b/arch/powerpc/kernel/trace/ftrace_entry.S
>> @@ -220,7 +220,9 @@
>>       /* Restore gprs */
>>       .if \allregs == 1
> 
>> -    REST_GPRS(2, 31, r1)
>> +    REST_GPRS(2, 12, r1)
>> +    /* Do not restore a stale PACA pointer if the task migrated */
>> +    REST_GPRS(14, 31, r1)
> 
> Given that r13 is not paca on ppc32, shouldn't the above change
> only apply to PPC64?

Yes. Good catch. Will make the above change only for PPC64.

Thanks for reviewing.

>>       .else
>>       REST_GPRS(3, 10, r1)
>>   #if defined(CONFIG_LIVEPATCH_64) || defined(CONFIG_PPC_FTRACE_OUT_OF_LINE)
> 
> - Hari
> 


