Return-Path: <linuxppc-dev+bounces-23678-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 646CDC43458
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Jul 2026 07:19:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gvXfP6XyVz3brt;
	Tue, 07 Jul 2026 17:19:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783408765;
	cv=none; b=jiHDnnP9xKGYCxoVCYXyUZjyG8tDQsEx7ZU5E1582OHIBrimfp8XyjwX4PrCcWCM8rOU/Bhezcri6G9N+tZm2z7m3wgK6uNtZiAaP9M1GDeCbjDmUGCXfOvw94rlBsjrxBqsOByqYyXn7mnNgFWppNbOPzdLN5Scvy/GThaFmmSy7fscwZv/z2DPjmm4lwIyUj7IqLP7C52DPkgJPvvujx1Wud6bGsyNKQ42OlN262qMwQXvuhE3YiBeupWbatXBhMcPmHeUy41U7Lnxrw3ChEzMPGKoVjE+uc+CMV8w1iZIsLtUaQtjLsT4m+h6OMI3M6HEWM7phPPNK58I1vcRxg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783408765; c=relaxed/relaxed;
	bh=TlTXBISLAgcbNZ/+VWXFyV6am3okMLflc7nxU3M/Tco=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AUS+Yv2LJKtmHpWQK0o0L+HfsNpcWSPH7Yk3eX5Y3sniyaU0nhK6/yVMLfXK8aRIdfaaQMvQCXRrs7mmewWH+pxmfenbVrA41tpesnd4Y35/q+cvdwGWkZOyqOmWdrRlpxbSc8x1fXFoIBLvcZMXG8fvx8vq8lT4IvJreFjf5YY+OKd5Ohl9yJWxvmASjcWF6GEELheNic9JxEwWvNSj+vrVybJLew9/thertQRBrjqvPFBkfj9YfHBzhszymZoJm4sTjH6funu0mHIGMHqETio4GakTZPQtpMphCkuSttCJFB74rRggYD46VtlwKq9j80uuMzonWdrwhTQ8gB4MJA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=sMddsvIc; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=nikhilks@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=sMddsvIc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=nikhilks@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gvXfN4KNCz2yR5
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Jul 2026 17:19:24 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6674INFO2385575;
	Tue, 7 Jul 2026 07:19:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=TlTXBI
	SLAgcbNZ/+VWXFyV6am3okMLflc7nxU3M/Tco=; b=sMddsvIcKszVwt5ju7UKTn
	ZLDVTvyKAR5Wvqy0qkk8cIZUY3bmjytqxXfRKzb3gJhrw9FSrEPS6IQ39ojHiFK9
	4FEjnLm3i4F0P5cvYkEcAGCcVlU8aE1izjiWseEVj+w2X4ifFJkHVRlO9jmEuzHU
	bPJK6C8oxg7W9fhIJF/QOYHErE0xn8rbGgdAWj64O+wH56+BQ0aLUbVEeWb8EUaZ
	QPr5B6OAMwnXRDABkMp6W0bmBpLfyN9MEC6kqvzCfjJGk+yttGXjuNEz2r7mmrYU
	LfnstWw6kaODbjuH1H5/zI+a+3F/vpLfW+5QNh9jh4ZRiafvc/GkBy8fYWn7wW/g
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sp3nrmq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jul 2026 07:19:09 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66774bw3023807;
	Tue, 7 Jul 2026 07:19:08 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7e0h9d3p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jul 2026 07:19:08 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6677J4oK39059864
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Jul 2026 07:19:04 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 012D12004F;
	Tue,  7 Jul 2026 07:19:04 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0167420049;
	Tue,  7 Jul 2026 07:19:00 +0000 (GMT)
Received: from [9.67.174.189] (unknown [9.67.174.189])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  7 Jul 2026 07:18:59 +0000 (GMT)
Message-ID: <86bee101-6bd4-45a6-a633-34f2a52d5ace@linux.ibm.com>
Date: Tue, 7 Jul 2026 12:48:57 +0530
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
Subject: Re: [PATCH v2] powerpc/64s: Clarify copy_and_flush() cache sync loop
 comment
To: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        chleroy@kernel.org, adityag@linux.ibm.com, mahesh@linux.ibm.com
References: <20260701182756.273019-1-nikhilks@linux.ibm.com>
 <20260706082708.43918-1-nikhilks@linux.ibm.com>
 <akyQQAiLHI3sVmTz@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
Content-Language: en-US
From: Nikhil Kumar Singh <nikhilks@linux.ibm.com>
In-Reply-To: <akyQQAiLHI3sVmTz@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=KsJ9H2WN c=1 sm=1 tr=0 ts=6a4ca86d cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=EEtNEHuYVbJky9YP0gIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDA2OSBTYWx0ZWRfX6RRM7NoGARDS
 gyuKeyc01L7ikLDUAgMcFGOJj7At4otLfTf1gPvU1NG3T6mSGu4PZhPLlzPalCorPA4uFig45fZ
 2HaJmu1wp6nBCB+Ky3p8gPrmRUSyH5U=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDA2OSBTYWx0ZWRfX8qnHME9JBzVk
 4cbVehXbl1UIp0Oc3rI9c6Bm5KvnGFQmU5IYaYNdQXyW00bJIVAnoqQ5tV44razRd4UDv4T1Cfr
 /JL6Qcla2e6g3sCip+r0/1kgk8PjEcCPSbg7VF6xs/lgshiSwzB5Irrtq625hLWWvjZiECMbuui
 QQVtRKguWR/BBbOJGkIOHWvdb2XHQVJ7BFLB2AZORnhCBmZK813o7H+ak+gtE9O2vWdKzzmhQF8
 rNNpPtjEoNLrM+tq21AmFD92/nOhUPjwiTx2dwgFpx72H0pGfjL3RCtaWM21C7k6udBAKd7Jvh6
 N9DjsSDCjRfVYXHyx02GbF/Ac6aURsHPVCHKiaFmkeMzZOsk4lHmdCPgGOP4vEe/8FbynFD1/ez
 8b3ZN5f15Wsa/AtUSsZ4uN9a0guv3lRZACe9Qt4aZtOBtRnCs3LFs4ZH2w2zmrW+laYCpcqyKh9
 cdFgfNLqcNHdBJNnDxQ==
X-Proofpoint-ORIG-GUID: MkGFt0B_qMheWO2n9cKNXAJaIxaceTSG
X-Proofpoint-GUID: k27bPG1diATK9yzxfssxIcWGn9jR0Arm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_01,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 adultscore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070069

Hi Mukesh,

Thanks for reviewing the patch and for the suggestion.
I'd prefer to keep the current alignment as I find it a bit more readable.

Thanks,
~ Nikhil

On 07/07/26 11:08, Mukesh Kumar Chaurasiya wrote:
> On Mon, Jul 06, 2026 at 01:57:08PM +0530, Nikhil Kumar Singh wrote:
>> The value loaded into r0 in copy_and_flush() represents the number of
>> 8-byte words processed between cache synchronization operations.
>>
>> The existing comment refers to cache line size, which can make it appear
>> that the value is a cache line size in bytes rather than a loop count.
>> Clarify the comment to explain that the loop processes 8 words (64 bytes)
>> per cache synchronization iteration, and that increasing the value would
>> skip cache maintenance for intermediate cache lines.
>>
>> This is a comment-only change with no functional impact.
>>
>> Signed-off-by: Nikhil Kumar Singh <nikhilks@linux.ibm.com>
>> ---
>>   arch/powerpc/kernel/head_64.S | 20 ++++++++++++--------
>>   1 file changed, 12 insertions(+), 8 deletions(-)
>>
>> diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
>> index 63432a33ec49..a54f6f979173 100644
>> --- a/arch/powerpc/kernel/head_64.S
>> +++ b/arch/powerpc/kernel/head_64.S
>> @@ -713,14 +713,18 @@ p_end: .8byte _end - copy_to_here
>>   _GLOBAL(copy_and_flush)
>>   	addi	r5,r5,-8
>>   	addi	r6,r6,-8
>> -4:	li	r0,8			/* Use the smallest common	*/
>> -					/* denominator cache line	*/
>> -					/* size.  This results in	*/
>> -					/* extra cache line flushes	*/
>> -					/* but operation is correct.	*/
>> -					/* Can't get cache line size	*/
>> -					/* from NACA as it is being	*/
>> -					/* moved too.			*/
>> +4:	li	r0,8			/* r0 is the number of 8-byte words	*/
>> +					/* to copy per cache sync iteration.	*/
>> +					/* 8 words * 8 bytes = 64 bytes. 64B is	*/
>> +					/* the current default cache line size.	*/
>> +					/* This is a loop count, not a byte	*/
>> +					/* count. Increasing it may skip	*/
>> +					/* dcbst/icbi for lines in between and	*/
>> +					/* leave stale instructions in icache.	*/
>> +					/* This results in extra cache line	*/
>> +					/* flushes but operation is correct.	*/
>> +					/* Can't get cache line size from NACA	*/
>> +					/* as it is being moved too.		*/
> The comment looks fine. But the alignement of the comment is still
> different from earlier. Keep the alignment same as earlier, it looks a
> little nicer.
>
> Regards,
> Mukesh
>>   
>>   	mtctr	r0			/* put # words/line in ctr	*/
>>   3:	addi	r6,r6,8			/* copy a cache line		*/
>> -- 
>> 2.43.5
>>

