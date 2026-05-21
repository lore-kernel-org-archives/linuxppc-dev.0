Return-Path: <linuxppc-dev+bounces-21336-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAE88CD4F3D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 May 2026 14:35:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gLrY42Qr0z2y7Y;
	Fri, 22 May 2026 00:35:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779374120;
	cv=none; b=TUhnWCm5FA7RURl62PgtHpsnldpGIFL+enTX5NT2j6kmD7QYEsjutXJ9+4G0FcAQLutRfHfIFS1+us2OlxgRNBxU+gd5o5f65ahH1VJLj1q6Zdej1la2eBMQgwFU8F043wB4+qGDhgzo99RqpExEI7trOrGNbU+HFjIuyBp8ctSbOgK5EPZ0IAQbUBEe9AA1QIe8+O9Iz71GTswmHhh831S37xYgKqtlHeM4uRvWUdZdRSoDSRu4LmIxM4HpEQ/Iv3pnbc8e22UwXQ8U4JiyDuD2nm0Zc4lKyINjbTUr8ViQ3c79234vfpbrhqSEpueUVNx4lZwbC/VlyNL4MfMuig==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779374120; c=relaxed/relaxed;
	bh=GhnFomH22GFQ6can2TpHBwAEx6p2G4Qw2kKyCPWjQ3M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kCE+raMMZT4rVLUxSMmcxdjbx3g/a3mK8Jr9V90Q7XJNtXmjDVt+yav2JuS+x5kJKAXw6XeKnDuiBXlRdVUZw1DMeSWnf/SukHwLp4dn0U0YSixUTJs74jQYijhFvL4ChYW6GqqD5JcxfBcXvwv3mknhrjGPQwL3RzpYjPeUlC51PNEXpITJ+jF2Xm6VazDZy9IZRTQQ3dBaRLwLsfBx9hT222faAwM9lFGwe6fjvoDAwEGAYpBo5NJIX0fn/5szeVeruUxe/X8a02j210o14qnJ781fJjCv9CRzoQVFMH/387fYnEkXVCvWH8kdsroZsKBYU49azBJ3GmfDHj2WnQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=SzoL3KoY; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=SzoL3KoY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gLrY25gqTz2xqJ
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 May 2026 00:35:17 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64L1dt024007920;
	Thu, 21 May 2026 14:35:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=GhnFom
	H22GFQ6can2TpHBwAEx6p2G4Qw2kKyCPWjQ3M=; b=SzoL3KoY5Yo8A0pyrRQAOK
	0A6kOGNrXzdbbn50pP96RDYNBNu05kjEce5YMoraWGbcPBizSgkD7bHUa2A3JOBp
	YC1d0+VECHHB2xDeZx/v1NZjnke9+9fb00kLVFvr7u3TJYY4GeMbUSj15EQKG5jw
	WgAuAPHOBCiyWBM9AvovEfIafMEGsLj1kjNyDIE4R+VsaPdrFO3M2VCTidgFwyKY
	zRU93PrNsiiE+IxPEHkoqv18mdmR98ZBBwOSQduDVy1HBazZFbRsnF9xzV1WufJs
	uabAIv1trSswIwa9C5wU0xq49SXZKzzKvYGp8q/jSPaZuGwAPzYXg8+B0YdSxslw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h9y7je6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 14:35:14 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64LEOBd5006250;
	Thu, 21 May 2026 14:35:13 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e75kycb72-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 14:35:13 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64LEZCLL20316784
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 May 2026 14:35:12 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AB1BF58062;
	Thu, 21 May 2026 14:35:12 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ADFD758052;
	Thu, 21 May 2026 14:35:08 +0000 (GMT)
Received: from [9.124.215.175] (unknown [9.124.215.175])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 21 May 2026 14:35:08 +0000 (GMT)
Message-ID: <e21bf17f-09d0-4a0e-a74a-5d9904a590a2@linux.ibm.com>
Date: Thu, 21 May 2026 20:05:06 +0530
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
Subject: Re: [PATCH] powerpc/fadump: fix integer overflow in MIN_RMA size
 check
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
        Michael Ellerman <mpe@kernel.org>, Nicholas Piggin <npiggin@gmail.com>
Cc: linux-kernel@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Sourabh Jain <sourabhjain@linux.ibm.com>
References: <00e9b516b13316f7ce81b651957dad0441e56006.1779255851.git.sayalip@linux.ibm.com>
 <d68d87ab-9149-4fb9-98a6-39b2e7ed2efa@kernel.org>
Content-Language: en-IN
From: Sayali Patil <sayalip@linux.ibm.com>
In-Reply-To: <d68d87ab-9149-4fb9-98a6-39b2e7ed2efa@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDE0MiBTYWx0ZWRfXzJ+Yhhf7QdOD
 WHeIji5EFdNLG/pHT+JP+I1ntThmRz0y5Zhwpo+1A/sDm3lfWJZuk14N5BMe2oU7On/hcUH51Jb
 OrNpp0iO/pCTz3NM4Kywwh9q731/nTtqYSXwOI8ghY3aJ024Vzi3Oc4f5nko74hsdlIVHsR0B7L
 ULPRu6AQedrE9WQ4kewa7kHTwA5ggRgMCGZ1Wx2hwUvQID664U4HqdsrE2aGpxmGSOlRXK7nB4V
 UjTbPCZblQVAZPAwl7Qj5tidOLk8rtNjKw3AzN2yLXTckBt8pzl4UPBQ5WjQqKhbKqFefnRDzp1
 8IiZOW/nktH2jOpt49W+mdGGJOSYcfZcFnClh9Zj6GXBU7GJpi3ZeTC3lU498/VS01qLo9bmEjt
 j+8tWJKOXUQR9OD7mB3ImSVHfmDzOOs8NiEhXAFiY5o/gUMYHqYMrGh/5zQ3jyRZPWkUw/fqQN+
 vvzVPX7LRLEvBqoKfeA==
X-Authority-Analysis: v=2.4 cv=BNuDalQG c=1 sm=1 tr=0 ts=6a0f1822 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=uFrerwBItCu7WUtJqroA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: FIwRuX90IcjctAIFR9rwhHCEIJD2AlX2
X-Proofpoint-GUID: Pez8KN814vbDpHsV6Z2HQ79d0JLnMKVg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210142



On 20/05/26 14:30, Christophe Leroy (CS GROUP) wrote:
> 
> 
> Le 20/05/2026 à 07:53, Sayali Patil a écrit :
>> The MIN_RMA size checks in fadump_setup_param_area() use
>> (MIN_RMA * 1024 * 1024), which is evaluated in int and can
>> overflow when MIN_RMA is 2048 or larger. This triggers compiler
>> warnings such as:
>>
>> warning: integer overflow in expression of type 'int'
>> results in '0' [-Woverflow]
>>
>> Promote MIN_RMA to u64 before the multiplication so the expression
>> is evaluated in 64-bit and matches the surrounding physical address
>> and memory size calculations.
>>
>> This fixes both the comparison against ppc64_rma_size and the
>> assignment to range_start.
> 
> How do you create that problem ? MIN_RMA has a fixed value of 768 which 
> is defined in asm/prom.h
Agreed, MIN_RMA is currently fixed at 768MB.
While going through the code, I thought this could become a
problem if MIN_RMA is increased beyond values such as SZ_2G.

> 
>>
>> Fixes: b7bb46062457 ("powerpc/fadump: fix additional param memory 
>> reservation for HASH MMU")
>> Signed-off-by: Sayali Patil <sayalip@linux.ibm.com>
>> ---
>>   arch/powerpc/kernel/fadump.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
>> index 501d43bf18f3..dea7f7105e42 100644
>> --- a/arch/powerpc/kernel/fadump.c
>> +++ b/arch/powerpc/kernel/fadump.c
>> @@ -1759,10 +1759,10 @@ void __init fadump_setup_param_area(void)
>>            * 2. The range should be between MIN_RMA and RMA size 
>> (ppc64_rma_size)
>>            * 3. It must not overlap with the fadump reserved area.
>>            */
>> -        if (ppc64_rma_size < MIN_RMA*1024*1024)
>> +        if (ppc64_rma_size < (u64)MIN_RMA * 1024 * 1024)
> 
> As you are modifying that line, please use SZ_1M instead of keeping 
> opencoded 1024 * 1024.
> 
>>               return;
>> -        range_start = MIN_RMA * 1024 * 1024;
>> +        range_start = (u64)MIN_RMA * 1024 * 1024;
> 
> Same.
> 
>>           range_end = min(ppc64_rma_size, fw_dump.boot_mem_top);
>>       }
> 
> Maybe the best would be to define MIN_RMA as a bytes value in asm/prom.h 
> and to divide the value by SZ_1M in kernel/prom_init.c when initialising 
> ibm_architecture_vec_template.
> 
> That way you could just define it as SZ_2G instead of the problematic 
> 2048 you mention.
> 
> 
Thanks for the review Christophe!
I will incorporate all the suggested improvements in v2.

Regards,
Sayali

