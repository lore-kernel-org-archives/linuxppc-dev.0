Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A116D1A0034
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Oct 2015 14:43:37 +1100 (AEDT)
Message-ID: <1444103016.16909.6.camel@ellerman.id.au>
Subject: Re: [PATCH 1/5 v2] dma-mapping: add generic dma_get_page_shift API
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
Cc: Matthew Wilcox <willy@linux.intel.com>, Keith Busch
 <keith.busch@intel.com>,  Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Alexey
 Kardashevskiy <aik@ozlabs.ru>,  David Gibson <david@gibson.dropbear.id.au>,
 Christoph Hellwig <hch@infradead.org>,  linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org,  linuxppc-dev@lists.ozlabs.org, Arnd Bergmann
 <arnd@arndb.de>
Date: Tue, 06 Oct 2015 14:43:36 +1100
In-Reply-To: <20151002201142.GC40695@linux.vnet.ibm.com>
References: <20151002171606.GA41011@linux.vnet.ibm.com>
 <20151002200953.GB40695@linux.vnet.ibm.com>
 <20151002201142.GC40695@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-10-02 at 13:11 -0700, Nishanth Aravamudan wrote:
> Drivers like NVMe need to be able to determine the page size used for
> DMA transfers. Add a new API that defaults to return PAGE_SHIFT on all
> architectures.
> 
> Signed-off-by: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
> 
> diff --git a/include/asm-generic/dma-mapping-common.h b/include/asm-generic/dma-mapping-common.h
> index b1bc954..86e4e97 100644
> --- a/include/asm-generic/dma-mapping-common.h
> +++ b/include/asm-generic/dma-mapping-common.h
> @@ -355,4 +355,11 @@ static inline int dma_set_mask(struct device *dev, u64 mask)
>  }
>  #endif
>  
> +#ifndef HAVE_ARCH_DMA_GET_PAGE_SHIFT
> +static inline unsigned long dma_get_page_shift(struct device *dev)
> +{
> +	return PAGE_SHIFT;
> +}
> +#endif
> +
>  #endif
> 

Adding Arnd who is asm-generic maintainer.

Arnd/Christoph can one of you give us an ack for this patch?

cheers
