Return-Path: <linuxppc-dev+bounces-28175-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC8A0C98306
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Sep 2026 06:40:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hrh0r1tdRz2yqq;
	Fri, 25 Sep 2026 16:40:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790318443;
	cv=none; b=AAGVB0uHAFVdHs2YWPAAEI3o8GLwTG0NPoAYzDrarJ1mgloLxE8ROd9i1PqaNuKFBF+t1yOQ1oVQPVaUUtGn9D/fRX2KIiqlEPCDMN1mfwaQCH+MXf7NiZbMLGZL/uYyVG3SjkPKMWDQQIHe8IYEKH9HVJ+tkINLK6WtqJOyTva+ILa+CeRCK43w0vxXDJiXDbxvsZWQyGbUOb/CI4WJZbOQX9lfWYlPJ3N7SD60/zlLULg2HF22Um6nhXJLQFp2tZFv0MKA+loCUfZh7XYN2unKcAUncyENVFYMM2FD7aw/Q1skJK0jEpsLxqqvwdD+V/YdIaMtv+XwIxQNBOM1ig==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790318443; c=relaxed/relaxed;
	bh=bXJhjP/badUh1fe4vovhZmycxRzu6/HJOEha3ZwNSLM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AonSel9G0ttS/5j3tT7H7tqozupj+5IVcDCufY/CbYNyYBk7z18iBgOl9oHHzlWJiMB4l/uFnE4yxXW6ZFpwwuttyqVo/uHKePmne4LpNfGAObOEy/ijBDYc7F8Acw1B9PX2HL8nWUfilLnI0A0Iwt3BhlaFQooY35TslGjCmfUYnI2ZyqualSY5KvX+257v7wy7FD1eVVmKUZ+66PiFfzNMOrrWODmI82Aa8AILKh4cEW4J6rf7l99QZ8ySOSZu2anEzbPcWd6kDT+u+alURmVhbtBL6D8DIuE5jpyQV2IzOC6dK705f1lwG6NAEkHnkSZIpSnPk+2/a7/8+gBTpA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=mHonUXyb; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=mHonUXyb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hrh0p74fTz2y8d
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2026 16:40:42 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68P4aJh63083932;
	Fri, 25 Sep 2026 06:40:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=bXJhjP
	/badUh1fe4vovhZmycxRzu6/HJOEha3ZwNSLM=; b=mHonUXybmPKx3EcnkVpr4o
	CqOyMQU9LPDtMP08eNpTJLfmVrJkJhUw/7D803DpfhDY2TbQijLBLE7yQRBDpoBK
	v3gCOJdFdqaeiPJt0aeEVIDg9l+UaV6OaG1l+hh5OJILH1HYMAOmlcql8JCPxAzw
	2C2QdfaaqNUOzi0thGou3bjjKwK0wTxOhAB6vAa3snOeOMe24YMkYAOkZ+1WMuWW
	9t2owWEEY/ZtgeMMOj2eCJ6uLEuiky1lt6/27QDhzpobzmRiVryQhRzvlCSaZgWA
	TgvbcnDa4AZhhmmBHMr9ABXCiNnBor51s6D5IaSxMMzyJBDP4W/jez5i7KgjCuuA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgqvmht-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 06:40:24 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68P4lZIW3244944;
	Fri, 25 Sep 2026 06:40:24 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbu9194v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 06:40:24 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68P6eJgl17039792
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Sep 2026 06:40:19 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8B6E320040;
	Fri, 25 Sep 2026 06:40:19 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 701812004E;
	Fri, 25 Sep 2026 06:40:15 +0000 (GMT)
Received: from [9.39.19.239] (unknown [9.39.19.239])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 25 Sep 2026 06:40:15 +0000 (GMT)
Message-ID: <d64240cc-62f7-4f59-8598-d1dc18e07c43@linux.ibm.com>
Date: Fri, 25 Sep 2026 12:10:14 +0530
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
To: Christian Zigotzky <chzigotzky@xenosoft.de>,
        =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>, harshpb@linux.ibm.com,
        Gautam Menghani <gautam@linux.ibm.com>, amachhiw@linux.ibm.com,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "R.T.Dickinson" <rtd2@xtra.co.nz>, hypexed@yahoo.com.au,
        mad skateman <madskateman@gmail.com>,
        Christian Zigotzky <info@xenosoft.de>, Samir M <samir@linux.ibm.com>,
        Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
        Narayana Murty N <nnmlinux@linux.ibm.com>,
        Hari Bathini <hbathini@linux.ibm.com>
References: <aqfTU79SlNB3ykDi@kunlun.suse.cz>
 <25cf64ab-2a32-4d4c-a0c7-2e9007c276d4@linux.ibm.com>
 <aqj1KxZttNgY5ZVR@kunlun.suse.cz>
 <ba9759d0-b1f2-4b33-aff5-769cf89bd584@linux.ibm.com>
 <9b58bd58-d0e4-463e-bff9-e33b153b2987@linux.ibm.com>
 <aqu9hA1Bq58GFrVw@kunlun.suse.cz>
 <b2a5d53f-05e8-48ae-adb7-12fc74523b4e@linux.ibm.com>
 <aqvnOg9JfkM2k0TX@kunlun.suse.cz>
 <7ad57b61-4567-42c8-a9f6-faaabe7766a7@linux.ibm.com>
 <7e06fb84-ca2e-dbb4-47bd-e95ee11113c9@xenosoft.de>
 <aqzj9xsPRsGgCI5M@kunlun.suse.cz>
 <79f9d4e3-ce55-d238-e4a9-b11e9ce27c5f@xenosoft.de>
 <33342fbf-eb7b-bde6-2c8c-254fe8bfb993@xenosoft.de>
 <b887c351-f7da-4e24-8cee-30a5a2dbfadb@linux.ibm.com>
 <7fb5baa6-9d06-2c61-2b43-6835e8fb0d1a@xenosoft.de>
 <9c1d7cf0-40f5-4a93-81ee-f5a4c5adcb9d@linux.ibm.com>
 <b8f82519-9ae5-c247-e020-e79c627e57df@xenosoft.de>
 <0fbc2522-791a-482b-a756-f3e6e61d2e29@linux.ibm.com>
 <a9fd6f5f-cdfa-a010-05b9-507689026fe4@xenosoft.de>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <a9fd6f5f-cdfa-a010-05b9-507689026fe4@xenosoft.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=G+OJgNk5 c=1 sm=1 tr=0 ts=6ab61759 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=oxC9TbpiAAAA:20
 a=NEAV23lmAAAA:8 a=Ct5YdCZI347Wp1tEtF0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDAyNiBTYWx0ZWRfX2R7lKGVWHvDD
 FohfBkE+/oGGZwbT7mQKXkDpUWCLf58oT+C2bpjgKJdgifEb4u9LyOE3Yn+utLlNVWZD39vciRw
 yyqFLF9tmCNgAvKXLIyVPgGt9QaNZGmPq1fEKqs59eqle8txsUkr+J7nmQPS5BIR2Vx1NDBSmc4
 AKPCMt34y7vkOVPAdg3Hxg68weCOmadQZHmyXSbgqyHwZPfQQev4u/bSeLOCJ+3lq103zKfXb8f
 Mq5eWe0vVgeTuTpmpu1FLyf5ZDGeBRil0DFVyaKB7/8fWOCnd9j2teVJ1YciUeh6QzCWTmqEg3N
 InfPORVWCKoIBGvc5kIAl9GtYYGq18MUGlk/5rzhI7QAGfTy4mZsEn2PBYtbZVJG8eXAfvSdUdw
 1vthYaUf4owafIzzPXvCIe4KdtJ5SNpN+havcba1rsT+8YmEVtdIlC614hYxoaJVjBYxgT9qywN
 HByWmDytIonF1a/C6HQ==
X-Proofpoint-ORIG-GUID: D15D7tFvq63lVNaxLrkYvar6ImF4-dAG
X-Proofpoint-GUID: p6gzJ7jOt9P5Mwy7D_0Vuh4VpHZO8C1e
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDAyNiBTYWx0ZWRfX7WFmKf26GFyK
 nV97/IR5CaB3ugfKKRi5OkkjYASuKt/hx8+ZdpYZvT0i42lw3fJdqb6rrC1jICyw9F7Y8ZqN8ZI
 J5tStr1KbaIu9Ic+z344ZJOl5RMqmQ8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250026

Hi Christian, Michal,


>>>>>>
>>>>>> I see it is mostly busy with printing
>>>>>> WARNING: at .enable_kernel_fp+0x30/0x78, CPU#3: qemu-system-ppc/4884
>>>>>>
>>>>>> The path seems to be same also.
>>>>>>
>>>>>> [c000000085ca7700] [c00000000005de84] .kvmppc_load_guest_fp+0x30/0x80
>>>>>> [c000000085ca7780] [c00000000005f2a0] .kvmppc_handle_exit+0x5bc/0x5cc
>>>>>> [c000000085ca7830] [c00000000006204c] .kvmppc_resume_host+0xb8/0x10c
>>>>>>
>>>>>>
>>>>>> Does below help to boot or make it stable?
>>>>>> ---
>>>>>>  arch/powerpc/kvm/booke.c | 9 ++++++++-
>>>>>>  1 file changed, 8 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
>>>>>> index 13ad4cf5fa71..d4be7a306bfc 100644
>>>>>> --- a/arch/powerpc/kvm/booke.c
>>>>>> +++ b/arch/powerpc/kvm/booke.c
>>>>>> @@ -1404,10 +1404,17 @@ int kvmppc_handle_exit(struct kvm_vcpu *vcpu, unsigned int exit_nr)
>>>>>>          if (s <= 0)
>>>>>>              r = (s << 2) | RESUME_HOST | (r & RESUME_FLAG_NV);
>>>>>>          else {
>>>>>> -            /* interrupts now hard-disabled */
>>>>>> +            /*
>>>>>> +             * interrupts now hard-disabled. i.e EE=0
>>>>>> +             * But irqs_disabled relies on PACA entries
>>>>>> +             * and fixup below enables it.
>>>>>> +             * So irqs_disabled == false
>>>>>> +             */
>>>>>>              kvmppc_fix_ee_before_entry();
>>>>>> +            preempt_disable();
>>>>>>              kvmppc_load_guest_fp(vcpu);
>>>>>>              kvmppc_load_guest_altivec(vcpu);
>>>>>> +            preempt_enable_no_resched();
>>>>>>          }
>>>>>>      }
>>>>>>
>>>>>>
>>>>> Hi,
>>>>>
>>>>> Thanks a lot for your patch!
>>>>>
>>>>> I patched the 7.3-rc4 kernel sources with your new patch and compiled the kernel again yesterday. [1]
>>>>>
>>>>
>>>> Thanks for trying.
>>>>
>>>>> Unfortunately, the issue still exists.
>>>>>
>>>>
>>>> Can you share the console log of the kernel with the patch applied?
>>>> We need to see where it is stuck now. Has it made forward progress?
>>>>
>>>>> I tested it with a guest kernel with and without preempt support.
>>>>>
>>>>> Cheers,
>>>>> Christian
>>>>>
>>>>> [1] https://github.com/chzigotzky/kernels/releases/tag/v7.3.0-rc4-2-preempt
>>>>>
>>>>
>>> Here is a new serial log from the patched kernel: https://github.com/user-attachments/files/32570808/e5500_preempt_pcie_ports_compat_patched_putty.log
>>>
>>
>> That paca mismatch is independent of preemption modes.
>>
>> It shows a few warnings and even after that a console message has come through.
>> Do warning continue forever?
>>
>> To fix those warnings, can you try this diff on the top of the earlier ones?
>> (Igonore whitespace mangling if any, Also patch is UNTESTED. It is more of my
>> speculation.).
>>
>> Sorry, I don't have any way to test it out locally.
>>
>> ---
>>
>> diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
>> index 9194cf492d1c..0a014fa45b20 100644
>> --- a/arch/powerpc/kvm/powerpc.c
>> +++ b/arch/powerpc/kvm/powerpc.c
>> @@ -147,6 +147,19 @@ int kvmppc_prepare_to_enter(struct kvm_vcpu *vcpu)
>>                         continue;
>>                 }
>>
>> +#ifdef CONFIG_PPC64
>> +               if (unlikely(local_paca->irq_happened != PACA_IRQ_HARD_DIS)) {
>> +               /*
>> +                * An interrupt arrived between the soft and hard
>> +                * disable. Replay it and retry guest entry.
>> +                */
>> +                       local_irq_enable();
>> +                       local_irq_disable();
>> +                       hard_irq_disable();
>> +                       continue;
>> +               }
>> +#endif
>> +
>>                 guest_enter_irqoff();
>>                 return 1;
>>         }
>>
> 
> Hi,
> 
> I patched the RC4 of kernel 7.3 with the two patches and compiled it again today.
> 
> I'm happy to report that the patched PREEMPT kernel with KVM HV works on the X5000/40. (e5500)
> 

That's very nice to hear. I will write changelog for both and send it across soon.
Give me sometime.

> Serial log: https://github.com/user-attachments/files/32619259/e5500_preempt_pcie_ports_compat_patched-2_putty.log
> 
> I also successfully tested it with KVM PR on the X1000 today. (PA6T)
> 

Nice.

> Further information: https://github.com/chzigotzky/kernels/issues/19#issuecomment-5818925408
> 
> Many thanks for your help,
> 

Happy to help.
Thanks for reporting and testing. We can finally close this thread :)
Thanks to michal for helping in getting the logs.

> Christian
> 

Also, Michal, can you report that kvm specific issue you are seeing with the
ftrace fix applied in separate thread. This thread has become long already.


