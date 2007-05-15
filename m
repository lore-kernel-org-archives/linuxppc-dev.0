Return-Path: <dgibson@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH 2/3] Derive ebc ranges property from EBC registers
In-Reply-To: <20070515045247.GA6998@localhost.localdomain>
Message-Id: <20070515045415.5B05ADDECE@ozlabs.org>
Date: Tue, 15 May 2007 14:54:15 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In the device tree for Ebony, the 'ranges' property in the node for
the EBC bridge shows the mappings from the chip select / address lines
actually used for the EBC peripherals into the address space of the
OPB.  At present, these mappings are hardcoded in ebony.dts for the
mappings set up by the OpenBIOS firmware when it configures the EBC
bridge.

This patch replaces the hardcoded mappings with code in the zImage to
read the EBC configuration registers and create an appropriate ranges
property based on them.  This should make the zImage and kernel more
robust to changes in firmware configuration.  In particular, some of
the Ebony's DIP switches can change the effective address of the Flash
and other peripherals in OPB space.  With this patch, the kernel will
be able to cope with at least some of the possible variations.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---

 arch/powerpc/boot/44x.c         |   29 +++++++++++++++++++++++++++++
 arch/powerpc/boot/44x.h         |    1 +
 arch/powerpc/boot/dcr.h         |   37 +++++++++++++++++++++++++++++++++++++
 arch/powerpc/boot/dts/ebony.dts |    8 +++-----
 arch/powerpc/boot/ebony.c       |    1 +
 5 files changed, 71 insertions(+), 5 deletions(-)

Index: working-2.6/arch/powerpc/boot/dcr.h
===================================================================
--- working-2.6.orig/arch/powerpc/boot/dcr.h	2007-05-14 14:37:57.000000000 +1000
+++ working-2.6/arch/powerpc/boot/dcr.h	2007-05-14 14:45:56.000000000 +1000
@@ -26,6 +26,43 @@ static const unsigned long sdram_bxcr[] 
 #define			SDRAM_CONFIG_BANK_SIZE(reg)	\
 	(0x00400000 << ((reg & SDRAM_CONFIG_SIZE_MASK) >> 17))
 
+/* 440GP External Bus Controller (EBC) */
+#define DCRN_EBC0_CFGADDR				0x012
+#define DCRN_EBC0_CFGDATA				0x013
+#define   EBC_NUM_BANKS					  8
+#define   EBC_B0CR					  0x00
+#define   EBC_B1CR					  0x01
+#define   EBC_B2CR					  0x02
+#define   EBC_B3CR					  0x03
+#define   EBC_B4CR					  0x04
+#define   EBC_B5CR					  0x05
+#define   EBC_B6CR					  0x06
+#define   EBC_B7CR					  0x07
+#define   EBC_BXCR(n)					  (n)
+#define	    EBC_BXCR_BAS				    0xfff00000
+#define	    EBC_BXCR_BS				  	    0x000e0000
+#define	    EBC_BXCR_BANK_SIZE(reg) \
+	(0x100000 << (((reg) & EBC_BXCR_BS) >> 17))
+#define	    EBC_BXCR_BU				  	    0x00018000
+#define	      EBC_BXCR_BU_OFF			  	      0x00000000
+#define	      EBC_BXCR_BU_RO			  	      0x00008000
+#define	      EBC_BXCR_BU_WO			  	      0x00010000
+#define	      EBC_BXCR_BU_RW			  	      0x00018000
+#define	    EBC_BXCR_BW				  	    0x00006000
+#define   EBC_B0AP					  0x10
+#define   EBC_B1AP					  0x11
+#define   EBC_B2AP					  0x12
+#define   EBC_B3AP					  0x13
+#define   EBC_B4AP					  0x14
+#define   EBC_B5AP					  0x15
+#define   EBC_B6AP					  0x16
+#define   EBC_B7AP					  0x17
+#define   EBC_BXAP(n)					  (0x10+(n))
+#define   EBC_BEAR					  0x20
+#define   EBC_BESR					  0x21
+#define   EBC_CFG					  0x23
+#define   EBC_CID					  0x24
+
 /* 440GP Clock, PM, chip control */
 #define DCRN_CPC0_SR					0x0b0
 #define DCRN_CPC0_ER					0x0b1
Index: working-2.6/arch/powerpc/boot/ebony.c
===================================================================
--- working-2.6.orig/arch/powerpc/boot/ebony.c	2007-05-14 14:45:55.000000000 +1000
+++ working-2.6/arch/powerpc/boot/ebony.c	2007-05-14 14:45:56.000000000 +1000
@@ -100,6 +100,7 @@ static void ebony_fixups(void)
 	ibm440gp_fixup_clocks(sysclk, 6 * 1843200);
 	ibm44x_fixup_memsize();
 	dt_fixup_mac_addresses(ebony_mac0, ebony_mac1);
+	ibm4xx_fixup_ebc_ranges("/plb/opb/ebc");
 }
 
 void ebony_init(void *mac0, void *mac1)
Index: working-2.6/arch/powerpc/boot/dts/ebony.dts
===================================================================
--- working-2.6.orig/arch/powerpc/boot/dts/ebony.dts	2007-05-14 14:38:39.000000000 +1000
+++ working-2.6/arch/powerpc/boot/dts/ebony.dts	2007-05-14 14:45:56.000000000 +1000
@@ -136,11 +136,9 @@
 				#address-cells = <2>;
 				#size-cells = <1>;
 				clock-frequency = <0>; // Filled in by zImage
-				ranges = <0 00000000 fff00000 100000
-					  1 00000000 48000000 100000
-					  2 00000000 ff800000 400000
-					  3 00000000 48200000 100000
-					  7 00000000 48300000 100000>;
+				// ranges property is supplied by zImage
+				// based on firmware's configuration of the
+				// EBC bridge
 				interrupts = <5 4>;
 				interrupt-parent = <&UIC1>;
 
Index: working-2.6/arch/powerpc/boot/44x.c
===================================================================
--- working-2.6.orig/arch/powerpc/boot/44x.c	2007-05-14 14:45:55.000000000 +1000
+++ working-2.6/arch/powerpc/boot/44x.c	2007-05-14 14:45:56.000000000 +1000
@@ -54,3 +54,32 @@ void ibm44x_dbcr_reset(void)
 		);
 
 }
+
+/* Read 4xx EBC bus bridge registers to get mappings of the peripheral
+ * banks into the OPB address space */
+void ibm4xx_fixup_ebc_ranges(const char *ebc)
+{
+	void *devp;
+	u32 bxcr;
+	u32 ranges[EBC_NUM_BANKS*4];
+	u32 *p = ranges;
+	int i;
+
+	for (i = 0; i < EBC_NUM_BANKS; i++) {
+		mtdcr(DCRN_EBC0_CFGADDR, EBC_BXCR(i));
+		bxcr = mfdcr(DCRN_EBC0_CFGDATA);
+
+		if ((bxcr & EBC_BXCR_BU) != EBC_BXCR_BU_OFF) {
+			*p++ = i;
+			*p++ = 0;
+			*p++ = bxcr & EBC_BXCR_BAS;
+			*p++ = EBC_BXCR_BANK_SIZE(bxcr);
+		}
+	}
+
+	devp = finddevice(ebc);
+	if (! devp)
+		fatal("Couldn't locate EBC node %s\n\r", ebc);
+
+	setprop(devp, "ranges", ranges, (p - ranges) * sizeof(u32));
+}
Index: working-2.6/arch/powerpc/boot/44x.h
===================================================================
--- working-2.6.orig/arch/powerpc/boot/44x.h	2007-05-14 14:45:55.000000000 +1000
+++ working-2.6/arch/powerpc/boot/44x.h	2007-05-14 14:45:56.000000000 +1000
@@ -11,6 +11,7 @@
 #define _PPC_BOOT_44X_H_
 
 void ibm44x_fixup_memsize(void);
+void ibm4xx_fixup_ebc_ranges(const char *ebc);
 
 void ibm44x_dbcr_reset(void);
 void ebony_init(void *mac0, void *mac1);
