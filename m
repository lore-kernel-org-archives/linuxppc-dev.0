Return-Path: <linuxppc-dev+bounces-19421-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D51BFB519B
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Apr 2026 05:58:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fqb8Y4MSVz2ygf;
	Tue, 07 Apr 2026 15:58:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775541485;
	cv=none; b=SgAOTgLcs00fhLBicBoX5EPZ7kUU7NuvwDHnPw4KFoLwz88F539BMgNB2DbKKr3MNoJ3UmsVVzSJW0+17av2awIOdMefySaS9ScGZIJOMQ/LQ6bIYQix3yc70KkR9xzuIRtsRqEgJVnAtetpSlhVRQDzLpY14YiZKMBju5p6ArJ5VDkNggytKiNlDQAgBgHTj+doyKcaRGddOGeDLIwwNtJeXkvzrspQgcwCZUop5I2GeCVoJGxNDwsgI85iXmzVRc1bnwec2EVYiMU22vFgYoahHu8U3CxsUXcBN3W2qxfh6gCMyUwrEoN+fBt8eEuIhG8l8BAq1nSxuUiat3kKQw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775541485; c=relaxed/relaxed;
	bh=HIRL5YD693g6mrnyAxeytfb9yPKk1YnN1I1Kgwhb0+U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HSZ89zhnAafdtbVhg+lV0SvsS1ISU2D564J8Tu896VkmPRAZvttV6SrvNOsNJva6SuXMKL852mqVS8riWGQsxEWTbPYvIsLEzPAFsMNX/c/PQQcu+lLbzHbMlvBy8J9kJmIxSby/1aHwRpP24juFInyAHxo1b6kmB3tZcFQyESnF5ohLTqFJDoL/CRW4N1Ot5vqfLVsgdYoTz+UYOiSfymv1Gpw6xn947WBsAfa/aUjrmI92VmKDVJ0gF1M7ptFdkWht0fxnPmivRbpTojkfqr1vFt17874gFyTCfejXXUrl1WaeXhinZ1S82krB7YVGQXglLFvutb7xsR5gzMefvA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=OfBSh9gS; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=OfBSh9gS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fqb8X371Fz2xLt
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Apr 2026 15:58:03 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 636Lmc5n2326574;
	Tue, 7 Apr 2026 05:57:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=HIRL5Y
	D693g6mrnyAxeytfb9yPKk1YnN1I1Kgwhb0+U=; b=OfBSh9gSBfiDr5yELPEtUx
	u6/pgchgAInGY2ok1cOQg3z508NhI9a0LIuQcKfP8k3qzSw5qbvar39cXj6QRpva
	8DYX5EeOr6N/coS98AbzRFO5HekzZj8NC1pSpMBQvg/YXrkAhC5Td8N6z8t5jlyl
	AVjYXYe3WK+GSp0+Sv+MGcExuuhCPKRXZQcvM9gGR9ortii/yfnsxYpu69j/2u14
	fPQQ0axn0ZovhyDPVM9K1TZBqXh1eb0Mb6hvJWDMuU2n512f0qdgfjKc5StPNOcD
	oO8nWQdy+9P7P8jcNUcVsRDJQgRCsHHPwyIKKaYkEUlYVZXA8XAyCRZJPMg5bF6w
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2k9743-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 05:57:54 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6373WIOb030025;
	Tue, 7 Apr 2026 05:57:53 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dcme798ba-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 05:57:53 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6375vnmt30998854
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Apr 2026 05:57:49 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 19F2D2004B;
	Tue,  7 Apr 2026 05:57:49 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CF6E220043;
	Tue,  7 Apr 2026 05:57:46 +0000 (GMT)
Received: from [9.123.14.142] (unknown [9.123.14.142])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  7 Apr 2026 05:57:46 +0000 (GMT)
Message-ID: <52b6b61b-ada4-4387-8e33-7370868ffbc1@linux.ibm.com>
Date: Tue, 7 Apr 2026 11:27:44 +0530
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
Subject: Re: [PATCH v2 2/2] powerpc/vmx: avoid KASAN instrumentation in
 enter_vmx_ops() for kexec
To: Aboorva Devarajan <aboorvad@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: Aditya Gupta <adityag@linux.ibm.com>, Daniel Axtens <dja@axtens.net>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Shivang Upadhyay <shivangu@linux.ibm.com>,
        Venkat Rao Bagalkote <venkat88@linux.ibm.com>
References: <20260403190123.1383198-1-sourabhjain@linux.ibm.com>
 <20260403190123.1383198-2-sourabhjain@linux.ibm.com>
 <3d49964eb097dfd396249241e648d2d758090f5e.camel@linux.ibm.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <3d49964eb097dfd396249241e648d2d758090f5e.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDA1MiBTYWx0ZWRfXxoqO1Fkt/gnX
 QxHlJ4TzqB606xHU4qkCQVE8jfa0j4AB1oxYT7xeJyKN4haOCI+lngmqPVLyRblWqiinq7nywSH
 rwqWMj9cvOYJrUp8tl9mVKfYp/g4RXN1Myptj1lBW4UWDfY0+pRWrpYDHe1CZEg1g6WdEetvjr5
 eehsxe3wqc/2ndQgupNfCRQokb3dfNe02c9Vx68cIRMKyyjLfvTxDW4ue9F4V3k2zhpMInXb4ea
 qDkqOtu0+HqSi4vOmUiajYE/jYsiK8+5Civ12jTo1G9RsBccZaVMgUimZhYy/ucyemimFHWKZwz
 n553KV7NLv2QvdJDAefb3d78gcB4WPgJGXWcIe5NbJF0uhWYN5X2BuWvcxwLDqkYQaQ2fGCRnEs
 E/+kmaPoFtHItVcOnaKXjRYGl7JCS3SVrHFkrSCePzBHhx4z9DSgpc84DdSywgl9Xr/gFi4bS6h
 UYHx7gOUxNeBgJnCdBQ==
X-Proofpoint-ORIG-GUID: c1o0PW0bwZz2VZzUysiyILarNVVnANk0
X-Authority-Analysis: v=2.4 cv=e9k2j6p/ c=1 sm=1 tr=0 ts=69d49ce2 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=JuTF4qcAAAAA:8 a=pGLkceISAAAA:8 a=NQeVejqwlDu56fHJKk8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=WlT8qwTXB_Kj6um4hl3b:22
X-Proofpoint-GUID: 68QzNG5uMcNI6_nmdotrRFcf0YGJoVP2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_02,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 suspectscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070052



On 07/04/26 01:23, Aboorva Devarajan wrote:
> On Sat, 2026-04-04 at 00:31 +0530, Sourabh Jain wrote:
>> The kexec sequence invokes enter_vmx_ops() via copy_page() with the MMU
>> disabled. In this context, code must not rely on normal virtual address
>> translations or trigger page faults.
>>
>> With KASAN enabled, functions get instrumented and may access shadow
>> memory using regular address translation. When executed with the MMU
>> off, this can lead to page faults (bad_page_fault) from which the
>> kernel cannot recover in the kexec path, resulting in a hang.
>>
>> The kexec path sets preempt_count to HARDIRQ_OFFSET before entering
>> the MMU-off copy sequence.
>>
>> current_thread_info()->preempt_count = HARDIRQ_OFFSET
>>    kexec_sequence(..., copy_with_mmu_off = 1)
>>      -> kexec_copy_flush(image)
>>           copy_segments()
>>             -> copy_page(dest, addr)
>> 	         bl enter_vmx_ops()
>>                     if (in_interrupt())
>>                       return 0
>> 	         beq .Lnonvmx_copy
>>
>> Since kexec sets preempt_count to HARDIRQ_OFFSET, in_interrupt()
>> evaluates to true and enter_vmx_ops() returns early.
>>
>> As in_interrupt() (and preempt_count()) are always inlined, mark
>> enter_vmx_ops() with __no_sanitize_address to avoid KASAN
>> instrumentation and shadow memory access with MMU disabled, helping
>> kexec boot fine with KASAN enabled.
>>
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
>> Changelog:
>>
>> v2:
>> - Remove __no_sanitize_address from exit_vmx_ops
>> - Add a comment explaining that marking only enter_vmx_ops
>>    with __no_sanitize_address is sufficient for kexec to
>>    function properly with KASAN enabled
>>
>> v1:
>> https://lore.kernel.org/all/20260321053121.614022-1-sourabhjain@linux.ibm.com/
>> ---
>>   arch/powerpc/lib/vmx-helper.c | 9 ++++++++-
>>   1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/lib/vmx-helper.c b/arch/powerpc/lib/vmx-helper.c
>> index 554b248002b4..57e897b60db8 100644
>> --- a/arch/powerpc/lib/vmx-helper.c
>> +++ b/arch/powerpc/lib/vmx-helper.c
>> @@ -52,7 +52,14 @@ int exit_vmx_usercopy(void)
>>   }
>>   EXPORT_SYMBOL(exit_vmx_usercopy);
>>   
>> -int enter_vmx_ops(void)
>> +/*
>> + * Can be called from kexec copy_page() path with MMU off. The kexec
>> + * code sets preempt_count to HARDIRQ_OFFSET so we return early here.
>> + * Since in_interrupt() is always inline, __no_sanitize_address on this
>> + * function is sufficient to avoid KASAN shadow memory accesses in real
>> + * mode.
>> + */
>> +int __no_sanitize_address enter_vmx_ops(void)
>>   {
>>   	if (in_interrupt())
>>   		return 0;
>
> Without these patches, when KASAN is enabled, I observe a hang during kexec boot on
> pseries (PowerVM):
>
> [ 3459.012617][ T4209] kexec_core: Starting new kernel
> [ 3459.012814][ T4209] kexec: waiting for cpu 1 (physical 1) to enter 2 state
> [ 3459.016236][ T4209] kexec: waiting for cpu 11 (physical 11) to enter 2 state
> [ 3459.016287][ T4209] kexec: waiting for cpu 12 (physical 12) to enter 2 state
> [ 3459.016380][ T4209] kexec: waiting for cpu 13 (physical 13) to enter 2 state
> [ 3459.016418][ T4209] kexec: waiting for cpu 14 (physical 14) to enter 2 state
> [ 3459.016444][ T4209] kexec: waiting for cpu 15 (physical 15) to enter 2 state
> [ 3459.016462][ T4209] kexec: waiting for cpu 18 (physical 18) to enter 2 state
> [ 3459.271929][ T4209] kexec: Starting switchover sequence.
> [system hangs here and no further progress]
>
> ==============
>
> With both the patches applied, kexec completes successfully with KASAN enabled.
>
> Reviewed-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
> Tested-by: Aboorva Devarajan <aboorvad@linux.ibm.com>

Thanks for testing and the review.

- Sourabh Jain

