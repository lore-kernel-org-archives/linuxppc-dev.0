Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C17441A00E9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Oct 2014 07:52:10 +1100 (AEDT)
Message-ID: <1414356641.364.142.camel@pasglop>
Subject: Re: [PATCH V2 1/2] mm: Update generic gup implementation to handle
 hugepage directory
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Date: Mon, 27 Oct 2014 07:50:41 +1100
In-Reply-To: <1414167761.19984.17.camel@jarvis.lan>
References: <1413520687-31729-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20141022160224.9c2268795e55d5a2eff5b94d@linux-foundation.org>
 <20141023.184035.388557314666522484.davem@davemloft.net>
 <1414107635.364.91.camel@pasglop> <1414167761.19984.17.camel@jarvis.lan>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: aarcange@redhat.com, linux-arch@vger.kernel.org, steve.capper@linaro.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 aneesh.kumar@linux.vnet.ibm.com, hannes@cmpxchg.org, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2014-10-24 at 09:22 -0700, James Bottomley wrote:

> Parisc does this.  As soon as one CPU issues a TLB purge, it's broadcast
> to all the CPUs on the inter-CPU bus.  The next instruction isn't
> executed until they respond.
> 
> But this is only for our CPU TLB.  There's no other external
> consequence, so removal from the page tables isn't effected by this TLB
> flush, therefore the theory on which Dave bases the change to
> atomic_add() should work for us (of course, atomic_add is lock add
> unlock on our CPU, so it's not going to be of much benefit).

I'm not sure I follow you here.

Do you or do you now perform an IPI to do TLB flushes ? If you don't
(for example because you have HW broadcast), then you need the
speculative get_page(). If you do (and can read a PTE atomically), you
can get away with atomic_add().

The reason is that if you remember how zap_pte_range works, we perform
the flush before we get rid of the page.

So if your using IPIs for the flush, the fact that gup_fast has
interrupts disabled will delay the IPI response and thus effectively
prevent the pages from being actually freed, allowing us to simply do
the atomic_add() on x86.

But if we don't use IPIs because we have HW broadcast of TLB
invalidations, then we don't have that synchronization. atomic_add won't
work, we need get_page_speculative() because the page could be
concurrently being freed.

Cheers,
Ben.

> James
> 
> > Another option would be to make the generic code use something defined
> > by the arch to decide whether to use speculative get or
> > not. I like the idea of keeping the bulk of that code generic...
> > 
> > Cheers,
> > Ben.
> > 
> > > --
> > > To unsubscribe, send a message with 'unsubscribe linux-mm' in
> > > the body to majordomo@kvack.org.  For more info on Linux MM,
> > > see: http://www.linux-mm.org/ .
> > > Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
> > 
> > 
> > --
> > To unsubscribe, send a message with 'unsubscribe linux-mm' in
> > the body to majordomo@kvack.org.  For more info on Linux MM,
> > see: http://www.linux-mm.org/ .
> > Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
> > 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
