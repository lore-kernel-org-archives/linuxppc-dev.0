Return-Path: <linuxppc-dev+bounces-24974-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07C2BC54F51
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Jul 2026 07:07:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h93Kz3rPKz2xrL;
	Wed, 29 Jul 2026 17:07:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.221
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785308823;
	cv=none; b=icEsDxJO5yDLp28bGtcV1//l32svv7H5xXMyH3TW03yEIBx/ufypYUrd/31DGtd/GviigV/xaH90kBJl9O4sv26FBQv+i1dAkVXkQ505A0MGgq8Czg/Qb6XiwLthejALzd1HDxw84JjapS3LC7lCNP3TFXOfIpH+4NPUN+ddH2LVBge7jCudOx+MjlpG6vCJyrtvP2mZJbjUY6d0tAN9BUPhCOkVP3KclHRBqaB2KN1c8YnplTWdjGMUOirD/eEHgfdxofVLNjCylhM5GGcAwr8D80u82+vBqZ97Rqbp8LQO4r839kV/zjEPLJWmfL8QiZCvDM0gH5oY1oOn8joEaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785308823; c=relaxed/relaxed;
	bh=ddNx3kGvkXozlJHzMn1Bc6InDYJCM1M1ttJfHSw5WBY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=RSZ9rrsfN+K0IEKT5Thu/eqNprOc4zCPvoEF+dgy3736pwdv6oZna/s0sNjJsjDSrGfEuKJeXfe1YpjWAc8BeEMo4BfVBpMJAN3APoM784H8dO8g+aFHEoi1dcs1uZXZsflkpzX0IF8/RkLyDW7xQpaT3Bs3v2EPF59+mZczx5+KYRzcI74I5k7BLzzmitDl8y2+/3a7w9QemykWcgdKYNVYRi0yGe1qd+vlJl8RrhYeTg/pBLDTuBy67BH3ViJFTIhsRvxwYM6Xa+PsUX400ace23B2tVzu1QnK4GIWZ+Jl0O0mG7CY+4/Pa5Uj0+19Dtj7qWOiGF3i/jp+0YDXKg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=aMmNXZ2C; dkim-atps=neutral; spf=pass (client-ip=113.46.200.221; helo=canpmsgout06.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=aMmNXZ2C;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.221; helo=canpmsgout06.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout06.his.huawei.com (unknown [113.46.200.221])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h93Kw0jgJz2xnp
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jul 2026 17:06:57 +1000 (AEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=ddNx3kGvkXozlJHzMn1Bc6InDYJCM1M1ttJfHSw5WBY=;
	b=aMmNXZ2CSu8pR6I+daYal1x8zFxmM+fkM1pK8jwsBR/iCBSjo5+S/aNmIfQpgmR5gDx26qaBQ
	+RJzwp7l6jygJNFvm2FLMh66gC48vHR0PzOEKlsT/g0LjonmXKZ+K/sb9xQLrQplWBQAJSvY9K/
	dHrt6OI0PnwNEP09AlI3l5E=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4h936s0qltzRhR0;
	Wed, 29 Jul 2026 14:57:25 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id CD84240538;
	Wed, 29 Jul 2026 15:06:50 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 dggpemf500011.china.huawei.com (7.185.36.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 29 Jul 2026 15:06:50 +0800
Message-ID: <774a2a84-bd3a-40a0-831a-860c978db9f0@huawei.com>
Date: Wed, 29 Jul 2026 15:06:49 +0800
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
To: Sourabh Jain <sourabhjain@linux.ibm.com>, <maddy@linux.ibm.com>,
	<mpe@ellerman.id.au>, <npiggin@gmail.com>, <chleroy@kernel.org>,
	<rppt@kernel.org>, <baoquan.he@linux.dev>, <hbathini@linux.ibm.com>,
	<adityag@linux.ibm.com>, <ritesh.list@gmail.com>, <bauerman@linux.ibm.com>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
References: <20260729012948.2797865-1-ruanjinjie@huawei.com>
 <20260729012948.2797865-4-ruanjinjie@huawei.com>
 <12df5a43-792a-45a9-9524-fa974cc1ce62@linux.ibm.com>
 <3a296aeb-d978-4460-bc7d-0500873127fc@huawei.com>
 <11d4d195-ed61-42f6-a59d-c2d42b4b9251@linux.ibm.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <11d4d195-ed61-42f6-a59d-c2d42b4b9251@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 dggpemf500011.china.huawei.com (7.185.36.131)



在 2026/7/29 14:44, Sourabh Jain 写道:
> 
> 
> On 29/07/26 11:56, Jinjie Ruan wrote:
>>
>> 在 2026/7/29 12:43, Sourabh Jain 写道:
>>>
>>> On 29/07/26 06:59, Jinjie Ruan wrote:
>>>> Sashiko AI review pointed out the following issue.
>>>>
>>>> The __merge_memory_ranges() function incorrectly handles overlapping
>>>> memory ranges when merging them. Although sort_memory_ranges() sorts
>>>> all
>>>> ranges by their start address in ascending order beforehand, the merge
>>>> logic remains defective in two ways:
>>>>
>>>> 1. It compares the current range's start against the previous element
>>>> (i-1)
>>>>      instead of the running target index (idx)
>>>>
>>>> 2. It unconditionally overwrites 'ranges[idx].end' with
>>>> 'ranges[i].end'.
>>>>
>>>> This logic flaw leads to critical memory truncation when a larger
>>>> memory
>>>> range completely subsumes subsequent smaller ranges.
>>>>
>>>> For example, consider a sorted input array with three ranges:
>>>>     Range A (idx=0): [0x1000 - 0x9000]
>>>>     Range B (i=1):   [0x2000 - 0x5000] (completely inside Range A)
>>>>     Range C (i=2):   [0x6000 - 0x8000] (completely inside Range A)
>>>>
>>>> 1. When i=1 (Range B):
>>>>      ranges[1].start (0x2000) <= ranges[0].end + 1 (0x9001) is TRUE.
>>>>      The code executes: ranges[0].end = ranges[1].end, which
>>>> erroneously
>>>>      shrinks Range A's end from 0x9000 down to 0x5000.
>>>>
>>>> 2. When i=2 (Range C):
>>>>      ranges[2].start (0x6000) <= ranges[1].end + 1 (0x5001) is FALSE.
>>>>      The code falls into the else block, creating a broken new range.
>>>>
>>>> As a result, valid memory fragments [0x5001 - 0x5fff] and [0x8001 -
>>>> 0x9000]
>>>> are completely lost from the kexec exclude lists, potentially allowing
>>>> the crash kernel to overwrite active memory, causing data corruption
>>>> or crashes.
>>>>
>>>> Fix this by ensuring the start of the current range is compared
>>>> against the
>>>> end of the active merged range (idx), and use max() to safely
>>>> prevent the
>>>> outer boundary from being truncated.
>>>>
>>>> Cc: Sourabh Jain <sourabhjain@linux.ibm.com>
>>>> Cc: Hari Bathini <hbathini@linux.ibm.com>
>>>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>>>> Cc: stable@vger.kernel.org
>>>> Fixes: 180adfc532a8 ("powerpc/kexec_file: Add helper functions for
>>>> getting memory ranges")
>>>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>>>> ---
>>>>    arch/powerpc/kexec/ranges.c | 12 +++++-------
>>>>    1 file changed, 5 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/arch/powerpc/kexec/ranges.c b/arch/powerpc/kexec/ranges.c
>>>> index e5fea23b191b..539061d14a77 100644
>>>> --- a/arch/powerpc/kexec/ranges.c
>>>> +++ b/arch/powerpc/kexec/ranges.c
>>>> @@ -21,6 +21,7 @@
>>>>    #include <linux/of.h>
>>>>    #include <linux/slab.h>
>>>>    #include <linux/memblock.h>
>>>> +#include <linux/minmax.h>
>>>>    #include <linux/crash_core.h>
>>>>    #include <asm/sections.h>
>>>>    #include <asm/kexec_ranges.h>
>>>> @@ -105,19 +106,16 @@ static void __merge_memory_ranges(struct
>>>> crash_mem *mem_rngs)
>>>>        struct range *ranges;
>>>>        int i, idx;
>>>>    -    if (!mem_rngs)
>>>> +    if (!mem_rngs || mem_rngs->nr_ranges <= 1)
>>>>            return;
>>> Although the below loop handles this but it is good to return early when
>>> there is
>>> only range.
>>>
>>>>          idx = 0;
>>>> -    ranges = &(mem_rngs->ranges[0]);
>>>> +    ranges = mem_rngs->ranges;
>>>>        for (i = 1; i < mem_rngs->nr_ranges; i++) {
>>>> -        if (ranges[i].start <= (ranges[i-1].end + 1))
>>>> -            ranges[idx].end = ranges[i].end;
>>>> +        if (ranges[i].start <= (ranges[idx].end + 1))
>>>> +            ranges[idx].end = max(ranges[idx].end, ranges[i].end);
>>> Yeah this changes is needed.
>>>
>>>>            else {
>>>>                idx++;
>>>> -            if (i == idx)
>>>> -                continue;
>>> Do we really need to remove the above condition?
>>>
>>> Isn't this condition is helpful till we find an overlap?
>> Hi Sourabh,
>>
>> I believe there is no functional change here. The else branch itself
>> already indicates that there will be no overlap this time, so we can
>> safely use ranges[i] as the next memory region.
> 
> I agree that keeping or removing it doesn't change the functionality.
> 
> My point is that it helps avoid copying a range onto itself. For example:
> 
> Range A (idx = 0): [0x1000 - 0x2000]
> Range B (idx = 1): [0x3000 - 0x5000]
> Range C (idx = 2): [0x6000 - 0x8000]
> 
> For all three ranges,  idx = i = x and kernel will do:
> ranges[x] = ranges[x];
> 
> This self-assignment can be avoided if we keep the condition instead of
> removing it. Isn't it?

Yes, with the continue we can avoid the self-assignment.

If this review is fine, can it be updated and submitted directly, or
does it need to be updated in the new version?

> 
> - Sourabh Jain
> 
> 
>> Whether we remove it or keep it is fine.
>>
>>> - Sourabh Jain
>>>
>>>> -
>>>>                ranges[idx] = ranges[i];
>>>>            }
>>>>        }
> 


