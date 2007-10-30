Return-Path: <Wei.Zhang@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2D629DE1CE
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Oct 2007 20:14:38 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l9U9DtLn014192
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Oct 2007 02:14:26 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l9U9Dovk006218
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Oct 2007 04:13:54 -0500 (CDT)
From: Zhang Wei <wei.zhang@freescale.com>
To: paulus@samba.org
Subject: [PATCH 2/2 v2] Add DMA engine and SOC device support to mpc8641hpcn
	board
Date: Tue, 30 Oct 2007 17:23:49 +0800
Message-Id: <119373623181-git-send-email-wei.zhang@freescale.com>
In-Reply-To: <11937362292747-git-send-email-wei.zhang@freescale.com>
References: <11937362292747-git-send-email-wei.zhang@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add DMA engine and SOC device support to mpc8641hpcn board

Signed-off-by: Zhang Wei <wei.zhang@freescale.com>
Signed-off-by: Ebony Zhu <ebony.zhu@freescale.com>
---
 arch/powerpc/boot/dts/mpc8641_hpcn.dts     |   32 ++++++++++++++++++++++++++++
 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c |   16 ++++++++++++++
 2 files changed, 48 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8641_hpcn.dts b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
index 3677659..ad6c528 100644
--- a/arch/powerpc/boot/dts/mpc8641_hpcn.dts
+++ b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
@@ -380,5 +380,37 @@
 				  01000000 0 00000000
 				  0 00100000>;
 		};
+
+		dma@21000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,mpc8540-dma";
+			reg = <21300 4>;
+			ranges = <0 21100 200>;
+			dma-channel@0 {
+				compatible = "fsl,mpc8540-dma-channel";
+				reg = <0 80>;
+				interrupt-parent = <&mpic>;
+				interrupts = <14 2>;
+			};
+			dma-channel@80 {
+				compatible = "fsl,mpc8540-dma-channel";
+				reg = <80 80>;
+				interrupt-parent = <&mpic>;
+				interrupts = <15 2>;
+			};
+			dma-channel@100 {
+				compatible = "fsl,mpc8540-dma-channel";
+				reg = <100 80>;
+				interrupt-parent = <&mpic>;
+				interrupts = <16 2>;
+			};
+			dma-channel@180 {
+				compatible = "fsl,mpc8540-dma-channel";
+				reg = <180 80>;
+				interrupt-parent = <&mpic>;
+				interrupts = <17 2>;
+			};
+		};
 	};
 };
diff --git a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
index 32a531a..92dcc22 100644
--- a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
+++ b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
@@ -18,6 +18,7 @@
 #include <linux/kdev_t.h>
 #include <linux/delay.h>
 #include <linux/seq_file.h>
+#include <linux/of_platform.h>
 
 #include <asm/system.h>
 #include <asm/time.h>
@@ -227,3 +228,18 @@ define_machine(mpc86xx_hpcn) {
 	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
 #endif
 };
+
+static struct of_device_id mpc86xx_of_ids[] = {
+	{ .type = "soc", },
+	{},
+};
+
+static __init int mpc86xx_of_device_init(void)
+{
+	if (!machine_is(mpc86xx_hpcn))
+		return 0;
+
+	return of_platform_bus_probe(NULL, mpc86xx_of_ids, NULL);
+}
+
+device_initcall(mpc86xx_of_device_init);
-- 
1.5.2
