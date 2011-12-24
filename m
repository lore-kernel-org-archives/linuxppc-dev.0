Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id D2B71B6FBA
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Dec 2011 18:01:10 +1100 (EST)
Message-ID: <1324710014.6632.23.camel@pasglop>
Subject: Re: [PATCH 00/14] DMA-mapping framework redesign preparation
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Matthew Wilcox <matthew@wil.cx>
Date: Sat, 24 Dec 2011 18:00:14 +1100
In-Reply-To: <20111223163516.GO20129@parisc-linux.org>
References: <1324643253-3024-1-git-send-email-m.szyprowski@samsung.com>
 <20111223163516.GO20129@parisc-linux.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-mm@kvack.org, sparclinux@vger.kernel.org,
 Marek Szyprowski <m.szyprowski@samsung.com>, linux-arch@vger.kernel.org,
 Stephen Rothwell <sfr@canb.auug.org.au>, Jonathan Corbet <corbet@lwn.net>,
 x86@kernel.org, Arnd Bergmann <arnd@arndb.de>,
 microblaze-uclinux@itee.uq.edu.au, linaro-mm-sig@lists.linaro.org,
 Andrzej Pietrasiewicz <andrzej.p@samsung.com>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 discuss@x86-64.org, linux-kernel@vger.kernel.org,
 Kyungmin Park <kyungmin.park@samsung.com>, linux-alpha@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2011-12-23 at 09:35 -0700, Matthew Wilcox wrote:
> I really think this wants to be a separate function.
> dma_alloc_coherent
> is for allocating memory to be shared between the kernel and a driver;
> we already have dma_map_sg for mapping userspace I/O as an alternative
> interface.  This feels like it's something different again rather than
> an option to dma_alloc_coherent. 

Depends. There can be some interesting issues with some of the ARM stuff
out there (and to a lesser extent older ppc embedded stuff).

For example, some devices really want a physically contiguous chunk, and
are not cache coherent. In that case, you can't keep the linear mapping
around. But you also don't waste your precious kernel virtual space
creating a separate non-cachable mapping for those.

In general, dma mapping attributes as a generic feature make sense,
whether this specific attribute does or not though. And we probably want
space for platform specific attributes, for example, FSL embedded
iommu's have "interesting" features for directing data toward a specific
core cache etc... that we might want to expose using such attributes.

Cheers,
Ben.
