Return-Path: <SRS0+97d39be1a89b1495b2c5+1313+infradead.org+dwmw2@canuck.srs.infradead.org>
Subject: [PATCH] Ignore memory listed in PS3 device tree
From: David Woodhouse <dwmw2@infradead.org>
To: cbe-oss-dev@ozlabs.org
Content-Type: text/plain
Date: Thu, 29 Mar 2007 23:43:57 +0100
Message-Id: <1175208237.3122.78.camel@pmac.infradead.org>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The old 2.6.16 kernel handled memory statically and it was shown in the
device tree. The current kernel deals with the hypervisor and hotplugs
the memory, so we should just ignore anything that's reported in the
device-tree. This enables the current kernel to be booted from 2.6.16
without evil hacks in head_64.S to override the device-tree.

Signed-off-by: David Woodhouse <dwmw2@infradead.org>

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 08bd255..dd38408 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -52,6 +52,7 @@
 #include <asm/pSeries_reconfig.h>
 #include <asm/pci-bridge.h>
 #include <asm/kexec.h>
+#include <asm/firmware.h>
 
 #ifdef DEBUG
 #define DBG(fmt...) printk(KERN_ERR fmt)
@@ -862,6 +863,9 @@ static int __init early_init_dt_scan_memory(unsigned long node,
 	cell_t *reg, *endp;
 	unsigned long l;
 
+	if (firmware_has_feature(FW_FEATURE_PS3_LV1))
+		return 0;
+
 	/* Look for the ibm,dynamic-reconfiguration-memory node */
 	if (depth == 1 &&
 	    strcmp(uname, "ibm,dynamic-reconfiguration-memory") == 0)

-- 
dwmw2
