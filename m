From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15357.26322.107051.143144@cargo.ozlabs.ibm.com>
Date: Fri, 23 Nov 2001 07:57:54 +1100 (EST)
To: Armin Kuster <akuster@mvista.com>
Cc: ppcdevel <linuxppc-dev@lists.linuxppc.org>
Subject: Re: New API for non cache coherent ppc cpu's
In-Reply-To: <3BFAB960.DAA72239@mvista.com>
References: <3BFAB960.DAA72239@mvista.com>
Reply-To: paulus@samba.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Armin Kuster writes:

> To all NOT_COHERENT_CACHE users
>
> About a month ago a new API made its way into the ppc,
> consistent_sync_page.  For CONFIG_NOT_COHERENT_CACHE  processors,
> requires
> proper flushing of the page being used.  Please review and provide feed
> back

If we have to have a consistent_sync_page, it should be purely a local
function in our implementation of the official DMA mapping API - see
Documentation/DMA-mapping.txt.  Drivers should be using functions such
as pci_alloc_consistent, pci_map_single, pci_dma_sync_single,
pci_unmap_single, etc.  The implementation of those routines should do
the correct cache flushing - if it doesn't then we need to fix it.

If you're talking about non-PCI devices, use the pci DMA API but just
pass NULL for the dev (we need to make sure that will work ok on the
non-cache-coherent cpus).

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
