Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-f54.google.com (mail-pa0-f54.google.com
 [209.85.220.54])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B5B1D1A11B1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Apr 2015 16:34:33 +1000 (AEST)
Received: by paboj16 with SMTP id oj16so197367761pab.0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Apr 2015 23:34:32 -0700 (PDT)
Message-ID: <55349DF0.6090301@ozlabs.ru>
Date: Mon, 20 Apr 2015 16:34:24 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH kernel v8 15/31] powerpc/iommu: Fix IOMMU ownership control
 functions
References: <1428647473-11738-1-git-send-email-aik@ozlabs.ru>
 <1428647473-11738-16-git-send-email-aik@ozlabs.ru>
 <20150416061049.GF3632@voom.redhat.com> <5530DD6D.8000001@ozlabs.ru>
 <20150420024638.GE10218@voom>
In-Reply-To: <20150420024638.GE10218@voom>
Content-Type: text/plain; charset=koi8-r; format=flowed
Cc: Alex Williamson <alex.williamson@redhat.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/20/2015 12:46 PM, David Gibson wrote:
> On Fri, Apr 17, 2015 at 08:16:13PM +1000, Alexey Kardashevskiy wrote:
>> On 04/16/2015 04:10 PM, David Gibson wrote:
>>> On Fri, Apr 10, 2015 at 04:30:57PM +1000, Alexey Kardashevskiy wrote:
>>>> This adds missing locks in iommu_take_ownership()/
>>>> iommu_release_ownership().
>>>>
>>>> This marks all pages busy in iommu_table::it_map in order to catch
>>>> errors if there is an attempt to use this table while ownership over it
>>>> is taken.
>>>>
>>>> This only clears TCE content if there is no page marked busy in it_map.
>>>> Clearing must be done outside of the table locks as iommu_clear_tce()
>>>> called from iommu_clear_tces_and_put_pages() does this.
>>>>
>>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>>>> ---
>>>> Changes:
>>>> v5:
>>>> * do not store bit#0 value, it has to be set for zero-based table
>>>> anyway
>>>> * removed test_and_clear_bit
>>>> ---
>>>>   arch/powerpc/kernel/iommu.c | 26 ++++++++++++++++++++++----
>>>>   1 file changed, 22 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
>>>> index 7d6089b..068fe4ff 100644
>>>> --- a/arch/powerpc/kernel/iommu.c
>>>> +++ b/arch/powerpc/kernel/iommu.c
>>>> @@ -1052,17 +1052,28 @@ EXPORT_SYMBOL_GPL(iommu_tce_build);
>>>>
>>>>   static int iommu_table_take_ownership(struct iommu_table *tbl)
>>>>   {
>>>> -	unsigned long sz = (tbl->it_size + 7) >> 3;
>>>> +	unsigned long flags, i, sz = (tbl->it_size + 7) >> 3;
>>>> +	int ret = 0;
>>>> +
>>>> +	spin_lock_irqsave(&tbl->large_pool.lock, flags);
>>>> +	for (i = 0; i < tbl->nr_pools; i++)
>>>> +		spin_lock(&tbl->pools[i].lock);
>>>>
>>>>   	if (tbl->it_offset == 0)
>>>>   		clear_bit(0, tbl->it_map);
>>>>
>>>>   	if (!bitmap_empty(tbl->it_map, tbl->it_size)) {
>>>>   		pr_err("iommu_tce: it_map is not empty");
>>>> -		return -EBUSY;
>>>> +		ret = -EBUSY;
>>>> +		if (tbl->it_offset == 0)
>>>> +			set_bit(0, tbl->it_map);
>>>
>>> This really needs a comment.  Why on earth are you changing the it_map
>>> on a failure case?
>>
>>
>> Does this explain?
>>
>> /*
>>   * The platform code reserves zero address in iommu_init_table().
>>   * As we cleared busy bit for page @0 before using bitmap_empty(),
>>   * we are restoring it now.
>>   */
>
> Only partly.  What's it reserved for, and why do you know it was
> always set on entry?


Because it is only handled in this file and I can see it in the code. Or I 
did not understand the question here...




-- 
Alexey
