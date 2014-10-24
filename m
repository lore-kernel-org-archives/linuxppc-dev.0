Return-Path: <James.Bottomley@HansenPartnership.com>
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com
 [66.63.167.143])
 by lists.ozlabs.org (Postfix) with ESMTP id 71BE31A01C7
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Oct 2014 03:22:45 +1100 (AEDT)
Message-ID: <1414167761.19984.17.camel@jarvis.lan>
Subject: Re: [PATCH V2 1/2] mm: Update generic gup implementation to handle
 hugepage directory
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 24 Oct 2014 09:22:41 -0700
In-Reply-To: <1414107635.364.91.camel@pasglop>
References: <1413520687-31729-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20141022160224.9c2268795e55d5a2eff5b94d@linux-foundation.org>
 <20141023.184035.388557314666522484.davem@davemloft.net>
 <1414107635.364.91.camel@pasglop>
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

On Fri, 2014-10-24 at 10:40 +1100, Benjamin Herrenschmidt wrote:
> On Thu, 2014-10-23 at 18:40 -0400, David Miller wrote:
> > Hey guys, was looking over the generic GUP while working on a sparc64
> > issue and I noticed that you guys do speculative page gets, and after
> > talking with Johannes Weiner (CC:'d) about this we don't see how it
> > could be necessary.
> > 
> > If interrupts are disabled during the page table scan (which they
> > are), no IPI tlb flushes can arrive.  Therefore any removal from the
> > page tables is guarded by interrupts being re-enabled.  And as a
> > result, page counts of pages we see in the page tables must always
> > have a count > 0.
> > 
> > x86 does direct atomic_add() on &page->_count because of this
> > invariant and I would rather see the generic version do this too.
> 
> This is of course only true of archs who use IPIs for TLB flushes, so if
> we are going down the path of not being speculative, powerpc would have
> to go back to doing its own since our broadcast TLB flush means we
> aren't protected (we are only protected vs. the page tables themselves
> being freed since we do that via sched RCU).
> 
> AFAIK, ARM also broadcasts TLB flushes...

Parisc does this.  As soon as one CPU issues a TLB purge, it's broadcast
to all the CPUs on the inter-CPU bus.  The next instruction isn't
executed until they respond.

But this is only for our CPU TLB.  There's no other external
consequence, so removal from the page tables isn't effected by this TLB
flush, therefore the theory on which Dave bases the change to
atomic_add() should work for us (of course, atomic_add is lock add
unlock on our CPU, so it's not going to be of much benefit).

James

> Another option would be to make the generic code use something defined
> by the arch to decide whether to use speculative get or
> not. I like the idea of keeping the bulk of that code generic...
> 
> Cheers,
> Ben.
> 
> > --
> > To unsubscribe, send a message with 'unsubscribe linux-mm' in
> > the body to majordomo@kvack.org.  For more info on Linux MM,
> > see: http://www.linux-mm.org/ .
> > Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
> 
> 
> --
> To unsubscribe, send a message with 'unsubscribe linux-mm' in
> the body to majordomo@kvack.org.  For more info on Linux MM,
> see: http://www.linux-mm.org/ .
> Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
> 
