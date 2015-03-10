Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-f48.google.com (mail-pa0-f48.google.com
 [209.85.220.48])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AF5E71A0631
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2015 10:45:29 +1100 (AEDT)
Received: by pabli10 with SMTP id li10so6296476pab.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Mar 2015 16:45:27 -0700 (PDT)
Message-ID: <54FF8211.5020001@ozlabs.ru>
Date: Wed, 11 Mar 2015 10:45:21 +1100
From: Alexey Kardashevskiy <aik@ozlabs.ru>
MIME-Version: 1.0
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v5 03/29] vfio: powerpc/spapr: Check that TCE page size
 is equal to it_page_size
References: <1425910045-26167-1-git-send-email-aik@ozlabs.ru>		
 <1425910045-26167-4-git-send-email-aik@ozlabs.ru>	
 <1426017408.25026.79.camel@redhat.com> <54FF76F4.5020503@ozlabs.ru>
 <1426028606.25026.86.camel@redhat.com>
In-Reply-To: <1426028606.25026.86.camel@redhat.com>
Content-Type: text/plain; charset=koi8-r; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/11/2015 10:03 AM, Alex Williamson wrote:
> On Wed, 2015-03-11 at 09:57 +1100, Alexey Kardashevskiy wrote:
>> On 03/11/2015 06:56 AM, Alex Williamson wrote:
>>> On Tue, 2015-03-10 at 01:06 +1100, Alexey Kardashevskiy wrote:
>>>> This checks that the TCE table page size is not bigger that the size of
>>>> a page we just pinned and going to put its physical address to the table.
>>>>
>>>> Otherwise the hardware gets unwanted access to physical memory between
>>>> the end of the actual page and the end of the aligned up TCE page.
>>>>
>>>> Since compound_order() and compound_head() work correctly on non-huge
>>>> pages, there is no need for additional check whether the page is huge.
>>>>
>>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>>>> ---
>>>> Changes:
>>>> v4:
>>>> * s/tce_check_page_size/tce_page_is_contained/
>>>> ---
>>>>    drivers/vfio/vfio_iommu_spapr_tce.c | 22 ++++++++++++++++++++++
>>>>    1 file changed, 22 insertions(+)
>>>>
>>>> diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
>>>> index 756831f..91e7599 100644
>>>> --- a/drivers/vfio/vfio_iommu_spapr_tce.c
>>>> +++ b/drivers/vfio/vfio_iommu_spapr_tce.c
>>>> @@ -49,6 +49,22 @@ struct tce_container {
>>>>    	bool enabled;
>>>>    };
>>>>
>>>> +static bool tce_page_is_contained(struct page *page, unsigned page_shift)
>>>> +{
>>>> +	unsigned shift;
>>>> +
>>>> +	/*
>>>> +	 * Check that the TCE table granularity is not bigger than the size of
>>>> +	 * a page we just found. Otherwise the hardware can get access to
>>>> +	 * a bigger memory chunk that it should.
>>>> +	 */
>>>> +	shift = PAGE_SHIFT + compound_order(compound_head(page));
>>>> +	if (shift >= page_shift)
>>>> +		return true;
>>>> +
>>>> +	return false;
>>>
>>> nit, simplified:
>>>
>>> return (PAGE_SHIFT + compound_order(compound_head(page) >= page_shift);
>>
>> This won't be "bool" though.
>
> Yes, it will.

Ah, misread as "... - page_shift". And you missed one bracket :)


>
>>   This will (I'll do this)
>>
>> shift = PAGE_SHIFT + compound_order(compound_head(page));
>> return (shift >= page_shift);
>>
>>
>>
>>
>>>
>>>> +}
>>>> +
>>>>    static int tce_iommu_enable(struct tce_container *container)
>>>>    {
>>>>    	int ret = 0;
>>>> @@ -197,6 +213,12 @@ static long tce_iommu_build(struct tce_container *container,
>>>>    			ret = -EFAULT;
>>>>    			break;
>>>>    		}
>>>> +
>>>> +		if (!tce_page_is_contained(page, tbl->it_page_shift)) {
>>>> +			ret = -EPERM;
>>>> +			break;
>>>> +		}
>>>> +
>>>>    		hva = (unsigned long) page_address(page) +
>>>>    			(tce & IOMMU_PAGE_MASK(tbl) & ~PAGE_MASK);
>>>>
>>>
>>>
>>>
>>
>>
>
>
>


-- 
Alexey
