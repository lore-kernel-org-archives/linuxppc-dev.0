Date: Sun, 18 Jan 2004 13:22:57 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Paul Mackerras <paulus@samba.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: [PATCH 2.6] LongTrail W83C553 IDE
Message-ID: <Pine.LNX.4.58.0401181317170.653@callisto>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="9jxsPFA5p3P2qPhR"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--9jxsPFA5p3P2qPhR
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

The patch below enables the W83C553 IDE interface on the CHRP LongTrail.
It's a straight forward port of the W83C553 fixup code for LongTrail and
Briq in 2.4.x. It was tested on LongTrail only, using a ST340810ACE hard
drive. Briq support may need additional changes.

The patch is relative to 2.6.0 in the linuxppc-2.5 tree on December 22.
Please apply, thanks!

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

--9jxsPFA5p3P2qPhR
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Disposition: attachment; filename="chrp_pci.c.patch"
Content-Transfer-Encoding: 7bit

--- linux-ppc-2.6.0/arch/ppc/platforms/chrp_pci.c.orig	2003-12-18 10:21:56.000000000 +0100
+++ linux-ppc-2.6.0/arch/ppc/platforms/chrp_pci.c	2003-12-21 12:47:29.000000000 +0100
@@ -24,6 +24,9 @@

 /* LongTrail */
 unsigned long gg2_pci_config_base;
+#ifdef BRIQ_SUPPORT_IS_THERE
+extern int chrp_is_briq;
+#endif

 /*
  * The VLSI Golden Gate II has only 512K of PCI configuration space, so we
@@ -166,6 +169,73 @@
 	}
 }

+/* W83C553 IDE Interrupt Routing Control Register */
+#define W83C553_IDEIRCR                0x43
+
+/* SL82C105 IDE Control/Status Register */
+#define SL82C105_IDECSR                0x40
+
+static void __init
+longtrail_pcibios_fixup(void)
+{
+       struct pci_dev *w83c553, *sl82c105;
+       u8 progif;
+
+       chrp_pcibios_fixup();
+
+       /*
+        *  Open Firmware may have left the SL82C105 IDE interface in the
+        *  W83C553 PCI/ISA bridge in legacy mode
+        */
+       if ((w83c553 = pci_find_device(PCI_VENDOR_ID_WINBOND,
+                                      PCI_DEVICE_ID_WINBOND_83C553, 0)) &&
+           (sl82c105 = pci_find_device(PCI_VENDOR_ID_WINBOND,
+                                       PCI_DEVICE_ID_WINBOND_82C105,
+                                       w83c553)) &&
+           (sl82c105->class & 5) != 5) {
+               printk("W83C553: Switching SL82C105 IDE to PCI native mode\n");
+               /* Enable W83C553 legacy interrupt internal routing to INTC#, */
+               /* which is connected to HYDRA_INT_EXT5 */
+               pci_write_config_byte(w83c553, W83C553_IDEIRCR, 0x00);
+               /* Enable SL82C105 PCI native IDE mode */
+               pci_read_config_byte(sl82c105, PCI_CLASS_PROG, &progif);
+               pci_write_config_byte(sl82c105, PCI_CLASS_PROG, progif | 0x05);
+               sl82c105->class |= 0x05;
+               /* Enable SL82C105 legacy interrupts & both channels */
+               pci_write_config_word(sl82c105, SL82C105_IDECSR, 0x0833);
+       }
+}
+
+#ifdef BRIQ_SUPPORT_IS_THERE
+static void __init
+briq_pcibios_fixup(void)
+{
+       struct pci_dev *w83c553, *sl82c105;
+       u8 progif;
+
+       chrp_pcibios_fixup();
+
+       /*
+        *  Open Firmware may have left the SL82C105 IDE interface in the
+        *  W83C553 PCI/ISA bridge in legacy mode
+        */
+       if ((w83c553 = pci_find_device(PCI_VENDOR_ID_WINBOND,
+                                      PCI_DEVICE_ID_WINBOND_83C553, 0)) &&
+           (sl82c105 = pci_find_device(PCI_VENDOR_ID_WINBOND,
+                                       PCI_DEVICE_ID_WINBOND_82C105,
+                                       w83c553)) &&
+           (sl82c105->class & 5) != 5) {
+               printk("W83C553: Switching SL82C105 IDE to PCI native mode\n");
+               /* Enable SL82C105 PCI native IDE mode */
+               pci_read_config_byte(sl82c105, PCI_CLASS_PROG, &progif);
+               pci_write_config_byte(sl82c105, PCI_CLASS_PROG, progif | 0x05);
+               sl82c105->class |= 0x05;
+               /* Disable SL82C105 second port */
+               pci_write_config_word(sl82c105, SL82C105_IDECSR, 0x0003);
+       }
+}
+#endif
+
 #define PRG_CL_RESET_VALID 0x00010000

 static void __init
@@ -275,5 +345,12 @@
 		}
 	}

-	ppc_md.pcibios_fixup = chrp_pcibios_fixup;
+       if (is_longtrail)
+               ppc_md.pcibios_fixup = longtrail_pcibios_fixup;
+#ifdef BRIQ_SUPPORT_IS_THERE
+       else if (chrp_is_briq)
+               ppc_md.pcibios_fixup = briq_pcibios_fixup;
+#endif
+       else
+               ppc_md.pcibios_fixup = chrp_pcibios_fixup;
 }

--9jxsPFA5p3P2qPhR--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
