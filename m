Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 3ACD92C00B7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Aug 2013 17:39:51 +1000 (EST)
Message-ID: <1377589182.3819.117.camel@pasglop>
Subject: Re: [PATCH v2 2/2] Register bootmem pages
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Date: Tue, 27 Aug 2013 17:39:42 +1000
In-Reply-To: <1377575091.3819.97.camel@pasglop>
References: <5212D989.8090103@linux.vnet.ibm.com>
 <5212DA31.2060105@linux.vnet.ibm.com> <1377575091.3819.97.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2013-08-27 at 13:44 +1000, Benjamin Herrenschmidt wrote:

> So I still feel very uncomfortable with that stuff ....
> 
> For example, x86 calls register_page_bootmem_info_node() at boot time,
> which does that strange "get_page_bootmem" on the NODE_DATA itself at
> boot time, we don't. Should we ?

Bah, call me an idiot ... I was looking at the code without your patch
and not realizing that this is exactly what your patch does :-)

 .../...

> There's a whole pile of totally undocumented / uncommented generic code
> with horrible function names in there whose sematic is very very
> unclear.
> 
> Now, if we call that thing, are we expected to have
> register_paqe_bootmem_memmap() to actually do something right? I assume
> that means actually calling get_page_bootmem() on the various struct
> page that comprise the vmemmap.
> 
> Well, we can probably implement that since we maintain a list of all the
> vmemap pages... However, we don't implement vmemmap_free(). Should we ?

This still stands, should we actually "register" the pages of the
vmemmap or not ?

What happens if we remove a chunk of memory and then plug it back in ?
Will it try to re-create a new vmemmap chunk for that area (where we
haven't removed the previous one) ? That might cause problems if we end
up putting duplicate entries in the hash table ... should we implement
vmemmap_free and actual unmap the segments ?

> Cheers,
> Ben.
> 
> > 
> > ---
> >  arch/powerpc/mm/init_64.c |    4 ++++
> >  arch/powerpc/mm/mem.c     |    9 +++++++++
> >  mm/Kconfig                |    2 +-
> >  3 files changed, 14 insertions(+), 1 deletion(-)
> > 
> > Index: linux/arch/powerpc/mm/init_64.c
> > ===================================================================
> > --- linux.orig/arch/powerpc/mm/init_64.c
> > +++ linux/arch/powerpc/mm/init_64.c
> > @@ -300,5 +300,9 @@ void vmemmap_free(unsigned long start, u
> >  {
> >  }
> > 
> > +void register_page_bootmem_memmap(unsigned long section_nr,
> > +				  struct page *start_page, unsigned long size)
> > +{
> > +}
> >  #endif /* CONFIG_SPARSEMEM_VMEMMAP */
> > 
> > Index: linux/arch/powerpc/mm/mem.c
> > ===================================================================
> > --- linux.orig/arch/powerpc/mm/mem.c
> > +++ linux/arch/powerpc/mm/mem.c
> > @@ -297,12 +297,21 @@ void __init paging_init(void)
> >  }
> >  #endif /* ! CONFIG_NEED_MULTIPLE_NODES */
> > 
> > +static void __init register_page_bootmem_info(void)
> > +{
> > +	int i;
> > +
> > +	for_each_online_node(i)
> > +		register_page_bootmem_info_node(NODE_DATA(i));
> > +}
> > +
> >  void __init mem_init(void)
> >  {
> >  #ifdef CONFIG_SWIOTLB
> >  	swiotlb_init(0);
> >  #endif
> > 
> > +	register_page_bootmem_info();
> >  	high_memory = (void *) __va(max_low_pfn * PAGE_SIZE);
> >  	set_max_mapnr(max_pfn);
> >  	free_all_bootmem();
> > Index: linux/mm/Kconfig
> > ===================================================================
> > --- linux.orig/mm/Kconfig
> > +++ linux/mm/Kconfig
> > @@ -183,7 +183,7 @@ config MEMORY_HOTPLUG_SPARSE
> >  config MEMORY_HOTREMOVE
> >  	bool "Allow for memory hot remove"
> >  	select MEMORY_ISOLATION
> > -	select HAVE_BOOTMEM_INFO_NODE if X86_64
> > +	select HAVE_BOOTMEM_INFO_NODE if (X86_64 || PPC64)
> >  	depends on MEMORY_HOTPLUG && ARCH_ENABLE_MEMORY_HOTREMOVE
> >  	depends on MIGRATION
> > 
> > 
> > _______________________________________________
> > Linuxppc-dev mailing list
> > Linuxppc-dev@lists.ozlabs.org
> > https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
