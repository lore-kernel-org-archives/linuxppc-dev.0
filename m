Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <5fec17c31f90769a228de7091420c89157658d37.1193381582.git.michael@ellerman.id.au>
In-Reply-To: <80449d4682309dbf8cf80816be4f381fe875f3d1.1193381582.git.michael@ellerman.id.au>
References: <80449d4682309dbf8cf80816be4f381fe875f3d1.1193381582.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 07/16] Use of_get_next_parent() in xics_setup_8259_cascade()
Date: Fri, 26 Oct 2007 16:54:37 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Use of_get_next_parent() in xics_setup_8259_cascade() to simplify
the loop logic.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/platforms/pseries/xics.c |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/xics.c b/arch/powerpc/platforms/pseries/xics.c
index 66e7d68..58a3cc7 100644
--- a/arch/powerpc/platforms/pseries/xics.c
+++ b/arch/powerpc/platforms/pseries/xics.c
@@ -617,7 +617,7 @@ static void __init xics_init_one_node(struct device_node *np,
 
 static void __init xics_setup_8259_cascade(void)
 {
-	struct device_node *np, *old, *found = NULL;
+	struct device_node *np, *found = NULL;
 	int cascade, naddr;
 	const u32 *addrp;
 	unsigned long intack = 0;
@@ -638,11 +638,8 @@ static void __init xics_setup_8259_cascade(void)
 	}
 	pr_debug("xics: cascade mapped to irq %d\n", cascade);
 
-	for (old = of_node_get(found); old != NULL ; old = np) {
-		np = of_get_parent(old);
-		of_node_put(old);
-		if (np == NULL)
-			break;
+	np = of_node_get(found);
+	while ((np = of_get_next_parent(np))) {
 		if (strcmp(np->name, "pci") != 0)
 			continue;
 		addrp = of_get_property(np, "8259-interrupt-acknowledge", NULL);
-- 
1.5.2.rc1.1884.g59b20
