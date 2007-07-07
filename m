Return-Path: <vitb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DB570DE211
	for <linuxppc-dev@ozlabs.org>; Sat,  7 Jul 2007 19:49:05 +1000 (EST)
To: linux-ide@vger.kernel.org
From: Vitaly Bordug <vitb@kernel.crashing.org>
Subject: [PATCH 2/2] [POWERPC] mmio ide support for mpc8349-itx target
Date: Sat, 07 Jul 2007 13:49:00 +0400
Message-ID: <20070707094900.9473.48577.stgit@localhost.localdomain>
In-Reply-To: <20070707094852.9473.21013.stgit@localhost.localdomain>
References: <20070707094852.9473.21013.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


This updates relevant platform code
(freescale mpc8349itx target) to make the CompactFlash
work in TrueIDE mode.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
Signed-off-by: Vitaly Bordug <vitb@kernel.crashing.org>

---

 arch/powerpc/boot/dts/mpc8349emitx.dts |   17 +++++
 arch/powerpc/sysdev/fsl_soc.c          |  113 ++++++++++++++++++++++++++++++++
 2 files changed, 129 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8349emitx.dts b/arch/powerpc/boot/dts/mpc8349emitx.dts
index db0d003..b3e80ab 100644
--- a/arch/powerpc/boot/dts/mpc8349emitx.dts
+++ b/arch/powerpc/boot/dts/mpc8349emitx.dts
@@ -42,7 +42,7 @@
 		#size-cells = <1>;
 		#interrupt-cells = <2>;
 		device_type = "soc";
-		ranges = <0 e0000000 00100000>;
+		ranges = <0 e0000000 1f000000>;
 		reg = <e0000000 00000200>;
 		bus-frequency = <0>;                    // from bootloader
 
@@ -229,6 +229,21 @@
 			descriptor-types-mask = <01010ebf>;
 		};
 
+		ide@10000000 {
+ 			#interrupt-cells = <2>;
+ 			interrupts = <17 8>;
+ 			interrupt-map = <0 0 0 1 700 17 8>;
+ 			interrupt-map-mask = <0>;
+ 
+ 			#size-cells = <1>;
+ 			#address-cells = <1>;
+ 			reg = <10000000 10 10000200 10>;
+ 
+ 			device_type = "ide";
+ 			compatible = "mmio-ide";
+ 			interrupt-parent = < &ipic >;
+ 		};
+
 		ipic: pic@700 {
 			interrupt-controller;
 			#address-cells = <0>;
diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index cad1757..b3fe011 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -1103,3 +1103,116 @@ err:
 arch_initcall(cpm_smc_uart_of_init);
 
 #endif /* CONFIG_8xx */
+
+#ifdef CONFIG_MPC834x_ITX
+
+#include <linux/ide.h>
+#include <linux/mmio-ide.h>
+#include <asm-ppc/mpc83xx.h>
+
+static void mmio_ide_outsw(unsigned long port, void *addr, u32 count)
+{
+	_outsw_ns((void __iomem *)port, addr, count);
+}
+
+static void mmio_ide_insw(unsigned long port, void *addr, u32 count)
+{
+	_insw_ns((void __iomem *)port, addr, count);
+}
+
+void mmio_ide_mmiops (ide_hwif_t *hwif)
+{
+	default_hwif_mmiops(hwif);
+	hwif->OUTL = NULL;
+	hwif->OUTSW = mmio_ide_outsw;
+	hwif->OUTSL = NULL;
+	hwif->INL = NULL;
+	hwif->INSW = mmio_ide_insw;
+	hwif->INSL = NULL;
+}
+
+void mmio_ide_selectproc (ide_drive_t *drive)
+{
+	u8 stat;
+
+	stat = drive->hwif->INB(IDE_STATUS_REG);
+	if ((stat & READY_STAT) && (stat & BUSY_STAT))
+		drive->present = 0;
+	else
+		drive->present = 1;
+}
+
+static int __init fsl_mmio_ide_of_init(void)
+{
+	struct device_node *np;
+	unsigned int i;
+
+	for (np = NULL, i = 0;
+	     (np = of_find_compatible_node(np, "ide", "mmio-ide")) != NULL;
+	     i++) {
+		int ret = 0;
+		struct resource res[3];
+		struct platform_device *pdev = NULL;
+		static struct mmio_ide_platform_data pdata = {
+			/* TODO: pass via OF? */
+			.byte_lanes_swapping = 0,
+			.regaddr_step        = 2,
+			.mmiops              = mmio_ide_mmiops,
+			.selectproc          = mmio_ide_selectproc,
+		};
+
+		memset(res, 0, sizeof(res));
+
+		ret = of_address_to_resource(np, 0, &res[0]);
+		if (ret) {
+			printk(KERN_ERR "mmio-ide.%d: unable to get "
+			       "resource from OF\n",i );
+			goto err0;
+		}
+
+		ret = of_address_to_resource(np, 1, &res[1]);
+		if (ret) {
+			printk(KERN_ERR "mmio-ide.%d: unable to get "
+			       "resource from OF\n", i);
+			goto err0;
+		}
+
+		res[2].start = res[2].end = irq_of_parse_and_map(np, 0);
+		if (res[2].start == NO_IRQ) {
+			printk(KERN_ERR "mmio-ide.%d: no IRQ\n", i);
+			goto err0;
+		}
+		res[2].name = "mmio-ide";
+		res[2].flags = IORESOURCE_IRQ;;
+
+		pdev = platform_device_alloc("mmio-ide", i);
+		if (!pdev)
+			goto err1;
+
+		ret = platform_device_add_data(pdev, &pdata, sizeof(pdata));
+		if (ret)
+			goto err1;
+
+		ret = platform_device_add_resources(pdev, res, ARRAY_SIZE(res));
+		if (ret)
+			goto err1;
+
+		ret = platform_device_register(pdev);
+		if (ret)
+			goto err1;
+
+		continue;
+err1:
+		printk(KERN_ERR "mmio-ide.%d: registration failed\n", i);
+		platform_device_del(pdev); /* it will free everything */
+err0:
+		/* Even if some device failed, try others */
+		continue;
+	}
+
+	return 0;
+}
+
+arch_initcall(fsl_mmio_ide_of_init);
+
+#endif /* CONFIG_MPC834x_ITX */
