Return-Path: <B07421@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe005.messaging.microsoft.com [207.46.163.28])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0EBEC2C00E4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Oct 2013 10:25:42 +1100 (EST)
Message-ID: <1381447532.7979.488.camel@snotra.buserror.net>
Subject: Re: [PATCH v2 1/3] powerpc/booke64: add sync after writing PTE
From: Scott Wood <scottwood@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 10 Oct 2013 18:25:32 -0500
In-Reply-To: <1381444273.7979.473.camel@snotra.buserror.net>
References: <1379130622-17436-1-git-send-email-scottwood@freescale.com>
 <1379281131.4098.48.camel@pasglop>
 <1379376371.2536.218.camel@snotra.buserror.net>
 <1381444273.7979.473.camel@snotra.buserror.net>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-10-10 at 17:31 -0500, Scott Wood wrote:
> On Mon, 2013-09-16 at 19:06 -0500, Scott Wood wrote:
> > On Mon, 2013-09-16 at 07:38 +1000, Benjamin Herrenschmidt wrote:
> > > On Fri, 2013-09-13 at 22:50 -0500, Scott Wood wrote:
> > > > The ISA says that a sync is needed to order a PTE write with a
> > > > subsequent hardware tablewalk lookup.  On e6500, without this sync
> > > > we've been observed to die with a DSI due to a PTE write not being seen
> > > > by a subsequent access, even when everything happens on the same
> > > > CPU.
> > > 
> > > This is gross, I didn't realize we had that bogosity in the
> > > architecture...
> > > 
> > > Did you measure the performance impact ?
> > 
> > I didn't see a noticeable impact on the tests I ran, but those were
> > aimed at measuring TLB miss overhead.  I'll need to try it with a
> > benchmark that's more oriented around lots of page table updates.
> 
> Lmbench's fork test runs about 2% slower with the sync.  I've been told
> that nothing relevant has changed since we saw the failure during
> emulation; it's probably luck and/or timing, or maybe a sync got added
> somewhere else since then?  I think it's only really a problem for
> kernel page tables, since user page tables will retry if do_page_fault()
> sees a valid PTE.  So maybe we should put an mb() in map_kernel_page()
> instead.

Looking at some of the code in mm/, I suspect that the normal callers of
set_pte_at() already have an unlock (and thus a sync) already, so we may
not even be relying on those retries.  Certainly some of them do; it
would take some effort to verify all of them.

Also, without such a sync in map_kernel_page(), even with software
tablewalk, couldn't we theoretically have a situation where a store to
pointer X that exposes a new mapping gets reordered before the PTE store
as seen by another CPU?  The other CPU could see non-NULL X and
dereference it, but get the stale PTE.  Callers of ioremap() generally
don't do a barrier of their own prior to exposing the result.

-Scott
