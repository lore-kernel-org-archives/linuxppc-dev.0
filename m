Return-Path: <linuxppc-dev+bounces-28919-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68412CA5FCE
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Oct 2026 08:12:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hysZ25C04z2ypW;
	Mon, 05 Oct 2026 19:12:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791187946;
	cv=none; b=VjwpLvDMZyECsOzPQTQ/C9JJwoWwrITxQ01C5/X9rIY7R3NzuAjwcB7BKwfXU03I/UeZ+l3yCOAF7NdNUX9CFW985VvNXx2DwL5gWKBo8COSsUAADFgSAhlzV+nnXq9jWBwInktZZL6YVmbCqQx8pcW8lVsEd3D70x82cik4dK09skoEmrfAX9oW8HMp8jGpKJmaprGrVvmVBPJJYv06Uc9EDkW7iO+T8gPv3ZnZROb46OUX83z1UfLtWQ3by+egFSUN28TZN5r8u+Ce0PpAUZ4zFH7/ApYfQ4ngULVU2LKo3T9kX9OACKx0XXd0G0UlPWhEyMluDTCnkXBi6sfgYg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791187946; c=relaxed/relaxed;
	bh=3cbbU741SbgqZJRcAAr1PPJbwn07RoCYANAWs6/OtKM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NIVi3lOzIYdkXry/+3vMe+o6OSpSXN7FX7d8PrXlMAgN2RlVQl7+5x7Xn6orxNqnEZmwHXArIPJEorV6LSC7465lnallWtKcWqnw5nSz9eEgl1l1SIhHpuuxxKbVgkT4C+oCk19XQDaA6xZQYjahQOOcivAm+2yVcvYGmXzEfIlljWU2hemziMXowDF4vU3deb64mNuE7+YihBwylMWPds9mTP1huuKZcPaNMSlTQZD4q1IARMru4JJumFeJiDT27zePNqcrVtLoBtyYqkrclGf0m+SP2oKEln9/7ayIn3YO9FdGANmDCL0Wwg6Q0jB4axTwB+2SQft1Q+qWWvwB2g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ngO95+Jh; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ngO95+Jh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hysZ05qZWz2y8G
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Oct 2026 19:12:24 +1100 (AEDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69516P9m3139667;
	Mon, 5 Oct 2026 08:12:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=3cbbU7
	41SbgqZJRcAAr1PPJbwn07RoCYANAWs6/OtKM=; b=ngO95+JhozgjhU+iiLHEhU
	R2UdJuTuHQZigkxpC2zy/K805ixzcp2SeEQi8B+Hddb+3/0lOUJ4iN8g18xGC/GM
	um7ghf1OA9xQlmU+vyYX115CT7Kp56QM+LNk4CRNsg5Q+pwPuZSfLR64UAg85RKQ
	xTiI4HQzzBrsg4PMPqlQt6AEfZfERDI0BvttWOYZlEaRTvrp1oE41yHd/Kiyrlug
	XpWLznX3NJav+xP1GNTmCl+rURDCiBn9jSS2r9Iu4QabfUtxkbJnTd/RNoQh8UNM
	7BYlBhPi1vYT+Pf8naF538N//wDa2KE1UAQjKhy96mdl/qUQjiYy6OLNd10IeVYQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2q4jgsfe-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 05 Oct 2026 08:12:09 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6956Ex0M2165217;
	Mon, 5 Oct 2026 08:12:08 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h3c1pmr90-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Oct 2026 08:12:08 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6958C4Ox45679086
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 5 Oct 2026 08:12:04 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BAA0920043;
	Mon,  5 Oct 2026 08:12:04 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6496C2004D;
	Mon,  5 Oct 2026 08:12:02 +0000 (GMT)
Received: from [9.123.14.142] (unknown [9.123.14.142])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  5 Oct 2026 08:12:02 +0000 (GMT)
Message-ID: <dbb4580d-7e20-4c38-9716-f39cf81a4942@linux.ibm.com>
Date: Mon, 5 Oct 2026 13:42:01 +0530
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
Subject: Re: [PATCH] powerpc/kexec: Annotate umem_info members with
 __counted_by_ptr
To: Thorsten Blum <blum@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Aditya Gupta <adityag@linux.ibm.com>,
        Hari Bathini <hbathini@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20260730130248.597249-2-thorsten.blum@linux.dev>
 <7d99725f-9c90-48ca-bee1-30e2e6c06617@linux.ibm.com>
 <asDClaRrHuKB44X-@kernel.org>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <asDClaRrHuKB44X-@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: SQmkxSjXfSF0Aigi6LvjR4rGT_ajmLVq
X-Proofpoint-GUID: 9Ws2SgDQDx_bhgExN4tr_8LPPrwIjVn5
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDAzMiBTYWx0ZWRfX+0yfOZeCg6vm
 Uy7QXUgn19+yDolbA9djlMEm0MsnAaGWc4YDmeIld5zNQsRh1jOe9pxpSVioqG2wbrs+5QWdj1n
 3nJfH1jcwRPqWO4BfZ1az6/cuHK3i5Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDAzMiBTYWx0ZWRfXwpwS+slmMMhU
 K3S8luuLydR1udZG+G+vNHsDKRrMNlFKF4lFAxhh2tlqbiNu74aQvmUvrWzxQyyOe5zN/jjyMNf
 718++icBmYkCM+OGsi2UUMqO5lXYD3N2r6featpLN4qYbAPHNVSQtCI8lLxcfPnBrzAPl1sfXiV
 k6JVFlr2785uNn8IXFCwp+Z5z15K64eEAPPDnvBWOFebO8+xGDJEtwODjt9qFOyUobAXQrWaRnR
 r4FxDZ4HJZ9mB6uAneEtHtP0fRsDTRSeYyqHj4rXfMdxUSWZcK5D+9nVE3h7k+Onl8f436/i9Tk
 75HW7nDmWpQZQLpwLEDga7BxJTlncIsy0uo9PVXxX3t/Y2CpAsZywVjdMhS4Hqwx4kbfABNs9dS
 hejRV326jVGq3qwrQUlKL9OTE9Ed8T84g1mUbywhTIsFJcsPOsr1YOxZy+K3SXnSGx4Pvxg7uvX
 ewiN5topA2limY/olZA==
X-Authority-Analysis: v=2.4 cv=eYeo7LEH c=1 sm=1 tr=0 ts=6ac35bda cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=9AdMxfjQAAAA:20
 a=EDIrg12U6glrp4Io1RoA:9 a=QEXdDO2ut3YA:10 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_01,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 clxscore=1015
 spamscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050032



On 03/10/26 14:23, Thorsten Blum wrote:
> On Fri, Sep 25, 2026 at 11:49:04AM +0530, Sourabh Jain wrote:
>> On 30/07/26 18:32, Thorsten Blum wrote:
>>> Add __counted_by_ptr() to umem_info::buf and umem_info::ranges to
>>> improve access bounds checking via CONFIG_UBSAN_BOUNDS and
>>> CONFIG_FORTIFY_SOURCE.
>>>
>>> Set the count fields before assigning the corresponding pointers, return
>>> early on krealloc() failure, and use sizeof(*buf) when deriving
>>> max_entries from the allocation size.
>>>
>>> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
>>> ---
>>>    arch/powerpc/kexec/file_load_64.c | 22 ++++++++++++----------
>>>    1 file changed, 12 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/arch/powerpc/kexec/file_load_64.c b/arch/powerpc/kexec/file_load_64.c
>>> index 8c72e12ea44e..6424b668f0e9 100644
>>> --- a/arch/powerpc/kexec/file_load_64.c
>>> +++ b/arch/powerpc/kexec/file_load_64.c
>>> @@ -34,14 +34,15 @@
>>>    #include <asm/cputhreads.h>
>>>    struct umem_info {
>>> -	__be64 *buf;		/* data buffer for usable-memory property */
>>> +	/* data buffer for usable-memory property */
>>> +	__be64 *buf __counted_by_ptr(max_entries);
>>>    	u32 size;		/* size allocated for the data buffer */
>>>    	u32 max_entries;	/* maximum no. of entries */
>>>    	u32 idx;		/* index of current entry */
>>>    	/* usable memory ranges to look up */
>>>    	unsigned int nr_ranges;
>>> -	const struct range *ranges;
>>> +	const struct range *ranges __counted_by_ptr(nr_ranges);
>>>    };
>> [...]
>>>    const struct kexec_file_ops * const kexec_file_loaders[] = {
>>> @@ -83,11 +84,12 @@ static __be64 *check_realloc_usable_mem(struct umem_info *um_info, int cnt)
>>>    	new_size = um_info->size + MEM_RANGE_CHUNK_SZ;
>>>    	tbuf = krealloc(um_info->buf, new_size, GFP_KERNEL);
>>> -	if (tbuf) {
>>> -		um_info->buf = tbuf;
>>> -		um_info->size = new_size;
>>> -		um_info->max_entries = (um_info->size / sizeof(u64));
>>> -	}
>>> +	if (!tbuf)
>>> +		return NULL;
>>> +
>>> +	um_info->size = new_size;
>>> +	um_info->max_entries = um_info->size / sizeof(*um_info->buf);
>>> +	um_info->buf = tbuf;
>>
>> Could you please explain why size and max_entries are updated before the
>> buffer itself?
> __counted_by_ptr() requires the counter ->max_entries to be set before
> the ->buf pointer is assigned; otherwise you have an inconsistent state
> where the counter doesn't match the pointer.

But isn't updating the counter holding the buffer size before the actual 
buffer
can cause problems?

Can you share the document link of __counted_by_ptr() which says that 
size counter to be
updated before the buffer pointer.

Here is an example in fs/coredump.c file where size counter is updated 
after the buffer
with __counter_by_ptr():

https://github.com/torvalds/linux/blob/a90ee4305c4a5df72c11b31dacfdc76e00fcf78a/fs/coredump.c#L98
https://github.com/torvalds/linux/blob/a90ee4305c4a5df72c11b31dacfdc76e00fcf78a/fs/coredump.c#L115

- Sourabh Jain

> And ->size is moved up because ->max_entries depends on it.



