Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yWCML0wL7zDrKD
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Nov 2017 13:01:01 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vA71nQlk001408
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Nov 2017 21:00:59 -0500
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2e32ffb0g4-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Nov 2017 21:00:58 -0500
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 6 Nov 2017 19:00:57 -0700
Subject: Re: [PATCH 1/5] powerpc/64s/hash: Fix 128TB-512TB virtual address
 boundary case allocation
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Florian Weimer <fweimer@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
References: <20171106100315.29720-1-npiggin@gmail.com>
 <20171106100315.29720-2-npiggin@gmail.com>
 <87y3njsne9.fsf@linux.vnet.ibm.com>
 <20171106215447.787e58fd@roar.ozlabs.ibm.com>
 <13f9578b-f907-1809-9aaa-cbb87c419bc6@linux.vnet.ibm.com>
Date: Tue, 7 Nov 2017 07:30:51 +0530
MIME-Version: 1.0
In-Reply-To: <13f9578b-f907-1809-9aaa-cbb87c419bc6@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <d7815f37-cd13-4506-3e6b-cc2aa1cc0787@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 11/06/2017 04:35 PM, Aneesh Kumar K.V wrote:
> 
> 
> On 11/06/2017 04:24 PM, Nicholas Piggin wrote:
>> On Mon, 06 Nov 2017 16:08:06 +0530
>> "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> wrote:
>>
>>> Nicholas Piggin <npiggin@gmail.com> writes:
>>>
>>>> When allocating VA space with a hint that crosses 128TB, the SLB 
>>>> addr_limit
>>>> variable is not expanded if addr is not > 128TB, but the slice 
>>>> allocation
>>>> looks at task_size, which is 512TB. This results in slice_check_fit()
>>>> incorrectly succeeding because the slice_count truncates off bit 128 
>>>> of the
>>>> requested mask, so the comparison to the available mask succeeds.
>>>
>>>
>>> But then the mask passed to slice_check_fit() is generated using
>>> context.addr_limit as max value. So how did that return succcess? ie,
>>> we get the request mask via
>>>
>>> slice_range_to_mask(addr, len, &mask);
>>>
>>> And the potential/possible mask using
>>>
>>> slice_mask_for_size(mm, psize, &good_mask);
>>>
>>> So how did slice_check_fit() return sucess with
>>>
>>> slice_check_fit(mm, mask, good_mask);
>>
>> Because the addr_limit check is used to *limit* the comparison.
>>
>> The available mask had bit up to 127 set, and the mask had 127 and
>> 128 set. However the 128T addr_limit causes only bits 0-127 to be
>> compared.
>>
> 
> Should we fix it then via ? I haven't tested this yet. Also this result 
> in us comparing more bits?
> 
> modified   arch/powerpc/mm/slice.c
> @@ -169,13 +169,12 @@ static int slice_check_fit(struct mm_struct *mm,
>                  struct slice_mask mask, struct slice_mask available)
>   {
>       DECLARE_BITMAP(result, SLICE_NUM_HIGH);
> -    unsigned long slice_count = 
> GET_HIGH_SLICE_INDEX(mm->context.addr_limit);
> 
>       bitmap_and(result, mask.high_slices,
> -           available.high_slices, slice_count);
> +           available.high_slices, SLICE_NUM_HIGH);
> 
>       return (mask.low_slices & available.low_slices) == mask.low_slices &&
> -        bitmap_equal(result, mask.high_slices, slice_count);
> +        bitmap_equal(result, mask.high_slices, SLICE_NUM_HIGH)
> 
> 

Florian, will you be able to test this patch ? We may not really want to 
push this. But it will confirm that we end up getting >128TB address 
because of this.

-aneesh
