Date: Sun, 21 Jul 2002 23:26:40 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-embedded@lists.linuxppc.org,
	"David S. Miller" <davem@redhat.com>
Subject: Re: consistent_alloc() revisited
Message-ID: <20020721132640.GF22786@zax>
References: <20020717012442.GA22786@zax> <20020720152830.1555@192.168.4.1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020720152830.1555@192.168.4.1>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Sat, Jul 20, 2002 at 05:28:30PM +0200, Benjamin Herrenschmidt wrote:
>
> >As far as I can tell there's no problem with get_free_pages() (or
> >rather, alloc_pages()), except that we need to add GFP_ATOMIC to the
> >flags if we're in interrupt context.
> >
> >The problems are in get_vm_area() which does a kmalloc() without
> >GFP_ATOMIC and in map_page() which can sleep.
>
> (Note do DaveM: this thread from linuxppc-embedded talks about
> out consistent_alloc() functions used to get non-cacheable
> DMA consistent memory for peripherials on the various non-PCI
> type busses you can find on such embedded CPUs)

And which is also used to implement pci_alloc_consistent().

> We can't rely on in_interrupt(). We can be called with a spinlock
> held or on the VM path. In those cases, we need GFP_ATOMIC but
> in_interrupt() won't be set.

That's true.

> I would rather pass a gfp_mask argument to consistent_alloc. I know
> the pci_xxx version lacks that argument, I yet have to talk to DaveM
> about it, in the meantime, it should be implemented as calling
> consistent_alloc(..., GFP_ATOMIC).

That makes sense.  But we would also need a GFP argument to
get_vm_area() and to pte_alloc_kernel()

> I want the gfp argument to be passed since some drivers will want
> a quite large pool to be allocated at insmod/kernel init time,
> and I want to let those drivers to be able to sleep while VM
> gets the pages back in this case instead of failing as they would
> probably do with a GFP_ATOMIC on a machine that have been running
> for some time.
>
> Ben.
>
>
>
>

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
