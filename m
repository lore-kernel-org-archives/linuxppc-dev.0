Return-Path: <rvinson@mvista.com>
Received: from zipcode.az.mvista.com (unknown [65.200.49.156])
	by ozlabs.org (Postfix) with ESMTP id 2B7FE68A23
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 21 Jan 2006 05:50:57 +1100 (EST)
Received: from [10.50.1.108] (rvinson@linuxbox.az.mvista.com [10.50.1.108])
	by zipcode.az.mvista.com (8.9.3/8.9.3) with ESMTP id LAA15213
	for <linuxppc-embedded@ozlabs.org>; Fri, 20 Jan 2006 11:46:47 -0700
Message-ID: <43D12F99.7090608@mvista.com>
Date: Fri, 20 Jan 2006 11:44:41 -0700
From: Randy Vinson <rvinson@mvista.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: [PATCH] Add support for Freescale 83xx Host Mode USB
Content-Type: multipart/mixed; boundary="------------000504020408060703090102"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------000504020408060703090102
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Greetings,
   The following patch was supposed to have been sent to 
linuxppc-embedded, but ended up on linuxppc-dev (address auto-completion 
goof). So... Here it is as promised.



Greetings,
     I've attached a patch (based on 2.6.16-rc1) which adds Host mode
support for the Dual-Role(DR) and Multi-Port-Host (MPH) USB controllers
found in the Freescale 8349. Note that this patch only provides the
platform-specific code that sets up the external hardware and pin
configuration. The actual DR and MPH controller driver is being posted
on the linux-usb-devel mailing list.

     Using a Freescale 8349CDS reference board, the DR controller was
successfully tested using a USB 2.0 high speed FLASH drive, a USB 1.1
full speed 4-port hub and a Siemens SpeedStream USB to Ethernet adapter.
The MPH controller has been successfully tested with a USB 2.0 high
speed FLASH drive. Attempts to run USB 1.1 devices with the MPH
controller have proven unsuccessful.


           Randy Vinson
           MontaVista Software

--------------000504020408060703090102
Content-Type: text/plain;
 name="8349_usb_platform.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="8349_usb_platform.patch"

Adding platform support for the 834x Host Mode USB controller.

This patch provides the platform-specific hardware setup required by the
83xx Host Mode USB controller on the Freescale 8349CDS reference system.

Signed-off-by: Randy Vinson <rvinson@mvista.com>

---
commit 30b1d2d35237f0367aeceb1bc9f62c9fdc46dbff
tree 64af0c1897f30bb1adb72ecbb6f4c4d0ef619639
parent 2581e186c343cd26802279bd80e420307037fbc6
author Randy Vinson <rvinson@linuxbox.(none)> Tue, 17 Jan 2006 16:32:23 -0700
committer Randy Vinson <rvinson@linuxbox.(none)> Tue, 17 Jan 2006 16:32:23 -0700

 arch/ppc/Kconfig                      |    2 +
 arch/ppc/platforms/83xx/Kconfig       |   28 +++++++++
 arch/ppc/platforms/83xx/mpc834x_sys.c |  100 +++++++++++++++++++++++++++++++++
 arch/ppc/platforms/83xx/mpc834x_sys.h |    3 +
 arch/ppc/syslib/mpc83xx_devices.c     |   16 +++++
 include/asm-ppc/mpc83xx.h             |   17 ++++++
 6 files changed, 166 insertions(+), 0 deletions(-)

diff --git a/arch/ppc/Kconfig b/arch/ppc/Kconfig
index 11899f0..b33b0eb 100644
--- a/arch/ppc/Kconfig
+++ b/arch/ppc/Kconfig
@@ -681,6 +681,8 @@ config EV64360
 	  platform.
 endchoice
 
+source arch/ppc/platforms/83xx/Kconfig
+
 config PQ2ADS
 	bool
 	depends on ADS8272
diff --git a/arch/ppc/platforms/83xx/Kconfig b/arch/ppc/platforms/83xx/Kconfig
new file mode 100644
index 0000000..90bc67a
--- /dev/null
+++ b/arch/ppc/platforms/83xx/Kconfig
@@ -0,0 +1,28 @@
+config 834x_USB_SUPPORT
+	bool "834x USB Support"
+	depends on MPC834x_SYS
+	default y
+	---help---
+	  Enables support for the USB controllers on the MPC834x chip. The 834x
+	  reference board is wired for only one USB port. That port may be
+	  used by either the MPH or DR USB controller.
+	  Requires USB Host EHCI support.
+	  If unsure, say Y.
+choice
+	prompt "834x USB Controller Selection"
+	depends on 834x_USB_SUPPORT
+	default 834x_DR_USB_SUPPORT
+
+config 834x_DR_USB_SUPPORT
+	bool "DR Controller"
+	select USB_EHCI_ROOT_HUB_TT
+	---help---
+	  Select if using the Dual-Role (DR) USB controller.
+
+config 834x_MPH_USB_SUPPORT
+	bool "MPH Controller"
+	---help---
+	  Select if using the Multi-Port-Host (MPH) USB controller.
+
+endchoice
+
diff --git a/arch/ppc/platforms/83xx/mpc834x_sys.c b/arch/ppc/platforms/83xx/mpc834x_sys.c
index 012e1e6..6f23909 100644
--- a/arch/ppc/platforms/83xx/mpc834x_sys.c
+++ b/arch/ppc/platforms/83xx/mpc834x_sys.c
@@ -11,6 +11,9 @@
  * under  the terms of  the GNU General  Public License as published by the
  * Free Software Foundation;  either version 2 of the  License, or (at your
  * option) any later version.
+ *
+ * USB setup added by Randy Vinson <rvinson@mvista.com> based on code from
+ * Hunter Wu.
  */
 
 #include <linux/config.h>
@@ -93,6 +96,99 @@ mpc83xx_exclude_device(u_char bus, u_cha
 }
 #endif /* CONFIG_PCI */
 
+/*
+ * Configure the on-chip USB controller. The MPC834xCDS only supports the
+ * second USB interface (port 1). This code sets up the hardware and then
+ * lets the platform driver take over device setup.
+ */
+
+#ifdef CONFIG_834x_USB_SUPPORT
+void mpc834x_board_init(void)
+{
+	unsigned char __iomem *bcsr;
+	volatile unsigned char *bcsr5_p;
+
+	/*
+	 * if SYS board is plug into PIB board,
+	 * force to use the PHY on SYS board
+	 * */
+	bcsr = ioremap(BCSR_PHYS_ADDR, BCSR_SIZE);
+	bcsr5_p = bcsr + BCSR5_OFF;
+	if ( (*bcsr5_p & BCSR5_INT_USB) == 0 )
+		*bcsr5_p = (*bcsr5_p | BCSR5_INT_USB);
+	iounmap(bcsr);
+}
+
+void mpc834x_usb_clk_cfg(void)
+{
+	unsigned long sccr;
+	volatile unsigned long *p;
+
+	p = (volatile unsigned long *)(VIRT_IMMRBAR + MPC83XX_SCCR_OFFS); /* SCCR */
+	sccr = *p;
+
+	sccr |= MPC83XX_SCCR_USB_MPHCM_11 | MPC83XX_SCCR_USB_DRCM_11;
+
+	*p = sccr;
+}
+
+static void mpc834x_usb_pin_cfg(struct fsl_usb2_platform_data *pdata)
+{
+	unsigned long sicrl;
+	volatile unsigned long *p;
+
+	p = (volatile unsigned long *)(VIRT_IMMRBAR + MPC83XX_SICRL_OFFS); /* SCCR */
+	sicrl = *p;
+
+	/* set both ports to MPH mode */
+	sicrl &= ~(MPC83XX_SICRL_USB0 | MPC83XX_SICRL_USB1);
+
+	if (pdata->operating_mode == FSL_USB2_DR_HOST) {
+		if (pdata->phy_mode == FSL_USB2_PHY_UTMI_WIDE) {
+			/* UTMI WIDE combines both ports into a single 16-bit port */
+			sicrl |= MPC83XX_SICRL_USB0 | MPC83XX_SICRL_USB1;
+		}
+		else {
+			if (pdata->port_enables & FSL_USB2_PORT0_ENABLED)
+				sicrl |= MPC83XX_SICRL_USB0;
+		}
+	}
+	*p = sicrl;
+}
+
+static void __init
+mpc834x_usb_init(void)
+{
+	struct fsl_usb2_platform_data *pdata;
+
+#ifdef CONFIG_834x_DR_USB_SUPPORT
+	ppc_sys_device_remove(MPC83xx_USB2_MPH);
+	pdata = (struct fsl_usb2_platform_data *) ppc_sys_get_pdata(MPC83xx_USB2_DR);
+
+	if (pdata) {
+		pdata->phy_mode = FSL_USB2_PHY_ULPI;
+		pdata->operating_mode = FSL_USB2_DR_HOST;
+		pdata->port_enables = FSL_USB2_PORT0_ENABLED;
+	}
+
+#elif defined(CONFIG_834x_MPH_USB_SUPPORT)
+	ppc_sys_device_remove(MPC83xx_USB2_DR);
+	pdata = (struct fsl_usb2_platform_data *) ppc_sys_get_pdata(MPC83xx_USB2_MPH);
+
+	if (pdata) {
+		pdata->phy_mode = FSL_USB2_PHY_ULPI;
+		pdata->operating_mode = FSL_USB2_MPH_HOST;
+		pdata->port_enables = FSL_USB2_PORT0_ENABLED;
+	}
+
+#endif
+	mpc834x_usb_pin_cfg(pdata);
+	mpc834x_board_init();
+	mpc834x_usb_clk_cfg();
+	return;
+}
+#endif /* CONFIG_834x_USB_SUPPORT */
+
 /* ************************************************************************
  *
  * Setup the architecture
@@ -144,6 +240,10 @@ mpc834x_sys_setup_arch(void)
 		memcpy(pdata->mac_addr, binfo->bi_enet1addr, 6);
 	}
 
+#ifdef CONFIG_834x_USB_SUPPORT
+	mpc834x_usb_init();
+#endif
+
 #ifdef CONFIG_BLK_DEV_INITRD
 	if (initrd_start)
 		ROOT_DEV = Root_RAM0;
diff --git a/arch/ppc/platforms/83xx/mpc834x_sys.h b/arch/ppc/platforms/83xx/mpc834x_sys.h
index 2e514d3..fab3762 100644
--- a/arch/ppc/platforms/83xx/mpc834x_sys.h
+++ b/arch/ppc/platforms/83xx/mpc834x_sys.h
@@ -27,6 +27,9 @@
 #define BCSR_PHYS_ADDR		((uint)0xf8000000)
 #define BCSR_SIZE		((uint)(128 * 1024))
 
+#define BCSR5_OFF		0x05
+#define BCSR5_INT_USB		0x02
+
 #define BCSR_MISC_REG2_OFF	0x07
 #define BCSR_MISC_REG2_PORESET	0x01
 
diff --git a/arch/ppc/syslib/mpc83xx_devices.c b/arch/ppc/syslib/mpc83xx_devices.c
index f9b95de..916926c 100644
--- a/arch/ppc/syslib/mpc83xx_devices.c
+++ b/arch/ppc/syslib/mpc83xx_devices.c
@@ -23,6 +23,8 @@
 #include <asm/ppc_sys.h>
 #include <asm/machdep.h>
 
+static u64 mpc83xx_dma_mask = 0xffffffffULL;
+
 /* We use offsets for IORESOURCE_MEM since we do not know at compile time
  * what IMMRBAR is, will get fixed up by mach_mpc83xx_fixup
  */
@@ -50,6 +52,14 @@ static struct fsl_i2c_platform_data mpc8
 	.device_flags = FSL_I2C_DEV_SEPARATE_DFSRR,
 };
 
+/* Placeholder to be filled in by board code */
+static struct fsl_usb2_platform_data mpc83xx_fsl_dr_pdata = { 
+};
+
+/* Placeholder to be filled in by board code */
+static struct fsl_usb2_platform_data mpc83xx_fsl_mph_pdata = {
+};
+
 static struct plat_serial8250_port serial_platform_data[] = {
 	[0] = {
 		.mapbase	= 0x4500,
@@ -190,7 +200,10 @@ struct platform_device ppc_sys_platform_
 	[MPC83xx_USB2_DR] = {
 		.name = "fsl-usb2-dr",
 		.id	= 1,
+		.dev.platform_data = &mpc83xx_fsl_dr_pdata,
 		.num_resources	 = 2,
+		.dev.dma_mask	= &mpc83xx_dma_mask,
+		.dev.coherent_dma_mask = 0xffffffffULL,
 		.resource = (struct resource[]) {
 			{
 				.start	= 0x23000,
@@ -208,6 +221,9 @@ struct platform_device ppc_sys_platform_
 		.name = "fsl-usb2-mph",
 		.id	= 1,
 		.num_resources	 = 2,
+		.dev.platform_data = &mpc83xx_fsl_mph_pdata,
+		.dev.dma_mask	= &mpc83xx_dma_mask,
+		.dev.coherent_dma_mask = 0xffffffffULL,
 		.resource = (struct resource[]) {
 			{
 				.start	= 0x22000,
diff --git a/include/asm-ppc/mpc83xx.h b/include/asm-ppc/mpc83xx.h
index 7cdf60f..cd2baf7 100644
--- a/include/asm-ppc/mpc83xx.h
+++ b/include/asm-ppc/mpc83xx.h
@@ -95,6 +95,23 @@ extern unsigned char __res[];
 
 #define MPC83xx_CCSRBAR_SIZE	(1024*1024)
 
+#define MPC83XX_SCCR_OFFS          0xA08
+#define MPC83XX_SCCR_USB_MPHCM_11  0x00c00000
+#define MPC83XX_SCCR_USB_MPHCM_01  0x00400000
+#define MPC83XX_SCCR_USB_MPHCM_10  0x00800000
+#define MPC83XX_SCCR_USB_DRCM_11   0x00300000
+#define MPC83XX_SCCR_USB_DRCM_01   0x00100000
+#define MPC83XX_SCCR_USB_DRCM_10   0x00200000
+
+/* system i/o configuration register low */
+#define MPC83XX_SICRL_OFFS         0x114
+#define MPC83XX_SICRL_USB0         0x40000000
+#define MPC83XX_SICRL_USB1         0x20000000
+
+/* system i/o configuration register high */
+#define MPC83XX_SICRH_OFFS         0x118
+#define MPC83XX_SICRH_USB_UTMI     0x00020000
+
 /* Let modules/drivers get at immrbar (physical) */
 extern phys_addr_t immrbar;
 

--------------000504020408060703090102--
