Return-Path: <iws@ovro.caltech.edu>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 64595B6F44
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 10 Jul 2009 07:38:37 +1000 (EST)
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id B4C63DDDA1
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Jul 2009 07:38:36 +1000 (EST)
Date: Thu, 9 Jul 2009 14:38:33 -0700
From: "Ira W. Snyder" <iws@ovro.caltech.edu>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] edac: mpc85xx: add support for mpc83xx memory controller
Message-ID: <20090709213833.GA21892@ovro.caltech.edu>
References: <20090708161954.GC14979@ovro.caltech.edu>
	<3887C2A7-3566-43A9-A863-4670B039E5DA@kernel.crashing.org>
	<20090708193355.GE2827@ovro.caltech.edu>
	<6CF38C94-45EB-4FD7-B8E0-B9899F4EEF90@kernel.crashing.org>
	<20090709165844.GB29383@ovro.caltech.edu>
	<FC7C9C56-A1E7-4A02-BDEA-F55E10567313@kernel.crashing.org>
	<20090709181705.GD29383@ovro.caltech.edu>
	<A9AC0F1D-255E-4445-BC56-FF4024B91BF0@kernel.crashing.org>
	<20090709193519.GE29383@ovro.caltech.edu>
	<C720C7F4-B3FE-4C98-B04A-EE4F0BD40D5E@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <C720C7F4-B3FE-4C98-B04A-EE4F0BD40D5E@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, bluesmoke-devel@lists.sourceforge.net,
	Dave Jiang <djiang@mvista.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 09, 2009 at 03:15:29PM -0500, Kumar Gala wrote:
>
> On Jul 9, 2009, at 2:35 PM, Ira W. Snyder wrote:
>
>> On Thu, Jul 09, 2009 at 01:25:43PM -0500, Kumar Gala wrote:
>>>
>>> On Jul 9, 2009, at 1:17 PM, Ira W. Snyder wrote:
>>>
>>>> On Thu, Jul 09, 2009 at 12:58:53PM -0500, Kumar Gala wrote:
>>>>>> Hello Kumar,
>>>>>>
>>>>>> I must not understand something going on here. Your proposed code
>>>>>> doesn't work at all on my board. The
>>>>>> /sys/devices/system/edac/mc/mc0/size_mb doesn't come out  
>>>>>> correctly.
>>>>>
>>>>> What does it come out as?  How much memory do you have in the  
>>>>> system?
>>>>>
>>>>
>>>> The size_mb shows as 0 with your code. See the explanation below.  
>>>> With
>>>> my code it shows as 256MB, as expected.
>>>>
>>>> I have 256MB memory in the system.
>>>>
>>>>>> The attached patch DOES work on my board, but I'm confident 
>>>>>> that it
>>>>>> does
>>>>>> NOT work on a system with PAGE_SIZE != 4096. Any idea what I did
>>>>>> wrong?
>>>>>>
>>>>>> If I'm reading things correctly:
>>>>>> csrow->first_page	full address of the first page (NOT pfn)
>>>>>> csrow->last_page	full address of the last  page (NOT pfn)
>>>>>> csrow->nr_pages		number of pages
>>>>>>
>>>>>> The EDAC subsystem does csrow->nr_pages * PAGE_SIZE to get the
>>>>>> size_mb
>>>>>> sysfs value.
>>>>>>
>>>>>> If csrow->first_page and csrow->last_page ARE supposed to be the
>>>>>> pfn,
>>>>>> then I think the original code got it wrong, and the 
>>>>>> calculation for
>>>>>> csrow->nr_pages needs to be changed.
>>>>>>
>>>>>> Thanks,
>>>>>> Ira
>>>>>
>>>>> [snip]
>>>>>
>>>>>> /************************ MC SYSFS parts
>>>>>> ***********************************/
>>>>>>
>>>>>> @@ -790,18 +792,19 @@ static void __devinit
>>>>>> mpc85xx_init_csrows(struct
>>>>>> mem_ctl_info *mci)
>>>>>> 		csrow = &mci->csrows[index];
>>>>>> 		cs_bnds = in_be32(pdata->mc_vbase + MPC85XX_MC_CS_BNDS_0 +
>>>>>> 				  (index * MPC85XX_MC_CS_BNDS_OFS));
>>>>>> -		start = (cs_bnds & 0xfff0000) << 4;
>>>>>> -		end = ((cs_bnds & 0xfff) << 20);
>>>>>> -		if (start)
>>>>>> -			start |= 0xfffff;
>>>>>> -		if (end)
>>>>>> -			end |= 0xfffff;
>>>>>
>>>>> can you printk what cs_bnds values are in your setup.
>>>>>
>>>>
>>>> I am only using a single chip select. CS0_BNDS (register 0xe0002000)
>>>> is
>>>> 0x0000000F.
>>>>
>>>>>> +
>>>>>> +		start = (cs_bnds & 0xffff0000) >> 16;
>>>>>> +		end   = (cs_bnds & 0x0000ffff);
>>>>>>
>>>>
>>>> This is the same in both our versions.
>>>>
>>>> start == 0x0
>>>> end   == 0xF
>>>>
>>>>>> 		if (start == end)
>>>>>> 			continue;	/* not populated */
>>>>>>
>>>>>> -		csrow->first_page = start >> PAGE_SHIFT;
>>>>>> -		csrow->last_page = end >> PAGE_SHIFT;
>>>>>> +		start <<= PAGE_SHIFT;
>>>>>> +		end   <<= PAGE_SHIFT;
>>>>>> +		end    |= (1 << PAGE_SHIFT) - 1;
>>>>>> +
>>>>
>>>> MY VERSION
>>>>
>>>> start == 0x0
>>>> end   == 0xffff
>>>>
>>>> first_page == 0x0
>>>> last_page  == 0xffff
>>>>
>>>> YOUR VERSION (<<= (20 - PAGE_SHIFT), etc.)
>>>
>>> My math was wrong it should be ( <<= (24 - PAGE_SHIFT) )
>>>
>>> With that I think things work out.
>>>
>>
>> Yep, that works out great. This solution is much better than my  
>> original
>> code. The 83xx doesn't need to be special-cased anymore.
>>
>> I checked the math for a 85xx with 64GB of memory. Assuming it uses  
>> 64K
>> pages (PAGE_SHIFT == 16), then everything works out.
>
> Does the math work for a 64GB system w/4K pages?
>

Yes, the math works there too. I just double-checked by hand. The v2
patch should work fine on both the 83xx and 85xx (both 4K and 64K
pages).

Thanks again for the help on this one.
Ira
