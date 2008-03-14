Return-Path: <asmirnov@ru.mvista.com>
Received: from spb.rtsoft.ru (unknown [212.176.242.38])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 71668DE1BA
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Mar 2008 01:18:15 +1100 (EST)
Received: from spb.rtsoft.ru (spb.rtsoft.ru [127.0.0.1])
	by spb.rtsoft.ru (8.13.5/8.13.5) with ESMTP id m2EER3be008330
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Mar 2008 17:27:03 +0300
Received: (from alex@localhost)
	by spb.rtsoft.ru (8.13.5/8.13.5/Submit) id m2EER3F7008329
	for linuxppc-dev@ozlabs.org; Fri, 14 Mar 2008 17:27:03 +0300
Date: Fri, 14 Mar 2008 17:27:03 +0300
From: Alexandr Smirnov <asmirnov@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/4] Emerson ATCA-C125 bootwrapper
Message-ID: <20080314142703.GB8228@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080314142220.GA8228@ru.mvista.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Bootwraper for Emerson ATCA-C125 board. This board has
four ethernet ports, so it has to use this code instead
of generic.

Signed-off-by: Alexandr Smirnov <asmirnov@ru.mvista.com>

 b/arch/powerpc/boot/Makefile      |    3 +
 b/arch/powerpc/boot/cuboot-c125.c |   65 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index e3993a6..1d9ffe1 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -64,7 +64,7 @@ src-plat := of.c cuboot-52xx.c cuboot-824x.c cuboot-83xx.c cuboot-85xx.c holly.c
 		cuboot-bamboo.c cuboot-mpc7448hpc2.c cuboot-taishan.c \
 		fixed-head.S ep88xc.c ep405.c \
 		cuboot-katmai.c cuboot-rainier.c redboot-8xx.c ep8248e.c \
-		cuboot-warp.c cuboot-85xx-cpm2.c
+		cuboot-warp.c cuboot-85xx-cpm2.c cuboot-c125.c
 src-boot := $(src-wlib) $(src-plat) empty.c
 
 src-boot := $(addprefix $(obj)/, $(src-boot))
@@ -255,6 +255,7 @@ image-$(CONFIG_TQM8555)			+= cuImage.tqm8555
 image-$(CONFIG_TQM8560)			+= cuImage.tqm8560
 image-$(CONFIG_SBC8548)			+= cuImage.tqm8548
 image-$(CONFIG_SBC8560)			+= cuImage.tqm8560
+image-$(CONFIG_C125)			+= cuImage.c125
 
 # Board ports in arch/powerpc/platform/embedded6xx/Kconfig
 image-$(CONFIG_STORCENTER)		+= cuImage.storcenter
diff --git a/arch/powerpc/boot/cuboot-c125.c b/arch/powerpc/boot/cuboot-c125.c
new file mode 100644
index 0000000..c336a44
--- /dev/null
+++ b/arch/powerpc/boot/cuboot-c125.c
@@ -0,0 +1,65 @@
+/*
+ * Old U-boot compatibility for Emerson ATCA-C125
+ *
+ * Author: Andrei Dolnikov <adolnikov@ru.mvista.com>
+ *         Alexandr Smirnov <asmirnov@ru.mvista.com>
+ *
+ * Based on cuboot-85xx.c by Scott Wood <scottwood@freescale.com>
+ *
+ * 2008 (c) MontaVista, Software, Inc.  This file is licensed under
+ * the terms of the GNU General Public License version 2.  This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ *
+ */
+
+#include "ops.h"
+#include "stdio.h"
+#include "cuboot.h"
+
+#define TARGET_85xx
+#define TARGET_HAS_ETH3
+#include "ppcboot.h"
+
+static bd_t bd;
+
+static void platform_fixups(void)
+{
+	void *soc;
+
+	dt_fixup_memory(bd.bi_memstart, bd.bi_memsize);
+	dt_fixup_mac_address_by_alias("ethernet0", bd.bi_enetaddr);
+	dt_fixup_mac_address_by_alias("ethernet1", bd.bi_enet1addr);
+	dt_fixup_mac_address_by_alias("ethernet2", bd.bi_enet2addr);
+	dt_fixup_mac_address_by_alias("ethernet3", bd.bi_enet3addr);
+	dt_fixup_cpu_clocks(bd.bi_intfreq, bd.bi_busfreq / 8, bd.bi_busfreq);
+
+	/* Unfortunately, the specific model number is encoded in the
+	 * soc node name in existing dts files -- once that is fixed,
+	 * this can do a simple path lookup.
+	 */
+	soc = find_node_by_devtype(NULL, "soc");
+	if (soc) {
+		void *serial = NULL;
+
+		setprop(soc, "bus-frequency", &bd.bi_busfreq,
+			sizeof(bd.bi_busfreq));
+
+		while ((serial = find_node_by_devtype(serial, "serial"))) {
+			if (get_parent(serial) != soc)
+				continue;
+
+			setprop(serial, "clock-frequency", &bd.bi_busfreq,
+				sizeof(bd.bi_busfreq));
+		}
+	}
+}
+
+void platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
+		   unsigned long r6, unsigned long r7)
+{
+	CUBOOT_INIT();
+	fdt_init(_dtb_start);
+	serial_console_init();
+	platform_ops.fixups = platform_fixups;
+}
