Message-ID: <1818.80.7.99.14.1086886222.squirrel@www.solinno.co.uk>
Date: Thu, 10 Jun 2004 17:50:22 +0100 (BST)
Subject: [RFC][PATCH 1/9] Support for old IBM PReP boxes
From: "Leigh Brown" <leigh@solinno.co.uk>
To: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I forgot to mention that all these patches can be obtained from
http://www.solinno.co.uk/7043-140/files/2.6.6/

This patch implements have_residual_data() and is a respin of
what I posted before, changing the way I defined the inline
function based on Hollis's comment.

diff -urNX .diffex linux-2.6.6-prev/arch/ppc/platforms/prep_pci.c
linux-2.6.6/arch/ppc/platforms/prep_pci.c
--- linux-2.6.6-prev/arch/ppc/platforms/prep_pci.c	2004-06-07
11:44:43.000000000 +0100
+++ linux-2.6.6/arch/ppc/platforms/prep_pci.c	2004-06-10
17:04:13.000000000 +0100
@@ -836,52 +836,52 @@
 void __init
 ibm_prep_init(void)
 {
-#ifdef CONFIG_PREP_RESIDUAL
-	u32 addr, real_addr, len;
-	PPC_DEVICE *mpic;
-	PnP_TAG_PACKET *pkt;
-
-	/* Use the PReP residual data to determine if an OpenPIC is
-	 * present.  If so, get the large vendor packet which will
-	 * tell us the base address and length in memory.
-	 * If we are successful, ioremap the memory area and set
-	 * OpenPIC_Addr (this indicates that the OpenPIC was found).
-	 */
-	mpic = residual_find_device(-1, NULL, SystemPeripheral,
-			    ProgrammableInterruptController, MPIC, 0);
-	if (!mpic)
-		return;
+	if (have_residual_data()) {
+		u32 addr, real_addr, len;
+		PPC_DEVICE *mpic;
+		PnP_TAG_PACKET *pkt;
+
+		/* Use the PReP residual data to determine if an OpenPIC is
+		 * present.  If so, get the large vendor packet which will
+		 * tell us the base address and length in memory.
+		 * If we are successful, ioremap the memory area and set
+		 * OpenPIC_Addr (this indicates that the OpenPIC was found).
+		 */
+		mpic = residual_find_device(-1, NULL, SystemPeripheral,
+				    ProgrammableInterruptController, MPIC, 0);
+		if (!mpic)
+			return;

-	pkt = PnP_find_large_vendor_packet(res->DevicePnPHeap +
-			mpic->AllocatedOffset, 9, 0);
+		pkt = PnP_find_large_vendor_packet(res->DevicePnPHeap +
+				mpic->AllocatedOffset, 9, 0);

-	if (!pkt)
-		return;
+		if (!pkt)
+			return;

 #define p pkt->L4_Pack.L4_Data.L4_PPCPack
-	if (!((p.PPCData[0] == 2) && (p.PPCData[1] == 32)))
-		return; /* not a 32-bit memory address */
-
-	real_addr = ld_le32((unsigned int *) (p.PPCData + 4));
-	if (real_addr == 0xffffffff)
-		return;
+		if (!((p.PPCData[0] == 2) && (p.PPCData[1] == 32)))
+			return; /* not a 32-bit memory address */

-	/* Adjust address to be as seen by CPU */
-	addr = real_addr + PREP_ISA_MEM_BASE;
-
-	len = ld_le32((unsigned int *) (p.PPCData + 12));
-	if (!len)
-		return;
+		real_addr = ld_le32((unsigned int *) (p.PPCData + 4));
+		if (real_addr == 0xffffffff)
+			return;
+
+		/* Adjust address to be as seen by CPU */
+		addr = real_addr + PREP_ISA_MEM_BASE;
+
+		len = ld_le32((unsigned int *) (p.PPCData + 12));
+		if (!len)
+			return;
 #undef p
-	OpenPIC_Addr = ioremap(addr, len);
-	ppc_md.get_irq = openpic_get_irq;
+		OpenPIC_Addr = ioremap(addr, len);
+		ppc_md.get_irq = openpic_get_irq;

-	OpenPIC_InitSenses = prep_openpic_initsenses;
-	OpenPIC_NumInitSenses = sizeof(prep_openpic_initsenses);
+		OpenPIC_InitSenses = prep_openpic_initsenses;
+		OpenPIC_NumInitSenses = sizeof(prep_openpic_initsenses);

-	printk(KERN_INFO "MPIC at 0x%08x (0x%08x), length 0x%08x "
-	       "mapped to 0x%p\n", addr, real_addr, len, OpenPIC_Addr);
-#endif
+		printk(KERN_INFO "MPIC at 0x%08x (0x%08x), length 0x%08x "
+		       "mapped to 0x%p\n", addr, real_addr, len, OpenPIC_Addr);
+	}
 }

 static void __init
@@ -1262,8 +1262,8 @@
 			   PREP_ISA_IO_BASE + 0xcfc);

 	printk("PReP architecture\n");
-#ifdef CONFIG_PREP_RESIDUAL
-	{
+
+	if (have_residual_data()) {
 		PPC_DEVICE *hostbridge;

 		hostbridge = residual_find_device(PROCESSORDEVICE, NULL,
@@ -1284,7 +1284,6 @@
 				setup_indirect_pci(hose, 0x80000cf8, 0x80000cfc);
 		}
 	}
-#endif /* CONFIG_PREP_RESIDUAL */

 	ppc_md.pcibios_fixup = prep_pcibios_fixup;
 	ppc_md.pcibios_after_init = prep_pcibios_after_init;
diff -urNX .diffex linux-2.6.6-prev/arch/ppc/platforms/prep_setup.c
linux-2.6.6/arch/ppc/platforms/prep_setup.c
--- linux-2.6.6-prev/arch/ppc/platforms/prep_setup.c	2004-06-07
11:44:43.000000000 +0100
+++ linux-2.6.6/arch/ppc/platforms/prep_setup.c	2004-06-10
17:04:13.000000000 +0100
@@ -194,9 +194,8 @@
 		seq_printf(m, "bad");
 	seq_printf(m, "\n");

-#ifdef CONFIG_PREP_RESIDUAL
 	/* print info about SIMMs */
-	if (res->ResidualLength != 0) {
+	if (have_residual_data()) {
 		int i;
 		seq_printf(m, "simms\t\t: ");
 		for (i = 0; (res->ActualNumMemories) && (i < MAX_MEMS); i++) {
@@ -208,7 +207,6 @@
 		}
 		seq_printf(m, "\n");
 	}
-#endif
 }

 static int __prep
@@ -432,9 +430,8 @@
 	}

 no_l2:
-#ifdef CONFIG_PREP_RESIDUAL
 	/* print info about SIMMs */
-	if (res->ResidualLength != 0) {
+	if (have_residual_data()) {
 		int i;
 		seq_printf(m, "simms\t\t: ");
 		for (i = 0; (res->ActualNumMemories) && (i < MAX_MEMS); i++) {
@@ -446,7 +443,6 @@
 		}
 		seq_printf(m, "\n");
 	}
-#endif

 	return 0;
 }
@@ -562,14 +558,12 @@
 {
 	/* PREP's without residual data will give incorrect values here */
 	seq_printf(m, "clock\t\t: ");
-#ifdef CONFIG_PREP_RESIDUAL
-	if (res->ResidualLength)
+	if (have_residual_data())
 		seq_printf(m, "%ldMHz\n",
 			   (res->VitalProductData.ProcessorHz > 1024) ?
 			   res->VitalProductData.ProcessorHz / 1000000 :
 			   res->VitalProductData.ProcessorHz);
 	else
-#endif /* CONFIG_PREP_RESIDUAL */
 		seq_printf(m, "???\n");

 	return 0;
@@ -599,9 +593,10 @@
 	 * Get the needed resource informations from residual data.
 	 *
 	 */
-#ifdef CONFIG_PREP_RESIDUAL
-	audiodevice = residual_find_device(~0, NULL, MultimediaController,
-			AudioController, -1, 0);
+	if (have_residual_data())
+		audiodevice = residual_find_device(~0, NULL,
+				MultimediaController, AudioController, -1, 0);
+
 	if (audiodevice != NULL) {
 		PnP_TAG_PACKET *pkt;

@@ -614,7 +609,6 @@
 		if (pkt != NULL)
 			ppc_cs4232_dma2 = masktoint(pkt->S5_Pack.DMAMask);
 	}
-#endif

 	/*
 	 * These are the PReP specs' defaults for the cs4231.  We use these
@@ -650,13 +644,14 @@
 static void __init
 prep_init_vesa(void)
 {
-#if defined(CONFIG_PREP_RESIDUAL) && \
-	(defined(CONFIG_FB_VGA16) || defined(CONFIG_FB_VGA_16_MODULE) || \
+#if     (defined(CONFIG_FB_VGA16) || defined(CONFIG_FB_VGA_16_MODULE) || \
 	 defined(CONFIG_FB_VESA))
-	PPC_DEVICE *vgadev;
+	PPC_DEVICE *vgadev = NULL;
+
+	if (have_residual_data())
+		vgadev = residual_find_device(~0, NULL, DisplayController,
+							SVGAController, -1, 0);

-	vgadev = residual_find_device(~0, NULL, DisplayController, SVGAController,
-									-1, 0);
 	if (vgadev != NULL) {
 		PnP_TAG_PACKET *pkt;

@@ -681,7 +676,7 @@
 			}
 		}
 	}
-#endif /* CONFIG_PREP_RESIDUAL */
+#endif
 }

 static void __init
@@ -822,18 +817,19 @@
 static void __init
 prep_calibrate_decr(void)
 {
-#ifdef CONFIG_PREP_RESIDUAL
-	unsigned long freq, divisor = 4;
+	if (have_residual_data()) {
+		unsigned long freq, divisor = 4;

-	if ( res->VitalProductData.ProcessorBusHz ) {
-		freq = res->VitalProductData.ProcessorBusHz;
-		printk("time_init: decrementer frequency = %lu.%.6lu MHz\n",
-				(freq/divisor)/1000000,
-				(freq/divisor)%1000000);
-		tb_to_us = mulhwu_scale_factor(freq/divisor, 1000000);
-		tb_ticks_per_jiffy = freq / HZ / divisor;
-	} else
-#endif
+		if ( res->VitalProductData.ProcessorBusHz ) {
+			freq = res->VitalProductData.ProcessorBusHz;
+			printk("time_init: decrementer frequency = %lu.%.6lu MHz\n",
+					(freq/divisor)/1000000,
+					(freq/divisor)%1000000);
+			tb_to_us = mulhwu_scale_factor(freq/divisor, 1000000);
+			tb_ticks_per_jiffy = freq / HZ / divisor;
+		}
+	}
+	else
 		todc_calibrate_decr();
 }

@@ -1001,15 +997,14 @@
 	DMA_MODE_WRITE = 0x48;

 	/* figure out what kind of prep workstation we are */
-#ifdef CONFIG_PREP_RESIDUAL
-	if ( res->ResidualLength != 0 ) {
+	if (have_residual_data()) {
 		if ( !strncmp(res->VitalProductData.PrintableModel,"IBM",3) )
 			_prep_type = _PREP_IBM;
 		else
 			_prep_type = _PREP_Motorola;
-	} else /* assume motorola if no residual (netboot?) */
-#endif
-	{
+	}
+	else {
+		/* assume motorola if no residual (netboot?) */
 		_prep_type = _PREP_Motorola;
 	}

diff -urNX .diffex linux-2.6.6-prev/arch/ppc/platforms/residual.c
linux-2.6.6/arch/ppc/platforms/residual.c
--- linux-2.6.6-prev/arch/ppc/platforms/residual.c	2004-01-09
06:59:10.000000000 +0000
+++ linux-2.6.6/arch/ppc/platforms/residual.c	2004-06-10
17:04:13.000000000 +0100
@@ -504,7 +504,7 @@
 #define did dev->DeviceId

 	/* make sure we have residual data first */
-	if ( res->ResidualLength == 0 )
+	if (!have_residual_data())
 		return;

 	printk("Residual: %ld devices\n", res->ActualNumDevices);
@@ -639,7 +639,7 @@
 #define did dev->DeviceId

 	/* make sure we have residual data first */
-	if ( res->ResidualLength == 0 )
+	if (!have_residual_data())
 		return;
 	printk("Residual: %ld devices\n", res->ActualNumDevices);
 	for ( i = 0;
@@ -790,7 +790,7 @@
 			 int n)
 {
 	int i;
-	if ( !res->ResidualLength ) return NULL;
+	if (!have_residual_data()) return NULL;
 	for (i=0; i<res->ActualNumDevices; i++) {
 #define Dev res->Devices[i].DeviceId
 		if ( (Dev.BusId&BusMask)                                  &&
@@ -813,7 +813,7 @@
 			 int n)
 {
 	int i;
-	if ( !res->ResidualLength ) return NULL;
+	if (!have_residual_data()) return NULL;
 	for (i=0; i<res->ActualNumDevices; i++) {
 #define Dev res->Devices[i].DeviceId
 		if ( (Dev.BusId&BusMask)                                  &&
@@ -901,7 +901,7 @@
 int __init
 proc_prep_residual_init(void)
 {
-	if (res->ResidualLength)
+	if (have_residual_data())
 		create_proc_read_entry("residual", S_IRUGO, NULL,
 					proc_prep_residual_read, NULL);
 	return 0;
diff -urNX .diffex linux-2.6.6-prev/include/asm-ppc/residual.h
linux-2.6.6/include/asm-ppc/residual.h
--- linux-2.6.6-prev/include/asm-ppc/residual.h	2004-01-09
06:59:27.000000000 +0000
+++ linux-2.6.6/include/asm-ppc/residual.h	2004-06-10 17:05:32.000000000
+0100
@@ -328,6 +328,19 @@
 extern PnP_TAG_PACKET *PnP_find_large_vendor_packet(unsigned char *p,
 						    unsigned packet_type,
 						    int n);
+
+#if       defined(CONFIG_PREP_RESIDUAL)
+static inline int have_residual_data(void)
+{
+	return res && res->ResidualLength;
+}
+#else /* !defined(CONFIG_PREP_RESIDUAL) */
+static inline int have_residual_data(void)
+{
+	return 0;
+}
+#endif /* defined(CONFIG_PREP_RESIDUAL) */
+
 #endif /* __ASSEMBLY__ */
 #endif  /* ndef _RESIDUAL_ */


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
