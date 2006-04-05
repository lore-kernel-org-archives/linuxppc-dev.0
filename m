Return-Path: <michael@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>,
	<linuxppc-dev@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Wed, 05 Apr 2006 18:18:25 +0200
Subject: [PATCH] powerpc: Fix machine detection in prom_init.c
Message-Id: <20060405161830.CFD28679EB@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In e8222502ee6157e2713da9e0792c21f4ad458d50 the detection of machine types
in prom_init broke for some machines. We should be checking /device_type
instead of /model. This should make Power3 and Power4 boot again. Haven't
been able to test this.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 arch/powerpc/kernel/prom_init.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: to-merge/arch/powerpc/kernel/prom_init.c
===================================================================
--- to-merge.orig/arch/powerpc/kernel/prom_init.c
+++ to-merge/arch/powerpc/kernel/prom_init.c
@@ -1528,7 +1528,7 @@ static int __init prom_find_machine_type
 	 *    non-IBM designs !
 	 *  - it has /rtas
 	 */
-	len = prom_getprop(_prom->root, "model",
+	len = prom_getprop(_prom->root, "device_type",
 			   compat, sizeof(compat)-1);
 	if (len <= 0)
 		return PLATFORM_GENERIC;
