Message-ID: <3AFF16E6.C715ECAE@acm.org>
Date: Sun, 13 May 2001 16:21:10 -0700
From: Ira Weiny <iweiny@acm.org>
MIME-Version: 1.0
To: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Walnut 405GP and SBLive sound card
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I am at the end of my rope...

What I know is:
I have a Walnut 405GP rev D board and a Creative SBLive sound card.
I have this card running on a G3 powermac. (endian fix)
And the card does get recognized and will start/top playing a continuous
tone at the correct times on the Walnut board.
There is a cache conherentcy issue on the 405GP when doing DMA.
Basically there is a hardware bug which does not flush the cache on
writes.  (I can't find the documentation from IBM which sort of hints at
this.)
I am _very_ confused by the virt_to_bus, virt_to_phys, ioremap,
memremap, and just about every other memory related functions I walk
through.  (and I can't seem to find PPC specific explanations for these
functions)
The driver calls the pci_(alloc/free)_consistent functions for the DMA
transfer buffers.

What I think:
I need to call dma_cache_wback_inv (with the correct address and size;
at the correct time)

What I am assuming:
The kernel I have (mvista 2001-04-12) works with a Promise IDE controler
so the PCI bridge must be setup and working ok.

My questions:
1) Where can I find PPC centric information on the kernel internals.
(Not just for this problem but as a general reference.)
I have purchased books which focus on the intel arch and have been to
many web sites which explain "UNIX internals" theory quite well.  But I
know theory...
2) Is dma_cache_wback_inv the correct way to do this?  If not, what is?

Thanks in advance,
Ira Weiny
iweiny@acm.org

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
