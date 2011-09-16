Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7D05DB7199
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Sep 2011 01:40:03 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id p8GFdxO3000784
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Sep 2011 10:40:00 -0500
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/2] powerpc: respect mem= setting for early memory limit setup
Date: Fri, 16 Sep 2011 10:39:58 -0500
Message-Id: <1316187599-27549-1-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

For those MMUs that have some form of bolt'd linear mapping (TLB)
required its rare that one ever sets mem= smaller than the size of that
mapping.

However, on Book-E 64 parts the initial linear mapping is quite large
(1G) so its quite reasonable that mem= is set smaller than that.

We need to parse the command line for mem= limit and constrain the
amount of memory we map initially by it if need be.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/kernel/prom.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 174e1e9..87902de 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -723,12 +723,15 @@ void __init early_init_devtree(void *params)
 
 	of_scan_flat_dt(early_init_dt_scan_root, NULL);
 	of_scan_flat_dt(early_init_dt_scan_memory_ppc, NULL);
-	setup_initial_memory_limit(memstart_addr, first_memblock_size);
 
 	/* Save command line for /proc/cmdline and then parse parameters */
 	strlcpy(boot_command_line, cmd_line, COMMAND_LINE_SIZE);
 	parse_early_param();
 
+	/* make sure we've parsed cmdline for mem= before this */
+	if (memory_limit)
+		first_memblock_size = min(first_memblock_size, memory_limit);
+	setup_initial_memory_limit(memstart_addr, first_memblock_size);
 	/* Reserve MEMBLOCK regions used by kernel, initrd, dt, etc... */
 	memblock_reserve(PHYSICAL_START, __pa(klimit) - PHYSICAL_START);
 	/* If relocatable, reserve first 32k for interrupt vectors etc. */
-- 
1.7.3.4
