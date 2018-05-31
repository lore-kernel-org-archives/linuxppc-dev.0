Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40xF3w683MzDrnR
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 May 2018 14:34:36 +1000 (AEST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH 04/11] powerpc/prom_init: Replace __initdata with
 __prombss when applicable
Date: Thu, 31 May 2018 14:33:42 +1000
Message-Id: <20180531043349.24783-5-benh@kernel.crashing.org>
In-Reply-To: <20180531043349.24783-1-benh@kernel.crashing.org>
References: <20180531043349.24783-1-benh@kernel.crashing.org>
Reply-To: [RFC.PATCH.00/11]prom_init.cleanups.and.sanitization@gate.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This replaces all occurrences of __initdata for uninitialized
data with a new __prombss

Currently __promdata is defined to be __initdata but we'll
eventually change that.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/prom_init.c | 55 +++++++++++++++++----------------
 1 file changed, 29 insertions(+), 26 deletions(-)

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index 860d2dbb6634..d60feccf4b27 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -49,6 +49,9 @@
 
 #include <linux/linux_logo.h>
 
+/* All of prom_init bss lives here */
+#define __prombss __initdata
+
 /*
  * Eventually bump that one up
  */
@@ -88,7 +91,7 @@
 #define OF_WORKAROUNDS	0
 #else
 #define OF_WORKAROUNDS	of_workarounds
-static int of_workarounds __promdata;
+static int of_workarounds __prombss;
 #endif
 
 #define OF_WA_CLAIM	1	/* do phys/virt claim separately, then map */
@@ -149,26 +152,26 @@ extern void copy_and_flush(unsigned long dest, unsigned long src,
 			   unsigned long size, unsigned long offset);
 
 /* prom structure */
-static struct prom_t __initdata prom;
+static struct prom_t __prombss prom;
 
-static unsigned long prom_entry __initdata;
+static unsigned long __prombss prom_entry;
 
 #define PROM_SCRATCH_SIZE 256
 
-static char __initdata of_stdout_device[256];
-static char __initdata prom_scratch[PROM_SCRATCH_SIZE];
+static char __prombss of_stdout_device[256];
+static char __prombss prom_scratch[PROM_SCRATCH_SIZE];
 
-static unsigned long __initdata dt_header_start;
-static unsigned long __initdata dt_struct_start, dt_struct_end;
-static unsigned long __initdata dt_string_start, dt_string_end;
+static unsigned long __prombss dt_header_start;
+static unsigned long __prombss dt_struct_start, dt_struct_end;
+static unsigned long __prombss dt_string_start, dt_string_end;
 
-static unsigned long __initdata prom_initrd_start, prom_initrd_end;
+static unsigned long __prombss prom_initrd_start, prom_initrd_end;
 
 #ifdef CONFIG_PPC64
-static int __initdata prom_iommu_force_on;
-static int __initdata prom_iommu_off;
-static unsigned long __initdata prom_tce_alloc_start;
-static unsigned long __initdata prom_tce_alloc_end;
+static int __prombss prom_iommu_force_on;
+static int __prombss prom_iommu_off;
+static unsigned long __prombss prom_tce_alloc_start;
+static unsigned long __prombss prom_tce_alloc_end;
 #endif
 
 static bool prom_radix_disable __initdata = !IS_ENABLED(CONFIG_PPC_RADIX_MMU_DEFAULT);
@@ -191,22 +194,22 @@ struct platform_support {
 #define PLATFORM_GENERIC	0x0500
 #define PLATFORM_OPAL		0x0600
 
-static int __initdata of_platform;
+static int __prombss of_platform;
 
-static char __initdata prom_cmd_line[COMMAND_LINE_SIZE];
+static char __prombss prom_cmd_line[COMMAND_LINE_SIZE];
 
-static unsigned long __initdata prom_memory_limit;
+static unsigned long __prombss prom_memory_limit;
 
-static unsigned long __initdata alloc_top;
-static unsigned long __initdata alloc_top_high;
-static unsigned long __initdata alloc_bottom;
-static unsigned long __initdata rmo_top;
-static unsigned long __initdata ram_top;
+static unsigned long __prombss alloc_top;
+static unsigned long __prombss alloc_top_high;
+static unsigned long __prombss alloc_bottom;
+static unsigned long __prombss rmo_top;
+static unsigned long __prombss ram_top;
 
-static struct mem_map_entry __initdata mem_reserve_map[MEM_RESERVE_MAP_SIZE];
-static int __initdata mem_reserve_cnt;
+static struct mem_map_entry __prombss mem_reserve_map[MEM_RESERVE_MAP_SIZE];
+static int __prombss mem_reserve_cnt;
 
-static cell_t __initdata regbuf[1024];
+static cell_t __prombss regbuf[1024];
 
 static bool rtas_has_query_cpu_stopped;
 
@@ -1534,8 +1537,8 @@ static void __init prom_close_stdin(void)
 #ifdef CONFIG_PPC_POWERNV
 
 #ifdef CONFIG_PPC_EARLY_DEBUG_OPAL
-static u64 __initdata prom_opal_base;
-static u64 __initdata prom_opal_entry;
+static u64 __prombss prom_opal_base;
+static u64 __prombss prom_opal_entry;
 #endif
 
 /*
-- 
2.17.0
