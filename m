Return-Path: <linas@austin.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1723167C44
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Dec 2006 04:08:04 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e3.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id kBEH7jc8017736
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Dec 2006 12:07:45 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kBEH7jnA234890
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Dec 2006 12:07:45 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kBEH7iYY025784
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Dec 2006 12:07:44 -0500
Date: Thu, 14 Dec 2006 11:07:37 -0600
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 1/14] Spidernet DMA coalescing
Message-ID: <20061214170737.GS4329@austin.ibm.com>
References: <20061213210010.GR4329@austin.ibm.com>
	<20061213210659.GA1915@austin.ibm.com>
	<20061214110517.GA13377@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20061214110517.GA13377@infradead.org>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: Andrew Morton <akpm@osdl.org>, Arnd Bergmann <arnd@arndb.de>,
	netdev@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Jens Osterkamp <Jens.Osterkamp@gmx.de>, jgarzik@pobox.com,
	James K Lewis <jim@jklewis.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Dec 14, 2006 at 11:05:17AM +0000, Christoph Hellwig wrote:
> On Wed, Dec 13, 2006 at 03:06:59PM -0600, Linas Vepstas wrote:
> > 
> > The current driver code performs 512 DMA mappings of a bunch of 
> > 32-byte ring descriptor structures. This is silly, as they are 
> > all in contiguous memory. This patch changes the code to 
> > dma_map_coherent() each rx/tx ring as a whole.
> 
> It's acutally dma_alloc_coherent now that you updated the patch :)
> 
> > +	chain->ring = dma_alloc_coherent(&card->pdev->dev, alloc_size,
> > +		&chain->dma_addr, GFP_KERNEL);
> >  
> > +	if (!chain->ring)
> > +		return -ENOMEM;
> >  
> > +	descr = chain->ring;
> > +	memset(descr, 0, alloc_size);
> 
> dma_alloc_coherent is defined to zero the allocated memory, so you
> won't need this memset.

Being unclear on the concept, should a send a new version of this patch,
or should I send a new patch that removes this?

--linas
