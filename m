Return-Path: <beckyb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E1216DDE16
	for <linuxppc-dev@ozlabs.org>; Thu, 28 May 2009 05:11:17 +1000 (EST)
Message-Id: <2A2CCBB9-12B1-43CD-9183-B851FF321B30@kernel.crashing.org>
From: Becky Bruce <beckyb@kernel.crashing.org>
To: Ian Campbell <Ian.Campbell@eu.citrix.com>
In-Reply-To: <1243342307.9295.86.camel@zakaz.uk.xensource.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH V2 2/3] powerpc: Add support for swiotlb on 32-bit
Date: Wed, 27 May 2009 14:11:05 -0500
References: <1242340949-16369-1-git-send-email-beckyb@kernel.crashing.org>
	<1242340949-16369-2-git-send-email-beckyb@kernel.crashing.org>
	<20090519142656T.fujita.tomonori@lab.ntt.co.jp>
	<19E48A70-3332-423C-ACAD-390F940EE81C@kernel.crashing.org>
	<4A1592CF.8000208@goop.org>
	<E6DAA792-9923-4B76-9759-6955AABE3EAB@kernel.crashing.org>
	<1242990702.22654.253.camel@zakaz.uk.xensource.com>
	<4A173B72.5000201@goop.org>
	<1243342307.9295.86.camel@zakaz.uk.xensource.com>
Cc: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Jeremy Fitzhardinge <jeremy@goop.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 26, 2009, at 7:51 AM, Ian Campbell wrote:

> On Fri, 2009-05-22 at 19:55 -0400, Jeremy Fitzhardinge wrote:
>> Ian Campbell wrote:
>>> On Thu, 2009-05-21 at 14:27 -0400, Becky Bruce wrote:
>>>
>>>> I can work with that, but it's going to be a bit inefficient, as I
>>>> actually need the dma_addr_t, not the phys_addr_t, so I'll have to
>>>> convert.  In every case, this is a conversion I've already done and
>>>> that I need in the calling code as well.
>>>>
>>>
>>> Does
>>>
>>>    dma_addr_t dma_map_range(struct device *hwdev, phys_addr_t addr,
>>>    size_t size);
>>>
>>> work for you?
>>>
>>> If the range does not need mapping then it returns the dma  
>>> address, if
>>> you needed to calculate the dma address anyway to figure out if  
>>> mapping
>>> is required then this is fine. If the range does need mapping then  
>>> it
>>> returns NULL.
>>>
>>
>> My only concern is whether dma_addr_t == 0 is actually equivalent to
>> NULL.  That is, can we be sure that address 0 will never be used?
>
> It seems not, ~0UL might have been an option, but...
>
>> Taking dma_alloc_coherent as a model, we could have something like:
>>
>>    int dma_map_range(struct device *hwdev, phys_addr_t addr, size_t  
>> size, dma_addr_t *dma_addrp);
>>
>>
>> where *dma_addrp is set if the function returns success (bool return
>> type might be clearer).
>
> ... this sounds like a good idea to me.

I agree.  This will work for me as well.

-becky
