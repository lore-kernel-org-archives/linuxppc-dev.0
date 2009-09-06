Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 86959B7B5C
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  7 Sep 2009 07:32:42 +1000 (EST)
Subject: RE: AW: PowerPC PCI DMA issues (prefetch/coherency?)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Wrobel Heinz-R39252 <Heinz.Wrobel@freescale.com>
In-Reply-To: <AAE514D00E55E6438B7F5186462A545202750F9B@zuk35exm20.fsl.freescale.net>
References: <1251926572.10090.17.camel@Adam> <4A9F78AF.4010206@oxtel.com>
	<AAE514D00E55E6438B7F5186462A545202750F9B@zuk35exm20.fsl.freescale.net>
Content-Type: text/plain
Date: Mon, 07 Sep 2009 07:32:27 +1000
Message-Id: <1252272747.4950.0.camel@pasglop>
Mime-Version: 1.0
Cc: Tom Burns <tburns@datacast.com>, Chris Pringle <chris.pringle@oxtel.com>,
	Andrea Zypchen <azypchen@intldata.ca>,
	linuxppc-dev@lists.ozlabs.org, azilkie@datacast.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2009-09-03 at 13:20 +0100, Wrobel Heinz-R39252 wrote:
> Hi,
> 
> This doesn't seem right. If we are talking about a single CPU core chip,
> i.e., just one data cache, then setting M is typically a) useless and
> could even b) cause a performance penalty depending on a chip's
> implementation.
> The M bit is required if *other* cores with caches need to see changes
> for coherency of their caches. You wouldn't set it for one core only
> because your own core knows about its own cache.
> The possible performance penalty could happen because you need some way
> to tell the others that they better intercept a transaction. And that
> could, depending on the chip, by a clock extra or so per transaction.
> Now, in theory, a DMA engine could have caches, read from cache content
> first, and could snoop the bus on global transactions like another core,
> but I have never heard of such a beast. 

Actually there are some freescale part, afaik, that require M for proper
cache coherency :-) I don't have names off the top of my mind, I think
it has to be with PCI inbound buffers.

In this case, however, it's 440 on which I believe M is simply ignored.

Cheers,
Ben.

> Hope this helps,
> 
> Heinz
> 
> -----Original Message-----
> From: linuxppc-dev-bounces+heinz.wrobel=freescale.com@lists.ozlabs.org
> [mailto:linuxppc-dev-bounces+heinz.wrobel=freescale.com@lists.ozlabs.org
> ] On Behalf Of Chris Pringle
> Sent: Donnerstag, 3. September 2009 10:05
> To: azilkie@datacast.com
> Cc: Tom Burns; Andrea Zypchen; linuxppc-dev@lists.ozlabs.org
> Subject: Re: AW: PowerPC PCI DMA issues (prefetch/coherency?)
> 
> Hi Adam,
> 
> If you have a look in include/asm-ppc/pgtable.h for the following
> section:
> #ifdef CONFIG_44x
> #define _PAGE_BASE    (_PAGE_PRESENT | _PAGE_ACCESSED | _PAGE_GUARDED)
> #else
> #define _PAGE_BASE    (_PAGE_PRESENT | _PAGE_ACCESSED)
> #endif
> 
> Try adding _PAGE_COHERENT to the appropriate line above and see if that
> fixes your issue - this causes the 'M' bit to be set on the page which
> sure enforce cache coherency. If it doesn't, you'll need to check the
> 'M' bit isn't being masked out in head_44x.S (it was originally masked
> out on arch/powerpc, but was fixed in later kernels when the cache
> coherency issues with non-SMP systems were resolved).
> 
> The patch I had fixed two problems on 2.6.26 for 'powerpc':
> 1) It stopped the 'M' bit being masked out (head_32.S)
> 2) It set the cache coherency ('M' bit) flag on each page table entry
> (pgtable-ppc32.h)
> 
> Hope this helps!
> 
> Cheers,
> Chris
> 
> Adam Zilkie wrote:
> > Hi Chris,
> >
> > I am having a problem similar to what you described in this
> discussion.
> > We are using the ppc arch with 2.6.24 with CONFIG_SEQUOIA with 
> > compiles arch/ppc/kernel/head_44x.c (quite different from 
> > /arch/powerpc/kernel/head_32.S). I would like to apply your 
> > backporting patch to this architecture. Any help would be appreciated.
> >
> > Regards,
> > Adam
> >
> >   
> 
> 
