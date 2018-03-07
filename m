Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zxF8L4VH1zF1cK
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Mar 2018 00:38:08 +1100 (AEDT)
Subject: Re: [PATCH 06/10] powerpc/mm/slice: implement slice_check_range_fits
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>
References: <20180306132507.10649-1-npiggin@gmail.com>
 <20180306132507.10649-7-npiggin@gmail.com>
 <e600126e-ab89-e15b-e4c3-17dec7799a57@c-s.fr>
 <20180307091232.4fb8d3c2@roar.ozlabs.ibm.com>
 <a61d33eb-dde3-526a-0847-e2d56f824217@c-s.fr>
 <20180307171621.00ec8814@roar.ozlabs.ibm.com>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <2c36df9f-74e0-c7aa-eb48-2ea1ba79b614@c-s.fr>
Date: Wed, 7 Mar 2018 14:38:02 +0100
MIME-Version: 1.0
In-Reply-To: <20180307171621.00ec8814@roar.ozlabs.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 07/03/2018 à 08:16, Nicholas Piggin a écrit :
> On Wed, 7 Mar 2018 07:12:23 +0100
> Christophe LEROY <christophe.leroy@c-s.fr> wrote:
> 
>> Le 07/03/2018 à 00:12, Nicholas Piggin a écrit :
>>> On Tue, 6 Mar 2018 15:41:00 +0100
>>> Christophe LEROY <christophe.leroy@c-s.fr> wrote:
>>>    
>>>> Le 06/03/2018 à 14:25, Nicholas Piggin a écrit :
> 
>>>>> @@ -596,10 +601,11 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
>>>>>     	slice_or_mask(&potential_mask, &good_mask);
>>>>>     	slice_print_mask(" potential", &potential_mask);
>>>>>     
>>>>> -	if ((addr != 0 || fixed) &&
>>>>> -			slice_check_fit(mm, &mask, &potential_mask)) {
>>>>> -		slice_dbg(" fits potential !\n");
>>>>> -		goto convert;
>>>>> +	if (addr || fixed) {
>>>>> +		if (slice_check_range_fits(mm, &potential_mask, addr, len)) {
>>>>> +			slice_dbg(" fits potential !\n");
>>>>> +			goto convert;
>>>>> +		}
>>>>
>>>> Why not keep the original structure and just replacing slice_check_fit()
>>>> by slice_check_range_fits() ?
>>>>
>>>> I believe cleanups should not be mixed with real feature changes. If
>>>> needed, you should have a cleanup patch up front the serie.
>>>
>>> For code that is already changing, I think minor cleanups are okay if
>>> they're very simple. Maybe this is getting to the point of needing
>>> another patch. You've made valid points for a lot of other unnecessary
>>> cleanups though, so I'll fix all of those.
>>
>> Ok, that's not a big point, but I like when patches really modifies
>> only the lines they need to modify.
> 
> Fair point, and in the end I agree mostly they should do that. But I
> don't think entirely if you can make the code slightly better as you
> go (again, so long as the change is obvious). I think having extra
> patches for trivial cleanups is not that great either.
> 
>> Why do we need a double if ?
>>
>> Why not just the following ? With proper alignment of the second line
>> with the open parenthese, it fits in one line
>>
>> 	if ((addr != 0 || fixed) &&
>> -			slice_check_fit(mm, &mask, &potential_mask)) {
>> +	    slice_check_range_fits(mm, &potential_mask, addr, len)) {
>>    		slice_dbg(" fits potential !\n");
>>    		goto convert;
> 
> For this case the main motivation was to make this test match the
> form of the same test (with different mask) above here. Doing the
> same thing with different coding styles annoys me.

Yes good point.

Christophe

> 
> I think I kept this one but fixed all your other suggestions in
> the v2 series.
> 
> Thanks,
> Nick
> 
