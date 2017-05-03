Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [184.105.139.130])
 by lists.ozlabs.org (Postfix) with ESMTP id 3wJ0zc0JxqzDqBH
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 May 2017 00:34:33 +1000 (AEST)
Date: Wed, 03 May 2017 10:34:28 -0400 (EDT)
Message-Id: <20170503.103428.1598887340082574002.davem@davemloft.net>
To: pasha.tatashin@oracle.com
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
 heiko.carstens@de.ibm.com, willy@infradead.org
Subject: Re: [v2 3/5] mm: add "zero" argument to vmemmap allocators
From: David Miller <davem@davemloft.net>
In-Reply-To: <1490383192-981017-4-git-send-email-pasha.tatashin@oracle.com>
References: <1490383192-981017-1-git-send-email-pasha.tatashin@oracle.com>
 <1490383192-981017-4-git-send-email-pasha.tatashin@oracle.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Fri, 24 Mar 2017 15:19:50 -0400

> Allow clients to request non-zeroed memory from vmemmap allocator.
> The following two public function have a new boolean argument called zero:
> 
> __vmemmap_alloc_block_buf()
> vmemmap_alloc_block()
> 
> When zero is true, memory that is allocated by memblock allocator is zeroed
> (the current behavior), when argument is false, the memory is not zeroed.
> 
> This change allows for optimizations where client knows when it is better
> to zero memory: may be later when other CPUs are started, or may be client
> is going to set every byte in the allocated memory, so no need to zero
> memory beforehand.
> 
> Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
> Reviewed-by: Shannon Nelson <shannon.nelson@oracle.com>

I think when you add a new argument that can adjust behavior, you
should add the new argument but retain exactly the current behavior in
the existing calls.

Then later you can piece by piece change behavior, and document properly
in the commit message what is happening and why the transformation is
legal.

Here, you are adding the new boolean to __earlyonly_bootmem_alloc() and
then making sparse_mem_maps_populate_node() pass false, which changes
behavior such that it doesn't get zero'd memory any more.

Please make one change at a time.  Otherwise review and bisection is
going to be difficult.
