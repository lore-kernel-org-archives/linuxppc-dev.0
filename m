Return-Path: <tglx@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a01:7a0:2:106d:700::1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y69Z76tGlzDqlM
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Oct 2017 07:27:27 +1100 (AEDT)
Date: Tue, 3 Oct 2017 22:27:08 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: David Laight <David.Laight@ACULAB.COM>
cc: 'Christoph Hellwig' <hch@lst.de>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Chris Zankel <chris@zankel.net>, Michal Simek <monstr@monstr.eu>,
 "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
 "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
 "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>,
 "x86@kernel.org" <x86@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 David Howells <dhowells@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Guan Xuetao <gxt@mprc.pku.edu.cn>, Robin Murphy <robin.murphy@arm.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>
Subject: RE: [PATCH 02/11] x86: make dma_cache_sync a no-op
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6DD0088B73@AcuExch.aculab.com>
Message-ID: <alpine.DEB.2.20.1710032214370.2278@nanos>
References: <20171003104311.10058-1-hch@lst.de>
 <20171003104311.10058-3-hch@lst.de>
 <063D6719AE5E284EB5DD2968C1650D6DD0088B73@AcuExch.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 3 Oct 2017, David Laight wrote:

> From: Christoph Hellwig
> > Sent: 03 October 2017 11:43
> > x86 does not implement DMA_ATTR_NON_CONSISTENT allocations, so it doesn't
> > make any sense to do any work in dma_cache_sync given that it must be a
> > no-op when dma_alloc_attrs returns coherent memory.
> 
> I believe it is just about possible to require an explicit
> write flush on x86.
> ISTR this can happen with something like write combining.

As the changelog says: x86 only implements dma_alloc_coherent() which as
the name says returns coherent memory, i.e. type WB (write back), which is
not subject to dma_cache_sync() operations.

If the driver converts that memory to WC (write combine) on its own via
PAT/MTRR, then it needs to take care of flushing the write buffer on its
own. It's not convered by this interface.

Thanks,

	tglx
