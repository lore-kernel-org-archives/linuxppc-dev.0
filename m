Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yblGH0y8FzDqYg
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Nov 2017 22:12:23 +1100 (AEDT)
In-Reply-To: <20171109172740.19681-2-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Florian Weimer <fweimer@redhat.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [v2,
 1/5] powerpc/64s/hash: Fix 128TB-512TB virtual address boundary case
 allocation
Message-Id: <3yblGG320nz9rxl@ozlabs.org>
Date: Tue, 14 Nov 2017 22:12:21 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-11-09 at 17:27:36 UTC, Nicholas Piggin wrote:
> When allocating VA space with a hint that crosses 128TB, the SLB addr_limit
> variable is not expanded if addr is not > 128TB, but the slice allocation
> looks at task_size, which is 512TB. This results in slice_check_fit()
> incorrectly succeeding because the slice_count truncates off bit 128 of the
> requested mask, so the comparison to the available mask succeeds.
> 
> Fix this by using mm->context.addr_limit instead of mm->task_size for
> testing allocation limits. This causes such allocations to fail.
> 
> Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
> Fixes: f4ea6dcb08 ("powerpc/mm: Enable mappings above 128TB")
> Reported-by: Florian Weimer <fweimer@redhat.com>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/6a72dc038b615229a1b285829d6c83

cheers
