Return-Path: <anton@ozlabs.org>
Message-Id: <20090401060656.920561864@samba.org>
References: <20090401060613.377489909@samba.org>
Date: Wed, 01 Apr 2009 17:06:14 +1100
From: anton@samba.org
To: linuxppc-dev@ozlabs.org
Subject: [patch 1/2] powerpc: Print progress of ibm, client-architecture method
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The ibm,client-architecture method will often cause a reconfiguration reboot.
When this happens the last thing we see is:

	Hypertas detected, assuming LPAR !

Which doesn't explain what just happened. Wrap the ibm,client-architecture
so it's clear what is going on:

	Calling ibm,client-architecture... done

In order to maintain the law of conservation of screen real estate, downgrade
two other messages to debug. 

Signed-off-by: Anton Blanchard <anton@samba.org>
---

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index 7f1b33d..d5414fe 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -732,15 +732,17 @@ static void __init prom_send_capabilities(void)
 	root = call_prom("open", 1, 1, ADDR("/"));
 	if (root != 0) {
 		/* try calling the ibm,client-architecture-support method */
+		prom_printf("Calling ibm,client-architecture...");
 		if (call_prom_ret("call-method", 3, 2, &ret,
 				  ADDR("ibm,client-architecture-support"),
 				  root,
 				  ADDR(ibm_architecture_vec)) == 0) {
 			/* the call exists... */
 			if (ret)
-				prom_printf("WARNING: ibm,client-architecture"
+				prom_printf("\nWARNING: ibm,client-architecture"
 					    "-support call FAILED!\n");
 			call_prom("close", 1, 0, root);
+			prom_printf(" done\n");
 			return;
 		}
 		call_prom("close", 1, 0, root);
@@ -1495,7 +1497,7 @@ static int __init prom_find_machine_type(void)
 		return PLATFORM_GENERIC;
 	x = prom_getproplen(rtas, "ibm,hypertas-functions");
 	if (x != PROM_ERROR) {
-		prom_printf("Hypertas detected, assuming LPAR !\n");
+		prom_debug("Hypertas detected, assuming LPAR !\n");
 		return PLATFORM_PSERIES_LPAR;
 	}
 	return PLATFORM_PSERIES;
@@ -1544,7 +1546,7 @@ static void __init prom_check_displays(void)
 	};
 	const unsigned char *clut;
 
-	prom_printf("Looking for displays\n");
+	prom_debug("Looking for displays\n");
 	for (node = 0; prom_next_node(&node); ) {
 		memset(type, 0, sizeof(type));
 		prom_getprop(node, "device_type", type, sizeof(type));

-- 
