Return-Path: <domen.puncer@telargo.com>
Received: from out002.atlarge.net (out002.atlarge.net [129.41.63.60])
	by ozlabs.org (Postfix) with ESMTP id D0859DDDF4
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 23 Jan 2007 20:33:44 +1100 (EST)
Date: Tue, 23 Jan 2007 10:33:39 +0100
From: Domen Puncer <domen.puncer@telargo.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: [RFC PATCHES] lite5200b low power mode works
Message-ID: <20070123093339.GF4397@moe.telargo.com>
References: <20061222105404.GC2481@moe.telargo.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="lMM8JwqTlfDpEaS6"
In-Reply-To: <20061222105404.GC2481@moe.telargo.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


--lMM8JwqTlfDpEaS6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 22/12/06 11:54 +0100, Domen Puncer wrote:
> Hi!
> 
> I have managed to implement low power mode... well, to some
> degree, at least.

And now, I can't break it anymore, it works every time on my
setup. :-)

How to use?
Patch u-boot, Linux. Run it. echo mem > /sys/power/state .


Patches in order they apply:
u-boot.patch
	wakeup ram from self-refresh and jump to kernel wakeup code
fec_platform_fix
sdma_platform_fix
	since these are platform drivers (.bus = ...), they need
	to have the proper structs so suspend_late will work
uart_sport_fix
	a typo fix in suspend code
sram_executable
	don't guard SRAM, since we execute some code from it
low_power_mode
	"main" patch, with suspend, self-refresh and resume code
suspend_arch_code_non-init
	call ppc_md.setup_arch() on resume
suspend_pic
	suspend and resume pic
uart_smaller_delay
	because 5 seconds delay is a bit long
suspend_bestcomm
	save/restore SRAM and bestcomm registers
suspend_fec
	fec suspend/resume



Update from previous patch:
the correct sequence for self-refresh seems to be:
mode_en = 1
soft_pre = 1
mode_en = 0, soft_pre = 0
ref_en = 1, cke = 0

Note the "mode_en = 0", I couldn't find it documented anywhere, and
even in freescale's examples it's missing.


I'm planning on porting this to Grant/Sylvain's arch/powerpc mpc52xx
tree soon.

Any comments are very appreaciated.


	Domen

--lMM8JwqTlfDpEaS6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="u-boot.patch"

diff --git a/board/icecube/icecube.c b/board/icecube/icecube.c
index 4f056b2..3a52557 100644
--- a/board/icecube/icecube.c
+++ b/board/icecube/icecube.c
@@ -38,6 +38,154 @@ # else
 #include "mt48lc16m16a2-75.h"
 # endif
 #endif
+
+#ifdef CONFIG_LITE5200B
+/* u-boot part of low-power mode implementation */
+#define SAVED_ADDR 0x00000000
+#define SDRAM_CONTROLW (SDRAM_CONTROL & ~0x50000000) /* !ref_en !cke */
+
+static void wakeup_sdram()
+{
+	long hi_addr_bit = 0x01000000;
+
+	/* unlock mode register */
+	*(vu_long *)MPC5XXX_SDRAM_CTRL = SDRAM_CONTROLW | 0x80000000;
+	__asm__ volatile ("sync");
+
+	/* precharge all banks */
+	*(vu_long *)MPC5XXX_SDRAM_CTRL = SDRAM_CONTROLW | 0x80000002;
+	__asm__ volatile ("sync");
+
+#if SDRAM_DDR
+	/* set mode register: extended mode */
+	*(vu_long *)MPC5XXX_SDRAM_MODE = SDRAM_EMODE;
+	__asm__ volatile ("sync");
+
+	/* set mode register: reset DLL */
+	*(vu_long *)MPC5XXX_SDRAM_MODE = SDRAM_MODE | 0x04000000;
+	__asm__ volatile ("sync");
+#endif
+
+	/* precharge all banks */
+	*(vu_long *)MPC5XXX_SDRAM_CTRL = SDRAM_CONTROLW | 0x80000002;
+	__asm__ volatile ("sync");
+
+	/* auto refresh */
+	*(vu_long *)MPC5XXX_SDRAM_CTRL = SDRAM_CONTROLW | 0x80000004;
+	__asm__ volatile ("sync");
+
+	/* set mode register */
+	*(vu_long *)MPC5XXX_SDRAM_MODE = SDRAM_MODE;
+	__asm__ volatile ("sync");
+
+
+	/* the second bank too */
+	/* unlock mode register */
+	*(vu_long *)MPC5XXX_SDRAM_CTRL = SDRAM_CONTROLW | 0x80000000 | hi_addr_bit;
+	__asm__ volatile ("sync");
+
+	/* precharge all banks */
+	*(vu_long *)MPC5XXX_SDRAM_CTRL = SDRAM_CONTROLW | 0x80000002 | hi_addr_bit;
+	__asm__ volatile ("sync");
+
+#if SDRAM_DDR
+	/* set mode register: extended mode */
+	*(vu_long *)MPC5XXX_SDRAM_MODE = SDRAM_EMODE;
+	__asm__ volatile ("sync");
+
+	/* set mode register: reset DLL */
+	*(vu_long *)MPC5XXX_SDRAM_MODE = SDRAM_MODE | 0x04000000;
+	__asm__ volatile ("sync");
+#endif
+
+	/* precharge all banks */
+	*(vu_long *)MPC5XXX_SDRAM_CTRL = SDRAM_CONTROLW | 0x80000002 | hi_addr_bit;
+	__asm__ volatile ("sync");
+
+	/* auto refresh */
+	*(vu_long *)MPC5XXX_SDRAM_CTRL = SDRAM_CONTROLW | 0x80000004 | hi_addr_bit;
+	__asm__ volatile ("sync");
+
+	/* set mode register */
+	*(vu_long *)MPC5XXX_SDRAM_MODE = SDRAM_MODE;
+	__asm__ volatile ("sync");
+
+
+	/* out of self refresh */
+	/* ref_en, cke, out of self refresh */
+	*(vu_long *)MPC5XXX_SDRAM_CTRL = SDRAM_CONTROLW | 0x80000000 | 0x50000000;
+	__asm__ volatile ("sync");
+
+	/* normal operation */
+	*(vu_long *)MPC5XXX_SDRAM_CTRL = SDRAM_CONTROLW | 0x50000000;
+	__asm__ volatile ("sync");
+
+	/* second bank too */
+	/* ref_en, cke, out of self refresh */
+	*(vu_long *)MPC5XXX_SDRAM_CTRL = SDRAM_CONTROLW | 0x80000000 | 0x50000000 | hi_addr_bit;
+	__asm__ volatile ("sync");
+
+	/* normal operation */
+	*(vu_long *)MPC5XXX_SDRAM_CTRL = SDRAM_CONTROLW | 0x50000000 | hi_addr_bit;
+	__asm__ volatile ("sync");
+}
+
+static void lite5200b_wakeup(void)
+{
+	unsigned char wakeup_pin;
+	void (*linux_wakeup)(void);
+
+	/* check PSC2_4, if it's down "QT" is signaling we have a wakeup
+	 * from low power mode */
+	*(vu_char *)MPC5XXX_WU_GPIO_ENABLE = 0x02;
+	__asm__ volatile ("sync");
+
+	wakeup_pin = *(vu_char *)MPC5XXX_WU_GPIO_DATA_I;
+	if (wakeup_pin & 0x02)
+		return;
+
+	/* acknowledge to "QT"
+	 * by holding pin at 1 for 10 uS */
+	*(vu_char *)MPC5XXX_WU_GPIO_DIR = 0x02;
+	__asm__ volatile ("sync");
+	*(vu_char *)MPC5XXX_WU_GPIO_DATA = 0x02;
+	__asm__ volatile ("sync");
+	udelay(10);
+
+	/* setup SDRAM chip selects */
+	/* 2 128 mb chips */
+	*(vu_long *)MPC5XXX_SDRAM_CS0CFG = 0x0000001a;/* 128mb at 0x0 */
+	*(vu_long *)MPC5XXX_SDRAM_CS1CFG = 0x0800001a;/* 128mb at 0x08000000 */
+	__asm__ volatile ("sync");
+
+	/* setup config registers */
+	*(vu_long *)MPC5XXX_SDRAM_CONFIG1 = SDRAM_CONFIG1;
+	*(vu_long *)MPC5XXX_SDRAM_CONFIG2 = SDRAM_CONFIG2;
+	__asm__ volatile ("sync");
+
+	/* set tap delay */
+	*(vu_long *)MPC5XXX_CDM_PORCFG = SDRAM_TAPDELAY;
+	__asm__ volatile ("sync");
+
+	*(vu_long *)MPC5XXX_SDRAM_SDELAY = 0x04;
+	__asm__ volatile ("sync");
+
+	wakeup_sdram(0);
+	wakeup_sdram(1);
+	udelay(10); /* wait a bit */
+
+	linux_wakeup = *(unsigned long *)SAVED_ADDR;
+
+	/* jump back to linux kernel code */
+	printf("\n\nLooks like we just woke, transferring control to 0x%08lx\n",
+			linux_wakeup);
+	linux_wakeup();
+}
+#else
+#define lite5200b_wakeup
+#endif
+
+
 #ifndef CFG_RAMBOOT
 static void sdram_start (int hi_addr)
 {
@@ -92,6 +240,8 @@ long int initdram (int board_type)
 	ulong dramsize2 = 0;
 	uint svr, pvr;
 
+	lite5200b_wakeup();
+
 #ifndef CFG_RAMBOOT
 	ulong test1, test2;
 
diff --git a/include/mpc5xxx.h b/include/mpc5xxx.h
index 1d20d1d..c7eb090 100644
--- a/include/mpc5xxx.h
+++ b/include/mpc5xxx.h
@@ -189,6 +189,7 @@ #define MPC5XXX_WU_GPIO_ENABLE  (MPC5XXX
 #define MPC5XXX_WU_GPIO_ODE     (MPC5XXX_WU_GPIO + 0x0004)
 #define MPC5XXX_WU_GPIO_DIR     (MPC5XXX_WU_GPIO + 0x0008)
 #define MPC5XXX_WU_GPIO_DATA    (MPC5XXX_WU_GPIO + 0x000c)
+#define MPC5XXX_WU_GPIO_DATA_I  (MPC5XXX_WU_GPIO + 0x0020)
 
 /* PCI registers */
 #define MPC5XXX_PCI_CMD		(MPC5XXX_PCI + 0x04)

--lMM8JwqTlfDpEaS6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=fec_platform_fix

Index: work-powerpc.git/drivers/net/fec_mpc52xx/fec.c
===================================================================
--- work-powerpc.git.orig/drivers/net/fec_mpc52xx/fec.c
+++ work-powerpc.git/drivers/net/fec_mpc52xx/fec.c
@@ -553,10 +553,9 @@ static void fec_reinit(struct net_device
 /* ======================================================================== */
 
 static int __devinit
-mpc52xx_fec_probe(struct device *dev)
+mpc52xx_fec_probe(struct platform_device *pdev)
 {
 	int ret;
-	struct platform_device *pdev = to_platform_device(dev);
 	struct net_device *ndev;
 	struct fec_priv *priv = NULL;
 	struct resource *mem;
@@ -680,7 +679,7 @@ mpc52xx_fec_probe(struct device *dev)
 	fec_mii_init(ndev);
 
 	/* We're done ! */
-	dev_set_drvdata(dev, ndev);
+	platform_set_drvdata(pdev, ndev);
 
 	return 0;
 
@@ -707,12 +706,11 @@ probe_error:
 }
 
 static int
-mpc52xx_fec_remove(struct device *dev)
+mpc52xx_fec_remove(struct platform_device *pdev)
 {
-	struct net_device *ndev;
+	struct net_device *ndev = platform_get_drvdata(pdev);
 	struct fec_priv *priv;
 
-	ndev = (struct net_device *) dev_get_drvdata(dev);
 	if (!ndev)
 		return 0;
 	priv = (struct fec_priv *) ndev->priv;
@@ -729,19 +727,20 @@ mpc52xx_fec_remove(struct device *dev)
 
 	free_netdev(ndev);
 
-	dev_set_drvdata(dev, NULL);
+	platform_set_drvdata(pdev, NULL);
 	return 0;
 }
 
-static struct device_driver mpc52xx_fec_driver = {
-	.name	  = DRIVER_NAME,
-	.bus		= &platform_bus_type,
+static struct platform_driver mpc52xx_fec_driver = {
 	.probe		= mpc52xx_fec_probe,
 	.remove		= mpc52xx_fec_remove,
 #ifdef CONFIG_PM
 /*	.suspend	= mpc52xx_fec_suspend,	TODO */
 /*	.resume		= mpc52xx_fec_resume,	TODO */
 #endif
+	.driver	= {
+		.name	  = DRIVER_NAME,
+	},
 };
 
 /* ======================================================================== */
@@ -751,13 +750,13 @@ static struct device_driver mpc52xx_fec_
 static int __init
 mpc52xx_fec_init(void)
 {
-	return driver_register(&mpc52xx_fec_driver);
+	return platform_driver_register(&mpc52xx_fec_driver);
 }
 
 static void __exit
 mpc52xx_fec_exit(void)
 {
-	driver_unregister(&mpc52xx_fec_driver);
+	platform_driver_unregister(&mpc52xx_fec_driver);
 }
 
 

--lMM8JwqTlfDpEaS6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=sdma_platform_fix

Index: work-powerpc.git/arch/ppc/syslib/bestcomm/bestcomm.c
===================================================================
--- work-powerpc.git.orig/arch/ppc/syslib/bestcomm/bestcomm.c
+++ work-powerpc.git/arch/ppc/syslib/bestcomm/bestcomm.c
@@ -264,9 +264,8 @@ void sdma_free(struct sdma *s)
 	kfree(s);
 }
 
-static int __devinit mpc52xx_sdma_probe(struct device *dev)
+static int __devinit mpc52xx_sdma_probe(struct platform_device *pdev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
 	int task;
 	u32 *context;
 	u32 *fdt;
@@ -361,30 +360,31 @@ out:
 }
 
 
-static struct device_driver mpc52xx_sdma_driver = {
-	.owner	  = THIS_MODULE,
-	.name	  = DRIVER_NAME,
-	.bus	  = &platform_bus_type,
+static struct platform_driver mpc52xx_sdma_driver = {
 	.probe 	  = mpc52xx_sdma_probe,
 /*	.remove	  = mpc52xx_sdma_remove,	TODO */
 #ifdef CONFIG_PM
 /*	.suspend	= mpc52xx_sdma_suspend,	TODO */
 /*	.resume		= mpc52xx_sdma_resume,	TODO */
 #endif
+	.driver	= {
+		.owner	  = THIS_MODULE,
+		.name	  = DRIVER_NAME,
+	},
 };
 
 static int __init
 mpc52xx_sdma_init(void)
 {
 	printk(KERN_INFO "DMA: MPC52xx BestComm driver\n");
-	return driver_register(&mpc52xx_sdma_driver);
+	return platform_driver_register(&mpc52xx_sdma_driver);
 }
 
 #ifdef MODULE
 static void __exit
 mpc52xx_sdma_exit(void)
 {
-	driver_unregister(&mpc52xx_sdma_driver);
+	platform_driver_unregister(&mpc52xx_sdma_driver);
 }
 #endif
 

--lMM8JwqTlfDpEaS6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=uart_sport_fix

Index: work-powerpc.git/drivers/serial/mpc52xx_uart.c
===================================================================
--- work-powerpc.git.orig/drivers/serial/mpc52xx_uart.c
+++ work-powerpc.git/drivers/serial/mpc52xx_uart.c
@@ -771,7 +771,7 @@ mpc52xx_uart_suspend(struct platform_dev
 {
 	struct uart_port *port = (struct uart_port *) platform_get_drvdata(dev);
 
-	if (sport)
+	if (port)
 		uart_suspend_port(&mpc52xx_uart_driver, port);
 
 	return 0;

--lMM8JwqTlfDpEaS6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=sram_executable

Index: work-powerpc.git/arch/ppc/syslib/mpc52xx_setup.c
===================================================================
--- work-powerpc.git.orig/arch/ppc/syslib/mpc52xx_setup.c
+++ work-powerpc.git/arch/ppc/syslib/mpc52xx_setup.c
@@ -86,8 +86,11 @@ mpc52xx_map_io(void)
 	/* Here we map the MBAR and the whole upper zone. MBAR is only
 	   64k but we can't map only 64k with BATs. Map the whole
 	   0xf0000000 range is ok and helps eventual lpb devices placed there */
+	/* Disable guarded bit, so we can execute code from SRAM.
+	 * Unfortunately, mappings are >= 2**17, so we "unguard" MBAR registers
+	 * too. This probably isn't a problem. */
 	io_block_mapping(
-		MPC52xx_MBAR_VIRT, MPC52xx_MBAR, 0x10000000, _PAGE_IO);
+		MPC52xx_MBAR_VIRT, MPC52xx_MBAR, 0x10000000, _PAGE_IO & ~_PAGE_GUARDED);
 }
 
 

--lMM8JwqTlfDpEaS6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=low_power_mode

Index: work-powerpc.git/arch/ppc/platforms/Makefile
===================================================================
--- work-powerpc.git.orig/arch/ppc/platforms/Makefile
+++ work-powerpc.git/arch/ppc/platforms/Makefile
@@ -28,6 +28,10 @@ obj-$(CONFIG_SANDPOINT)		+= sandpoint.o
 obj-$(CONFIG_SBC82xx)		+= sbc82xx.o
 obj-$(CONFIG_SPRUCE)		+= spruce.o
 obj-$(CONFIG_LITE5200)		+= lite5200.o
+ifeq ($(CONFIG_LITE5200),y)
+obj-$(CONFIG_PM)		+= lite5200_pm.o
+obj-$(CONFIG_PM)		+= lite5200_sleep.o
+endif
 obj-$(CONFIG_MEDIA5200)		+= media5200.o
 obj-$(CONFIG_EV64360)		+= ev64360.o
 obj-$(CONFIG_MPC86XADS)		+= mpc866ads_setup.o
Index: work-powerpc.git/arch/ppc/platforms/lite5200_pm.c
===================================================================
--- /dev/null
+++ work-powerpc.git/arch/ppc/platforms/lite5200_pm.c
@@ -0,0 +1,72 @@
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/pm.h>
+#include <asm/io.h>
+#include <asm/reg.h>
+#include <asm/machdep.h>
+
+extern void l5200_qt_sleep(void);
+
+static int l5200_pm_valid(suspend_state_t state)
+{
+	switch (state) {
+	case PM_SUSPEND_MEM:
+	case PM_SUSPEND_STANDBY:
+		return 1;
+	default:
+		return 0;
+	}
+}
+
+static int l5200_pm_prepare(suspend_state_t state)
+{
+	return 0;
+}
+
+static int l5200_pm_enter(suspend_state_t state)
+{
+	struct mpc52xx_gpio __iomem *gpio;
+	u32 gpio_saved_pc;
+
+	/* Map zones */
+	gpio = ioremap(MPC52xx_PA(MPC52xx_GPIO_OFFSET), MPC52xx_GPIO_SIZE);
+
+	if (!gpio) {
+		printk(KERN_ERR "%s:%i Error mapping io zones\n", __func__, __LINE__);
+		return 1;
+	}
+
+	/* save ie. ethernet pins configuration */
+	gpio_saved_pc = gpio->port_config;
+	iounmap(gpio);
+
+	if (state == PM_SUSPEND_MEM)
+		l5200_qt_sleep();
+
+	gpio = ioremap(MPC52xx_PA(MPC52xx_GPIO_OFFSET), MPC52xx_GPIO_SIZE);
+	/* restore ie. ethernet pins configuration */
+	gpio->port_config = gpio_saved_pc;
+	iounmap(gpio);
+
+	return 0;
+}
+
+static int l5200_pm_finish(suspend_state_t state)
+{
+	return 0;
+}
+
+static struct pm_ops lite5200_pm_ops = {
+	.valid		= l5200_pm_valid,
+	.prepare	= l5200_pm_prepare,
+	.enter		= l5200_pm_enter,
+	.finish		= l5200_pm_finish,
+};
+
+static int __init lite5200_pm_init(void)
+{
+	pm_set_ops(&lite5200_pm_ops);
+	return 0;
+}
+
+arch_initcall(lite5200_pm_init);
Index: work-powerpc.git/arch/ppc/platforms/lite5200_sleep.S
===================================================================
--- /dev/null
+++ work-powerpc.git/arch/ppc/platforms/lite5200_sleep.S
@@ -0,0 +1,528 @@
+#include <asm/reg.h>
+#include <asm/ppc_asm.h>
+#include <asm/processor.h>
+#include <asm/cache.h>
+
+
+#define MBAR	0xf0000000
+
+#define SDRAM_MODE	0x100
+#define SDRAM_CTRL	0x104
+#define SDRAM_CFG1	0x108
+#define SDRAM_CFG2	0x10c
+#define SC_MODE_EN	(1<<31)
+#define SC_CKE		(1<<30)
+#define SC_REF_EN	(1<<28)
+#define SC_SOFT_PRE	(1<<1)
+
+#define GPIO_CFG	0xb00
+#define GPIO_GPIOE	0xb04
+#define GPIO_ODE	0xb08
+#define GPIO_DDR	0xb0c
+#define GPIO_DVO	0xb10
+
+#define GPIOW_GPIOE	0xc00
+#define GPIOW_ODE	0xc04
+#define GPIOW_DDR	0xc08
+#define GPIOW_DVO	0xc0c
+#define GPIOW_INTEN	0xc10
+
+#define LED_BOTH	0x00
+#define LED_RED		0x10
+#define LED_GREEN	0x20
+#define LED_NONE	0x30
+
+#define CDM_CE		0x214
+#define CDM_SDRAM	(1<<3)
+
+#define TMR_GREEN	0x620
+#define TMR_RED		0x630
+#define TMR_LED_ON	0x24
+#define TMR_LED_OFF	0x34
+
+#define TMR0_ENABLE	0x600
+#define TMR0_INPUT	0x604
+#define TMR0_STATUS	0x60c
+
+#define SRAM		0x8000
+
+// about 2000 cpu cycles for one sdram cycle here
+// just increase, to be on the safe side?
+#define TCK	5000
+
+
+// ----------------------------------------------------------------------
+// QT sleep
+
+// XXX it uses cca. 10 mA less if registers are saved in .text. WTF
+// is this still true?
+//	.data
+registers:
+	.space 0x180
+//	.text
+
+// probably not used... just in case...
+#define SPRN_IABR2 1018
+#define SPRN_DABR2 317
+#define SPRN_DCMP 977
+#define SPRN_MBAR 311
+#define SPRN_IBCR 309
+#define SPRN_DBCR 310
+
+// helpers... beware: r10 and r4
+#define SAVE_SPRN(reg, addr)		\
+	mfspr	r10, SPRN_##reg;	\
+	stw	r10, (addr*4)(r4);
+
+#define LOAD_SPRN(reg, addr)		\
+	lwz	r10, (addr*4)(r4);	\
+	mtspr	SPRN_##reg, r10;	\
+	sync;				\
+	isync;
+
+
+	.globl l5200_qt_sleep
+l5200_qt_sleep:
+
+	// setup wakeup address for u-boot
+	lis	r3, 0xc000
+	lis	r4, l5200_wakeup@h
+	ori	r4, r4, l5200_wakeup@l
+	xoris	r4, r4, 0xc000	// & ~0xc000 0000
+	stw	r4, 0(r3)
+
+
+	// save stuff BDI overwrites
+	/* save 0xf0 (0xe0->0x100 gets overwritten when BDI connected;
+	 *   even when CONFIG_BDI* is disabled and MMU XLAT commented; heisenbug?))
+	 * WARNING: self-refresh doesn't seem to work when BDI2000 is connected,
+	 *   possibly because BDI sets SDRAM registers before wakeup code does */
+	lis	r4, registers@h
+	ori	r4, r4, registers@l
+	lwz	r10, 0xf0(r3)
+	stw	r10, (0x59*4)(r4)
+
+	// save registers to r4 [destroys r10]
+	SAVE_SPRN(LR, 0x3c)
+	bl	save_regs
+
+	// flush caches [destroys r3, r4]
+	bl	flush_data_cache
+
+
+	// copy code to sram
+	lis	r4, MBAR@h
+	ori	r4, r4, SRAM
+	li	r3, (sram_code_end - sram_code)/4
+	mtctr	r3
+	lis	r3, sram_code@h
+	ori	r3, r3, sram_code@l
+1:
+	lwz	r5, 0(r3)
+	stw	r5, 0(r4)
+	addi	r3, r3, 4
+	addi	r4, r4, 4
+	bdnz	1b
+
+	// disable I and D caches
+	mfspr	r3, SPRN_HID0
+	ori	r3, r3, HID0_ICE | HID0_DCE
+	xori	r3, r3, HID0_ICE | HID0_DCE
+	sync; isync;
+	mtspr	SPRN_HID0, r3
+	sync; isync;
+
+	// jump to sram
+	lis	r3, MBAR@h
+	ori	r3, r3, SRAM
+	mtlr	r3
+	blrl
+
+	// doesn't return
+
+
+sram_code:
+	// self refresh
+	lis	r3, MBAR@h
+
+	lwz	r4, SDRAM_CTRL(r3)
+
+	// send NOP (precharge)
+	oris	r4, r4, SC_MODE_EN@h	// mode_en
+	stw	r4, SDRAM_CTRL(r3)
+	sync
+
+	ori	r4, r4, SC_SOFT_PRE	// soft_pre
+	stw	r4, SDRAM_CTRL(r3)
+	sync
+	xori	r4, r4, SC_SOFT_PRE
+
+	xoris	r4, r4, SC_MODE_EN@h	// !mode_en
+	stw	r4, SDRAM_CTRL(r3)
+	sync
+
+	// delay for one sdram cycle (for NOP to finish)
+	li	r5, TCK
+	mtctr	r5
+1:	bdnz-	1b
+
+	// mode_en must not be set when enabling self-refresh
+	// send AR with CKE low (self-refresh)
+	oris	r4, r4, (SC_REF_EN | SC_CKE)@h
+	xoris	r4, r4, (SC_CKE)@h	// ref_en !cke
+	stw	r4, SDRAM_CTRL(r3)
+	sync
+
+	// delay for two sdram cycles (after !CKE there should be two cycles)
+	li	r5, 2*TCK
+	mtctr	r5
+1:	bdnz-	1b
+
+	// disable clock
+	lwz	r4, CDM_CE(r3)
+	ori	r4, r4, CDM_SDRAM
+	xori	r4, r4, CDM_SDRAM
+	stw	r4, CDM_CE(r3)
+	sync
+
+	// delay for two sdram cycles
+	li	r5, 2*TCK
+	mtctr	r5
+1:	bdnz-	1b
+
+
+	// turn off with QT chip
+	lis	r3, MBAR@h
+	li	r4, 0x02
+	stb	r4, GPIOW_GPIOE(r3)	// enable gpio_wkup1
+	sync
+
+	stb	r4, GPIOW_DVO(r3)	// "output" high
+	sync
+	stb	r4, GPIOW_DDR(r3)	// output
+	sync
+	stb	r4, GPIOW_DVO(r3)	// output high
+	sync
+
+	// delay
+	// 2000 cycles is cca 12 uS, 10uS should be enough
+	li	r4, 2000
+	mtctr	r4
+1:
+	bdnz-	1b
+
+	// turn off
+	li	r4, 0
+	stb	r4, GPIOW_DVO(r3)	// output low
+	sync
+
+	// wait until we're offline
+1:
+	b	1b
+sram_code_end:
+
+
+
+// uboot jumps here on resume
+l5200_wakeup:
+	bl	restore_regs
+
+
+	// HIDs, MSR
+	LOAD_SPRN(HID1, 0x39)
+	LOAD_SPRN(HID2, 0x3a)
+
+
+	// address translation is tricky (see turn_on_mmu)
+	mfmsr	r10
+	ori	r10, r10, MSR_DR | MSR_IR
+
+
+	mtspr	SPRN_SRR1, r10
+	lis	r10, mmu_on@h
+	ori	r10, r10, mmu_on@l
+	mtspr	SPRN_SRR0, r10
+	sync
+	rfi
+mmu_on:
+	// kernel offset (r4 is still set from restore_registers)
+	oris	r4, r4, 0xc000
+
+
+	// restore MSR
+	lwz	r10, (4*0x3b)(r4)
+	mtmsr	r10
+	sync; isync;
+
+	// setup DEC somewhere in the 1/HZ range
+	// if you don't do this, timer interrupt will trigger a few
+	//	seconds later, and that is not good.
+	lis	r3, 0x10
+	mtdec	r3
+
+	// invalidate caches
+	mfspr	r10, SPRN_HID0
+	ori	r5, r10, HID0_ICFI | HID0_DCI
+	mtspr	SPRN_HID0, r5	// invalidate caches
+	sync; isync;
+	mtspr	SPRN_HID0, r10
+	sync; isync;
+
+	// enable caches
+	lwz	r10, (4*0x38)(r4)
+	mtspr	SPRN_HID0, r10	// restore (enable caches, DPM)
+	// ^ this has to be after address translation set in MSR
+	sync
+	isync
+
+
+	// restore 0xf0 (BDI2000)
+	lis	r3, 0xc000
+	lwz	r10, (0x59*4)(r4)
+	stw	r10, 0xf0(r3)
+
+	LOAD_SPRN(LR, 0x3c)
+
+
+	blr
+
+
+// ----------------------------------------------------------------------
+// boring code: helpers
+
+save_regs:
+	// save registers
+	stw	r0, 0(r4)
+	stw	r1, 0x4(r4)
+	stw	r2, 0x8(r4)
+	stw	r11, 0xc(r4)
+	stw	r12, 0x10(r4)
+	stw	r13, 0x14(r4)
+	stw	r14, 0x18(r4)
+	stw	r15, 0x1c(r4)
+	stw	r16, 0x20(r4)
+	stw	r17, 0x24(r4)
+	stw	r18, 0x28(r4)
+	stw	r19, 0x2c(r4)
+	stw	r20, 0x30(r4)
+	stw	r21, 0x34(r4)
+	stw	r22, 0x38(r4)
+	stw	r23, 0x3c(r4)
+	stw	r24, 0x40(r4)
+	stw	r25, 0x44(r4)
+	stw	r26, 0x48(r4)
+	stw	r27, 0x4c(r4)
+	stw	r28, 0x50(r4)
+	stw	r29, 0x54(r4)
+	stw	r30, 0x58(r4)
+	stw	r31, 0x5c(r4)
+
+	// save MMU regs
+	SAVE_SPRN(DBAT0L, 0x18)
+	SAVE_SPRN(DBAT0U, 0x19)
+	SAVE_SPRN(IBAT0L, 0x1a)
+	SAVE_SPRN(IBAT0U, 0x1b)
+	SAVE_SPRN(DBAT1L, 0x1c)
+	SAVE_SPRN(DBAT1U, 0x1d)
+	SAVE_SPRN(IBAT1L, 0x1e)
+	SAVE_SPRN(IBAT1U, 0x1f)
+	SAVE_SPRN(DBAT2L, 0x20)
+	SAVE_SPRN(DBAT2U, 0x21)
+	SAVE_SPRN(IBAT2L, 0x22)
+	SAVE_SPRN(IBAT2U, 0x23)
+	SAVE_SPRN(DBAT3L, 0x24)
+	SAVE_SPRN(DBAT3U, 0x25)
+	SAVE_SPRN(IBAT3L, 0x26)
+	SAVE_SPRN(IBAT3U, 0x27)
+	SAVE_SPRN(DBAT4L, 0x28)
+	SAVE_SPRN(DBAT4U, 0x29)
+	SAVE_SPRN(IBAT4L, 0x2a)
+	SAVE_SPRN(IBAT4U, 0x2b)
+	SAVE_SPRN(DBAT5L, 0x2c)
+	SAVE_SPRN(DBAT5U, 0x2d)
+	SAVE_SPRN(IBAT5L, 0x2e)
+	SAVE_SPRN(IBAT5U, 0x2f)
+	SAVE_SPRN(DBAT6L, 0x30)
+	SAVE_SPRN(DBAT6U, 0x31)
+	SAVE_SPRN(IBAT6L, 0x32)
+	SAVE_SPRN(IBAT6U, 0x33)
+	SAVE_SPRN(DBAT7L, 0x34)
+	SAVE_SPRN(DBAT7U, 0x35)
+	SAVE_SPRN(IBAT7L, 0x36)
+	SAVE_SPRN(IBAT7U, 0x37)
+
+	SAVE_SPRN(HID0, 0x38)
+	SAVE_SPRN(HID1, 0x39)
+	SAVE_SPRN(HID2, 0x3a)
+
+	mfmsr	r10
+	stw	r10, (4*0x3b)(r4)
+
+	//SAVE_SPRN(LR, 0x3c) have to save it before the call
+
+	SAVE_SPRN(SPRG0, 0x40)
+	SAVE_SPRN(SPRG1, 0x41)
+	SAVE_SPRN(SPRG2, 0x42)
+	SAVE_SPRN(SPRG3, 0x43)
+	SAVE_SPRN(SPRG4, 0x44)
+	SAVE_SPRN(SPRG5, 0x45)
+	SAVE_SPRN(SPRG6, 0x46)
+	SAVE_SPRN(SPRG7, 0x47)
+	SAVE_SPRN(IABR,  0x48)
+	SAVE_SPRN(IABR2, 0x49)
+	SAVE_SPRN(DABR,  0x4a)
+	SAVE_SPRN(DABR2, 0x4b)
+	SAVE_SPRN(DMISS, 0x4c)
+	SAVE_SPRN(DCMP,  0x4d)
+	SAVE_SPRN(IMISS, 0x4e)
+	SAVE_SPRN(ICMP,  0x4f)
+	SAVE_SPRN(HASH1, 0x50)
+	SAVE_SPRN(HASH2, 0x51)
+	SAVE_SPRN(MBAR,  0x52)
+
+	SAVE_SPRN(CTR,   0x54)
+	SAVE_SPRN(DSISR, 0x55)
+	SAVE_SPRN(DAR,   0x56)
+	SAVE_SPRN(RPA,   0x57)
+	SAVE_SPRN(SDR1,  0x58)
+
+	SAVE_SPRN(IBCR,  0x5a)
+	SAVE_SPRN(DBCR,  0x5b)
+	SAVE_SPRN(TBRL,  0x5c)
+	SAVE_SPRN(TBRU,  0x5d)
+	// 0x59 reserved by 0xf0
+
+	blr
+
+// restore registers
+restore_regs:
+	lis	r4, registers@h
+	ori	r4, r4, registers@l
+	xoris	r4, r4, 0xc000	// & ~0xc000 0000
+
+	lwz	r0, 0(r4)
+	lwz	r1, 0x4(r4)
+	lwz	r2, 0x8(r4)
+	lwz	r11, 0xc(r4)
+	lwz	r12, 0x10(r4)
+	lwz	r13, 0x14(r4)
+	lwz	r14, 0x18(r4)
+	lwz	r15, 0x1c(r4)
+	lwz	r16, 0x20(r4)
+	lwz	r17, 0x24(r4)
+	lwz	r18, 0x28(r4)
+	lwz	r19, 0x2c(r4)
+	lwz	r20, 0x30(r4)
+	lwz	r21, 0x34(r4)
+	lwz	r22, 0x38(r4)
+	lwz	r23, 0x3c(r4)
+	lwz	r24, 0x40(r4)
+	lwz	r25, 0x44(r4)
+	lwz	r26, 0x48(r4)
+	lwz	r27, 0x4c(r4)
+	lwz	r28, 0x50(r4)
+	lwz	r29, 0x54(r4)
+	lwz	r30, 0x58(r4)
+	lwz	r31, 0x5c(r4)
+
+	// restore MMU regs
+	LOAD_SPRN(DBAT0L, 0x18)
+	LOAD_SPRN(DBAT0U, 0x19)
+	LOAD_SPRN(IBAT0L, 0x1a)
+	LOAD_SPRN(IBAT0U, 0x1b)
+	LOAD_SPRN(DBAT1L, 0x1c)
+	LOAD_SPRN(DBAT1U, 0x1d)
+	LOAD_SPRN(IBAT1L, 0x1e)
+	LOAD_SPRN(IBAT1U, 0x1f)
+	LOAD_SPRN(DBAT2L, 0x20)
+	LOAD_SPRN(DBAT2U, 0x21)
+	LOAD_SPRN(IBAT2L, 0x22)
+	LOAD_SPRN(IBAT2U, 0x23)
+	LOAD_SPRN(DBAT3L, 0x24)
+	LOAD_SPRN(DBAT3U, 0x25)
+	LOAD_SPRN(IBAT3L, 0x26)
+	LOAD_SPRN(IBAT3U, 0x27)
+	LOAD_SPRN(DBAT4L, 0x28)
+	LOAD_SPRN(DBAT4U, 0x29)
+	LOAD_SPRN(IBAT4L, 0x2a)
+	LOAD_SPRN(IBAT4U, 0x2b)
+	LOAD_SPRN(DBAT5L, 0x2c)
+	LOAD_SPRN(DBAT5U, 0x2d)
+	LOAD_SPRN(IBAT5L, 0x2e)
+	LOAD_SPRN(IBAT5U, 0x2f)
+	LOAD_SPRN(DBAT6L, 0x30)
+	LOAD_SPRN(DBAT6U, 0x31)
+	LOAD_SPRN(IBAT6L, 0x32)
+	LOAD_SPRN(IBAT6U, 0x33)
+	LOAD_SPRN(DBAT7L, 0x34)
+	LOAD_SPRN(DBAT7U, 0x35)
+	LOAD_SPRN(IBAT7L, 0x36)
+	LOAD_SPRN(IBAT7U, 0x37)
+
+	/* these are a bit tricky */
+	/*
+	0x38 - HID0
+	0x39 - HID1
+	0x3a - HID2
+	0x3b - MSR
+	0x3c - LR
+	*/
+
+	// rest of regs
+	LOAD_SPRN(SPRG0, 0x40);
+	LOAD_SPRN(SPRG1, 0x41);
+	LOAD_SPRN(SPRG2, 0x42);
+	LOAD_SPRN(SPRG3, 0x43);
+	LOAD_SPRN(SPRG4, 0x44);
+	LOAD_SPRN(SPRG5, 0x45);
+	LOAD_SPRN(SPRG6, 0x46);
+	LOAD_SPRN(SPRG7, 0x47);
+	LOAD_SPRN(IABR,  0x48);
+	LOAD_SPRN(IABR2, 0x49);
+	LOAD_SPRN(DABR,  0x4a);
+	LOAD_SPRN(DABR2, 0x4b);
+	LOAD_SPRN(DMISS, 0x4c);
+	LOAD_SPRN(DCMP,  0x4d);
+	LOAD_SPRN(IMISS, 0x4e);
+	LOAD_SPRN(ICMP,  0x4f);
+	LOAD_SPRN(HASH1, 0x50);
+	LOAD_SPRN(HASH2, 0x51);
+	LOAD_SPRN(MBAR,  0x52);
+
+	LOAD_SPRN(CTR,   0x54);
+	LOAD_SPRN(DSISR, 0x55);
+	LOAD_SPRN(DAR,   0x56);
+	LOAD_SPRN(RPA,   0x57);
+	LOAD_SPRN(SDR1,  0x58);
+
+	// 0x59 reserved by 0xf0
+	LOAD_SPRN(IBCR,  0x5a);
+	LOAD_SPRN(DBCR,  0x5b);
+	LOAD_SPRN(TBWL,  0x5c);	// these two have separate R/W regs
+	LOAD_SPRN(TBWU,  0x5d);
+
+	blr
+
+
+
+#if 1
+/* cache flushing code. copied from boot/util.S. how do you link with that?! */
+#define NUM_CACHE_LINES 128*8
+#define cache_flush_buffer 0xc0000000
+
+/*
+ * Flush data cache
+ * Do this by just reading lots of stuff into the cache.
+ */
+        .globl flush_data_cache
+flush_data_cache:
+	lis	r3,cache_flush_buffer@h
+	ori	r3,r3,cache_flush_buffer@l
+	li	r4,NUM_CACHE_LINES
+	mtctr	r4
+1:
+	lwz	r4,0(r3)
+	addi	r3,r3,L1_CACHE_BYTES	/* Next line, please */
+	bdnz	1b
+	blr
+#endif

--lMM8JwqTlfDpEaS6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=suspend_arch_code_non-init

Index: work-powerpc.git/arch/ppc/syslib/mpc52xx_setup.c
===================================================================
--- work-powerpc.git.orig/arch/ppc/syslib/mpc52xx_setup.c
+++ work-powerpc.git/arch/ppc/syslib/mpc52xx_setup.c
@@ -220,8 +220,7 @@ mpc52xx_calibrate_decr(void)
 	tb_to_us = mulhwu_scale_factor(xlbfreq / divisor, 1000000);
 }
 
-void __init
-mpc52xx_setup_cpu(void)
+void mpc52xx_setup_cpu(void)
 {
 	struct mpc52xx_cdm  __iomem *cdm;
 	struct mpc52xx_xlb  __iomem *xlb;
Index: work-powerpc.git/arch/ppc/platforms/lite5200.c
===================================================================
--- work-powerpc.git.orig/arch/ppc/platforms/lite5200.c
+++ work-powerpc.git/arch/ppc/platforms/lite5200.c
@@ -93,8 +93,7 @@ lite5200_map_irq(struct pci_dev *dev, un
 #endif
 #endif
 
-static void __init
-lite5200_setup_cpu(void)
+void lite5200_setup_cpu(void)
 {
 	struct mpc52xx_gpio __iomem *gpio;
 	struct mpc52xx_intr __iomem *intr;
@@ -149,8 +148,7 @@ unmap_regs:
 	if (intr) iounmap(intr);
 }
 
-static void __init
-lite5200_setup_arch(void)
+static void lite5200_setup_arch(void)
 {
 	/* CPU & Port mux setup */
 	mpc52xx_setup_cpu();	/* Generic */
Index: work-powerpc.git/arch/ppc/platforms/lite5200_pm.c
===================================================================
--- work-powerpc.git.orig/arch/ppc/platforms/lite5200_pm.c
+++ work-powerpc.git/arch/ppc/platforms/lite5200_pm.c
@@ -48,6 +48,8 @@ static int l5200_pm_enter(suspend_state_
 	gpio->port_config = gpio_saved_pc;
 	iounmap(gpio);
 
+	ppc_md.setup_arch();
+
 	return 0;
 }
 

--lMM8JwqTlfDpEaS6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=suspend_pic

Index: work-powerpc.git/arch/ppc/syslib/mpc52xx_pic.c
===================================================================
--- work-powerpc.git.orig/arch/ppc/syslib/mpc52xx_pic.c
+++ work-powerpc.git/arch/ppc/syslib/mpc52xx_pic.c
@@ -317,3 +317,47 @@ peripheral:
 	return irq;
 }
 
+/* save and restore registers for suspend to ram */
+u32 pic_regs[0x10];
+void mpc52xx_pic_suspend(void)
+{
+	int i = 0;
+	// sdma into sdma suspend/resume
+	pic_regs[i++] = in_be32(&sdma->IntPend);
+	pic_regs[i++] = in_be32(&sdma->IntMask);
+	pic_regs[i++] = in_be32(&intr->per_mask);
+	pic_regs[i++] = in_be32(&intr->main_mask);
+	pic_regs[i++] = in_be32(&intr->ctrl);
+	pic_regs[i++] = in_be32(&intr->per_pri1);
+	pic_regs[i++] = in_be32(&intr->per_pri2);
+	pic_regs[i++] = in_be32(&intr->per_pri3);
+	pic_regs[i++] = in_be32(&intr->main_pri1);
+	pic_regs[i++] = in_be32(&intr->main_pri2);
+
+	iounmap(intr);
+	iounmap(sdma);
+	iounmap(slt0);
+}
+
+void mpc52xx_pic_resume(void)
+{
+	int i = 0;
+
+	intr = ioremap(MPC52xx_PA(MPC52xx_INTR_OFFSET), MPC52xx_INTR_SIZE);
+	sdma = ioremap(MPC52xx_PA(MPC52xx_SDMA_OFFSET), MPC52xx_SDMA_SIZE);
+	slt0 = ioremap(MPC52xx_PA(MPC52xx_SLTx_OFFSET(0)), MPC52xx_SLT_SIZE);
+	if ((intr==NULL) || (sdma==NULL) || (slt0==NULL))
+		panic("Can't ioremap PIC/SDMA/SLT0 registers for init_irq !");
+
+	// sdma into sdma suspend/resume
+	out_be32(&sdma->IntPend, pic_regs[i++]);
+	out_be32(&sdma->IntMask, pic_regs[i++]);
+	out_be32(&intr->per_mask, pic_regs[i++]);
+	out_be32(&intr->main_mask, pic_regs[i++]);
+	out_be32(&intr->ctrl, pic_regs[i++]);
+	out_be32(&intr->per_pri1, pic_regs[i++]);
+	out_be32(&intr->per_pri2, pic_regs[i++]);
+	out_be32(&intr->per_pri3, pic_regs[i++]);
+	out_be32(&intr->main_pri1, pic_regs[i++]);
+	out_be32(&intr->main_pri2, pic_regs[i++]);
+}
Index: work-powerpc.git/arch/ppc/platforms/lite5200_pm.c
===================================================================
--- work-powerpc.git.orig/arch/ppc/platforms/lite5200_pm.c
+++ work-powerpc.git/arch/ppc/platforms/lite5200_pm.c
@@ -23,6 +23,9 @@ static int l5200_pm_prepare(suspend_stat
 	return 0;
 }
 
+extern void mpc52xx_pic_suspend(void);
+extern void mpc52xx_pic_resume(void);
+
 static int l5200_pm_enter(suspend_state_t state)
 {
 	struct mpc52xx_gpio __iomem *gpio;
@@ -40,6 +43,8 @@ static int l5200_pm_enter(suspend_state_
 	gpio_saved_pc = gpio->port_config;
 	iounmap(gpio);
 
+	mpc52xx_pic_suspend();
+
 	if (state == PM_SUSPEND_MEM)
 		l5200_qt_sleep();
 
@@ -50,6 +55,8 @@ static int l5200_pm_enter(suspend_state_
 
 	ppc_md.setup_arch();
 
+	mpc52xx_pic_resume();
+
 	return 0;
 }
 

--lMM8JwqTlfDpEaS6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=uart_smaller_delay

Index: work-powerpc.git/drivers/serial/mpc52xx_uart.c
===================================================================
--- work-powerpc.git.orig/drivers/serial/mpc52xx_uart.c
+++ work-powerpc.git/drivers/serial/mpc52xx_uart.c
@@ -285,7 +285,7 @@ mpc52xx_uart_set_termios(struct uart_por
 
 	/* Do our best to flush TX & RX, so we don't loose anything */
 	/* But we don't wait indefinitly ! */
-	j = 5000000;	/* Maximum wait */
+	j = 500000;	/* Maximum wait */
 	/* FIXME Can't receive chars since set_termios might be called at early
 	 * boot for the console, all stuff is not yet ready to receive at that
 	 * time and that just makes the kernel oops */

--lMM8JwqTlfDpEaS6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=suspend_bestcomm

Index: work-powerpc.git/arch/ppc/syslib/bestcomm/bestcomm.c
===================================================================
--- work-powerpc.git.orig/arch/ppc/syslib/bestcomm/bestcomm.c
+++ work-powerpc.git/arch/ppc/syslib/bestcomm/bestcomm.c
@@ -360,16 +360,85 @@ out:
 }
 
 
+/* saved sdma regs */
+struct mpc52xx_sdma sdma_regs;
+char saved_sram[0x4000]; // 16 kB
+static int mpc52xx_sdma_suspend(struct platform_device *pdev, pm_message_t state)
+{
+	int i;
+
+	/* don't actually need the be variants */
+	sdma_regs.taskBar =	in_be32(&sdma.io->taskBar);
+	sdma_regs.currentPointer = in_be32(&sdma.io->currentPointer);
+	sdma_regs.endPointer =	in_be32(&sdma.io->endPointer);
+	sdma_regs.variablePointer = in_be32(&sdma.io->variablePointer);
+	sdma_regs.IntVect1 =	in_8(&sdma.io->IntVect1);
+	sdma_regs.IntVect2 =	in_8(&sdma.io->IntVect2);
+	sdma_regs.PtdCntrl =	in_be16(&sdma.io->PtdCntrl);
+	sdma_regs.IntPend =	in_be32(&sdma.io->IntPend);
+	sdma_regs.IntMask =	in_be32(&sdma.io->IntMask);
+
+	for (i=0; i<16; i++)
+		sdma_regs.tcr[i] = in_be16(&sdma.io->tcr[i]);
+	for (i=0; i<32; i++)
+		sdma_regs.ipr[i] = in_8(&sdma.io->ipr[i]);
+
+	sdma_regs.cReqSelect =	in_be32(&sdma.io->cReqSelect);
+	sdma_regs.task_size[0] = in_be32(&sdma.io->task_size[0]);
+	sdma_regs.task_size[1] = in_be32(&sdma.io->task_size[1]);
+	sdma_regs.MDEDebug =	in_be32(&sdma.io->MDEDebug);
+	sdma_regs.Value1 =	in_be32(&sdma.io->Value1);
+	sdma_regs.Value2 =	in_be32(&sdma.io->Value2);
+	sdma_regs.Control =	in_be32(&sdma.io->Control);
+	sdma_regs.Status =	in_be32(&sdma.io->Status);
+	sdma_regs.PTDDebug =	in_be32(&sdma.io->PTDDebug);
+
+	memcpy(saved_sram, sdma.sram, sdma.sram_size);
+	return 0;
+}
+
+static int mpc52xx_sdma_resume(struct platform_device *pdev)
+{
+	int i;
+
+	memcpy(sdma.sram, saved_sram, sdma.sram_size);
+
+	// XXX order?
+	out_be32(&sdma.io->taskBar, sdma_regs.taskBar);
+	out_be32(&sdma.io->currentPointer, sdma_regs.currentPointer);
+	out_be32(&sdma.io->endPointer, sdma_regs.endPointer);
+	out_be32(&sdma.io->variablePointer, sdma_regs.variablePointer);
+	out_8(&sdma.io->IntVect1, sdma_regs.IntVect1);
+	out_8(&sdma.io->IntVect2, sdma_regs.IntVect2);
+	out_be16(&sdma.io->PtdCntrl, sdma_regs.PtdCntrl);
+	out_be32(&sdma.io->IntPend, sdma_regs.IntPend);
+	out_be32(&sdma.io->IntMask, sdma_regs.IntMask);
+
+	for (i=0; i<16; i++)
+		out_be16(&sdma.io->tcr[i], sdma_regs.tcr[i]);
+	for (i=0; i<32; i++)
+		out_8(&sdma.io->ipr[i], sdma_regs.ipr[i]);
+
+	out_be32(&sdma.io->cReqSelect, sdma_regs.cReqSelect);
+	out_be32(&sdma.io->task_size[0], sdma_regs.task_size[0]);
+	out_be32(&sdma.io->task_size[1], sdma_regs.task_size[1]);
+	out_be32(&sdma.io->MDEDebug, sdma_regs.MDEDebug);
+	out_be32(&sdma.io->Value1, sdma_regs.Value1);
+	out_be32(&sdma.io->Value2, sdma_regs.Value2);
+	out_be32(&sdma.io->Control, sdma_regs.Control);
+	out_be32(&sdma.io->Status, sdma_regs.Status);
+	out_be32(&sdma.io->PTDDebug, sdma_regs.PTDDebug);
+	return 0;
+}
+
 static struct platform_driver mpc52xx_sdma_driver = {
 	.probe 	  = mpc52xx_sdma_probe,
 /*	.remove	  = mpc52xx_sdma_remove,	TODO */
-#ifdef CONFIG_PM
-/*	.suspend	= mpc52xx_sdma_suspend,	TODO */
-/*	.resume		= mpc52xx_sdma_resume,	TODO */
-#endif
-	.driver	= {
-		.owner	  = THIS_MODULE,
+	.suspend	= mpc52xx_sdma_suspend,
+	.resume		= mpc52xx_sdma_resume,
+	.driver = {
 		.name	  = DRIVER_NAME,
+		.owner	  = THIS_MODULE,
 	},
 };
 

--lMM8JwqTlfDpEaS6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=suspend_fec

Index: work-powerpc.git/drivers/net/fec_mpc52xx/fec.c
===================================================================
--- work-powerpc.git.orig/drivers/net/fec_mpc52xx/fec.c
+++ work-powerpc.git/drivers/net/fec_mpc52xx/fec.c
@@ -731,14 +731,55 @@ mpc52xx_fec_remove(struct platform_devic
 	return 0;
 }
 
+
+extern int mpc52xx_fec_mii_suspend(struct net_device *dev);
+int mpc52xx_fec_suspend(struct platform_device *pdev, pm_message_t state)
+{
+	struct net_device *ndev = platform_get_drvdata(pdev);
+	struct fec_priv *priv = ndev->priv;
+	struct mpc52xx_fec *fec = priv->fec;
+
+	netif_stop_queue(ndev);
+	out_be32(&fec->imask, 0x0);
+
+	/* Disable the rx and tx tasks. */
+	sdma_disable(priv->rx_sdma);
+	sdma_disable(priv->tx_sdma);
+
+	/* Stop FEC */
+	out_be32(&fec->ecntrl, in_be32(&fec->ecntrl) & ~0x2);
+
+	mpc52xx_fec_mii_suspend(ndev);
+
+	return 0;
+}
+
+int mpc52xx_fec_resume(struct platform_device *pdev)
+{
+	struct net_device *ndev = platform_get_drvdata(pdev);
+	struct fec_priv *priv = ndev->priv;
+	//struct mpc52xx_fec *fec = priv->fec;
+
+	/* Restart the DMA tasks */
+	sdma_fec_rx_init(priv->rx_sdma, priv->rx_fifo, FEC_RX_BUFFER_SIZE);
+	sdma_fec_tx_init(priv->tx_sdma, priv->tx_fifo);
+	fec_hw_init(ndev);
+	fec_mii_init(ndev);
+
+	if (priv->sequence_done) {		 /* redo the fec_open() */
+		fec_free_rx_buffers(priv->rx_sdma);
+		fec_open(ndev);
+	}
+
+	return 0;
+}
+
 static struct platform_driver mpc52xx_fec_driver = {
 	.probe		= mpc52xx_fec_probe,
 	.remove		= mpc52xx_fec_remove,
-#ifdef CONFIG_PM
-/*	.suspend	= mpc52xx_fec_suspend,	TODO */
-/*	.resume		= mpc52xx_fec_resume,	TODO */
-#endif
-	.driver	= {
+	.suspend	= mpc52xx_fec_suspend,
+	.resume		= mpc52xx_fec_resume,
+	.driver = {
 		.name	  = DRIVER_NAME,
 	},
 };
Index: work-powerpc.git/drivers/net/fec_mpc52xx/fec_phy.c
===================================================================
--- work-powerpc.git.orig/drivers/net/fec_mpc52xx/fec_phy.c
+++ work-powerpc.git/drivers/net/fec_mpc52xx/fec_phy.c
@@ -521,6 +521,15 @@ int fec_mii_wait(struct net_device *dev)
 	return 0;
 }
 
+
+phy_cmd_t phy_cmd_powerdown[] =  { { mk_mii_write(0x00, 0x0800), NULL }, // power down
+				{ mk_mii_end, } };
+
+void mpc52xx_fec_mii_suspend(struct net_device *dev)
+{
+	mii_do_cmd(dev, phy_cmd_powerdown);
+}
+
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Dale Farnsworth");
 MODULE_DESCRIPTION("PHY driver for Motorola MPC52xx FEC");


--lMM8JwqTlfDpEaS6--
