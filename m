Return-Path: <jochen@scram.de>
Received: from mail0.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail0.scram.de", Issuer "scram e.V. CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 7851EDDDFF
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Dec 2007 02:17:50 +1100 (EST)
Message-ID: <477513CC.3060109@scram.de>
Date: Fri, 28 Dec 2007 16:18:36 +0100
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH/RFC] Add support for freescale watchdog to CPM serial driver.
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
 arch/powerpc/boot/cpm-serial.c |   33 ++++++++++++++++++++++++++++++++-
 1 files changed, 32 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/boot/cpm-serial.c b/arch/powerpc/boot/cpm-serial.c
index 28296fa..d85f038 100644
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
@@ -50,7 +53,16 @@ struct cpm_bd {
 	u8 *addr; /* Buffer address in host memory */
 };
 
+struct pq_wdt {
+	u32 res0;
+	u32 swcrr; /* System watchdog control register */
+	u32 swcnr; /* System watchdog count register */
+	u8  res1[2];
+	u16 swsrr; /* System watchdog service register */
+};
+
 static void *cpcr;
+static struct pq_wdt *wdt;
 static struct cpm_param *param;
 static struct cpm_smc *smc;
 static struct cpm_scc *scc;
@@ -154,6 +166,11 @@ static void cpm_serial_putc(unsigned char c)
 
 static unsigned char cpm_serial_tstc(void)
 {
+	if (wdt) {
+		out_be16(&wdt->swsrr, 0x556c);
+		out_be16(&wdt->swsrr, 0xaa39);
+	}
+
 	barrier();
 	return !(rbdf->sc & 0x8000);
 }
@@ -178,7 +195,7 @@ int cpm_console_init(void *devp, struct serial_console_data *scdp)
 	void *reg_virt[2];
 	int is_smc = 0, is_cpm2 = 0, n;
 	unsigned long reg_phys;
-	void *parent, *muram;
+	void *parent, *muram, *watchdog;
 
 	if (dt_is_compatible(devp, "fsl,cpm1-smc-uart")) {
 		is_smc = 1;
@@ -260,6 +277,20 @@ int cpm_console_init(void *devp, struct serial_console_data *scdp)
 	if (n < 4)
 		return -1;
 
+	watchdog = finddevice("/soc/wdt");
+	if (watchdog && (dt_is_compatible(watchdog, "fsl,pq1-wdt") ||
+			 dt_is_compatible(watchdog, "fsl,pq2-wdt") ||
+			 dt_is_compatible(watchdog, "fsl,pq2pro-wdt"))) {
+		n = getprop(watchdog, "virtual-reg", reg_virt,
+			 sizeof(reg_virt));
+		if (n < (int)sizeof(reg_virt)) {
+			if (!dt_xlate_reg(watchdog, 0, &reg_phys, NULL))
+				return -1;
+			reg_virt[0] = (void *)reg_phys;
+		}
+		wdt = reg_virt[0];
+	}
+
 	scdp->open = cpm_serial_open;
 	scdp->putc = cpm_serial_putc;
 	scdp->getc = cpm_serial_getc;
-- 
1.5.3.7
