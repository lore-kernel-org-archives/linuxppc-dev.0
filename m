Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40zxgl4mvmzF0gv
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jun 2018 00:11:31 +1000 (AEST)
In-Reply-To: <20180601082424.17393-1-aneesh.kumar@linux.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, benh@kernel.crashing.org,
 paulus@samba.org, npiggin@gmail.com
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: powerpc/mm/hugetlb: Update hugetlb related locks
Message-Id: <40zxgl009mz9s7V@ozlabs.org>
Date: Tue,  5 Jun 2018 00:11:30 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2018-06-01 at 08:24:24 UTC, "Aneesh Kumar K.V" wrote:
> With split pmd page table lock enabled, we don't use mm->page_table_lock when
> updating pmd entries. This patch update hugetlb path to use the right lock
> when inserting huge page directory entries into page table.
> 
> ex: if we are using hugepd and inserting hugepd entry at the pmd level, we
> use pmd_lockptr, which based on config can be split pmd lock.
> 
> For update huge page directory entries itself we use mm->page_table_lock. We
> do have a helper huge_pte_lockptr() for that.
> 
> Fixes: 675d99529 ("powerpc/book3s64: Enable split pmd ptlock")
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/ed515b6898c36775ddd99ff9ffeda4

cheers
