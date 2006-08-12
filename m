Return-Path: <vbordug@ru.mvista.com>
Received: from localhost.localdomain (cdma-45-244.msk.skylink.ru
	[83.217.45.244])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D729A67C14
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Aug 2006 10:20:31 +1000 (EST)
To: Paul Mackerras <paulus@samba.org>
From: Vitaly Bordug <vbordug@ru.mvista.com>
Subject: [PATCH 2/6] CPM_UART: update to make the utilization possible both
	from ppc and powerpc
Date: Sat, 12 Aug 2006 04:10:10 +0400
Message-Id: <20060812001010.6186.77892.stgit@localhost.localdomain>
In-Reply-To: <20060812000655.6186.42738.stgit@localhost.localdomain>
References: <20060812000655.6186.42738.stgit@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=fixed
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Driver core has been updated to make use of the new powerpc OF-inspired
platform devices, yet keeping compatibility to the vast board list from
ppc.

Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>
---

 drivers/serial/cpm_uart/cpm_uart_core.c |   11 ++++-------
 drivers/serial/cpm_uart/cpm_uart_cpm2.c |   13 +++++++------
 include/asm-powerpc/fs_pd.h             |   27 ++++++++++++++++++++++++++
 include/asm-ppc/fs_pd.h                 |   32 +++++++++++++++++++++++++++++++
 4 files changed, 70 insertions(+), 13 deletions(-)

diff --git a/drivers/serial/cpm_uart/cpm_uart_core.c b/drivers/serial/cpm_uart/cpm_uart_core.c
index 90ff96e..dfa06b6 100644
--- a/drivers/serial/cpm_uart/cpm_uart_core.c
+++ b/drivers/serial/cpm_uart/cpm_uart_core.c
@@ -46,6 +46,7 @@ #include <linux/fs_uart_pd.h>
 #include <asm/io.h>
 #include <asm/irq.h>
 #include <asm/delay.h>
+#include <asm/fs_pd.h>
 
 #if defined(CONFIG_SERIAL_CPM_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
 #define SUPPORT_SYSRQ
@@ -1044,11 +1045,11 @@ int cpm_uart_drv_get_platform_data(struc
 
 	if (!(r = platform_get_resource_byname(pdev, IORESOURCE_MEM, "regs")))
 		return -EINVAL;
-	mem = r->start;
+	mem = (u32)ioremap(r->start, r->end - r->start + 1);
 
 	if (!(r = platform_get_resource_byname(pdev, IORESOURCE_MEM, "pram")))
 		return -EINVAL;
-	pram = r->start;
+	pram = (u32)ioremap(r->start, r->end - r->start + 1);
 
 	if(idx > fsid_smc2_uart) {
 		pinfo->sccp = (scc_t *)mem;
@@ -1189,11 +1190,7 @@ static int __init cpm_uart_console_setup
 	if (options) {
 		uart_parse_options(options, &baud, &parity, &bits, &flow);
 	} else {
-		bd_t *bd = (bd_t *) __res;
-
-		if (bd->bi_baudrate)
-			baud = bd->bi_baudrate;
-		else
+		if ((baud = uart_baudrate()) == -1)
 			baud = 9600;
 	}
 
diff --git a/drivers/serial/cpm_uart/cpm_uart_cpm2.c b/drivers/serial/cpm_uart/cpm_uart_cpm2.c
index ef3bb47..02b9ef9 100644
--- a/drivers/serial/cpm_uart/cpm_uart_cpm2.c
+++ b/drivers/serial/cpm_uart/cpm_uart_cpm2.c
@@ -40,6 +40,7 @@ #include <linux/dma-mapping.h>
 
 #include <asm/io.h>
 #include <asm/irq.h>
+#include <asm/fs_pd.h>
 
 #include <linux/serial_core.h>
 #include <linux/kernel.h>
@@ -266,7 +267,7 @@ #ifdef CONFIG_SERIAL_CPM_SMC1
 	    (unsigned long)&cpm2_immr->im_smc[0];
 	cpm_uart_ports[UART_SMC1].smcp->smc_smcm |= (SMCM_RX | SMCM_TX);
 	cpm_uart_ports[UART_SMC1].smcp->smc_smcmr &= ~(SMCMR_REN | SMCMR_TEN);
-	cpm_uart_ports[UART_SMC1].port.uartclk = (((bd_t *) __res)->bi_intfreq);
+	cpm_uart_ports[UART_SMC1].port.uartclk = uart_clock();
 	cpm_uart_port_map[cpm_uart_nr++] = UART_SMC1;
 #endif
 
@@ -279,7 +280,7 @@ #ifdef CONFIG_SERIAL_CPM_SMC2
 	    (unsigned long)&cpm2_immr->im_smc[1];
 	cpm_uart_ports[UART_SMC2].smcp->smc_smcm |= (SMCM_RX | SMCM_TX);
 	cpm_uart_ports[UART_SMC2].smcp->smc_smcmr &= ~(SMCMR_REN | SMCMR_TEN);
-	cpm_uart_ports[UART_SMC2].port.uartclk = (((bd_t *) __res)->bi_intfreq);
+	cpm_uart_ports[UART_SMC2].port.uartclk = uart_clock();
 	cpm_uart_port_map[cpm_uart_nr++] = UART_SMC2;
 #endif
 
@@ -293,7 +294,7 @@ #ifdef CONFIG_SERIAL_CPM_SCC1
 	    ~(UART_SCCM_TX | UART_SCCM_RX);
 	cpm_uart_ports[UART_SCC1].sccp->scc_gsmrl &=
 	    ~(SCC_GSMRL_ENR | SCC_GSMRL_ENT);
-	cpm_uart_ports[UART_SCC1].port.uartclk = (((bd_t *) __res)->bi_intfreq);
+	cpm_uart_ports[UART_SCC1].port.uartclk = uart_clock();
 	cpm_uart_port_map[cpm_uart_nr++] = UART_SCC1;
 #endif
 
@@ -307,7 +308,7 @@ #ifdef CONFIG_SERIAL_CPM_SCC2
 	    ~(UART_SCCM_TX | UART_SCCM_RX);
 	cpm_uart_ports[UART_SCC2].sccp->scc_gsmrl &=
 	    ~(SCC_GSMRL_ENR | SCC_GSMRL_ENT);
-	cpm_uart_ports[UART_SCC2].port.uartclk = (((bd_t *) __res)->bi_intfreq);
+	cpm_uart_ports[UART_SCC2].port.uartclk = uart_clock();
 	cpm_uart_port_map[cpm_uart_nr++] = UART_SCC2;
 #endif
 
@@ -321,7 +322,7 @@ #ifdef CONFIG_SERIAL_CPM_SCC3
 	    ~(UART_SCCM_TX | UART_SCCM_RX);
 	cpm_uart_ports[UART_SCC3].sccp->scc_gsmrl &=
 	    ~(SCC_GSMRL_ENR | SCC_GSMRL_ENT);
-	cpm_uart_ports[UART_SCC3].port.uartclk = (((bd_t *) __res)->bi_intfreq);
+	cpm_uart_ports[UART_SCC3].port.uartclk = uart_clock();
 	cpm_uart_port_map[cpm_uart_nr++] = UART_SCC3;
 #endif
 
@@ -335,7 +336,7 @@ #ifdef CONFIG_SERIAL_CPM_SCC4
 	    ~(UART_SCCM_TX | UART_SCCM_RX);
 	cpm_uart_ports[UART_SCC4].sccp->scc_gsmrl &=
 	    ~(SCC_GSMRL_ENR | SCC_GSMRL_ENT);
-	cpm_uart_ports[UART_SCC4].port.uartclk = (((bd_t *) __res)->bi_intfreq);
+	cpm_uart_ports[UART_SCC4].port.uartclk = uart_clock();
 	cpm_uart_port_map[cpm_uart_nr++] = UART_SCC4;
 #endif
 
diff --git a/include/asm-powerpc/fs_pd.h b/include/asm-powerpc/fs_pd.h
new file mode 100644
index 0000000..d530f68
--- /dev/null
+++ b/include/asm-powerpc/fs_pd.h
@@ -0,0 +1,27 @@
+/*
+ * Platform information definitions.
+ *
+ * 2006 (c) MontaVista Software, Inc.
+ * Vitaly Bordug <vbordug@ru.mvista.com>
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2. This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+#ifndef FS_PD_H
+#define FS_PD_H
+#include <sysdev/fsl_soc.h>
+#include <asm/time.h>
+
+static inline int uart_baudrate(void)
+{
+        return get_baudrate();
+}
+
+static inline int uart_clock(void)
+{
+        return ppc_proc_freq;
+}
+
+#endif
diff --git a/include/asm-ppc/fs_pd.h b/include/asm-ppc/fs_pd.h
new file mode 100644
index 0000000..eed7778
--- /dev/null
+++ b/include/asm-ppc/fs_pd.h
@@ -0,0 +1,32 @@
+/*
+ * Platform information definitions.
+ *
+ * 2006 (c) MontaVista Software, Inc.
+ * Vitaly Bordug <vbordug@ru.mvista.com>
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2. This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+#ifndef FS_PD_H
+#define FS_PD_H
+
+static inline int uart_baudrate(void)
+{
+	int baud;
+	bd_t *bd = (bd_t *) __res;
+
+	if (bd->bi_baudrate)
+		baud = bd->bi_baudrate;
+	else
+		baud = -1;
+	return baud;
+}
+
+static inline int uart_clock(void)
+{
+	return (((bd_t *) __res)->bi_intfreq);
+}
+
+#endif
