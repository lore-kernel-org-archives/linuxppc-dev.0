Return-Path: <glikely@secretlab.ca>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.172])
	by ozlabs.org (Postfix) with ESMTP id 98B51DDEDD
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Aug 2008 16:02:57 +1000 (EST)
Received: by wf-out-1314.google.com with SMTP id 24so5593181wfg.15
	for <linuxppc-dev@ozlabs.org>; Tue, 05 Aug 2008 23:02:56 -0700 (PDT)
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [RFC/PATCH 3/3] powerpc/52xx: add udbg and early debug support for
	PSC serial console
To: linuxppc-dev@ozlabs.org, benh@kernel.crashing.org, paulus@samba.org,
	galak@kernel.crashing.org, jwboyer@linux.vnet.ibm.com
Date: Wed, 06 Aug 2008 00:02:54 -0600
Message-ID: <20080806060249.30717.32997.stgit@trillian.secretlab.ca>
In-Reply-To: <20080806055214.30717.86092.stgit@trillian.secretlab.ca>
References: <20080806055214.30717.86092.stgit@trillian.secretlab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: Grant Likely <glikely@secretlab.ca>
Cc: miltonm@bga.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 arch/powerpc/Kconfig.debug                   |   11 +++
 arch/powerpc/kernel/udbg.c                   |    2 
 arch/powerpc/platforms/52xx/lite5200.c       |    6 +
 arch/powerpc/platforms/52xx/mpc5200_simple.c |    3 +
 arch/powerpc/platforms/52xx/mpc52xx_common.c |  109 ++++++++++++++++++++++++++
 include/asm-powerpc/mpc52xx.h                |    1 
 include/asm-powerpc/udbg.h                   |    1 
 7 files changed, 131 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
index 8c8aadb..26e12d6 100644
--- a/arch/powerpc/Kconfig.debug
+++ b/arch/powerpc/Kconfig.debug
@@ -210,6 +210,12 @@ config PPC_EARLY_DEBUG_40x
 	  inbuilt serial port. This works on chips with a 16550 compatible
 	  UART. Xilinx chips with uartlite cannot use this option.
 
+config PPC_EARLY_DEBUG_5200
+	bool "MPC5200 PSC serial port"
+	depends on PPC_MPC52xx
+	help
+	  Select this to enable early debugging for the Freescale MPC5200 SoC.
+
 config PPC_EARLY_DEBUG_CPM
 	bool "Early serial debugging for Freescale CPM-based serial ports"
 	depends on SERIAL_CPM
@@ -239,6 +245,11 @@ config PPC_EARLY_DEBUG_40x_PHYSADDR
 	depends on PPC_EARLY_DEBUG_40x
 	default "0xef600300"
 
+config PPC_EARLY_DEBUG_5200_PHYSADDR
+	hex "Early debug PSC UART physical address"
+	depends on PPC_EARLY_DEBUG_5200
+	default "0xf0002000"
+
 config PPC_EARLY_DEBUG_CPM_ADDR
 	hex "CPM UART early debug transmit descriptor address"
 	depends on PPC_EARLY_DEBUG_CPM
diff --git a/arch/powerpc/kernel/udbg.c b/arch/powerpc/kernel/udbg.c
index 7d6c9bb..a3a0c13 100644
--- a/arch/powerpc/kernel/udbg.c
+++ b/arch/powerpc/kernel/udbg.c
@@ -57,6 +57,8 @@ void __init udbg_early_init(void)
 #elif defined(CONFIG_PPC_EARLY_DEBUG_40x)
 	/* PPC40x debug */
 	udbg_init_40x_realmode();
+#elif defined(CONFIG_PPC_EARLY_DEBUG_5200)
+	udbg_init_mpc5200();
 #elif defined(CONFIG_PPC_EARLY_DEBUG_CPM)
 	udbg_init_cpm();
 #endif
diff --git a/arch/powerpc/platforms/52xx/lite5200.c b/arch/powerpc/platforms/52xx/lite5200.c
index 6d584f4..0685c2c 100644
--- a/arch/powerpc/platforms/52xx/lite5200.c
+++ b/arch/powerpc/platforms/52xx/lite5200.c
@@ -25,6 +25,7 @@
 #include <asm/machdep.h>
 #include <asm/prom.h>
 #include <asm/mpc52xx.h>
+#include <asm/udbg.h>
 
 /* ************************************************************************
  *
@@ -182,7 +183,8 @@ static int __init lite5200_probe(void)
 	if (!of_flat_dt_is_compatible(node, "fsl,lite5200") &&
 	    !of_flat_dt_is_compatible(node, "fsl,lite5200b"))
 		return 0;
-	pr_debug("%s board found\n", model ? model : "unknown");
+
+	udbg_printf("%s board found\n", model ? model : "unknown");
 
 	return 1;
 }
@@ -191,9 +193,11 @@ define_machine(lite5200) {
 	.name 		= "lite5200",
 	.probe 		= lite5200_probe,
 	.setup_arch 	= lite5200_setup_arch,
+	.init_early	= mpc52xx_udbg_init,
 	.init		= mpc52xx_declare_of_platform_devices,
 	.init_IRQ 	= mpc52xx_init_irq,
 	.get_irq 	= mpc52xx_get_irq,
 	.restart	= mpc52xx_restart,
 	.calibrate_decr	= generic_calibrate_decr,
+	.progress	= udbg_progress,
 };
diff --git a/arch/powerpc/platforms/52xx/mpc5200_simple.c b/arch/powerpc/platforms/52xx/mpc5200_simple.c
index a3bda0b..16daf9d 100644
--- a/arch/powerpc/platforms/52xx/mpc5200_simple.c
+++ b/arch/powerpc/platforms/52xx/mpc5200_simple.c
@@ -30,6 +30,7 @@
 #include <asm/prom.h>
 #include <asm/machdep.h>
 #include <asm/mpc52xx.h>
+#include <asm/udbg.h>
 
 /*
  * Setup the architecture
@@ -78,9 +79,11 @@ define_machine(mpc5200_simple_platform) {
 	.name		= "mpc5200-simple-platform",
 	.probe		= mpc5200_simple_probe,
 	.setup_arch	= mpc5200_simple_setup_arch,
+	.init_early	= mpc52xx_udbg_init,
 	.init		= mpc52xx_declare_of_platform_devices,
 	.init_IRQ	= mpc52xx_init_irq,
 	.get_irq	= mpc52xx_get_irq,
 	.restart	= mpc52xx_restart,
 	.calibrate_decr	= generic_calibrate_decr,
+	.progress	= udbg_progress,
 };
diff --git a/arch/powerpc/platforms/52xx/mpc52xx_common.c b/arch/powerpc/platforms/52xx/mpc52xx_common.c
index 4d5fd1d..dcbeb06 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_common.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_common.c
@@ -10,7 +10,7 @@
  *
  */
 
-#undef DEBUG
+#define DEBUG
 
 #include <linux/kernel.h>
 #include <linux/spinlock.h>
@@ -18,6 +18,18 @@
 #include <asm/io.h>
 #include <asm/prom.h>
 #include <asm/mpc52xx.h>
+#include <asm/udbg.h>
+#include <asm/pgalloc.h>
+#include <mm/mmu_decl.h>
+
+/* Programmable Serial Controller (PSC) status register bits */
+#define MPC52xx_PSC_SR		0x04
+#define MPC52xx_PSC_SR_RXRDY		0x0100
+#define MPC52xx_PSC_SR_RXFULL		0x0200
+#define MPC52xx_PSC_SR_TXRDY		0x0400
+#define MPC52xx_PSC_SR_TXEMP		0x0800
+
+#define MPC52xx_PSC_BUFFER	0x0C
 
 /* MPC5200 device tree match tables */
 static struct of_device_id mpc52xx_xlb_ids[] __initdata = {
@@ -36,6 +48,101 @@ static struct of_device_id mpc52xx_bus_ids[] __initdata = {
 	{}
 };
 
+static struct of_device_id mpc52xx_psc_uart_ids[] __initdata = {
+	{ .compatible = "fsl,mpc5200-psc-uart", },
+};
+
+static void __iomem *psc_console;
+
+static void mpc52xx_udbg_putc(char c)
+{
+	while (!(in_be16(psc_console + MPC52xx_PSC_SR) & MPC52xx_PSC_SR_TXRDY))
+		; /* wait for idle */
+	out_8(psc_console + MPC52xx_PSC_BUFFER, c);
+	if (c == '\n')
+		mpc52xx_udbg_putc('\r');
+}
+
+static int mpc52xx_udbg_getc(void)
+{
+	while (!(in_be16(psc_console + MPC52xx_PSC_SR) & MPC52xx_PSC_SR_RXRDY))
+		; /* wait for char */
+	return in_8(psc_console + MPC52xx_PSC_BUFFER);
+}
+
+static int mpc52xx_udbg_getc_poll(void)
+{
+	if (!(in_be16(psc_console + MPC52xx_PSC_SR) & MPC52xx_PSC_SR_RXRDY))
+		return -1;
+
+	return in_8(psc_console + MPC52xx_PSC_BUFFER);
+}
+
+
+#if defined(CONFIG_PPC_EARLY_DEBUG_5200)
+/**
+ * mpc52xx_udbg_init_early - Set up UDBG for early debug
+ *
+ * Called by udbg code if early debug is configured for the MPC5200
+ */
+void __init udbg_init_mpc5200(void)
+{
+	/* At this point, the bootwrapper or u-boot has already set up the
+	 * serial console correctly.  Assume that it is still configured
+	 * for the correct baud rate */
+
+	/* Map the entire IMMR range  (minimum mapping of 128k) */
+	psc_console = ioremap_bat(0xf0000000, 128<<10);
+	if (!psc_console)
+		return;
+
+	/* Adjust upwards for the base address of the PSC. */
+	psc_console += CONFIG_PPC_EARLY_DEBUG_5200_PHYSADDR - 0xf0000000;
+
+	/* See if it works */
+	mpc52xx_udbg_putc('=');
+
+	udbg_putc = mpc52xx_udbg_putc;
+	udbg_getc = mpc52xx_udbg_getc;
+	udbg_getc_poll = mpc52xx_udbg_getc_poll;
+	udbg_printf("psc_console=%p\n", psc_console);
+}
+#endif
+
+/**
+ * Initialize UDBG based on data in the device tree
+ */
+void __init mpc52xx_udbg_init(void)
+{
+	/* Lookup the console node */
+	struct device_node *stdout_node = of_lookup_stdout();
+	if (!stdout_node)
+		return;
+
+	/* Is this a PSC? */
+	if (!of_match_node(mpc52xx_psc_uart_ids, stdout_node)) {
+		of_node_put(stdout_node);
+		return;
+	}
+
+	/* Map the PSC registers */
+	psc_console = of_iomap(stdout_node, 0);
+	of_node_put(stdout_node);
+	if (!psc_console)
+		return;
+
+	/* See if it works */
+	mpc52xx_udbg_putc('+');
+
+	/* At this point, the bootwrapper or u-boot has already set up the
+	 * serial console correctly.  Assume that it is still configured
+	 * for the correct baud rate */
+	udbg_putc = mpc52xx_udbg_putc;
+	udbg_getc = mpc52xx_udbg_getc;
+	udbg_getc_poll = mpc52xx_udbg_getc_poll;
+	udbg_printf("psc_console=%p\n", psc_console);
+}
+
 /*
  * This variable is mapped in mpc52xx_map_wdt() and used in mpc52xx_restart().
  * Permanent mapping is required because mpc52xx_restart() can be called
diff --git a/include/asm-powerpc/mpc52xx.h b/include/asm-powerpc/mpc52xx.h
index 81ef10b..94e7f22 100644
--- a/include/asm-powerpc/mpc52xx.h
+++ b/include/asm-powerpc/mpc52xx.h
@@ -255,6 +255,7 @@ extern void mpc52xx_declare_of_platform_devices(void);
 extern void mpc52xx_map_common_devices(void);
 extern int mpc52xx_set_psc_clkdiv(int psc_id, int clkdiv);
 extern void mpc52xx_restart(char *cmd);
+extern void __init mpc52xx_udbg_init(void);
 
 /* mpc52xx_pic.c */
 extern void mpc52xx_init_irq(void);
diff --git a/include/asm-powerpc/udbg.h b/include/asm-powerpc/udbg.h
index 6418cee..ea6dd41 100644
--- a/include/asm-powerpc/udbg.h
+++ b/include/asm-powerpc/udbg.h
@@ -49,6 +49,7 @@ extern void __init udbg_init_debug_beat(void);
 extern void __init udbg_init_btext(void);
 extern void __init udbg_init_44x_as1(void);
 extern void __init udbg_init_40x_realmode(void);
+extern void __init udbg_init_mpc5200(void);
 extern void __init udbg_init_cpm(void);
 
 #endif /* __KERNEL__ */
