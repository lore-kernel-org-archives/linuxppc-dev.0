Subject: [PATCH] sandpoint X2 in linuxppc_2_5
From: Adrian Cox <adrian@humboldt.co.uk>
To: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <1079446844.1677.250.camel@newt>
References: <1079446844.1677.250.camel@newt>
Content-Type: text/plain
Message-Id: <1079448047.1677.253.camel@newt>
Mime-Version: 1.0
Date: Tue, 16 Mar 2004 14:40:47 +0000
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, 2004-03-16 at 14:20, Adrian Cox wrote:
> This patch ports the openpic_hookup_cascade() function from 2_4_devel,
> as it is necessary for the Sandpoint X2. In doing this I have to change
> almost every user of openpic_init.

And here is the X2 patch. My earlier problems with serial interrupts
were solved by putting those i8259 irqs into edge mode.

- Adrian Cox

===== arch/ppc/Kconfig 1.63 vs edited =====
--- 1.63/arch/ppc/Kconfig	Fri Mar 12 20:23:17 2004
+++ edited/arch/ppc/Kconfig	Tue Mar 16 13:54:05 2004
@@ -622,9 +622,22 @@
 	depends on EV64260
 	default y

+config SANDPOINT_X2
+        bool "Run on X2 Sandpoint"
+        depends on SANDPOINT
+        default n
+        ---help---
+          This switches the Sandpoint platform to support the older X2
+          revision. The X2 has only two usable PCI slots and a more
+          restricted interrupt layout.
+
+          If you select this option the kernel will not run on later
+          revisions of the Sandpoint.
+
+
 config EPIC_SERIAL_MODE
 	bool
-	depends on 6xx && (LOPEC || SANDPOINT)
+	depends on 6xx && (LOPEC || SANDPOINT) && ! SANDPOINT_X2
 	default y

 config MPC10X_STORE_GATHERING
===== arch/ppc/platforms/sandpoint.c 1.23 vs edited =====
--- 1.23/arch/ppc/platforms/sandpoint.c	Tue Mar 16 14:08:56 2004
+++ edited/arch/ppc/platforms/sandpoint.c	Tue Mar 16 14:19:35 2004
@@ -61,10 +61,6 @@
  * what version of DINK initializes the system for us, if applicable, is
  * found, we can hopefully stop hardcoding 32MB of RAM.
  *
- * It is important to note that this code only supports the Sandpoint X3
- * (all flavors) platform, and it does not support the X2 anymore.  Code
- * that at one time worked on the X2 can be found at:
- * ftp://source.mvista.com/pub/linuxppc/obsolete/sandpoint/
  */

 #include <linux/config.h>
@@ -137,18 +133,41 @@
 	 * 	   A   B   C   D
 	 */
 	{
+#ifdef CONFIG_SANDPOINT_X2
+                { 18,  0,  0,  0 },     /* IDSEL 11 - i8259 on Windbond */
+                {  0,  0,  0,  0 },     /* IDSEL 12 - unused */
+                { 16, 17, 18, 19 },     /* IDSEL 13 - PCI slot 1 */
+                { 17, 18, 19, 16 },     /* IDSEL 14 - PCI slot 2 */
+                { 18, 19, 16, 17 },     /* IDSEL 15 - PCI slot 3 */
+                { 19, 16, 17, 18 },     /* IDSEL 16 - PCI slot 4 */
+#else
 		{ 16,  0,  0,  0 },	/* IDSEL 11 - i8259 on Winbond */
 		{  0,  0,  0,  0 },	/* IDSEL 12 - unused */
 		{ 18, 21, 20, 19 },	/* IDSEL 13 - PCI slot 1 */
 		{ 19, 18, 21, 20 },	/* IDSEL 14 - PCI slot 2 */
 		{ 20, 19, 18, 21 },	/* IDSEL 15 - PCI slot 3 */
 		{ 21, 20, 19, 18 },	/* IDSEL 16 - PCI slot 4 */
+#endif
 	};

 	const long min_idsel = 11, max_idsel = 16, irqs_per_slot = 4;
 	return PCI_IRQ_TABLE_LOOKUP;
 }

+#ifdef CONFIG_SANDPOINT_X2
+/* On the sandpoint X2, we must avoid sending configuration cycles to
+ * device #12 (IDSEL addr = AD12).
+ */
+static int
+sandpoint_exclude_device(u_char bus, u_char devfn)
+{
+        if ((bus == 0) && (PCI_SLOT(devfn) == SANDPOINT_HOST_BRIDGE_IDSEL))
+               return PCIBIOS_DEVICE_NOT_FOUND;
+        else
+               return PCIBIOS_SUCCESSFUL;
+}
+#endif
+
 static void __init
 sandpoint_setup_winbond_83553(struct pci_controller *hose)
 {
@@ -236,6 +255,9 @@

 		/* Do early winbond init, then scan PCI bus */
 		sandpoint_setup_winbond_83553(hose);
+#ifdef CONFIG_SANDPOINT_X2
+                ppc_md.pci_exclude_device = sandpoint_exclude_device;
+#endif
 		hose->last_busno = pciauto_bus_scan(hose, hose->first_busno);

 		ppc_md.pcibios_fixup = NULL;
@@ -361,7 +383,7 @@
 sandpoint_fix_winbond_83553(void)
 {
 	/* Make all 8259 interrupt level sensitive */
-	outb(0xf8, 0x4d0);
+	outb(0xe0, 0x4d0);
 	outb(0xde, 0x4d1);

 	return 0;
@@ -440,11 +462,19 @@
 	 * Interrupt Source Configuration Registers gives these numbers
 	 * as offsets starting at 0x50200, we need to adjust occordinly.
 	 */
+#ifdef CONFIG_SANDPOINT_X2
+        /* Map EPIC IRQs 0-3 */
+        openpic_set_sources(0, 4, OpenPIC_Addr + 0x10200);
+        /* Skip reserved space and map i2c and DMA Ch[01] */
+        openpic_set_sources(4, 3, OpenPIC_Addr + 0x11020);
+        /* Skip reserved space and map Message Unit Interrupt (I2O) */
+        openpic_set_sources(7, 1, OpenPIC_Addr + 0x110C0);
+#else
 	/* Map serial interrupts 0-15 */
 	openpic_set_sources(0, 16, OpenPIC_Addr + 0x10200);
-
+#endif
 	openpic_init(NUM_8259_INTERRUPTS);
-        openpic_hookup_cascade(NUM_8259_INTERRUPTS, "82c59 cascade", &i8259_irq);
+	openpic_hookup_cascade(SANDPOINT_CASCADE, "8259 cascade", &i8259_irq);

 	/*
 	 * openpic_init() has set up irq_desc[16-31] to be openpic
@@ -636,7 +666,16 @@
 			sync "
 			: "=r" (bat3u), "=r" (bat3l));
 }
+#ifdef CONFIG_SANDPOINT_X2
+static void __init sandpointx2_calibrate_decr(void)
+{
+	unsigned freq = 16666600;

+	printk("time_init: decrementer frequency = %d\n", freq);
+    	tb_ticks_per_jiffy = freq / HZ;
+    	tb_to_us = mulhwu_scale_factor(freq, 1000000);
+}
+#endif
 TODC_ALLOC();

 void __init
@@ -693,6 +732,9 @@
 	ppc_md.find_end_of_memory = sandpoint_find_end_of_memory;
 	ppc_md.setup_io_mappings = sandpoint_map_io;

+#ifdef CONFIG_SANDPOINT_X2
+	ppc_md.calibrate_decr = sandpointx2_calibrate_decr;
+#else
 	TODC_INIT(TODC_TYPE_PC97307, 0x70, 0x00, 0x71, 8);
 	ppc_md.time_init = todc_time_init;
 	ppc_md.set_rtc_time = todc_set_rtc_time;
@@ -701,6 +743,7 @@

 	ppc_md.nvram_read_val = todc_mc146818_read_val;
 	ppc_md.nvram_write_val = todc_mc146818_write_val;
+#endif

 #if defined(CONFIG_SERIAL_8250) && \
 	(defined(CONFIG_KGDB) || defined(CONFIG_SERIAL_TEXT_DEBUG))
===== arch/ppc/platforms/sandpoint.h 1.7 vs edited =====
--- 1.7/arch/ppc/platforms/sandpoint.h	Fri Sep 12 18:39:40 2003
+++ edited/arch/ppc/platforms/sandpoint.h	Tue Mar 16 14:10:11 2004
@@ -35,6 +35,16 @@
 #define SANDPOINT_IDE_INT1		15	/* 8259 Test */
 #endif

+/* The Sandpoint X3 runs the epic in serial mode, with the i8259 cascade
+ * on IRQ 0. The X2 runs in parallel mode with the cascade on IRQ 1, shared
+ * with a PCI slot. */
+
+#ifdef CONFIG_SANDPOINT_X2
+#define SANDPOINT_CASCADE 17
+#else
+#define SANDPOINT_CASCADE 16
+#endif
+
 /*
  * The sandpoint boards have processor modules that either have an 8240 or
  * an MPC107 host bridge on them.  These bridges have an IDSEL line that allows


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
