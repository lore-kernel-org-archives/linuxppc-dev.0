Date: Thu, 1 Apr 2004 10:01:47 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: John Whitney <jwhitney-linuxppc@sands-edge.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Problems with dma_alloc_coherent()
Message-ID: <20040401170147.GB26876@smtp.west.cox.net>
References: <9EB527A2-83F5-11D8-9FF0-000A95A07384@sands-edge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9EB527A2-83F5-11D8-9FF0-000A95A07384@sands-edge.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Apr 01, 2004 at 10:59:56AM -0500, John Whitney wrote:

> In the process of reworking my Generic DMA core for the 2.6 kernel, I
> noticed that dma_alloc_coherent() returns NULL in all cases on a
> cache-coherent platform.  Instead, I think it would be better if this
> routine returned a block of contiguous memory (not cache-inhibited), as
> pci_alloc_consistent() does.
>
> To that end, I am submitting the attached patch which modifies
> dma_alloc_coherent() and dma_free_coherent() to do just this for
> cache-coherent platforms.
> I was going to add a check for dev->dma_mask in dma_alloc_coherent()
> (to add GFP_DMA to the flags), but the dma_supported() macro always
> returns 1, which would indicate that this is superfluous.

I'd like to suggest that what we do is make dma_alloc_coherent and
dma_free_coherent steal the logic of pci_alloc/free_consistent outright,
moving us one step closer to using <asm-generic/pci-dma-compat.h> (PCI
DMA API implemented in terms of the generic DMA API).

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
