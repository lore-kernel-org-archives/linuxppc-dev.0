Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <bc0f09818134417c23c120426f3d51a32f37ae8f.1193381582.git.michael@ellerman.id.au>
In-Reply-To: <80449d4682309dbf8cf80816be4f381fe875f3d1.1193381582.git.michael@ellerman.id.au>
References: <80449d4682309dbf8cf80816be4f381fe875f3d1.1193381582.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 08/16] Use of_get_next_parent() in pseries_mpic_init_IRQ()
Date: Fri, 26 Oct 2007 16:54:38 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Use of_get_next_parent() in pseries_mpic_init_IRQ() to simplify
the loop logic.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/platforms/pseries/setup.c |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index fdb9b1c..f08dfaf 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -129,7 +129,7 @@ void pseries_8259_cascade(unsigned int irq, struct irq_desc *desc)
 
 static void __init pseries_mpic_init_IRQ(void)
 {
-	struct device_node *np, *old, *cascade = NULL;
+	struct device_node *np, *cascade = NULL;
         const unsigned int *addrp;
 	unsigned long intack = 0;
 	const unsigned int *opprop;
@@ -182,11 +182,8 @@ static void __init pseries_mpic_init_IRQ(void)
 	}
 
 	/* Check ACK type */
-	for (old = of_node_get(cascade); old != NULL ; old = np) {
-		np = of_get_parent(old);
-		of_node_put(old);
-		if (np == NULL)
-			break;
+	np = of_node_get(cascade);
+	while ((np = of_get_next_parent(np))) {
 		if (strcmp(np->name, "pci") != 0)
 			continue;
 		addrp = of_get_property(np, "8259-interrupt-acknowledge",
-- 
1.5.2.rc1.1884.g59b20
