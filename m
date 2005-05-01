Return-Path: <sneakums@zork.net>
Received: from zork.zork.net (zork.zork.net [64.81.246.102])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 82F0267A07
	for <linuxppc-dev@ozlabs.org>; Mon,  2 May 2005 01:36:57 +1000 (EST)
From: Sean Neakums <sneakums@zork.net>
To: Andrew Morton <akpm@osdl.org>
References: <20050430164303.6538f47c.akpm@osdl.org>
Date: Sun, 01 May 2005 16:08:25 +0100
In-Reply-To: <20050430164303.6538f47c.akpm@osdl.org> (Andrew Morton's message
	of "Sat, 30 Apr 2005 16:43:03 -0700")
Message-ID: <6uu0lnf0gm.fsf@zork.zork.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: 2.6.12-rc3-mm2: ppc pte_offset_map()
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On my Mackertosh (PowerBook5.4), build fails with the following:

  fs/proc/task_mmu.c: In function `smaps_pte_range':
  fs/proc/task_mmu.c:177: warning: implicit declaration of function `kmap_atomic'
  fs/proc/task_mmu.c:177: error: `KM_PTE0' undeclared (first use in this function)
  fs/proc/task_mmu.c:177: error: (Each undeclared identifier is reported only once
  fs/proc/task_mmu.c:177: error: for each function it appears in.)
  fs/proc/task_mmu.c:207: warning: implicit declaration of function `kunmap_atomic'

With the naive patch below, it builds with this warning and everything works.

  fs/proc/task_mmu.c: In function `smaps_pte_range':
  fs/proc/task_mmu.c:208: warning: passing arg 1 of `kunmap_atomic' makes pointer from integer without a cast

I tried including linux/highmem.h in asm-ppc/pgtable.h
(smaps_pte_range() -> pte_offset_map() -> kmap_atomic()), but that
doesn't work.


--- S12-rc3-mm2/fs/proc/task_mmu.c~	2005-05-01 15:52:55.000000000 +0100
+++ S12-rc3-mm2/fs/proc/task_mmu.c	2005-05-01 15:23:22.000000000 +0100
@@ -1,4 +1,5 @@
 #include <linux/mm.h>
+#include <linux/highmem.h>
 #include <linux/hugetlb.h>
 #include <linux/mount.h>
 #include <linux/seq_file.h>


-- 
Dag vijandelijk luchtschip de huismeester is dood
