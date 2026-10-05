Return-Path: <linuxppc-dev+bounces-28923-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6C1DCA5FCE
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Oct 2026 09:13:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hytw31N0Vz2yf9;
	Mon, 05 Oct 2026 20:13:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791191587;
	cv=none; b=e/YK+PZaQ82sS8keZJYU3XwMXb3Gkmo7DdXEfkCQgBXJL73sXCjJvnp2Hf5sZj/OranzOuOcs3M5hxoPXJSROSNNMNAMkj83iBvXVn+79U5JElE9ml7jKmpToi8WwczYmCF9+cB1IpYBBRAaZjfuz+i/uUxiKjdwQ7VuIj3GF3g9qpZGNm2Dp1BNuekul24qD5Gn1oLTvJDfo3SODJ30qu0apciC8mF6loMSxCo3e9AqupPixivlVMI+4j3+0kKP+Vbehsl7nWzfzDe9iuQbND2k/To6yT+4smeI7dp3choU/DYqYlpYaCjoxYJYo/571E7loYq+ddGtf3j2lDnciA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791191587; c=relaxed/relaxed;
	bh=utxReP00qD5cgqEWxGBm18zTCm8VojZQaF5MSHHROUQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T4hcQWzG5OoOU3ic0uNUto0BZBUAZSTLxAHGf08gFXftZXATpyywyI3EV+ZzIOWM9jk+qbXBGJUqlGOctAjTSRKZRu1icH5XTGJbeNPNwizgKqeYOW/DeS4eevgO4F0jz/j+OnAlgYJHYvlvGtKuBmGiFSHtOu0Fm8k6vxJsnHkspaD3tvUsYrljMvMV++8h0vcuzjsserSURnVjXJ8m5XRvN30Pq0sU2bfgi8UflNq5vDc+r/PeQf3n3IDC1PE1lEdji3eYeNk3301LlLRy3Uz8LYYRVvqrTzIaPhQQW5zuhIUX7yuansNOm6pwTMZryEIjEh84THTxnT1RBwmfGQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=W0wQqDOj; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=W0wQqDOj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hytw13Z10z2xCC
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Oct 2026 20:13:04 +1100 (AEDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69516hra3276412;
	Mon, 5 Oct 2026 09:12:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=utxReP
	00qD5cgqEWxGBm18zTCm8VojZQaF5MSHHROUQ=; b=W0wQqDOj8WMJEBHN54EWFs
	t3F8mchffU7RUPGCIbna4Z96bGUmMd2isOsNZygVc9b180jH/o9Md0xpoYvmpcFB
	1RdDXF9N2aYuXizkcFTfUUVIieXhlUOaSOji38lQGErVx2Mngflld8fTArcrB93H
	DIY9LH163jOyC8sWmQdKXos4+S3V3Kn1RmN5+cBWM8ZjI4ouf4b4+/Nj/kREgl1y
	87vmDe+B5zTe2Qtb2+J2syIIVB0dliCjeQNEygPqp8gZFDw60hko/fhUe4+g2rTC
	uUWOYAjB7dU+nvRGOR2dCzUP6lKKXLk6eSRtn66+UZseNFhL8JlY8lZ9DZVZcvMA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2se59axa-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 05 Oct 2026 09:12:46 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6956S4rk2175575;
	Mon, 5 Oct 2026 09:12:45 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h3eqy4h42-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Oct 2026 09:12:45 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6959Cf9A48169384
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 5 Oct 2026 09:12:42 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 77A8D20040;
	Mon,  5 Oct 2026 09:12:41 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 01B5A2004B;
	Mon,  5 Oct 2026 09:12:38 +0000 (GMT)
Received: from [9.123.14.142] (unknown [9.123.14.142])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  5 Oct 2026 09:12:37 +0000 (GMT)
Message-ID: <a5a1879f-32e4-4e7f-a209-6ec4826c937f@linux.ibm.com>
Date: Mon, 5 Oct 2026 14:42:37 +0530
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
Subject: Re: [PATCH v1 1/2] kho: check scratch vs CMA alignment at runtime
To: Mike Rapoport <rppt@kernel.org>
Cc: kexec@lists.infradead.org, Aditya Gupta <adityag@linux.ibm.com>,
        Alexander Graf <graf@amazon.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <baoquan.he@linux.dev>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Shivang Upadhyay <shivangu@linux.ibm.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
References: <20260928083226.107807-1-sourabhjain@linux.ibm.com>
 <20260928083226.107807-2-sourabhjain@linux.ibm.com>
 <asC15ISMMbHMwnHi@kernel.org>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <asC15ISMMbHMwnHi@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDAzNiBTYWx0ZWRfXz7edKAP3e9+i
 mvX6hewUt/vlLwnts11l0A7mpkv49bpI/PS9nb+fKU0L212iUw8itQ1kJ31RnbP+gBmWsi1pMB8
 DZbmxCa7bFZR4Rjb9Fo2hoTwe+GHRTc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDAzNiBTYWx0ZWRfX75QgcX01hVAd
 wVwzG1dOTHEM6laQ+uHZmKye3IdTcVapEBSZpALEkR3cFN+tDMEb7QcL3OyMN9ZT2bHz9wJ+M4C
 VgCV+o5XB2jC9P6t4X4y6zYQw8uRn/KFq+/aZd/ti07qiIdGF+OQVh6d8LdiAmL8S+OMBtrm009
 BUc63hiNu+yV4yEdY6nFPafop6n2NbWI9atVansrlCebcWG7OUT5JDNJSHz/hdzjLtvBZJ53f3h
 FzPrsoocMfuArkmiDvMw3sZsbugA3aVkfYdIoFaV9okS3LRzXmRGWsbR+EwsNj+0wyJbL0zHiKW
 h1uLbsfET0zEIEwJsmvrN7XkxXeiPSWo5pFjq5MfV5+8nxmUwgmPCR82p+64HLzUXMokbRRoXsX
 n0kmGGmSY2C2vSbQ8bJv7Yret8x36WPvMcWFT6oFd+31X1A4EC2FCuiuJO63MYnGnplwOm82YFw
 o4RU4+s9DsOl2RnCflQ==
X-Proofpoint-GUID: goHjBEAZB996cFteavISIUM1oEYle7Ki
X-Authority-Analysis: v=2.4 cv=UNRIjyfy c=1 sm=1 tr=0 ts=6ac36a0f cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=vggBfdFIAAAA:8 a=Z4Rwk6OoAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=7ipKWUHlAAAA:8 a=voM4FWlXAAAA:8 a=rxpbpe3YEeMVxz9nh0AA:9 a=QEXdDO2ut3YA:10
 a=HkZW87K1Qel5hWWM3VKY:22 a=gpc5p9EgBqZVLdJeV_V1:22 a=IC2XNlieTeVoXbcui8wp:22
X-Proofpoint-ORIG-GUID: LC6TT4KO37m9DrhgAtOZuI7GeiqV65P-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_01,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050036



On 03/10/26 13:29, Mike Rapoport wrote:
> Hi,
>
> On Mon, Sep 28, 2026 at 02:02:25PM +0530, Sourabh Jain wrote:
>> KHO requires the scratch alignment to be at least CMA_MIN_ALIGNMENT_BYTES,
>> and this is currently enforced with a static_assert().
>>
>> That assertion breaks the build on powerpc once CONFIG_KEXEC_HANDOVER is
>> enabled together with CONFIG_TRANSPARENT_HUGEPAGE or CONFIG_HUGETLB_PAGE:
>>
>>      kernel/liveupdate/kexec_handover.c:49:39: error: expression in static assertion is not constant
>>         49 | static_assert(SCRATCH_ALIGNMENT_BYTES >= CMA_MIN_ALIGNMENT_BYTES);
>>      ./include/linux/build_bug.h:80:56: note: in definition of macro '__static_assert'
>>         80 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
>>            |                                                        ^~~~
>>      kernel/liveupdate/kexec_handover.c:49:1: note: in expansion of macro 'static_assert'
>>         49 | static_assert(SCRATCH_ALIGNMENT_BYTES >= CMA_MIN_ALIGNMENT_BYTES);
>>
>> CMA_MIN_ALIGNMENT_BYTES depends on pageblock_order, which is not a
>> compile-time constant with certain configs, such as
>> CONFIG_HUGETLB_PAGE_SIZE_VARIABLE on powerpc. The next patch in this
>> series enables KHO on powerpc, so the alignment must be checked at
>> runtime instead.
>>
>> Replace the static_assert() with a runtime check at the start of
>> kho_reserve_scratch(), before any scratch memory is reserved. If the
>> scratch alignment is smaller than the CMA minimum alignment, warn once
>> and disable KHO rather than continue with a misaligned reservation.
> Can we keep static_assert() for everything !powerpc please?

Yeah, that's a good idea. We can have a dynamic check for cases
where a static check is not possible.

Thanks for the suggestion.

- Sourabh Jain


> Like something along these lines:
>
> #ifndef CONFIG_HUGETLB_PAGE_SIZE_VARIABLE
> #define check_scratch_alignment static_assert(...)
> #else
> static inline bool check_scratch_alignment()
> {
> ...
> }
> #endif
>
>   
>> Cc: Aditya Gupta <adityag@linux.ibm.com>
>> Cc: Alexander Graf <graf@amazon.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Baoquan He <baoquan.he@linux.dev>
>> Cc: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
>> Cc: Hari Bathini <hbathini@linux.ibm.com>
>> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
>> Cc: Mahesh Salgaonkar <mahesh@linux.ibm.com>
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: Mike Rapoport <rppt@kernel.org>
>> Cc: Nicholas Piggin <npiggin@gmail.com>
>> Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
>> Cc: Pratyush Yadav <pratyush@kernel.org>
>> Cc: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>> Cc: Shivang Upadhyay <shivangu@linux.ibm.com>
>> Cc: Shrikanth Hegde <sshegde@linux.ibm.com>
>> Cc: linux-kernel@vger.kernel.org
>> Cc: linuxppc-dev@lists.ozlabs.org
>> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
>> ---
>>   kernel/liveupdate/kexec_handover.c | 23 +++++++++++++++--------
>>   1 file changed, 15 insertions(+), 8 deletions(-)
>>
>> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
>> index 7c4d86daf86d..dc76dd6b74da 100644
>> --- a/kernel/liveupdate/kexec_handover.c
>> +++ b/kernel/liveupdate/kexec_handover.c
>> @@ -39,15 +39,7 @@
>>   #include "../kexec_internal.h"
>>   #include "kexec_handover_internal.h"
>>   
>> -/*
>> - * This is the minimal alignment required by deferred struct page init.
>> - * deferred_init_memmap_chunk frees memory to the buddy allocator, which looks
>> - * at the neighboring pages (up to MAX_PAGE_ORDER) to merge them.
>> - * If KHO scratch is not aligned to that value, buddy can access uninitialized
>> - * struct pages, which can cause a crash.
>> - */
>>   #define SCRATCH_ALIGNMENT_BYTES (PAGE_SIZE * MAX_ORDER_NR_PAGES)
>> -static_assert(SCRATCH_ALIGNMENT_BYTES >= CMA_MIN_ALIGNMENT_BYTES);
>>   
>>   /* The magic token for preserved pages */
>>   #define KHO_PAGE_MAGIC 0x4b484f50U /* ASCII for 'KHOP' */
>> @@ -836,6 +828,21 @@ static void __init kho_reserve_scratch(void)
>>   	if (!kho_enable)
>>   		return;
>>   
>> +	/*
>> +	 * This is the minimal alignment required by deferred struct page init.
>> +	 * deferred_init_memmap_chunk frees memory to the buddy allocator, which looks
>> +	 * at the neighboring pages (up to MAX_PAGE_ORDER) to merge them.
>> +	 * If KHO scratch is not aligned to that value, buddy can access uninitialized
>> +	 * struct pages, which can cause a crash.
>> +	 */
>> +	if (WARN_ON_ONCE(SCRATCH_ALIGNMENT_BYTES < CMA_MIN_ALIGNMENT_BYTES)) {
>> +		pr_err("scratch alignment %lu < CMA minimum %lu, disabling\n",
>> +		       (unsigned long)SCRATCH_ALIGNMENT_BYTES,
>> +		       (unsigned long)CMA_MIN_ALIGNMENT_BYTES);
>> +		kho_enable = false;
>> +		return;
>> +	}
>> +
>>   	scratch_size_update();
>>   
>>   	/* FIXME: deal with node hot-plug/remove */
>> -- 
>> 2.55.0
>>


