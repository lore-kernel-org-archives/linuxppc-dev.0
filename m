Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zG7Q22qZ2zF0QT
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Jan 2018 21:18:18 +1100 (AEDT)
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2] powerpc/mm: Fix growth direction for hugepages mmaps with
 slice
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Message-Id: <20180109101810.2471D6C6CF@localhost.localdomain>
Date: Tue,  9 Jan 2018 11:18:10 +0100 (CET)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

An application running with libhugetlbfs fails to allocate
additional pages to HEAP due to the hugemap being done
inconditionally as topdown mapping:

mmap(0x10080000, 1572864, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS|0x40000, -1, 0) = 0x73e80000
[...]
mmap(0x74000000, 1048576, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS|0x40000, -1, 0x180000) = 0x73d80000
munmap(0x73d80000, 1048576)             = 0
[...]
mmap(0x74000000, 1572864, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS|0x40000, -1, 0x180000) = 0x73d00000
munmap(0x73d00000, 1572864)             = 0
[...]
mmap(0x74000000, 1572864, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS|0x40000, -1, 0x180000) = 0x73d00000
munmap(0x73d00000, 1572864)             = 0
[...]

As one can see from the above strace log, mmap() allocates further
pages below the initial one.

This patch fixes it by taking into account MAP_GROWSDOWN flag.

Fixes: d0f13e3c20b6f ("[POWERPC] Introduce address space "slices" ")
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 v2: Added missing include

 arch/powerpc/mm/hugetlbpage.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index 79e1378ee303..0eadf9f199de 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -19,6 +19,7 @@
 #include <linux/moduleparam.h>
 #include <linux/swap.h>
 #include <linux/swapops.h>
+#include <linux/mman.h>
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
 #include <asm/tlb.h>
@@ -558,7 +559,8 @@ unsigned long hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
 		return radix__hugetlb_get_unmapped_area(file, addr, len,
 						       pgoff, flags);
 #endif
-	return slice_get_unmapped_area(addr, len, flags, mmu_psize, 1);
+	return slice_get_unmapped_area(addr, len, flags, mmu_psize,
+				       flags & MAP_GROWSDOWN);
 }
 #endif
 
-- 
2.13.3
