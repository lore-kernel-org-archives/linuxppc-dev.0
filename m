Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DD81CDDFCE
	for <linuxppc-dev@ozlabs.org>; Thu, 28 May 2009 23:06:23 +1000 (EST)
Message-Id: <F82DCD3F-A23D-40F1-89E5-A4D050463E76@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1243491063.3171.117.camel@pasglop>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH V2 2/3] powerpc: Add support for swiotlb on 32-bit
Date: Thu, 28 May 2009 08:06:07 -0500
References: <1242340949-16369-1-git-send-email-beckyb@kernel.crashing.org>
	<1242340949-16369-2-git-send-email-beckyb@kernel.crashing.org>
	<1242622141.18075.37.camel@pasglop>
	<DE108B1C-85A6-4D1F-8E4D-E1AB5495578A@kernel.crashing.org>
	<1242683395.16901.0.camel@pasglop>
	<13F18475-1D3E-4D9E-B10C-8BE48FBA9DF5@kernel.crashing.org>
	<2CCC4C06-15EC-438B-8BEA-A31690B4FB2C@kernel.crashing.org>
	<1243491063.3171.117.camel@pasglop>
Cc: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 28, 2009, at 1:11 AM, Benjamin Herrenschmidt wrote:

> On Wed, 2009-05-27 at 23:42 -0500, Kumar Gala wrote:
>> Ben,
>>
>> Any comments on this.. need a decision so we can have patches ready
>> for .31.
>
>>> Clamping the DMA mask is even worse than the additional indirection
>>> for us.  We have valid scenarios in which we'd have 512M of outbound
>>> PCI address space and 4G of mem and thus 3.5G of inbound PCI address
>>> space.  With the DMA mask we'd be limited to 2G and bouncing from
>>> 2..3.5G when we don't need to.
>
> Ok and agreed.
>
>>> I think our options are to change archdata as follows:
>>>
>>> Option 1 - just add a new data member to dev_archdata
>>>
>>> struct dev_archdata {
>>>       /* Optional pointer to an OF device node */
>>>       struct device_node      *of_node;
>>>
>>>       /* DMA operations on that device */
>>>       struct dma_mapping_ops  *dma_ops;
>>>       void 		        *dma_data;
>>> 	dma_addr_t		direct_dma_addr;
>>> };
>
> That sounds like the "simple" option, might want for now to make
> it conditional on SWIOTLB but the bloat is reasonably small I would
> expect.
>
>>> Option 2 - introduce a proper container for how we use dma_data.
>>> This may just be moving the indirection from an indirection function
>>> call to an indirection data reference:
>
> Right, it somewhat defeats the purpose though an indirect data  
> reference
> tends to hit the pipeline less hard than an indirect function call...
>
>>> Option 3 - use dma_data to keep the addr at which we need to bounce
>>> vs not for SWIOTLB - this has potential issues w/conflicting with
>>> dma_data being used as the dma_offset. (need to think on that a bit
>>> more).  Additionally this has the benefit in that we need dma_data
>>> to be a 64-bit quantity on ppc32 w/>32-bit phys addr.
>
> Well, that means that swiotlb can not be used with a !0 offset. That
> -might- be an issue if the PCI is setup "backward", ie with 0..N being
> the outbound MMIO and N..4G the DMA region, remapped to 0. There are
> reasons to do it this way, it's not invalid, for example it allow easy
> access to ISA/VGA holes.

Yeah, realized that after thinking about it a bit more.

> At this stage I have no firm opinion. I'm thinking that either we try
> to limit the overhead and option 1 is probably the simplest, at the
> expense of a little bit of memory, or we think the overhead is going
> to be minimum and we may as well stick to 2 functions since that's
> going to be more flexible.

If you don't have a firm opinion I would ask you pull in this patch as  
it is in your next tree.  If we decide to move away from the 2  
function method and use a little bit more memory per dev_archdata we  
at least have the history in the tree of the 2 function method.

- k
