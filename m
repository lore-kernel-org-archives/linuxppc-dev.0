Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <cf9d9fddba10efbfd006706d6c5e2e201ff80c67.1226550015.git.michael@ellerman.id.au>
In-Reply-To: <2743c30c538d24a0befee055bd6e0fcd746d0e82.1226550015.git.michael@ellerman.id.au>
References: <2743c30c538d24a0befee055bd6e0fcd746d0e82.1226550015.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 4/4] Use of_find_node_with_property() in pmac_setup_arch()
Date: Thu, 13 Nov 2008 15:20:43 +1100 (EST)
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
 arch/powerpc/platforms/powermac/setup.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/powermac/setup.c b/arch/powerpc/platforms/powermac/setup.c
index 82c14d2..1293772 100644
--- a/arch/powerpc/platforms/powermac/setup.c
+++ b/arch/powerpc/platforms/powermac/setup.c
@@ -310,9 +310,7 @@ static void __init pmac_setup_arch(void)
 	}
 
 	/* See if newworld or oldworld */
-	for (ic = NULL; (ic = of_find_all_nodes(ic)) != NULL; )
-		if (of_get_property(ic, "interrupt-controller", NULL))
-			break;
+	ic = of_find_node_with_property(NULL, "interrupt-controller");
 	if (ic) {
 		pmac_newworld = 1;
 		of_node_put(ic);
-- 
1.5.5
