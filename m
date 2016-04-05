Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qfdd11kv7zDq6Y
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Apr 2016 05:06:44 +1000 (AEST)
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Tue, 5 Apr 2016 15:06:41 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 306BB6E805C
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Apr 2016 14:53:29 -0400 (EDT)
Received: from d01av05.pok.ibm.com (d01av05.pok.ibm.com [9.56.224.195])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u35J6dkL37617670
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 5 Apr 2016 19:06:39 GMT
Received: from d01av05.pok.ibm.com (localhost [127.0.0.1])
 by d01av05.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u35J0vmu029660
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 5 Apr 2016 15:00:57 -0400
Date: Tue, 5 Apr 2016 12:05:47 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org, James Dykman <jdykman@us.ibm.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH 1/1] powerpc/mm: Add memory barrier in __hugepte_alloc()
Message-ID: <20160405190547.GA12673@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>From f7b73c6b4508fe9b141a43d92be2f9dd7d3c4a58 Mon Sep 17 00:00:00 2001
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Date: Thu, 24 Mar 2016 02:07:57 -0400
Subject: [PATCH 1/1] powerpc/mm: Add memory barrier in __hugepte_alloc()

__hugepte_alloc() uses kmem_cache_zalloc() to allocate a zeroed PTE
and proceeds to use the newly allocated PTE. Add a memory barrier to
make sure that the other CPUs see a properly initialized PTE.

Based on a fix suggested by James Dykman.

Reported-by: James Dykman <jdykman@us.ibm.com>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Tested-by: James Dykman <jdykman@us.ibm.com>
---
Note:
	The bug was encountered and fix tested on an older version
	of the kernel. Forward porting to mainline.
---
 arch/powerpc/mm/hugetlbpage.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index d991b9e..081f679 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -81,6 +81,13 @@ static int __hugepte_alloc(struct mm_struct *mm, hugepd_t *hpdp,
 	if (! new)
 		return -ENOMEM;
 
+	/*
+	 * Make sure other cpus find the hugepd set only after a
+	 * properly initialized page table is visible to them.
+	 * For more details look for comment in __pte_alloc().
+	 */
+	smp_wmb();
+
 	spin_lock(&mm->page_table_lock);
 #ifdef CONFIG_PPC_FSL_BOOK3E
 	/*
-- 
1.8.3.1
