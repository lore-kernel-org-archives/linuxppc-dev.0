Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x230.google.com (mail-pf0-x230.google.com
 [IPv6:2607:f8b0:400e:c00::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wG4MK1J9gzDqCv
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Apr 2017 20:59:57 +1000 (AEST)
Received: by mail-pf0-x230.google.com with SMTP id q20so11802193pfg.0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Apr 2017 03:59:57 -0700 (PDT)
Date: Sun, 30 Apr 2017 20:59:37 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/64s: use
 ibm,tlbiel-congruence-classes-(hash|radix) dt property
Message-ID: <20170430205937.47b49a1e@roar.ozlabs.ibm.com>
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

I'm just trying to look at the best thing to do for this. In fact we
already do broadcast tlbie before all CPUs have their LPCR and other
MMU related registers all set up properly (e.g., in update_hid_for_radix
/ hash and radix_init_pgtable).

I was looking at doing a local TLB flush for appropriate machine and MMU
mode right at the end of early_init_mmu/early_init_mmu_secondary, so
after all registers are set, but before relocation is switched on.

Would that be preferable for you? For the next release at least we would
just leave in existing earlier flushes too, I guess.

Thanks,
Nick
