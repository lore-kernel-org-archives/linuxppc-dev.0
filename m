Date: Mon, 22 Jan 2001 22:23:55 +0100 (MET)
From: Roman Zippel <zippel@fh-brandenburg.de>
To: Jeff Hartmann <jhartmann@valinux.com>
cc: Dan Malek <dan@mvista.com>, michdaen@iiic.ethz.ch,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Gareth Hughes <gareth@valinux.com>, linuxppc-dev@lists.linuxppc.org,
        dri-devel@lists.sourceforge.net, Paul Mackerras <paulus@linuxcare.com>
Subject: Re: [Dri-devel] PPC Lockup (ati-pcigart-branch)
In-Reply-To: <3A6C9852.4090201@valinux.com>
Message-ID: <Pine.GSO.4.10.10101222206430.24677-100000@zeus.fh-brandenburg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

On Mon, 22 Jan 2001, Jeff Hartmann wrote:

> Later on this list of pages will be mapped into user space by the DRM's
> mmap routine.  It uses vma_nopage to accomplish this.  vma_nopage
> functions should return struct page *, we do this by returning
> pagelist[page_offset_in_pages_from_start_of_vma].  This should work on
> fine on any arch's kernel.  We haven't gotten to this point in the code
> yet, so its not the issue we are addressing.

Do you make the page private already?

> Another thing that happens later is that we need the bus address of each
> of these pages to program the card to do scatter gather dma from this
> region.  We do virt_to_bus(pagelist[i]->virtual) to accomplish this
> translation.

Better use page_address() to get the virtual address and then use
pci_map_single() or pci_map_sg() to get a dma address.

> I know on the ia32 a pgd/pmd can actually point to 4MB pages rather then
> a real pte.  Does the PowerPC have anything like this?  I would doubt
> that I would encounter anything like this from a vmalloc'ed area of
> memory (since vmalloc is arch independent and it would call alloc_page
> for each individual pte.)  Am I correct in this assumption?

ppc doesn't have page table, it either uses a hash table or the tlb
entries have to be filled by software. Anyway, pgd/pmd/pte are used to
keep the management compatible to Linux and are like ia32 also two levels.

> Another thing we might be running into here is that vmalloc does not
> guarantee a virtually contiguous area of memory (or so I am told.)  I've
> NEVER seen this in practice on an ia32 platform.  Does this happen only
> happen on other platforms, or perhaps happen more often on other platforms?

Someone was confused :). vmalloc can't guarantee that it allocates a
physical contiguous area.

bye, Roman


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
