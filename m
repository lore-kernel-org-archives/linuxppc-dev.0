Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 3A4F4B70B0
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  3 Sep 2009 19:57:37 +1000 (EST)
Subject: Re: AW: PowerPC PCI DMA issues (prefetch/coherency?)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Chris Pringle <chris.pringle@oxtel.com>
In-Reply-To: <4A9F78AF.4010206@oxtel.com>
References: <1251926572.10090.17.camel@Adam>  <4A9F78AF.4010206@oxtel.com>
Content-Type: text/plain
Date: Thu, 03 Sep 2009 19:57:29 +1000
Message-Id: <1251971849.15089.28.camel@pasglop>
Mime-Version: 1.0
Cc: Tom Burns <tburns@datacast.com>, Andrea Zypchen <azypchen@intldata.ca>,
	linuxppc-dev@lists.ozlabs.org, azilkie@datacast.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2009-09-03 at 09:05 +0100, Chris Pringle wrote:
> Hi Adam,
> 
> If you have a look in include/asm-ppc/pgtable.h for the following section:
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

I have some doubts about the usefulness of doing that for 4xx. AFAIK,
the 440 core just ignores M.

The problem lies probably elsewhere. Maybe the L2 cache coherency isn't
enabled or not working ?

The L1 cache on 440 is simply not coherent, so drivers have to make sure
they use the appropriate DMA APIs which will do cache flushing when
needed.

Adam, what driver is causing you that sort of problems ?

Cheers,
Ben.
