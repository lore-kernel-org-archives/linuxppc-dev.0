Date: Thu, 1 Apr 2004 10:40:04 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: John Whitney <jwhitney-linuxppc@sands-edge.com>
Cc: linuxppc-dev@lists.linuxppc.org,
	Matt Porter <mporter@kernel.crashing.org>
Subject: Re: Problems with dma_alloc_coherent()
Message-ID: <20040401184004.GA3786@gate.ebshome.net>
References: <9EB527A2-83F5-11D8-9FF0-000A95A07384@sands-edge.com> <20040401100546.A27472@home.com> <4317F0F4-8405-11D8-9FF0-000A95A07384@sands-edge.com> <20040401181926.GA3630@gate.ebshome.net> <1A3C4ACE-840B-11D8-9FF0-000A95A07384@sands-edge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1A3C4ACE-840B-11D8-9FF0-000A95A07384@sands-edge.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Apr 01, 2004 at 01:33:42PM -0500, John Whitney wrote:
> Yes, but both pci_alloc_consistent() and dma_alloc_coherent() return
> physical addresses made with virt_to_bus() (at least they do in the
> PowerPC tree).  This routine specifically adds the PCI-bus view of the
> address space to the physical address produced.  I don't understand why
> two different APIs are needed, if they both do the same thing.

They do the same thing _now_, because it's a _new_ API. This _may_ change in
future.

DMA API is needed, because generic code uses it, most archs have default generic
implementation which use PCI DMA API and I don't see _any_ problems with that.

Some archs may have _different_ implementations which DON'T use PCI DMA API.

>
> This means that the address produced by pci_alloc_... and dma_alloc_...
> are incorrect for a device like a direct memory-mapped encryption chip,
> or in my case a northbridge DMA controller.

It depends, on all systems I use PCI view == phys address, so it'll work.

Eugene


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
