Message-ID: <9ef20ef304071314244a31a27@mail.gmail.com>
Date: Tue, 13 Jul 2004 18:24:13 -0300
From: Gustavo Barbieri <barbieri@gmail.com>
To: debian-boot@lists.debian.org, debian-powerpc@lists.debian.org,
	anton@samba.org, paulus@samba.org, linuxppc-dev@lists.linuxppc.org
Subject: rs/6000 e30 + 240 (doral) support.
Cc: Gustavo Barbieri <barbieri@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_313_20063767.1089753853348"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


------=_Part_313_20063767.1089753853348
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,

Here are 2 patches to make linux support the old IBM RS/6000 E30
(ppc604e) and 240 (doral). The support was written by Leigh Brown and
adapted from the patch present in the website:
http://home.tiscali.be/philipa/rs6000.html

These machines are old, but usable nowadays. Here in brazil we have
many universities with them, since they were distributed to some
projects between 1999-2001.

These patches are not invasive and easily portable to other kernel
versions... so I hope you all will try to support it.

PS: I'm not subscribed to the lists, so please CC me.

--
Gustavo Sverzut Barbieri
---------------------------------------
Computer Engineer 2001 - UNICAMP
GPSL - Grupo Pro Software Livre
Cell..: +55 (19) 9165 8010
Jabber: gsbarbieri@jabber.org
  ICQ#: 17249123
   GPG: 0xB640E1A2 @ wwwkeys.pgp.net

------=_Part_313_20063767.1089753853348
Content-Type: text/x-patch; name="linux-2.4.26-rs6000_e30.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="linux-2.4.26-rs6000_e30.diff"

diff -Naur linux-2.4.26-old/arch/ppc/platforms/prep_pci.c linux-2.4.26/arch=
/ppc/platforms/prep_pci.c
--- linux-2.4.26-old/arch/ppc/platforms/prep_pci.c=092004-02-18 10:36:30.00=
0000000 -0300
+++ linux-2.4.26/arch/ppc/platforms/prep_pci.c=092004-06-01 21:35:39.000000=
000 -0300
@@ -547,6 +547,74 @@
         15,     /* Line 4 */
 };
=20
+/*
+ * IBM RS/6000 7043-240  -- Leigh Brown
+ * XXX we should get all this from the residual data
+ */
+static char ibm_doral_pci_IRQ_map[23] __prepdata =3D {
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
+static char ibm_7024e30_pci_IRQ_map[23] __prepdata =3D {
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
+static char ibm_7024e30_pci_IRQ_routes[] __prepdata =3D {
+        0,      /* Line 0 - unused */
+        15,     /* Line 1 */
+        15,     /* Line 2 */
+        15,     /* Line 3 */
+        15,     /* Line 4 */
+};
+
 /* Motorola PowerPlus architecture PCI IRQ tables */
 /* Interrupt line values for INTA-D on primary/secondary MPIC inputs */
=20
@@ -869,6 +937,28 @@
 =09pci_write_config_byte(dev, PCI_INTERRUPT_LINE, dev->irq);
 }
=20
+static void __init
+ibm_7024e30_pci_map_non0(struct pci_dev *dev)
+{
+=09unsigned char intpin;
+=09int irq;
+=09static unsigned char bridge_intrs[5][4] =3D {
+=09=09{ 1, 0, 0, 0 },
+=09=09{ 8, 9, 8, 9 },
+=09=09{ 10, 11, 10, 11 },
+=09=09{ 12, 13, 12, 13 }
+=09};
+
+=09if (dev =3D=3D NULL || PCI_SLOT(dev->devfn) > 4)
+=09=09return;
+=09pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &intpin);
+=09if (intpin < 1 || intpin > 4)
+=09=09return;
+=09irq =3D bridge_intrs[PCI_SLOT(dev->devfn)][intpin - 1];
+=09dev->irq =3D openpic_to_irq(irq);
+=09pci_write_config_byte(dev, PCI_INTERRUPT_LINE, dev->irq);
+}
+
 void __init
 prep_sandalfoot_setup_pci(char *irq_edge_mask_lo, char *irq_edge_mask_hi)
 {
@@ -911,6 +1001,28 @@
 }
=20
 void __init
+prep_doral_setup_pci(char *irq_edge_mask_lo, char *irq_edge_mask_hi)
+{
+=09Motherboard_map_name =3D "IBM 7043-240 (Doral)";
+=09Motherboard_map =3D ibm_doral_pci_IRQ_map;
+=09Motherboard_routes =3D NULL;
+=09Motherboard_non0 =3D NULL;
+=09*irq_edge_mask_lo =3D 0x00; /* irq's 0-7 all edge-triggered */
+=09*irq_edge_mask_hi =3D 0xA0; /* irq's 13, 15 level-triggered */
+}
+
+void __init
+prep_7024e30_setup_pci(char *irq_edge_mask_lo, char *irq_edge_mask_hi)
+{
+=09Motherboard_map_name =3D "IBM 7024-E30";
+=09Motherboard_map =3D ibm_7024e30_pci_IRQ_map;
+=09Motherboard_routes =3D ibm_7024e30_pci_IRQ_routes;
+=09Motherboard_non0 =3D ibm_7024e30_pci_map_non0;
+=09*irq_edge_mask_lo =3D 0x00; /* irq's 0-7 all edge-triggered */
+=09*irq_edge_mask_hi =3D 0xA0; /* irq's 13, 15 level-triggered */
+}
+
+void __init
 prep_route_pci_interrupts(void)
 {
 =09unsigned char *ibc_pirq =3D (unsigned char *)0x80800860;
@@ -990,11 +1102,13 @@
 =09=09return;
 =09}
=20
-=09/* Set up mapping from slots */
-=09for (i =3D 1;  i <=3D 4;  i++)
-=09=09ibc_pirq[i-1] =3D Motherboard_routes[i];
-=09/* Enable PCI interrupts */
-=09*ibc_pcicon |=3D 0x20;
+ =09if (Motherboard_routes) { /* Doral does not like this code */
+=09        /* Set up mapping from slots */
+=09        for (i =3D 1;  i <=3D 4;  i++)
+=09=09        ibc_pirq[i-1] =3D Motherboard_routes[i];
+=09=09/* Enable PCI interrupts */
+=09=09*ibc_pcicon |=3D 0x20;
+=09}
 }
=20
 void __init
@@ -1268,7 +1382,8 @@
 =09=09hostbridge =3D residual_find_device(PROCESSORDEVICE, NULL,
 =09=09=09BridgeController, PCIBridge, -1, 0);
 =09=09if (hostbridge &&
-=09=09=09hostbridge->DeviceId.Interface =3D=3D PCIBridgeIndirect) {
+=09=09=09((hostbridge->DeviceId.Interface =3D=3D PCIBridgeIndirect) ||
+=09=09=09 (hostbridge->DeviceId.Interface =3D=3D PCIBridgeRS6K))) {
 =09=09=09PnP_TAG_PACKET * pkt;
 =09=09=09pkt =3D PnP_find_large_vendor_packet(
 =09=09=09=09res->DevicePnPHeap+hostbridge->AllocatedOffset,
diff -Naur linux-2.4.26-old/arch/ppc/platforms/prep_setup.c linux-2.4.26/ar=
ch/ppc/platforms/prep_setup.c
--- linux-2.4.26-old/arch/ppc/platforms/prep_setup.c=092003-08-25 08:44:40.=
000000000 -0300
+++ linux-2.4.26/arch/ppc/platforms/prep_setup.c=092004-06-01 21:35:39.0000=
00000 -0300
@@ -94,6 +94,8 @@
 extern void prep_thinkpad_setup_pci(char *irq_edge_mask_lo, char *irq_edge=
_mask_hi);
 extern void prep_carolina_setup_pci(char *irq_edge_mask_lo, char *irq_edge=
_mask_hi);
 extern void prep_tiger1_setup_pci(char *irq_edge_mask_lo, char *irq_edge_m=
ask_hi);
+extern void prep_doral_setup_pci(char *irq_edge_mask_lo, char *irq_edge_ma=
sk_hi);
+extern void prep_7024e30_setup_pci(char *irq_edge_mask_lo, char *irq_edge_=
mask_hi);
=20
=20
 #define cached_21=09(((char *)(ppc_cached_irq_mask))[3])
@@ -137,8 +139,8 @@
 /* planar ID values: */
 /* Sandalfoot/Sandalbow (6015/7020) */
 #define PREP_IBM_SANDALFOOT=090xfc
-/* Woodfield, Thinkpad 850/860 (6042/7249) */
-#define PREP_IBM_THINKPAD=090xff /* planar ID unimplemented */
+/* Woodfield, Thinkpad 850/860 (6042/7249), 7043-240 */
+#define PREP_IBM_NO_PLANAR_ID=09=090xff /* planar ID unimplemented */
 /* PowerSeries 830/850 (6050/6070) */
 #define PREP_IBM_CAROLINA_IDE_0=090xf0
 #define PREP_IBM_CAROLINA_IDE_1=090xf1
@@ -154,6 +156,12 @@
 #define PREP_IBM_TIGER1_180=09=090xd3
 #define PREP_IBM_TIGER1_xxx=09=090xd4 /* unknown, but probably exists */
 #define PREP_IBM_TIGER1_333=09=090xd5 /* missing from Tiger Tech Spec */
+/* 7024-E30 */
+#define PREP_IBM_7024E30=09=090x95
+
+/* Residual data model strings */
+#define PREP_IBM_MODEL_TIGER1=09"IBM Model 7042/7043 (ED)"
+#define PREP_IBM_MODEL_DORAL=09"IBM PPS Model 7043 (ED)"
=20
 /* setup_ibm_pci:
  * =09set Motherboard_map_name, Motherboard_map, Motherboard_routes.
@@ -722,11 +730,26 @@
 =09=09=09=09ppc_md.power_off =3D prep_sig750_poweroff;
 =09=09=09=09ppc_md.show_cpuinfo =3D prep_sandalfoot_cpuinfo;
 =09=09=09=09break;
-=09=09=09case PREP_IBM_THINKPAD:
-=09=09=09=09prep_gen_enable_l2();
-=09=09=09=09setup_ibm_pci =3D prep_thinkpad_setup_pci;
-=09=09=09=09ppc_md.power_off =3D prep_carrera_poweroff;
-=09=09=09=09ppc_md.show_cpuinfo =3D prep_thinkpad_cpuinfo;
+=09=09=09case PREP_IBM_NO_PLANAR_ID:
+#ifdef CONFIG_PREP_RESIDUAL
+=09=09=09=09if (res &&
+=09=09=09=09    strcmp(res->VitalProductData.PrintableModel,
+=09=09=09=09=09    PREP_IBM_MODEL_DORAL) =3D=3D 0) {
+=09=09=09=09=09prep_carolina_enable_l2();
+=09=09=09=09=09setup_ibm_pci =3D prep_doral_setup_pci;
+=09=09=09=09=09ppc_md.power_off =3D prep_sig750_poweroff;
+=09=09=09=09=09ppc_md.show_cpuinfo =3D prep_tiger1_cpuinfo;
+=09=09=09=09}
+=09=09=09=09else {
+#else /* !CONFIG_PREP_RESIDUAL */
+=09=09=09=09{
+#endif /* CONFIG_PREP_RESIDUAL */
+=09=09=09=09=09/* Assume it is a thinkpad */
+=09=09=09=09=09prep_gen_enable_l2();
+=09=09=09=09=09setup_ibm_pci =3D prep_thinkpad_setup_pci;
+=09=09=09=09=09ppc_md.power_off =3D prep_carrera_poweroff;
+=09=09=09=09=09ppc_md.show_cpuinfo =3D prep_thinkpad_cpuinfo;
+=09=09=09=09}
 =09=09=09=09break;
 =09=09=09default:
 =09=09=09=09printk(" -- unknown! Assuming Carolina");
@@ -753,6 +776,12 @@
 =09=09=09=09ppc_md.power_off =3D prep_sig750_poweroff;
 =09=09=09=09ppc_md.show_cpuinfo =3D prep_tiger1_cpuinfo;
 =09=09=09=09break;
+=09=09=09case PREP_IBM_7024E30:
+=09=09=09=09prep_carolina_enable_l2();
+=09=09=09=09setup_ibm_pci =3D prep_7024e30_setup_pci;
+=09=09=09=09ppc_md.power_off =3D prep_sig750_poweroff;
+=09=09=09=09ppc_md.show_cpuinfo =3D prep_carolina_cpuinfo;
+=09=09=09=09break;
 =09=09}
 =09=09printk("\n");
=20

------=_Part_313_20063767.1089753853348
Content-Type: text/x-patch; name="linux-2.6.6-rs6000_e30.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="linux-2.6.6-rs6000_e30.diff"

diff -Naur linux-2.6.6-orig/arch/ppc/platforms/prep_pci.c linux-2.6.6/arch/=
ppc/platforms/prep_pci.c
--- linux-2.6.6-orig/arch/ppc/platforms/prep_pci.c=092004-05-09 23:33:20.00=
0000000 -0300
+++ linux-2.6.6/arch/ppc/platforms/prep_pci.c=092004-06-01 19:06:41.0000000=
00 -0300
@@ -42,6 +42,75 @@
=20
 /* Tables for known hardware */
=20
+/*
+ * IBM RS/6000 7043-240  -- Leigh Brown
+ * XXX we should get all this from the residual data
+ */
+static char ibm_doral_pci_IRQ_map[23] __prepdata =3D {
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
+static char ibm_7024e30_pci_IRQ_map[23] __prepdata =3D {
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
+static char ibm_7024e30_pci_IRQ_routes[] __prepdata =3D {
+        0,      /* Line 0 - unused */
+        15,     /* Line 1 */
+        15,     /* Line 2 */
+        15,     /* Line 3 */
+        15,     /* Line 4 */
+};
+
+
 /* Motorola PowerStackII - Utah */
 static char Utah_pci_IRQ_map[23] __prepdata =3D
 {
@@ -885,6 +954,50 @@
 }
=20
 static void __init
+ibm_7024e30_pci_map_non0(struct pci_dev *dev)
+{
+=09unsigned char intpin;
+=09int irq;
+=09static unsigned char bridge_intrs[5][4] =3D {
+=09=09{ 1, 0, 0, 0 },
+=09=09{ 8, 9, 8, 9 },
+=09=09{ 10, 11, 10, 11 },
+=09=09{ 12, 13, 12, 13 }
+=09};
+
+=09if (dev =3D=3D NULL || PCI_SLOT(dev->devfn) > 4)
+=09=09return;
+=09pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &intpin);
+=09if (intpin < 1 || intpin > 4)
+=09=09return;
+=09irq =3D bridge_intrs[PCI_SLOT(dev->devfn)][intpin - 1];
+=09dev->irq =3D openpic_to_irq(irq);
+=09pci_write_config_byte(dev, PCI_INTERRUPT_LINE, dev->irq);
+}
+
+void __init
+prep_doral_setup_pci(char *irq_edge_mask_lo, char *irq_edge_mask_hi)
+{
+=09Motherboard_map_name =3D "IBM 7043-240 (Doral)";
+=09Motherboard_map =3D ibm_doral_pci_IRQ_map;
+=09Motherboard_routes =3D NULL;
+=09Motherboard_non0 =3D NULL;
+=09*irq_edge_mask_lo =3D 0x00; /* irq's 0-7 all edge-triggered */
+=09*irq_edge_mask_hi =3D 0xA0; /* irq's 13, 15 level-triggered */
+}
+
+void __init
+prep_7024e30_setup_pci(char *irq_edge_mask_lo, char *irq_edge_mask_hi)
+{
+=09Motherboard_map_name =3D "IBM 7024-E30";
+=09Motherboard_map =3D ibm_7024e30_pci_IRQ_map;
+=09Motherboard_routes =3D ibm_7024e30_pci_IRQ_routes;
+=09Motherboard_non0 =3D ibm_7024e30_pci_map_non0;
+=09*irq_edge_mask_lo =3D 0x00; /* irq's 0-7 all edge-triggered */
+=09*irq_edge_mask_hi =3D 0xA0; /* irq's 13, 15 level-triggered */
+}
+
+static void __init
 ibm43p_pci_map_non0(struct pci_dev *dev)
 {
 =09unsigned char intpin;
@@ -1021,11 +1134,13 @@
 =09=09return;
 =09}
=20
-=09/* Set up mapping from slots */
-=09for (i =3D 1;  i <=3D 4;  i++)
-=09=09ibc_pirq[i-1] =3D Motherboard_routes[i];
-=09/* Enable PCI interrupts */
-=09*ibc_pcicon |=3D 0x20;
+ =09if (Motherboard_routes) { /* Doral does not like this code */
+=09        /* Set up mapping from slots */
+=09        for (i =3D 1;  i <=3D 4;  i++)
+=09=09        ibc_pirq[i-1] =3D Motherboard_routes[i];
+=09=09/* Enable PCI interrupts */
+=09=09*ibc_pcicon |=3D 0x20;
+=09}
 }
=20
 void __init
@@ -1269,7 +1384,8 @@
 =09=09hostbridge =3D residual_find_device(PROCESSORDEVICE, NULL,
 =09=09=09BridgeController, PCIBridge, -1, 0);
 =09=09if (hostbridge &&
-=09=09=09hostbridge->DeviceId.Interface =3D=3D PCIBridgeIndirect) {
+=09=09=09((hostbridge->DeviceId.Interface =3D=3D PCIBridgeIndirect) ||
+=09=09=09 (hostbridge->DeviceId.Interface =3D=3D PCIBridgeRS6K))) {
 =09=09=09PnP_TAG_PACKET * pkt;
 =09=09=09pkt =3D PnP_find_large_vendor_packet(
 =09=09=09=09res->DevicePnPHeap+hostbridge->AllocatedOffset,
diff -Naur linux-2.6.6-orig/arch/ppc/platforms/prep_setup.c linux-2.6.6/arc=
h/ppc/platforms/prep_setup.c
--- linux-2.6.6-orig/arch/ppc/platforms/prep_setup.c=092004-05-09 23:33:13.=
000000000 -0300
+++ linux-2.6.6/arch/ppc/platforms/prep_setup.c=092004-06-01 19:25:58.00000=
0000 -0300
@@ -80,6 +80,8 @@
=20
 int _prep_type;
=20
+extern void prep_doral_setup_pci(char *irq_edge_mask_lo, char *irq_edge_ma=
sk_hi);
+extern void prep_7024e30_setup_pci(char *irq_edge_mask_lo, char *irq_edge_=
mask_hi);
 extern void prep_sandalfoot_setup_pci(char *irq_edge_mask_lo, char *irq_ed=
ge_mask_hi);
 extern void prep_thinkpad_setup_pci(char *irq_edge_mask_lo, char *irq_edge=
_mask_hi);
 extern void prep_carolina_setup_pci(char *irq_edge_mask_lo, char *irq_edge=
_mask_hi);
@@ -128,8 +130,8 @@
 /* planar ID values: */
 /* Sandalfoot/Sandalbow (6015/7020) */
 #define PREP_IBM_SANDALFOOT=090xfc
-/* Woodfield, Thinkpad 850/860 (6042/7249) */
-#define PREP_IBM_THINKPAD=090xff /* planar ID unimplemented */
+/* Woodfield, Thinkpad 850/860 (6042/7249), 7043-240 */
+#define PREP_IBM_NO_PLANAR_ID=090xff /* planar ID unimplemented */
 /* PowerSeries 830/850 (6050/6070) */
 #define PREP_IBM_CAROLINA_IDE_0=090xf0
 #define PREP_IBM_CAROLINA_IDE_1=090xf1
@@ -146,6 +148,12 @@
 #define PREP_IBM_TIGER1_180=09=090xd3
 #define PREP_IBM_TIGER1_xxx=09=090xd4 /* unknown, but probably exists */
 #define PREP_IBM_TIGER1_333=09=090xd5 /* missing from Tiger Tech Spec */
+/* 7024-E30 */
+#define PREP_IBM_7024E30=09=090x95
+
+/* Residual data model strings */
+#define PREP_IBM_MODEL_TIGER1=09"IBM Model 7042/7043 (ED)"
+#define PREP_IBM_MODEL_DORAL=09"IBM PPS Model 7043 (ED)"
=20
 /* setup_ibm_pci:
  * =09set Motherboard_map_name, Motherboard_map, Motherboard_routes.
@@ -715,11 +723,26 @@
 =09=09=09=09ppc_md.power_off =3D prep_sig750_poweroff;
 =09=09=09=09ppc_md.show_cpuinfo =3D prep_sandalfoot_cpuinfo;
 =09=09=09=09break;
-=09=09=09case PREP_IBM_THINKPAD:
-=09=09=09=09prep_gen_enable_l2();
-=09=09=09=09setup_ibm_pci =3D prep_thinkpad_setup_pci;
-=09=09=09=09ppc_md.power_off =3D prep_carrera_poweroff;
-=09=09=09=09ppc_md.show_cpuinfo =3D prep_thinkpad_cpuinfo;
+=09=09=09case PREP_IBM_NO_PLANAR_ID:
+#ifdef CONFIG_PREP_RESIDUAL
+=09=09=09=09if (res &&
+=09=09=09=09    strcmp(res->VitalProductData.PrintableModel,
+=09=09=09=09=09    PREP_IBM_MODEL_DORAL) =3D=3D 0) {
+=09=09=09=09=09prep_carolina_enable_l2();
+=09=09=09=09=09setup_ibm_pci =3D prep_doral_setup_pci;
+=09=09=09=09=09ppc_md.power_off =3D prep_sig750_poweroff;
+=09=09=09=09=09ppc_md.show_cpuinfo =3D prep_tiger1_cpuinfo;
+=09=09=09=09}
+=09=09=09=09else {
+#else /* !CONFIG_PREP_RESIDUAL */
+=09=09=09=09{
+#endif /* CONFIG_PREP_RESIDUAL */
+=09=09=09=09=09/* Assume it is a thinkpad */
+=09=09=09=09=09prep_gen_enable_l2();
+=09=09=09=09=09setup_ibm_pci =3D prep_thinkpad_setup_pci;
+=09=09=09=09=09ppc_md.power_off =3D prep_carrera_poweroff;
+=09=09=09=09=09ppc_md.show_cpuinfo =3D prep_thinkpad_cpuinfo;
+=09=09=09=09}
 =09=09=09=09break;
 =09=09=09default:
 =09=09=09=09printk(" -- unknown! Assuming Carolina");
@@ -748,6 +771,12 @@
 =09=09=09=09ppc_md.show_cpuinfo =3D prep_tiger1_cpuinfo;
 =09=09=09=09ppc_md.progress =3D prep_tiger1_progress;
 =09=09=09=09break;
+=09=09=09case PREP_IBM_7024E30:
+=09=09=09=09prep_carolina_enable_l2();
+=09=09=09=09setup_ibm_pci =3D prep_7024e30_setup_pci;
+=09=09=09=09ppc_md.power_off =3D prep_sig750_poweroff;
+=09=09=09=09ppc_md.show_cpuinfo =3D prep_carolina_cpuinfo;
+=09=09=09=09break;
 =09=09}
 =09=09printk("\n");
=20

------=_Part_313_20063767.1089753853348--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
** This list is shutting down 7/24/2004.
