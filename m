In-Reply-To: <20040401100546.A27472@home.com>
References: <9EB527A2-83F5-11D8-9FF0-000A95A07384@sands-edge.com> <20040401100546.A27472@home.com>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <4317F0F4-8405-11D8-9FF0-000A95A07384@sands-edge.com>
Cc: linuxppc-dev@lists.linuxppc.org
From: John Whitney <jwhitney-linuxppc@sands-edge.com>
Subject: Re: Problems with dma_alloc_coherent()
Date: Thu, 1 Apr 2004 12:51:54 -0500
To: Matt Porter <mporter@kernel.crashing.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
> Yeah, that's really broken.  The changeover to dma-mapping.h is
> incomplete.  Tom and I were just talking about this because I
> think it exposes a bigger problem.  What I originally wanted
> was the PCI DMA API defined in terms of the generic DMA API
> on ppc32.  He just pointed out asm-generic/pci-dma-compat.h that
> we can leverage to do that.
>

I noticed that all the PCI and DMA coherency routines seem to assume
that DMA will occur between memory and a bus device (all physical
addresses returned are converted to a bus address).  Is this really the
desired action?  I would have prefered to have the PCI routines return
bus-correct physical addresses, and the DMA routines return processor
physical addresses (so they can be used for non-bus-related DMA, to a
direct memory-mapped encryption chip, for example).  Is this the
eventual implementation of those functions, or are all DMA transactions
expected to be to or from a PCI-based device?

John


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
