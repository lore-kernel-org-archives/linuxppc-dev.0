Return-Path: <rashmica.g@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w1YQW6YNXzDq7Z
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Apr 2017 12:04:19 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id 79so23819584pgf.0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 09 Apr 2017 19:04:19 -0700 (PDT)
From: Rashmica Gupta <rashmica.g@gmail.com>
To: linuxppc-dev@lists.ozlabs.org,
	mpe@ellerman.id.au
Cc: Rashmica Gupta <rashmica.g@gmail.com>
Subject: [PATCH] powerpc/mm: Dump hash table
Date: Mon, 10 Apr 2017 12:04:04 +1000
Message-Id: <20170410020404.11375-1-rashmica.g@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Current behaviour assumes that memory in RAM is contiguous and
iterates from the start of RAM to (start + size of memory). When the
memory isn't physically contiguous, this approach doesn't work.

If memory exists at 0-5 GB and 6-10 GB then the current approach will
check if entries exist in the hash table from 0GB to 9GB. This patch
changes the behaviour to iterate up to the end of RAM.

Signed-off-by: Rashmica Gupta <rashmica.g@gmail.com>
---
 arch/powerpc/mm/dump_hashpagetable.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/dump_hashpagetable.c b/arch/powerpc/mm/dump_hashpagetable.c
index d979709..ee07398 100644
--- a/arch/powerpc/mm/dump_hashpagetable.c
+++ b/arch/powerpc/mm/dump_hashpagetable.c
@@ -468,7 +468,7 @@ static void walk_linearmapping(struct pg_state *st)
 	unsigned long psize = 1 << mmu_psize_defs[mmu_linear_psize].shift;
 
 	for (addr = PAGE_OFFSET; addr < PAGE_OFFSET +
-			memblock_phys_mem_size(); addr += psize)
+			memblock_end_of_DRAM(); addr += psize)
 		hpte_find(st, addr, mmu_linear_psize);
 }
 
-- 
2.9.3
