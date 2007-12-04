Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id BEABBDE177
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Dec 2007 04:03:25 +1100 (EST)
Date: Tue, 4 Dec 2007 20:07:26 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org
Subject: [PATCH v2 3/4] [POWERPC] MPC8349E-mITX: introduce localbus and pata
	nodes
Message-ID: <20071204170726.GC15599@localhost.localdomain>
References: <20071204170442.GA10460@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20071204170442.GA10460@localhost.localdomain>
Cc: Jeff Garzik <jeff@garzik.org>, Arnd Bergmann <arnd@arndb.de>,
	Paul Mundt <lethal@linux-sh.org>, Olof Johansson <olof@lixom.net>
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

Patch also adds code to probe localbus.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/boot/dts/mpc8349emitx.dts    |   18 +++++++++++++++++-
 arch/powerpc/platforms/83xx/mpc834x_itx.c |   17 +++++++++++++++++
 2 files changed, 34 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8349emitx.dts b/arch/powerpc/boot/dts/mpc8349emitx.dts
index 5072f6d..c459b0a 100644
--- a/arch/powerpc/boot/dts/mpc8349emitx.dts
+++ b/arch/powerpc/boot/dts/mpc8349emitx.dts
@@ -249,6 +249,22 @@
 		device_type = "pci";
 	};
 
+	localbus@e0005000 {
+		#address-cells = <2>;
+		#size-cells = <1>;
+		compatible = "fsl,mpc8349emitx-localbus",
+			     "fsl,mpc8349e-localbus",
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
diff --git a/arch/powerpc/platforms/83xx/mpc834x_itx.c b/arch/powerpc/platforms/83xx/mpc834x_itx.c
index aa76819..ea5f176 100644
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
 
+static struct of_device_id mpc834x_itx_ids[] = {
+	{ .name = "localbus", },
+	{},
+};
+
+static int __init mpc834x_itx_declare_of_platform_devices(void)
+{
+	if (!machine_is(mpc834x_itx))
+		return 0;
+
+	of_platform_bus_probe(NULL, mpc834x_itx_ids, NULL);
+
+	return 0;
+}
+device_initcall(mpc834x_itx_declare_of_platform_devices);
+
 /* ************************************************************************
  *
  * Setup the architecture
-- 
1.5.2.2
