Date: Mon, 23 Dec 2002 23:13:11 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: [PATCH] IDE on CHRP LongTrail
Message-ID: <Pine.GSO.4.21.0212232301330.1694-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This patch enables the SL82C105 IDE interface in the W83C553 PCI/ISA bridge on
my CHRP LongTrail.

There are 2 ways to configure the IDE interface:
  - Legacy mode, using IRQ 14 for the primary channel, and IRQ 15 for the
    secondary channel
  - Native mode, using IRQ 32 (OpenPIC IRQ 16) for both channels

Apparently Open Firmware left the IDE interface in legacy mode, while the
interrupt property of the device pointed to the OpenPIC interrupt. Of course
this mix of legacy and native mode didn't work well and no interrupts came
through.

With the patch below, the SL82C105 is configured for native mode and both IDE
channels work. The patch applies to 2.4.21-pre2 as well, but there IDE seems to
be broken on PPC in general.

--- linux-ppc-2.4.20/arch/ppc/platforms/chrp_pci.c.orig	Sun Dec 22 15:52:13 2002
+++ linux-ppc-2.4.20/arch/ppc/platforms/chrp_pci.c	Mon Dec 23 20:37:10 2002
@@ -194,6 +194,44 @@
 	}
 }

+
+/* W83C553 IDE Interrupt Routing Control Register */
+#define W83C553_IDEIRCR		0x43
+
+/* SL82C105 IDE Control/Status Register */
+#define SL82C105_IDECSR		0x41
+
+static void __init
+longtrail_pcibios_fixup(void)
+{
+	struct pci_dev *w83c553, *sl82c105;
+	u8 progif;
+
+	chrp_pcibios_fixup();
+
+	/*
+	 *  Open Firmware may have left the SL82C105 IDE interface in the
+	 *  W83C553 PCI/ISA bridge in legacy mode
+	 */
+	if ((w83c553 = pci_find_device(PCI_VENDOR_ID_WINBOND,
+				       PCI_DEVICE_ID_WINBOND_83C553, 0)) &&
+	    (sl82c105 = pci_find_device(PCI_VENDOR_ID_WINBOND,
+					PCI_DEVICE_ID_WINBOND_82C105,
+					w83c553)) &&
+	    (sl82c105->class & 5) != 5) {
+		printk("W83C553: Switching SL82C105 IDE to PCI native mode\n");
+		/* Enable W83C553 legacy interrupt internal routing to INTC#, */
+		/* which is connected to HYDRA_INT_EXT5 */
+		pci_write_config_byte(w83c553, W83C553_IDEIRCR, 0x00);
+		/* Enable SL82C105 PCI native IDE mode */
+		pci_read_config_byte(sl82c105, PCI_CLASS_PROG, &progif);
+		pci_write_config_byte(sl82c105, PCI_CLASS_PROG, progif | 0x05);
+		sl82c105->class |= 0x05;
+		/* Enable SL82C105 legacy interrupts */
+		pci_write_config_byte(sl82c105, SL82C105_IDECSR, 0x08);
+	}
+}
+
 #define PRG_CL_RESET_VALID 0x00010000

 static void __init
@@ -318,5 +356,8 @@
 		}
 	}

-	ppc_md.pcibios_fixup = chrp_pcibios_fixup;
+	if (is_longtrail)
+		ppc_md.pcibios_fixup = longtrail_pcibios_fixup;
+	else
+		ppc_md.pcibios_fixup = chrp_pcibios_fixup;
 }

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
