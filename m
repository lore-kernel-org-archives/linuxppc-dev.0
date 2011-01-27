Return-Path: <scottwood@freescale.com>
Received: from VA3EHSOBE002.bigfish.com (va3ehsobe002.messaging.microsoft.com
	[216.32.180.12]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 90619B70E9
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Jan 2011 07:46:01 +1100 (EST)
Date: Thu, 27 Jan 2011 14:30:44 -0600
From: Scott Wood <scottwood@freescale.com>
To: <benh@kernel.crashing.org>
Subject: [PATCH] powerpc: fix memory limits when starting at a non-zero address
Message-ID: <20110127203044.GA30952@udp111988uds.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

memblock_enforce_memory_limit() takes the desired maximum quantity of memory
to end up with, not an address above which memory will not be used.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/kernel/prom.c |    2 +-
 arch/powerpc/mm/init_32.c  |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 7185f0d..05b7139 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -97,7 +97,7 @@ static void __init move_device_tree(void)
 	start = __pa(initial_boot_params);
 	size = be32_to_cpu(initial_boot_params->totalsize);
 
-	if ((memory_limit && (start + size) > memory_limit) ||
+	if ((memory_limit && (start + size) > PHYSICAL_START + memory_limit) ||
 			overlaps_crashkernel(start, size)) {
 		p = __va(memblock_alloc(size, PAGE_SIZE));
 		memcpy(p, initial_boot_params, size);
diff --git a/arch/powerpc/mm/init_32.c b/arch/powerpc/mm/init_32.c
index 742da43..d65b591 100644
--- a/arch/powerpc/mm/init_32.c
+++ b/arch/powerpc/mm/init_32.c
@@ -148,7 +148,7 @@ void __init MMU_init(void)
 		lowmem_end_addr = memstart_addr + total_lowmem;
 #ifndef CONFIG_HIGHMEM
 		total_memory = total_lowmem;
-		memblock_enforce_memory_limit(lowmem_end_addr);
+		memblock_enforce_memory_limit(total_lowmem);
 		memblock_analyze();
 #endif /* CONFIG_HIGHMEM */
 	}
-- 
1.7.0.4
