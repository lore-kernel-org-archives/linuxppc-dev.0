Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vNblR3HB3zDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Feb 2017 21:54:43 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/mm: Fix build break with BOOK3S_64=n and
 MEMORY_HOTPLUG=y
Date: Wed, 15 Feb 2017 21:54:37 +1100
Message-Id: <1487156077-30798-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The recently merged HPT (Hash Page Table) resize support broke the build
when BOOK3S_64=n (ie. 32-bit or 64-bit Book3E) and MEMORY_HOTPLUG=y:

  arch/powerpc/mm/mem.o: In function `.arch_add_memory':
  (.text+0x4e4): undefined reference to `.resize_hpt_for_hotplug'

Fix it by adding a dummy version.

Fixes: 438cc81a41e8 ("powerpc/pseries: Automatically resize HPT for memory hot add/remove")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/sparsemem.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/sparsemem.h b/arch/powerpc/include/asm/sparsemem.h
index 737335c891e4..c88930c9db7f 100644
--- a/arch/powerpc/include/asm/sparsemem.h
+++ b/arch/powerpc/include/asm/sparsemem.h
@@ -16,9 +16,15 @@
 #endif /* CONFIG_SPARSEMEM */
 
 #ifdef CONFIG_MEMORY_HOTPLUG
-extern void resize_hpt_for_hotplug(unsigned long new_mem_size);
 extern int create_section_mapping(unsigned long start, unsigned long end);
 extern int remove_section_mapping(unsigned long start, unsigned long end);
+
+#ifdef CONFIG_PPC_BOOK3S_64
+extern void resize_hpt_for_hotplug(unsigned long new_mem_size);
+#else
+static inline void resize_hpt_for_hotplug(unsigned long new_mem_size) { }
+#endif
+
 #ifdef CONFIG_NUMA
 extern int hot_add_scn_to_nid(unsigned long scn_addr);
 #else
-- 
2.7.4
