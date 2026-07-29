Return-Path: <linuxppc-dev+bounces-24976-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BC0EC54F51
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Jul 2026 08:19:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h94x26qW8z2xrL;
	Wed, 29 Jul 2026 18:19:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785313142;
	cv=none; b=Fd346CI+Jhu2r60t74aEFEnu715Eob9B9n48B20oP3w2H7dX3Qt5+AjHmCi+xeCjdHZaaJDjMFSpioMVPOs9kK2ZU831lHmlED5pPgB4Tq6xgA0gUkKqTnlJ44IAuuhaChEd7aW/sPdbmOXho7skZ70837nDspD1Rr/sYvXnuX01Aj1NfSEbIKMDpiMkGKw8/JjeSaRd2G0a6o1hT1OWvLz8CSJimjRGY94s944iaGcf0STbsdEK/fuevJ6rWYiAbX7DKU4FRuQ4Fx7EWNamNuorjOyIn9lJxL8l1vQ0acIdQixH6tENiXAwKRE+17bxG7q6pQsA0RbKjuhm9jT5RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785313142; c=relaxed/relaxed;
	bh=qHtPl7nOdkSYwQ4Ir2f+XPdS3oEZ6S7dVVJOyL5LvTk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bfOh/RCCqePkdxVD9UL3WQnSZJvuk4V/WsMkPYa105KC9LizN7PcgyY4zYHs1eqZMyUky0tWOBY5mil2NAMJ06G755IxkoXNSe8WD3XwzgX+ad1CDrq+doFWAo0eiOiZEkF42mZc4DQnvXzEyorsKq//MgnxjrdsW5Bb01ytE1FkxP1UYolf4IPlVHElLLJQ8Qasa1OqQp1fcKarOFuUFq7rH34T+F9++Xd74ARARIfaiPNIv12UyJE1NSkagcouSOaPFwKC4isQOhnc+vl3xpWo67jAIuycV0YyfPCsAxR0l0Xr9xPOXvIpW0jtQO+6dPcNCYfzoJ8jbZef5VQvXA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=QP8wl1ni; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=QP8wl1ni;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h94x20vt5z2xFc
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jul 2026 18:19:01 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66T7m3N03509245;
	Wed, 29 Jul 2026 08:18:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=qHtPl7
	nOdkSYwQ4Ir2f+XPdS3oEZ6S7dVVJOyL5LvTk=; b=QP8wl1nikmJrKNA/psZlOT
	hhw8kcOXWFE55C4ycW1+6pUI7GBTxGENzgPhNdIQfsEzcB4J+GowWIMjU/e5nICJ
	vLigbdaIo09r9r0vFKqxI8YsBwc0lXTMw4rtOd4bDNoY++EQUhVB7sOpUF3p0MEn
	CjmK7eBthPqW21gYoN3ngE1Elmh8HescPnGb2RFBI2Ed84Pyrya0mbafnKMEA7yj
	3DROFvQtxyxuzPFXdf8n8TGfIBXHghBEjm0X7UwfEilCtmZsCpM3cmaeqmdoOoPr
	EVNqQXcfIwFUmT4JqV+ZkkXoMwIEoXVvfAL10b0FZWM0towU4YgSj9dLw9Hyv50g
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0nrvm4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 08:18:42 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66T8Buvd023759;
	Wed, 29 Jul 2026 08:18:42 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8fk5ufp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 08:18:42 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66T8Iaw826280664
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jul 2026 08:18:36 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 49DC22004B;
	Wed, 29 Jul 2026 08:18:36 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6D45B20040;
	Wed, 29 Jul 2026 08:18:32 +0000 (GMT)
Received: from [9.39.24.31] (unknown [9.39.24.31])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 Jul 2026 08:18:32 +0000 (GMT)
Message-ID: <31030168-596c-4e1d-bdd6-cb9b4199b5a5@linux.ibm.com>
Date: Wed, 29 Jul 2026 13:48:31 +0530
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
Subject: Re: [PATCH v2 3/3] powerpc/kexec_file: Prevent kexec range truncation
To: Jinjie Ruan <ruanjinjie@huawei.com>, maddy@linux.ibm.com,
        mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
        rppt@kernel.org, baoquan.he@linux.dev, hbathini@linux.ibm.com,
        adityag@linux.ibm.com, ritesh.list@gmail.com, bauerman@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20260729012948.2797865-1-ruanjinjie@huawei.com>
 <20260729012948.2797865-4-ruanjinjie@huawei.com>
 <12df5a43-792a-45a9-9524-fa974cc1ce62@linux.ibm.com>
 <3a296aeb-d978-4460-bc7d-0500873127fc@huawei.com>
 <11d4d195-ed61-42f6-a59d-c2d42b4b9251@linux.ibm.com>
 <774a2a84-bd3a-40a0-831a-860c978db9f0@huawei.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <774a2a84-bd3a-40a0-831a-860c978db9f0@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDA2NyBTYWx0ZWRfX3gvLIcA1aW/x
 9v5as76PrBXjPy2C3JGqns9y1scsjABZWEb4+GOk3AHr50u3JuKWKRfo2yKBcvpb4UQTXBHGeKB
 DAsATokhAGWFi2gahpMLBxdn7j0TeyU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDA2NyBTYWx0ZWRfX54vhXS6GfyAL
 sOCG/N3mVzTxdhRnNhVPNSFfh7BczU2PXmZzL2vArsMEbVDfpQY5e6NLg5sbZYFJWcuhU/K+Cf8
 gFmW52urQ3/8UbG1OBsh6BkQvYOZOo47xRCrM7F/Cst8sMOiLKBuFMFdS8xzaA2AeuCtmIMe1rd
 CBwriB12i6TfINKsu8xAPHAZj2f6fsyPzM7SMKLWnK8xJdugerBtsfnMgL0NbVU42e6xUFDY0sn
 iukQXc8tCP9sa+WN4VsG5YZpeKBIzqndMZBWheHhpG0RMNW7fdpK+hyXMjhFrOt7oz9iT4/A+eL
 i7S1rV6i7Kb0VsYQQOYC6oPbR7haq2j05HDQnBL/RTVcrY01EnS7sAKZSkHFU/ji2sc78I6J6KT
 bzxCeUBwUzFLjCUyOLtvFoUSTMZQ3OTVvdsWrX4ayug9ziWZM891moWDLhPu+/OvRnCGEF+l8dh
 qygMFph3uxkqgBmGGtw==
X-Authority-Analysis: v=2.4 cv=b5WCJNGx c=1 sm=1 tr=0 ts=6a69b763 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=i0EeH86SAAAA:8 a=ySpMQNN6z8kT0b9Rh_YA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: xx8ixoCj_D7Fo5B2Pla5apIsDtEEDbwd
X-Proofpoint-ORIG-GUID: LDy16L4Ds1lXSsGEpeYVJpfb7izVX4iY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_03,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290067



On 29/07/26 12:36, Jinjie Ruan wrote:
>
> 在 2026/7/29 14:44, Sourabh Jain 写道:
>>
>> On 29/07/26 11:56, Jinjie Ruan wrote:
>>> 在 2026/7/29 12:43, Sourabh Jain 写道:
>>>> On 29/07/26 06:59, Jinjie Ruan wrote:
>>>>> Sashiko AI review pointed out the following issue.
>>>>>
>>>>> The __merge_memory_ranges() function incorrectly handles overlapping
>>>>> memory ranges when merging them. Although sort_memory_ranges() sorts
>>>>> all
>>>>> ranges by their start address in ascending order beforehand, the merge
>>>>> logic remains defective in two ways:
>>>>>
>>>>> 1. It compares the current range's start against the previous element
>>>>> (i-1)
>>>>>       instead of the running target index (idx)
>>>>>
>>>>> 2. It unconditionally overwrites 'ranges[idx].end' with
>>>>> 'ranges[i].end'.
>>>>>
>>>>> This logic flaw leads to critical memory truncation when a larger
>>>>> memory
>>>>> range completely subsumes subsequent smaller ranges.
>>>>>
>>>>> For example, consider a sorted input array with three ranges:
>>>>>      Range A (idx=0): [0x1000 - 0x9000]
>>>>>      Range B (i=1):   [0x2000 - 0x5000] (completely inside Range A)
>>>>>      Range C (i=2):   [0x6000 - 0x8000] (completely inside Range A)
>>>>>
>>>>> 1. When i=1 (Range B):
>>>>>       ranges[1].start (0x2000) <= ranges[0].end + 1 (0x9001) is TRUE.
>>>>>       The code executes: ranges[0].end = ranges[1].end, which
>>>>> erroneously
>>>>>       shrinks Range A's end from 0x9000 down to 0x5000.
>>>>>
>>>>> 2. When i=2 (Range C):
>>>>>       ranges[2].start (0x6000) <= ranges[1].end + 1 (0x5001) is FALSE.
>>>>>       The code falls into the else block, creating a broken new range.
>>>>>
>>>>> As a result, valid memory fragments [0x5001 - 0x5fff] and [0x8001 -
>>>>> 0x9000]
>>>>> are completely lost from the kexec exclude lists, potentially allowing
>>>>> the crash kernel to overwrite active memory, causing data corruption
>>>>> or crashes.
>>>>>
>>>>> Fix this by ensuring the start of the current range is compared
>>>>> against the
>>>>> end of the active merged range (idx), and use max() to safely
>>>>> prevent the
>>>>> outer boundary from being truncated.
>>>>>
>>>>> Cc: Sourabh Jain <sourabhjain@linux.ibm.com>
>>>>> Cc: Hari Bathini <hbathini@linux.ibm.com>
>>>>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>>>>> Cc: stable@vger.kernel.org
>>>>> Fixes: 180adfc532a8 ("powerpc/kexec_file: Add helper functions for
>>>>> getting memory ranges")
>>>>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>>>>> ---
>>>>>     arch/powerpc/kexec/ranges.c | 12 +++++-------
>>>>>     1 file changed, 5 insertions(+), 7 deletions(-)
>>>>>
>>>>> diff --git a/arch/powerpc/kexec/ranges.c b/arch/powerpc/kexec/ranges.c
>>>>> index e5fea23b191b..539061d14a77 100644
>>>>> --- a/arch/powerpc/kexec/ranges.c
>>>>> +++ b/arch/powerpc/kexec/ranges.c
>>>>> @@ -21,6 +21,7 @@
>>>>>     #include <linux/of.h>
>>>>>     #include <linux/slab.h>
>>>>>     #include <linux/memblock.h>
>>>>> +#include <linux/minmax.h>
>>>>>     #include <linux/crash_core.h>
>>>>>     #include <asm/sections.h>
>>>>>     #include <asm/kexec_ranges.h>
>>>>> @@ -105,19 +106,16 @@ static void __merge_memory_ranges(struct
>>>>> crash_mem *mem_rngs)
>>>>>         struct range *ranges;
>>>>>         int i, idx;
>>>>>     -    if (!mem_rngs)
>>>>> +    if (!mem_rngs || mem_rngs->nr_ranges <= 1)
>>>>>             return;
>>>> Although the below loop handles this but it is good to return early when
>>>> there is
>>>> only range.
>>>>
>>>>>           idx = 0;
>>>>> -    ranges = &(mem_rngs->ranges[0]);
>>>>> +    ranges = mem_rngs->ranges;
>>>>>         for (i = 1; i < mem_rngs->nr_ranges; i++) {
>>>>> -        if (ranges[i].start <= (ranges[i-1].end + 1))
>>>>> -            ranges[idx].end = ranges[i].end;
>>>>> +        if (ranges[i].start <= (ranges[idx].end + 1))
>>>>> +            ranges[idx].end = max(ranges[idx].end, ranges[i].end);
>>>> Yeah this changes is needed.
>>>>
>>>>>             else {
>>>>>                 idx++;
>>>>> -            if (i == idx)
>>>>> -                continue;
>>>> Do we really need to remove the above condition?
>>>>
>>>> Isn't this condition is helpful till we find an overlap?
>>> Hi Sourabh,
>>>
>>> I believe there is no functional change here. The else branch itself
>>> already indicates that there will be no overlap this time, so we can
>>> safely use ranges[i] as the next memory region.
>> I agree that keeping or removing it doesn't change the functionality.
>>
>> My point is that it helps avoid copying a range onto itself. For example:
>>
>> Range A (idx = 0): [0x1000 - 0x2000]
>> Range B (idx = 1): [0x3000 - 0x5000]
>> Range C (idx = 2): [0x6000 - 0x8000]
>>
>> For all three ranges,  idx = i = x and kernel will do:
>> ranges[x] = ranges[x];
>>
>> This self-assignment can be avoided if we keep the condition instead of
>> removing it. Isn't it?
> Yes, with the continue we can avoid the self-assignment.
>
> If this review is fine, can it be updated and submitted directly, or
> does it need to be updated in the new version?

A new version will be helpful. And feel free to add:
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>

>
>> - Sourabh Jain
>>
>>
>>> Whether we remove it or keep it is fine.
>>>
>>>> - Sourabh Jain
>>>>
>>>>> -
>>>>>                 ranges[idx] = ranges[i];
>>>>>             }
>>>>>         }


