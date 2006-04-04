Return-Path: <jcrigby@gmail.com>
Message-ID: <4b73d43f0604041508t369d08d5n73a3498b51edc27f@mail.gmail.com>
Date: Tue, 4 Apr 2006 16:08:45 -0600
From: "John Rigby" <jcrigby@gmail.com>
To: "Sylvain Munaut" <tnt@246tnt.com>,
	Linuxppc-embedded <Linuxppc-embedded@ozlabs.org>
Subject: [PATCH] Add support for Freescale MEDIA5200 MPC5200 based platform
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_9829_14386636.1144188525908"
Cc: John Rigby <jrigby@freescale.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_9829_14386636.1144188525908
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Sylvain,

This adds support for the Media5200 platform.  A couple ugly things are 1)
A new file arch/ppc/platforms/media5200.c duplicates alot of code in
..../lite5200.c and 2) the patch adds some platform specific interrupt
code to arch/ppc/syslib/mpc52xx_pic.c.  The platform has an FPGA that
cascades the 4 PCI interrupts off of MPC52xx_IRQ0.  I suppose a
cleaner solution would be to add some generic cascade code to
mpc52xx_pic.c and add a new file to arch/ppc/platforms/media5200_pic.c
or some thing like that.  Let me know what you think.

John

------=_Part_9829_14386636.1144188525908
Content-Type: text/plain;
	name=0001-Add-support-for-Freescale-MEDIA5200-MPC5200-based-platform.txt;
	charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Attachment-Id: f_elmror93
Content-Disposition: attachment; filename="0001-Add-support-for-Freescale-MEDIA5200-MPC5200-based-platform.txt"

>From nobody Mon Sep 17 00:00:00 2001
From: John Rigby <jrigby@freescale.com>
Date: Tue Apr 4 14:59:18 2006 -0600
Subject: [PATCH] Add support for Freescale MEDIA5200 MPC5200 based platform.

Signed-off-by: John Rigby <jrigby@freescale.com>

---

 arch/ppc/Kconfig               |    6 +
 arch/ppc/platforms/Makefile    |    1 
 arch/ppc/platforms/media5200.c |  218 ++++++++++++++++++++++++++++++++++++++++
 arch/ppc/platforms/media5200.h |   21 ++++
 arch/ppc/syslib/mpc52xx_pic.c  |   49 +++++++++
 include/asm-ppc/mpc52xx.h      |   17 +++
 6 files changed, 312 insertions(+), 0 deletions(-)
 create mode 100644 arch/ppc/platforms/media5200.c
 create mode 100644 arch/ppc/platforms/media5200.h

03370dab9b10e5354b49734161bbd9e28c076b87
diff --git a/arch/ppc/Kconfig b/arch/ppc/Kconfig
index 776f5a9..7a7c14d 100644
--- a/arch/ppc/Kconfig
+++ b/arch/ppc/Kconfig
@@ -671,6 +671,12 @@ config LITE5200B
 	  Support for the LITE5200B dev board for the MPC5200 from Freescale.
 	  This is the new board with 2 PCI slots.
 
+config MEDIA5200
+	bool "Freescale MEDIA5200"
+	select PPC_MPC52xx
+	help
+	  Support for the MEDIA5200 dev platform for the MPC5200 from Freescale.
+
 config MPC834x_SYS
 	bool "Freescale MPC834x SYS"
 	help
diff --git a/arch/ppc/platforms/Makefile b/arch/ppc/platforms/Makefile
index 51430e2..b2bd70f 100644
--- a/arch/ppc/platforms/Makefile
+++ b/arch/ppc/platforms/Makefile
@@ -36,6 +36,7 @@ obj-$(CONFIG_SANDPOINT)		+= sandpoint.o
 obj-$(CONFIG_SBC82xx)		+= sbc82xx.o
 obj-$(CONFIG_SPRUCE)		+= spruce.o
 obj-$(CONFIG_LITE5200)		+= lite5200.o
+obj-$(CONFIG_MEDIA5200)		+= media5200.o
 obj-$(CONFIG_EV64360)		+= ev64360.o
 
 ifeq ($(CONFIG_SMP),y)
diff --git a/arch/ppc/platforms/media5200.c b/arch/ppc/platforms/media5200.c
new file mode 100644
index 0000000..52fcc66
--- /dev/null
+++ b/arch/ppc/platforms/media5200.c
@@ -0,0 +1,218 @@
+/*
+ * Platform support file for the Freescale MEDIA5200 based on MPC52xx.
+ *
+ * Copyright 2005,2006 Freescale, Bernhard Kuhn, John Rigby
+ *
+ * This file originally based on lite5200.c
+ * 
+ * Maintainer : Sylvain Munaut <tnt@246tNt.com>
+ *
+ * Based on the 2.4 code written by Kent Borg,
+ * Dale Farnsworth <dale.farnsworth@mvista.com> and
+ * Wolfgang Denk <wd@denx.de>
+ * 
+ * Copyright 2004 Sylvain Munaut <tnt@246tNt.com>
+ * Copyright 2003 Motorola Inc.
+ * Copyright 2003 MontaVista Software Inc.
+ * Copyright 2003 DENX Software Engineering (wd@denx.de)
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2. This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+#include <linux/config.h>
+#include <linux/initrd.h>
+#include <linux/seq_file.h>
+#include <linux/kdev_t.h>
+#include <linux/root_dev.h>
+#include <linux/console.h>
+#include <linux/module.h>
+
+#include <asm/bootinfo.h>
+#include <asm/io.h>
+#include <asm/mpc52xx.h>
+#include <asm/ppc_sys.h>
+#include <asm/machdep.h>
+#include <asm/pci-bridge.h>
+
+
+extern int powersave_nap;
+
+/* Board data given by U-Boot */
+bd_t __res;
+EXPORT_SYMBOL(__res);	/* For modules */
+
+
+/* ======================================================================== */
+/* Platform specific code                                                   */
+/* ======================================================================== */
+
+/* Supported PSC function in "preference" order */
+struct mpc52xx_psc_func mpc52xx_psc_functions[] = {
+		{       .id     = 5,
+			.func   = "uart",
+		},
+		{       .id     = -1,   /* End entry */
+			.func   = NULL,
+		}
+	};
+
+
+static int
+media5200_show_cpuinfo(struct seq_file *m)
+{
+	seq_printf(m, "machine\t\t: Freescale MEDIA5200\n");
+	return 0;
+}
+
+#ifdef CONFIG_PCI
+
+static int
+mpc5200_map_irq_mapping[4][6] = {
+  //  Connector 1         Connector 2         Mini-PCI         SIU     CoralPA         MPC5200
+  { MEDIA5200_PCI0_IRQ, MEDIA5200_PCI1_IRQ, MEDIA5200_PCI2_IRQ, -1, MEDIA5200_PCI3_IRQ, -1 }, // Pin A
+  { MEDIA5200_PCI1_IRQ, MEDIA5200_PCI2_IRQ, MEDIA5200_PCI3_IRQ, -1,                 -1, -1 }, // Pin B
+  { MEDIA5200_PCI2_IRQ, MEDIA5200_PCI3_IRQ,                 -1, -1,                 -1, -1 }, // Pin C
+  { MEDIA5200_PCI3_IRQ, MEDIA5200_PCI0_IRQ,                 -1, -1,                 -1, -1 }  // Pin D
+};
+
+static int
+media5200_map_irq(struct pci_dev *dev, unsigned char idsel,
+                 unsigned char pin) {
+	return mpc5200_map_irq_mapping[pin-1][idsel-24];
+}
+#endif
+
+static void __init
+media5200_setup_cpu(void)
+{
+	struct mpc52xx_gpio __iomem *gpio;
+	struct mpc52xx_intr __iomem *intr;
+
+	u32 port_config;
+	u32 intr_ctrl;
+
+	/* Map zones */
+	gpio = ioremap(MPC52xx_PA(MPC52xx_GPIO_OFFSET), MPC52xx_GPIO_SIZE);
+	intr = ioremap(MPC52xx_PA(MPC52xx_INTR_OFFSET), MPC52xx_INTR_SIZE);
+
+	if (!gpio || !intr) {
+		printk(KERN_ERR __FILE__ ": "
+			"Error while mapping GPIO/INTR during "
+			"media5200_setup_cpu\n");
+		goto unmap_regs;
+	}
+
+	// FIXME
+	port_config = 0x11551c20;
+	out_be32(&gpio->port_config, port_config);
+
+	/* IRQ[0-3] setup : IRQ0     - Level Active Low  */
+	/*                  IRQ[1-3] - Level Active High */
+	intr_ctrl = in_be32(&intr->ctrl);
+	intr_ctrl &= ~0x00ff0000;
+	intr_ctrl |=  0x00c00000;
+	out_be32(&intr->ctrl, intr_ctrl);
+
+	/* Unmap reg zone */
+unmap_regs:
+	if (gpio) iounmap(gpio);
+	if (intr) iounmap(intr);
+}
+
+static void __init
+media5200_setup_arch(void)
+{
+	/* CPU & Port mux setup */
+	mpc52xx_setup_cpu();	/* Generic */
+	media5200_setup_cpu();	/* Platform specific */
+
+#ifdef CONFIG_PCI
+	/* PCI Bridge setup */
+	mpc52xx_find_bridges();
+#endif
+}
+
+// TODO CONFIG_ARCH_IRQ_PRIO
+void __init
+platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
+              unsigned long r6, unsigned long r7)
+{
+	/* Generic MPC52xx platform initialization */
+	/* TODO Create one and move a max of stuff in it.
+	   Put this init in the syslib */
+
+	struct bi_record *bootinfo = find_bootinfo();
+
+	if (bootinfo)
+		parse_bootinfo(bootinfo);
+	else {
+		/* Load the bd_t board info structure */
+		if (r3)
+			memcpy((void*)&__res,(void*)(r3+KERNELBASE),
+					sizeof(bd_t));
+
+#ifdef CONFIG_BLK_DEV_INITRD
+		/* Load the initrd */
+		if (r4) {
+			initrd_start = r4 + KERNELBASE;
+			initrd_end = r5 + KERNELBASE;
+		}
+#endif
+
+		/* Load the command line */
+		if (r6) {
+			*(char *)(r7+KERNELBASE) = 0;
+			strcpy(cmd_line, (char *)(r6+KERNELBASE));
+		}
+	}
+
+	/* PPC Sys identification */
+	identify_ppc_sys_by_id(mfspr(SPRN_SVR));
+
+	/* BAT setup */
+	mpc52xx_set_bat();
+
+	/* No ISA bus by default */
+#ifdef CONFIG_PCI
+	isa_io_base		= 0;
+	isa_mem_base		= 0;
+#endif
+
+	/* Powersave */
+	/* This is provided as an example on how to do it. But you
+	   need to be aware that NAP disable bus snoop and that may
+	   be required for some devices to work properly, like USB ... */
+	/* powersave_nap = 1; */
+
+
+	/* Setup the ppc_md struct */
+	ppc_md.setup_arch	= media5200_setup_arch;
+	ppc_md.show_cpuinfo	= media5200_show_cpuinfo;
+	ppc_md.show_percpuinfo	= NULL;
+	ppc_md.init_IRQ		= mpc52xx_init_irq;
+	ppc_md.get_irq		= mpc52xx_get_irq;
+
+#ifdef CONFIG_PCI
+	ppc_md.pci_map_irq	= media5200_map_irq;
+#endif
+
+	ppc_md.find_end_of_memory = mpc52xx_find_end_of_memory;
+	ppc_md.setup_io_mappings  = mpc52xx_map_io;
+
+	ppc_md.restart		= mpc52xx_restart;
+	ppc_md.power_off	= mpc52xx_power_off;
+	ppc_md.halt		= mpc52xx_halt;
+
+		/* No time keeper on the MEDIA5200 */
+	ppc_md.time_init	= NULL;
+	ppc_md.get_rtc_time	= NULL;
+	ppc_md.set_rtc_time	= NULL;
+
+	ppc_md.calibrate_decr	= mpc52xx_calibrate_decr;
+#ifdef CONFIG_SERIAL_TEXT_DEBUG
+	ppc_md.progress		= mpc52xx_progress;
+#endif
+}
+
diff --git a/arch/ppc/platforms/media5200.h b/arch/ppc/platforms/media5200.h
new file mode 100644
index 0000000..b72d6c5
--- /dev/null
+++ b/arch/ppc/platforms/media5200.h
@@ -0,0 +1,21 @@
+/*
+ * Definitions for Freescale MEDIA5200 : MPC52xx Standard Development
+ * Platform board support
+ * 
+ * Maintainer : Sylvain Munaut <tnt@246tNt.com>
+ * 
+ * Copyright (C) 2004 Sylvain Munaut <tnt@246tNt.com>
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2. This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+#ifndef __PLATFORMS_MEDIA5200_H__
+#define __PLATFORMS_MEDIA5200_H__
+
+/* Serial port used for low-level debug */
+#define MPC52xx_PF_CONSOLE_PORT 6	/* PSC6 */
+
+
+#endif /* __PLATFORMS_MEDIA5200_H__ */
diff --git a/arch/ppc/syslib/mpc52xx_pic.c b/arch/ppc/syslib/mpc52xx_pic.c
index 4c4497e..b9e2cdb 100644
--- a/arch/ppc/syslib/mpc52xx_pic.c
+++ b/arch/ppc/syslib/mpc52xx_pic.c
@@ -36,15 +36,23 @@
 static struct mpc52xx_intr __iomem *intr;
 static struct mpc52xx_sdma __iomem *sdma;
 
+// FIXME ioremap these
+#ifdef CONFIG_MEDIA5200
+#define MEDIA5200_FPGA_INT_MASK ((u32*)0xf001040c)
+#define MEDIA5200_FPGA_INT_STAT ((u32*)0xf0010410)
+#endif
+
 static void
 mpc52xx_ic_disable(unsigned int irq)
 {
 	u32 val;
 
 	if (irq == MPC52xx_IRQ0) {
+#ifndef CONFIG_MEDIA5200
 		val = in_be32(&intr->ctrl);
 		val &= ~(1 << 11);
 		out_be32(&intr->ctrl, val);
+#endif
 	}
 	else if (irq < MPC52xx_IRQ1) {
 		BUG();
@@ -64,11 +72,22 @@ mpc52xx_ic_disable(unsigned int irq)
 		val |= 1 << (irq - MPC52xx_SDMA_IRQ_BASE);
 		out_be32(&sdma->IntMask, val);
 	}
+#ifdef CONFIG_MEDIA5200
+	else if (irq < MEDIA5200_FPGA_IRQ_BASE) {
+#else
 	else {
+#endif
 		val = in_be32(&intr->per_mask);
 		val |= 1 << (31 - (irq - MPC52xx_PERP_IRQ_BASE));
 		out_be32(&intr->per_mask, val);
 	}
+#ifdef CONFIG_MEDIA5200
+	else {
+	        val = in_be32(MEDIA5200_FPGA_INT_MASK);
+		val &= ~(1 << (irq - MEDIA5200_FPGA_IRQ_BASE + 28));
+		out_be32(MEDIA5200_FPGA_INT_MASK, val);
+	}
+#endif
 }
 
 static void
@@ -77,9 +96,11 @@ mpc52xx_ic_enable(unsigned int irq)
 	u32 val;
 
 	if (irq == MPC52xx_IRQ0) {
+#ifndef CONFIG_MEDIA5200
 		val = in_be32(&intr->ctrl);
 		val |= 1 << 11;
 		out_be32(&intr->ctrl, val);
+#endif
 	}
 	else if (irq < MPC52xx_IRQ1) {
 		BUG();
@@ -99,11 +120,22 @@ mpc52xx_ic_enable(unsigned int irq)
 		val &= ~(1 << (irq - MPC52xx_SDMA_IRQ_BASE));
 		out_be32(&sdma->IntMask, val);
 	}
+#ifdef CONFIG_MEDIA5200
+	else if (irq < MEDIA5200_FPGA_IRQ_BASE) {
+#else
 	else {
+#endif
 		val = in_be32(&intr->per_mask);
 		val &= ~(1 << (31 - (irq - MPC52xx_PERP_IRQ_BASE)));
 		out_be32(&intr->per_mask, val);
 	}
+#ifdef CONFIG_MEDIA5200
+	else {
+	        val = in_be32(MEDIA5200_FPGA_INT_MASK);
+		val |= (1 << (irq - MEDIA5200_FPGA_IRQ_BASE + 28));
+		out_be32(MEDIA5200_FPGA_INT_MASK, val);
+	}
+#endif
 }
 
 static void
@@ -117,9 +149,11 @@ mpc52xx_ic_ack(unsigned int irq)
 
 	switch (irq) {
 	case MPC52xx_IRQ0:
+#ifndef CONFIG_MEDIA5200
 		val = in_be32(&intr->ctrl);
 		val |= 0x08000000;
 		out_be32(&intr->ctrl, val);
+#endif
 		break;
 	case MPC52xx_CCS_IRQ:
 		val = in_be32(&intr->enc_status);
@@ -187,6 +221,9 @@ mpc52xx_init_irq(void)
 		panic("Can't ioremap PIC/SDMA register for init_irq !");
 
 	/* Disable all interrupt sources. */
+#ifdef CONFIG_MEDIA5200
+	out_be32(MEDIA5200_FPGA_INT_MASK,0x00000000);
+#endif
 	out_be32(&sdma->IntPend, 0xffffffff);	/* 1 means clear pending */
 	out_be32(&sdma->IntMask, 0xffffffff);	/* 1 means disabled */
 	out_be32(&intr->per_mask, 0x7ffffc00);	/* 1 means disabled */
@@ -195,6 +232,10 @@ mpc52xx_init_irq(void)
 	intr_ctrl &=    0x00ff0000;	/* Keeps IRQ[0-3] config */
 	intr_ctrl |=	0x0f000000 |	/* clear IRQ 0-3 */
 			0x00001000 |	/* MEE master external enable */
+#ifdef CONFIG_MEDIA5200
+			0x00c00000 |	/* IRQ0: level-sensitive, active low */
+			0x00000800 |	/* enable IRQ 0, disable IRQ 1,2,3 */
+#endif
 			0x00000000 |	/* 0 means disable IRQ 0-3 */
 			0x00000001;	/* CEb route critical normally */
 	out_be32(&intr->ctrl, intr_ctrl);
@@ -227,6 +268,14 @@ mpc52xx_get_irq(struct pt_regs *regs)
 	u32 status;
 	int irq = -1;
 
+#ifdef CONFIG_MEDIA5200
+	status = in_be32(MEDIA5200_FPGA_INT_STAT) & in_be32(MEDIA5200_FPGA_INT_MASK);
+	if(status & 0xffff0000) {
+	  irq = ffs(status) - 1 + MEDIA5200_FPGA_IRQ_BASE - 28;
+	  // printk("IRQ=%i\n",irq);
+	  return irq;
+	}
+#endif
 	status = in_be32(&intr->enc_status);
 
 	if (status & 0x00000400) {		/* critical */
diff --git a/include/asm-ppc/mpc52xx.h b/include/asm-ppc/mpc52xx.h
index bd953b9..0b8edaf 100644
--- a/include/asm-ppc/mpc52xx.h
+++ b/include/asm-ppc/mpc52xx.h
@@ -119,11 +119,17 @@ enum ppc_sys_devices {
 #define MPC52xx_MAIN_IRQ_NUM	17
 #define MPC52xx_SDMA_IRQ_NUM	17
 #define MPC52xx_PERP_IRQ_NUM	23
+#ifdef CONFIG_MEDIA5200
+#define MEDIA5200_FPGA_IRQ_NUM	6
+#endif
 
 #define MPC52xx_CRIT_IRQ_BASE	1
 #define MPC52xx_MAIN_IRQ_BASE	(MPC52xx_CRIT_IRQ_BASE + MPC52xx_CRIT_IRQ_NUM)
 #define MPC52xx_SDMA_IRQ_BASE	(MPC52xx_MAIN_IRQ_BASE + MPC52xx_MAIN_IRQ_NUM)
 #define MPC52xx_PERP_IRQ_BASE	(MPC52xx_SDMA_IRQ_BASE + MPC52xx_SDMA_IRQ_NUM)
+#ifdef CONFIG_MEDIA5200
+#define MEDIA5200_FPGA_IRQ_BASE	(MPC52xx_PERP_IRQ_BASE + MPC52xx_PERP_IRQ_NUM)
+#endif
 
 #define MPC52xx_IRQ0			(MPC52xx_CRIT_IRQ_BASE + 0)
 #define MPC52xx_SLICE_TIMER_0_IRQ	(MPC52xx_CRIT_IRQ_BASE + 1)
@@ -159,6 +165,14 @@ enum ppc_sys_devices {
 #define MPC52xx_XLB_ARB_IRQ		(MPC52xx_PERP_IRQ_BASE + 21)
 #define MPC52xx_BDLC_IRQ		(MPC52xx_PERP_IRQ_BASE + 22)
 
+#ifdef CONFIG_MEDIA5200
+#define MEDIA5200_PCI0_IRQ              (MEDIA5200_FPGA_IRQ_BASE + 0)
+#define MEDIA5200_PCI1_IRQ              (MEDIA5200_FPGA_IRQ_BASE + 1)
+#define MEDIA5200_PCI2_IRQ              (MEDIA5200_FPGA_IRQ_BASE + 2)
+#define MEDIA5200_PCI3_IRQ              (MEDIA5200_FPGA_IRQ_BASE + 3)
+#define MEDIA5200_EU0_IRQ               (MEDIA5200_FPGA_IRQ_BASE + 4)
+#define MEDIA5200_EU1_IRQ               (MEDIA5200_FPGA_IRQ_BASE + 5)
+#endif
 
 
 /* ======================================================================== */
@@ -457,6 +471,9 @@ extern bd_t __res;
 #if defined(CONFIG_LITE5200)
 #include <platforms/lite5200.h>
 #endif
+#if defined(CONFIG_MEDIA5200)
+#include <platforms/media5200.h>
+#endif
 
 
 #endif /* __ASM_MPC52xx_H__ */
-- 
1.2.4











------=_Part_9829_14386636.1144188525908--
