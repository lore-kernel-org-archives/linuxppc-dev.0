Date: Tue, 3 Aug 2004 13:20:38 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: linuxppc-dev@lists.linuxppc.org
Subject: [PATCH] Default to conswitchp=&dummy_con on DUMMY_CONSOLE
Message-ID: <20040803202038.GF9235@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


The following has arch/ppc/kernel/setup.c::setup_arch() set conswitchp
to &dummy_con, just prior to calling ppc_md.setup_arch().  The rational
here is that whenever DUMMY_CONSOLE=y we must do this, and we weren't
always getting this correct before, nor were we always doing it (which
is the cause of at least 1 8xx crash I've seen reported).  Comments?
I'll send this off to Linus post 2.6.8 otherwise (along with some 8xx
changes from Andreas Oberritter <obi@saftware.de> and possibly other
bits.

 arch/ppc/amiga/config.c                      |    3 ---
 arch/ppc/kernel/setup.c                      |    4 ++++
 arch/ppc/platforms/4xx/ocotea.c              |    4 ----
 arch/ppc/platforms/85xx/mpc8540_ads.c        |    4 ----
 arch/ppc/platforms/85xx/mpc85xx_cds_common.c |    4 ----
 arch/ppc/platforms/85xx/sbc8560.c            |    3 ---
 arch/ppc/platforms/chrp_setup.c              |    7 -------
 arch/ppc/platforms/k2.c                      |    4 ----
 arch/ppc/platforms/lopec_setup.c             |    3 ---
 arch/ppc/platforms/mcpn765.c                 |    4 ----
 arch/ppc/platforms/mvme5100_setup.c          |    4 ----
 arch/ppc/platforms/pcore.c                   |    4 ----
 arch/ppc/platforms/pmac_setup.c              |    3 ---
 arch/ppc/platforms/pplus.c                   |    2 --
 arch/ppc/platforms/prep_setup.c              |    2 --
 arch/ppc/platforms/prpmc750.c                |    4 ----
 arch/ppc/platforms/prpmc800.c                |    4 ----
 arch/ppc/platforms/sandpoint.c               |    4 ----
 arch/ppc/platforms/spruce.c                  |    5 -----
 arch/ppc/syslib/ppc4xx_setup.c               |    4 ----
 20 files changed, 4 insertions(+), 72 deletions(-)
--- a/arch/ppc/amiga/config.c	2004-08-03 13:19:48 -07:00
+++ b/arch/ppc/amiga/config.c	2004-08-03 13:19:48 -07:00
@@ -423,9 +423,6 @@
   mach_floppy_setup    = amiga_floppy_setup;
 #endif
   mach_reset           = amiga_reset;
-#ifdef CONFIG_DUMMY_CONSOLE
-  conswitchp           = &dummy_con;
-#endif
 #ifdef CONFIG_HEARTBEAT
   mach_heartbeat = amiga_heartbeat;
 #endif
--- a/arch/ppc/kernel/setup.c	2004-08-03 13:19:48 -07:00
+++ b/arch/ppc/kernel/setup.c	2004-08-03 13:19:48 -07:00
@@ -744,6 +744,10 @@
 	if ( ppc_md.progress ) ppc_md.progress("ocp: exit", 0x3eab);
 #endif

+#ifdef CONFIG_DUMMY_CONSOLE
+	conswitchp = &dummy_con;
+#endif
+
 	ppc_md.setup_arch();
 	if ( ppc_md.progress ) ppc_md.progress("arch: exit", 0x3eab);

--- a/arch/ppc/platforms/4xx/ocotea.c	2004-08-03 13:19:48 -07:00
+++ b/arch/ppc/platforms/4xx/ocotea.c	2004-08-03 13:19:48 -07:00
@@ -319,10 +319,6 @@
 		ROOT_DEV = Root_HDA1;
 #endif

-#ifdef CONFIG_DUMMY_CONSOLE
-	conswitchp = &dummy_con;
-#endif
-
 	ocotea_early_serial_map(&clocks);

 	/* Identify the system */
--- a/arch/ppc/platforms/85xx/mpc8540_ads.c	2004-08-03 13:19:48 -07:00
+++ b/arch/ppc/platforms/85xx/mpc8540_ads.c	2004-08-03 13:19:48 -07:00
@@ -120,10 +120,6 @@
 	mpc85xx_setup_hose();
 #endif

-#ifdef CONFIG_DUMMY_CONSOLE
-	conswitchp = &dummy_con;
-#endif
-
 #ifdef CONFIG_SERIAL_8250
 	mpc85xx_early_serial_map();
 #endif
--- a/arch/ppc/platforms/85xx/mpc85xx_cds_common.c	2004-08-03 13:19:48 -07:00
+++ b/arch/ppc/platforms/85xx/mpc85xx_cds_common.c	2004-08-03 13:19:48 -07:00
@@ -358,10 +358,6 @@
         mpc85xx_setup_hose();
 #endif

-#ifdef CONFIG_DUMMY_CONSOLE
-        conswitchp = &dummy_con;
-#endif
-
 #ifdef CONFIG_SERIAL_8250
         mpc85xx_early_serial_map();
 #endif
--- a/arch/ppc/platforms/85xx/sbc8560.c	2004-08-03 13:19:48 -07:00
+++ b/arch/ppc/platforms/85xx/sbc8560.c	2004-08-03 13:19:48 -07:00
@@ -144,9 +144,6 @@
 	/* setup PCI host bridges */
 	mpc85xx_setup_hose();
 #endif
-#ifdef CONFIG_DUMMY_CONSOLE
-	conswitchp = &dummy_con;
-#endif
 #ifdef CONFIG_SERIAL_8250
 	sbc8560_early_serial_map();
 #endif
--- a/arch/ppc/platforms/chrp_setup.c	2004-08-03 13:19:48 -07:00
+++ b/arch/ppc/platforms/chrp_setup.c	2004-08-03 13:19:48 -07:00
@@ -250,13 +250,6 @@
 	 */
 	sio_init();

-	/*
-	 *  Setup the console operations
-	 */
-#ifdef CONFIG_DUMMY_CONSOLE
-	conswitchp = &dummy_con;
-#endif
-
 	/* Get the event scan rate for the rtas so we know how
 	 * often it expects a heartbeat. -- Cort
 	 */
--- a/arch/ppc/platforms/k2.c	2004-08-03 13:19:48 -07:00
+++ b/arch/ppc/platforms/k2.c	2004-08-03 13:19:48 -07:00
@@ -464,10 +464,6 @@
 		ROOT_DEV = Root_HDC1;
 #endif

-#ifdef CONFIG_DUMMY_CONSOLE
-	conswitchp = &dummy_con;
-#endif
-
 	/* Identify the system */
 	printk(KERN_INFO "System Identification: SBS K2 - PowerPC 750 @ "
 			"%d Mhz\n", k2_get_cpu_speed() / 1000000);
--- a/arch/ppc/platforms/lopec_setup.c	2004-08-03 13:19:48 -07:00
+++ b/arch/ppc/platforms/lopec_setup.c	2004-08-03 13:19:48 -07:00
@@ -313,9 +313,6 @@
         	ROOT_DEV = Root_SDA1;
 #endif

-#ifdef CONFIG_VT
-	conswitchp = &dummy_con;
-#endif
 #ifdef CONFIG_PPCBUG_NVRAM
 	/* Read in NVRAM data */
 	init_prep_nvram();
--- a/arch/ppc/platforms/mcpn765.c	2004-08-03 13:19:48 -07:00
+++ b/arch/ppc/platforms/mcpn765.c	2004-08-03 13:19:48 -07:00
@@ -324,10 +324,6 @@
 		ROOT_DEV = Root_SDA2;
 #endif

-#ifdef CONFIG_DUMMY_CONSOLE
-	conswitchp = &dummy_con;
-#endif
-
 	if ( ppc_md.progress )
 		ppc_md.progress("mcpn765_setup_arch: find_bridges", 0);

--- a/arch/ppc/platforms/mvme5100_setup.c	2004-08-03 13:19:48 -07:00
+++ b/arch/ppc/platforms/mvme5100_setup.c	2004-08-03 13:19:48 -07:00
@@ -85,10 +85,6 @@
 		ROOT_DEV = Root_SDA2;
 #endif

-#ifdef CONFIG_DUMMY_CONSOLE
-	conswitchp = &dummy_con;
-#endif
-
 	if ( ppc_md.progress )
 		ppc_md.progress("mvme5100_setup_arch: find_bridges", 0);

--- a/arch/ppc/platforms/pcore.c	2004-08-03 13:19:48 -07:00
+++ b/arch/ppc/platforms/pcore.c	2004-08-03 13:19:48 -07:00
@@ -228,10 +228,6 @@
 		ROOT_DEV = Root_SDA2;
 #endif

-#ifdef CONFIG_DUMMY_CONSOLE
-	conswitchp = &dummy_con;
-#endif
-
  	printk(KERN_INFO "Force PowerCore ");
 	if (board_type == PCORE_TYPE_6750)
 		printk("6750\n");
--- a/arch/ppc/platforms/pmac_setup.c	2004-08-03 13:19:48 -07:00
+++ b/arch/ppc/platforms/pmac_setup.c	2004-08-03 13:19:48 -07:00
@@ -318,9 +318,6 @@
 #ifdef CONFIG_NVRAM
 	pmac_nvram_init();
 #endif
-#ifdef CONFIG_DUMMY_CONSOLE
-	conswitchp = &dummy_con;
-#endif
 #ifdef CONFIG_BLK_DEV_INITRD
 	if (initrd_start)
 		ROOT_DEV = Root_RAM0;
--- a/arch/ppc/platforms/pplus.c	2004-08-03 13:19:48 -07:00
+++ b/arch/ppc/platforms/pplus.c	2004-08-03 13:19:48 -07:00
@@ -583,8 +583,6 @@
 	vgacon_remap_base = (unsigned long)ioremap(PPLUS_ISA_MEM_BASE,
 						   0x08000000);
 	conswitchp = &vga_con;
-#elif defined(CONFIG_DUMMY_CONSOLE)
-	conswitchp = &dummy_con;
 #endif
 #ifdef CONFIG_PPCBUG_NVRAM
 	/* Read in NVRAM data */
--- a/arch/ppc/platforms/prep_setup.c	2004-08-03 13:19:48 -07:00
+++ b/arch/ppc/platforms/prep_setup.c	2004-08-03 13:19:48 -07:00
@@ -808,8 +808,6 @@
 	/* vgacon.c needs to know where we mapped IO memory in io_block_mapping() */
 	vgacon_remap_base = 0xf0000000;
 	conswitchp = &vga_con;
-#elif defined(CONFIG_DUMMY_CONSOLE)
-	conswitchp = &dummy_con;
 #endif
 }

--- a/arch/ppc/platforms/prpmc750.c	2004-08-03 13:19:48 -07:00
+++ b/arch/ppc/platforms/prpmc750.c	2004-08-03 13:19:48 -07:00
@@ -193,10 +193,6 @@
 		ROOT_DEV = Root_SDA2;
 #endif

-#ifdef CONFIG_DUMMY_CONSOLE
-	conswitchp = &dummy_con;
-#endif
-
 	OpenPIC_InitSenses = prpmc750_openpic_initsenses;
 	OpenPIC_NumInitSenses = sizeof(prpmc750_openpic_initsenses);

--- a/arch/ppc/platforms/prpmc800.c	2004-08-03 13:19:48 -07:00
+++ b/arch/ppc/platforms/prpmc800.c	2004-08-03 13:19:48 -07:00
@@ -309,10 +309,6 @@
 		ROOT_DEV = Root_SDA2;
 #endif

-#ifdef CONFIG_DUMMY_CONSOLE
-	conswitchp = &dummy_con;
-#endif
-
 	printk(KERN_INFO "Port by MontaVista Software, Inc. "
 			 "(source@mvista.com)\n");
 }
--- a/arch/ppc/platforms/sandpoint.c	2004-08-03 13:19:48 -07:00
+++ b/arch/ppc/platforms/sandpoint.c	2004-08-03 13:19:48 -07:00
@@ -303,10 +303,6 @@
 	/* Lookup PCI host bridges */
 	sandpoint_find_bridges();

-#ifdef CONFIG_DUMMY_CONSOLE
-	conswitchp = &dummy_con;
-#endif
-
 	printk(KERN_INFO "Motorola SPS Sandpoint Test Platform\n");
 	printk(KERN_INFO "Port by MontaVista Software, Inc. (source@mvista.com)\n");

--- a/arch/ppc/platforms/spruce.c	2004-08-03 13:19:48 -07:00
+++ b/arch/ppc/platforms/spruce.c	2004-08-03 13:19:48 -07:00
@@ -228,11 +228,6 @@
 		ROOT_DEV = Root_SDA1;
 #endif

-#ifdef CONFIG_VT
-	conswitchp = &dummy_con;
-#endif
-
-
 	/* Identify the system */
 	printk(KERN_INFO "System Identification: IBM Spruce\n");
 	printk(KERN_INFO "Port by MontaVista Software, Inc. (source@mvista.com)\n");
--- a/arch/ppc/syslib/ppc4xx_setup.c	2004-08-03 13:19:48 -07:00
+++ b/arch/ppc/syslib/ppc4xx_setup.c	2004-08-03 13:19:48 -07:00
@@ -61,10 +61,6 @@
 #ifdef CONFIG_PCI
 	ppc4xx_find_bridges();
 #endif
-
-#if defined(CONFIG_FB)
-	conswitchp = &dummy_con;
-#endif
 }

 /*

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
