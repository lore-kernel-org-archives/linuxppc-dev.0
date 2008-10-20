Return-Path: <benh@ozlabs.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 21 Oct 2008 10:06:29 +1100
Subject: [RFC/PATCH] pci: Workaround invalid P2P bridge bus numbers
Message-Id: <20081020230717.2FD16DDDDB@ozlabs.org>
Cc: linux-pci@vger.kernel.org, AymanE@tanisys.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Some firmware fail to properly configure P2P bridges, leaving them
with invalid bus numbers. In some cases, this happens on some embedded
4xx boards as the result of the kernel allocating different bus space
than the firmware does to host bridges while not setting
pcibios_assign_all_busses() for various reasons. In other cases, it can
just be bogus firmware.

This adds some sanity checking to the PCI probing code. If a bridge is
found whose primary bus number doesn't match the bus it's sitting on,
or whose secondary bus number not strictly above it's primary bus
number, then the bridge bus numbers are deconfigured in the first pass
of pci_scan_bridge() to be re-assigned in the second pass.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

Ayman, can you double check that this variant of the patch still
fixes your problem ? Thanks !

Jesse, if it works for Ayman and you have no objection, can this
still go into 2.6.28 ? The root cause of the problem on PPC 4xx is
a bit more tricky and will be fixed later but I believe that this
added robustness to our code won't harm (and will work around the
problem until I have fixed the root cause).

 drivers/pci/probe.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

--- linux-work.orig/drivers/pci/probe.c	2008-10-21 09:47:41.000000000 +1100
+++ linux-work/drivers/pci/probe.c	2008-10-21 09:56:50.000000000 +1100
@@ -480,19 +480,27 @@ int __devinit pci_scan_bridge(struct pci
 	int is_cardbus = (dev->hdr_type == PCI_HEADER_TYPE_CARDBUS);
 	u32 buses, i, j = 0;
 	u16 bctl;
+	int broken = 0;
 
 	pci_read_config_dword(dev, PCI_PRIMARY_BUS, &buses);
 
 	dev_dbg(&dev->dev, "scanning behind bridge, config %06x, pass %d\n",
 		buses & 0xffffff, pass);
 
+	/* Check if setup is sensible at all */
+	if (!pass &&
+	    ((buses & 0xff) != bus->number || ((buses >> 8) & 0xff) <= bus->number)) {
+		dev_dbg(&dev->dev, "bus configuration invalid, reconfiguring\n");
+		broken = 1;
+	}
+
 	/* Disable MasterAbortMode during probing to avoid reporting
 	   of bus errors (in some architectures) */ 
 	pci_read_config_word(dev, PCI_BRIDGE_CONTROL, &bctl);
 	pci_write_config_word(dev, PCI_BRIDGE_CONTROL,
 			      bctl & ~PCI_BRIDGE_CTL_MASTER_ABORT);
 
-	if ((buses & 0xffff00) && !pcibios_assign_all_busses() && !is_cardbus) {
+	if ((buses & 0xffff00) && !pcibios_assign_all_busses() && !is_cardbus && !broken) {
 		unsigned int cmax, busnr;
 		/*
 		 * Bus already configured by firmware, process it in the first
@@ -530,7 +538,7 @@ int __devinit pci_scan_bridge(struct pci
 		 * do in the second pass.
 		 */
 		if (!pass) {
-			if (pcibios_assign_all_busses())
+			if (pcibios_assign_all_busses() || broken)
 				/* Temporarily disable forwarding of the
 				   configuration cycles on all bridges in
 				   this bus segment to avoid possible
