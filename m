Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id F140EDDECC
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jan 2008 14:39:13 +1100 (EST)
Date: Mon, 7 Jan 2008 21:48:24 -0600
From: Olof Johansson <olof@lixom.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH][POWERPC] Workaround for iommu page alignment (#2)
Message-ID: <20080108034824.GA7983@lixom.net>
References: <1199742359.6734.14.camel@pasglop>
	<1199748862.6734.20.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1199748862.6734.20.camel@pasglop>
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

On Tue, Jan 08, 2008 at 10:34:22AM +1100, Benjamin Herrenschmidt wrote:
> powerpc: Workaround for iommu page alignment
> 
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
> ---
> 
> And this version actually does what the comment says (I had forgotten
> to quilt ref... a common mistake).

And sloppy of me to not catch it. Anyway:

Acked-by: Olof Johansson <olof@lixom.net>

I wonder how long until there's a device that has some other < PAGE_SIZE
alignment bug^Wrequirement that we'll need to meet too. :(


-Olof
