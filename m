Return-Path: <fujita.tomonori@lab.ntt.co.jp>
Received: from sh.osrg.net (sh.osrg.net [192.16.179.4])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7CE17B7D22
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Mar 2010 10:16:30 +1100 (EST)
Date: Wed, 17 Mar 2010 08:16:25 +0900
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: fix swiotlb to respect the boot option
From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Message-Id: <20100317081540C.fujita.tomonori@lab.ntt.co.jp>
Cc: albert_herranz@yahoo.es, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

powerpc initializes swiotlb before parsing the kernel boot options so
swiotlb options (e.g. specifying the swiotlb buffer size) are ignored.

Any time before freeing bootmem works for swiotlb so this patch moves
powerpc's swiotlb initialization after parsing the kernel boot
options, mem_init (as x86 does).

Signed-off-by: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Tested-by: Becky Bruce <beckyb@kernel.crashing.org>
---
 arch/powerpc/kernel/setup_32.c |    6 ------
 arch/powerpc/kernel/setup_64.c |    6 ------
 arch/powerpc/mm/mem.c          |    6 ++++++
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
index b152de3..8f58986 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -39,7 +39,6 @@
 #include <asm/serial.h>
 #include <asm/udbg.h>
 #include <asm/mmu_context.h>
-#include <asm/swiotlb.h>
 
 #include "setup.h"
 
@@ -343,11 +342,6 @@ void __init setup_arch(char **cmdline_p)
 		ppc_md.setup_arch();
 	if ( ppc_md.progress ) ppc_md.progress("arch: exit", 0x3eab);
 
-#ifdef CONFIG_SWIOTLB
-	if (ppc_swiotlb_enable)
-		swiotlb_init(1);
-#endif
-
 	paging_init();
 
 	/* Initialize the MMU context management stuff */
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 6354739..9143891 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -61,7 +61,6 @@
 #include <asm/xmon.h>
 #include <asm/udbg.h>
 #include <asm/kexec.h>
-#include <asm/swiotlb.h>
 #include <asm/mmu_context.h>
 
 #include "setup.h"
@@ -541,11 +540,6 @@ void __init setup_arch(char **cmdline_p)
 	if (ppc_md.setup_arch)
 		ppc_md.setup_arch();
 
-#ifdef CONFIG_SWIOTLB
-	if (ppc_swiotlb_enable)
-		swiotlb_init(1);
-#endif
-
 	paging_init();
 
 	/* Initialize the MMU context management stuff */
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 311224c..448f972 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -48,6 +48,7 @@
 #include <asm/sparsemem.h>
 #include <asm/vdso.h>
 #include <asm/fixmap.h>
+#include <asm/swiotlb.h>
 
 #include "mmu_decl.h"
 
@@ -320,6 +321,11 @@ void __init mem_init(void)
 	struct page *page;
 	unsigned long reservedpages = 0, codesize, initsize, datasize, bsssize;
 
+#ifdef CONFIG_SWIOTLB
+	if (ppc_swiotlb_enable)
+		swiotlb_init(1);
+#endif
+
 	num_physpages = lmb.memory.size >> PAGE_SHIFT;
 	high_memory = (void *) __va(max_low_pfn * PAGE_SIZE);
 
-- 
1.7.0
