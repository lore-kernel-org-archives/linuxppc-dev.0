Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rV5cc0LN4zDqjK
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jun 2016 22:37:04 +1000 (AEST)
In-Reply-To: <1465395958-21349-4-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [V2,
 03/10] powerpc/mm/radix: Flush page walk cache when freeing page table
Message-Id: <3rV5cb6mYpz9t1W@ozlabs.org>
Date: Wed, 15 Jun 2016 22:37:03 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-08-06 at 14:25:51 UTC, "Aneesh Kumar K.V" wrote:
> Even though a tlb_flush() does a flush with invalidate all cache,
> we can end up doing an RCU page table free before calling tlb_flush().
> That means we can have page walk cache entries even after we free the
> page table pages. This can result in us doing wrong page table walk.
> 
> Avoid this by doing pwc flush on every page table free. We can't batch
> the pwc flush, because the rcu call back function where we free the
> page table pages doesn't have information of the mmu gather. Thus we
> have to do a pwc on every page table page freed.
> 
> Note: I also removed the dummy tlb_flush_pgtable call functions for
> hash 32.
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/a145abf12c9f7d30d8c330c9d8

cheers
