Return-Path: <tony@bakeyournoodle.com>
Received: from pythia.bakeyournoodle.com (pythia.bakeyournoodle.com
	[203.82.209.197]) by ozlabs.org (Postfix) with ESMTP id 72B70DDE28
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Jul 2008 11:30:02 +1000 (EST)
To: Paul Mackerras <paulus@samba.org>, <linuxppc-dev@ozlabs.org>
Message-Id: <ee4b4da609da3b2e94f484a0124ed3f8cdfffee6.1214875806.git.tony@bakeyournoodle.com>
From: Tony Breeds <tony@bakeyournoodle.com>
Subject: [PATCH 1/1] Fix Building of arch/powerpc/mm/mem.o when
	MEMORY_HOTPLUG=y and SPARSEMEM=n
Date: Tue,  1 Jul 2008 11:30:06 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Currently the kernel fails to build with the above config options with:
  CC      arch/powerpc/mm/mem.o
arch/powerpc/mm/mem.c: In function 'arch_add_memory':
arch/powerpc/mm/mem.c:130: error: implicit declaration of function 'create_section_mapping'

This patch explicitly includes asm/sparsemem.h in arch/powerpc/mm/mem.c and
moves the guards in include/asm-powerpc/sparsemem.h to protect the
SPARSEMEM specific portions only.

Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>
---
 arch/powerpc/mm/mem.c           |    1 +
 include/asm-powerpc/sparsemem.h |    4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 51f82d8..776ba6a 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -44,6 +44,7 @@
 #include <asm/btext.h>
 #include <asm/tlb.h>
 #include <asm/sections.h>
+#include <asm/sparsemem.h>
 #include <asm/vdso.h>
 #include <asm/fixmap.h>
 
diff --git a/include/asm-powerpc/sparsemem.h b/include/asm-powerpc/sparsemem.h
index 9aea8e9..54a47ea 100644
--- a/include/asm-powerpc/sparsemem.h
+++ b/include/asm-powerpc/sparsemem.h
@@ -13,6 +13,8 @@
 #define MAX_PHYSADDR_BITS       44
 #define MAX_PHYSMEM_BITS        44
 
+#endif /* CONFIG_SPARSEMEM */
+
 #ifdef CONFIG_MEMORY_HOTPLUG
 extern void create_section_mapping(unsigned long start, unsigned long end);
 extern int remove_section_mapping(unsigned long start, unsigned long end);
@@ -26,7 +28,5 @@ static inline int hot_add_scn_to_nid(unsigned long scn_addr)
 #endif /* CONFIG_NUMA */
 #endif /* CONFIG_MEMORY_HOTPLUG */
 
-#endif /* CONFIG_SPARSEMEM */
-
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_SPARSEMEM_H */
-- 
1.5.6
