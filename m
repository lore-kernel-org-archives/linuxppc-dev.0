Date: Thu, 1 Apr 2004 10:05:46 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: John Whitney <jwhitney-linuxppc@sands-edge.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Problems with dma_alloc_coherent()
Message-ID: <20040401100546.A27472@home.com>
References: <9EB527A2-83F5-11D8-9FF0-000A95A07384@sands-edge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9EB527A2-83F5-11D8-9FF0-000A95A07384@sands-edge.com>; from jwhitney-linuxppc@sands-edge.com on Thu, Apr 01, 2004 at 10:59:56AM -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Apr 01, 2004 at 10:59:56AM -0500, John Whitney wrote:
> In the process of reworking my Generic DMA core for the 2.6 kernel, I
> noticed that dma_alloc_coherent() returns NULL in all cases on a
> cache-coherent platform.  Instead, I think it would be better if this
> routine returned a block of contiguous memory (not cache-inhibited), as
> pci_alloc_consistent() does.

Yeah, that's really broken.  The changeover to dma-mapping.h is
incomplete.  Tom and I were just talking about this because I
think it exposes a bigger problem.  What I originally wanted
was the PCI DMA API defined in terms of the generic DMA API
on ppc32.  He just pointed out asm-generic/pci-dma-compat.h that
we can leverage to do that.

> To that end, I am submitting the attached patch which modifies
> dma_alloc_coherent() and dma_free_coherent() to do just this for
> cache-coherent platforms.

Your patch fixes the problem but exposes the bigger issue that we
are starting to duplicate code since on ppc32 PCI DMA API and DMA
API are handled the same on the backend.

In the meantime (I think Tom volunteered to clean this up!), I think
this needs to go in so we are at least functional.

-Matt

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
