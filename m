Return-Path: <mgreer@mvista.com>
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by ozlabs.org (Postfix) with ESMTP id 78B5567A81
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 Mar 2005 09:26:29 +1100 (EST)
Message-ID: <4237610E.7030409@mvista.com>
Date: Tue, 15 Mar 2005 15:26:22 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: akpm <akpm@osdl.org>
Content-Type: multipart/mixed; boundary="------------080400030708050700050901"
Cc: Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
Subject: [PATCH 2.6.12] ppc32: Patch for changed dev->bus_id format
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
--------------080400030708050700050901
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

ppc32: Patch for changed dev->bus_id format + some misc fixups

- Recent changes to drivers/base/platform.c:platform_device_register() 
changed the format
of dev->bus_id (there is now a '.' between the name & instance (e.g., 
the old mpsc0 is now mpsc.0)).  This field is used by some platform's 
platform_notify() routine to identify  the dev entry.  This patch 
updates the bus_id value compared to include the dot.
- Fix an bad macro name change by a previous patch.
- Some coding style fixups, etc.

Signed-off-by: Mark A. Greer <mgreer@mvista.com>
--

--------------080400030708050700050901
Content-Type: text/plain;
 name="bus_id_fixups.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="bus_id_fixups.patch"

diff -Nru a/arch/ppc/platforms/cpci690.c b/arch/ppc/platforms/cpci690.c
--- a/arch/ppc/platforms/cpci690.c	2005-03-15 15:15:30 -07:00
+++ b/arch/ppc/platforms/cpci690.c	2005-03-15 15:15:30 -07:00
@@ -60,8 +60,7 @@
 
 		const long min_idsel = 20, max_idsel = 20, irqs_per_slot = 4;
 		return PCI_IRQ_TABLE_LOOKUP;
-	}
-	else {
+	} else {
 		static char pci_irq_table[][4] =
 		/*
 		 *	PCI IDSEL/INTPIN->INTLINE
@@ -79,18 +78,12 @@
 }
 
 static int
-cpci690_get_bus_speed(void)
-{
-	return 133333333;
-}
-
-static int
 cpci690_get_cpu_speed(void)
 {
 	unsigned long	hid1;
 
 	hid1 = mfspr(SPRN_HID1) >> 28;
-	return cpci690_get_bus_speed() * cpu_7xx[hid1]/2;
+	return CPCI690_BUS_FREQ * cpu_7xx[hid1]/2;
 }
 
 #define	KB	(1024UL)
@@ -226,8 +219,6 @@
 	bh.hose_b->last_busno = 0xff;
 	bh.hose_b->last_busno = pciauto_bus_scan(bh.hose_b,
 		bh.hose_b->first_busno);
-
-	return;
 }
 
 static void __init
@@ -285,8 +276,6 @@
 	/* Route MPP interrupt inputs to GPP */
 	mv64x60_write(&bh, MV64x60_MPP_CNTL_2, 0x00000000);
 	mv64x60_write(&bh, MV64x60_MPP_CNTL_3, 0x00000000);
-
-	return;
 }
 
 static void __init
@@ -326,8 +315,6 @@
 
 	if (ppc_md.progress)
 		ppc_md.progress("cpci690_setup_arch: exit", 0);
-
-	return;
 }
 
 /* Platform device data fixup routines. */
@@ -340,11 +327,9 @@
 	pdata = (struct mpsc_pdata *)pdev->dev.platform_data;
 
 	pdata->max_idle = 40;
-	pdata->default_baud = 9600;
-	pdata->brg_clk_src = 8;
-	pdata->brg_clk_freq = 133000000;
-
-	return;
+	pdata->default_baud = CPCI690_MPSC_BAUD;
+	pdata->brg_clk_src = CPCI690_MPSC_CLK_SRC;
+	pdata->brg_clk_freq = CPCI690_BUS_FREQ;
 }
 
 static int __init
@@ -354,8 +339,8 @@
 		char	*bus_id;
 		void	((*rtn)(struct platform_device *pdev));
 	} dev_map[] = {
-		{ MPSC_CTLR_NAME "0", cpci690_fixup_mpsc_pdata },
-		{ MPSC_CTLR_NAME "1", cpci690_fixup_mpsc_pdata },
+		{ MPSC_CTLR_NAME ".0", cpci690_fixup_mpsc_pdata },
+		{ MPSC_CTLR_NAME ".1", cpci690_fixup_mpsc_pdata },
 	};
 	struct platform_device	*pdev;
 	int	i;
@@ -412,7 +397,7 @@
 	seq_printf(m, "vendor\t\t: " BOARD_VENDOR "\n");
 	seq_printf(m, "machine\t\t: " BOARD_MACHINE "\n");
 	seq_printf(m, "cpu MHz\t\t: %d\n", cpci690_get_cpu_speed()/1000/1000);
-	seq_printf(m, "bus MHz\t\t: %d\n", cpci690_get_bus_speed()/1000/1000);
+	seq_printf(m, "bus MHz\t\t: %d\n", CPCI690_BUS_FREQ/1000/1000);
 
 	return 0;
 }
@@ -422,15 +407,13 @@
 {
 	ulong freq;
 
-	freq = cpci690_get_bus_speed()/4;
+	freq = CPCI690_BUS_FREQ / 4;
 
 	printk(KERN_INFO "time_init: decrementer frequency = %lu.%.6lu MHz\n",
 	       freq/1000000, freq%1000000);
 
 	tb_ticks_per_jiffy = freq / HZ;
 	tb_to_us = mulhwu_scale_factor(freq, 1000000);
-
-	return;
 }
 
 static __inline__ void
@@ -444,8 +427,6 @@
 	mtspr(SPRN_DBAT1U, addr | size | 0x2); /* Vs == 1; Vp == 0 */
 	mtspr(SPRN_DBAT1L, addr | 0x2a); /* WIMG bits == 0101; PP == r/w access */
 	mb();
-
-	return;
 }
 
 #if defined(CONFIG_SERIAL_TEXT_DEBUG) || defined(CONFIG_KGDB)
@@ -507,6 +488,4 @@
 #if defined(CONFIG_SERIAL_MPSC)
 	platform_notify = cpci690_platform_notify;
 #endif
-
-	return;
 }
diff -Nru a/arch/ppc/platforms/cpci690.h b/arch/ppc/platforms/cpci690.h
--- a/arch/ppc/platforms/cpci690.h	2005-03-15 15:15:30 -07:00
+++ b/arch/ppc/platforms/cpci690.h	2005-03-15 15:15:30 -07:00
@@ -70,4 +70,9 @@
 #define	CPCI690_IPMI_SIZE		max(GT64260_WINDOW_SIZE_MIN,	\
 						CPCI690_IPMI_SIZE_ACTUAL)
 
+#define	CPCI690_MPSC_BAUD			9600
+#define	CPCI690_MPSC_CLK_SRC			8 /* TCLK */
+
+#define	CPCI690_BUS_FREQ			133333333
+
 #endif /* __PPC_PLATFORMS_CPCI690_H */
diff -Nru a/arch/ppc/platforms/ev64260.c b/arch/ppc/platforms/ev64260.c
--- a/arch/ppc/platforms/ev64260.c	2005-03-15 15:15:30 -07:00
+++ b/arch/ppc/platforms/ev64260.c	2005-03-15 15:15:30 -07:00
@@ -80,7 +80,7 @@
 {
 	unsigned long	pvr, hid1, pll_ext;
 
-	pvr = SPRN_VER(mfspr(SPRN_PVR));
+	pvr = PVR_VER(mfspr(SPRN_PVR));
 
 	if (pvr != PVR_VER(PVR_7450)) {
 		hid1 = mfspr(SPRN_HID1) >> 28;
@@ -422,8 +422,8 @@
 		char	*bus_id;
 		void	((*rtn)(struct platform_device *pdev));
 	} dev_map[] = {
-		{ MPSC_CTLR_NAME "0", ev64260_fixup_mpsc_pdata },
-		{ MPSC_CTLR_NAME "1", ev64260_fixup_mpsc_pdata },
+		{ MPSC_CTLR_NAME ".0", ev64260_fixup_mpsc_pdata },
+		{ MPSC_CTLR_NAME ".1", ev64260_fixup_mpsc_pdata },
 	};
 	struct platform_device	*pdev;
 	int	i;
diff -Nru a/arch/ppc/platforms/katana.c b/arch/ppc/platforms/katana.c
--- a/arch/ppc/platforms/katana.c	2005-03-15 15:15:30 -07:00
+++ b/arch/ppc/platforms/katana.c	2005-03-15 15:15:30 -07:00
@@ -521,13 +521,13 @@
 		void	((*rtn)(struct platform_device *pdev));
 	} dev_map[] = {
 #if defined(CONFIG_SERIAL_MPSC)
-		{ MPSC_CTLR_NAME "0", katana_fixup_mpsc_pdata },
-		{ MPSC_CTLR_NAME "1", katana_fixup_mpsc_pdata },
+		{ MPSC_CTLR_NAME ".0", katana_fixup_mpsc_pdata },
+		{ MPSC_CTLR_NAME ".1", katana_fixup_mpsc_pdata },
 #endif
 #if defined(CONFIG_MV643XX_ETH)
-		{ MV643XX_ETH_NAME "0", katana_fixup_eth_pdata },
-		{ MV643XX_ETH_NAME "1", katana_fixup_eth_pdata },
-		{ MV643XX_ETH_NAME "2", katana_fixup_eth_pdata },
+		{ MV643XX_ETH_NAME ".0", katana_fixup_eth_pdata },
+		{ MV643XX_ETH_NAME ".1", katana_fixup_eth_pdata },
+		{ MV643XX_ETH_NAME ".2", katana_fixup_eth_pdata },
 #endif
 	};
 	struct platform_device	*pdev;

--------------080400030708050700050901--
