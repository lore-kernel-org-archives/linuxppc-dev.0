Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: benh@kernel.crashing.org
MIME-Version: 1.0
Subject: [PATCH] powerpc: add missing sparsemem.h include
Date: Mon, 09 Feb 2009 11:49:39 +1100
Message-ID: <13807.1234140579@neuling.org>
Sender: mikey@neuling.org
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

arch/powerpc/platforms/pseries/hotplug-memory.c uses
remove_section_mapping() but doesn't include sparsemem.h which defines
it.  This can cause compilation fails for some configs. 

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
This is against mainline, so should be pushed up soon-ish...

 arch/powerpc/platforms/pseries/hotplug-memory.c |    1 +
 1 file changed, 1 insertion(+)

Index: linux-2.6-ozlabs/arch/powerpc/platforms/pseries/hotplug-memory.c
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/platforms/pseries/hotplug-memory.c
+++ linux-2.6-ozlabs/arch/powerpc/platforms/pseries/hotplug-memory.c
@@ -14,6 +14,7 @@
 #include <asm/firmware.h>
 #include <asm/machdep.h>
 #include <asm/pSeries_reconfig.h>
+#include <asm/sparsemem.h>
 
 static int pseries_remove_lmb(unsigned long base, unsigned int lmb_size)
 {
