Return-Path: <anton@samba.org>
Date: Thu, 25 Jul 2013 12:51:22 +1000
From: Anton Blanchard <anton@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, Grant Likely <grant.likely@linaro.org>, Rob Herring
 <rob.herring@calxeda.com>
Subject: [PATCH] powerpc: Feed entire flattened device tree into the random
 pool
Message-ID: <20130725125122.78accf44@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


We feed the entire DMI table into the random pool to provide
better random data during early boot, so do the same with the
flattened device tree.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

It might be worth doing this somewhere common, but the only place
I could find (unflatten_device_tree) is almost certainly too
early in the boot process.

diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 63d051f..6914851 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -35,6 +35,7 @@
 #include <linux/percpu.h>
 #include <linux/memblock.h>
 #include <linux/of_platform.h>
+#include <linux/random.h>
 #include <asm/io.h>
 #include <asm/paca.h>
 #include <asm/prom.h>
@@ -752,3 +753,13 @@ void arch_setup_pdev_archdata(struct platform_device *pdev)
 	pdev->dev.dma_mask = &pdev->archdata.dma_mask;
  	set_dma_ops(&pdev->dev, &dma_direct_ops);
 }
+
+/* Feed entire flattened device tree into the random pool */
+static int __init add_fdt_randomness(void)
+{
+	add_device_randomness(initial_boot_params,
+			      initial_boot_params->totalsize);
+
+	return 0;
+}
+core_initcall(add_fdt_randomness);
