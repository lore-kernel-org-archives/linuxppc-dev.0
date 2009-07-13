Return-Path: <beckyb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by bilbo.ozlabs.org (Postfix) with ESMTPS id A19DCB7080
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 14 Jul 2009 07:51:02 +1000 (EST)
Message-Id: <B6C36B32-6861-4FD9-B8A3-E8C328687E0F@kernel.crashing.org>
From: Becky Bruce <beckyb@kernel.crashing.org>
To: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
In-Reply-To: <20090710104706I.fujita.tomonori@lab.ntt.co.jp>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v935.3)
Subject: Re: removing addr_needs_map in struct dma_mapping_ops
Date: Mon, 13 Jul 2009 16:50:43 -0500
References: <20090710104706I.fujita.tomonori@lab.ntt.co.jp>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 9, 2009, at 8:47 PM, FUJITA Tomonori wrote:

> I'm trying to convert POWERPC to use asm-generic/dma-mapping-common.h.
>
> POWERPC needs addr_needs_map() in struct dma_mapping_ops for SWIOTLB
> support but I want to avoid add addr_needs_map() in struct
> dma_map_ops. IIRC, you guys think it as a temporary solution and

That is correct - I was planning to update when the iotlb folks had  
decided on a final scheme for this.  We don't like the additional  
indirection we're getting with the current implementation.

>
> talked about defining something like struct dma_data. Then we could
>
> struct dev_archdata {
>      ...
>
>      struct dma_data *ddata;
> };
>
> or
>
> struct dev_archdata {
>      ...
>
>      struct dma_data ddata;
> };
>
>
> struct dma_data needs dma_direct_offset, iommu_table, dma_base, and
> dma_window_size, anything else?

IIRC, what we had talked about was simpler - we talked about changing  
the current dev_archdata from this:

struct dev_archdata {
        struct device_node      *of_node;
        struct dma_mapping_ops  *dma_ops;
        void                    *dma_data;
};

to this:

struct dev_archdata {
	struct device_node *of_node;
	struct dma_mapping_ops *dma_ops;
	unsigned long long dma_data;
#ifdef CONFIG_SWIOTLB
	dma_addr_t max_direct_dma_addr;
#endif
};

Where max_direct_dma_addr is the address beyond which a specific  
device must use swiotlb, and dma_data is the offset like it is now  
(but wider on 32-bit systems than void *). I believe Ben had mentioned  
wanting to make the max_direct_dma_addr part conditional so we don't  
bloat archdata on platforms that don't ever bounce.

The change to the type of dma_data is actually in preparation for an  
optimization I have planned for 64-bit PCI devices (and which probably  
requires more discussion), so that doesn't need to happen now -  just  
leave it as a void *, and I can post a followup patch.

Let me know if I can help or do any testing - I've been meaning to  
look into switching to dma_map_ops for a while now but it hasn't  
managed to pop off my todo stack.

Cheers,
Becky
