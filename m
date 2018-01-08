Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zFdFw3k6XzF0Zn
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Jan 2018 01:39:32 +1100 (AEDT)
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/mm: Fix growth direction for hugepages mmaps with
 slice
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Message-Id: <20180108143920.091256E955@localhost.localdomain>
Date: Mon,  8 Jan 2018 15:39:19 +0100 (CET)
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
 arch/powerpc/mm/hugetlbpage.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index 5c5873259127..76330a976f9e 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -558,7 +558,8 @@ unsigned long hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
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
