Return-Path: <npiggin@gmail.com>
Received: from mail-io0-x22c.google.com (mail-io0-x22c.google.com
 [IPv6:2607:f8b0:4001:c06::22c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wBCqn0ddszDq66
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Apr 2017 14:22:44 +1000 (AEST)
Received: by mail-io0-x22c.google.com with SMTP id a103so176455599ioj.1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Apr 2017 21:22:44 -0700 (PDT)
Date: Mon, 24 Apr 2017 14:22:18 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/64s: use
 ibm,tlbiel-congruence-classes-(hash|radix) dt property
Message-ID: <20170424141954.3b400f30@roar.ozlabs.ibm.com>
In-Reply-To: <1492992803.25766.193.camel@kernel.crashing.org>
References: <20170422005854.17128-1-npiggin@gmail.com>
 <20170422005854.17128-2-npiggin@gmail.com>
 <1492848130.25766.185.camel@kernel.crashing.org>
 <20170423091428.16fc298f@roar.ozlabs.ibm.com>
 <1492907951.25766.191.camel@kernel.crashing.org>
 <20170423195755.43e36953@roar.ozlabs.ibm.com>
 <1492992803.25766.193.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 24 Apr 2017 10:13:23 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Sun, 2017-04-23 at 19:57 +1000, Nicholas Piggin wrote:
> > On Sun, 23 Apr 2017 10:39:11 +1000
> > Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> >   
> > > On Sun, 2017-04-23 at 09:14 +1000, Nicholas Piggin wrote:  
> > > > I think we were going to take another look at moving the setup
> > > > code
> > > > later, but I think that might wait until 4.13.    
> > > 
> > > Except without that we won't boot a post-P9 CPU right ? So we'll
> > > end up
> > > having to chase distros to backport it :-( Oh well...  
> > 
> > Okay, well what if we just move the TLB flushing to somewhere like
> > early_init_mmu(_secondary) for power CPUs first?
> > 
> > Non-local tlbie does not seem to have this requirement, so would it
> > make it more robust just to execute that once during boot with the
> > primary thread?  
> 
> I wouldn't do a broadcast before we have LPCR setup... but for no
> obvious reason. Also I'm not sure our boot time cleanup does things
> properly vs hash & radix. I think we really need 2 passes.
> 
> Oh well..
> 
> My main worry is the fact that on future chip we won't be setting up
> LPCR properly. We should at least assume an unknown chip is P9, is that
> what you do with your cpu-features patches ?

cpu-features patches set up LPCR based on ISAv3 compatible MMU property
(among other things). In case that does not match, we currently don't do
anything graceful.

Actually those patches I think are missing the TLB flush though, which
I will add as a per-cpu local flush in the MMU setup path.
