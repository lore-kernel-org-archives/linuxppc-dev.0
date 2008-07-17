Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <27c8ac7aceccaf7856c65f2ef1305321f94d564e.1216279070.git.michael@ellerman.id.au>
In-Reply-To: <3756cbfb076b2fa0b93ec990aabfee73296443d9.1216279070.git.michael@ellerman.id.au>
References: <3756cbfb076b2fa0b93ec990aabfee73296443d9.1216279070.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 3/3] powerpc: Use PPC_LONG and PPC_LONG_ALIGN in lib/string.S
Date: Thu, 17 Jul 2008 17:17:52 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

No change to the generated code.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/lib/string.S |   18 ++++++------------
 1 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/lib/string.S b/arch/powerpc/lib/string.S
index 49eb1f1..64e2e49 100644
--- a/arch/powerpc/lib/string.S
+++ b/arch/powerpc/lib/string.S
@@ -13,13 +13,7 @@
 #include <asm/ppc_asm.h>
 
 	.section __ex_table,"a"
-#ifdef CONFIG_PPC64
-	.align	3
-#define EXTBL	.llong
-#else
-	.align	2
-#define EXTBL	.long
-#endif
+	PPC_LONG_ALIGN
 	.text
 	
 _GLOBAL(strcpy)
@@ -160,9 +154,9 @@ _GLOBAL(__clear_user)
 	blr
 
 	.section __ex_table,"a"
-	EXTBL	11b,90b
-	EXTBL	1b,91b
-	EXTBL	8b,92b
+	PPC_LONG	11b,90b
+	PPC_LONG	1b,91b
+	PPC_LONG	8b,92b
 	.text
 
 _GLOBAL(__strncpy_from_user)
@@ -183,7 +177,7 @@ _GLOBAL(__strncpy_from_user)
 	blr
 
 	.section __ex_table,"a"
-	EXTBL	1b,99b
+	PPC_LONG	1b,99b
 	.text
 
 /* r3 = str, r4 = len (> 0), r5 = top (highest addr) */
@@ -208,4 +202,4 @@ _GLOBAL(__strnlen_user)
 	blr
 
 	.section __ex_table,"a"
-	EXTBL	1b,99b
+	PPC_LONG	1b,99b
-- 
1.5.5
