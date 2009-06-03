Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 03 Jun 2009 17:16:38 +1000
Subject: [PATCH] powerpc: Set init_bootmem_done on NUMA platforms as well
Message-Id: <20090603071653.8E1B7DDDF7@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

For some obscure reason, we only set init_bootmem_done after initializing
bootmem when NUMA isn't enabled. We even document this next to the declaration
of that global in system.h which of course I didn't read before I had to
debug why some WIP code wasn't working properly...

This patch changes it so that we always set it after bootmem is initialized
which should have always been the case... go figure !

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/include/asm/system.h |    2 +-
 arch/powerpc/mm/numa.c            |    2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

--- linux-work.orig/arch/powerpc/include/asm/system.h	2009-06-03 17:12:48.000000000 +1000
+++ linux-work/arch/powerpc/include/asm/system.h	2009-06-03 17:12:51.000000000 +1000
@@ -211,7 +211,7 @@ extern struct task_struct *_switch(struc
 
 extern unsigned int rtas_data;
 extern int mem_init_done;	/* set on boot once kmalloc can be called */
-extern int init_bootmem_done;	/* set on !NUMA once bootmem is available */
+extern int init_bootmem_done;	/* set once bootmem is available */
 extern phys_addr_t memory_limit;
 extern unsigned long klimit;
 
Index: linux-work/arch/powerpc/mm/numa.c
===================================================================
--- linux-work.orig/arch/powerpc/mm/numa.c	2009-06-03 17:12:21.000000000 +1000
+++ linux-work/arch/powerpc/mm/numa.c	2009-06-03 17:12:25.000000000 +1000
@@ -981,6 +981,8 @@ void __init do_init_bootmem(void)
 		mark_reserved_regions_for_nid(nid);
 		sparse_memory_present_with_active_regions(nid);
 	}
+
+	init_bootmem_done = 1;
 }
 
 void __init paging_init(void)
