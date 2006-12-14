Return-Path: <SRS0+8dd218c1a5062aad74f4+1208+infradead.org+hch@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3BEEE67C27
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Dec 2006 22:05:39 +1100 (EST)
Date: Thu, 14 Dec 2006 11:05:17 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Linas Vepstas <linas@austin.ibm.com>
Subject: Re: [PATCH 1/14] Spidernet DMA coalescing
Message-ID: <20061214110517.GA13377@infradead.org>
References: <20061213210010.GR4329@austin.ibm.com>
	<20061213210659.GA1915@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20061213210659.GA1915@austin.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, Arnd Bergmann <arnd@arndb.de>,
	netdev@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
	linuxppc-dev@ozlabs.org, Jens Osterkamp <Jens.Osterkamp@gmx.de>,
	jgarzik@pobox.com, James K Lewis <jim@jklewis.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Dec 13, 2006 at 03:06:59PM -0600, Linas Vepstas wrote:
> 
> The current driver code performs 512 DMA mappings of a bunch of 
> 32-byte ring descriptor structures. This is silly, as they are 
> all in contiguous memory. This patch changes the code to 
> dma_map_coherent() each rx/tx ring as a whole.

It's acutally dma_alloc_coherent now that you updated the patch :)

> +	chain->ring = dma_alloc_coherent(&card->pdev->dev, alloc_size,
> +		&chain->dma_addr, GFP_KERNEL);
>  
> +	if (!chain->ring)
> +		return -ENOMEM;
>  
> +	descr = chain->ring;
> +	memset(descr, 0, alloc_size);

dma_alloc_coherent is defined to zero the allocated memory, so you
won't need this memset.
