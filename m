Return-Path: <linuxppc-dev+bounces-19184-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DD56CC6B00
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Apr 2026 03:59:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fmSm84nX6z2ySk;
	Thu, 02 Apr 2026 14:59:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775102376;
	cv=none; b=LpUHkGF7mRYBWuU8FlgeZtsbw+PLVH2w5J9SoXVfuYPICfg5e33UTX50zP/TPv5xz5m3kg/rozdf/uPgbnn9S/p8E3oSx4NfWZxbWvLPqGykOkzVPuBh1CW8z368vwRQPMx082pxq3hd5aOCwjXdU1jz7Nu1Sq3CfKoi3IpOVeczg65jXUfIByX4WgMF+QciAVb0/ACvnAGoWOm03KAsaNEHcvMZp6tyI6Wct6mOxXfw1Msmf+4PScxyo6VB/sRJ+EL8YdR2ZQUO7ug2wODOlgJh6G3qMs4o8AVoM90Lj8c0+2Xask4cULI0OjOTgwOWjzAgRn4fYNmGOLtSzOCNfg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775102376; c=relaxed/relaxed;
	bh=QYEB8SliKLGX4fPrzg2FIbLChPM9Js48uOaW3OTCARI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jTdwoKJiJdnCulJZs4PJAZx7BUIZzUcHNed7rLCh+JoZhUuGSCQwxE7/mzIQ7ZTVxn3U2fTJI+La2UwIDCAE4xNS9MxWYmAHrGxR2T0yimJykZ3ZX2p9+nzzVTOuJZx1DkVP7T94qFt+GbTFkLRSF4L9Pt0Cm6ov9GGXQLinLBLPWVfNcbyuPjgGpropK87I0555xlRxsIdjGzVboQ9dHT0DumK5QZ4hVKfZKBqxIHz+ESyL9B1fafKu0Ednr988Bfy4d+gD4j57LCQjStSPjlgwktii/PJsJk6i+gAGCVlq6WXFbAtYXFZKr0JjYaFuj1Z5SYzP1EcDewyUf+uORw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=i+N5MGoE; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=i+N5MGoE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fmSm71rBqz2xm5
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Apr 2026 14:59:34 +1100 (AEDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63219h3U462561;
	Thu, 2 Apr 2026 03:59:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=QYEB8S
	liKLGX4fPrzg2FIbLChPM9Js48uOaW3OTCARI=; b=i+N5MGoEC703s8cY5ebCNv
	Ps93NvS8i6wBYXl05gt5Sv5qGNks08GfG2ss1qVJbt5vsZsYI78TKtPo4hWfJ0S/
	E5QXMAxF+uIg37uCqetw1GWQujmM99vEb8q5fJbiJdAE7cyT8rfSTgeumQuuXyxS
	qn8Ly/tbnCDEhN7KwO5ZlLwD5I2sl9Urgx8smdRGDlwXLVHWP6oIdjvk9elBUyxj
	U2VRB4Q28JOtiylc57VxMkXXHnBf8jDYof6Gb44YuEN7lMgF2JLZkGJDSpsqjU/u
	neu9SKnVsb0m27h05h9y4gWQY1l2QBDeWndezdvCyKVX+QVj6K9gZc8y9t7XiD6Q
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66nnu5s7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 03:59:24 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6320UQY9022165;
	Thu, 2 Apr 2026 03:59:23 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d6tan8h0w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 03:59:23 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6323xJJa58458496
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 2 Apr 2026 03:59:19 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9E5F520043;
	Thu,  2 Apr 2026 03:59:19 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 46CF620040;
	Thu,  2 Apr 2026 03:59:17 +0000 (GMT)
Received: from [9.123.14.142] (unknown [9.123.14.142])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  2 Apr 2026 03:59:17 +0000 (GMT)
Message-ID: <255cc5b6-e1f3-4fc7-b100-5db4635a04eb@linux.ibm.com>
Date: Thu, 2 Apr 2026 09:29:16 +0530
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
Subject: Re: [PATCH 2/2] powerpc/kexec: Disable KASAN for VMX helpers used in
 MMU-off path
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        linuxppc-dev@lists.ozlabs.org
Cc: Aditya Gupta <adityag@linux.ibm.com>, Daniel Axtens <dja@axtens.net>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Shivang Upadhyay <shivangu@linux.ibm.com>,
        Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
        Aboorva Devarajan <aboorvad@linux.ibm.com>
References: <20260321053121.614022-1-sourabhjain@linux.ibm.com>
 <20260321053121.614022-2-sourabhjain@linux.ibm.com>
 <wlyvmo0a.ritesh.list@gmail.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <wlyvmo0a.ritesh.list@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: bSNevfn1RrcV_bfx_ZqkvkwSq8P98xzz
X-Authority-Analysis: v=2.4 cv=KslAGGWN c=1 sm=1 tr=0 ts=69cde99d cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=JuTF4qcAAAAA:8 a=pGLkceISAAAA:8 a=PzjdQOMMOfR6aN2UM1UA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10 a=WlT8qwTXB_Kj6um4hl3b:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDAzMCBTYWx0ZWRfX8OLQc8TsVD5L
 ht3Cb0ai7qTb2rInJHDQ2CX81VmtvTuxf9JG2AX4+NfCE0HQsPFRM7WDjOWzqPTtdmnIFJ31sTV
 +yu6Ueq5USt9CfRFp9/n+GOZj9ntHyBjMZgo7kGbBSJgDSzz7T+7iO1nAZPxO30IH+EDea+XkQb
 NCe+bNzzPTnPcu7y/elBf/8c/04DjvzB+tMoEvegt+KjkGZjr0CcfjpfewVk35NMiZpENjvKdYG
 cKZu/D5rzdWny8aaDhb6tBbgKG/azz0JyMQijrE86TG3DNAri3yR3NSBuRgU2aJ0bngnE/8gHWV
 ERsLAOohimjIqjUrph90uu+P7gKrUhdpNS2GhllJvIKxNGtnPvuwp5OrkXmxjNIH7YXVRHHzaki
 AWLmVSESZRK/PH2C2GK0P3kvVV+wsc/Vjap/GY0Z0KZspNltWHnnOFATa6L4+pK8PMnOjZL8VWg
 0mGA49DgGzy8Mpudodg==
X-Proofpoint-ORIG-GUID: OTtQ9z9dlbFS9gYJ8EQ3KyQfb4E31jGx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_01,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 phishscore=0 adultscore=0 bulkscore=0 impostorscore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604020030



On 29/03/26 06:48, Ritesh Harjani (IBM) wrote:
> Sourabh Jain <sourabhjain@linux.ibm.com> writes:
>
>> The kexec sequence invokes enter_vmx_ops() and exit_vmx_ops() with the
>> MMU disabled. In this context, code must not rely on normal virtual
>> address translations or trigger page faults.
>> With KASAN enabled, these functions get instrumented and may access
>> shadow memory using regular address translation. When executed with
>> the MMU off, this can lead to page faults (bad_page_fault) from which
>> the kernel cannot recover in the kexec path, resulting in a hang.
> Right, so with mmu off, kernel can't access KASAN shadow memory.
>
> So, let me trace down the path a bit... you skipped an important detail
> i.e. preempt_count() is always inline, and we play a few tricks in kexec
> path to tell enter_vmx_ops() that we are in HARDIRQ mode.
>
> default_machine_kexec(image)
>      current_thread_info()->preempt_count = HARDIRQ_OFFSET
>
>      kexec_sequence(..., copy_with_mmu_off = 1)
>          if (copy_with_mmu_off) bl real_mode
>
>          bl kexec_copy_flush(image)
>              memcpy(ranges, image->segment, ...)
>
>              copy_segments()
>                  copy_page(dest, addr)
>
>                      bl enter_vmx_ops()
>                          if (in_interrupt() == true) return 0 // preempt_count == HARDIRQ_OFFSET
>                      beq .Lnonvmx_copy

Yes since preempt_count for the current thread is set to HARDIRQ_OFFSET 
we return early from copy_page() -> copypage_power7 -> enter_vmx_ops() 
and call to exit_vmx_ops is skipped.
>
>> Mark enter_vmx_ops() and exit_vmx_ops() with __no_sanitize_address to
>> avoid KASAN instrumentation and ensure kexec boots fine with KASAN
>> enabled.
>>
> IIUC, preempt_count() is always inline, and since you are disabling kasan
> instrumentation on enter_vmx_ops(), hence it just works for this reason.
> But you missed adding that detail here.

Yeah it is worth adding that in commit message. I will add it in v2.

>
> enter_vmx_ops()
>      if (in_interrupt()) // return 0
>             preempt_count() & ... | HARDIRQ_OFFSET   // preempt_count() is this is __always_inline
>
> static __always_inline int preempt_count(void)
> {
> 	return READ_ONCE(current_thread_info()->preempt_count);
> }
>
>> Cc: Aditya Gupta <adityag@linux.ibm.com>
>> Cc: Daniel Axtens <dja@axtens.net>
>> Cc: Hari Bathini <hbathini@linux.ibm.com>
>> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
>> Cc: Mahesh Salgaonkar <mahesh@linux.ibm.com>
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>> Cc: Shivang Upadhyay <shivangu@linux.ibm.com>
>> Cc: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
>> Reported-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
>> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
>> ---
>>   arch/powerpc/lib/vmx-helper.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/powerpc/lib/vmx-helper.c b/arch/powerpc/lib/vmx-helper.c
>> index 554b248002b4..c01b2d856650 100644
>> --- a/arch/powerpc/lib/vmx-helper.c
>> +++ b/arch/powerpc/lib/vmx-helper.c
>> @@ -52,7 +52,7 @@ int exit_vmx_usercopy(void)
>>   }
>>   EXPORT_SYMBOL(exit_vmx_usercopy);
>>   
>> -int enter_vmx_ops(void)
> In that case, should we should add a comment here saying:
>
> /*
>   * Can be called from kexec copy_page() path with MMU off. The kexec
>   * code sets preempt_count to HARDIRQ_OFFSET so we return early here.
>   * Since in_interrupt() is always inline, __no_sanitize_address on this
>   * function is sufficient to avoid KASAN shadow memory accesses in real
>   * mode.
>   */

Thanks for the write up, I will add it in v2.

>> +int __no_sanitize_address enter_vmx_ops(void)
>>   {
>>   	if (in_interrupt())
>>   		return 0;
>> @@ -69,7 +69,7 @@ int enter_vmx_ops(void)
>>    * passed a pointer to the destination which we return as required by a
>>    * memcpy implementation.
>>    */
>> -void *exit_vmx_ops(void *dest)
>> +void __no_sanitize_address *exit_vmx_ops(void *dest)
> I am assuming since we never enter into VMX in kexec path, so kexec path
> must not be calling exit_vmx_ops anyways? So do we need __no_sanitize_address here?

Agree in copypage_power7() we jump to  .Lnonvmx_copy label and do
not call exit_vmx_ops. I will remove __no_sanitize_address from 
exit_vmx_ops().

Thanks for the detailed review Ritesh.

- Soruabh Jain

