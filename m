Date: Sun, 1 Feb 2004 23:49:38 -0600
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Jeff Garzik <jgarzik@pobox.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>,
	"David D. Kilzer" <ddkilzer@kilzer.net>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [PATCH] Fix byte-swapped ethernet addr for Asante Fast 10/100 PCI Adapter
Message-ID: <20040202054938.GA1814@permusion.kilzer.net>
References: <Pine.LNX.4.44.0312231423020.1925-100000@zirkon.biophys.uni-duesseldorf.de> <Pine.GSO.4.58.0312231500350.1139@waterleaf.sonytel.be> <40132070.4080704@pobox.com> <1074995318.835.129.camel@gaston>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="UugvWAfsgieZRqgk"
In-Reply-To: <1074995318.835.129.camel@gaston>
From: ddkilzer@kilzer.net (David D. Kilzer)
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Attached is my second pass at patches to fix the byte-swapped ethernet
MAC address issue with my tulip-based Asante ethernet card.  Please note
that the patch against 2.4.24 also applies cleanly to 2.6.x (with
offsets).

The approach I took for these patches was to remove the current logic
from the 'if' statement and to put it in its own function (unchanged),
along with new code for identifying the Asante card using PCI
(sub)vendor and (sub)device IDs.  I also did some investigative work
regarding the original code that only checks the first two bytes of the
ethernet MAC address.  This information appears in the comments,
although they are a bit more verbose than the rest of the code.

Finally, it may be possible to replace the new
needs_mac_addr_byte_swapped() function with a check of the PCI vendor
and device IDs, assuming all tulip ethernet cards using the LC82C168
chipset have this same problem (and the same PCI IDs):

	if (pdev->vendor == PCI_VENDOR_ID_LITEON
		&& pdev->device == PCI_DEVICE_ID_LITEON_LNE100TX)
 		for (i = 0; i < 6; i+=2) {
			...
		}

Through Google searches, I've determined that the Kingston boards need
this fix, but there are some Netgear "FA310TX" boards that I'm not sure
about.

I'm looking for more feedback on the patches, unless they're ready to be
included in the kernel.  Some lingering questions I had were:

- Should I check for all 3 ethernet MAC address bytes instead of just
  the first two for the first 'if' statemen, now that I've identified
  what the original code was probably checking for?

- Should I simply replace the needs_mac_addr_byte_swapped() function
  with the PCI vendor/device check shown above?  (I probably shouldn't
  have asked this; would only be useful if someone had such a Netgear
  card on this list and could confirm it.)

- Did I define the subvendor/subdevice constants in pci_ids.h correctly?

- Was I too verbose in my code comments?  If so, where should that
  information be located if not in the code?  Should it be in
  Documentation/DocBook/tulip.tmpl instead?

Thanks!

Dave

On Sun, Jan 25, 2004 at 12:48:38PM +1100, Benjamin Herrenschmidt wrote:
> On Sun, 2004-01-25 at 12:48, Jeff Garzik wrote:
> > Geert Uytterhoeven wrote:
> > > Really? I'd say it's easier to look at the struct pci_dev the
> > > Tulip driver already looks at. Besides, someone may want to try
> > > that card in a non-PowerMac, while still having the correct MAC
> > > address.
> >
> > Agreed.
>
> Provided the card has a unique device ID... but yes, in this case,
> it's the best solution.

--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux-2.2.20-tulip-fix-asante-mac-addr-v2.diff"

diff -u kernel-source-2.2.20/drivers/net/tulip.c.orig kernel-source-2.2.20/drivers/net/tulip.c
--- kernel-source-2.2.20/drivers/net/tulip.c.orig	Fri Jul  4 17:58:17 2003
+++ kernel-source-2.2.20/drivers/net/tulip.c	Sun Feb  1 20:40:36 2004
@@ -26,6 +26,11 @@

 	2002 Dec 21  Neale Banks <neale@lowendale.com.au>
 	Gracefully handle the case where init_etherdev() returns NULL
+
+	2004 Jan 31  David D. Kilzer <ddkilzer@kilzer.net>
+	Moved check for needing to byte-swap MAC address into its own
+	function.  Added code to function to check for the Asante Fast
+	10/100 PCI Adapter Rev B P/N 99-00493-87.
 */

 #define SMP_CHECK
@@ -678,6 +683,73 @@
 }
 #endif  /* not CARDBUS */

+static int needs_mac_addr_byte_swapped(int pci_bus, int pci_devfn,
+	struct device *dev)
+{
+	/*
+	 * Lite-On boards have the mac address byte-swapped.
+	 *
+	 * The code below is checking for the following ethernet MAC
+	 * address combinations (in byte-swapped order):
+	 *
+	 *   00:A0:**
+	 *   00:C0:**
+	 *
+	 * However, only one of these maps directly to a Lite-On
+	 * ethernet vendor code:
+	 *
+	 *   00-A0-CC	LITE-ON COMMUNICATIONS, INC.
+	 *
+	 * The other code is probably for Kingston Technology, who
+	 * distributed their own ethernet cards using Lite-On chips
+	 * (confirmed via Google search of "00:C0 lite-on"):
+	 *
+	 *   00-C0-F0	KINGSTON TECHNOLOGY CORP.
+	 *
+	 * Ethernet vendor codes were found here:
+	 *
+	 *   http://standards.ieee.org/regauth/oui/index.shtml
+	 */
+	if ((dev->dev_addr[0] == 0xA0  ||  dev->dev_addr[0] == 0xC0)
+		&&  dev->dev_addr[1] == 0x00)
+		return 1;
+
+	/*
+	 * Asante Technologies also produced an ethernet card based on
+	 * the Lite-On chipset.
+	 */
+	{
+#if defined(PCI_SUPPORT_VER1)
+		/*
+		 * Fall back to checking for the ethernet vendor code:
+	 	 *   00-00-94	ASANTE TECHNOLOGIES
+		 */
+		if (dev->dev_addr[0] == 0x00 &&  dev->dev_addr[1] == 0x00
+			&&  dev->dev_addr[3] == 0x94)
+			return 1;
+#elif defined(PCI_SUPPORT_VER2)
+		/*
+		 * Check the PCI (sub)vendor and (sub)device instead.
+		 */
+		struct pci_dev *pdev = pci_find_slot(pci_bus, pci_devfn);
+		u16 sub_vendor_id, sub_device_id;
+
+		pcibios_read_config_word(pci_bus, pci_devfn,
+			PCI_SUBSYSTEM_VENDOR_ID, &sub_vendor_id);
+		pcibios_read_config_word(pci_bus, pci_devfn,
+			PCI_SUBSYSTEM_ID,        &sub_device_id);
+
+		if (pdev->vendor == PCI_VENDOR_ID_LITEON
+			&& pdev->device == PCI_DEVICE_ID_LITEON_LNE100TX
+			&& sub_vendor_id == PCI_SUBVENDOR_ID_ASANTE
+			&& sub_device_id == PCI_SUBDEVICE_ID_ASANTE_FAST_10_100_REV_B)
+			return 1;
+#endif
+	}
+
+	return 0;
+}
+
 static struct device *tulip_probe1(int pci_bus, int pci_devfn,
 								   struct device *dev, long ioaddr, int irq,
 								   int chip_idx, int board_idx)
@@ -786,9 +858,9 @@
 			sum += ee_data[i + sa_offset];
 		}
 	}
-	/* Lite-On boards have the address byte-swapped. */
-	if ((dev->dev_addr[0] == 0xA0  ||  dev->dev_addr[0] == 0xC0)
-		&&  dev->dev_addr[1] == 0x00)
+	/* Boards with the Lite-On LC82C168 chipset have the address
+	   byte-swapped. */
+	if (needs_mac_addr_byte_swapped(pci_bus, pci_devfn, dev))
 		for (i = 0; i < 6; i+=2) {
 			char tmp = dev->dev_addr[i];
 			dev->dev_addr[i] = dev->dev_addr[i+1];
diff -u kernel-source-2.2.20/include/linux/pci.h.orig kernel-source-2.2.20/include/linux/pci.h
--- kernel-source-2.2.20/include/linux/pci.h.orig	Fri Jul  4 18:33:54 2003
+++ kernel-source-2.2.20/include/linux/pci.h	Sun Feb  1 20:16:55 2004
@@ -994,6 +994,9 @@
 #define PCI_VENDOR_ID_LITEON		0x11ad
 #define PCI_DEVICE_ID_LITEON_LNE100TX	0x0002

+#define PCI_SUBVENDOR_ID_ASANTE		0x128a
+#define PCI_SUBDEVICE_ID_ASANTE_FAST_10_100_REV_B	0xf001
+
 #define PCI_VENDOR_ID_NP		0x11bc
 #define PCI_DEVICE_ID_NP_PCI_FDDI	0x0001


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux-2.4.24-tulip-fix-asante-mac-addr-v2.diff"

diff -urN -x *.orig linux-2.4.24-orig/drivers/net/tulip/tulip_core.c linux-2.4.24/drivers/net/tulip/tulip_core.c
--- linux-2.4.24-orig/drivers/net/tulip/tulip_core.c	Fri Nov 28 12:26:20 2003
+++ linux-2.4.24/drivers/net/tulip/tulip_core.c	Sun Feb  1 20:43:06 2004
@@ -1322,6 +1322,52 @@
 }
 #endif

+static int __devinit needs_mac_addr_byte_swapped(struct pci_dev *pdev,
+						 struct net_device *dev)
+{
+	/*
+	 * Lite-On boards have the mac address byte-swapped.
+	 *
+	 * The code below is checking for the following ethernet MAC
+	 * address combinations (in byte-swapped order):
+	 *
+	 *   00:A0:**
+	 *   00:C0:**
+	 *
+	 * However, only one of these maps directly to a Lite-On
+	 * ethernet vendor code:
+	 *
+	 *   00-A0-CC	LITE-ON COMMUNICATIONS, INC.
+	 *
+	 * The other code is probably for Kingston Technology, who
+	 * distributed their own ethernet cards using Lite-On chips
+	 * (confirmed via Google search of "00:C0 lite-on"):
+	 *
+	 *   00-C0-F0	KINGSTON TECHNOLOGY CORP.
+	 *
+	 * Ethernet vendor codes were found here:
+	 *
+	 *   http://standards.ieee.org/regauth/oui/index.shtml
+	 */
+	if ((dev->dev_addr[0] == 0xA0  ||  dev->dev_addr[0] == 0xC0)
+		&&  dev->dev_addr[1] == 0x00)
+		return 1;
+
+	/*
+	 * Asante Technologies also produced an ethernet card based on
+	 * the Lite-On chipset.
+	 *
+	 * Check the PCI (sub)vendor and (sub)device instead.
+	 */
+	if (pdev->vendor == PCI_VENDOR_ID_LITEON
+		&& pdev->device == PCI_DEVICE_ID_LITEON_LNE100TX
+		&& pdev->subsystem_vendor == PCI_SUBVENDOR_ID_ASANTE
+		&& pdev->subsystem_device == PCI_SUBDEVICE_ID_ASANTE_FAST_10_100_REV_B)
+		return 1;
+
+	return 0;
+}
+
 static int __devinit tulip_init_one (struct pci_dev *pdev,
 				     const struct pci_device_id *ent)
 {
@@ -1623,9 +1669,9 @@
 			sum += ee_data[i + sa_offset];
 		}
 	}
-	/* Lite-On boards have the address byte-swapped. */
-	if ((dev->dev_addr[0] == 0xA0  ||  dev->dev_addr[0] == 0xC0)
-		&&  dev->dev_addr[1] == 0x00)
+	/* Boards with the Lite-On LC82C168 chipset have the address
+	   byte-swapped. */
+	if (needs_mac_addr_byte_swapped(pdev, dev))
 		for (i = 0; i < 6; i+=2) {
 			char tmp = dev->dev_addr[i];
 			dev->dev_addr[i] = dev->dev_addr[i+1];
diff -urN -x *.orig linux-2.4.24-orig/include/linux/pci_ids.h linux-2.4.24/include/linux/pci_ids.h
--- linux-2.4.24-orig/include/linux/pci_ids.h	Fri Nov 28 12:26:21 2003
+++ linux-2.4.24/include/linux/pci_ids.h	Sun Feb  1 20:24:29 2004
@@ -1306,6 +1306,9 @@
 #define PCI_VENDOR_ID_LITEON		0x11ad
 #define PCI_DEVICE_ID_LITEON_LNE100TX	0x0002

+#define PCI_SUBVENDOR_ID_ASANTE		0x128a
+#define PCI_SUBDEVICE_ID_ASANTE_FAST_10_100_REV_B	0xf001
+
 #define PCI_VENDOR_ID_V3		0x11b0
 #define PCI_DEVICE_ID_V3_V960		0x0001
 #define PCI_DEVICE_ID_V3_V350		0x0001

--UugvWAfsgieZRqgk--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
