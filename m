Return-Path: <kim.phillips@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id E770D67C1E
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Nov 2006 11:19:54 +1100 (EST)
Date: Tue, 21 Nov 2006 18:19:42 -0600
From: Kim Phillips <kim.phillips@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2.6.19] fix ucc_geth of_device discovery on mpc832x
Message-Id: <20061121181942.5d965694.kim.phillips@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

mpc832x, as in mpc8360, needs to explicitly find and create the platform device for ucc_geth in 2.6.19.  This code will likely be readapted to Benh's new of_ methods for 2.6.20.

Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
---
 arch/powerpc/platforms/83xx/mpc832x_mds.c |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/83xx/mpc832x_mds.c b/arch/powerpc/platforms/83xx/mpc832x_mds.c
index 54dea9d..a43ac71 100644
--- a/arch/powerpc/platforms/83xx/mpc832x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc832x_mds.c
@@ -24,6 +24,7 @@ #include <linux/seq_file.h>
 #include <linux/root_dev.h>
 #include <linux/initrd.h>
 
+#include <asm/of_device.h>
 #include <asm/system.h>
 #include <asm/atomic.h>
 #include <asm/time.h>
@@ -136,6 +137,24 @@ #else
 #endif
 }
 
+static int __init mpc832x_declare_of_platform_devices(void)
+{
+	struct device_node *np;
+
+	for (np = NULL; (np = of_find_compatible_node(np, "network",
+					"ucc_geth")) != NULL;) {
+		int ucc_num;
+		char bus_id[BUS_ID_SIZE];
+
+		ucc_num = *((uint *) get_property(np, "device-id", NULL)) - 1;
+		snprintf(bus_id, BUS_ID_SIZE, "ucc_geth.%u", ucc_num);
+		of_platform_device_create(np, bus_id, NULL);
+	}
+
+	return 0;
+}
+device_initcall(mpc832x_declare_of_platform_devices);
+
 void __init mpc832x_sys_init_IRQ(void)
 {
 
-- 
1.4.2.3
