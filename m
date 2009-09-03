Return-Path: <azilkie@datacast.com>
Received: from datacast.com (mail.datacast.com [209.87.232.171])
	by bilbo.ozlabs.org (Postfix) with ESMTP id 00B30B6F2B
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  4 Sep 2009 02:17:55 +1000 (EST)
Received: from [192.168.2.131] by datacast.com (MDaemon PRO v9.6.1)
	with ESMTP id md50001429242.msg
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 03 Sep 2009 12:13:07 -0400
Subject: Re: AW: PowerPC PCI DMA issues (prefetch/coherency?)
From: Adam Zilkie <azilkie@datacast.com>
To: benh@kernel.crashing.org
In-Reply-To: <1251971849.15089.28.camel@pasglop>
References: <1251926572.10090.17.camel@Adam>  <4A9F78AF.4010206@oxtel.com>
	<1251971849.15089.28.camel@pasglop>
Content-Type: text/plain
Date: Thu, 03 Sep 2009 12:04:50 -0400
Message-Id: <1251993890.2548.14.camel@Adam>
Mime-Version: 1.0
Cc: Tom Burns <tburns@datacast.com>, Chris Pringle <chris.pringle@oxtel.com>,
	Andrea Zypchen <azypchen@intldata.ca>, linuxppc-dev@lists.ozlabs.org
Reply-To: azilkie@datacast.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ben,

Thanks for your info.

Are you sure there is L2 cache on the 440?

I am seeing this problem with our custom IDE driver which is based on
pretty old code. Our driver uses pci_alloc_consistent() to allocate the
physical DMA memory and alloc_pages() to allocate a virtual page. It
then uses pci_map_sg() to map to a scatter/gather buffer. Perhaps I
should convert these to the DMA API calls as you suggest.

Regards,
Adam

On Thu, 2009-09-03 at 19:57 +1000, Benjamin Herrenschmidt wrote:
> On Thu, 2009-09-03 at 09:05 +0100, Chris Pringle wrote:
> > Hi Adam,
> > 
> > If you have a look in include/asm-ppc/pgtable.h for the following section:
> > #ifdef CONFIG_44x
> > #define _PAGE_BASE    (_PAGE_PRESENT | _PAGE_ACCESSED | _PAGE_GUARDED)
> > #else
> > #define _PAGE_BASE    (_PAGE_PRESENT | _PAGE_ACCESSED)
> > #endif
> > 
> > Try adding _PAGE_COHERENT to the appropriate line above and see if that 
> > fixes your issue - this causes the 'M' bit to be set on the page which 
> > sure enforce cache coherency. If it doesn't, you'll need to check the 
> > 'M' bit isn't being masked out in head_44x.S (it was originally masked 
> > out on arch/powerpc, but was fixed in later kernels when the cache 
> > coherency issues with non-SMP systems were resolved).
> 
> I have some doubts about the usefulness of doing that for 4xx. AFAIK,
> the 440 core just ignores M.
> 
> The problem lies probably elsewhere. Maybe the L2 cache coherency isn't
> enabled or not working ?
> 
> The L1 cache on 440 is simply not coherent, so drivers have to make sure
> they use the appropriate DMA APIs which will do cache flushing when
> needed.
> 
> Adam, what driver is causing you that sort of problems ?
> 
> Cheers,
> Ben.
> 
> 
-- 
Adam Zilkie
Software Designer,
International Datacasting Corp.

This message and the documents attached hereto are intended only for the addressee and may contain privileged or confidential information. Any unauthorized disclosure is strictly prohibited. If you have received this message in error, please notify us immediately so that we may correct our internal records. Please then delete the original message. Thank you.
