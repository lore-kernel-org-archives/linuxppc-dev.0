Date: Thu, 1 Apr 2004 11:16:59 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: John Whitney <jwhitney-linuxppc@sands-edge.com>
Cc: Matt Porter <mporter@kernel.crashing.org>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: Problems with dma_alloc_coherent()
Message-ID: <20040401111659.B27472@home.com>
References: <9EB527A2-83F5-11D8-9FF0-000A95A07384@sands-edge.com> <20040401100546.A27472@home.com> <4317F0F4-8405-11D8-9FF0-000A95A07384@sands-edge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4317F0F4-8405-11D8-9FF0-000A95A07384@sands-edge.com>; from jwhitney-linuxppc@sands-edge.com on Thu, Apr 01, 2004 at 12:51:54PM -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Apr 01, 2004 at 12:51:54PM -0500, John Whitney wrote:
> >
> > Yeah, that's really broken.  The changeover to dma-mapping.h is
> > incomplete.  Tom and I were just talking about this because I
> > think it exposes a bigger problem.  What I originally wanted
> > was the PCI DMA API defined in terms of the generic DMA API
> > on ppc32.  He just pointed out asm-generic/pci-dma-compat.h that
> > we can leverage to do that.
> >
>
> I noticed that all the PCI and DMA coherency routines seem to assume
> that DMA will occur between memory and a bus device (all physical
> addresses returned are converted to a bus address).  Is this really the
> desired action?  I would have prefered to have the PCI routines return
> bus-correct physical addresses, and the DMA routines return processor
> physical addresses (so they can be used for non-bus-related DMA, to a
> direct memory-mapped encryption chip, for example).  Is this the
> eventual implementation of those functions, or are all DMA transactions
> expected to be to or from a PCI-based device?

Yes, the DMA API and PCI DMA API have been stated (repeatedly) to
be _only_ for [system memory]<->[device].  Trying to use them
otherwise is incorrect.  I believe DaveM's suggestion was, "If you
want a device-to-device DMA API then create a separate one".

It's another thing that embedded people will have to take the
time to introduce...but most embedded Linux people are too busy
with their apps on 2.4, maintaining boards, etc. to fix kernel
APIs. Don't expect the desktop/server folks to care. :)

-Matt

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
