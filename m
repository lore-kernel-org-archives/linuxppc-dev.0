In-Reply-To: <20040401184004.GA3786@gate.ebshome.net>
References: <9EB527A2-83F5-11D8-9FF0-000A95A07384@sands-edge.com> <20040401100546.A27472@home.com> <4317F0F4-8405-11D8-9FF0-000A95A07384@sands-edge.com> <20040401181926.GA3630@gate.ebshome.net> <1A3C4ACE-840B-11D8-9FF0-000A95A07384@sands-edge.com> <20040401184004.GA3786@gate.ebshome.net>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <3AEE9BD0-840D-11D8-9FF0-000A95A07384@sands-edge.com>
Cc: linuxppc-dev@lists.linuxppc.org,
	Matt Porter <mporter@kernel.crashing.org>
From: John Whitney <jwhitney-linuxppc@sands-edge.com>
Subject: Re: Problems with dma_alloc_coherent()
Date: Thu, 1 Apr 2004 13:48:56 -0500
To: Eugene Surovegin <ebs@ebshome.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> They do the same thing _now_, because it's a _new_ API. This _may_
> change in
> future.
>
> DMA API is needed, because generic code uses it, most archs have
> default generic
> implementation which use PCI DMA API and I don't see _any_ problems
> with that.
>
> Some archs may have _different_ implementations which DON'T use PCI
> DMA API.
>
>>
>> This means that the address produced by pci_alloc_... and
>> dma_alloc_...
>> are incorrect for a device like a direct memory-mapped encryption
>> chip,
>> or in my case a northbridge DMA controller.
>
> It depends, on all systems I use PCI view == phys address, so it'll
> work.
>

And in actuality, it will work in my case as well.  However, it won't
work for some single-board computers I've worked on, so I'd like to
have an API that works for everything.

It would be nice if there was a dma_bus_offset field in the device
structure that got set by the device creator.  PCI devices would get
PCI_DRAM_OFFSET, PLB devices would get 0, OCP devices would get
whatever they need.

Then the API could add the appropriate offset for the device passed in,
rather than relying on the static virt_to_bus() mapping, which is PCI
specific.  As a default, with a NULL device given, I think it should
return a PLB physical address.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
