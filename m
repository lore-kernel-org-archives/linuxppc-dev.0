Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <4ccd209b3cc7e9a3b05686843509ea3fa6843a37.1226550015.git.michael@ellerman.id.au>
In-Reply-To: <2743c30c538d24a0befee055bd6e0fcd746d0e82.1226550015.git.michael@ellerman.id.au>
References: <2743c30c538d24a0befee055bd6e0fcd746d0e82.1226550015.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 2/4] Use for_each_node_with_property() in of_irq_map_init()
Date: Thu, 13 Nov 2008 15:20:37 +1100 (EST)
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
 arch/powerpc/kernel/prom_parse.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/prom_parse.c b/arch/powerpc/kernel/prom_parse.c
index bc1fb27..2a1c02c 100644
--- a/arch/powerpc/kernel/prom_parse.c
+++ b/arch/powerpc/kernel/prom_parse.c
@@ -731,10 +731,7 @@ void of_irq_map_init(unsigned int flags)
 	if (flags & OF_IMAP_NO_PHANDLE) {
 		struct device_node *np;
 
-		for(np = NULL; (np = of_find_all_nodes(np)) != NULL;) {
-			if (of_get_property(np, "interrupt-controller", NULL)
-			    == NULL)
-				continue;
+		for_each_node_with_property(np, "interrupt-controller") {
 			/* Skip /chosen/interrupt-controller */
 			if (strcmp(np->name, "chosen") == 0)
 				continue;
-- 
1.5.5
