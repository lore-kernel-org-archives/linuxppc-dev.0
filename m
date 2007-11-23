Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 7AB97DDF02
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Nov 2007 04:48:35 +1100 (EST)
Date: Fri, 23 Nov 2007 20:53:56 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org
Subject: [PATCH 3/3] [POWERPC] MPC8349E-mITX: introduce pata node,
	make use pata_of_platform driver
Message-ID: <20071123175356.GC27338@localhost.localdomain>
References: <20071123175229.GA27143@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20071123175229.GA27143@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/boot/dts/mpc8349emitx.dts    |    9 +++++++--
 arch/powerpc/platforms/83xx/mpc834x_itx.c |   17 +++++++++++++++++
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8349emitx.dts b/arch/powerpc/boot/dts/mpc8349emitx.dts
index 5072f6d..898c294 100644
--- a/arch/powerpc/boot/dts/mpc8349emitx.dts
+++ b/arch/powerpc/boot/dts/mpc8349emitx.dts
@@ -249,6 +249,11 @@
 		device_type = "pci";
 	};
 
-
-
+	pata@f0000000 {
+		compatible = "fsl,mpc8349emitx", "pata-platform";
+		reg = <f0000000 10 f000020c 4>;
+		ioport-shift = <1>;
+		interrupts = <17 8>;
+		interrupt-parent = <&ipic>;
+	};
 };
diff --git a/arch/powerpc/platforms/83xx/mpc834x_itx.c b/arch/powerpc/platforms/83xx/mpc834x_itx.c
index aa76819..150fafb 100644
--- a/arch/powerpc/platforms/83xx/mpc834x_itx.c
+++ b/arch/powerpc/platforms/83xx/mpc834x_itx.c
@@ -23,6 +23,7 @@
 #include <linux/delay.h>
 #include <linux/seq_file.h>
 #include <linux/root_dev.h>
+#include <linux/of_platform.h>
 
 #include <asm/system.h>
 #include <asm/atomic.h>
@@ -37,6 +38,22 @@
 
 #include "mpc83xx.h"
 
+static struct of_device_id mpc834x_ids[] = {
+	{ .compatible = "pata-platform", },
+	{},
+};
+
+static int __init mpc834x_declare_of_platform_devices(void)
+{
+	if (!machine_is(mpc834x_itx))
+		return 0;
+
+	of_platform_bus_probe(NULL, mpc834x_ids, NULL);
+
+	return 0;
+}
+device_initcall(mpc834x_declare_of_platform_devices);
+
 /* ************************************************************************
  *
  * Setup the architecture
-- 
1.5.2.2
