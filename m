Date: Sun, 23 May 2004 20:30:51 -0400 (EDT)
From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH] Fixup for DEC 21154 bridge to allow CardBus support
To: linuxppc-dev@lists.linuxppc.org
Message-id: <Pine.LNX.4.58.0405231954120.10093@portland.hansa.lan>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_Id3asnkvRWxv+Xg/E7bjMw)"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--Boundary_(ID_Id3asnkvRWxv+Xg/E7bjMw)
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT

Hello!

I'm using Blue&While G3.  I installed a CardBus bridge into a PCI slot.
The bridge uses TI PCI1410 chip.  16-bit PCMCIA cards work fine, but
CardBus cards don't work.  They are not shown by lspci.  I'm running
Debian unstable with Linux 2.6.6-bk9.

It turns out the PCI bridge (DEC 21154) only handles bus 1 and doesn't
forward requests to higher buses.  The CardBus card is configured to act
as a bridge from bus 1 to buses 2-5.  That's why requests to bus 2 don't
go through.

If I reconfigure the PCI bridge to handle buses 1-255, the CardBus cards
start working.  The attached patch add a fixup for DEC 21154 bridge.

If there are a better way to fix the problem with CardBus, I'm ready to
test other patches.

More information about the system (including kernel log) is available at
http://www.red-bean.com/~proski/g3bw/

As a side not, the kernel says that the Host bridge (Motorola MPC106
Grackle) is configured to support buses 0 and 1.  Those values come from
the "bus-range" property.  I believe this limitation is not enforced, or
it would also hinder CardBus support.

--
Regards,
Pavel Roskin

--Boundary_(ID_Id3asnkvRWxv+Xg/E7bjMw)
Content-id: <Pine.LNX.4.58.0405232030510.10443@portland.hansa.lan>
Content-type: TEXT/plain; charset=US-ASCII; name=dec_fixup.diff
Content-transfer-encoding: 7BIT
Content-disposition: attachment; filename=dec_fixup.diff
Content-description: 

--- linux.orig/arch/ppc/kernel/pci.c
+++ linux/arch/ppc/kernel/pci.c
@@ -49,6 +49,7 @@ static void fixup_cpc710_pci64(struct pc
 extern void pmac_pci_fixup_cardbus(struct pci_dev* dev);
 extern void pmac_pci_fixup_pciata(struct pci_dev* dev);
 extern void pmac_pci_fixup_k2_sata(struct pci_dev* dev);
+extern void pmac_pci_fixup_dec_bridge(struct pci_dev* dev);
 #endif
 #ifdef CONFIG_PPC_OF
 static u8* pci_to_OF_bus_map;
@@ -72,6 +73,7 @@ struct pci_fixup pcibios_fixups[] = {
 #ifdef CONFIG_PPC_PMAC
 	/* We should add per-machine fixup support in xxx_setup.c or xxx_pci.c */
 	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_TI,	PCI_ANY_ID,			pmac_pci_fixup_cardbus },
+	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_DEC,	PCI_DEVICE_ID_DEC_21154,	pmac_pci_fixup_dec_bridge },
 	{ PCI_FIXUP_FINAL,	PCI_ANY_ID,		PCI_ANY_ID,			pmac_pci_fixup_pciata },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_SERVERWORKS, 0x0240,			pmac_pci_fixup_k2_sata },
 #endif /* CONFIG_PPC_PMAC */
--- linux.orig/arch/ppc/platforms/pmac_pci.c
+++ linux/arch/ppc/platforms/pmac_pci.c
@@ -1034,6 +1034,13 @@ void pmac_pci_fixup_cardbus(struct pci_d
 	}
 }

+void fixup_dec_bridge(struct pci_dev* dev)
+{
+	/* By default this bridge only handles bus 1.  This fixup allows
+	 * access to higher busses, which is needed for CardBus support */
+	pci_write_config_byte(dev, PCI_SUBORDINATE_BUS, 255);
+}
+
 void pmac_pci_fixup_pciata(struct pci_dev* dev)
 {
        u8 progif = 0;

--Boundary_(ID_Id3asnkvRWxv+Xg/E7bjMw)--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
