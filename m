From: Gustavo Sverzut Barbieri <gustavo@gsbarbieri.sytes.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: rs6k E30 + 240 (doral) support
Date: Mon, 7 Jun 2004 18:02:09 -0300
Cc: anton@samba.org, paulus@samba.org
MIME-Version: 1.0
Content-Type: Multipart/Mixed
Message-Id: <200406071802.20745.gustavo@gsbarbieri.sytes.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--Boundary-00=_VfNxA/DHSlowuou
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,

	Attached are 2 patches to add support for rs/6000 E30 and 240 (Doral) PPC 32
bits PReP machines.
	These patches are not mine, I just adapted a patch from 2.4.19 to 2.4.26 and
2.6.6. I found that patch at:
			http://home.tiscali.be/philipa/rs6000.html
	Original patch is from Leigh Brown.

	I know these machines are quite old, but I found out that they're common in
Universities here in Brazil due some partnership, maybe they're in other poor
countries, so please look at integrating them :)

--
Gustavo Sverzut Barbieri

----
Engenharia de Computacao 2001 - UNICAMP
LTC - Linux Technology Center  - IBM / Brazil
Jabber: gsbarbieri@jabber.org
  ICQ#: 17249123
   GPG: 0xB640E1A2 @ wwwkeys.pgp.net

--Boundary-00=_VfNxA/DHSlowuou
Content-Type: text/x-diff;
  charset="us-ascii";
  name="linux-2.4.26-rs6000_e30.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="linux-2.4.26-rs6000_e30.diff"

diff -Naur linux-2.4.26-old/arch/ppc/platforms/prep_pci.c linux-2.4.26/arch/ppc/platforms/prep_pci.c
--- linux-2.4.26-old/arch/ppc/platforms/prep_pci.c	2004-02-18 10:36:30.000000000 -0300
+++ linux-2.4.26/arch/ppc/platforms/prep_pci.c	2004-06-01 21:35:39.000000000 -0300
@@ -547,6 +547,74 @@
         15,     /* Line 4 */
 };

+/*
+ * IBM RS/6000 7043-240  -- Leigh Brown
+ * XXX we should get all this from the residual data
+ */
+static char ibm_doral_pci_IRQ_map[23] __prepdata = {
+        0, /* Slot 0  - unused */
+        3, /* Slot 1  - PCI Slot 1 device 0x08 */
+        5, /* Slot 2  - PCI Slot 3 device 0x10 */
+       11, /* Slot 3  - PCI Slot 5 device 0x18 */
+        2, /* Slot 4  - Integrated PCI device 0x20 */
+        1, /* Slot 5  - Integrated PCI device 0x28 */
+        0, /* Slot 6  - Integrated PCI device 0x30 - no IRQ */
+        0, /* Slot 7  - Integrated PCI device 0x38 - no IRQ */
+        0, /* Slot 8  - unused */
+        0, /* Slot 9  - unused */
+        0, /* Slot 10 - unused */
+        0, /* Slot 11 - unused */
+        0, /* Slot 12 - unused */
+        0, /* Slot 13 - unused */
+        0, /* Slot 14 - unused */
+        0, /* Slot 15 - unused */
+        0, /* Slot 16 - unused */
+        0, /* Slot 17 - unused */
+        0, /* Slot 18 - unused */
+        0, /* Slot 19 - unused */
+        0, /* Slot 20 - unused */
+        0, /* Slot 21 - unused */
+        0, /* Slot 22 - unused */
+};
+
+/*
+ * IBM RS/6000 7024-E30  -- Leigh Brown
+ * XXX we should get all this from the residual data
+ */
+static char ibm_7024e30_pci_IRQ_map[23] __prepdata = {
+        0, /* Slot 0  - unused */
+        0, /* Slot 1  - unused */
+        0, /* Slot 2  - unused */
+        0, /* Slot 3  - unused */
+        0, /* Slot 4  - unused */
+        0, /* Slot 5  - unused */
+        0, /* Slot 6  - unused */
+        0, /* Slot 7  - unused */
+        0, /* Slot 8  - unused */
+        0, /* Slot 9  - unused */
+        0, /* Slot 10 - unused */
+        0, /* Slot 11 - Unknown Integrated PCI device - no IRQ */
+        0, /* Slot 12 - Unknown Integrated PCI device - no IRQ */
+        0, /* Slot 13 - Unknown Integrated PCI device - no IRQ */
+        2, /* Slot 14 - PCI Slot 1 INTA and INTC */
+        4, /* Slot 15 - PCI Slot 2 INTA and INTC */
+        0, /* Slot 16 - unused */
+        0, /* Slot 17 - unused */
+        0, /* Slot 18 - unused */
+        0, /* Slot 19 - unused */
+        0, /* Slot 20 - unused */
+        0, /* Slot 21 - unused */
+        0, /* Slot 22 - unused */
+};
+
+static char ibm_7024e30_pci_IRQ_routes[] __prepdata = {
+        0,      /* Line 0 - unused */
+        15,     /* Line 1 */
+        15,     /* Line 2 */
+        15,     /* Line 3 */
+        15,     /* Line 4 */
+};
+
 /* Motorola PowerPlus architecture PCI IRQ tables */
 /* Interrupt line values for INTA-D on primary/secondary MPIC inputs */

@@ -869,6 +937,28 @@
 	pci_write_config_byte(dev, PCI_INTERRUPT_LINE, dev->irq);
 }

+static void __init
+ibm_7024e30_pci_map_non0(struct pci_dev *dev)
+{
+	unsigned char intpin;
+	int irq;
+	static unsigned char bridge_intrs[5][4] = {
+		{ 1, 0, 0, 0 },
+		{ 8, 9, 8, 9 },
+		{ 10, 11, 10, 11 },
+		{ 12, 13, 12, 13 }
+	};
+
+	if (dev == NULL || PCI_SLOT(dev->devfn) > 4)
+		return;
+	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &intpin);
+	if (intpin < 1 || intpin > 4)
+		return;
+	irq = bridge_intrs[PCI_SLOT(dev->devfn)][intpin - 1];
+	dev->irq = openpic_to_irq(irq);
+	pci_write_config_byte(dev, PCI_INTERRUPT_LINE, dev->irq);
+}
+
 void __init
 prep_sandalfoot_setup_pci(char *irq_edge_mask_lo, char *irq_edge_mask_hi)
 {
@@ -911,6 +1001,28 @@
 }

 void __init
+prep_doral_setup_pci(char *irq_edge_mask_lo, char *irq_edge_mask_hi)
+{
+	Motherboard_map_name = "IBM 7043-240 (Doral)";
+	Motherboard_map = ibm_doral_pci_IRQ_map;
+	Motherboard_routes = NULL;
+	Motherboard_non0 = NULL;
+	*irq_edge_mask_lo = 0x00; /* irq's 0-7 all edge-triggered */
+	*irq_edge_mask_hi = 0xA0; /* irq's 13, 15 level-triggered */
+}
+
+void __init
+prep_7024e30_setup_pci(char *irq_edge_mask_lo, char *irq_edge_mask_hi)
+{
+	Motherboard_map_name = "IBM 7024-E30";
+	Motherboard_map = ibm_7024e30_pci_IRQ_map;
+	Motherboard_routes = ibm_7024e30_pci_IRQ_routes;
+	Motherboard_non0 = ibm_7024e30_pci_map_non0;
+	*irq_edge_mask_lo = 0x00; /* irq's 0-7 all edge-triggered */
+	*irq_edge_mask_hi = 0xA0; /* irq's 13, 15 level-triggered */
+}
+
+void __init
 prep_route_pci_interrupts(void)
 {
 	unsigned char *ibc_pirq = (unsigned char *)0x80800860;
@@ -990,11 +1102,13 @@
 		return;
 	}

-	/* Set up mapping from slots */
-	for (i = 1;  i <= 4;  i++)
-		ibc_pirq[i-1] = Motherboard_routes[i];
-	/* Enable PCI interrupts */
-	*ibc_pcicon |= 0x20;
+ 	if (Motherboard_routes) { /* Doral does not like this code */
+	        /* Set up mapping from slots */
+	        for (i = 1;  i <= 4;  i++)
+		        ibc_pirq[i-1] = Motherboard_routes[i];
+		/* Enable PCI interrupts */
+		*ibc_pcicon |= 0x20;
+	}
 }

 void __init
@@ -1268,7 +1382,8 @@
 		hostbridge = residual_find_device(PROCESSORDEVICE, NULL,
 			BridgeController, PCIBridge, -1, 0);
 		if (hostbridge &&
-			hostbridge->DeviceId.Interface == PCIBridgeIndirect) {
+			((hostbridge->DeviceId.Interface == PCIBridgeIndirect) ||
+			 (hostbridge->DeviceId.Interface == PCIBridgeRS6K))) {
 			PnP_TAG_PACKET * pkt;
 			pkt = PnP_find_large_vendor_packet(
 				res->DevicePnPHeap+hostbridge->AllocatedOffset,
diff -Naur linux-2.4.26-old/arch/ppc/platforms/prep_setup.c linux-2.4.26/arch/ppc/platforms/prep_setup.c
--- linux-2.4.26-old/arch/ppc/platforms/prep_setup.c	2003-08-25 08:44:40.000000000 -0300
+++ linux-2.4.26/arch/ppc/platforms/prep_setup.c	2004-06-01 21:35:39.000000000 -0300
@@ -94,6 +94,8 @@
 extern void prep_thinkpad_setup_pci(char *irq_edge_mask_lo, char *irq_edge_mask_hi);
 extern void prep_carolina_setup_pci(char *irq_edge_mask_lo, char *irq_edge_mask_hi);
 extern void prep_tiger1_setup_pci(char *irq_edge_mask_lo, char *irq_edge_mask_hi);
+extern void prep_doral_setup_pci(char *irq_edge_mask_lo, char *irq_edge_mask_hi);
+extern void prep_7024e30_setup_pci(char *irq_edge_mask_lo, char *irq_edge_mask_hi);


 #define cached_21	(((char *)(ppc_cached_irq_mask))[3])
@@ -137,8 +139,8 @@
 /* planar ID values: */
 /* Sandalfoot/Sandalbow (6015/7020) */
 #define PREP_IBM_SANDALFOOT	0xfc
-/* Woodfield, Thinkpad 850/860 (6042/7249) */
-#define PREP_IBM_THINKPAD	0xff /* planar ID unimplemented */
+/* Woodfield, Thinkpad 850/860 (6042/7249), 7043-240 */
+#define PREP_IBM_NO_PLANAR_ID		0xff /* planar ID unimplemented */
 /* PowerSeries 830/850 (6050/6070) */
 #define PREP_IBM_CAROLINA_IDE_0	0xf0
 #define PREP_IBM_CAROLINA_IDE_1	0xf1
@@ -154,6 +156,12 @@
 #define PREP_IBM_TIGER1_180		0xd3
 #define PREP_IBM_TIGER1_xxx		0xd4 /* unknown, but probably exists */
 #define PREP_IBM_TIGER1_333		0xd5 /* missing from Tiger Tech Spec */
+/* 7024-E30 */
+#define PREP_IBM_7024E30		0x95
+
+/* Residual data model strings */
+#define PREP_IBM_MODEL_TIGER1	"IBM Model 7042/7043 (ED)"
+#define PREP_IBM_MODEL_DORAL	"IBM PPS Model 7043 (ED)"

 /* setup_ibm_pci:
  * 	set Motherboard_map_name, Motherboard_map, Motherboard_routes.
@@ -722,11 +730,26 @@
 				ppc_md.power_off = prep_sig750_poweroff;
 				ppc_md.show_cpuinfo = prep_sandalfoot_cpuinfo;
 				break;
-			case PREP_IBM_THINKPAD:
-				prep_gen_enable_l2();
-				setup_ibm_pci = prep_thinkpad_setup_pci;
-				ppc_md.power_off = prep_carrera_poweroff;
-				ppc_md.show_cpuinfo = prep_thinkpad_cpuinfo;
+			case PREP_IBM_NO_PLANAR_ID:
+#ifdef CONFIG_PREP_RESIDUAL
+				if (res &&
+				    strcmp(res->VitalProductData.PrintableModel,
+					    PREP_IBM_MODEL_DORAL) == 0) {
+					prep_carolina_enable_l2();
+					setup_ibm_pci = prep_doral_setup_pci;
+					ppc_md.power_off = prep_sig750_poweroff;
+					ppc_md.show_cpuinfo = prep_tiger1_cpuinfo;
+				}
+				else {
+#else /* !CONFIG_PREP_RESIDUAL */
+				{
+#endif /* CONFIG_PREP_RESIDUAL */
+					/* Assume it is a thinkpad */
+					prep_gen_enable_l2();
+					setup_ibm_pci = prep_thinkpad_setup_pci;
+					ppc_md.power_off = prep_carrera_poweroff;
+					ppc_md.show_cpuinfo = prep_thinkpad_cpuinfo;
+				}
 				break;
 			default:
 				printk(" -- unknown! Assuming Carolina");
@@ -753,6 +776,12 @@
 				ppc_md.power_off = prep_sig750_poweroff;
 				ppc_md.show_cpuinfo = prep_tiger1_cpuinfo;
 				break;
+			case PREP_IBM_7024E30:
+				prep_carolina_enable_l2();
+				setup_ibm_pci = prep_7024e30_setup_pci;
+				ppc_md.power_off = prep_sig750_poweroff;
+				ppc_md.show_cpuinfo = prep_carolina_cpuinfo;
+				break;
 		}
 		printk("\n");


--Boundary-00=_VfNxA/DHSlowuou
Content-Type: text/x-diff;
  charset="us-ascii";
  name="linux-2.6.6-rs6000_e30.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="linux-2.6.6-rs6000_e30.diff"

diff -Naur linux-2.6.6-orig/arch/ppc/platforms/prep_pci.c linux-2.6.6/arch/ppc/platforms/prep_pci.c
--- linux-2.6.6-orig/arch/ppc/platforms/prep_pci.c	2004-05-09 23:33:20.000000000 -0300
+++ linux-2.6.6/arch/ppc/platforms/prep_pci.c	2004-06-01 19:06:41.000000000 -0300
@@ -42,6 +42,75 @@

 /* Tables for known hardware */

+/*
+ * IBM RS/6000 7043-240  -- Leigh Brown
+ * XXX we should get all this from the residual data
+ */
+static char ibm_doral_pci_IRQ_map[23] __prepdata = {
+        0, /* Slot 0  - unused */
+        3, /* Slot 1  - PCI Slot 1 device 0x08 */
+        5, /* Slot 2  - PCI Slot 3 device 0x10 */
+       11, /* Slot 3  - PCI Slot 5 device 0x18 */
+        2, /* Slot 4  - Integrated PCI device 0x20 */
+        1, /* Slot 5  - Integrated PCI device 0x28 */
+        0, /* Slot 6  - Integrated PCI device 0x30 - no IRQ */
+        0, /* Slot 7  - Integrated PCI device 0x38 - no IRQ */
+        0, /* Slot 8  - unused */
+        0, /* Slot 9  - unused */
+        0, /* Slot 10 - unused */
+        0, /* Slot 11 - unused */
+        0, /* Slot 12 - unused */
+        0, /* Slot 13 - unused */
+        0, /* Slot 14 - unused */
+        0, /* Slot 15 - unused */
+        0, /* Slot 16 - unused */
+        0, /* Slot 17 - unused */
+        0, /* Slot 18 - unused */
+        0, /* Slot 19 - unused */
+        0, /* Slot 20 - unused */
+        0, /* Slot 21 - unused */
+        0, /* Slot 22 - unused */
+};
+
+/*
+ * IBM RS/6000 7024-E30  -- Leigh Brown
+ * XXX we should get all this from the residual data
+ */
+static char ibm_7024e30_pci_IRQ_map[23] __prepdata = {
+        0, /* Slot 0  - unused */
+        0, /* Slot 1  - unused */
+        0, /* Slot 2  - unused */
+        0, /* Slot 3  - unused */
+        0, /* Slot 4  - unused */
+        0, /* Slot 5  - unused */
+        0, /* Slot 6  - unused */
+        0, /* Slot 7  - unused */
+        0, /* Slot 8  - unused */
+        0, /* Slot 9  - unused */
+        0, /* Slot 10 - unused */
+        0, /* Slot 11 - Unknown Integrated PCI device - no IRQ */
+        0, /* Slot 12 - Unknown Integrated PCI device - no IRQ */
+        0, /* Slot 13 - Unknown Integrated PCI device - no IRQ */
+        2, /* Slot 14 - PCI Slot 1 INTA and INTC */
+        4, /* Slot 15 - PCI Slot 2 INTA and INTC */
+        0, /* Slot 16 - unused */
+        0, /* Slot 17 - unused */
+        0, /* Slot 18 - unused */
+        0, /* Slot 19 - unused */
+        0, /* Slot 20 - unused */
+        0, /* Slot 21 - unused */
+        0, /* Slot 22 - unused */
+};
+
+static char ibm_7024e30_pci_IRQ_routes[] __prepdata = {
+        0,      /* Line 0 - unused */
+        15,     /* Line 1 */
+        15,     /* Line 2 */
+        15,     /* Line 3 */
+        15,     /* Line 4 */
+};
+
+
 /* Motorola PowerStackII - Utah */
 static char Utah_pci_IRQ_map[23] __prepdata =
 {
@@ -885,6 +954,50 @@
 }

 static void __init
+ibm_7024e30_pci_map_non0(struct pci_dev *dev)
+{
+	unsigned char intpin;
+	int irq;
+	static unsigned char bridge_intrs[5][4] = {
+		{ 1, 0, 0, 0 },
+		{ 8, 9, 8, 9 },
+		{ 10, 11, 10, 11 },
+		{ 12, 13, 12, 13 }
+	};
+
+	if (dev == NULL || PCI_SLOT(dev->devfn) > 4)
+		return;
+	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &intpin);
+	if (intpin < 1 || intpin > 4)
+		return;
+	irq = bridge_intrs[PCI_SLOT(dev->devfn)][intpin - 1];
+	dev->irq = openpic_to_irq(irq);
+	pci_write_config_byte(dev, PCI_INTERRUPT_LINE, dev->irq);
+}
+
+void __init
+prep_doral_setup_pci(char *irq_edge_mask_lo, char *irq_edge_mask_hi)
+{
+	Motherboard_map_name = "IBM 7043-240 (Doral)";
+	Motherboard_map = ibm_doral_pci_IRQ_map;
+	Motherboard_routes = NULL;
+	Motherboard_non0 = NULL;
+	*irq_edge_mask_lo = 0x00; /* irq's 0-7 all edge-triggered */
+	*irq_edge_mask_hi = 0xA0; /* irq's 13, 15 level-triggered */
+}
+
+void __init
+prep_7024e30_setup_pci(char *irq_edge_mask_lo, char *irq_edge_mask_hi)
+{
+	Motherboard_map_name = "IBM 7024-E30";
+	Motherboard_map = ibm_7024e30_pci_IRQ_map;
+	Motherboard_routes = ibm_7024e30_pci_IRQ_routes;
+	Motherboard_non0 = ibm_7024e30_pci_map_non0;
+	*irq_edge_mask_lo = 0x00; /* irq's 0-7 all edge-triggered */
+	*irq_edge_mask_hi = 0xA0; /* irq's 13, 15 level-triggered */
+}
+
+static void __init
 ibm43p_pci_map_non0(struct pci_dev *dev)
 {
 	unsigned char intpin;
@@ -1021,11 +1134,13 @@
 		return;
 	}

-	/* Set up mapping from slots */
-	for (i = 1;  i <= 4;  i++)
-		ibc_pirq[i-1] = Motherboard_routes[i];
-	/* Enable PCI interrupts */
-	*ibc_pcicon |= 0x20;
+ 	if (Motherboard_routes) { /* Doral does not like this code */
+	        /* Set up mapping from slots */
+	        for (i = 1;  i <= 4;  i++)
+		        ibc_pirq[i-1] = Motherboard_routes[i];
+		/* Enable PCI interrupts */
+		*ibc_pcicon |= 0x20;
+	}
 }

 void __init
@@ -1269,7 +1384,8 @@
 		hostbridge = residual_find_device(PROCESSORDEVICE, NULL,
 			BridgeController, PCIBridge, -1, 0);
 		if (hostbridge &&
-			hostbridge->DeviceId.Interface == PCIBridgeIndirect) {
+			((hostbridge->DeviceId.Interface == PCIBridgeIndirect) ||
+			 (hostbridge->DeviceId.Interface == PCIBridgeRS6K))) {
 			PnP_TAG_PACKET * pkt;
 			pkt = PnP_find_large_vendor_packet(
 				res->DevicePnPHeap+hostbridge->AllocatedOffset,
diff -Naur linux-2.6.6-orig/arch/ppc/platforms/prep_setup.c linux-2.6.6/arch/ppc/platforms/prep_setup.c
--- linux-2.6.6-orig/arch/ppc/platforms/prep_setup.c	2004-05-09 23:33:13.000000000 -0300
+++ linux-2.6.6/arch/ppc/platforms/prep_setup.c	2004-06-01 19:25:58.000000000 -0300
@@ -80,6 +80,8 @@

 int _prep_type;

+extern void prep_doral_setup_pci(char *irq_edge_mask_lo, char *irq_edge_mask_hi);
+extern void prep_7024e30_setup_pci(char *irq_edge_mask_lo, char *irq_edge_mask_hi);
 extern void prep_sandalfoot_setup_pci(char *irq_edge_mask_lo, char *irq_edge_mask_hi);
 extern void prep_thinkpad_setup_pci(char *irq_edge_mask_lo, char *irq_edge_mask_hi);
 extern void prep_carolina_setup_pci(char *irq_edge_mask_lo, char *irq_edge_mask_hi);
@@ -128,8 +130,8 @@
 /* planar ID values: */
 /* Sandalfoot/Sandalbow (6015/7020) */
 #define PREP_IBM_SANDALFOOT	0xfc
-/* Woodfield, Thinkpad 850/860 (6042/7249) */
-#define PREP_IBM_THINKPAD	0xff /* planar ID unimplemented */
+/* Woodfield, Thinkpad 850/860 (6042/7249), 7043-240 */
+#define PREP_IBM_NO_PLANAR_ID	0xff /* planar ID unimplemented */
 /* PowerSeries 830/850 (6050/6070) */
 #define PREP_IBM_CAROLINA_IDE_0	0xf0
 #define PREP_IBM_CAROLINA_IDE_1	0xf1
@@ -146,6 +148,12 @@
 #define PREP_IBM_TIGER1_180		0xd3
 #define PREP_IBM_TIGER1_xxx		0xd4 /* unknown, but probably exists */
 #define PREP_IBM_TIGER1_333		0xd5 /* missing from Tiger Tech Spec */
+/* 7024-E30 */
+#define PREP_IBM_7024E30		0x95
+
+/* Residual data model strings */
+#define PREP_IBM_MODEL_TIGER1	"IBM Model 7042/7043 (ED)"
+#define PREP_IBM_MODEL_DORAL	"IBM PPS Model 7043 (ED)"

 /* setup_ibm_pci:
  * 	set Motherboard_map_name, Motherboard_map, Motherboard_routes.
@@ -715,11 +723,26 @@
 				ppc_md.power_off = prep_sig750_poweroff;
 				ppc_md.show_cpuinfo = prep_sandalfoot_cpuinfo;
 				break;
-			case PREP_IBM_THINKPAD:
-				prep_gen_enable_l2();
-				setup_ibm_pci = prep_thinkpad_setup_pci;
-				ppc_md.power_off = prep_carrera_poweroff;
-				ppc_md.show_cpuinfo = prep_thinkpad_cpuinfo;
+			case PREP_IBM_NO_PLANAR_ID:
+#ifdef CONFIG_PREP_RESIDUAL
+				if (res &&
+				    strcmp(res->VitalProductData.PrintableModel,
+					    PREP_IBM_MODEL_DORAL) == 0) {
+					prep_carolina_enable_l2();
+					setup_ibm_pci = prep_doral_setup_pci;
+					ppc_md.power_off = prep_sig750_poweroff;
+					ppc_md.show_cpuinfo = prep_tiger1_cpuinfo;
+				}
+				else {
+#else /* !CONFIG_PREP_RESIDUAL */
+				{
+#endif /* CONFIG_PREP_RESIDUAL */
+					/* Assume it is a thinkpad */
+					prep_gen_enable_l2();
+					setup_ibm_pci = prep_thinkpad_setup_pci;
+					ppc_md.power_off = prep_carrera_poweroff;
+					ppc_md.show_cpuinfo = prep_thinkpad_cpuinfo;
+				}
 				break;
 			default:
 				printk(" -- unknown! Assuming Carolina");
@@ -748,6 +771,12 @@
 				ppc_md.show_cpuinfo = prep_tiger1_cpuinfo;
 				ppc_md.progress = prep_tiger1_progress;
 				break;
+			case PREP_IBM_7024E30:
+				prep_carolina_enable_l2();
+				setup_ibm_pci = prep_7024e30_setup_pci;
+				ppc_md.power_off = prep_sig750_poweroff;
+				ppc_md.show_cpuinfo = prep_carolina_cpuinfo;
+				break;
 		}
 		printk("\n");


--Boundary-00=_VfNxA/DHSlowuou
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

=2D----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello,

	Attached are 2 patches to add support for rs/6000 E30 and 240 (Doral) PPC =
32=20
bits PReP machines.
	These patches are not mine, I just adapted a patch from 2.4.19 to 2.4.26 a=
nd=20
2.6.6. I found that patch at:=20
			http://home.tiscali.be/philipa/rs6000.html
	Original patch is from Leigh Brown.

	I know these machines are quite old, but I found out that they're common i=
n=20
Universities here in Brazil due some partnership, maybe they're in other po=
or=20
countries, so please look at integrating them :)

=2D --=20
Gustavo Sverzut Barbieri
=2D ---------------------------------------
Engenharia de Computacao 2001 - UNICAMP
LTC - Linux Technology Center  - IBM / Brazil
Jabber: gsbarbieri@jabber.org
  ICQ#: 17249123
   GPG: 0xB640E1A2 @ wwwkeys.pgp.net
=2D----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAxNfX66YP4bZA4aIRAgDRAJ9HiVQw5j0Cmo16drQbVRHEoahdmwCfYDS1
8QtCs+oAWcbuJewDOo2o+/M=3D
=3DWzyE
=2D----END PGP SIGNATURE-----

--Boundary-00=_VfNxA/DHSlowuou
Content-Type: text/x-diff;
  charset="us-ascii";
  name="linux-2.4.26-rs6000_e30.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="linux-2.4.26-rs6000_e30.diff"

diff -Naur linux-2.4.26-old/arch/ppc/platforms/prep_pci.c linux-2.4.26/arch/ppc/platforms/prep_pci.c
--- linux-2.4.26-old/arch/ppc/platforms/prep_pci.c	2004-02-18 10:36:30.000000000 -0300
+++ linux-2.4.26/arch/ppc/platforms/prep_pci.c	2004-06-01 21:35:39.000000000 -0300
@@ -547,6 +547,74 @@
         15,     /* Line 4 */
 };

+/*
+ * IBM RS/6000 7043-240  -- Leigh Brown
+ * XXX we should get all this from the residual data
+ */
+static char ibm_doral_pci_IRQ_map[23] __prepdata = {
+        0, /* Slot 0  - unused */
+        3, /* Slot 1  - PCI Slot 1 device 0x08 */
+        5, /* Slot 2  - PCI Slot 3 device 0x10 */
+       11, /* Slot 3  - PCI Slot 5 device 0x18 */
+        2, /* Slot 4  - Integrated PCI device 0x20 */
+        1, /* Slot 5  - Integrated PCI device 0x28 */
+        0, /* Slot 6  - Integrated PCI device 0x30 - no IRQ */
+        0, /* Slot 7  - Integrated PCI device 0x38 - no IRQ */
+        0, /* Slot 8  - unused */
+        0, /* Slot 9  - unused */
+        0, /* Slot 10 - unused */
+        0, /* Slot 11 - unused */
+        0, /* Slot 12 - unused */
+        0, /* Slot 13 - unused */
+        0, /* Slot 14 - unused */
+        0, /* Slot 15 - unused */
+        0, /* Slot 16 - unused */
+        0, /* Slot 17 - unused */
+        0, /* Slot 18 - unused */
+        0, /* Slot 19 - unused */
+        0, /* Slot 20 - unused */
+        0, /* Slot 21 - unused */
+        0, /* Slot 22 - unused */
+};
+
+/*
+ * IBM RS/6000 7024-E30  -- Leigh Brown
+ * XXX we should get all this from the residual data
+ */
+static char ibm_7024e30_pci_IRQ_map[23] __prepdata = {
+        0, /* Slot 0  - unused */
+        0, /* Slot 1  - unused */
+        0, /* Slot 2  - unused */
+        0, /* Slot 3  - unused */
+        0, /* Slot 4  - unused */
+        0, /* Slot 5  - unused */
+        0, /* Slot 6  - unused */
+        0, /* Slot 7  - unused */
+        0, /* Slot 8  - unused */
+        0, /* Slot 9  - unused */
+        0, /* Slot 10 - unused */
+        0, /* Slot 11 - Unknown Integrated PCI device - no IRQ */
+        0, /* Slot 12 - Unknown Integrated PCI device - no IRQ */
+        0, /* Slot 13 - Unknown Integrated PCI device - no IRQ */
+        2, /* Slot 14 - PCI Slot 1 INTA and INTC */
+        4, /* Slot 15 - PCI Slot 2 INTA and INTC */
+        0, /* Slot 16 - unused */
+        0, /* Slot 17 - unused */
+        0, /* Slot 18 - unused */
+        0, /* Slot 19 - unused */
+        0, /* Slot 20 - unused */
+        0, /* Slot 21 - unused */
+        0, /* Slot 22 - unused */
+};
+
+static char ibm_7024e30_pci_IRQ_routes[] __prepdata = {
+        0,      /* Line 0 - unused */
+        15,     /* Line 1 */
+        15,     /* Line 2 */
+        15,     /* Line 3 */
+        15,     /* Line 4 */
+};
+
 /* Motorola PowerPlus architecture PCI IRQ tables */
 /* Interrupt line values for INTA-D on primary/secondary MPIC inputs */

@@ -869,6 +937,28 @@
 	pci_write_config_byte(dev, PCI_INTERRUPT_LINE, dev->irq);
 }

+static void __init
+ibm_7024e30_pci_map_non0(struct pci_dev *dev)
+{
+	unsigned char intpin;
+	int irq;
+	static unsigned char bridge_intrs[5][4] = {
+		{ 1, 0, 0, 0 },
+		{ 8, 9, 8, 9 },
+		{ 10, 11, 10, 11 },
+		{ 12, 13, 12, 13 }
+	};
+
+	if (dev == NULL || PCI_SLOT(dev->devfn) > 4)
+		return;
+	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &intpin);
+	if (intpin < 1 || intpin > 4)
+		return;
+	irq = bridge_intrs[PCI_SLOT(dev->devfn)][intpin - 1];
+	dev->irq = openpic_to_irq(irq);
+	pci_write_config_byte(dev, PCI_INTERRUPT_LINE, dev->irq);
+}
+
 void __init
 prep_sandalfoot_setup_pci(char *irq_edge_mask_lo, char *irq_edge_mask_hi)
 {
@@ -911,6 +1001,28 @@
 }

 void __init
+prep_doral_setup_pci(char *irq_edge_mask_lo, char *irq_edge_mask_hi)
+{
+	Motherboard_map_name = "IBM 7043-240 (Doral)";
+	Motherboard_map = ibm_doral_pci_IRQ_map;
+	Motherboard_routes = NULL;
+	Motherboard_non0 = NULL;
+	*irq_edge_mask_lo = 0x00; /* irq's 0-7 all edge-triggered */
+	*irq_edge_mask_hi = 0xA0; /* irq's 13, 15 level-triggered */
+}
+
+void __init
+prep_7024e30_setup_pci(char *irq_edge_mask_lo, char *irq_edge_mask_hi)
+{
+	Motherboard_map_name = "IBM 7024-E30";
+	Motherboard_map = ibm_7024e30_pci_IRQ_map;
+	Motherboard_routes = ibm_7024e30_pci_IRQ_routes;
+	Motherboard_non0 = ibm_7024e30_pci_map_non0;
+	*irq_edge_mask_lo = 0x00; /* irq's 0-7 all edge-triggered */
+	*irq_edge_mask_hi = 0xA0; /* irq's 13, 15 level-triggered */
+}
+
+void __init
 prep_route_pci_interrupts(void)
 {
 	unsigned char *ibc_pirq = (unsigned char *)0x80800860;
@@ -990,11 +1102,13 @@
 		return;
 	}

-	/* Set up mapping from slots */
-	for (i = 1;  i <= 4;  i++)
-		ibc_pirq[i-1] = Motherboard_routes[i];
-	/* Enable PCI interrupts */
-	*ibc_pcicon |= 0x20;
+ 	if (Motherboard_routes) { /* Doral does not like this code */
+	        /* Set up mapping from slots */
+	        for (i = 1;  i <= 4;  i++)
+		        ibc_pirq[i-1] = Motherboard_routes[i];
+		/* Enable PCI interrupts */
+		*ibc_pcicon |= 0x20;
+	}
 }

 void __init
@@ -1268,7 +1382,8 @@
 		hostbridge = residual_find_device(PROCESSORDEVICE, NULL,
 			BridgeController, PCIBridge, -1, 0);
 		if (hostbridge &&
-			hostbridge->DeviceId.Interface == PCIBridgeIndirect) {
+			((hostbridge->DeviceId.Interface == PCIBridgeIndirect) ||
+			 (hostbridge->DeviceId.Interface == PCIBridgeRS6K))) {
 			PnP_TAG_PACKET * pkt;
 			pkt = PnP_find_large_vendor_packet(
 				res->DevicePnPHeap+hostbridge->AllocatedOffset,
diff -Naur linux-2.4.26-old/arch/ppc/platforms/prep_setup.c linux-2.4.26/arch/ppc/platforms/prep_setup.c
--- linux-2.4.26-old/arch/ppc/platforms/prep_setup.c	2003-08-25 08:44:40.000000000 -0300
+++ linux-2.4.26/arch/ppc/platforms/prep_setup.c	2004-06-01 21:35:39.000000000 -0300
@@ -94,6 +94,8 @@
 extern void prep_thinkpad_setup_pci(char *irq_edge_mask_lo, char *irq_edge_mask_hi);
 extern void prep_carolina_setup_pci(char *irq_edge_mask_lo, char *irq_edge_mask_hi);
 extern void prep_tiger1_setup_pci(char *irq_edge_mask_lo, char *irq_edge_mask_hi);
+extern void prep_doral_setup_pci(char *irq_edge_mask_lo, char *irq_edge_mask_hi);
+extern void prep_7024e30_setup_pci(char *irq_edge_mask_lo, char *irq_edge_mask_hi);


 #define cached_21	(((char *)(ppc_cached_irq_mask))[3])
@@ -137,8 +139,8 @@
 /* planar ID values: */
 /* Sandalfoot/Sandalbow (6015/7020) */
 #define PREP_IBM_SANDALFOOT	0xfc
-/* Woodfield, Thinkpad 850/860 (6042/7249) */
-#define PREP_IBM_THINKPAD	0xff /* planar ID unimplemented */
+/* Woodfield, Thinkpad 850/860 (6042/7249), 7043-240 */
+#define PREP_IBM_NO_PLANAR_ID		0xff /* planar ID unimplemented */
 /* PowerSeries 830/850 (6050/6070) */
 #define PREP_IBM_CAROLINA_IDE_0	0xf0
 #define PREP_IBM_CAROLINA_IDE_1	0xf1
@@ -154,6 +156,12 @@
 #define PREP_IBM_TIGER1_180		0xd3
 #define PREP_IBM_TIGER1_xxx		0xd4 /* unknown, but probably exists */
 #define PREP_IBM_TIGER1_333		0xd5 /* missing from Tiger Tech Spec */
+/* 7024-E30 */
+#define PREP_IBM_7024E30		0x95
+
+/* Residual data model strings */
+#define PREP_IBM_MODEL_TIGER1	"IBM Model 7042/7043 (ED)"
+#define PREP_IBM_MODEL_DORAL	"IBM PPS Model 7043 (ED)"

 /* setup_ibm_pci:
  * 	set Motherboard_map_name, Motherboard_map, Motherboard_routes.
@@ -722,11 +730,26 @@
 				ppc_md.power_off = prep_sig750_poweroff;
 				ppc_md.show_cpuinfo = prep_sandalfoot_cpuinfo;
 				break;
-			case PREP_IBM_THINKPAD:
-				prep_gen_enable_l2();
-				setup_ibm_pci = prep_thinkpad_setup_pci;
-				ppc_md.power_off = prep_carrera_poweroff;
-				ppc_md.show_cpuinfo = prep_thinkpad_cpuinfo;
+			case PREP_IBM_NO_PLANAR_ID:
+#ifdef CONFIG_PREP_RESIDUAL
+				if (res &&
+				    strcmp(res->VitalProductData.PrintableModel,
+					    PREP_IBM_MODEL_DORAL) == 0) {
+					prep_carolina_enable_l2();
+					setup_ibm_pci = prep_doral_setup_pci;
+					ppc_md.power_off = prep_sig750_poweroff;
+					ppc_md.show_cpuinfo = prep_tiger1_cpuinfo;
+				}
+				else {
+#else /* !CONFIG_PREP_RESIDUAL */
+				{
+#endif /* CONFIG_PREP_RESIDUAL */
+					/* Assume it is a thinkpad */
+					prep_gen_enable_l2();
+					setup_ibm_pci = prep_thinkpad_setup_pci;
+					ppc_md.power_off = prep_carrera_poweroff;
+					ppc_md.show_cpuinfo = prep_thinkpad_cpuinfo;
+				}
 				break;
 			default:
 				printk(" -- unknown! Assuming Carolina");
@@ -753,6 +776,12 @@
 				ppc_md.power_off = prep_sig750_poweroff;
 				ppc_md.show_cpuinfo = prep_tiger1_cpuinfo;
 				break;
+			case PREP_IBM_7024E30:
+				prep_carolina_enable_l2();
+				setup_ibm_pci = prep_7024e30_setup_pci;
+				ppc_md.power_off = prep_sig750_poweroff;
+				ppc_md.show_cpuinfo = prep_carolina_cpuinfo;
+				break;
 		}
 		printk("\n");


--Boundary-00=_VfNxA/DHSlowuou
Content-Type: text/x-diff;
  charset="us-ascii";
  name="linux-2.6.6-rs6000_e30.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="linux-2.6.6-rs6000_e30.diff"

diff -Naur linux-2.6.6-orig/arch/ppc/platforms/prep_pci.c linux-2.6.6/arch/ppc/platforms/prep_pci.c
--- linux-2.6.6-orig/arch/ppc/platforms/prep_pci.c	2004-05-09 23:33:20.000000000 -0300
+++ linux-2.6.6/arch/ppc/platforms/prep_pci.c	2004-06-01 19:06:41.000000000 -0300
@@ -42,6 +42,75 @@

 /* Tables for known hardware */

+/*
+ * IBM RS/6000 7043-240  -- Leigh Brown
+ * XXX we should get all this from the residual data
+ */
+static char ibm_doral_pci_IRQ_map[23] __prepdata = {
+        0, /* Slot 0  - unused */
+        3, /* Slot 1  - PCI Slot 1 device 0x08 */
+        5, /* Slot 2  - PCI Slot 3 device 0x10 */
+       11, /* Slot 3  - PCI Slot 5 device 0x18 */
+        2, /* Slot 4  - Integrated PCI device 0x20 */
+        1, /* Slot 5  - Integrated PCI device 0x28 */
+        0, /* Slot 6  - Integrated PCI device 0x30 - no IRQ */
+        0, /* Slot 7  - Integrated PCI device 0x38 - no IRQ */
+        0, /* Slot 8  - unused */
+        0, /* Slot 9  - unused */
+        0, /* Slot 10 - unused */
+        0, /* Slot 11 - unused */
+        0, /* Slot 12 - unused */
+        0, /* Slot 13 - unused */
+        0, /* Slot 14 - unused */
+        0, /* Slot 15 - unused */
+        0, /* Slot 16 - unused */
+        0, /* Slot 17 - unused */
+        0, /* Slot 18 - unused */
+        0, /* Slot 19 - unused */
+        0, /* Slot 20 - unused */
+        0, /* Slot 21 - unused */
+        0, /* Slot 22 - unused */
+};
+
+/*
+ * IBM RS/6000 7024-E30  -- Leigh Brown
+ * XXX we should get all this from the residual data
+ */
+static char ibm_7024e30_pci_IRQ_map[23] __prepdata = {
+        0, /* Slot 0  - unused */
+        0, /* Slot 1  - unused */
+        0, /* Slot 2  - unused */
+        0, /* Slot 3  - unused */
+        0, /* Slot 4  - unused */
+        0, /* Slot 5  - unused */
+        0, /* Slot 6  - unused */
+        0, /* Slot 7  - unused */
+        0, /* Slot 8  - unused */
+        0, /* Slot 9  - unused */
+        0, /* Slot 10 - unused */
+        0, /* Slot 11 - Unknown Integrated PCI device - no IRQ */
+        0, /* Slot 12 - Unknown Integrated PCI device - no IRQ */
+        0, /* Slot 13 - Unknown Integrated PCI device - no IRQ */
+        2, /* Slot 14 - PCI Slot 1 INTA and INTC */
+        4, /* Slot 15 - PCI Slot 2 INTA and INTC */
+        0, /* Slot 16 - unused */
+        0, /* Slot 17 - unused */
+        0, /* Slot 18 - unused */
+        0, /* Slot 19 - unused */
+        0, /* Slot 20 - unused */
+        0, /* Slot 21 - unused */
+        0, /* Slot 22 - unused */
+};
+
+static char ibm_7024e30_pci_IRQ_routes[] __prepdata = {
+        0,      /* Line 0 - unused */
+        15,     /* Line 1 */
+        15,     /* Line 2 */
+        15,     /* Line 3 */
+        15,     /* Line 4 */
+};
+
+
 /* Motorola PowerStackII - Utah */
 static char Utah_pci_IRQ_map[23] __prepdata =
 {
@@ -885,6 +954,50 @@
 }

 static void __init
+ibm_7024e30_pci_map_non0(struct pci_dev *dev)
+{
+	unsigned char intpin;
+	int irq;
+	static unsigned char bridge_intrs[5][4] = {
+		{ 1, 0, 0, 0 },
+		{ 8, 9, 8, 9 },
+		{ 10, 11, 10, 11 },
+		{ 12, 13, 12, 13 }
+	};
+
+	if (dev == NULL || PCI_SLOT(dev->devfn) > 4)
+		return;
+	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &intpin);
+	if (intpin < 1 || intpin > 4)
+		return;
+	irq = bridge_intrs[PCI_SLOT(dev->devfn)][intpin - 1];
+	dev->irq = openpic_to_irq(irq);
+	pci_write_config_byte(dev, PCI_INTERRUPT_LINE, dev->irq);
+}
+
+void __init
+prep_doral_setup_pci(char *irq_edge_mask_lo, char *irq_edge_mask_hi)
+{
+	Motherboard_map_name = "IBM 7043-240 (Doral)";
+	Motherboard_map = ibm_doral_pci_IRQ_map;
+	Motherboard_routes = NULL;
+	Motherboard_non0 = NULL;
+	*irq_edge_mask_lo = 0x00; /* irq's 0-7 all edge-triggered */
+	*irq_edge_mask_hi = 0xA0; /* irq's 13, 15 level-triggered */
+}
+
+void __init
+prep_7024e30_setup_pci(char *irq_edge_mask_lo, char *irq_edge_mask_hi)
+{
+	Motherboard_map_name = "IBM 7024-E30";
+	Motherboard_map = ibm_7024e30_pci_IRQ_map;
+	Motherboard_routes = ibm_7024e30_pci_IRQ_routes;
+	Motherboard_non0 = ibm_7024e30_pci_map_non0;
+	*irq_edge_mask_lo = 0x00; /* irq's 0-7 all edge-triggered */
+	*irq_edge_mask_hi = 0xA0; /* irq's 13, 15 level-triggered */
+}
+
+static void __init
 ibm43p_pci_map_non0(struct pci_dev *dev)
 {
 	unsigned char intpin;
@@ -1021,11 +1134,13 @@
 		return;
 	}

-	/* Set up mapping from slots */
-	for (i = 1;  i <= 4;  i++)
-		ibc_pirq[i-1] = Motherboard_routes[i];
-	/* Enable PCI interrupts */
-	*ibc_pcicon |= 0x20;
+ 	if (Motherboard_routes) { /* Doral does not like this code */
+	        /* Set up mapping from slots */
+	        for (i = 1;  i <= 4;  i++)
+		        ibc_pirq[i-1] = Motherboard_routes[i];
+		/* Enable PCI interrupts */
+		*ibc_pcicon |= 0x20;
+	}
 }

 void __init
@@ -1269,7 +1384,8 @@
 		hostbridge = residual_find_device(PROCESSORDEVICE, NULL,
 			BridgeController, PCIBridge, -1, 0);
 		if (hostbridge &&
-			hostbridge->DeviceId.Interface == PCIBridgeIndirect) {
+			((hostbridge->DeviceId.Interface == PCIBridgeIndirect) ||
+			 (hostbridge->DeviceId.Interface == PCIBridgeRS6K))) {
 			PnP_TAG_PACKET * pkt;
 			pkt = PnP_find_large_vendor_packet(
 				res->DevicePnPHeap+hostbridge->AllocatedOffset,
diff -Naur linux-2.6.6-orig/arch/ppc/platforms/prep_setup.c linux-2.6.6/arch/ppc/platforms/prep_setup.c
--- linux-2.6.6-orig/arch/ppc/platforms/prep_setup.c	2004-05-09 23:33:13.000000000 -0300
+++ linux-2.6.6/arch/ppc/platforms/prep_setup.c	2004-06-01 19:25:58.000000000 -0300
@@ -80,6 +80,8 @@

 int _prep_type;

+extern void prep_doral_setup_pci(char *irq_edge_mask_lo, char *irq_edge_mask_hi);
+extern void prep_7024e30_setup_pci(char *irq_edge_mask_lo, char *irq_edge_mask_hi);
 extern void prep_sandalfoot_setup_pci(char *irq_edge_mask_lo, char *irq_edge_mask_hi);
 extern void prep_thinkpad_setup_pci(char *irq_edge_mask_lo, char *irq_edge_mask_hi);
 extern void prep_carolina_setup_pci(char *irq_edge_mask_lo, char *irq_edge_mask_hi);
@@ -128,8 +130,8 @@
 /* planar ID values: */
 /* Sandalfoot/Sandalbow (6015/7020) */
 #define PREP_IBM_SANDALFOOT	0xfc
-/* Woodfield, Thinkpad 850/860 (6042/7249) */
-#define PREP_IBM_THINKPAD	0xff /* planar ID unimplemented */
+/* Woodfield, Thinkpad 850/860 (6042/7249), 7043-240 */
+#define PREP_IBM_NO_PLANAR_ID	0xff /* planar ID unimplemented */
 /* PowerSeries 830/850 (6050/6070) */
 #define PREP_IBM_CAROLINA_IDE_0	0xf0
 #define PREP_IBM_CAROLINA_IDE_1	0xf1
@@ -146,6 +148,12 @@
 #define PREP_IBM_TIGER1_180		0xd3
 #define PREP_IBM_TIGER1_xxx		0xd4 /* unknown, but probably exists */
 #define PREP_IBM_TIGER1_333		0xd5 /* missing from Tiger Tech Spec */
+/* 7024-E30 */
+#define PREP_IBM_7024E30		0x95
+
+/* Residual data model strings */
+#define PREP_IBM_MODEL_TIGER1	"IBM Model 7042/7043 (ED)"
+#define PREP_IBM_MODEL_DORAL	"IBM PPS Model 7043 (ED)"

 /* setup_ibm_pci:
  * 	set Motherboard_map_name, Motherboard_map, Motherboard_routes.
@@ -715,11 +723,26 @@
 				ppc_md.power_off = prep_sig750_poweroff;
 				ppc_md.show_cpuinfo = prep_sandalfoot_cpuinfo;
 				break;
-			case PREP_IBM_THINKPAD:
-				prep_gen_enable_l2();
-				setup_ibm_pci = prep_thinkpad_setup_pci;
-				ppc_md.power_off = prep_carrera_poweroff;
-				ppc_md.show_cpuinfo = prep_thinkpad_cpuinfo;
+			case PREP_IBM_NO_PLANAR_ID:
+#ifdef CONFIG_PREP_RESIDUAL
+				if (res &&
+				    strcmp(res->VitalProductData.PrintableModel,
+					    PREP_IBM_MODEL_DORAL) == 0) {
+					prep_carolina_enable_l2();
+					setup_ibm_pci = prep_doral_setup_pci;
+					ppc_md.power_off = prep_sig750_poweroff;
+					ppc_md.show_cpuinfo = prep_tiger1_cpuinfo;
+				}
+				else {
+#else /* !CONFIG_PREP_RESIDUAL */
+				{
+#endif /* CONFIG_PREP_RESIDUAL */
+					/* Assume it is a thinkpad */
+					prep_gen_enable_l2();
+					setup_ibm_pci = prep_thinkpad_setup_pci;
+					ppc_md.power_off = prep_carrera_poweroff;
+					ppc_md.show_cpuinfo = prep_thinkpad_cpuinfo;
+				}
 				break;
 			default:
 				printk(" -- unknown! Assuming Carolina");
@@ -748,6 +771,12 @@
 				ppc_md.show_cpuinfo = prep_tiger1_cpuinfo;
 				ppc_md.progress = prep_tiger1_progress;
 				break;
+			case PREP_IBM_7024E30:
+				prep_carolina_enable_l2();
+				setup_ibm_pci = prep_7024e30_setup_pci;
+				ppc_md.power_off = prep_sig750_poweroff;
+				ppc_md.show_cpuinfo = prep_carolina_cpuinfo;
+				break;
 		}
 		printk("\n");


--Boundary-00=_VfNxA/DHSlowuou--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
