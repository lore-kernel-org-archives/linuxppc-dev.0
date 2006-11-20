Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2D95D67BAB
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Nov 2006 21:24:40 +1100 (EST)
Date: Mon, 20 Nov 2006 11:24:24 +0100
From: Christoph Hellwig <hch@lst.de>
To: Dan Malek <dan@embeddedalley.com>
Subject: Re: [PATCH 2/5] [POWERPC] 8xx: generic 8xx code arch/powerpc port
Message-ID: <20061120102424.GB12002@lst.de>
References: <20061114012504.17455.13833.stgit@localhost.localdomain>
	<20061114012816.17455.12059.stgit@localhost.localdomain>
	<20061117080052.GA16985@lst.de>
	<DB42A6F7-2B5E-4A22-8AA8-0F2C3BDEFC99@embeddedalley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <DB42A6F7-2B5E-4A22-8AA8-0F2C3BDEFC99@embeddedalley.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Nov 17, 2006 at 08:24:16PM -0500, Dan Malek wrote:
> On Nov 17, 2006, at 3:00 AM, Christoph Hellwig wrote:
> 
> >this is used by arch/ppc/fec.c to set mapping uncachable, which
> >seems rather odd to me.
> 
> I thought arch/ppc/fec.c is dead in favor of the
> "generic" version in the drivers/net directory?

Sorry, I actually meant drivers/net/fec.c.

> We use the va_to_pte() functions to find
> the mappings to create "coherent" cache areas
> by changing the cache attributes of the vmalloc()
> space.  We can't use virt_to_phys() or similar
> associated functions because they simply do the
> kernel virtual arithmetic and don't return the
> proper PTEs for for changing these attributes.

Yes, I noticed that in the second round of actually
looking at all the users.

> >it might make sense to move the implementation to fec.c.
> 
> I don't know what version of fec.c you are looking
> at, but it should use the dma_alloc_coherent() functions
> and be stashing both the physical and virtual addresses.
> I made this change long ago and I hope it hasn't
> been lost.
> 
> The coherent dma functions will in turn use
> the va_to_pte() (or associated functions) mentioned
> above.

drivers/net/fec.c in current linus tree doesn't use the dma
api at all, and there is no dma api implementation that
uses va_to_pte().  The only users of va_to_pte() in current
Linus tree are drivers/net/fec.c:fec_uncachable() in the #else
block of a large #ifdef / #ifelse spagethhi sections and va_to_phys in
arch/ppc/mm/fault.c under CONFIG_8xx, which is unused.
