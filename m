Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 65CFF2C0337
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Oct 2013 09:34:21 +1100 (EST)
Message-ID: <1381530853.5630.94.camel@pasglop>
Subject: Re: [PATCH v2 1/3] powerpc/booke64: add sync after writing PTE
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
Date: Sat, 12 Oct 2013 09:34:13 +1100
In-Reply-To: <1381529267.7979.582.camel@snotra.buserror.net>
References: <1379130622-17436-1-git-send-email-scottwood@freescale.com>
 <1379281131.4098.48.camel@pasglop>
 <1379376371.2536.218.camel@snotra.buserror.net>
 <1381444273.7979.473.camel@snotra.buserror.net>
 <1381447532.7979.488.camel@snotra.buserror.net>
 <1381449086.5630.42.camel@pasglop>
 <1381529267.7979.582.camel@snotra.buserror.net>
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

On Fri, 2013-10-11 at 17:07 -0500, Scott Wood wrote:
> On Fri, 2013-10-11 at 10:51 +1100, Benjamin Herrenschmidt wrote:
> > On Thu, 2013-10-10 at 18:25 -0500, Scott Wood wrote:
> > 
> > > Looking at some of the code in mm/, I suspect that the normal callers of
> > > set_pte_at() already have an unlock (and thus a sync) 
> > 
> > Unlock is lwsync actually...
> 
> Oops, I was seeing the conditional sync from SYNC_IO in the disassembly.
> BTW, it's a bug that we don't do SYNC_IO on e500mc -- the assumption
> that lwsync is 64-bit-only is no longer true.

Patch welcome :)

> > > already, so we may
> > > not even be relying on those retries.  Certainly some of them do; it
> > > would take some effort to verify all of them.
> > > 
> > > Also, without such a sync in map_kernel_page(), even with software
> > > tablewalk, couldn't we theoretically have a situation where a store to
> > > pointer X that exposes a new mapping gets reordered before the PTE store
> > > as seen by another CPU?  The other CPU could see non-NULL X and
> > > dereference it, but get the stale PTE.  Callers of ioremap() generally
> > > don't do a barrier of their own prior to exposing the result.
> > 
> > Hrm, we transition to the new PTE either restricts the access permission
> > in which case it flushes the TLB (and synchronizes with other CPUs) or
> > extends access (adds dirty, set pte from 0 -> populated, ...) in which
> > case the worst case is we see the old one and take a spurrious fault.
> 
> Yes, and the lwsync is good enough for software reading the PTE.  So it
> becomes a question of how much spurious faults with hardware tablewalk
> hurt performance, and at least for the lmbench fork test, the sync is
> worse (or maybe lwsync happens to be good enough for hw tablewalk on
> e6500?).
> 
> > So the problem would only be with kernel mappings and in that case I
> > think we are fine. A driver doing an ioremap shouldn't then start using
> > that mapping on another CPU before having *informed* that other CPU of
> > the existence of the mapping and that should be ordered.
> 
> But are callers of ioremap() expected to use a barrier before exposing
> the pointer (and what type)?  I don't think that's common practice.
> 
> map_kernel_page() should not be performance critical, so it shouldn't be
> a big deal to put mb() in there.

Yup, go for it.

Cheers,
Ben.

> -Scott
> 
> 
