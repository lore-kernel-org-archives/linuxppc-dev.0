Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6175C1A02B3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Oct 2014 10:41:29 +1100 (AEDT)
Message-ID: <1414107635.364.91.camel@pasglop>
Subject: Re: [PATCH V2 1/2] mm: Update generic gup implementation to handle
 hugepage directory
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Miller <davem@davemloft.net>
Date: Fri, 24 Oct 2014 10:40:35 +1100
In-Reply-To: <20141023.184035.388557314666522484.davem@davemloft.net>
References: <1413520687-31729-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20141022160224.9c2268795e55d5a2eff5b94d@linux-foundation.org>
 <20141023.184035.388557314666522484.davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: aarcange@redhat.com, linux-arch@vger.kernel.org, steve.capper@linaro.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 aneesh.kumar@linux.vnet.ibm.com, hannes@cmpxchg.org, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-10-23 at 18:40 -0400, David Miller wrote:
> Hey guys, was looking over the generic GUP while working on a sparc64
> issue and I noticed that you guys do speculative page gets, and after
> talking with Johannes Weiner (CC:'d) about this we don't see how it
> could be necessary.
> 
> If interrupts are disabled during the page table scan (which they
> are), no IPI tlb flushes can arrive.  Therefore any removal from the
> page tables is guarded by interrupts being re-enabled.  And as a
> result, page counts of pages we see in the page tables must always
> have a count > 0.
> 
> x86 does direct atomic_add() on &page->_count because of this
> invariant and I would rather see the generic version do this too.

This is of course only true of archs who use IPIs for TLB flushes, so if
we are going down the path of not being speculative, powerpc would have
to go back to doing its own since our broadcast TLB flush means we
aren't protected (we are only protected vs. the page tables themselves
being freed since we do that via sched RCU).

AFAIK, ARM also broadcasts TLB flushes...

Another option would be to make the generic code use something defined
by the arch to decide whether to use speculative get or
not. I like the idea of keeping the bulk of that code generic...

Cheers,
Ben.

> --
> To unsubscribe, send a message with 'unsubscribe linux-mm' in
> the body to majordomo@kvack.org.  For more info on Linux MM,
> see: http://www.linux-mm.org/ .
> Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
