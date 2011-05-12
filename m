Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 42E38B6F75
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 12 May 2011 16:58:26 +1000 (EST)
Received: from [IPv6:::1] (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id p4C6wJMs024277
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 May 2011 01:58:20 -0500
Subject: [PATCH] powerpc: Make early memory scan more resilient to out of
	order nodes
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 12 May 2011 16:58:18 +1000
Message-ID: <1305183498.29820.95.camel@pasglop>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We keep track of the size of the lowest block of memory and call
setup_initial_memory_limit() only after we've parsed them all

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/prom.c |   15 ++++++++++-----
 1 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 584b398..27475c6 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -70,6 +70,7 @@ int __initdata iommu_force_on;
 unsigned long tce_alloc_start, tce_alloc_end;
 u64 ppc64_rma_size;
 #endif
+static phys_addr_t first_memblock_size;
 
 static int __init early_parse_mem(char *p)
 {
@@ -507,11 +508,14 @@ void __init early_init_dt_add_memory_arch(u64 base, u64 size)
 			size = 0x80000000ul - base;
 	}
 #endif
-
-	/* First MEMBLOCK added, do some special initializations */
-	if (memstart_addr == ~(phys_addr_t)0)
-		setup_initial_memory_limit(base, size);
-	memstart_addr = min((u64)memstart_addr, base);
+	/* Keep track of the beginning of memory -and- the size of
+	 * the very first block in the device-tree as it represents
+	 * the RMA on ppc64 server
+	 */
+	if (base < memstart_addr) {
+		memstart_addr = base;
+		first_memblock_size = size;
+	}
 
 	/* Add the chunk to the MEMBLOCK list */
 	memblock_add(base, size);
@@ -708,6 +712,7 @@ void __init early_init_devtree(void *params)
 
 	of_scan_flat_dt(early_init_dt_scan_root, NULL);
 	of_scan_flat_dt(early_init_dt_scan_memory_ppc, NULL);
+	setup_initial_memory_limit(memstart_addr, first_memblock_size);
 
 	/* Save command line for /proc/cmdline and then parse parameters */
 	strlcpy(boot_command_line, cmd_line, COMMAND_LINE_SIZE);
