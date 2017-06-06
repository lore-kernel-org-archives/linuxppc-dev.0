Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3whgjV0vqNzDqKv
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Jun 2017 15:49:02 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: bsingharora@gmail.com,
	aneesh.kumar@linux.vnet.ibm.com
Subject: [PATCH] powerpc/mm/radix: Only add X for pages overlapping kernel text
Date: Tue,  6 Jun 2017 15:48:57 +1000
Message-Id: <1496728137-19655-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently we map the whole linear mapping with PAGE_KERNEL_X. Instead we
should check if the page overlaps the kernel text and only then add
PAGE_KERNEL_X.

Note that we still use 1G pages if they're available, so this will
typically still result in a 1G executable page at KERNELBASE. So this fix is
primarily useful for catching stray branches to high linear mapping addresses.

Without this patch, we can execute at 1G in xmon using:

  0:mon> m c000000040000000
  c000000040000000  00 l
  c000000040000000  00000000 01006038
  c000000040000004  00000000 2000804e
  c000000040000008  00000000 x
  0:mon> di c000000040000000
  c000000040000000  38600001      li      r3,1
  c000000040000004  4e800020      blr
  0:mon> p c000000040000000
  return value is 0x1

After we get a 400 as expected:

  0:mon> p c000000040000000
  *** 400 exception occurred

Fixes: 2bfd65e45e87 ("powerpc/mm/radix: Add radix callbacks for early init routines")
Cc: stable@vger.kernel.org # v4.7+
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/mm/pgtable-radix.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index c28165d8970b..6c062f92b9e4 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -19,6 +19,7 @@
 #include <asm/mmu.h>
 #include <asm/firmware.h>
 #include <asm/powernv.h>
+#include <asm/sections.h>
 
 #include <trace/events/thp.h>
 
@@ -121,7 +122,8 @@ static inline void __meminit print_mapping(unsigned long start,
 static int __meminit create_physical_mapping(unsigned long start,
 					     unsigned long end)
 {
-	unsigned long addr, mapping_size = 0;
+	unsigned long vaddr, addr, mapping_size = 0;
+	pgprot_t prot;
 
 	start = _ALIGN_UP(start, PAGE_SIZE);
 	for (addr = start; addr < end; addr += mapping_size) {
@@ -145,8 +147,14 @@ static int __meminit create_physical_mapping(unsigned long start,
 			start = addr;
 		}
 
-		rc = radix__map_kernel_page((unsigned long)__va(addr), addr,
-					    PAGE_KERNEL_X, mapping_size);
+		vaddr = (unsigned long)__va(addr);
+
+		if (overlaps_kernel_text(vaddr, vaddr + mapping_size))
+			prot = PAGE_KERNEL_X;
+		else
+			prot = PAGE_KERNEL;
+
+		rc = radix__map_kernel_page(vaddr, addr, prot, mapping_size);
 		if (rc)
 			return rc;
 	}
-- 
2.7.4
