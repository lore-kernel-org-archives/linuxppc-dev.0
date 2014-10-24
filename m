Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by lists.ozlabs.org (Postfix) with ESMTP id D2ABA1A0074
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Oct 2014 14:55:17 +1100 (AEDT)
Date: Thu, 23 Oct 2014 23:55:11 -0400 (EDT)
Message-Id: <20141023.235511.1672975903756808524.davem@davemloft.net>
To: benh@kernel.crashing.org
Subject: Re: [PATCH V2 1/2] mm: Update generic gup implementation to handle
 hugepage directory
From: David Miller <davem@davemloft.net>
In-Reply-To: <1414107635.364.91.camel@pasglop>
References: <20141022160224.9c2268795e55d5a2eff5b94d@linux-foundation.org>
 <20141023.184035.388557314666522484.davem@davemloft.net>
 <1414107635.364.91.camel@pasglop>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
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

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 24 Oct 2014 10:40:35 +1100

> Another option would be to make the generic code use something defined
> by the arch to decide whether to use speculative get or
> not. I like the idea of keeping the bulk of that code generic...

Me too.  We could have inlines that do either speculative or
non-speculative gets on the pages in some header file and hide
the ifdefs in there.
