Date: Thu, 1 Apr 2004 10:19:26 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: John Whitney <jwhitney-linuxppc@sands-edge.com>
Cc: Matt Porter <mporter@kernel.crashing.org>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: Problems with dma_alloc_coherent()
Message-ID: <20040401181926.GA3630@gate.ebshome.net>
References: <9EB527A2-83F5-11D8-9FF0-000A95A07384@sands-edge.com> <20040401100546.A27472@home.com> <4317F0F4-8405-11D8-9FF0-000A95A07384@sands-edge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4317F0F4-8405-11D8-9FF0-000A95A07384@sands-edge.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Apr 01, 2004 at 12:51:54PM -0500, John Whitney wrote:
> I noticed that all the PCI and DMA coherency routines seem to assume
> that DMA will occur between memory and a bus device (all physical
> addresses returned are converted to a bus address).  Is this really the
> desired action?  I would have prefered to have the PCI routines return
> bus-correct physical addresses, and the DMA routines return processor
> physical addresses (so they can be used for non-bus-related DMA, to a
> direct memory-mapped encryption chip, for example).  Is this the
> eventual implementation of those functions, or are all DMA transactions
> expected to be to or from a PCI-based device?

Hmm, I don't understand this, bus != PCI bus. All devices sit on some kind of
bus, even your encryption chip.

As far as I understand, DMA API was added exactly because we may have different
(from PCI) buses.

Current implementation just relies on the fact that PCI devices view system
memory the same way as other-bus devices (e.g. OCP devices which sit on OPB).

In more general case, yes, "views" can be different for each bus type or even
for each bus...

Eugene.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
