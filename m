Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <aab322f087db2ecc390ea5e224db143cf77d3067.1232001859.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 1/2] powerpc: Allow debugging of LMBs with lmb=debug
Date: Thu, 15 Jan 2009 17:46:01 +1100 (EST)
Cc: "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The lmb debugging can be turned on at boottime with lmb=debug on the
command line. However on powerpc that doesn't work, because we don't
necessarily call lmb_dump_all().

So always call lmb_dump_all() after lmb_analyze(), no output is
generated unless lmb=debug is found on the command line.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/kernel/prom.c |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index c09cffa..045277b 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -1070,11 +1070,6 @@ static void __init early_reserve_mem(void)
 		DBG("reserving: %llx -> %llx\n", base, size);
 		lmb_reserve(base, size);
 	}
-
-#if 0
-	DBG("memory reserved, lmbs :\n");
-      	lmb_dump_all();
-#endif
 }
 
 #ifdef CONFIG_PHYP_DUMP
@@ -1216,6 +1211,7 @@ void __init early_init_devtree(void *params)
 	lmb_enforce_memory_limit(limit);
 
 	lmb_analyze();
+	lmb_dump_all();
 
 	DBG("Phys. mem: %lx\n", lmb_phys_mem_size());
 
-- 
1.5.5
