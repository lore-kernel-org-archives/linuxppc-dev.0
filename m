Return-Path: <dan@embeddedalley.com>
Received: from smtp107.biz.mail.re2.yahoo.com (smtp107.biz.mail.re2.yahoo.com
	[206.190.52.176]) by ozlabs.org (Postfix) with SMTP id 9CA5D67BBD
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Nov 2006 12:31:04 +1100 (EST)
In-Reply-To: <20061117080052.GA16985@lst.de>
References: <20061114012504.17455.13833.stgit@localhost.localdomain>
	<20061114012816.17455.12059.stgit@localhost.localdomain>
	<20061117080052.GA16985@lst.de>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <DB42A6F7-2B5E-4A22-8AA8-0F2C3BDEFC99@embeddedalley.com>
From: Dan Malek <dan@embeddedalley.com>
Subject: Re: [PATCH 2/5] [POWERPC] 8xx: generic 8xx code arch/powerpc port
Date: Fri, 17 Nov 2006 20:24:16 -0500
To: Christoph Hellwig <hch@lst.de>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Nov 17, 2006, at 3:00 AM, Christoph Hellwig wrote:

> this is used by arch/ppc/fec.c to set mapping uncachable, which
> seems rather odd to me.

I thought arch/ppc/fec.c is dead in favor of the
"generic" version in the drivers/net directory?

We use the va_to_pte() functions to find
the mappings to create "coherent" cache areas
by changing the cache attributes of the vmalloc()
space.  We can't use virt_to_phys() or similar
associated functions because they simply do the
kernel virtual arithmetic and don't return the
proper PTEs for for changing these attributes.

I believe this is also used on the 4xx, but I
could be mistaken.

> .....  For now we'll have to keep it I think, but
> it might make sense to move the implementation to fec.c.

I don't know what version of fec.c you are looking
at, but it should use the dma_alloc_coherent() functions
and be stashing both the physical and virtual addresses.
I made this change long ago and I hope it hasn't
been lost.

The coherent dma functions will in turn use
the va_to_pte() (or associated functions) mentioned
above.

Thanks.


	-- Dan
