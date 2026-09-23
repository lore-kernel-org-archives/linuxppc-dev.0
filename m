Return-Path: <linuxppc-dev+bounces-28063-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 369ABC98304
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Sep 2026 18:42:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hqm6n2ffbz3048;
	Thu, 24 Sep 2026 04:42:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790188961;
	cv=none; b=mbsvY1w/MIvJFq1QP/hBBcNeIf9rOCymZ2msyGh5+1K7Cs2uNMvVl6cjsBSeLDSWp2tcZqBNqCB5O0DLZhmtu9Rm8n3WScBSm/4vHrZm66aU8JdrNKeHkxq7gRm3JvN71vljWMCKGrivvWjcZqC7BXColbfOgYjGJsgdew/beG4PWgRzTnyguYQfIfxkPutrEB2pZv2qUj1+2Z+lVc43rY+0pRvtv5ByKqirR4LAvGhqWzZ92UErpuyvvaLTo9Cs0S/fJiGTMbcjU8WXP6yZB9ysRZdjhtaGPJ0GbyTbGct4fUKHXuJWyW5QeXCp2XSde1iiok/MyQO+WeeOTmroEg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790188961; c=relaxed/relaxed;
	bh=CUYITwKQ+z+1OAH+g8CWgxbCNFHSvBZjQhuLJ/kZcmc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nXaRq+xoJ/qLJVXyjUyOWN6kbJXDWl0POpVCdUsrANpWTNZtT8m9itbVH8b9RqtwXp/lWCh2Wx8DmcVAVJzEd2BxqbFq9d1nvDwvCZ4C9Pl/IbCqxfiWE3fOep+xT8Iuc6uvVBgHNjBHpuL+RpLCCJghnO4G5P/DYxpiAGDVr/1ctU/3VttZkZs5dOfeI4sPXc/8kLp1KT40m33hoQTMK1QwhmuWlHuqBLT649bvhZ8xkIFaRAXEnoAgzVlf7girVGuHgMr8Gb5Z98A0sC9riLuLewgGQmgh41rizAYxAIA3KeBK5Vae45v6ZDseMWfX/hhY6hkVE4C+ixLsFmAW6Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=MphYg5RR; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=MphYg5RR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hqm6m3tyjz2yDm
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2026 04:42:40 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68NGZgWa3926118;
	Wed, 23 Sep 2026 18:42:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=CUYITw
	KQ+z+1OAH+g8CWgxbCNFHSvBZjQhuLJ/kZcmc=; b=MphYg5RR4+XjqpOwgPc504
	Tysar5Yjf/fhG2q6P7K8DwYaoP8Yoi/XVRWJuiMSlwKFwBloeiaVJMCE9S/yESbc
	lbvfqI+eQekMdOJqo/qH2FFVCFvq35CM/rlfP+WxqOudwcSHLouPlVx8/scpsfoi
	fGdPwVRexZLGrEXfFbL372QC+X/VxGTDZQWiuJ5ZBB6n/dnjlqnX3LvivuB3oesF
	OCJ1HvYTEz3cwX1p87RPnljjb4kYXgpqvq1WhboA47WOjKtsIJw+OFl5aHsGK/3P
	3SRMWyyLTctM66FTPWYK1pusFsfckoX27ajwjvgT+GWKffqGI6xoaIe3ixF/29Sg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskg2n2vd-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 23 Sep 2026 18:42:25 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68NGWmDh627143;
	Wed, 23 Sep 2026 18:42:24 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbt2t73f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Sep 2026 18:42:24 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68NIgKsd45482342
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Sep 2026 18:42:20 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 90CAB2004B;
	Wed, 23 Sep 2026 18:42:20 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 11E0C20043;
	Wed, 23 Sep 2026 18:42:16 +0000 (GMT)
Received: from [9.124.209.29] (unknown [9.124.209.29])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 23 Sep 2026 18:42:15 +0000 (GMT)
Message-ID: <0fbc2522-791a-482b-a756-f3e6e61d2e29@linux.ibm.com>
Date: Thu, 24 Sep 2026 00:12:15 +0530
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
To: Christian Zigotzky <chzigotzky@xenosoft.de>
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
        Hari Bathini <hbathini@linux.ibm.com>,
        =?UTF-8?Q?Michal_Such=C3=A1nek?=
 <msuchanek@suse.de>
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
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <b8f82519-9ae5-c247-e020-e79c627e57df@xenosoft.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: 7HiYtBbMyfdbwNsCIvG4D9iZnVNw9xus
X-Authority-Analysis: v=2.4 cv=I43w19gg c=1 sm=1 tr=0 ts=6ab41d92 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=NEAV23lmAAAA:8
 a=oxC9TbpiAAAA:20 a=aONlWmznN9kDEt85WeAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA3NCBTYWx0ZWRfX5/uvzcbLju1H
 V79D+iMBZMqUTB0vN4rGuidaawI6mPomZuwipLjKlpNRfq86RI1QhyDPNfXVQ7N+Ns3l/l9pUCL
 RUJynxkC8UIFpq+EWneVuxyCW+U3UyEesXmNcWCmLHNvDW+8ZCVF7/hrJuOUnhLPahf3UmxG0h+
 gu0HkLTBTSq22DJUdk38ZXfwoJMzS/OyL4K7y5eys3AFNybcnUwmIhNbEacoAC6y+TaBLTqDtSX
 TgWp12wFbp1ZBXKyXGDwAdneXCHAV1KmmwEiZhcYoAH4RivBRybLBh0d1ceMWgHtBKq0/H0JXiS
 RROdtHLdo28io8QAcnN2N/DA7t1FNRWESed9XF1nUqMeJhw+Q1GiogZvqNbRKQ8qxCas2M9yUBI
 KWAQ8oDRDhZ4zwmV+RURArAisWrAsFSHImm1/rKWEC+sQcclogCMK00bg3jvFV7CodO+xjkjxbt
 bbzaFZzysv4XuneI35g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA3NCBTYWx0ZWRfX9AJtoIhefh2e
 +xx3TR55DCO+zNllhsvNrazN63D2uMTS9hK2LUSPbpW9Sovy/BxSC+LXwUW5MCx74XrAxRSjnom
 9XmESeT0YjR/yLVtux6lPnLFQchHAwg=
X-Proofpoint-GUID: D1bMIssP0fwaGi38ucfM1SlIZqJyT4cE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_06,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230074

Hi

On 9/23/26 9:31 PM, Christian Zigotzky wrote:
> On 23/09/26 07:13, Shrikanth Hegde wrote:
>>
>>
>> On 9/23/26 10:39 AM, Christian Zigotzky wrote:
>>> On 21/09/26 07:12, Shrikanth Hegde wrote:
>>>> Hi Christian.
>>>>
>>>> On 9/20/26 6:34 PM, Christian Zigotzky wrote:
>>>>> On 09/20/2026 01:49 PM, Christian Zigotzky wrote:
>>>>>> On 09/18/2026 09:10 AM, Michal Suchánek wrote:
>>>>>>> On Fri, Sep 18, 2026 at 04:39:57AM +0200, Christian Zigotzky wrote:
>>>>>>>> On 17/09/26 16:15, Shrikanth Hegde wrote:
>>>>>>>>> Hi Michal,
>>>>>>>>>
>>>>>>>>>>> Give it a try.
>>>>>>>>>>>
>>>>>>>>>>> I am suspecting both lockup, stack corruptions are secondary
>>>>>>>>>>> symptoms here.
>>>>>>>>>>> While recreate, I have different type of traces.
>>>>>>>>>> Yes, it does work for the crash I see.
>>>>>>>>> Thanks. Give me sometime to see further on that. Didn't get any time
>>>>>>>>> today.
>>>>>>>>>
>>>>>>>>>> However, we hijacked the report
>>>>>>>>>> of KVM locking up on FSL Cyrus+, and that is likely a different problem
>>>>>>>>>> still not addressed.
>>>>>>>>>>
>>>>>>>>> Ah, that's what you meant. Yes, i still don't know where FSL Cyrus+ is
>>>>>>>>> stuck.
>>>>>>>>>
>>>>>>>>> I would need help from FSL Cyrus+ to get some logs or is there a way we
>>>>>>>>> can spin of
>>>>>>>>> a QEMU guest of it? We should have the log to start somewhere.
>>>>>>>>>
>>>>>>>>>
>>>>>>>> It's difficult to get a log because it freezes and can't write any error
>>>>>>>> messages to the log files. This bug is very old. We had this issue some
>>>>>>>> years ago but we was able to disable PREEMPT because we don't need it.
>>>>>>> I would expect serial console and sysrq could give something, depending
>>>>>>> on how much of the kernel is frozen.
>>>>>>>
>>>>>>> Thanks
>>>>>>>
>>>>>>> Michal
>>>>>> Here is a serial log: https://github.com/user-attachments/files/32433586/e5500_preempt_putty.log
>>>>>>
>>>>
>>>> Thanks Michal for helping to get the traces.
>>>>
>>>>> Another serial log with pcie_ports=compat: https://github.com/user-attachments/files/32434487/e5500_preempt_pcie_ports_compat_putty.log
>>>>>
>>>>
>>>> I see it is mostly busy with printing
>>>> WARNING: at .enable_kernel_fp+0x30/0x78, CPU#3: qemu-system-ppc/4884
>>>>
>>>> The path seems to be same also.
>>>>
>>>> [c000000085ca7700] [c00000000005de84] .kvmppc_load_guest_fp+0x30/0x80
>>>> [c000000085ca7780] [c00000000005f2a0] .kvmppc_handle_exit+0x5bc/0x5cc
>>>> [c000000085ca7830] [c00000000006204c] .kvmppc_resume_host+0xb8/0x10c
>>>>
>>>>
>>>> Does below help to boot or make it stable?
>>>> ---
>>>>  arch/powerpc/kvm/booke.c | 9 ++++++++-
>>>>  1 file changed, 8 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
>>>> index 13ad4cf5fa71..d4be7a306bfc 100644
>>>> --- a/arch/powerpc/kvm/booke.c
>>>> +++ b/arch/powerpc/kvm/booke.c
>>>> @@ -1404,10 +1404,17 @@ int kvmppc_handle_exit(struct kvm_vcpu *vcpu, unsigned int exit_nr)
>>>>          if (s <= 0)
>>>>              r = (s << 2) | RESUME_HOST | (r & RESUME_FLAG_NV);
>>>>          else {
>>>> -            /* interrupts now hard-disabled */
>>>> +            /*
>>>> +             * interrupts now hard-disabled. i.e EE=0
>>>> +             * But irqs_disabled relies on PACA entries
>>>> +             * and fixup below enables it.
>>>> +             * So irqs_disabled == false
>>>> +             */
>>>>              kvmppc_fix_ee_before_entry();
>>>> +            preempt_disable();
>>>>              kvmppc_load_guest_fp(vcpu);
>>>>              kvmppc_load_guest_altivec(vcpu);
>>>> +            preempt_enable_no_resched();
>>>>          }
>>>>      }
>>>>
>>>>
>>> Hi,
>>>
>>> Thanks a lot for your patch!
>>>
>>> I patched the 7.3-rc4 kernel sources with your new patch and compiled the kernel again yesterday. [1]
>>>
>>
>> Thanks for trying.
>>
>>> Unfortunately, the issue still exists.
>>>
>>
>> Can you share the console log of the kernel with the patch applied?
>> We need to see where it is stuck now. Has it made forward progress?
>>
>>> I tested it with a guest kernel with and without preempt support.
>>>
>>> Cheers,
>>> Christian
>>>
>>> [1] https://github.com/chzigotzky/kernels/releases/tag/v7.3.0-rc4-2-preempt
>>>
>>
> Here is a new serial log from the patched kernel: https://github.com/user-attachments/files/32570808/e5500_preempt_pcie_ports_compat_patched_putty.log
> 

That paca mismatch is independent of preemption modes.

It shows a few warnings and even after that a console message has come through.
Do warning continue forever?

To fix those warnings, can you try this diff on the top of the earlier ones?
(Igonore whitespace mangling if any, Also patch is UNTESTED. It is more of my
speculation.).

Sorry, I don't have any way to test it out locally.

---

diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 9194cf492d1c..0a014fa45b20 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -147,6 +147,19 @@ int kvmppc_prepare_to_enter(struct kvm_vcpu *vcpu)
                         continue;
                 }
  
+#ifdef CONFIG_PPC64
+               if (unlikely(local_paca->irq_happened != PACA_IRQ_HARD_DIS)) {
+               /*
+                * An interrupt arrived between the soft and hard
+                * disable. Replay it and retry guest entry.
+                */
+                       local_irq_enable();
+                       local_irq_disable();
+                       hard_irq_disable();
+                       continue;
+               }
+#endif
+
                 guest_enter_irqoff();
                 return 1;
         }


> Thanks
> 


