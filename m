Return-Path: <djiang@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id 7D00EDE03D
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Feb 2008 08:05:35 +1100 (EST)
Date: Wed, 13 Feb 2008 14:08:03 -0700
From: Dave Jiang <djiang@mvista.com>
To: galak@kernel.crashing.org, linuxppc-dev@ozlabs.org
Subject: [PATCH 1/2 rev2] powerpc: publish 85xx cds soc dts entries as
	of_device
Message-ID: <20080213210803.GA12018@blade.az.mvista.com>
References: <20080211203243.GA5331@blade.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20080211203243.GA5331@blade.az.mvista.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Publish the devices listed in dts under SOC as of_device for mpc85xx_cds
platforms.

The memory controller, L2 cache-controller, and the PCI controller(s) are
published as of_device so the mpc85xx EDAC driver can claim them for usage.

Signed-off-by: Dave Jiang <djiang@mvista.com>

---
commit 4be72413410c560fe7ad5ef9156d43159003dad3
tree 8890093ee1cff0ec0cc9ce0b9367e134f528eed2
parent 19af35546de68c872dcb687613e0902a602cb20e
author Dave Jiang <djiang@mvista.com> Wed, 13 Feb 2008 14:03:33 -0700
committer Dave Jiang <djiang@blade.(none)> Wed, 13 Feb 2008 14:03:33 -0700

 arch/powerpc/platforms/85xx/mpc85xx_cds.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/mpc85xx_cds.c b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
index 8b1de78..374c9d5 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_cds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
@@ -26,6 +26,7 @@
 #include <linux/module.h>
 #include <linux/interrupt.h>
 #include <linux/fsl_devices.h>
+#include <linux/of_platform.h>
 
 #include <asm/system.h>
 #include <asm/pgtable.h>
@@ -324,6 +325,19 @@ static void mpc85xx_cds_show_cpuinfo(struct seq_file *m)
 	seq_printf(m, "Memory\t\t: %d MB\n", memsize / (1024 * 1024));
 }
 
+static struct of_device_id __initdata of_bus_ids[] = {
+	{ .name = "soc", },
+	{ .type = "soc", },
+	{},
+};
+
+static int __init declare_of_platform_devices(void)
+{
+	of_platform_bus_probe(NULL, of_bus_ids, NULL);
+
+	return 0;
+}
+machine_device_initcall(mpc85xx_cds, declare_of_platform_devices);
 
 /*
  * Called very early, device-tree isn't unflattened
