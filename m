Date: Wed, 17 Jul 2002 10:07:12 -0500
From: Stephen Cameron <steve.cameron@hp.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: RE: ioremap on powerpc question
Message-ID: <20020717100712.A23115@zuul.cca.cpqcorp.net>
Reply-To: steve.cameron@hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hmm, I continue to have difficulties...

Matt Porter wrote:
>
>
> On Mon, Jul 15, 2002 at 01:58:21PM -0500, Cameron, Steve wrote:
[...]
> > I want to create a huge RAM buffer for i/o purposes, so I
> > boot the kernel with parameter "mem=64M" (actually, my
> > system, an IBM ebony 440, has 128M RAM) [...]
> >
> > 	unsigned char *buf;
> > 	buf = ioremap_nocache(64*1024*1024, 64*1024*1024);
> >
[...]
> > However, on powerpc, as soon as I try to do, for example:
> >
> > 	*buf = '\0'; // write one char to virt addr returned by ioremap
> >
> > It blows up with a machine check.
>
> You are hitting a 440GP specific feature.  ioremap is trapping
> ranges of addresses and "fixing them up" with the proper ERPN.
> Unfortunately, I left the default on a no match as an ERPN=1
> which will ioremap 1 0400 0000.   That's why you get a bus error.
>
> Try this patch:
>
> ===== arch/ppc/mm/pgtable.c 1.19 vs edited =====
> --- 1.19/arch/ppc/mm/pgtable.c	Wed Jun 26 15:00:59 2002
> +++ edited/arch/ppc/mm/pgtable.c	Mon Jul 15 16:12:32 2002
> @@ -93,7 +93,7 @@
>  ioremap(unsigned long addr, unsigned long size)
>  {
>  	unsigned long long addr64;
> -	unsigned long long page_4gb = PPC440_IO_PAGE;
> +	unsigned long long page_4gb = 0;
>
>  	/*
>  	 * Trap the least significant 32-bit portions of an
>

Ok, I tried this all day yesterday.  This does allow me to
use the virtual address returned by ioremap_nocache.  However,
when I attempt to DMA into the physical address with my PCI device,
it is as if the DMA never occurs.  Prior to the DMA, I fill the
buffer with 0x55's, and after the DMA, the 0x55's are still there.
I'm thinking either caching is getting me, or else the physical
address mapped by ioremap is not what I think it is.  Attacking
the caching problem first, I tried, just before the DMA,

	consistent_sync(buf, length, data_direction);

where buf is (a page aligned offset from) the virtual address returned by
ioremap, length is either the buffer length, or the buffer length
rounded up to next multiple of SMP_CACHE_BYTES (tried both), and data_direction
is in this case, PCI_DMA_FROMDEVICE.  (I also tried using for "buf",
virt_to_phys(physaddr) where physaddr was the physical address
which I (presumably) know because I set it up via ioremap...that is
passing 0xC0000000 + physaddr to consistent_sync...that panicked).

I also tried ioremap() vs. ioremap_nocache(), thinking possibly that
using ioremap_nocache() was somehow short-circuiting the action of
consistent_sync() (though not seeing any code that does that.) No dice.
Always the same result, the DMA does not work.

BTW, my device seems happy with the physical addresses I pass it,
and the response I get from it indicate the DMA occurred...to
_somewhere_.  Maybe it's time to break out the pci analyzer.
Any ideas what's going on here?

I caught some idea from someone here at HP that the caching attributes
were implemented on the 440 such that they applied to 128M physical
regions, so it wasn't really possible to set up 64M to be non-cached
with the other 64M cached.... not sure if that's right or not,
but perhaps it's related to my problem somehow.

>
> You could use alloc_bootmem_pages() to get a large buffer more
> elegantly than lopping off memory and ioremapping. IMHO, it is
> a slightly more flexible approach to large allocations.
>

Since I was having no luck with ioremap, and this did seem more
elegant, I tried this approach too.  In init/main.c, I added code
to call alloc_bootmem_pages via a __setup() type function with
the amount of ram to alloc passed on kernel cmdline.

Here, I could allocate memory.  However, if I allocated more than
about 8M, the kernel would hang, the last thing output being
"POSIX conformance testing by UNIFIX".  I tried allocating 32M,
then 64M, then freeing the original 32M, thknking perhaps the first
allocation was grabbing some specific memory needed by something
later, this allowed things to get a little bit further, but ultimately
panicked the system.

Allocating small amounts of memory (4M), I did get DMA to succeed at
least once, but without being able to get all the memory I need
this wasn't really useful.

I also tried moving the allocation around in main.c to various
places, but found nothing that worked.

Any ideas on this alloc_bootmem_pages front?

Thanks,

-- steve


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
