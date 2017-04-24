Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wB6Jd1777zDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Apr 2017 10:13:52 +1000 (AEST)
Message-ID: <1492992803.25766.193.camel@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/64s: use
 ibm,tlbiel-congruence-classes-(hash|radix) dt property
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
Date: Mon, 24 Apr 2017 10:13:23 +1000
In-Reply-To: <20170423195755.43e36953@roar.ozlabs.ibm.com>
References: <20170422005854.17128-1-npiggin@gmail.com>
 <20170422005854.17128-2-npiggin@gmail.com>
 <1492848130.25766.185.camel@kernel.crashing.org>
 <20170423091428.16fc298f@roar.ozlabs.ibm.com>
 <1492907951.25766.191.camel@kernel.crashing.org>
 <20170423195755.43e36953@roar.ozlabs.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2017-04-23 at 19:57 +1000, Nicholas Piggin wrote:
> On Sun, 23 Apr 2017 10:39:11 +1000
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> 
> > On Sun, 2017-04-23 at 09:14 +1000, Nicholas Piggin wrote:
> > > I think we were going to take another look at moving the setup
> > > code
> > > later, but I think that might wait until 4.13.  
> > 
> > Except without that we won't boot a post-P9 CPU right ? So we'll
> > end up
> > having to chase distros to backport it :-( Oh well...
> 
> Okay, well what if we just move the TLB flushing to somewhere like
> early_init_mmu(_secondary) for power CPUs first?
> 
> Non-local tlbie does not seem to have this requirement, so would it
> make it more robust just to execute that once during boot with the
> primary thread?

I wouldn't do a broadcast before we have LPCR setup... but for no
obvious reason. Also I'm not sure our boot time cleanup does things
properly vs hash & radix. I think we really need 2 passes.

Oh well..

My main worry is the fact that on future chip we won't be setting up
LPCR properly. We should at least assume an unknown chip is P9, is that
what you do with your cpu-features patches ?

Cheers,
Ben.
