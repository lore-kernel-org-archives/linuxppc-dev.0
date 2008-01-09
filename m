Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 1F3F7DDDEB
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jan 2008 06:02:00 +1100 (EST)
Date: Wed, 9 Jan 2008 22:11:05 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org
Subject: [PATCH 3/3] [POWERPC] MPC8349E-mITX: introduce localbus and pata nodes
Message-ID: <20080109191105.GC23283@localhost.localdomain>
References: <20080109190852.GA18827@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20080109190852.GA18827@localhost.localdomain>
Cc: Olof Johansson <olof@lixom.net>, Paul Mundt <lethal@linux-sh.org>,
	Jeff Garzik <jeff@garzik.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds localbus and pata nodes to use CF IDE interface
on MPC8349E-mITX boards.

Patch also updates defconfig and adds some code to probe localbus.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
Acked-by: Olof Johansson <olof@lixom.net>
---
 arch/powerpc/boot/dts/mpc8349emitx.dts     |   17 ++++++++++++++++-
 arch/powerpc/configs/mpc834x_itx_defconfig |    3 ++-
 arch/powerpc/platforms/83xx/mpc834x_itx.c  |   12 ++++++++++++
 3 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8349emitx.dts b/arch/powerpc/boot/dts/mpc8349emitx.dts
index e354f26..06d5b9c 100644
--- a/arch/powerpc/boot/dts/mpc8349emitx.dts
+++ b/arch/powerpc/boot/dts/mpc8349emitx.dts
@@ -253,6 +253,21 @@
 		device_type = "pci";
 	};
 
+	localbus@e0005000 {
+		#address-cells = <2>;
+		#size-cells = <1>;
+		compatible = "fsl,mpc8349e-localbus",
+			     "fsl,pq2pro-localbus";
+		reg = <e0005000 d8>;
+		ranges = <3 0 f0000000 210>;
 
-
+		pata@3,0 {
+			compatible = "fsl,mpc8349emitx-pata", "ata-generic";
+			reg = <3 0 10 3 20c 4>;
+			reg-shift = <1>;
+			pio-mode = <6>;
+			interrupts = <17 8>;
+			interrupt-parent = <&ipic>;
+		};
+	};
 };
diff --git a/arch/powerpc/configs/mpc834x_itx_defconfig b/arch/powerpc/configs/mpc834x_itx_defconfig
index 6feb86e..2fbe4e5 100644
--- a/arch/powerpc/configs/mpc834x_itx_defconfig
+++ b/arch/powerpc/configs/mpc834x_itx_defconfig
@@ -570,7 +570,8 @@ CONFIG_SATA_SIL=y
 # CONFIG_PATA_SIS is not set
 # CONFIG_PATA_VIA is not set
 # CONFIG_PATA_WINBOND is not set
-# CONFIG_PATA_PLATFORM is not set
+CONFIG_PATA_PLATFORM=y
+CONFIG_PATA_OF_PLATFORM=y
 CONFIG_MD=y
 CONFIG_BLK_DEV_MD=y
 CONFIG_MD_LINEAR=y
diff --git a/arch/powerpc/platforms/83xx/mpc834x_itx.c b/arch/powerpc/platforms/83xx/mpc834x_itx.c
index aa76819..50e8f63 100644
--- a/arch/powerpc/platforms/83xx/mpc834x_itx.c
+++ b/arch/powerpc/platforms/83xx/mpc834x_itx.c
@@ -23,6 +23,7 @@
 #include <linux/delay.h>
 #include <linux/seq_file.h>
 #include <linux/root_dev.h>
+#include <linux/of_platform.h>
 
 #include <asm/system.h>
 #include <asm/atomic.h>
@@ -37,6 +38,17 @@
 
 #include "mpc83xx.h"
 
+static struct of_device_id __initdata mpc834x_itx_ids[] = {
+	{ .compatible = "fsl,pq2pro-localbus", },
+	{},
+};
+
+static int __init mpc834x_itx_declare_of_platform_devices(void)
+{
+	return of_platform_bus_probe(NULL, mpc834x_itx_ids, NULL);
+}
+machine_device_initcall(mpc834x_itx, mpc834x_itx_declare_of_platform_devices);
+
 /* ************************************************************************
  *
  * Setup the architecture
-- 
1.5.2.2
