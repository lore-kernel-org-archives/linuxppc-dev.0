Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by lists.ozlabs.org (Postfix) with ESMTP id C59331A015A
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Oct 2014 09:40:59 +1100 (AEDT)
Date: Thu, 23 Oct 2014 18:40:35 -0400 (EDT)
Message-Id: <20141023.184035.388557314666522484.davem@davemloft.net>
To: akpm@linux-foundation.org
Subject: Re: [PATCH V2 1/2] mm: Update generic gup implementation to handle
 hugepage directory
From: David Miller <davem@davemloft.net>
In-Reply-To: <20141022160224.9c2268795e55d5a2eff5b94d@linux-foundation.org>
References: <1413520687-31729-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20141022160224.9c2268795e55d5a2eff5b94d@linux-foundation.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: aarcange@redhat.com, linux-arch@vger.kernel.org, steve.capper@linaro.org,
 hannes@cmpxchg.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 aneesh.kumar@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hey guys, was looking over the generic GUP while working on a sparc64
issue and I noticed that you guys do speculative page gets, and after
talking with Johannes Weiner (CC:'d) about this we don't see how it
could be necessary.

If interrupts are disabled during the page table scan (which they
are), no IPI tlb flushes can arrive.  Therefore any removal from the
page tables is guarded by interrupts being re-enabled.  And as a
result, page counts of pages we see in the page tables must always
have a count > 0.

x86 does direct atomic_add() on &page->_count because of this
invariant and I would rather see the generic version do this too.
