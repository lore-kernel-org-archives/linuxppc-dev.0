Return-Path: <azilkie@datacast.com>
Received: from datacast.com (mail.datacast.com [209.87.232.171])
	by bilbo.ozlabs.org (Postfix) with ESMTP id 47011B6F20
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  9 Sep 2009 06:11:54 +1000 (EST)
Received: from [192.168.2.131] by datacast.com (MDaemon PRO v9.6.1)
	with ESMTP id md50001435584.msg
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Sep 2009 16:09:04 -0400
Subject: RE: AW: PowerPC PCI DMA issues (prefetch/coherency?)
From: Adam Zilkie <azilkie@datacast.com>
To: phazarika@amcc.com
In-Reply-To: <0CA0A16855646F4FA96D25A158E299D606F60BA2@SDCEXCHANGE01.ad.amcc.com>
References: <1251926572.10090.17.camel@Adam> <4A9F78AF.4010206@oxtel.com>
	<1251971849.15089.28.camel@pasglop> <1251993890.2548.14.camel@Adam>
	<0CA0A16855646F4FA96D25A158E299D606F60795@SDCEXCHANGE01.ad.amcc.com>
	<1252432873.2548.41.camel@Adam>
	<0CA0A16855646F4FA96D25A158E299D606F60B70@SDCEXCHANGE01.ad.amcc.com>
	<1252438259.2548.50.camel@Adam>
	<0CA0A16855646F4FA96D25A158E299D606F60BA2@SDCEXCHANGE01.ad.amcc.com>
Content-Type: text/plain
Date: Tue, 08 Sep 2009 16:00:26 -0400
Message-Id: <1252440026.2548.53.camel@Adam>
Mime-Version: 1.0
Cc: Tom Burns <tburns@datacast.com>, Andrea Zypchen <azypchen@intldata.ca>,
	linuxppc-dev@lists.ozlabs.org
Reply-To: azilkie@datacast.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We are using pci_alloc_consistent()

Adam

On Tue, 2009-09-08 at 12:56 -0700, Prodyut Hazarika wrote:
> > We have found that using flush_dcache_range() after each DMA solves
> the
> > problem. Ideally, we'd like to be able to allocate the virtual page in
> > cache inhibited memory to avoid the performance loss from all the
> flush
> > calls. To do this, we'd have to change our TLB sizes and reserve a TLB
> > in memory as cache inhibited (using the 'I' bit). Will update if this
> > works as well. Thanks for your help in this.
> 
> Aren't you using dma_alloc_coherent to get buffers that are shared
> between CPU and external devices?
> 
> Thanks
> Prodyut
> 
> On Tue, 2009-09-08 at 11:59 -0700, Prodyut Hazarika wrote:
> > Hi Adam,
> > 
> > > Yes, I am using the 440EPx (same as the sequoia board). 
> > > Our ideDriver is DMA'ing blocks of 192-byte data over the PCI bus
> > (using
> > > the Sil0680A PCI-IDE bridge). Most of the DMA's (depending on
> timing)
> > > end up being partially corrupted when we try to parse the data in
> the
> > > virtual page. We have confirmed the data is good before the PCI-IDE
> > > bridge. We are creating two 8K pages and map them to physical DMA
> > memory
> > > using single-entry scatter/gather structs. When a DMA block is
> > > corrupted, we see a random portion of it (always a multiple of
> 16byte
> > > cache lines) is overwritten with old data from the last time the
> > buffer
> > > was used. 
> > 
> > This looks like a cache coherency problem.
> > Can you ensure that the TLB entries corresponding to the DMA region
> has
> > the CacheInhibit bit set.
> > You will need a BDI connected to your system.
> > 
> > Also, you will need to invalidate and flush the lines appropriately,
> > since in 440 cores,
> > L1Cache coherency is managed entirely by software.
> > Please look at drivers/net/ibm_newemac/mal.c and core.c for example on
> > how to do it.
> > 
> > Thanks
> > Prodyut
> > 
> > On Thu, 2009-09-03 at 13:27 -0700, Prodyut Hazarika wrote:
> > > Hi Adam,
> > > 
> > > > Are you sure there is L2 cache on the 440?
> > > 
> > > It depends on the SoC you are using. SoC like 460EX (Canyonlands
> > board)
> > > have L2Cache.
> > > It seems you are using a Sequoia board, which has a 440EPx SoC.
> 440EPx
> > > has a 440 cpu core, but no L2Cache.
> > > Could you please tell me which SoC you are using?
> > > You can also refer to the appropriate dts file to see if there is
> L2C.
> > > For example, in canyonlands.dts (460EX based board), we have the L2C
> > > entry.
> > >         L2C0: l2c {
> > >               ...
> > >         }
> > > 
> > > >I am seeing this problem with our custom IDE driver which is based
> on
> > 
> > > >pretty old code. Our driver uses pci_alloc_consistent() to allocate
> > the
> > > 
> > > >physical DMA memory and alloc_pages() to allocate a virtual page.
> It 
> > > >then uses pci_map_sg() to map to a scatter/gather buffer. Perhaps I
> 
> > > >should convert these to the DMA API calls as you suggest.
> > > 
> > > Could you give more details on the consistency problem? It is a good
> > > idea to change to the new DMA APIs, but pci_alloc_consistent()
> should
> > > work too
> > > 
> > > Thanks
> > > Prodyut	
> > > 
> > > On Thu, 2009-09-03 at 19:57 +1000, Benjamin Herrenschmidt wrote:
> > > > On Thu, 2009-09-03 at 09:05 +0100, Chris Pringle wrote:
> > > > > Hi Adam,
> > > > > 
> > > > > If you have a look in include/asm-ppc/pgtable.h for the
> following
> > > section:
> > > > > #ifdef CONFIG_44x
> > > > > #define _PAGE_BASE    (_PAGE_PRESENT | _PAGE_ACCESSED |
> > > _PAGE_GUARDED)
> > > > > #else
> > > > > #define _PAGE_BASE    (_PAGE_PRESENT | _PAGE_ACCESSED)
> > > > > #endif
> > > > > 
> > > > > Try adding _PAGE_COHERENT to the appropriate line above and see
> if
> > > that 
> > > > > fixes your issue - this causes the 'M' bit to be set on the page
> > > which 
> > > > > sure enforce cache coherency. If it doesn't, you'll need to
> check
> > > the 
> > > > > 'M' bit isn't being masked out in head_44x.S (it was originally
> > > masked 
> > > > > out on arch/powerpc, but was fixed in later kernels when the
> cache
> > 
> > > > > coherency issues with non-SMP systems were resolved).
> > > > 
> > > > I have some doubts about the usefulness of doing that for 4xx.
> > AFAIK,
> > > > the 440 core just ignores M.
> > > > 
> > > > The problem lies probably elsewhere. Maybe the L2 cache coherency
> > > isn't
> > > > enabled or not working ?
> > > > 
> > > > The L1 cache on 440 is simply not coherent, so drivers have to
> make
> > > sure
> > > > they use the appropriate DMA APIs which will do cache flushing
> when
> > > > needed.
> > > > 
> > > > Adam, what driver is causing you that sort of problems ?
> > > > 
> > > > Cheers,
> > > > Ben.
> > > > 
> > > > 
> > -- 
> > Adam Zilkie
> > Software Designer,
> > International Datacasting Corp.
> > 
> > This message and the documents attached hereto are intended only for
> the
> > addressee and may contain privileged or confidential information. Any
> > unauthorized disclosure is strictly prohibited. If you have received
> > this message in error, please notify us immediately so that we may
> > correct our internal records. Please then delete the original message.
> > Thank you.
> > --------------------------------------------------------
> > 
> > CONFIDENTIALITY NOTICE: This e-mail message, including any
> attachments, is for the sole use of the intended recipient(s) and
> contains information that is confidential and proprietary to
> AppliedMicro Corporation or its subsidiaries. It is to be used solely
> for the purpose of furthering the parties' business relationship. All
> unauthorized review, use, disclosure or distribution is prohibited. If
> you are not the intended recipient, please contact the sender by reply
> e-mail and destroy all copies of the original message.
> > 
-- 
Adam Zilkie
Software Designer,
International Datacasting Corp.

This message and the documents attached hereto are intended only for the addressee and may contain privileged or confidential information. Any unauthorized disclosure is strictly prohibited. If you have received this message in error, please notify us immediately so that we may correct our internal records. Please then delete the original message. Thank you.
