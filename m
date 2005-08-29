Return-Path: <jirislaby@gmail.com>
Received: from wscnet.wsc.cz (wscnet.wsc.cz [212.80.64.118])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CAA0668135
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Aug 2005 08:35:39 +1000 (EST)
Date: Tue, 30 Aug 2005 00:26:32 +0200
Message-Id: <200508292226.j7TMQWo2019990@wscnet.wsc.cz>
In-reply-to: <200508292220.j7TMKbNC019793@wscnet.wsc.cz>
From: Jiri Slaby <jirislaby@gmail.com>
To: Greg KH <gregkh@suse.de>
Cc: linuxppc-dev@ozlabs.org, linux-pci@atrey.karlin.mff.cuni.cz,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 5/7] arch: pci_find_device remove (ppc/kernel/pci.c)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Generated in 2.6.13-rc6-mm2 kernel version.

Signed-off-by: Jiri Slaby <xslaby@fi.muni.cz>

 pci.c |   21 +++++++++++----------
 1 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/arch/ppc/kernel/pci.c b/arch/ppc/kernel/pci.c
--- a/arch/ppc/kernel/pci.c
+++ b/arch/ppc/kernel/pci.c
@@ -517,7 +517,7 @@ pcibios_allocate_resources(int pass)
 	u16 command;
 	struct resource *r;
 
-	while ((dev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
+	for_each_pci_dev(dev) {
 		pci_read_config_word(dev, PCI_COMMAND, &command);
 		for (idx = 0; idx < 6; idx++) {
 			r = &dev->resource[idx];
@@ -554,7 +554,7 @@ pcibios_assign_resources(void)
 	int idx;
 	struct resource *r;
 
-	while ((dev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
+	for_each_pci_dev(dev) {
 		int class = dev->class >> 8;
 
 		/* Don't touch classless devices and host bridges */
@@ -880,14 +880,15 @@ pci_device_from_OF_node(struct device_no
 	 */
 	if (!pci_to_OF_bus_map)
 		return 0;
-	while ((dev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
-		if (pci_to_OF_bus_map[dev->bus->number] != *bus)
-			continue;
-		if (dev->devfn != *devfn)
-			continue;
-		*bus = dev->bus->number;
-		return 0;
-	}
+
+	for_each_pci_dev(dev)
+		if (pci_to_OF_bus_map[dev->bus->number] == *bus &&
+				dev->devfn == *devfn) {
+			*bus = dev->bus->number;
+			pci_dev_put(dev);
+			return 0;
+		}
+
 	return -ENODEV;
 }
 
