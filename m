In-Reply-To: <20040401181926.GA3630@gate.ebshome.net>
References: <9EB527A2-83F5-11D8-9FF0-000A95A07384@sands-edge.com> <20040401100546.A27472@home.com> <4317F0F4-8405-11D8-9FF0-000A95A07384@sands-edge.com> <20040401181926.GA3630@gate.ebshome.net>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <1A3C4ACE-840B-11D8-9FF0-000A95A07384@sands-edge.com>
Cc: linuxppc-dev@lists.linuxppc.org,
	Matt Porter <mporter@kernel.crashing.org>
From: John Whitney <jwhitney-linuxppc@sands-edge.com>
Subject: Re: Problems with dma_alloc_coherent()
Date: Thu, 1 Apr 2004 13:33:42 -0500
To: Eugene Surovegin <ebs@ebshome.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Hmm, I don't understand this, bus != PCI bus. All devices sit on some
> kind of
> bus, even your encryption chip.
>

Yes, but both pci_alloc_consistent() and dma_alloc_coherent() return
physical addresses made with virt_to_bus() (at least they do in the
PowerPC tree).  This routine specifically adds the PCI-bus view of the
address space to the physical address produced.  I don't understand why
two different APIs are needed, if they both do the same thing.

This means that the address produced by pci_alloc_... and dma_alloc_...
are incorrect for a device like a direct memory-mapped encryption chip,
or in my case a northbridge DMA controller.

John


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
