Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 60D9EB6F1F
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  9 Sep 2009 07:29:52 +1000 (EST)
Subject: RE: AW: PowerPC PCI DMA issues (prefetch/coherency?)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: azilkie@datacast.com
In-Reply-To: <1252432873.2548.41.camel@Adam>
References: <1251926572.10090.17.camel@Adam>  <4A9F78AF.4010206@oxtel.com>
	<1251971849.15089.28.camel@pasglop> <1251993890.2548.14.camel@Adam>
	<0CA0A16855646F4FA96D25A158E299D606F60795@SDCEXCHANGE01.ad.amcc.com>
	<1252432873.2548.41.camel@Adam>
Content-Type: text/plain
Date: Wed, 09 Sep 2009 07:29:35 +1000
Message-Id: <1252445375.4950.95.camel@pasglop>
Mime-Version: 1.0
Cc: phazarika@amcc.com, Tom Burns <tburns@datacast.com>,
	Andrea Zypchen <azypchen@intldata.ca>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2009-09-08 at 14:01 -0400, Adam Zilkie wrote:
> Hi Prodyut,
> 
> Yes, I am using the 440EPx (same as the sequoia board). 
> Our ideDriver is DMA'ing blocks of 192-byte data over the PCI bus (using
> the Sil0680A PCI-IDE bridge). Most of the DMA's (depending on timing)
> end up being partially corrupted when we try to parse the data in the
> virtual page. We have confirmed the data is good before the PCI-IDE
> bridge. We are creating two 8K pages and map them to physical DMA memory
> using single-entry scatter/gather structs. When a DMA block is
> corrupted, we see a random portion of it (always a multiple of 16byte
> cache lines) is overwritten with old data from the last time the buffer
> was used. 

Smells to me like you aren't properly using the dma or pci dma APIs to
flush/invalidate the cache around your transfers.

Ben.


> Regards,
> Adam
> 
> On Thu, 2009-09-03 at 13:27 -0700, Prodyut Hazarika wrote:
> > Hi Adam,
> > 
> > > Are you sure there is L2 cache on the 440?
> > 
> > It depends on the SoC you are using. SoC like 460EX (Canyonlands board)
> > have L2Cache.
> > It seems you are using a Sequoia board, which has a 440EPx SoC. 440EPx
> > has a 440 cpu core, but no L2Cache.
> > Could you please tell me which SoC you are using?
> > You can also refer to the appropriate dts file to see if there is L2C.
> > For example, in canyonlands.dts (460EX based board), we have the L2C
> > entry.
> >         L2C0: l2c {
> >               ...
> >         }
> > 
> > >I am seeing this problem with our custom IDE driver which is based on 
> > >pretty old code. Our driver uses pci_alloc_consistent() to allocate the
> > 
> > >physical DMA memory and alloc_pages() to allocate a virtual page. It 
> > >then uses pci_map_sg() to map to a scatter/gather buffer. Perhaps I 
> > >should convert these to the DMA API calls as you suggest.
> > 
> > Could you give more details on the consistency problem? It is a good
> > idea to change to the new DMA APIs, but pci_alloc_consistent() should
> > work too
> > 
> > Thanks
> > Prodyut	
> > 
> > On Thu, 2009-09-03 at 19:57 +1000, Benjamin Herrenschmidt wrote:
> > > On Thu, 2009-09-03 at 09:05 +0100, Chris Pringle wrote:
> > > > Hi Adam,
> > > > 
> > > > If you have a look in include/asm-ppc/pgtable.h for the following
> > section:
> > > > #ifdef CONFIG_44x
> > > > #define _PAGE_BASE    (_PAGE_PRESENT | _PAGE_ACCESSED |
> > _PAGE_GUARDED)
> > > > #else
> > > > #define _PAGE_BASE    (_PAGE_PRESENT | _PAGE_ACCESSED)
> > > > #endif
> > > > 
> > > > Try adding _PAGE_COHERENT to the appropriate line above and see if
> > that 
> > > > fixes your issue - this causes the 'M' bit to be set on the page
> > which 
> > > > sure enforce cache coherency. If it doesn't, you'll need to check
> > the 
> > > > 'M' bit isn't being masked out in head_44x.S (it was originally
> > masked 
> > > > out on arch/powerpc, but was fixed in later kernels when the cache 
> > > > coherency issues with non-SMP systems were resolved).
> > > 
> > > I have some doubts about the usefulness of doing that for 4xx. AFAIK,
> > > the 440 core just ignores M.
> > > 
> > > The problem lies probably elsewhere. Maybe the L2 cache coherency
> > isn't
> > > enabled or not working ?
> > > 
> > > The L1 cache on 440 is simply not coherent, so drivers have to make
> > sure
> > > they use the appropriate DMA APIs which will do cache flushing when
> > > needed.
> > > 
> > > Adam, what driver is causing you that sort of problems ?
> > > 
> > > Cheers,
> > > Ben.
> > > 
> > > 
