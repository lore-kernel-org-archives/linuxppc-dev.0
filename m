Return-Path: <beckyb@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 9AA29B7B60
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 27 Aug 2009 06:21:12 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 052B4DDD01
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Aug 2009 06:21:11 +1000 (EST)
Message-Id: <E3F20841-FB04-44EF-8DAA-91F51873C0A6@kernel.crashing.org>
From: Becky Bruce <beckyb@kernel.crashing.org>
To: michael@ellerman.id.au
In-Reply-To: <1251295725.7492.5.camel@concordia>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v936)
Subject: Re: [PATCH] powerpc: Change archdata dma_data type to dma_addr_t
Date: Wed, 26 Aug 2009 15:20:56 -0500
References: <1251130634-15093-1-git-send-email-beckyb@kernel.crashing.org>
	<20090824194800.GA13503@lst.de> <1251289790.1379.71.camel@pasglop>
	<1251295725.7492.5.camel@concordia>
Cc: Christoph Hellwig <hch@lst.de>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Aug 26, 2009, at 9:08 AM, Michael Ellerman wrote:

> On Wed, 2009-08-26 at 22:29 +1000, Benjamin Herrenschmidt wrote:
>> On Mon, 2009-08-24 at 21:48 +0200, Christoph Hellwig wrote:
>>> On Mon, Aug 24, 2009 at 11:17:14AM -0500, Becky Bruce wrote:
>>>> Previously, this was specified as a void *, but that's not
>>>> large enough on 32-bit systems with 36-bit physical
>>>> addressing support.  Change the type to dma_addr_t so it
>>>> will scale based on the size of a dma address.
>>>
>>> This looks extreml ugly to me.  It seems like the typical use is to
>>> store a pointer to a structure.  So what about making the direct
>>> dma case follow that general scheme instead?
>>>
>>> E.g. declare a
>>>
>>> struct direct_dma_data {
>>> 	dma_addr_t	direct_dma_offset;
>>> };
>>>
>>> and have one normal instace of it, and one per weird cell device.
>>
>> Right, but we want to avoid a structure for the classic case of 32- 
>> bit
>> systems with no iommu...
>>
>> I wouldn't mind doing a union here.
>
> That might be best, the patch as it stands is a horrible mess of  
> casts.

Let's be fair - the code before was a horrible mess of casts, I've  
just moved them :)

>
> Stashing a dma_addr_t into a void * is sort of gross, but storing a
> pointer to some struct (a void *) in a dma_addr_t is _really_ gross :)

Both are revolting (and storing a dma_addr_t into a void * is really  
gross when the void * is smaller than the dma_addr_t!!).  A union  
might not be a bad idea, though.  I'll look at doing that instead.

-Becky
