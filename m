Date: Mon, 24 May 2004 01:21:11 -0400 (EDT)
From: Pavel Roskin <proski@gnu.org>
Subject: Re: [PATCH] Fixup for DEC 21154 bridge to allow CardBus support
In-reply-to: <1085363158.15315.11.camel@gaston>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.linuxppc.org
Message-id: <Pine.LNX.4.58.0405240031200.2676@portland.hansa.lan>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_+AFLwtbF6VIagtDfTs65/A)"
References: <Pine.LNX.4.58.0405231954120.10093@portland.hansa.lan>
 <1085363158.15315.11.camel@gaston>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--Boundary_(ID_+AFLwtbF6VIagtDfTs65/A)
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT

Hi, Benjamin!

On Mon, 24 May 2004, Benjamin Herrenschmidt wrote:

> > As a side not, the kernel says that the Host bridge (Motorola MPC106
> > Grackle) is configured to support buses 0 and 1.  Those values come from
> > the "bus-range" property.  I believe this limitation is not enforced, or
> > it would also hinder CardBus support.
>
> It's a bit nasty right now... You may bump into other problems, the
> main issue is OF not setting a proper bus range.

I actually tried to replace all references to "bus-range" with "bus-bogus"
in the kernel.  The kernel would print

Found Grackle (MPC106) PCI host bridge at 0x80000000. Firmware bus number: 0->255

instead of "0->1", but I didn't notice any difference with regards to
CardBus support.

> Anyway, you should make your patch machine specific to avoid screwing up
> other possible busses...

I have CONFIG_PPC_PMAC condition already.  This plus the exact vendor and
device ID should be machine specific.  I can check that the machine is
"PowerMac1,1" if you want.  I have no idea if G4 models have this problem.

> (hrm... not too sure in fact if the linux common PCI code will properly
> fixup the last subordinate bus number, you may also want to only give a
> range of 5 or 10 bus numbers in case somebody plugs another PCI card
> with a P2P bridge on it, maybe just read the bus number and rewrite it
> adding 5 or so...)

I assumed that all PCI devices inserted to the slots would be on the bus 1
and thus behind the DEC bridge I'm reconfiguring.

Now I see that the video card is on bus 0 somehow.  Maybe that particular
slot is wired differently.  If you really think that somebody could insert
a P2P bridge instead of the video card, then maybe I should leave some
space.  I seem to remember that some multihead cards (Colorgraphic
Predator LT) have internal bridges.

There are 3 PCI slots other than VGA.  Every card can have 2 CardBus
slots.  Every CardBus bridge uses 4 buses.  That's 24 buses, from 2 to 25.

The fixed patch is attached.

--
Regards,
Pavel Roskin

--Boundary_(ID_+AFLwtbF6VIagtDfTs65/A)
Content-id: <Pine.LNX.4.58.0405240121110.2676@portland.hansa.lan>
Content-type: TEXT/plain; charset=US-ASCII; name=dec_fixup_2.diff
Content-transfer-encoding: 7BIT
Content-disposition: attachment; filename=dec_fixup_2.diff
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
@@ -1034,6 +1034,21 @@ void pmac_pci_fixup_cardbus(struct pci_d
 	}
 }

+/* By default the PCI bridge on Blue&White G3 only handles bus 1.   This
+ * fixup allows access to higher buses in case if PCI or Cardbus bridge
+ * is added to the system.  */
+void pmac_pci_fixup_dec_bridge(struct pci_dev* dev)
+{
+	u8 val;
+
+	if (!machine_is_compatible("PowerMac1,1"))
+		return;
+
+	if (pci_read_config_byte(dev, PCI_SUBORDINATE_BUS, &val) == 0 &&
+	    val < 25)
+		pci_write_config_byte(dev, PCI_SUBORDINATE_BUS, 25);
+}
+
 void pmac_pci_fixup_pciata(struct pci_dev* dev)
 {
        u8 progif = 0;

--Boundary_(ID_+AFLwtbF6VIagtDfTs65/A)--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
