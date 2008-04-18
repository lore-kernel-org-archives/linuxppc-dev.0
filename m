Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <2dbf0286a67c8141d12eeb08fc662d68c0a91f87.1208505275.git.michael@ellerman.id.au>
In-Reply-To: <fbb91d0892c720d6f28501e1830028c78eb6664f.1208505275.git.michael@ellerman.id.au>
References: <fbb91d0892c720d6f28501e1830028c78eb6664f.1208505275.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 06/11] Convert from DBG() to pr_debug() in
	platforms/pseries/firmware.c
Date: Fri, 18 Apr 2008 17:54:39 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/platforms/pseries/firmware.c |    9 ++-------
 1 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/firmware.c b/arch/powerpc/platforms/pseries/firmware.c
index b765b7c..743d494 100644
--- a/arch/powerpc/platforms/pseries/firmware.c
+++ b/arch/powerpc/platforms/pseries/firmware.c
@@ -27,11 +27,6 @@
 #include <asm/prom.h>
 #include <asm/udbg.h>
 
-#ifdef DEBUG
-#define DBG(fmt...) udbg_printf(fmt)
-#else
-#define DBG(fmt...)
-#endif
 
 typedef struct {
     unsigned long val;
@@ -72,7 +67,7 @@ void __init fw_feature_init(const char *hypertas, unsigned long len)
 	const char *s;
 	int i;
 
-	DBG(" -> fw_feature_init()\n");
+	pr_debug(" -> fw_feature_init()\n");
 
 	for (s = hypertas; s < hypertas + len; s += strlen(s) + 1) {
 		for (i = 0; i < FIRMWARE_MAX_FEATURES; i++) {
@@ -88,5 +83,5 @@ void __init fw_feature_init(const char *hypertas, unsigned long len)
 		}
 	}
 
-	DBG(" <- fw_feature_init()\n");
+	pr_debug(" <- fw_feature_init()\n");
 }
-- 
1.5.5
