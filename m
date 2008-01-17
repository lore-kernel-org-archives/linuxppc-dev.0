Return-Path: <jochen@scram.de>
Received: from mail0.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail0.scram.de", Issuer "scram e.V. CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id A6E19DDE06
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jan 2008 23:32:10 +1100 (EST)
Message-ID: <478F4AE3.5090803@scram.de>
Date: Thu, 17 Jan 2008 13:32:35 +0100
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH/RFCv2] [POWERPC] Add support for freescale watchdog to CPM
	serial driver.
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Cc: Scott Wood <scottwood@freescale.com>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

If a freescale watchdog device node is present, reset the watchdog
while waiting for serial input.

Signed-off-by: Jochen Friedrich <jochen@scram.de>
---
 arch/powerpc/boot/Makefile     |    2 +-
 arch/powerpc/boot/cpm-serial.c |    6 ++++
 arch/powerpc/boot/cuboot-8xx.c |    1 +
 arch/powerpc/boot/ops.h        |    2 +
 arch/powerpc/boot/watchdog.c   |   65 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 75 insertions(+), 1 deletions(-)
 create mode 100644 arch/powerpc/boot/watchdog.c

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index d1e625c..66edf77 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -56,7 +56,7 @@ src-wlib := string.S crt0.S stdio.c main.c \
 		gunzip_util.c elf_util.c $(zlib) devtree.c oflib.c ofconsole.c \
 		4xx.c ebony.c mv64x60.c mpsc.c mv64x60_i2c.c cuboot.c bamboo.c \
 		cpm-serial.c stdlib.c mpc52xx-psc.c planetcore.c uartlite.c \
-		fsl-soc.c mpc8xx.c pq2.c
+		fsl-soc.c mpc8xx.c pq2.c watchdog.c
 src-plat := of.c cuboot-52xx.c cuboot-83xx.c cuboot-85xx.c holly.c \
 		cuboot-ebony.c treeboot-ebony.c prpmc2800.c \
 		ps3-head.S ps3-hvcall.S ps3.c treeboot-bamboo.c cuboot-8xx.c \
diff --git a/arch/powerpc/boot/cpm-serial.c b/arch/powerpc/boot/cpm-serial.c
index 28296fa..56b5fda 100644
--- a/arch/powerpc/boot/cpm-serial.c
+++ b/arch/powerpc/boot/cpm-serial.c
@@ -6,6 +6,9 @@
  *
  * It is assumed that the firmware (or the platform file) has already set
  * up the port.
+ *
+ * If a watchdog node exists, periodically reset the watchdog while waiting
+ * for console input.
  */
 
 #include "types.h"
@@ -154,6 +157,9 @@ static void cpm_serial_putc(unsigned char c)
 
 static unsigned char cpm_serial_tstc(void)
 {
+
+	watchdog_poke();
+
 	barrier();
 	return !(rbdf->sc & 0x8000);
 }
diff --git a/arch/powerpc/boot/cuboot-8xx.c b/arch/powerpc/boot/cuboot-8xx.c
index c202c88..767670e 100644
--- a/arch/powerpc/boot/cuboot-8xx.c
+++ b/arch/powerpc/boot/cuboot-8xx.c
@@ -43,5 +43,6 @@ void platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
 	CUBOOT_INIT();
 	fdt_init(_dtb_start);
 	serial_console_init();
+	watchdog_init();
 	platform_ops.fixups = platform_fixups;
 }
diff --git a/arch/powerpc/boot/ops.h b/arch/powerpc/boot/ops.h
index 6036a98..0701359 100644
--- a/arch/powerpc/boot/ops.h
+++ b/arch/powerpc/boot/ops.h
@@ -86,6 +86,8 @@ int mpsc_console_init(void *devp, struct serial_console_data *scdp);
 int cpm_console_init(void *devp, struct serial_console_data *scdp);
 int mpc5200_psc_console_init(void *devp, struct serial_console_data *scdp);
 int uartlite_console_init(void *devp, struct serial_console_data *scdp);
+void watchdog_poke(void);
+void watchdog_init(void);
 void *simple_alloc_init(char *base, unsigned long heap_size,
 			unsigned long granularity, unsigned long max_allocs);
 extern void flush_cache(void *, unsigned long);
diff --git a/arch/powerpc/boot/watchdog.c b/arch/powerpc/boot/watchdog.c
new file mode 100644
index 0000000..6c50052
--- /dev/null
+++ b/arch/powerpc/boot/watchdog.c
@@ -0,0 +1,65 @@
+/*
+ * PQ Watchdog
+ *
+ * Copyright 2008 Jochen Friedrich <jochen@scram.de>
+ *
+ * Search for PowerQUICC type watchdog devices. Provide a callback to
+ * periodically reset the watchdog while waiting for console input.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#include "types.h"
+#include "io.h"
+#include "ops.h"
+
+struct pq_wdt {
+	u32 res0;
+	u32 swcrr; /* System watchdog control register */
+	u32 swcnr; /* System watchdog count register */
+	u8  res1[2];
+	u16 swsrr; /* System watchdog service register */
+};
+
+static struct pq_wdt *wdt;
+
+void watchdog_poke(void)
+{
+	if (wdt) {
+		out_be16(&wdt->swsrr, 0x556c);
+		out_be16(&wdt->swsrr, 0xaa39);
+	}
+}
+
+void watchdog_init(void)
+{
+	void *reg_virt[2];
+	int n;
+	unsigned long reg_phys;
+	void *watchdog;
+
+	watchdog = finddevice("/soc/wdt");
+	if (watchdog && (dt_is_compatible(watchdog, "fsl,pq1-wdt") ||
+			 dt_is_compatible(watchdog, "fsl,pq2-wdt") ||
+			 dt_is_compatible(watchdog, "fsl,pq2pro-wdt"))) {
+		n = getprop(watchdog, "virtual-reg", reg_virt,
+			 sizeof(reg_virt));
+		if (n < (int)sizeof(reg_virt)) {
+			if (!dt_xlate_reg(watchdog, 0, &reg_phys, NULL))
+				return;
+			reg_virt[0] = (void *)reg_phys;
+		}
+		wdt = reg_virt[0];
+	}
+}
-- 
1.5.3.8
