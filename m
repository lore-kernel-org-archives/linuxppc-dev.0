Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 38B5DDDEF3
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jan 2008 08:48:46 +1100 (EST)
Date: Mon, 7 Jan 2008 15:57:56 -0600
From: Olof Johansson <olof@lixom.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH][POWERPC] Workaround for iommu page alignment
Message-ID: <20080107215755.GA31230@lixom.net>
References: <1199742359.6734.14.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1199742359.6734.14.camel@pasglop>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jan 08, 2008 at 08:45:59AM +1100, Benjamin Herrenschmidt wrote:
> Our iommu page size is currently always 4K. That means with our current
> code, drivers may do a dma_map_sg() of a 64K page and obtain a dma_addr_t
> that is only 4K aligned.
> 
> This works fine in most cases except some infiniband HW it seems, where
> they tell the HW about the page size and it ignores the low bits of the
> DMA address.
> 
> This works around it by making our IOMMU code enforce a PAGE_SIZE alignment
> for mappings of objects that are page aligned in the first place and whose
> size is larger or equal to a page.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Acked-by: Olof Johansson <olof@lixom.net>


-Olof
