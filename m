Subject: Re: 2.6 kernel on Sandpoint
From: Adrian Cox <adrian@humboldt.co.uk>
To: Dan Malek <dan@embeddededge.com>
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <1079112788.691.64.camel@newt>
References: <1079084120.691.16.camel@newt>
	 <4051D5EF.7040709@embeddededge.com>  <1079112788.691.64.camel@newt>
Content-Type: text/plain
Message-Id: <1079114375.691.68.camel@newt>
Mime-Version: 1.0
Date: Fri, 12 Mar 2004 17:59:35 +0000
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, 2004-03-12 at 17:33, Adrian Cox wrote:
> I'm just checking whether my patch works on the current
> linuxppc_2_4_devel Bitkeeper. It should follow soon.

See below for my Linux 2.4 on Sandpoint X2 patch.

The patch disables the RTC, which doesn't work on my X2. I'd like to
know if this is just a problem with mine, or whether it applies to yours
as well.

- Adrian Cox

diff -Nru a/arch/ppc/config.in b/arch/ppc/config.in
--- a/arch/ppc/config.in	Fri Mar 12 17:57:08 2004
+++ b/arch/ppc/config.in	Fri Mar 12 17:57:08 2004
@@ -211,6 +211,10 @@
   define_bool CONFIG_GEN550 y
 fi

+if [ "$CONFIG_SANDPOINT" = "y" ]; then
+  bool 'Run on older Sandpoint X2' CONFIG_SANDPOINT_X2
+fi
+
 if [ "$CONFIG_FORCE" = "y" -o "$CONFIG_SANDPOINT" = "y" ]; then
   bool 'Enable MPC10x store gathering' CONFIG_MPC10X_STORE_GATHERING
 fi
@@ -260,7 +264,9 @@
 fi

 if [ "$CONFIG_SANDPOINT" = "y" ]; then
-  define_bool CONFIG_EPIC_SERIAL_MODE y
+  if [ "$CONFIG_SANDPOINT_X2" = "n" ]; then
+    define_bool CONFIG_EPIC_SERIAL_MODE y
+  fi
   define_bool CONFIG_GEN550 y
 fi

diff -Nru a/arch/ppc/platforms/sandpoint.h b/arch/ppc/platforms/sandpoint.h
--- a/arch/ppc/platforms/sandpoint.h	Fri Mar 12 17:57:08 2004
+++ b/arch/ppc/platforms/sandpoint.h	Fri Mar 12 17:57:08 2004
@@ -35,6 +35,12 @@
 #define SANDPOINT_IDE_INT1	15	/* 8259 Test */
 #endif

+#ifdef CONFIG_SANDPOINT_X2
+#define SANDPOINT_CASCADE 17
+#else
+#define SANDPOINT_CASCADE 16
+#endif
+
 /*
  * The sandpoint boards have processor modules that either have an 8240 or
  * an MPC107 host bridge on them.  These bridges have an IDSEL line that allows
diff -Nru a/arch/ppc/platforms/sandpoint_pci.c b/arch/ppc/platforms/sandpoint_pci.c
--- a/arch/ppc/platforms/sandpoint_pci.c	Fri Mar 12 17:57:08 2004
+++ b/arch/ppc/platforms/sandpoint_pci.c	Fri Mar 12 17:57:08 2004
@@ -40,12 +40,21 @@
 	 * 	   A   B   C   D
 	 */
 	{
+#ifdef CONFIG_SANDPOINT_X2
+		{ 18,  0,  0,  0 },	/* IDSEL 11 - i8259 on Windbond */
+		{  0,  0,  0,  0 },	/* IDSEL 12 - unused */
+		{ 16, 17, 18, 19 },     /* IDSEL 13 - PCI slot 1 */
+		{ 17, 18, 19, 16 },     /* IDSEL 14 - PCI slot 2 */
+		{ 18, 19, 16, 17 },     /* IDSEL 15 - PCI slot 3 */
+		{ 19, 16, 17, 18 },     /* IDSEL 16 - PCI slot 4 */
+#else
 		{ 16,  0,  0,  0 },	/* IDSEL 11 - i8259 on Windbond */
 		{  0,  0,  0,  0 },	/* IDSEL 12 - unused */
 		{ 17, 18, 19, 20 },     /* IDSEL 13 - PCI slot 1 */
 		{ 18, 19, 20, 17 },     /* IDSEL 14 - PCI slot 2 */
 		{ 19, 20, 17, 18 },     /* IDSEL 15 - PCI slot 3 */
 		{ 20, 17, 18, 19 },     /* IDSEL 16 - PCI slot 4 */
+#endif
 	};

 	const long min_idsel = 11, max_idsel = 16, irqs_per_slot = 4;
@@ -119,6 +128,20 @@
 	return;
 }

+#ifdef CONFIG_SANDPOINT_X2
+/* On the sandpoint X2, we must avoid sending configuration cycles to
+ * device #12 (IDSEL addr = AD12).
+ */
+static int
+sandpoint_exclude_device(u_char bus, u_char devfn)
+{
+       if ((bus == 0) && (PCI_SLOT(devfn) == SANDPOINT_HOST_BRIDGE_IDSEL))
+               return PCIBIOS_DEVICE_NOT_FOUND;
+       else
+               return PCIBIOS_SUCCESSFUL;
+}
+#endif
+
 void __init
 sandpoint_find_bridges(void)
 {
@@ -139,6 +162,9 @@

 		/* Do early winbond init, then scan PCI bus */
 		sandpoint_setup_winbond_83553(hose);
+#ifdef CONFIG_SANDPOINT_X2
+                ppc_md.pci_exclude_device = sandpoint_exclude_device;
+#endif
 		hose->last_busno = pciauto_bus_scan(hose, hose->first_busno);

 		ppc_md.pcibios_fixup = NULL;
diff -Nru a/arch/ppc/platforms/sandpoint_setup.c b/arch/ppc/platforms/sandpoint_setup.c
--- a/arch/ppc/platforms/sandpoint_setup.c	Fri Mar 12 17:57:08 2004
+++ b/arch/ppc/platforms/sandpoint_setup.c	Fri Mar 12 17:57:08 2004
@@ -324,7 +324,14 @@
 	 * Interrupt Source Configuration Registers gives these numbers
 	 * as offsets starting at 0x50200, we need to adjust occordinly.
 	 */
-
+#ifdef CONFIG_SANDPOINT_X2
+        /* Map EPIC IRQs 0-3 */
+        openpic_set_sources(0, 4, OpenPIC_Addr + 0x10200);
+        /* Skip reserved space and map i2c and DMA Ch[01] */
+        openpic_set_sources(4, 3, OpenPIC_Addr + 0x11020);
+        /* Skip reserved space and map Message Unit Interrupt (I2O) */
+        openpic_set_sources(7, 1, OpenPIC_Addr + 0x110C0);
+#else
 	/* Map serial interrupt 0 */
 	openpic_set_sources(0, 1, OpenPIC_Addr + 0x10200);
 	/* Map serial interrupts 2-5 */
@@ -335,12 +342,14 @@
 	openpic_set_sources(7, 3, OpenPIC_Addr + 0x11020);
 	/* Skip reserved space and map Message Unit Interrupt (I2O) */
 	openpic_set_sources(10, 1, OpenPIC_Addr + 0x110C0);
+#endif

 	openpic_init(NUM_8259_INTERRUPTS);
 	/* The cascade is on EPIC IRQ 0 (Linux IRQ 16). */
-	openpic_hookup_cascade(16, "8259 cascade to EPIC",
+	openpic_hookup_cascade(SANDPOINT_CASCADE, "8259 cascade to EPIC",
 			&i8259_irq);

+	if (ppc_md.progress) ppc_md.progress("done cascade", 0x122);
 	/*
 	 * openpic_init() has set up irq_desc[0-23] to be openpic
 	 * interrupts.  We need to set irq_desc[0-15] to be 8259 interrupts.
@@ -532,6 +541,33 @@
 			: "=r" (bat3u), "=r" (bat3l));
 }

+#ifdef CONFIG_SANDPOINT_X2
+static int sandpointx2_set_rtc_time(unsigned long nowtime)
+{
+    	return -1;
+}
+
+static unsigned long sandpointx2_get_rtc_time(void)
+{
+        /* We must randomise the initial time, so that the NFS client
+	   can produce a random XID. This can lead to the clock going back
+	   between boots, but anybody who needs a reliable clock should
+	   get time from the host.  The code copies the bus clock counter into
+	   minutes and seconds, on the assumption that whatever process booted
+	   the board does not take a repeatable time at that scale. */
+	unsigned long tbl = get_tbl();
+    	return mktime(2001, 1, 1, 12, (tbl & 0x3e0) >> 5, tbl & 0x1f);
+}
+
+static void __init sandpointx2_calibrate_decr(void)
+{
+	unsigned freq = 16666600;
+
+	printk("time_init: decrementer frequency = %d\n", freq);
+    	tb_ticks_per_jiffy = freq / HZ;
+    	tb_to_us = mulhwu_scale_factor(freq, 1000000);
+}
+#endif
 TODC_ALLOC();

 void __init
@@ -589,13 +625,17 @@

 	ppc_md.find_end_of_memory = sandpoint_find_end_of_memory;
 	ppc_md.setup_io_mappings = sandpoint_map_io;
-
+#ifdef CONFIG_SANDPOINT_X2
+ 	ppc_md.set_rtc_time = sandpointx2_set_rtc_time;
+	ppc_md.get_rtc_time = sandpointx2_get_rtc_time;
+	ppc_md.calibrate_decr = sandpointx2_calibrate_decr;
+#else
 	TODC_INIT(TODC_TYPE_PC97307, 0x70, 0x00, 0x71, 8);
 	ppc_md.time_init = todc_time_init;
 	ppc_md.set_rtc_time = todc_set_rtc_time;
 	ppc_md.get_rtc_time = todc_get_rtc_time;
 	ppc_md.calibrate_decr = todc_calibrate_decr;
-
+#endif
 	ppc_md.nvram_read_val = todc_mc146818_read_val;
 	ppc_md.nvram_write_val = todc_mc146818_write_val;


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
