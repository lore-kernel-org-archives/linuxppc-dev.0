Return-Path: <fujita.tomonori@lab.ntt.co.jp>
Received: from sh.osrg.net (sh.osrg.net [192.16.179.4])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7E366B70DF
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Oct 2010 20:23:16 +1000 (EST)
Date: Sat, 2 Oct 2010 19:11:11 +0900
To: benh@kernel.crashing.org
Subject: Re: [patch 1/1] powerpc: enable ARCH_DMA_ADDR_T_64BIT with
	ARCH_PHYS_ADDR_T_64BIT
From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
In-Reply-To: <1285989654.2463.286.camel@pasglop>
References: <201010012112.o91LCtEk020866@imap1.linux-foundation.org>
	<AANLkTikrgu5LrYfveax_EavObThNw2M4ukVB3ka1y0Hj@mail.gmail.com>
	<1285989654.2463.286.camel@pasglop>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Message-Id: <20101002190634E.fujita.tomonori@lab.ntt.co.jp>
Cc: fujita.tomonori@lab.ntt.co.jp, linuxppc-dev@ozlabs.org,
	akpm@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 02 Oct 2010 13:20:54 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Fri, 2010-10-01 at 21:31 -0400, Josh Boyer wrote:
> > > +config ARCH_DMA_ADDR_T_64BIT
> > > +       def_bool ARCH_PHYS_ADDR_T_64BIT
> > > +
> > 
> > I seemed to have missed what this is about entirely.  Is there some
> > place I can look that describes what that is supposed to do?  The PPC

This patchset unifies dma_addr_t typedef.

> > 4xx boards set PHYS_ADDR_T_64BIT because the MMU uses 36 bit
> > addressing, but the CPU is only 32 bits.  I want to make sure this DMA
> > thing isn't going to cause problems. 

this patchset changes nothing. Please see below.


> Yes, we need to test a bit. Our dma_addr_t has remained 32-bit so far
> because despite the fact that we've had routinely to deal with >32-bit
> physical addresses for MMIO, physical memory support has been
> constrained afaik to 32-bit.

Really?

The current dma_addr_t is:

#if defined(__powerpc64__) || defined(CONFIG_PHYS_64BIT)
typedef u64 dma_addr_t;
#else
typedef u32 dma_addr_t;
#endif
typedef u64 dma64_addr_t;


I think that this patch doesn't change anything. Or I miss something?

@@ -22,6 +22,9 @@ config WORD_SIZE
 config ARCH_PHYS_ADDR_T_64BIT
        def_bool PPC64 || PHYS_64BIT

+config ARCH_DMA_ADDR_T_64BIT
+       def_bool ARCH_PHYS_ADDR_T_64BIT
+
 config MMU
        bool
        default y
