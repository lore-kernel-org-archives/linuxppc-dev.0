Return-Path: <vbordug@ru.mvista.com>
Received: from localhost.localdomain (cdma-41-194.msk.skylink.ru
	[83.217.41.194])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F2BDE67B14
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Jun 2006 09:46:45 +1000 (EST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.6/8.13.6) with ESMTP id k5NNH7fW006755
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Jun 2006 03:17:08 +0400
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
From: Vitaly Bordug <vbordug@ru.mvista.com>
Subject: [PATCH 5/6] CPM_UART: unify clock sources
Date: Sat, 24 Jun 2006 03:17:07 +0400
Message-Id: <20060623231707.6721.43277.stgit@localhost.localdomain>
In-Reply-To: <20060623231648.6721.3495.stgit@localhost.localdomain>
References: <20060623231648.6721.3495.stgit@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=fixed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


In order to make it possible to utilize the driver from arch/powerpc yet not
breaking existing ppc users, clock sources are unfied via macro, and
resources ioremapped.

Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>
---

 drivers/serial/cpm_uart/cpm_uart_core.c |   11 ++++-------
 drivers/serial/cpm_uart/cpm_uart_cpm2.c |   13 +++++++------
 include/asm-powerpc/fs_pd.h             |   17 +++++++++++++++++
 include/asm-ppc/fs_pd.h                 |   17 +++++++++++++++++
 4 files changed, 45 insertions(+), 13 deletions(-)

diff --git a/drivers/serial/cpm_uart/cpm_uart_core.c b/drivers/serial/cpm_uart/cpm_uart_core.c
index 5cba59a..0507f74 100644
--- a/drivers/serial/cpm_uart/cpm_uart_core.c
+++ b/drivers/serial/cpm_uart/cpm_uart_core.c
@@ -47,6 +47,7 @@ #include <linux/fs_uart_pd.h>
 #include <asm/io.h>
 #include <asm/irq.h>
 #include <asm/delay.h>
+#include <asm/fs_pd.h>
 
 #if defined(CONFIG_SERIAL_CPM_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
 #define SUPPORT_SYSRQ
@@ -1045,11 +1046,11 @@ int cpm_uart_drv_get_platform_data(struc
 
 	if (!(r = platform_get_resource_byname(pdev, IORESOURCE_MEM, "regs")))
 		return -EINVAL;
-	mem = r->start;
+	mem = ioremap(r->start, r->end - r->start + 1);
 
 	if (!(r = platform_get_resource_byname(pdev, IORESOURCE_MEM, "pram")))
 		return -EINVAL;
-	pram = r->start;
+	pram = ioremap(r->start, r->end - r->start + 1);
 
 	if(idx > fsid_smc2_uart) {
 		pinfo->sccp = (scc_t *)mem;
@@ -1190,11 +1191,7 @@ static int __init cpm_uart_console_setup
 	if (options) {
 		uart_parse_options(options, &baud, &parity, &bits, &flow);
 	} else {
-		bd_t *bd = (bd_t *) __res;
-
-		if (bd->bi_baudrate)
-			baud = bd->bi_baudrate;
-		else
+		if ((baud = GET_BAUDRATE()) == -1)
 			baud = 9600;
 	}
 
diff --git a/drivers/serial/cpm_uart/cpm_uart_cpm2.c b/drivers/serial/cpm_uart/cpm_uart_cpm2.c
index cdba128..29b89f0 100644
--- a/drivers/serial/cpm_uart/cpm_uart_cpm2.c
+++ b/drivers/serial/cpm_uart/cpm_uart_cpm2.c
@@ -41,6 +41,7 @@ #include <linux/dma-mapping.h>
 
 #include <asm/io.h>
 #include <asm/irq.h>
+#include <asm/fs_pd.h>
 
 #include <linux/serial_core.h>
 #include <linux/kernel.h>
@@ -267,7 +268,7 @@ #ifdef CONFIG_SERIAL_CPM_SMC1
 	    (unsigned long)&cpm2_immr->im_smc[0];
 	cpm_uart_ports[UART_SMC1].smcp->smc_smcm |= (SMCM_RX | SMCM_TX);
 	cpm_uart_ports[UART_SMC1].smcp->smc_smcmr &= ~(SMCMR_REN | SMCMR_TEN);
-	cpm_uart_ports[UART_SMC1].port.uartclk = (((bd_t *) __res)->bi_intfreq);
+	cpm_uart_ports[UART_SMC1].port.uartclk = FS_UART_CLK();
 	cpm_uart_port_map[cpm_uart_nr++] = UART_SMC1;
 #endif
 
@@ -280,7 +281,7 @@ #ifdef CONFIG_SERIAL_CPM_SMC2
 	    (unsigned long)&cpm2_immr->im_smc[1];
 	cpm_uart_ports[UART_SMC2].smcp->smc_smcm |= (SMCM_RX | SMCM_TX);
 	cpm_uart_ports[UART_SMC2].smcp->smc_smcmr &= ~(SMCMR_REN | SMCMR_TEN);
-	cpm_uart_ports[UART_SMC2].port.uartclk = (((bd_t *) __res)->bi_intfreq);
+	cpm_uart_ports[UART_SMC2].port.uartclk = FS_UART_CLK();
 	cpm_uart_port_map[cpm_uart_nr++] = UART_SMC2;
 #endif
 
@@ -294,7 +295,7 @@ #ifdef CONFIG_SERIAL_CPM_SCC1
 	    ~(UART_SCCM_TX | UART_SCCM_RX);
 	cpm_uart_ports[UART_SCC1].sccp->scc_gsmrl &=
 	    ~(SCC_GSMRL_ENR | SCC_GSMRL_ENT);
-	cpm_uart_ports[UART_SCC1].port.uartclk = (((bd_t *) __res)->bi_intfreq);
+	cpm_uart_ports[UART_SCC1].port.uartclk = FS_UART_CLK();
 	cpm_uart_port_map[cpm_uart_nr++] = UART_SCC1;
 #endif
 
@@ -308,7 +309,7 @@ #ifdef CONFIG_SERIAL_CPM_SCC2
 	    ~(UART_SCCM_TX | UART_SCCM_RX);
 	cpm_uart_ports[UART_SCC2].sccp->scc_gsmrl &=
 	    ~(SCC_GSMRL_ENR | SCC_GSMRL_ENT);
-	cpm_uart_ports[UART_SCC2].port.uartclk = (((bd_t *) __res)->bi_intfreq);
+	cpm_uart_ports[UART_SCC2].port.uartclk = FS_UART_CLK();
 	cpm_uart_port_map[cpm_uart_nr++] = UART_SCC2;
 #endif
 
@@ -322,7 +323,7 @@ #ifdef CONFIG_SERIAL_CPM_SCC3
 	    ~(UART_SCCM_TX | UART_SCCM_RX);
 	cpm_uart_ports[UART_SCC3].sccp->scc_gsmrl &=
 	    ~(SCC_GSMRL_ENR | SCC_GSMRL_ENT);
-	cpm_uart_ports[UART_SCC3].port.uartclk = (((bd_t *) __res)->bi_intfreq);
+	cpm_uart_ports[UART_SCC3].port.uartclk = FS_UART_CLK();
 	cpm_uart_port_map[cpm_uart_nr++] = UART_SCC3;
 #endif
 
@@ -336,7 +337,7 @@ #ifdef CONFIG_SERIAL_CPM_SCC4
 	    ~(UART_SCCM_TX | UART_SCCM_RX);
 	cpm_uart_ports[UART_SCC4].sccp->scc_gsmrl &=
 	    ~(SCC_GSMRL_ENR | SCC_GSMRL_ENT);
-	cpm_uart_ports[UART_SCC4].port.uartclk = (((bd_t *) __res)->bi_intfreq);
+	cpm_uart_ports[UART_SCC4].port.uartclk = FS_UART_CLK();
 	cpm_uart_port_map[cpm_uart_nr++] = UART_SCC4;
 #endif
 
diff --git a/include/asm-powerpc/fs_pd.h b/include/asm-powerpc/fs_pd.h
new file mode 100644
index 0000000..b20d8da
--- /dev/null
+++ b/include/asm-powerpc/fs_pd.h
@@ -0,0 +1,17 @@
+/*
+ * Platform information definitions.
+ *
+ * 2006 (c) MontaVista Software, Inc.
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2. This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+#ifndef FS_PD_H
+#define FS_PD_H
+
+#define GET_BAUDRATE()	get_baudrate()
+#define FS_UART_CLK()	get_intfreq()
+
+#endif
diff --git a/include/asm-ppc/fs_pd.h b/include/asm-ppc/fs_pd.h
new file mode 100644
index 0000000..b1d550b
--- /dev/null
+++ b/include/asm-ppc/fs_pd.h
@@ -0,0 +1,17 @@
+/*
+ * Platform information definitions.
+ *
+ * 2006 (c) MontaVista Software, Inc.
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2. This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+#ifndef FS_PD_H
+#define FS_PD_H
+
+#define GET_BAUDRATE()	(((bd_t *) __res)->bi_baudrate ? ((bd_t *) __res)->bi_baudrate : -1)
+#define FS_UART_CLK()	(((bd_t *) __res)->bi_intfreq)
+
+#endif
