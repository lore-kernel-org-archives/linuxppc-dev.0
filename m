From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15357.42818.227392.566129@cargo.ozlabs.ibm.com>
Date: Fri, 23 Nov 2001 12:32:50 +1100 (EST)
To: Dan Malek <dan@embeddededge.com>
Cc: Armin Kuster <akuster@mvista.com>,
	ppcdevel <linuxppc-dev@lists.linuxppc.org>
Subject: Re: New API for non cache coherent ppc cpu's
In-Reply-To: <3BFD8520.5060105@embeddededge.com>
References: <3BFAB960.DAA72239@mvista.com>
	<15357.26322.107051.143144@cargo.ozlabs.ibm.com>
	<3BFD8520.5060105@embeddededge.com>
Reply-To: paulus@samba.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Dan Malek writes:

> That's exactly what it is.  We are not creating a new API, and it shouldn't
> have been described as such.

OK... Armin's message wasn't exactly clear... :)

> They do.  Recently a pci_sync_page was added for some reason (because

To go with pci_map_page and pci_unmap_page.  These give you the
ability to do DMA to highmem pages without using bounce buffers.

> > If you're talking about non-PCI devices, use the pci DMA API but just
> > pass NULL for the dev (we need to make sure that will work ok on the
> > non-cache-coherent cpus).
>
> Ummm....I don't normally do this because using these functions requires
> the CONFIG_PCI option, which isn't supported or has bad effects when
> requested on processors that don't have PCI.  For non-PCI devices,
> I call the consistent_* functions, which other architectures support
> and do as well.  So, we kind of have a common interface here for non-PCI
> devices as well.

My preference would be to make the one set of functions work
everywhere.  OTOH these non-PCI devices you're talking about are
presumably very specific to PPC embedded chips so maybe it doesn't
matter so much.

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
