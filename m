From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Gibson <david@gibson.dropbear.id.au>,
	<linuxppc-embedded@lists.linuxppc.org>
Cc: "David S. Miller" <davem@redhat.com>
Subject: Re: consistent_alloc() revisited
Date: Sat, 20 Jul 2002 17:28:30 +0200
Message-Id: <20020720152830.1555@192.168.4.1>
In-Reply-To: <20020717012442.GA22786@zax>
References: <20020717012442.GA22786@zax>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>As far as I can tell there's no problem with get_free_pages() (or
>rather, alloc_pages()), except that we need to add GFP_ATOMIC to the
>flags if we're in interrupt context.
>
>The problems are in get_vm_area() which does a kmalloc() without
>GFP_ATOMIC and in map_page() which can sleep.

(Note do DaveM: this thread from linuxppc-embedded talks about
out consistent_alloc() functions used to get non-cacheable
DMA consistent memory for peripherials on the various non-PCI
type busses you can find on such embedded CPUs)

We can't rely on in_interrupt(). We can be called with a spinlock
held or on the VM path. In those cases, we need GFP_ATOMIC but
in_interrupt() won't be set.

I would rather pass a gfp_mask argument to consistent_alloc. I know
the pci_xxx version lacks that argument, I yet have to talk to DaveM
about it, in the meantime, it should be implemented as calling
consistent_alloc(..., GFP_ATOMIC).

I want the gfp argument to be passed since some drivers will want
a quite large pool to be allocated at insmod/kernel init time,
and I want to let those drivers to be able to sleep while VM
gets the pages back in this case instead of failing as they would
probably do with a GFP_ATOMIC on a machine that have been running
for some time.

Ben.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
