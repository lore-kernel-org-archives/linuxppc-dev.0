Date: Sat, 16 Aug 2003 17:28:08 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Paul Mackerras <paulus@samba.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: [PATCH] SL82C105 IDE on LongTrail
Message-ID: <Pine.GSO.4.21.0308161723250.12665-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


The patch below enables SL82C105 IDE on the LongTrail. It's a forward port of
the code in the 2.4 tree. I disabled the similar code for the Briq, since it
relies on other Briq support code which is not yet there.

Please apply (at least the part for LongTrail).

--- linux-ppc-2.6.0-test3/arch/ppc/platforms/chrp_pci.c	Mon Aug 11 02:22:13 2003
+++ linux-longtrail-2.6.0-test3/arch/ppc/platforms/chrp_pci.c	Wed Aug 13 22:37:19 2003
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

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
