Return-Path: <mgreer@mvista.com>
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by ozlabs.org (Postfix) with ESMTP id 5ACBE67A7D
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 26 Jan 2005 11:14:36 +1100 (EST)
Message-ID: <41F6E0E1.6000803@mvista.com>
Date: Tue, 25 Jan 2005 17:14:25 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: akpm <akpm@osdl.org>
Content-Type: multipart/mixed; boundary="------------050200070608020603020505"
Cc: Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
Subject: [PATCH][PPC32] mv64x60 updates
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
--------------050200070608020603020505
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrew.

This patch briges the mv64x60 related code up to the latest that I have.

It:
- adds MPSC support to some ppc bootwrapper files
- adds an erratum workaround for the mv64460
- changes some platform_data related structure names
- cleans up a bunch of whitespace

Signed-off-by: Mark A. Greer <mgreer@mvista.com>
--

--------------050200070608020603020505
Content-Type: text/plain;
 name="mv64x60.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mv64x60.patch"

diff -Nru a/arch/ppc/boot/common/misc-common.c b/arch/ppc/boot/common/misc-common.c
--- a/arch/ppc/boot/common/misc-common.c	2005-01-25 17:05:15 -07:00
+++ b/arch/ppc/boot/common/misc-common.c	2005-01-25 17:05:15 -07:00
@@ -60,7 +60,8 @@
 unsigned char *ISA_io = NULL;
 
 #if defined(CONFIG_SERIAL_CPM_CONSOLE) || defined(CONFIG_SERIAL_8250_CONSOLE) \
-	|| defined(CONFIG_SERIAL_MPC52xx_CONSOLE)
+	|| defined(CONFIG_SERIAL_MPC52xx_CONSOLE) \
+	|| defined(CONFIG_SERIAL_MPSC_CONSOLE)
 extern unsigned long com_port;
 
 extern int serial_tstc(unsigned long com_port);
@@ -82,7 +83,8 @@
 int tstc(void)
 {
 #if defined(CONFIG_SERIAL_CPM_CONSOLE) || defined(CONFIG_SERIAL_8250_CONSOLE) \
-	|| defined(CONFIG_SERIAL_MPC52xx_CONSOLE)
+	|| defined(CONFIG_SERIAL_MPC52xx_CONSOLE) \
+	|| defined(CONFIG_SERIAL_MPSC_CONSOLE)
 	if(keyb_present)
 		return (CRT_tstc() || serial_tstc(com_port));
 	else
@@ -96,7 +98,8 @@
 {
 	while (1) {
 #if defined(CONFIG_SERIAL_CPM_CONSOLE) || defined(CONFIG_SERIAL_8250_CONSOLE) \
-	|| defined(CONFIG_SERIAL_MPC52xx_CONSOLE)
+	|| defined(CONFIG_SERIAL_MPC52xx_CONSOLE) \
+	|| defined(CONFIG_SERIAL_MPSC_CONSOLE)
 		if (serial_tstc(com_port))
 			return (serial_getc(com_port));
 #endif /* serial console */
@@ -112,7 +115,8 @@
 	int x,y;
 
 #if defined(CONFIG_SERIAL_CPM_CONSOLE) || defined(CONFIG_SERIAL_8250_CONSOLE) \
-	|| defined(CONFIG_SERIAL_MPC52xx_CONSOLE)
+	|| defined(CONFIG_SERIAL_MPC52xx_CONSOLE) \
+	|| defined(CONFIG_SERIAL_MPSC_CONSOLE)
 	serial_putc(com_port, c);
 	if ( c == '\n' )
 		serial_putc(com_port, '\r');
@@ -160,7 +164,8 @@
 
 	while ( ( c = *s++ ) != '\0' ) {
 #if defined(CONFIG_SERIAL_CPM_CONSOLE) || defined(CONFIG_SERIAL_8250_CONSOLE) \
-	|| defined(CONFIG_SERIAL_MPC52xx_CONSOLE)
+	|| defined(CONFIG_SERIAL_MPC52xx_CONSOLE) \
+	|| defined(CONFIG_SERIAL_MPSC_CONSOLE)
 	        serial_putc(com_port, c);
 	        if ( c == '\n' ) serial_putc(com_port, '\r');
 #endif /* serial console */
diff -Nru a/arch/ppc/boot/simple/misc.c b/arch/ppc/boot/simple/misc.c
--- a/arch/ppc/boot/simple/misc.c	2005-01-25 17:05:15 -07:00
+++ b/arch/ppc/boot/simple/misc.c	2005-01-25 17:05:15 -07:00
@@ -50,7 +50,8 @@
  */
 #if (defined(CONFIG_SERIAL_8250_CONSOLE) \
 	|| defined(CONFIG_VGA_CONSOLE) \
-	|| defined(CONFIG_SERIAL_MPC52xx_CONSOLE)) \
+	|| defined(CONFIG_SERIAL_MPC52xx_CONSOLE) \
+	|| defined(CONFIG_SERIAL_MPSC_CONSOLE)) \
 	&& !defined(CONFIG_GEMINI)
 #define INTERACTIVE_CONSOLE	1
 #endif
@@ -98,7 +99,7 @@
 	struct bi_record *rec;
 	unsigned long initrd_loc = 0, TotalMemory = 0;
 
-#ifdef CONFIG_SERIAL_8250_CONSOLE
+#if defined(CONFIG_SERIAL_8250_CONSOLE) || defined(CONFIG_SERIAL_MPSC_CONSOLE)
 	com_port = serial_init(0, NULL);
 #endif
 
diff -Nru a/arch/ppc/boot/simple/mv64x60_tty.c b/arch/ppc/boot/simple/mv64x60_tty.c
--- a/arch/ppc/boot/simple/mv64x60_tty.c	2005-01-25 17:05:15 -07:00
+++ b/arch/ppc/boot/simple/mv64x60_tty.c	2005-01-25 17:05:15 -07:00
@@ -6,12 +6,10 @@
  *
  * Author: Mark A. Greer <mgreer@mvista.com>
  *
- * Copyright 2001 MontaVista Software Inc.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by the
- * Free Software Foundation; either version 2 of the License, or (at your
- * option) any later version.
+ * 2001 (c) MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
  */
 
 /* This code assumes that the data cache has been disabled (L1, L2, L3). */
diff -Nru a/arch/ppc/syslib/mv64360_pic.c b/arch/ppc/syslib/mv64360_pic.c
--- a/arch/ppc/syslib/mv64360_pic.c	2005-01-25 17:05:15 -07:00
+++ b/arch/ppc/syslib/mv64360_pic.c	2005-01-25 17:05:15 -07:00
@@ -369,7 +369,8 @@
 	u32	mask;
 	int	rc;
 
-	/* Register CPU interface error interrupt handler */
+	/* Clear old errors and register CPU interface error intr handler */
+	mv64x60_write(&bh, MV64x60_CPU_ERR_CAUSE, 0);
 	if ((rc = request_irq(MV64x60_IRQ_CPU_ERR,
 		mv64360_cpu_error_int_handler, SA_INTERRUPT, CPU_INTR_STR, 0)))
 		printk(KERN_WARNING "Can't register cpu error handler: %d", rc);
@@ -377,7 +378,8 @@
 	mv64x60_write(&bh, MV64x60_CPU_ERR_MASK, 0);
 	mv64x60_write(&bh, MV64x60_CPU_ERR_MASK, 0x000000ff);
 
-	/* Register internal SRAM error interrupt handler */
+	/* Clear old errors and register internal SRAM error intr handler */
+	mv64x60_write(&bh, MV64360_SRAM_ERR_CAUSE, 0);
 	if ((rc = request_irq(MV64360_IRQ_SRAM_PAR_ERR,
 		mv64360_sram_error_int_handler,SA_INTERRUPT,SRAM_INTR_STR, 0)))
 		printk(KERN_WARNING "Can't register SRAM error handler: %d",rc);
@@ -393,18 +395,20 @@
 		(mv64x60_get_bridge_rev() > 1))
 		mask |= 0x1;	/* enable DPErr on 64460 */
 
-	/* Register PCI 0 error interrupt handler */
+	/* Clear old errors and register PCI 0 error intr handler */
+	mv64x60_write(&bh, MV64x60_PCI0_ERR_CAUSE, 0);
 	if ((rc = request_irq(MV64360_IRQ_PCI0, mv64360_pci_error_int_handler,
-		    SA_INTERRUPT, PCI0_INTR_STR, (void *)0)))
+			SA_INTERRUPT, PCI0_INTR_STR, (void *)0)))
 		printk(KERN_WARNING "Can't register pci 0 error handler: %d",
 			rc);
 
 	mv64x60_write(&bh, MV64x60_PCI0_ERR_MASK, 0);
 	mv64x60_write(&bh, MV64x60_PCI0_ERR_MASK, mask);
 
-	/* Register PCI 1 error interrupt handler */
+	/* Clear old errors and register PCI 1 error intr handler */
+	mv64x60_write(&bh, MV64x60_PCI1_ERR_CAUSE, 0);
 	if ((rc = request_irq(MV64360_IRQ_PCI1, mv64360_pci_error_int_handler,
-		    SA_INTERRUPT, PCI1_INTR_STR, (void *)1)))
+			SA_INTERRUPT, PCI1_INTR_STR, (void *)1)))
 		printk(KERN_WARNING "Can't register pci 1 error handler: %d",
 			rc);
 
diff -Nru a/arch/ppc/syslib/mv64x60.c b/arch/ppc/syslib/mv64x60.c
--- a/arch/ppc/syslib/mv64x60.c	2005-01-25 17:05:15 -07:00
+++ b/arch/ppc/syslib/mv64x60.c	2005-01-25 17:05:15 -07:00
@@ -34,10 +34,10 @@
 u8		mv64x60_pci_exclude_bridge = 1;
 spinlock_t	mv64x60_lock; /* Only really used by PIC code once init done */
 
-static u32	mv64x60_bridge_pbase = 0;
-static u32	mv64x60_bridge_vbase = 0;
-static u32	mv64x60_bridge_type = MV64x60_TYPE_INVALID;
-static u32	mv64x60_bridge_rev = 0;
+static phys_addr_t 	mv64x60_bridge_pbase = 0;
+static void 		*mv64x60_bridge_vbase = 0;
+static u32		mv64x60_bridge_type = MV64x60_TYPE_INVALID;
+static u32		mv64x60_bridge_rev = 0;
 
 static u32 gt64260_translate_size(u32 base, u32 size, u32 num_bits);
 static u32 gt64260_untranslate_size(u32 base, u32 size, u32 num_bits);
@@ -88,7 +88,7 @@
 	.translate_size		= gt64260_translate_size,
 	.untranslate_size	= gt64260_untranslate_size,
 	.set_pci2mem_window	= gt64260_set_pci2mem_window,
-	.set_pci2regs_window    = gt64260_set_pci2regs_window,
+	.set_pci2regs_window	= gt64260_set_pci2regs_window,
 	.is_enabled_32bit	= gt64260_is_enabled_32bit,
 	.enable_window_32bit	= gt64260_enable_window_32bit,
 	.disable_window_32bit	= gt64260_disable_window_32bit,
@@ -104,7 +104,7 @@
 	.translate_size		= gt64260_translate_size,
 	.untranslate_size	= gt64260_untranslate_size,
 	.set_pci2mem_window	= gt64260_set_pci2mem_window,
-	.set_pci2regs_window    = gt64260_set_pci2regs_window,
+	.set_pci2regs_window	= gt64260_set_pci2regs_window,
 	.is_enabled_32bit	= gt64260_is_enabled_32bit,
 	.enable_window_32bit	= gt64260_enable_window_32bit,
 	.disable_window_32bit	= gt64260_disable_window_32bit,
@@ -120,7 +120,7 @@
 	.translate_size		= mv64360_translate_size,
 	.untranslate_size	= mv64360_untranslate_size,
 	.set_pci2mem_window	= mv64360_set_pci2mem_window,
-	.set_pci2regs_window    = mv64360_set_pci2regs_window,
+	.set_pci2regs_window	= mv64360_set_pci2regs_window,
 	.is_enabled_32bit	= mv64360_is_enabled_32bit,
 	.enable_window_32bit	= mv64360_enable_window_32bit,
 	.disable_window_32bit	= mv64360_disable_window_32bit,
@@ -138,7 +138,7 @@
 	.translate_size		= mv64360_translate_size,
 	.untranslate_size	= mv64360_untranslate_size,
 	.set_pci2mem_window	= mv64360_set_pci2mem_window,
-	.set_pci2regs_window    = mv64360_set_pci2regs_window,
+	.set_pci2regs_window	= mv64360_set_pci2regs_window,
 	.is_enabled_32bit	= mv64360_is_enabled_32bit,
 	.enable_window_32bit	= mv64360_enable_window_32bit,
 	.disable_window_32bit	= mv64360_disable_window_32bit,
@@ -160,7 +160,7 @@
  *****************************************************************************
  */
 #ifdef CONFIG_SERIAL_MPSC
-static struct mpsc_shared_pd_dd mv64x60_mpsc_shared_pd_dd = {
+static struct mpsc_shared_pdata mv64x60_mpsc_shared_pdata = {
 	.mrr_val		= 0x3ffffe38,
 	.rcrr_val		= 0,
 	.tcrr_val		= 0,
@@ -192,11 +192,11 @@
 	.num_resources	= ARRAY_SIZE(mv64x60_mpsc_shared_resources),
 	.resource	= mv64x60_mpsc_shared_resources,
 	.dev = {
-		.driver_data = &mv64x60_mpsc_shared_pd_dd,
+		.platform_data = &mv64x60_mpsc_shared_pdata,
 	},
 };
 
-static struct mpsc_pd_dd mv64x60_mpsc0_pd_dd = {
+static struct mpsc_pdata mv64x60_mpsc0_pdata = {
 	.mirror_regs		= 0,
 	.cache_mgmt		= 0,
 	.max_idle		= 0,
@@ -248,11 +248,11 @@
 	.num_resources	= ARRAY_SIZE(mv64x60_mpsc0_resources),
 	.resource	= mv64x60_mpsc0_resources,
 	.dev = {
-		.driver_data = &mv64x60_mpsc0_pd_dd,
+		.platform_data = &mv64x60_mpsc0_pdata,
 	},
 };
 
-static struct mpsc_pd_dd mv64x60_mpsc1_pd_dd = {
+static struct mpsc_pdata mv64x60_mpsc1_pdata = {
 	.mirror_regs		= 0,
 	.cache_mgmt		= 0,
 	.max_idle		= 0,
@@ -305,7 +305,130 @@
 	.num_resources	= ARRAY_SIZE(mv64x60_mpsc1_resources),
 	.resource	= mv64x60_mpsc1_resources,
 	.dev = {
-		.driver_data = &mv64x60_mpsc1_pd_dd,
+		.platform_data = &mv64x60_mpsc1_pdata,
+	},
+};
+#endif
+
+#ifdef CONFIG_MV643XX_ETH
+static struct resource mv64x60_eth_shared_resources[] = {
+	[0] = {
+		.name	= "ethernet shared base",
+		.start	= MV64340_ETH_SHARED_REGS,
+		.end	= MV64340_ETH_SHARED_REGS +
+					MV64340_ETH_SHARED_REGS_SIZE - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device mv64x60_eth_shared_device = {
+	.name		= MV64XXX_ETH_SHARED_NAME,
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(mv64x60_eth_shared_resources),
+	.resource	= mv64x60_eth_shared_resources,
+};
+
+#ifdef CONFIG_MV643XX_ETH_0
+static struct resource mv64x60_eth0_resources[] = {
+	[0] = {
+		.name	= "eth0 irq",
+		.start	= MV64x60_IRQ_ETH_0,
+		.end	= MV64x60_IRQ_ETH_0,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct mv64xxx_eth_platform_data eth0_pd;
+
+static struct platform_device eth0_device = {
+	.name		= MV64XXX_ETH_NAME,
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(mv64x60_eth0_resources),
+	.resource	= mv64x60_eth0_resources,
+	.dev = {
+		.platform_data = &eth0_pd,
+	},
+};
+#endif
+
+#ifdef CONFIG_MV643XX_ETH_1
+static struct resource mv64x60_eth1_resources[] = {
+	[0] = {
+		.name	= "eth1 irq",
+		.start	= MV64x60_IRQ_ETH_1,
+		.end	= MV64x60_IRQ_ETH_1,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct mv64xxx_eth_platform_data eth1_pd;
+
+static struct platform_device eth1_device = {
+	.name		= MV64XXX_ETH_NAME,
+	.id		= 1,
+	.num_resources	= ARRAY_SIZE(mv64x60_eth1_resources),
+	.resource	= mv64x60_eth1_resources,
+	.dev = {
+		.platform_data = &eth1_pd,
+	},
+};
+#endif
+
+#ifdef CONFIG_MV643XX_ETH_2
+static struct resource mv64x60_eth2_resources[] = {
+	[0] = {
+		.name	= "eth2 irq",
+		.start	= MV64x60_IRQ_ETH_2,
+		.end	= MV64x60_IRQ_ETH_2,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct mv64xxx_eth_platform_data eth2_pd;
+
+static struct platform_device eth2_device = {
+	.name		= MV64XXX_ETH_NAME,
+	.id		= 2,
+	.num_resources	= ARRAY_SIZE(mv64x60_eth2_resources),
+	.resource	= mv64x60_eth2_resources,
+	.dev = {
+		.platform_data = &eth2_pd,
+	},
+};
+#endif
+#endif
+
+#ifdef	CONFIG_I2C_MV64XXX
+static struct mv64xxx_i2c_pdata mv64xxx_i2c_pdata = {
+	.freq_m			= 8,
+	.freq_n			= 3,
+	.timeout		= 1000, /* Default timeout of 1 second */
+	.retries		= 1,
+};
+
+static struct resource mv64xxx_i2c_resources[] = {
+	/* Do not change the order of the IORESOURCE_MEM resources */
+	[0] = {
+		.name	= "mv64xxx i2c base",
+		.start	= MV64XXX_I2C_OFFSET,
+		.end	= MV64XXX_I2C_OFFSET + MV64XXX_I2C_REG_BLOCK_SIZE - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.name	= "mv64xxx i2c irq",
+		.start	= MV64x60_IRQ_I2C,
+		.end	= MV64x60_IRQ_I2C,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device i2c_device = {
+	.name		= MV64XXX_I2C_CTLR_NAME,
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(mv64xxx_i2c_resources),
+	.resource	= mv64xxx_i2c_resources,
+	.dev = {
+		.platform_data = &mv64xxx_i2c_pdata,
 	},
 };
 #endif
@@ -316,6 +439,21 @@
 	&mpsc0_device,
 	&mpsc1_device,
 #endif
+#ifdef CONFIG_MV643XX_ETH
+	&mv64x60_eth_shared_device,
+#endif
+#ifdef CONFIG_MV643XX_ETH_0
+	&eth0_device,
+#endif
+#ifdef CONFIG_MV643XX_ETH_1
+	&eth1_device,
+#endif
+#ifdef CONFIG_MV643XX_ETH_2
+	&eth2_device,
+#endif
+#ifdef	CONFIG_I2C_MV64XXX
+	&i2c_device,
+#endif
 };
 
 /*
@@ -344,7 +482,7 @@
 	mv64x60_early_init(bh, si);
 
 	if (mv64x60_get_type(bh) || mv64x60_setup_for_chip(bh)) {
-		iounmap((void *)bh->v_base);
+		iounmap(bh->v_base);
 		bh->v_base = 0;
 		if (ppc_md.progress)
 			ppc_md.progress("mv64x60_init: Can't determine chip",0);
@@ -416,7 +554,7 @@
 	memset(bh, 0, sizeof(*bh));
 
 	bh->p_base = si->phys_reg_base;
-	bh->v_base = (u32)ioremap(bh->p_base, MV64x60_INTERNAL_SPACE_SIZE);
+	bh->v_base = ioremap(bh->p_base, MV64x60_INTERNAL_SPACE_SIZE);
 
 	mv64x60_bridge_pbase = bh->p_base;
 	mv64x60_bridge_vbase = bh->v_base;
@@ -598,7 +736,7 @@
  */
 void __init
 mv64x60_set_64bit_window(struct mv64x60_handle *bh, u32 window,
-			u32 base_hi, u32 base_lo, u32 size, u32 other_bits)
+	u32 base_hi, u32 base_lo, u32 size, u32 other_bits)
 {
 	u32	val, base_lo_reg, size_reg, base_lo_bits, size_bits;
 	u32	(*map_to_field)(u32 val, u32 num_bits);
@@ -645,7 +783,7 @@
 }
 
 /*
- * mv64x60_mask_shift_left()
+ * mv64x60_shift_left()
  *
  * Take the low-order 'num_bits' of 'val', shift left to align at bit 31 (MSB).
  */
@@ -702,7 +840,7 @@
 	/* Get the revision of the chip */
 	early_read_config_word(&hose, 0, PCI_DEVFN(0, 0), PCI_CLASS_REVISION,
 		&val);
-	bh->rev = (u32) (val & 0xff);
+	bh->rev = (u32)(val & 0xff);
 
 	/* Figure out the type of Marvell bridge it is */
 	early_read_config_word(&hose, 0, PCI_DEVFN(0, 0), PCI_DEVICE_ID, &val);
@@ -790,7 +928,7 @@
  *
  * Return the virtual address of the bridge's registers.
  */
-u32
+void *
 mv64x60_get_bridge_vbase(void)
 {
 	return mv64x60_bridge_vbase;
@@ -836,13 +974,13 @@
 mv64x60_get_mem_size(u32 bridge_base, u32 chip_type)
 {
 	struct mv64x60_handle	bh;
-	u32			mem_windows[MV64x60_CPU2MEM_WINDOWS][2];
-	u32			rc = 0;
+	u32	mem_windows[MV64x60_CPU2MEM_WINDOWS][2];
+	u32	rc = 0;
 
 	memset(&bh, 0, sizeof(bh));
 
 	bh.type = chip_type;
-	bh.v_base = bridge_base;
+	bh.v_base = (void *)bridge_base;
 
 	if (!mv64x60_setup_for_chip(&bh)) {
 		mv64x60_get_mem_windows(&bh, mem_windows);
@@ -1117,7 +1255,7 @@
 			IORESOURCE_IO, s[hose->index][0]);
 		hose->io_space.start = pi->pci_io.pci_base_lo;
 		hose->io_space.end = pi->pci_io.pci_base_lo + pi->pci_io.size-1;
-		hose->io_base_phys = (ulong)pi->pci_io.cpu_base;
+		hose->io_base_phys = pi->pci_io.cpu_base;
 		hose->io_base_virt = (void *)isa_io_base;
 	}
 
@@ -1592,8 +1730,8 @@
 	struct resource	*r;
 #endif
 #if !defined(CONFIG_NOT_COHERENT_CACHE)
-	u32		val;
-	u8		save_exclude;
+	u32	val;
+	u8	save_exclude;
 #endif
 
 	if (si->pci_0.enable_bus)
@@ -1638,10 +1776,10 @@
 	mv64x60_clr_bits(bh, 0xf2c0, (1<< 6) | (1<<14) | (1<<22) | (1<<30));
 
 #ifdef CONFIG_SERIAL_MPSC
-	mv64x60_mpsc0_pd_dd.mirror_regs = 1;
-	mv64x60_mpsc0_pd_dd.cache_mgmt = 1;
-	mv64x60_mpsc1_pd_dd.mirror_regs = 1;
-	mv64x60_mpsc1_pd_dd.cache_mgmt = 1;
+	mv64x60_mpsc0_pdata.mirror_regs = 1;
+	mv64x60_mpsc0_pdata.cache_mgmt = 1;
+	mv64x60_mpsc1_pdata.mirror_regs = 1;
+	mv64x60_mpsc1_pdata.cache_mgmt = 1;
 
 	if ((r = platform_get_resource(&mpsc1_device, IORESOURCE_IRQ, 0))
 		!= NULL) {
@@ -1667,8 +1805,8 @@
 	struct resource	*r;
 #endif
 #if !defined(CONFIG_NOT_COHERENT_CACHE)
-	u32		val;
-	u8		save_exclude;
+	u32	val;
+	u8	save_exclude;
 #endif
 
 	if (si->pci_0.enable_bus)
@@ -1720,8 +1858,8 @@
 	 * can't access cache coherent regions.  However, testing has shown
 	 * that the MPSC, at least, still has this bug.
 	 */
-	mv64x60_mpsc0_pd_dd.cache_mgmt = 1;
-	mv64x60_mpsc1_pd_dd.cache_mgmt = 1;
+	mv64x60_mpsc0_pdata.cache_mgmt = 1;
+	mv64x60_mpsc1_pdata.cache_mgmt = 1;
 
 	if ((r = platform_get_resource(&mpsc1_device, IORESOURCE_IRQ, 0))
 		!= NULL) {
@@ -2228,10 +2366,10 @@
 	struct mv64x60_setup_info *si)
 {
 #ifdef CONFIG_SERIAL_MPSC
-	mv64x60_mpsc0_pd_dd.brg_can_tune = 1;
-	mv64x60_mpsc0_pd_dd.cache_mgmt = 1;
-	mv64x60_mpsc1_pd_dd.brg_can_tune = 1;
-	mv64x60_mpsc1_pd_dd.cache_mgmt = 1;
+	mv64x60_mpsc0_pdata.brg_can_tune = 1;
+	mv64x60_mpsc0_pdata.cache_mgmt = 1;
+	mv64x60_mpsc1_pdata.brg_can_tune = 1;
+	mv64x60_mpsc1_pdata.cache_mgmt = 1;
 #endif
 
 	return;
@@ -2247,8 +2385,8 @@
 	struct mv64x60_setup_info *si)
 {
 #ifdef CONFIG_SERIAL_MPSC
-	mv64x60_mpsc0_pd_dd.brg_can_tune = 1;
-	mv64x60_mpsc1_pd_dd.brg_can_tune = 1;
+	mv64x60_mpsc0_pdata.brg_can_tune = 1;
+	mv64x60_mpsc1_pdata.brg_can_tune = 1;
 #endif
 	return;
 }
diff -Nru a/include/asm-ppc/mv64x60.h b/include/asm-ppc/mv64x60.h
--- a/include/asm-ppc/mv64x60.h	2005-01-25 17:05:15 -07:00
+++ b/include/asm-ppc/mv64x60.h	2005-01-25 17:05:15 -07:00
@@ -27,7 +27,7 @@
 #include <asm/pci-bridge.h>
 #include <asm/mv64x60_defs.h>
 
-extern u8      mv64x60_pci_exclude_bridge;
+extern u8	mv64x60_pci_exclude_bridge;
 
 extern spinlock_t mv64x60_lock;
 
@@ -210,7 +210,7 @@
 	void	(*enable_window_64bit)(mv64x60_handle_t *bh, u32 window);
 	void	(*disable_window_64bit)(mv64x60_handle_t *bh, u32 window);
 	void	(*disable_all_windows)(mv64x60_handle_t *bh,
-		       struct mv64x60_setup_info *si);
+			struct mv64x60_setup_info *si);
 	void	(*config_io2mem_windows)(mv64x60_handle_t *bh,
 			struct mv64x60_setup_info *si,
 			u32 mem_windows[MV64x60_CPU2MEM_WINDOWS][2]);
@@ -223,16 +223,16 @@
 };
 
 struct mv64x60_handle {
-	u32	type;		/* type of bridge */
-	u32	rev;		/* revision of bridge */
-	u32	v_base;		/* virtual base addr of bridge regs */
-	u32	p_base;		/* physical base addr of bridge regs */
+	u32		type;		/* type of bridge */
+	u32		rev;		/* revision of bridge */
+	void		*v_base;	/* virtual base addr of bridge regs */
+	phys_addr_t	p_base;		/* physical base addr of bridge regs */
 
-	u32	pci_mode_a;	/* pci bus 0 mode: conventional pci, pci-x */
-	u32	pci_mode_b;	/* pci bus 1 mode: conventional pci, pci-x */
+	u32		pci_mode_a;	/* pci 0 mode: conventional pci, pci-x*/
+	u32		pci_mode_b;	/* pci 1 mode: conventional pci, pci-x*/
 
-	u32	io_base_a;	/* vaddr of pci 0's I/O space */
-	u32	io_base_b;	/* vaddr of pci 1's I/O space */
+	u32		io_base_a;	/* vaddr of pci 0's I/O space */
+	u32		io_base_b;	/* vaddr of pci 1's I/O space */
 
 	struct pci_controller	*hose_a;
 	struct pci_controller	*hose_b;
@@ -247,7 +247,7 @@
 	ulong	flags;
 
 	spin_lock_irqsave(&mv64x60_lock, flags);
-	out_le32((volatile u32 *)(bh->v_base + offset), val);
+	out_le32(bh->v_base + offset, val);
 	spin_unlock_irqrestore(&mv64x60_lock, flags);
 }
 
@@ -256,7 +256,7 @@
 	ulong	flags;
 
 	spin_lock_irqsave(&mv64x60_lock, flags);
-	return in_le32((volatile u32 *)(bh->v_base + offset));
+	return in_le32(bh->v_base + offset);
 	spin_unlock_irqrestore(&mv64x60_lock, flags);
 }
 
@@ -282,11 +282,11 @@
 u32 mv64x60_get_mem_size(u32 bridge_base, u32 chip_type);
 void mv64x60_early_init(struct mv64x60_handle *bh,
 	struct mv64x60_setup_info *si);
-void mv64x60_alloc_hose(struct mv64x60_handle *bh, u32 cfg_addr, u32 cfg_data,
-	struct pci_controller **hose);
+void mv64x60_alloc_hose(struct mv64x60_handle *bh, u32 cfg_addr,
+	u32 cfg_data, struct pci_controller **hose);
 int mv64x60_get_type(struct mv64x60_handle *bh);
 int mv64x60_setup_for_chip(struct mv64x60_handle *bh);
-u32 mv64x60_get_bridge_vbase(void);
+void *mv64x60_get_bridge_vbase(void);
 u32 mv64x60_get_bridge_type(void);
 u32 mv64x60_get_bridge_rev(void);
 void mv64x60_get_mem_windows(struct mv64x60_handle *bh,
diff -Nru a/include/asm-ppc/mv64x60_defs.h b/include/asm-ppc/mv64x60_defs.h
--- a/include/asm-ppc/mv64x60_defs.h	2005-01-25 17:05:15 -07:00
+++ b/include/asm-ppc/mv64x60_defs.h	2005-01-25 17:05:15 -07:00
@@ -216,9 +216,9 @@
 #define MV64360_CPU1_SYNC_BARRIER_VIRT		0x00d8
 
 /* CPU Deadlock and Ordering registers (Rev B part only) */
-#define GT64260_CPU_DEADLOCK_ORDERING                   0x02d0
-#define GT64260_CPU_WB_PRIORITY_BUFFER_DEPTH            0x02d8
-#define GT64260_CPU_COUNTERS_SYNC_BARRIER_ATTRIBUTE     0x02e0
+#define GT64260_CPU_DEADLOCK_ORDERING			0x02d0
+#define GT64260_CPU_WB_PRIORITY_BUFFER_DEPTH		0x02d8
+#define GT64260_CPU_COUNTERS_SYNC_BARRIER_ATTRIBUTE	0x02e0
 
 /* CPU Access Protection Registers (gt64260 realy has 8 but don't need) */
 #define	MV64x260_CPU_PROT_WINDOWS		4
diff -Nru a/include/linux/mv643xx.h b/include/linux/mv643xx.h
--- a/include/linux/mv643xx.h	2005-01-25 17:05:15 -07:00
+++ b/include/linux/mv643xx.h	2005-01-25 17:05:15 -07:00
@@ -1048,7 +1048,7 @@
 #define MPSC_ROUTING_REG_BLOCK_SIZE	0x000c
 #define MPSC_SDMA_INTR_REG_BLOCK_SIZE	0x0084
 
-struct mpsc_shared_pd_dd {
+struct mpsc_shared_pdata {
 	u32	mrr_val;
 	u32	rcrr_val;
 	u32	tcrr_val;
@@ -1067,7 +1067,7 @@
 #define MPSC_SDMA_REG_BLOCK_SIZE	0x0c18
 #define MPSC_BRG_REG_BLOCK_SIZE		0x0008
 
-struct mpsc_pd_dd {
+struct mpsc_pdata {
 	u8	mirror_regs;
 	u8	cache_mgmt;
 	u8	max_idle;

--------------050200070608020603020505--
