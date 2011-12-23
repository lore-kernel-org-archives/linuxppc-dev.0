Return-Path: <willy@parisc-linux.org>
Received: from mail.parisc-linux.org (palinux.external.hp.com [192.25.206.14])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.parisc-linux.org",
 Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 286BBB71C4
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Dec 2011 03:40:55 +1100 (EST)
Date: Fri, 23 Dec 2011 09:35:16 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH 00/14] DMA-mapping framework redesign preparation
Message-ID: <20111223163516.GO20129@parisc-linux.org>
References: <1324643253-3024-1-git-send-email-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1324643253-3024-1-git-send-email-m.szyprowski@samsung.com>
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-mm@kvack.org, sparclinux@vger.kernel.org,
 linux-arch@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>,
 Jonathan Corbet <corbet@lwn.net>, x86@kernel.org,
 Arnd Bergmann <arnd@arndb.de>, microblaze-uclinux@itee.uq.edu.au,
 linaro-mm-sig@lists.linaro.org, Andrzej Pietrasiewicz <andrzej.p@samsung.com>,
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

On Fri, Dec 23, 2011 at 01:27:19PM +0100, Marek Szyprowski wrote:
> The first issue we identified is the fact that on some platform (again,
> mainly ARM) there are several functions for allocating DMA buffers:
> dma_alloc_coherent, dma_alloc_writecombine and dma_alloc_noncoherent

Is this write-combining from the point of view of the device (ie iommu),
or from the point of view of the CPU, or both?

> The next step in dma mapping framework update is the introduction of
> dma_mmap/dma_mmap_attrs() function. There are a number of drivers
> (mainly V4L2 and ALSA) that only exports the DMA buffers to user space.
> Creating a userspace mapping with correct page attributes is not an easy
> task for the driver. Also the DMA-mapping framework is the only place
> where the complete information about the allocated pages is available,
> especially if the implementation uses IOMMU controller to provide a
> contiguous buffer in DMA address space which is scattered in physical
> memory space.

Surely we only need a helper which drivrs can call from their mmap routine to solve this?

> Usually these drivers don't touch the buffer data at all, so the mapping
> in kernel virtual address space is not needed. We can introduce
> DMA_ATTRIB_NO_KERNEL_MAPPING attribute which lets kernel to skip/ignore
> creation of kernel virtual mapping. This way we can save previous
> vmalloc area and simply some mapping operation on a few architectures.

I really think this wants to be a separate function.  dma_alloc_coherent
is for allocating memory to be shared between the kernel and a driver;
we already have dma_map_sg for mapping userspace I/O as an alternative
interface.  This feels like it's something different again rather than
an option to dma_alloc_coherent.

-- 
Matthew Wilcox				Intel Open Source Technology Centre
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
