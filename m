Subject: Re: Problems with dma_alloc_coherent()
From: Adrian Cox <adrian@humboldt.co.uk>
To: John Whitney <jwhitney-linuxppc@sands-edge.com>
Cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <811D8989-856C-11D8-9FF0-000A95A07384@sands-edge.com>
References: <9EB527A2-83F5-11D8-9FF0-000A95A07384@sands-edge.com>
	 <20040401100546.A27472@home.com>
	 <4317F0F4-8405-11D8-9FF0-000A95A07384@sands-edge.com>
	 <20040401181926.GA3630@gate.ebshome.net> <406C658E.10500@embeddededge.com>
	 <20040401185956.GB3786@gate.ebshome.net>
	 <2C2F00BD-8410-11D8-9FF0-000A95A07384@sands-edge.com>
	 <20040401191715.GC3786@gate.ebshome.net> <406C8104.9050609@acm.org>
	 <20040401220018.GA4130@gate.ebshome.net>
	 <D7F4C570-84C5-11D8-9FF0-000A95A07384@sands-edge.com>
	 <406DB5DC.6060508@acm.org>
	 <C9A11702-84DB-11D8-9FF0-000A95A07384@sands-edge.com>
	 <406DCAF1.1040602@acm.org>
	 <F6294392-84E8-11D8-9FF0-000A95A07384@sands-edge.com>
	 <1080978857.7999.813.camel@newt>
	 <811D8989-856C-11D8-9FF0-000A95A07384@sands-edge.com>
Content-Type: text/plain
Message-Id: <1081155937.7999.893.camel@newt>
Mime-Version: 1.0
Date: Mon, 05 Apr 2004 10:05:37 +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 2004-04-03 at 13:43, John Whitney wrote:

> One of the nice things about having the DMA-core, however, was that it
> accepted virtual addresses and handled cache consistency.  If the
> driver is accepting physical addresses only, it can't do that.  This
> means the client would have to allocate space using the DMA/PCI to get
> the same coherency, which means all addresses will be
> PCI-address-space.  Should the individual drivers accept this and just
> subtract off PCI_DRAM_OFFSET (or equivalent) to get back to a physical
> address?  This is what would make life hell for a cross-platform DMA
> controller.

What I would like is a general API for a block move between memory and a
dumb PCI peripheral. Something like mempcy_toio() but with the
expectation of it sleeping.

Your local bus peripheral might benefit from a standard API, but I'm
still not convinced that there will be many cross-platform DMA
controllers. All the ones I've seen are tightly coupled to the
northbridge or system-on-a-chip internal bus. I'd still prefer a shared
interface rather than implementation, and I'd suggest taking an
interface proposal to the linux-arm-kernel and linuxppc-embedded lists.

- Adrian Cox


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
