Return-Path: <becky.bruce@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7D148DDFC4
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Jun 2008 10:15:16 +1000 (EST)
In-Reply-To: <200805291153.31305.markn@au1.ibm.com>
References: <Pine.LNX.4.64.0804301815020.12768@monty.am.freescale.net>
	<200805231806.50551.markn@au1.ibm.com>
	<200805291153.31305.markn@au1.ibm.com>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <2C2AC58A-E906-4BEC-B9F9-713782DE03E3@freescale.com>
From: Becky Bruce <becky.bruce@freescale.com>
Subject: Re: [RFC] POWERPC: Merge 32 and 64-bit dma code
Date: Tue, 3 Jun 2008 19:18:24 -0500
To: Mark Nelson <markn@au1.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 28, 2008, at 8:53 PM, Mark Nelson wrote:

> On Fri, 23 May 2008 06:06:50 pm Mark Nelson wrote:
>> On Thu, 1 May 2008 09:36:43 am Becky Bruce wrote:
>>>
>>> I essentially adopt the 64-bit dma code, with some changes to  
>>> support
>>> 32-bit systems, including HIGHMEM.  dma functions on 32-bit are now
>>> invoked via accessor functions which call the correct op for a  
>>> device based
>>> on archdata dma_ops.  Currently, this defaults to dma_direct_ops,  
>>> but this
>>> structure will make it easier to do iommu/swiotlb on 32-bit going
>>> forward.
>>>
>>> In addition, the dma_map/unmap_page functions are added to  
>>> dma_ops on
>>> HIGHMEM-enabled configs because we can't just fall back on map/ 
>>> unmap_single
>>> when HIGHMEM is enabled.  Adding these to dma_ops makes it  
>>> cleaner to
>>> substitute different functionality once we have iommu/swiotlb  
>>> support.
>>>
>>> This code conflicts with the dma_attrs code that Mark Nelson just  
>>> pushed.
>>> At this point, I'm just looking for some review, and suggestions  
>>> on how
>>> this code might be improved.  I'll uprev it to work with Mark's  
>>> code once
>>> that goes in.
>>
>> The last patch of my series may be in question so it could end up  
>> that this
>> patch makes it in first. It shouldn't be too hard to respin my  
>> patches after
>> your merge so no worries there though.

Either way, we'll deal with it.  Thanks!

>>
>>>
>>> There will be other patches that precede this one - I plan to  
>>> duplicate
>>> dma_mapping.h into include/asm-ppc to avoid breakage there.   
>>> There will
>>> also be a patch to rename dma_64.c to dma.c, and a series of  
>>> patches to
>>> modify drivers that pass NULL dev pointers.
>>>
>>> Dma experts, please review this when you can - I was a dma newbie
>>> until very recently, and the odds that I'm missing some subtlety
>>> in this merge are fairly high.
>>>
>>
>> I'm far from a DMA expert but this all looks sane to me - I can't  
>> really
>> comment on the 32bit side of things but I don't think it's going  
>> to break
>> anything on 64bit (it compiles fine on cell and pseries).
>>
>> I'll try and test boot it on Monday.
>
> Not quite Monday, but it boots fine on the QS22 and QS21 Cell blades
> and on a Power6 box.


Thanks for the testing - that's great news.  Apologies for my slow  
response - I was blissfully on vacation for a couple of weeks.

>
> Mark.
>
>>
>> We should get BenH to look at it but he's travelling at the moment...

Yep, I'm going to have to start stalking him soon.  We've talked  
about a few issues, but he hasn't done a full review yet, as he is  
much in demand.

Thanks!
-Becky
