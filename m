Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A9220DDE03
	for <linuxppc-dev@ozlabs.org>; Thu, 28 May 2009 14:43:07 +1000 (EST)
Message-Id: <2CCC4C06-15EC-438B-8BEA-A31690B4FB2C@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <13F18475-1D3E-4D9E-B10C-8BE48FBA9DF5@kernel.crashing.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH V2 2/3] powerpc: Add support for swiotlb on 32-bit
Date: Wed, 27 May 2009 23:42:32 -0500
References: <1242340949-16369-1-git-send-email-beckyb@kernel.crashing.org>
	<1242340949-16369-2-git-send-email-beckyb@kernel.crashing.org>
	<1242622141.18075.37.camel@pasglop>
	<DE108B1C-85A6-4D1F-8E4D-E1AB5495578A@kernel.crashing.org>
	<1242683395.16901.0.camel@pasglop>
	<13F18475-1D3E-4D9E-B10C-8BE48FBA9DF5@kernel.crashing.org>
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

Ben,

Any comments on this.. need a decision so we can have patches ready  
for .31.

- k

On May 19, 2009, at 8:04 AM, Kumar Gala wrote:

>
> On May 18, 2009, at 4:49 PM, Benjamin Herrenschmidt wrote:
>
>> On Mon, 2009-05-18 at 08:25 -0500, Kumar Gala wrote:
>>>
>>> Part of this is how the generic swiotlb code works and part of it
>>> was
>>> our desire not to bloat dev archdata by adding such info that as you
>>> say is either bus specific or conveyed in the dma addr mask.
>>
>> Right but perf sucks :-)
>>
>> Maybe an option is to clamp the DMA mask when it's set by the  
>> driver to
>> limit it to the available inbound window ?
>
> Clamping the DMA mask is even worse than the additional indirection  
> for us.  We have valid scenarios in which we'd have 512M of outbound  
> PCI address space and 4G of mem and thus 3.5G of inbound PCI address  
> space.  With the DMA mask we'd be limited to 2G and bouncing from  
> 2..3.5G when we don't need to.
>
> I think our options are to change archdata as follows:
>
> Option 1 - just add a new data member to dev_archdata
>
> struct dev_archdata {
>        /* Optional pointer to an OF device node */
>        struct device_node      *of_node;
>
>        /* DMA operations on that device */
>        struct dma_mapping_ops  *dma_ops;
>        void 		        *dma_data;
> 	dma_addr_t		direct_dma_addr;
> };
>
> Option 2 - introduce a proper container for how we use dma_data.   
> This may just be moving the indirection from an indirection function  
> call to an indirection data reference:
>
> struct dma_data {
>        dma_addr_t      offset;
>        dma_addr_t      direct_dma_addr;
>        struct          iommu_table *iommu_table;
> };
>
> struct dev_archdata {
>        /* Optional pointer to an OF device node */
>        struct device_node      *of_node;
>
>        /* DMA operations on that device */
>        struct dma_mapping_ops  *dma_ops;
>        struct dma_data         *dma_data;
> };
>
> Option 3 - use dma_data to keep the addr at which we need to bounce  
> vs not for SWIOTLB - this has potential issues w/conflicting with  
> dma_data being used as the dma_offset. (need to think on that a bit  
> more).  Additionally this has the benefit in that we need dma_data  
> to be a 64-bit quantity on ppc32 w/>32-bit phys addr.
>
> struct dev_archdata {
>        /* Optional pointer to an OF device node */
>        struct device_node      *of_node;
>
>        /* DMA operations on that device */
>        struct dma_mapping_ops  *dma_ops;
>        dma_addr_t 	        dma_data;
> };
>
> others??
>
> - k
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
