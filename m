Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 785AA1A0371
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jun 2015 15:01:34 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: shreyas@linux.vnet.ibm.com
Subject: [PATCH v2] powerpc/powernv: pnv_init_idle_states() should only run on
 powernv
Date: Mon, 15 Jun 2015 15:01:32 +1000
Message-Id: <1434344492-4859-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Although this init call checks for device tree properties before doing
anything, it should still only run on powernv machines.

Reviewed-by: Shreyas B Prabhu <shreyas@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/platforms/powernv/idle.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)


v2: Add include of machdep.h to make it actually build.

diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
index bd39a120bd60..59d735d2e5c0 100644
--- a/arch/powerpc/platforms/powernv/idle.c
+++ b/arch/powerpc/platforms/powernv/idle.c
@@ -17,6 +17,7 @@
 #include <linux/cpu.h>
 
 #include <asm/firmware.h>
+#include <asm/machdep.h>
 #include <asm/opal.h>
 #include <asm/cputhreads.h>
 #include <asm/cpuidle.h>
@@ -289,5 +290,4 @@ out_free:
 out:
 	return 0;
 }
-
-subsys_initcall(pnv_init_idle_states);
+machine_subsys_initcall(powernv, pnv_init_idle_states);
-- 
2.1.0
