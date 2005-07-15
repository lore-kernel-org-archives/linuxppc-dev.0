Return-Path: <galak@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id D116B67CE3
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 15 Jul 2005 13:21:24 +1000 (EST)
Date: Thu, 14 Jul 2005 22:21:05 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
To: Andrew Morton <akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0507142213190.14976@nylon.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: [PATCH] ppc32: Make the UARTs on MPC824x individual platform devices
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

The UARTs on the MPC824x are unique devices and really shouldn't be
thought of as a DUART.  In addition, if both UARTs are in use we need
to configure the part to enable the 2nd UART since the pins for the
UARTs are multiplexed.  Adds support to run the 824x Sandpoint with
both UARTs if desired.

Signed-off-by: Matt McClintock <msm@freescale.com>
Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
commit fe6f929c51bca1f8a2c8f645fc6cb63b86200cf8
tree c10a1ef20ad36bca6324ea9438815f70c0e9b20a
parent 06c8f2c3113bf5cba59adbdc60949b76b0943316
author Kumar K. Gala <kumar.gala@freescale.com> Thu, 14 Jul 2005 22:20:25 -0500
committer Kumar K. Gala <kumar.gala@freescale.com> Thu, 14 Jul 2005 22:20:25 -0500

 arch/ppc/Kconfig                     |    7 ++++
 arch/ppc/configs/sandpoint_defconfig |    2 +
 arch/ppc/platforms/sandpoint.c       |   17 ++++++----
 arch/ppc/syslib/mpc10x_common.c      |   57 +++++++++++++++++++++++++++-------
 include/asm-ppc/mpc10x.h             |    3 +-
 5 files changed, 65 insertions(+), 21 deletions(-)

diff --git a/arch/ppc/Kconfig b/arch/ppc/Kconfig
--- a/arch/ppc/Kconfig
+++ b/arch/ppc/Kconfig
@@ -878,6 +878,13 @@ config MPC10X_STORE_GATHERING
 	bool "Enable MPC10x store gathering"
 	depends on MPC10X_BRIDGE
 
+config SANDPOINT_ENABLE_UART1
+	bool "Enable DUART mode on Sandpoint"
+	depends on SANDPOINT
+	help
+	  If this option is enabled then the MPC824x processor will run
+	  in DUART mode instead of UART mode.
+
 config CPC710_DATA_GATHERING
 	bool "Enable CPC710 data gathering"
 	depends on K2
diff --git a/arch/ppc/configs/sandpoint_defconfig b/arch/ppc/configs/sandpoint_defconfig
--- a/arch/ppc/configs/sandpoint_defconfig
+++ b/arch/ppc/configs/sandpoint_defconfig
@@ -437,7 +437,7 @@ CONFIG_SOUND_GAMEPORT=y
 #
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
-CONFIG_SERIAL_8250_NR_UARTS=2
+CONFIG_SERIAL_8250_NR_UARTS=4
 # CONFIG_SERIAL_8250_EXTENDED is not set
 
 #
diff --git a/arch/ppc/platforms/sandpoint.c b/arch/ppc/platforms/sandpoint.c
--- a/arch/ppc/platforms/sandpoint.c
+++ b/arch/ppc/platforms/sandpoint.c
@@ -311,19 +311,22 @@ sandpoint_setup_arch(void)
 	{
 		bd_t *bp = (bd_t *)__res;
 		struct plat_serial8250_port *pdata;
-		pdata = (struct plat_serial8250_port *) ppc_sys_get_pdata(MPC10X_DUART);
 
+		pdata = (struct plat_serial8250_port *) ppc_sys_get_pdata(MPC10X_UART0);
 		if (pdata)
 		{
 			pdata[0].uartclk = bp->bi_busfreq;
-			pdata[0].membase = ioremap(pdata[0].mapbase, 0x100);
+		}
 
-			/* this disables the 2nd serial port on the DUART
-			 * since the sandpoint does not have it connected */
-			pdata[1].uartclk = 0;
-			pdata[1].irq = 0;
-			pdata[1].mapbase = 0;
+#ifdef CONFIG_SANDPOINT_ENABLE_UART1		
+		pdata = (struct plat_serial8250_port *) ppc_sys_get_pdata(MPC10X_UART1);
+		if (pdata)
+		{
+			pdata[0].uartclk = bp->bi_busfreq;
 		}
+#else
+		ppc_sys_device_remove(MPC10X_UART1);
+#endif
 	}
 
 	printk(KERN_INFO "Motorola SPS Sandpoint Test Platform\n");
diff --git a/arch/ppc/syslib/mpc10x_common.c b/arch/ppc/syslib/mpc10x_common.c
--- a/arch/ppc/syslib/mpc10x_common.c
+++ b/arch/ppc/syslib/mpc10x_common.c
@@ -45,24 +45,29 @@
 #define MPC10X_DMA0_IRQ (EPIC_IRQ_BASE + 1 + NUM_8259_INTERRUPTS)
 #define MPC10X_DMA1_IRQ (EPIC_IRQ_BASE + 2 + NUM_8259_INTERRUPTS)
 #define MPC10X_UART0_IRQ (EPIC_IRQ_BASE + 4 + NUM_8259_INTERRUPTS)
+#define MPC10X_UART1_IRQ (EPIC_IRQ_BASE + 5 + NUM_8259_INTERRUPTS)
 #else
 #define MPC10X_I2C_IRQ -1
 #define MPC10X_DMA0_IRQ -1
 #define MPC10X_DMA1_IRQ -1
 #define MPC10X_UART0_IRQ -1
+#define MPC10X_UART1_IRQ -1
 #endif
 
 static struct fsl_i2c_platform_data mpc10x_i2c_pdata = {
 	.device_flags		= 0,
 };
 
-static struct plat_serial8250_port serial_platform_data[] = {
+static struct plat_serial8250_port serial_plat_uart0[] = {
 	[0] = {
 		.mapbase	= 0x4500,
 		.iotype		= UPIO_MEM,
 		.flags		= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST,
 	},
-	[1] = {
+	{ },
+};
+static struct plat_serial8250_port serial_plat_uart1[] = {
+	[0] = {
 		.mapbase	= 0x4600,
 		.iotype		= UPIO_MEM,
 		.flags		= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST,
@@ -133,11 +138,17 @@ struct platform_device ppc_sys_platform_
 			},
 		},
 	},
-	[MPC10X_DUART] = {
+	[MPC10X_UART0] = {
 		.name = "serial8250",
 		.id	= 0,
-		.dev.platform_data = serial_platform_data,
+		.dev.platform_data = serial_plat_uart0,
 	},
+	[MPC10X_UART1] = {
+		.name = "serial8250",
+		.id	= 1,
+		.dev.platform_data = serial_plat_uart1,
+	},
+	
 };
 
 /* We use the PCI ID to match on */
@@ -147,10 +158,10 @@ struct ppc_sys_spec ppc_sys_specs[] = {
 		.ppc_sys_name 	= "8245",
 		.mask		= 0xFFFFFFFF,
 		.value		= MPC10X_BRIDGE_8245,
-		.num_devices	= 4,
+		.num_devices	= 5,
 		.device_list	= (enum ppc_sys_devices[])
 		{
-			MPC10X_IIC1, MPC10X_DMA0, MPC10X_DMA1, MPC10X_DUART,
+			MPC10X_IIC1, MPC10X_DMA0, MPC10X_DMA1, MPC10X_UART0, MPC10X_UART1,
 		},
 	},
 	{
@@ -180,6 +191,25 @@ struct ppc_sys_spec ppc_sys_specs[] = {
 	},
 };
 
+/*
+ * mach_mpc10x_fixup: This function enables DUART mode if it detects
+ * if it detects two UARTS in the platform device entries.
+ */
+static int __init mach_mpc10x_fixup(struct platform_device *pdev)
+{
+	if (strncmp (pdev->name, "serial8250", 10) == 0 && pdev->id == 1)
+		writeb(readb(serial_plat_uart1[0].membase + 0x11) | 0x1,
+				serial_plat_uart1[0].membase + 0x11);
+	return 0;
+}
+
+static int __init mach_mpc10x_init(void)
+{
+	ppc_sys_device_fixup = mach_mpc10x_fixup;
+	return 0;
+}
+postcore_initcall(mach_mpc10x_init);
+
 /* Set resources to match bridge memory map */
 void __init
 mpc10x_bridge_set_resources(int map, struct pci_controller *hose)
@@ -219,6 +249,7 @@ mpc10x_bridge_set_resources(int map, str
 				ppc_md.progress("mpc10x:exit1", 0x100);
 	}
 }
+
 /*
  * Do some initialization and put the EUMB registers at the specified address
  * (also map the EPIC registers into virtual space--OpenPIC_Addr will be set).
@@ -411,12 +442,14 @@ mpc10x_bridge_init(struct pci_controller
 	ppc_sys_platform_devices[MPC10X_DMA1].resource[1].start = MPC10X_DMA1_IRQ;
 	ppc_sys_platform_devices[MPC10X_DMA1].resource[1].end = MPC10X_DMA1_IRQ;
 
-	serial_platform_data[0].mapbase += phys_eumb_base;
-	serial_platform_data[0].irq = MPC10X_UART0_IRQ;
-
-	serial_platform_data[1].mapbase += phys_eumb_base;
-	serial_platform_data[1].irq = MPC10X_UART0_IRQ + 1;
-
+	serial_plat_uart0[0].mapbase += phys_eumb_base;
+	serial_plat_uart0[0].irq = MPC10X_UART0_IRQ;
+	serial_plat_uart0[0].membase = ioremap(serial_plat_uart0[0].mapbase, 0x100);
+
+	serial_plat_uart1[0].mapbase += phys_eumb_base;
+	serial_plat_uart1[0].irq = MPC10X_UART1_IRQ;
+	serial_plat_uart1[0].membase = ioremap(serial_plat_uart1[0].mapbase, 0x100);
+	
 	/*
 	 * 8240 erratum 26, 8241/8245 erratum 29, 107 erratum 23: speculative
 	 * PCI reads may return stale data so turn off.
diff --git a/include/asm-ppc/mpc10x.h b/include/asm-ppc/mpc10x.h
--- a/include/asm-ppc/mpc10x.h
+++ b/include/asm-ppc/mpc10x.h
@@ -163,7 +163,8 @@ enum ppc_sys_devices {
 	MPC10X_IIC1,
 	MPC10X_DMA0,
 	MPC10X_DMA1,
-	MPC10X_DUART,
+	MPC10X_UART0,
+	MPC10X_UART1,
 };
 
 int mpc10x_bridge_init(struct pci_controller *hose,
