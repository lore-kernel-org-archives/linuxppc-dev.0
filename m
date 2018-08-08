Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41ltww2dnVzDqhV
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Aug 2018 00:26:24 +1000 (AEST)
In-Reply-To: <20180727114817.27190-1-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Nicholas Piggin <npiggin@gmail.com>, linux-mm@kvack.org
Subject: Re: [resend] powerpc/64s: fix page table fragment refcount race vs
 speculative references
Message-Id: <41ltwv4RJjz9s4V@ozlabs.org>
Date: Thu,  9 Aug 2018 00:26:10 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2018-07-27 at 11:48:17 UTC, Nicholas Piggin wrote:
> The page table fragment allocator uses the main page refcount racily
> with respect to speculative references. A customer observed a BUG due
> to page table page refcount underflow in the fragment allocator. This
> can be caused by the fragment allocator set_page_count stomping on a
> speculative reference, and then the speculative failure handler
> decrements the new reference, and the underflow eventually pops when
> the page tables are freed.
> 
> Fix this by using a dedicated field in the struct page for the page
> table fragment allocator.
> 
> Fixes: 5c1f6ee9a31c ("powerpc: Reduce PTE table memory wastage")
> Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/4231aba000f5a4583dd9f67057aadb

cheers
