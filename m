Return-Path: <linuxppc-dev+bounces-27956-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77201C98302
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Sep 2026 05:14:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hqQBQ4Cklz2xs1;
	Wed, 23 Sep 2026 15:14:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790140478;
	cv=none; b=lGnsurla5k1IBDFGs3u3xd8SFpwSKC3Y2vN0ash04EVzS85/H6Lio5LUxLzcrDbadiEB+IFDYCpvrAj7GsRyE3zQNGxFPPRvEAbH4rhv/rQn8QeFihLFjhl33FrmLyyQzP9YRU+OVBcMNcg2rjbTEiZEZr075szv3Jyz5siT8W759Q5EJzQ1i3kl+MHOMwDJquzpryqymSaE1aco9QumyICPfsNjzrUt8sfSIeJc2Gyh5v6Y1cBt+nD0cC0b0/5CM7SF5St4lSgcOQSS9v98Kl6POt8Q3F9diY/pbWfE1vvqsQUicZBHwRMb6v4jGFfEU7cLGok024v8g6kML9N0qw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790140478; c=relaxed/relaxed;
	bh=441XGplko3eHphwZZt4cF0SHZAIYjrcYFtmeJFhZI5o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VoTNErlzM8RNz94/K3CgDpDxdCpu5bGLU5TqxSpjPydAM6p7ytWDkoJoQHyKhVP2tH+fZLWA3/P3ZP2TYpbajAqCjbE9G8rpGZRN3gyEW9qqpgmbtzAvUJlT53poA+bhxrX9Pc6d9EA0bdlmf8ImYV6nGzbWfWRMkNaJpl2Xc7B5TZHWpPFbJ1y6llUM5YUjVjV1zkYxHiIEfFOdkSh9wBShHig+ELacmkIpKCBPDZbehIqA4L2kLupy6aOudZ9DKAmzdgM3Q3bXE5IbTmD+uYoiY1QygSFrrImCIRSstHIUDY3HtKb2470YBi+iOJNycrMC0h0m8gsQZ7t9md2hDw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=KPmuIRet; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=KPmuIRet;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hqQBP43Wrz2xk7
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2026 15:14:37 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68N45RpQ477960;
	Wed, 23 Sep 2026 05:14:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=441XGp
	lko3eHphwZZt4cF0SHZAIYjrcYFtmeJFhZI5o=; b=KPmuIRetzb2AoelYHruzMl
	WTTOMToQIyeToWYO5LOfXJfetztJl9EDgaKM8gdyB8O3n12MHpJ9GZq8njlB/JT8
	cFHb9/kATDhn41DEDbqVzDfNUrHiXrqiwfOUorVFFJcHvL2BqrW6BOLNNqLcqkTR
	XFhXL/I6+bj6Y0stmaQJ0T4wn8u9e927+ytmz8KiwBYifbZ/Tq6CpJIjKyPs11pb
	whitGxv9YTc/p4iPhMubJ47uIsNqWCd9QTHhz56aozmhVlRXlT1z5cFLp6oNT05h
	xY5e/EIYjxG8L90QRSsnDB4fCN1O/kIi8Atdc5FASJ5bxMYojqHFgQUOEI16SCGQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske1sb24-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 23 Sep 2026 05:14:10 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68N3lXP42594539;
	Wed, 23 Sep 2026 05:14:10 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gu5bkfcka-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Sep 2026 05:14:10 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68N5E6FC25428626
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Sep 2026 05:14:06 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0AC7620043;
	Wed, 23 Sep 2026 05:14:06 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5698F20040;
	Wed, 23 Sep 2026 05:14:00 +0000 (GMT)
Received: from [9.124.209.29] (unknown [9.124.209.29])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 23 Sep 2026 05:14:00 +0000 (GMT)
Message-ID: <9c1d7cf0-40f5-4a93-81ee-f5a4c5adcb9d@linux.ibm.com>
Date: Wed, 23 Sep 2026 10:43:59 +0530
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
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <7fb5baa6-9d06-2c61-2b43-6835e8fb0d1a@xenosoft.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: JCSBF24Yn6g5t4Dqmp2iVTDyyAVAtH3I
X-Authority-Analysis: v=2.4 cv=EOCTQFZC c=1 sm=1 tr=0 ts=6ab36023 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=NEAV23lmAAAA:8
 a=oxC9TbpiAAAA:20 a=TyhM5VrcfDcAQIkWa9IA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDAyMCBTYWx0ZWRfX5cWjgvWu8hKX
 nnYaKVZ40kkKw3wJS9m8kKTZSLKHqMZtn7Lfxuw6NAhlI9LRHXgLSKbCfp4+TELg+p7UsunGz9f
 ECbImzimkjtIUGfYcHn8hVnwvd3phxY=
X-Proofpoint-GUID: A4doiWS49zoeNluiBCfPV4hccmLA9dLx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDAyMCBTYWx0ZWRfX8pEnAifyIA0b
 WPumZpdDoVxwTDQihilDpYBkmFI6f4VD9Twj9DyRlU0QV9H6+M9yBdjGVbmrUTMNbZURUuoGxTB
 WNaK7tD6wz4a2AL115vU4WKAdbb9QJSu8DssyIPUJe7LQ7PcRJAUnytBJR8nS8G+opFLnQjlHyI
 HBybdyd+P5tlc1fkGhAF0PWc0liGbdSaBwDfbwWhvEW39muASeASamtlhJ9kQkXW5yx7/+4EAx1
 ZCLiCywhIpOGLEHaGCVlWRHMGsMUmEq0uThDY8czOhOkVNFSPeBsXmM4GIFNTkqiY4+p2TzzdE3
 r4vOD3gtbDAY8PLEyZpg+WzpoHJDo6UfWdZsZlhjNLtycYPDMdbSCkfcF+CqqlVCNH8uiWfbfxt
 H9hfsuqjNo6LcfYkcdNdYlKpbWyDELLHFozA48xeKrk2Xe0q1NFoFfA57Ehsv7uNt1jIItal0aC
 b5Mzzlt+uXv5fRdaKXQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230020



On 9/23/26 10:39 AM, Christian Zigotzky wrote:
> On 21/09/26 07:12, Shrikanth Hegde wrote:
>> Hi Christian.
>>
>> On 9/20/26 6:34 PM, Christian Zigotzky wrote:
>>> On 09/20/2026 01:49 PM, Christian Zigotzky wrote:
>>>> On 09/18/2026 09:10 AM, Michal Suchánek wrote:
>>>>> On Fri, Sep 18, 2026 at 04:39:57AM +0200, Christian Zigotzky wrote:
>>>>>> On 17/09/26 16:15, Shrikanth Hegde wrote:
>>>>>>> Hi Michal,
>>>>>>>
>>>>>>>>> Give it a try.
>>>>>>>>>
>>>>>>>>> I am suspecting both lockup, stack corruptions are secondary
>>>>>>>>> symptoms here.
>>>>>>>>> While recreate, I have different type of traces.
>>>>>>>> Yes, it does work for the crash I see.
>>>>>>> Thanks. Give me sometime to see further on that. Didn't get any time
>>>>>>> today.
>>>>>>>
>>>>>>>> However, we hijacked the report
>>>>>>>> of KVM locking up on FSL Cyrus+, and that is likely a different problem
>>>>>>>> still not addressed.
>>>>>>>>
>>>>>>> Ah, that's what you meant. Yes, i still don't know where FSL Cyrus+ is
>>>>>>> stuck.
>>>>>>>
>>>>>>> I would need help from FSL Cyrus+ to get some logs or is there a way we
>>>>>>> can spin of
>>>>>>> a QEMU guest of it? We should have the log to start somewhere.
>>>>>>>
>>>>>>>
>>>>>> It's difficult to get a log because it freezes and can't write any error
>>>>>> messages to the log files. This bug is very old. We had this issue some
>>>>>> years ago but we was able to disable PREEMPT because we don't need it.
>>>>> I would expect serial console and sysrq could give something, depending
>>>>> on how much of the kernel is frozen.
>>>>>
>>>>> Thanks
>>>>>
>>>>> Michal
>>>> Here is a serial log: https://github.com/user-attachments/files/32433586/e5500_preempt_putty.log
>>>>
>>
>> Thanks Michal for helping to get the traces.
>>
>>> Another serial log with pcie_ports=compat: https://github.com/user-attachments/files/32434487/e5500_preempt_pcie_ports_compat_putty.log
>>>
>>
>> I see it is mostly busy with printing
>> WARNING: at .enable_kernel_fp+0x30/0x78, CPU#3: qemu-system-ppc/4884
>>
>> The path seems to be same also.
>>
>> [c000000085ca7700] [c00000000005de84] .kvmppc_load_guest_fp+0x30/0x80
>> [c000000085ca7780] [c00000000005f2a0] .kvmppc_handle_exit+0x5bc/0x5cc
>> [c000000085ca7830] [c00000000006204c] .kvmppc_resume_host+0xb8/0x10c
>>
>>
>> Does below help to boot or make it stable?
>> ---
>>  arch/powerpc/kvm/booke.c | 9 ++++++++-
>>  1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
>> index 13ad4cf5fa71..d4be7a306bfc 100644
>> --- a/arch/powerpc/kvm/booke.c
>> +++ b/arch/powerpc/kvm/booke.c
>> @@ -1404,10 +1404,17 @@ int kvmppc_handle_exit(struct kvm_vcpu *vcpu, unsigned int exit_nr)
>>          if (s <= 0)
>>              r = (s << 2) | RESUME_HOST | (r & RESUME_FLAG_NV);
>>          else {
>> -            /* interrupts now hard-disabled */
>> +            /*
>> +             * interrupts now hard-disabled. i.e EE=0
>> +             * But irqs_disabled relies on PACA entries
>> +             * and fixup below enables it.
>> +             * So irqs_disabled == false
>> +             */
>>              kvmppc_fix_ee_before_entry();
>> +            preempt_disable();
>>              kvmppc_load_guest_fp(vcpu);
>>              kvmppc_load_guest_altivec(vcpu);
>> +            preempt_enable_no_resched();
>>          }
>>      }
>>
>>
> Hi,
> 
> Thanks a lot for your patch!
> 
> I patched the 7.3-rc4 kernel sources with your new patch and compiled the kernel again yesterday. [1]
> 

Thanks for trying.

> Unfortunately, the issue still exists.
> 

Can you share the console log of the kernel with the patch applied?
We need to see where it is stuck now. Has it made forward progress?

> I tested it with a guest kernel with and without preempt support.
> 
> Cheers,
> Christian
> 
> [1] https://github.com/chzigotzky/kernels/releases/tag/v7.3.0-rc4-2-preempt
> 


