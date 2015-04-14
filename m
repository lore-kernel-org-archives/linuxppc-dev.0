Return-Path: <linux@roeck-us.net>
Received: from bh-25.webhostbox.net (bh-25.webhostbox.net [208.91.199.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EF5201A0094
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Apr 2015 05:53:04 +1000 (AEST)
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
 (envelope-from <linux@roeck-us.net>) id 1Yi6tJ-003XlP-R8
 for linuxppc-dev@lists.ozlabs.org; Tue, 14 Apr 2015 19:53:02 +0000
From: Guenter Roeck <linux@roeck-us.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] powerpc: Fix build error seen with powermac smp builds
Date: Tue, 14 Apr 2015 12:52:50 -0700
Message-Id: <1429041170-17695-1-git-send-email-linux@roeck-us.net>
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

powermac smp builds fail with

arch/powerpc/platforms/powermac/smp.c: In function 'smp_psurge_probe':
arch/powerpc/platforms/powermac/smp.c:278:3: error:
		'return' with a value, in function returning void

There are several instances of this error.

Cc: Michael Ellerman <mpe@ellerman.id.au>
Fixes: a7f4ee1fe93a ("powerpc: Drop return value of smp_ops->probe()")
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
Seen in next-20150414.

 arch/powerpc/platforms/powermac/smp.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/platforms/powermac/smp.c b/arch/powerpc/platforms/powermac/smp.c
index f84ac7e..28a147c 100644
--- a/arch/powerpc/platforms/powermac/smp.c
+++ b/arch/powerpc/platforms/powermac/smp.c
@@ -275,7 +275,7 @@ static void __init smp_psurge_probe(void)
 
 	/* We don't do SMP on the PPC601 -- paulus */
 	if (PVR_VER(mfspr(SPRN_PVR)) == 1)
-		return 1;
+		return;
 
 	/*
 	 * The powersurge cpu board can be used in the generation
@@ -289,7 +289,7 @@ static void __init smp_psurge_probe(void)
 	 */
 	dn = of_find_node_by_name(NULL, "hammerhead");
 	if (dn == NULL)
-		return 1;
+		return;
 	of_node_put(dn);
 
 	hhead_base = ioremap(HAMMERHEAD_BASE, 0x800);
@@ -310,13 +310,13 @@ static void __init smp_psurge_probe(void)
 			/* not a dual-cpu card */
 			iounmap(hhead_base);
 			psurge_type = PSURGE_NONE;
-			return 1;
+			return;
 		}
 		ncpus = 2;
 	}
 
 	if (psurge_secondary_ipi_init())
-		return 1;
+		return;
 
 	psurge_start = ioremap(PSURGE_START, 4);
 	psurge_pri_intr = ioremap(PSURGE_PRI_INTR, 4);
@@ -332,8 +332,6 @@ static void __init smp_psurge_probe(void)
 		set_cpu_present(i, true);
 
 	if (ppc_md.progress) ppc_md.progress("smp_psurge_probe - done", 0x352);
-
-	return ncpus;
 }
 
 static int __init smp_psurge_kick_cpu(int nr)
-- 
2.1.0
