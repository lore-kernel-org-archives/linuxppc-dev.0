Return-Path: <domen.puncer@telargo.com>
Received: from out001.atlarge.net (out001.atlarge.net [129.41.63.69])
	by ozlabs.org (Postfix) with ESMTP id 8E8C2DDE3B
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 22 Dec 2006 22:06:17 +1100 (EST)
Date: Fri, 22 Dec 2006 11:54:04 +0100
From: Domen Puncer <domen.puncer@telargo.com>
To: linuxppc-embedded@ozlabs.org
Subject: [RFC] lite5200b low power mode
Message-ID: <20061222105404.GC2481@moe.telargo.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="7AUc2qLy4jB3hD7Z"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

I have managed to implement low power mode... well, to some
degree, at least.

Short description:
patch u-boot, it's the return from wakeup code. pretty clean.
	address is saved at 0x0 (0xc000_0000)
patch linux with PM-platform_bus-and-late_suspend-early_resume.patch
	didn't investigate too much, but it seems to broke mine.
patch linux with lite5200b_low_power.patch
	ugly, with debugging, hacks and whatever

Boot Linux and 'echo mem > /sys/power/state'.
It won't work on PCI, possibly other devices, PSC0 and FEC seem
to work ok for me.

It seems to work reliably (checksums match, so ram was in self-refresh)
when called from boot scripts, but not so when from console prompt.


If someone's interested (or maybe wants to play with this during
holiday? ;-) ), more info follow:


Intro
-----
lite5200b has low power mode, which turns off supply to MPC5200.
It is controlled via "...QT1" microcontroller (PSC2_4 pin on mpc)

The cpu itself also supports a similar mode - deep sleep, where
cpu is stopped but contents remain because it's static.

Vital for restore in both cases is putting sdram in self-refresh
correctly. For deep sleep mpc5200b does that automatically
(AN3045 says it's so for B rev., and tests confirm it).


self-refresh
------------
There are many ways of putting ram in self-refresh.
Code can't be executed from SDRAM, but there are a few choices:
FLASH, SRAM (don't forget & ~_PAGE_GUARDED in mpc52xx_map_io),
and instruction cache (prefetching via icbi or as described
in g2 core reference manual didn't work for me. However,
executing code surely did put it in cache).

Now, the sad part for me, is that I never actually managed
to put it in SR. I've bugged Freescale, and they've been
very helpfull, even tried my code on another project/kernel,
and it worked.
Maybe I was doing something wrong, maybe something was accessing
SDRAM (i flushed data cache, disabled interrupts).

The trick this patch uses, it to signal "low power" to "QT1",
and after that put mpc5200b in deep sleep.
As I'm figuring out now, this isn't 100% ok either. I think
it always worked right when called from boot scripts. Calling it
from serial console is pretty much unpredictible.


deep sleep
----------
And a note about deep sleep.
I had code to put mpc in deep sleep in SRAM (so it should remain
here on wakeup, to wake SDRAM). 1st stage wakeup code was
interrupt handler (0x500), put in i-cache, by forcing an
interrupt before sleeping.
It went to sleep, but on restore, I didn't get further than
i-cached wakeup code. Jump back to SRAM failed :-(


Hopefully someone finds this useful.


I'd appreaciate any tips, ideas, patches etc. :-)


	Domen

--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="u-boot.git.qt_sleep_in_c.patch"

diff --git a/board/icecube/icecube.c b/board/icecube/icecube.c
index 4f056b2..741f1b5 100644
--- a/board/icecube/icecube.c
+++ b/board/icecube/icecube.c
@@ -38,6 +38,52 @@ # else
 #include "mt48lc16m16a2-75.h"
 # endif
 #endif
+
+#ifdef CONFIG_LITE5200B
+/* u-boot part of low-power mode implementation */
+#define SAVED_ADDR 0x00000000
+void lite5200b_wakeup(void)
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
+	/* put ram out of self-refresh */
+	*(vu_long *)MPC5XXX_SDRAM_CTRL |= 0x80000000;	// mode_en
+	__asm__ volatile ("sync");
+	*(vu_long *)MPC5XXX_SDRAM_CTRL |= 0x50000000;	// cke ref_en
+	__asm__ volatile ("sync");
+	*(vu_long *)MPC5XXX_SDRAM_CTRL &= ~0x80000000;	// !mode_en
+	__asm__ volatile ("sync");
+	udelay(10); /* wait a bit */
+
+	/* jump back to linux kernel code */
+	linux_wakeup = *(unsigned long *)SAVED_ADDR;
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
@@ -204,6 +250,8 @@ #endif /* CFG_RAMBOOT */
 		__asm__ volatile ("sync");
 	}
 
+	lite5200b_wakeup();
+
 	return dramsize + dramsize2;
 }
 
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

--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="PM-platform_bus-and-late_suspend-early_resume.patch"

commit 386415d88b1ae50304f9c61aa3e0db082fa90428
Author: David Brownell <david-b@pacbell.net>
Date:   Sun Sep 3 13:16:45 2006 -0700

    PM: platform_bus and late_suspend/early_resume
    
    Teach platform_bus about the new suspend_late/resume_early PM calls,
    issued with IRQs off.  Do we really need sysdev and friends any more,
    or can janitors start switching its users over to platform_device so
    we can do a minor code-ectomy?
    
    Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
    Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -505,36 +505,12 @@ static int platform_match(struct device 
 	return (strncmp(pdev->name, drv->name, BUS_ID_SIZE) == 0);
 }
 
-static int platform_suspend(struct device *dev, pm_message_t mesg)
+static int platform_suspend(struct device * dev, pm_message_t state)
 {
 	int ret = 0;
 
 	if (dev->driver && dev->driver->suspend)
-		ret = dev->driver->suspend(dev, mesg);
-
-	return ret;
-}
-
-static int platform_suspend_late(struct device *dev, pm_message_t mesg)
-{
-	struct platform_driver *drv = to_platform_driver(dev->driver);
-	struct platform_device *pdev = container_of(dev, struct platform_device, dev);
-	int ret = 0;
-
-	if (dev->driver && drv->suspend_late)
-		ret = drv->suspend_late(pdev, mesg);
-
-	return ret;
-}
-
-static int platform_resume_early(struct device *dev)
-{
-	struct platform_driver *drv = to_platform_driver(dev->driver);
-	struct platform_device *pdev = container_of(dev, struct platform_device, dev);
-	int ret = 0;
-
-	if (dev->driver && drv->resume_early)
-		ret = drv->resume_early(pdev);
+		ret = dev->driver->suspend(dev, state);
 
 	return ret;
 }
@@ -555,8 +531,6 @@ struct bus_type platform_bus_type = {
 	.match		= platform_match,
 	.uevent		= platform_uevent,
 	.suspend	= platform_suspend,
-	.suspend_late	= platform_suspend_late,
-	.resume_early	= platform_resume_early,
 	.resume		= platform_resume,
 };
 EXPORT_SYMBOL_GPL(platform_bus_type);
diff --git a/drivers/base/power/resume.c b/drivers/base/power/resume.c
diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
diff --git a/drivers/ide/Kconfig b/drivers/ide/Kconfig
diff --git a/drivers/ide/Makefile b/drivers/ide/Makefile
diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
diff --git a/drivers/mtd/maps/Kconfig b/drivers/mtd/maps/Kconfig
diff --git a/drivers/mtd/maps/Makefile b/drivers/mtd/maps/Makefile
diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
diff --git a/drivers/net/Makefile b/drivers/net/Makefile
diff --git a/drivers/serial/mpc52xx_uart.c b/drivers/serial/mpc52xx_uart.c
diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
diff --git a/drivers/video/Makefile b/drivers/video/Makefile
diff --git a/drivers/video/cfbcopyarea.c b/drivers/video/cfbcopyarea.c
diff --git a/drivers/video/cfbfillrect.c b/drivers/video/cfbfillrect.c
diff --git a/drivers/video/cfbimgblt.c b/drivers/video/cfbimgblt.c
diff --git a/include/asm-ppc/mpc52xx.h b/include/asm-ppc/mpc52xx.h
diff --git a/include/linux/fb.h b/include/linux/fb.h
diff --git a/include/linux/ide.h b/include/linux/ide.h
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index 29cd6de..782090c 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -49,8 +49,6 @@ struct platform_driver {
 	int (*remove)(struct platform_device *);
 	void (*shutdown)(struct platform_device *);
 	int (*suspend)(struct platform_device *, pm_message_t state);
-	int (*suspend_late)(struct platform_device *, pm_message_t state);
-	int (*resume_early)(struct platform_device *);
 	int (*resume)(struct platform_device *);
 	struct device_driver driver;
 };
diff --git a/kernel/power/main.c b/kernel/power/main.c
diff --git a/sound/Kconfig b/sound/Kconfig
diff --git a/sound/Makefile b/sound/Makefile

--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="lite5200b_low_power.patch"

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
@@ -0,0 +1,141 @@
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/pm.h>
+#include <asm/io.h>
+#include <asm/reg.h>
+#include <asm/machdep.h>
+
+extern void l5200_sleep(void);
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
+extern void mpc52xx_pic_suspend(void);
+extern void mpc52xx_pic_resume(void);
+
+static int l5200_pm_enter(suspend_state_t state)
+{
+	struct mpc52xx_cdm __iomem *cdm;
+	struct mpc52xx_gpio __iomem *gpio;
+	unsigned long *start = (unsigned long *)0xc0700000;
+	unsigned long length = 0x1000000; // 16*4 mb
+
+	u32 gpio_saved_pc;
+
+	printk(KERN_ALERT "%s: %i\n", __func__, __LINE__);
+
+	/* Map zones */
+	cdm = ioremap(MPC52xx_PA(MPC52xx_CDM_OFFSET), MPC52xx_CDM_SIZE);
+	gpio = ioremap(MPC52xx_PA(MPC52xx_GPIO_OFFSET), MPC52xx_GPIO_SIZE);
+
+	if (!cdm || !gpio) {
+		printk(KERN_ALERT "erroring out %s: %i\n", __func__, __LINE__);
+		return 1;
+	}
+	cdm->ccs_sleep_enable = 0x01;	/* enable CSS (clock control sequencer)*/
+	__asm__ __volatile__ ("sync");
+
+	/* save ie. ethernet pins configuration */
+	gpio_saved_pc = gpio->port_config;
+
+#if 0
+	gpio->port_config  &= 0xff0fffff;
+	gpio->simple_gpioe |= 0x30000000;
+	gpio->simple_ddr   |= 0x30000000;
+	gpio->simple_dvo   = 0x30000000;
+	__asm__ __volatile__ ("sync");
+#endif
+	iounmap(cdm);
+	iounmap(gpio);
+
+	mpc52xx_pic_suspend();
+	{
+		unsigned long checksum = 0;
+		int i;
+		for (i=0; i<length; i++)
+			checksum += start[i];
+		printk(KERN_ALERT "%s: %i; checksum: 0x%lx\n", __func__, __LINE__, checksum);
+//		*(unsigned int*)0xc0000010 = checksum;
+
+		/*for (i=0; i<0x3ac0/4; i+=16/4) {
+			unsigned __iomem *io;
+			io = i + (unsigned __iomem *)0xf0000000;
+			printk(KERN_ALERT "%p:  %08x %08x %08x %08x\n",
+					io, in_be32(io), in_be32(io+4),
+					in_be32(io+8), in_be32(io+0xc));
+		}*/
+	}
+
+	if (state == PM_SUSPEND_MEM) {
+		l5200_qt_sleep();
+	}
+	{
+		unsigned long checksum = 0;
+		int i;
+		for (i=0; i<length; i++)
+			checksum += start[i];
+		printk(KERN_ALERT "%s: %i; checksum: 0x%lx\n", __func__, __LINE__, checksum);
+//		*(unsigned int*)0xc0000018 = checksum;
+
+		/*for (i=0; i<0x3ac0/4; i+=16/4) {
+			unsigned __iomem *io;
+			io = i + (unsigned __iomem *)0xf0000000;
+			printk(KERN_ALERT "%p:  %08x %08x %08x %08x\n",
+					io, in_be32(io), in_be32(io+4),
+					in_be32(io+8), in_be32(io+0xc));
+		}*/
+	}
+
+	gpio = ioremap(MPC52xx_PA(MPC52xx_GPIO_OFFSET), MPC52xx_GPIO_SIZE);
+	/* restore ie. ethernet pins configuration */
+	gpio->port_config = gpio_saved_pc;
+	iounmap(gpio);
+
+	ppc_md.setup_arch();
+	mpc52xx_pic_resume();
+
+	*((volatile char *)0xc0000008) = 0x2f;
+	asm volatile("dcbf 0,%0" : : "r" (0xc0000008) : "memory");
+
+	// red timer led
+	*((volatile int *)0xf0000630) = 0x24;
+	asm volatile("sync");
+
+	return 0;
+}
+
+static int l5200_pm_finish(suspend_state_t state)
+{
+	printk(KERN_ALERT "%s: %i\n", __func__, __LINE__);
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
+	printk(KERN_ALERT "%s: %i\n", __func__, __LINE__);
+	pm_set_ops(&lite5200_pm_ops);
+	return 0;
+}
+
+arch_initcall(lite5200_pm_init);
Index: work-powerpc.git/arch/ppc/platforms/lite5200_sleep.S
===================================================================
--- /dev/null
+++ work-powerpc.git/arch/ppc/platforms/lite5200_sleep.S
@@ -0,0 +1,490 @@
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
+
+// ----------------------------------------------------------------------
+// QT sleep
+
+// XXX it uses cca. 10 mA less if registers are saved in .text. WTF
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
+#define debug(x)		\
+	li	r9, x;		\
+	stb	r9, 0x8(r8);	\
+	dcbf	0, r8;
+
+	.globl l5200_qt_sleep
+l5200_qt_sleep:
+
+	// need to accept that irq, so it stays in deep sleep
+	mfmsr	r3
+	ori	r3, r3, 0x8000
+	sync; isync;
+	mtmsr	r3
+	sync; isync
+
+
+	lis	r3, 0xc000
+	mr	r8, r3
+	lis	r4, l5200_wakeup@h
+	ori	r4, r4, l5200_wakeup@l
+	xoris	r4, r4, 0xc000	// & ~0xc000 0000
+	stw	r4, 0(r3)
+
+	debug(1)
+
+	lis	r4, registers@h
+	ori	r4, r4, registers@l
+	// save 0xf0 (0xe0->0x100 gets overwritten when BDI connected;
+	//   even when CONFIG_BDI* is disabled and MMU XLAT commented; heisenbug?))
+	lwz	r10, 0xf0(r3)
+	stw	r10, (0x5f*4)(r4)
+	// save registers to r4 [destroys r10]
+	SAVE_SPRN(LR, 0x3c)
+	bl	save_regs
+
+	debug(2)
+	// flush caches [destroys r3, r4]
+	bl	flush_data_cache
+
+	debug(3)
+
+
+	// put it to sleep
+	mfmsr	r8
+	oris	r8, r8, 0x0004
+	xoris	r8, r8, 0x0004	// POW = 0
+	sync; isync;
+	mtmsr	r8
+	sync; isync;
+
+	mfspr	r8, SPRN_HID0
+	oris	r8, r8, 0x00f0
+	xoris	r8, r8, 0x00d0	// disable all power modes but sleep
+	sync; isync;
+	mtspr	SPRN_HID0, r8
+	sync; isync;
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
+
+	// deep sleep - this puts ram into self-refresh, just moment before
+	//   QT turns us off
+	mfmsr	r8
+	oris	r8, r8, 0x0004	// POW = 1
+	sync; isync;
+	mtmsr	r8
+	sync; isync;
+
+1:
+	b	1b
+
+
+
+// uboot jumps here on resume
+l5200_wakeup:
+	lis	r8, 0x0000
+
+	debug(0x18)
+
+	lis	r3, 0xf000
+	ori	r3, r3, 0x0b00
+	li	r4, 0x30
+	stb	r4, 0x04(r3)
+	sync
+	stb	r4, 0x0c(r3)
+	sync
+	//li	r4, 0x10 // red
+	//li	r4, 0x00 // both
+	//stb	r4, 0x10(r3)
+
+	debug(0x19)
+
+	bl	restore_regs
+
+	debug(0x1a)
+
+	// HIDs, MSR
+	LOAD_SPRN(HID1, 0x39)
+	LOAD_SPRN(HID2, 0x3a)
+
+	debug(0x1b)
+
+	// address translation is tricky (see turn_on_mmu)
+	mfmsr	r10
+	ori	r10, r10, MSR_DR | MSR_IR
+
+	debug(0x1c)
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
+	lis	r8, 0xc000
+
+	debug(0x1d)
+
+	// restore MSR
+	lwz	r10, (4*0x3b)(r4)
+	mtmsr	r10
+	sync
+	isync
+
+	debug(0x20)
+
+	mfspr	r10, SPRN_HID0
+	ori	r5, r10, 0x0c00
+	mtspr	SPRN_HID0, r5	// invalidate caches
+	sync
+	isync
+	mtspr	SPRN_HID0, r10
+	sync
+	isync
+
+	debug(0x21)
+
+	lwz	r10, (4*0x38)(r4)
+	mtspr	SPRN_HID0, r10	// restore (enable caches, DPM)
+	// ^ this has to be after address translation set in MSR
+	sync
+	isync
+
+	debug(0x22)
+
+	// r8 is 0xc0000000, from debug
+	// restore 0xf0
+	lwz	r10, (0x5f*4)(r4)
+	stw	r10, 0xf0(r8)
+
+	LOAD_SPRN(LR, 0x3c)
+
+	debug(0x23)
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
+	SAVE_SPRN(DEC,   0x59)
+	SAVE_SPRN(IBCR,  0x5a)
+	SAVE_SPRN(DBCR,  0x5b)
+	SAVE_SPRN(TBRL,  0x5c)
+	SAVE_SPRN(TBRU,  0x5d)
+	// 0x5f reserved by 0xf0
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
+	LOAD_SPRN(DEC,   0x59);
+	LOAD_SPRN(IBCR,  0x5a);
+	LOAD_SPRN(DBCR,  0x5b);
+	LOAD_SPRN(TBWL,  0x5c);	// these two have separate R/W regs
+	LOAD_SPRN(TBWU,  0x5d);
+	// 0x5f reserved by 0xf0
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
Index: work-powerpc.git/arch/ppc/syslib/mpc52xx_pic.c
===================================================================
--- work-powerpc.git.orig/arch/ppc/syslib/mpc52xx_pic.c
+++ work-powerpc.git/arch/ppc/syslib/mpc52xx_pic.c
@@ -301,6 +301,7 @@ mpc52xx_get_irq(void)
 		irq = (status >> 16) & 0x1f;
 		if (irq == 4)			/* low priority peripheral */
 			goto peripheral;
+		printk(KERN_ALERT "%s: %i status: %x\n", __func__, __LINE__, status);
 		irq += MPC52xx_MAIN_IRQ_BASE;
 	}
 	else if (status & 0x20000000) {		/* peripheral */
@@ -317,3 +318,47 @@ peripheral:
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
@@ -771,7 +771,7 @@ mpc52xx_uart_suspend(struct platform_dev
 {
 	struct uart_port *port = (struct uart_port *) platform_get_drvdata(dev);
 
-	if (sport)
+	if (port)
 		uart_suspend_port(&mpc52xx_uart_driver, port);
 
 	return 0;
Index: work-powerpc.git/include/asm-ppc/mpc52xx.h
===================================================================
--- work-powerpc.git.orig/include/asm-ppc/mpc52xx.h
+++ work-powerpc.git/include/asm-ppc/mpc52xx.h
@@ -142,6 +142,12 @@ enum ppc_sys_devices {
 #define MPC52xx_IRQ1			(MPC52xx_MAIN_IRQ_BASE + 1)
 #define MPC52xx_IRQ2			(MPC52xx_MAIN_IRQ_BASE + 2)
 #define MPC52xx_IRQ3			(MPC52xx_MAIN_IRQ_BASE + 3)
+/* see mpc5200b users manual, page 162 (7.2.4.11), and just count... */
+#define MPC52xx_LOINT_IRQ		(MPC52xx_MAIN_IRQ_BASE + 4)
+#define MPC52xx_RTC_PER_IRQ		(MPC52xx_MAIN_IRQ_BASE + 5)
+#define MPC52xx_RTC_STOP_IRQ		(MPC52xx_MAIN_IRQ_BASE + 6)
+#define MPC52xx_GPIO_IRQ		(MPC52xx_MAIN_IRQ_BASE + 7)
+#define MPC52xx_GPIO_WKUP_IRQ		(MPC52xx_MAIN_IRQ_BASE + 8)	/* == 13 */
 
 #define MPC52xx_SDMA_IRQ		(MPC52xx_PERP_IRQ_BASE + 0)
 #define MPC52xx_PSC1_IRQ		(MPC52xx_PERP_IRQ_BASE + 1)
Index: work-powerpc.git/drivers/net/fec_mpc52xx/fec.c
===================================================================
--- work-powerpc.git.orig/drivers/net/fec_mpc52xx/fec.c
+++ work-powerpc.git/drivers/net/fec_mpc52xx/fec.c
@@ -733,14 +733,64 @@ mpc52xx_fec_remove(struct device *dev)
 	return 0;
 }
 
+
+static struct device_driver mpc52xx_fec_driver;
+extern int mpc52xx_fec_mii_suspend(struct net_device *dev);
+int mpc52xx_fec_suspend(struct device *ddev, pm_message_t state)
+{
+#if 1
+	struct net_device *dev = dev_get_drvdata(ddev);
+	struct fec_priv *priv = dev->priv;
+	struct mpc52xx_fec *fec = priv->fec;
+
+	netif_stop_queue(dev);
+	out_be32(&fec->imask, 0x0);
+
+	/* Disable the rx and tx tasks. */
+	sdma_disable(priv->rx_sdma);
+	sdma_disable(priv->tx_sdma);
+
+	/* Stop FEC */
+	out_be32(&fec->ecntrl, in_be32(&fec->ecntrl) & ~0x2);
+
+	mpc52xx_fec_mii_suspend(dev);
+#else
+//	mpc52xx_fec_remove(ddev);
+#endif
+	return 0;
+}
+
+int mpc52xx_fec_resume(struct device *ddev)
+{
+#if 1
+	struct net_device *dev = dev_get_drvdata(ddev);
+	struct fec_priv *priv = dev->priv;
+	//struct mpc52xx_fec *fec = priv->fec;
+
+	/* Restart the DMA tasks */
+	sdma_fec_rx_init(priv->rx_sdma, priv->rx_fifo, FEC_RX_BUFFER_SIZE);
+	sdma_fec_tx_init(priv->tx_sdma, priv->tx_fifo);
+	fec_hw_init(dev);
+	fec_mii_init(dev);
+
+	if (priv->sequence_done) {		 /* redo the fec_open() */
+		fec_free_rx_buffers(priv->rx_sdma);
+		fec_open(dev);
+	}
+#else
+//	mpc52xx_fec_probe(ddev);
+#endif
+	return 0;
+}
+
 static struct device_driver mpc52xx_fec_driver = {
 	.name	  = DRIVER_NAME,
 	.bus		= &platform_bus_type,
 	.probe		= mpc52xx_fec_probe,
 	.remove		= mpc52xx_fec_remove,
 #ifdef CONFIG_PM
-/*	.suspend	= mpc52xx_fec_suspend,	TODO */
-/*	.resume		= mpc52xx_fec_resume,	TODO */
+	.suspend	= mpc52xx_fec_suspend,
+	.resume		= mpc52xx_fec_resume,
 #endif
 };
 
Index: work-powerpc.git/drivers/net/fec_mpc52xx/fec_phy.c
===================================================================
--- work-powerpc.git.orig/drivers/net/fec_mpc52xx/fec_phy.c
+++ work-powerpc.git/drivers/net/fec_mpc52xx/fec_phy.c
@@ -521,6 +521,23 @@ int fec_mii_wait(struct net_device *dev)
 	return 0;
 }
 
+
+phy_cmd_t phy_cmd_powerdown[] =  { { mk_mii_write(0x00, 0x0800), NULL }, // power down
+				{ mk_mii_end, } };
+phy_cmd_t phy_cmd_sleep[] =  { { mk_mii_write(MII_LXT971_PCR, 0x00dc), NULL }, // sleep after 1 sec
+				{ mk_mii_write(0x14, 0xbbb2), NULL }, // disable leds
+				{ mk_mii_end, } };
+phy_cmd_t phy_cmd_wakeup[] =  { { mk_mii_write(MII_LXT971_PCR, 0x0084), NULL },
+				{ mk_mii_end, } };
+phy_cmd_t phy_cmd_poweron[] =  { { mk_mii_write(MII_BMCR, (BMCR_ANENABLE | BMCR_ANRESTART)), NULL },
+	  			{ mk_mii_end, } };
+
+void mpc52xx_fec_mii_suspend(struct net_device *dev)
+{
+	mii_do_cmd(dev, phy_cmd_powerdown);
+	printk(KERN_ALERT "%s: %i\n", __func__, __LINE__);
+}
+
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Dale Farnsworth");
 MODULE_DESCRIPTION("PHY driver for Motorola MPC52xx FEC");
Index: work-powerpc.git/kernel/power/main.c
===================================================================
--- work-powerpc.git.orig/kernel/power/main.c
+++ work-powerpc.git/kernel/power/main.c
@@ -115,9 +115,26 @@ int suspend_enter(suspend_state_t state)
 		goto Done;
 	}
 	error = pm_ops->enter(state);
+	// zakaj za vraga se ne vrne sem? nima smisla, saj so vsi registri prav nastavljeni
+	*((volatile char *)0xc0000008) = 0x30;
+	asm volatile("dcbf 0,%0" : : "r" (0xc0000008) : "memory");
+
+	*((volatile long *)0xf0000620)   = 0x24;	// timer2 led, green
+	__asm__ __volatile__ ("sync");
+
+	*((volatile long *)0xf0000b10)   = 0x20000000;	// green
+	__asm__ __volatile__ ("sync");
+	*((volatile char *)0xc0000008)   = 0x31;
+	asm volatile("dcbf 0,%0" : : "r" (0xc0000008) : "memory");
 	device_power_up();
  Done:
+	*((volatile long *)0xf0000b10)   = 0x00000000;	// both
+	*((volatile char *)0xc0000008)   = 0x32;
+	asm volatile("dcbf 0,%0" : : "r" (0xc0000008) : "memory");
+	__asm__ __volatile__ ("sync");
 	local_irq_restore(flags);
+	*((volatile char *)0xc0000008)   = 0x33;
+	asm volatile("dcbf 0,%0" : : "r" (0xc0000008) : "memory");
 	return error;
 }
 
@@ -132,13 +149,27 @@ int suspend_enter(suspend_state_t state)
 
 static void suspend_finish(suspend_state_t state)
 {
+	*((volatile char *)0xc0000008)   = 0x40;
+	asm volatile("dcbf 0,%0" : : "r" (0xc0000008) : "memory");
 	device_resume();
+	*((volatile char *)0xc0000008)   = 0x41;
+	asm volatile("dcbf 0,%0" : : "r" (0xc0000008) : "memory");
 	resume_console();
+	*((volatile char *)0xc0000008)   = 0x42;
+	asm volatile("dcbf 0,%0" : : "r" (0xc0000008) : "memory");
 	thaw_processes();
+	*((volatile char *)0xc0000008)   = 0x43;
+	asm volatile("dcbf 0,%0" : : "r" (0xc0000008) : "memory");
 	enable_nonboot_cpus();
+	*((volatile char *)0xc0000008)   = 0x44;
+	asm volatile("dcbf 0,%0" : : "r" (0xc0000008) : "memory");
 	if (pm_ops && pm_ops->finish)
 		pm_ops->finish(state);
+	*((volatile char *)0xc0000008)   = 0x45;
+	asm volatile("dcbf 0,%0" : : "r" (0xc0000008) : "memory");
 	pm_restore_console();
+	*((volatile char *)0xc0000008)   = 0x46;
+	asm volatile("dcbf 0,%0" : : "r" (0xc0000008) : "memory");
 }
 
 
@@ -197,10 +228,17 @@ static int enter_state(suspend_state_t s
 	pr_debug("PM: Entering %s sleep\n", pm_states[state]);
 	error = suspend_enter(state);
 
+	*((volatile char *)0xc0000008)   = 0x35;
+	asm volatile("dcbf 0,%0" : : "r" (0xc0000008) : "memory");
 	pr_debug("PM: Finishing wakeup.\n");
+	*((volatile char *)0xc0000008)   = 0x36;
+	asm volatile("dcbf 0,%0" : : "r" (0xc0000008) : "memory");
 	suspend_finish(state);
+	*((volatile char *)0xc0000008)   = 0x37;
+	asm volatile("dcbf 0,%0" : : "r" (0xc0000008) : "memory");
  Unlock:
 	up(&pm_sem);
+	*((volatile char *)0xc0000008)   = 0x38;
 	return error;
 }
 
Index: work-powerpc.git/drivers/base/power/resume.c
===================================================================
--- work-powerpc.git.orig/drivers/base/power/resume.c
+++ work-powerpc.git/drivers/base/power/resume.c
@@ -70,10 +70,14 @@ static int resume_device_early(struct de
 void dpm_resume(void)
 {
 	down(&dpm_list_sem);
+	int foo = 0x50;
 	while(!list_empty(&dpm_off)) {
 		struct list_head * entry = dpm_off.next;
 		struct device * dev = to_device(entry);
 
+		*((volatile char *)0xc0000008)   = foo++;
+		asm volatile("dcbf 0,%0" : : "r" (0xc0000008) : "memory");
+
 		get_device(dev);
 		list_move_tail(entry, &dpm_active);
 
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
 
 
@@ -217,8 +220,7 @@ mpc52xx_calibrate_decr(void)
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
Index: work-powerpc.git/arch/ppc/syslib/bestcomm/bestcomm.c
===================================================================
--- work-powerpc.git.orig/arch/ppc/syslib/bestcomm/bestcomm.c
+++ work-powerpc.git/arch/ppc/syslib/bestcomm/bestcomm.c
@@ -361,6 +361,77 @@ out:
 }
 
 
+/* saved sdma regs */
+struct mpc52xx_sdma sdma_regs;
+char saved_sram[0x4000]; // 16 kB
+static int mpc52xx_sdma_suspend(struct device *dev, pm_message_t state)
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
+static int mpc52xx_sdma_resume(struct device *dev)
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
 static struct device_driver mpc52xx_sdma_driver = {
 	.owner	  = THIS_MODULE,
 	.name	  = DRIVER_NAME,
@@ -368,8 +439,8 @@ static struct device_driver mpc52xx_sdma
 	.probe 	  = mpc52xx_sdma_probe,
 /*	.remove	  = mpc52xx_sdma_remove,	TODO */
 #ifdef CONFIG_PM
-/*	.suspend	= mpc52xx_sdma_suspend,	TODO */
-/*	.resume		= mpc52xx_sdma_resume,	TODO */
+	.suspend	= mpc52xx_sdma_suspend,
+	.resume		= mpc52xx_sdma_resume,
 #endif
 };
 

--7AUc2qLy4jB3hD7Z--
