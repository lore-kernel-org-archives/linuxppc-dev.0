Return-Path: <bigeasy@www.tglx.de>
Received: from www.tglx.de (www.tglx.de [62.245.132.106])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2137DDDF7E
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 11 Mar 2008 22:21:15 +1100 (EST)
Date: Tue, 11 Mar 2008 11:39:06 +0100
From: Sebastian Siewior <bigeasy@tglx.de>
To: linuxppc-embedded@ozlabs.org
Subject: [RFC/PATCH] [POWER] mpc85xx_ds add DMA engine to the DT and parse it.
Message-ID: <20080311103906.GD9656@www.tglx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

The DT entry is copy / paste from the documentation.

Signed-off-by: Sebastian Siewior <bigeasy@linutronix.de>
---
 arch/powerpc/boot/dts/mpc8544ds.dts      |   41 ++++++++++++++++++++++++++++++
 arch/powerpc/platforms/85xx/mpc85xx_ds.c |   13 +++++++++
 2 files changed, 54 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8544ds.dts b/arch/powerpc/boot/dts/mpc8544ds.dts
index 688af9d..fdaf793 100644
--- a/arch/powerpc/boot/dts/mpc8544ds.dts
+++ b/arch/powerpc/boot/dts/mpc8544ds.dts
@@ -116,6 +116,47 @@
 			};
 		};
 
+		dma@21300 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,mpc8540-dma", "fsl,eloplus-dma";
+			reg = <21300 4>;
+			ranges = <0 21100 200>;
+			cell-index = <0>;
+			dma-channel@0 {
+				compatible = "fsl,mpc8540-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0 80>;
+				cell-index = <0>;
+				interrupt-parent = <&mpic>;
+				interrupts = <14 2>;
+			};
+			dma-channel@80 {
+				compatible = "fsl,mpc8540-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <80 80>;
+				cell-index = <1>;
+				interrupt-parent = <&mpic>;
+				interrupts = <15 2>;
+			};
+			dma-channel@100 {
+				compatible = "fsl,mpc8540-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <100 80>;
+				cell-index = <2>;
+				interrupt-parent = <&mpic>;
+				interrupts = <16 2>;
+			};
+			dma-channel@180 {
+				compatible = "fsl,mpc8540-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <180 80>;
+				cell-index = <3>;
+				interrupt-parent = <&mpic>;
+				interrupts = <17 2>;
+			};
+		};
+
 		enet0: ethernet@24000 {
 			cell-index = <0>;
 			device_type = "network";
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ds.c b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
index bdb3d0b..b9a3094 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
@@ -19,6 +19,7 @@
 #include <linux/delay.h>
 #include <linux/seq_file.h>
 #include <linux/interrupt.h>
+#include <linux/of_platform.h>
 
 #include <asm/system.h>
 #include <asm/time.h>
@@ -183,6 +184,18 @@ static int __init mpc8544_ds_probe(void)
 	}
 }
 
+static struct of_device_id mpc85xxds_ids[] = {
+	{ .type = "soc", },
+	{ .compatible = "soc", },
+	{},
+};
+
+static int __init mpc85xxds_publish_devices(void)
+{
+	return of_platform_bus_probe(NULL, mpc85xxds_ids, NULL);
+}
+machine_device_initcall(mpc8544_ds, mpc85xxds_publish_devices);
+
 /*
  * Called very early, device-tree isn't unflattened
  */
-- 
1.5.4.3
