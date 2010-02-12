Return-Path: <bjorn.helgaas@hp.com>
Received: from g4t0017.houston.hp.com (g4t0017.houston.hp.com [15.201.24.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp1.hp.com",
	Issuer "VeriSign Class 3 Secure Server CA - G2" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B2862B7080
	for <linuxppc-dev@ozlabs.org>; Sat, 13 Feb 2010 04:10:13 +1100 (EST)
Subject: [PATCH v3 6/7] PCI: break out primary/secondary/subordinate for
	readability
To: Jesse Barnes <jbarnes@virtuousgeek.org>
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Date: Fri, 12 Feb 2010 10:00:17 -0700
Message-ID: <20100212170017.19522.97245.stgit@bob.kio>
In-Reply-To: <20100212165532.19522.47240.stgit@bob.kio>
References: <20100212165532.19522.47240.stgit@bob.kio>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Tony Luck <tony.luck@intel.com>,
	linuxppc-dev@ozlabs.org, linux-pci@vger.kernel.org,
	Peter Haight <peterh@sapros.com>,
	Gary Hade <garyhade@us.ibm.com>, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-acpi@vger.kernel.org, linux-am33-list@redhat.com,
	linux-alpha@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
	Yinghai Lu <yinghai@kernel.org>, Larry Finger <Larry.Finger@lwfinger.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


No functional change; just add names for the primary/secondary/subordinate
bus numbers read from config space rather than repeatedly masking/shifting.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---

 drivers/pci/probe.c |   24 ++++++++++++++----------
 1 files changed, 14 insertions(+), 10 deletions(-)


diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index dacdeae..04e7e97 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -671,16 +671,20 @@ int __devinit pci_scan_bridge(struct pci_bus *bus, struct pci_dev *dev, int max,
 	int is_cardbus = (dev->hdr_type == PCI_HEADER_TYPE_CARDBUS);
 	u32 buses, i, j = 0;
 	u16 bctl;
+	u8 primary, secondary, subordinate;
 	int broken = 0;
 
 	pci_read_config_dword(dev, PCI_PRIMARY_BUS, &buses);
+	primary = buses & 0xFF;
+	secondary = (buses >> 8) & 0xFF;
+	subordinate = (buses >> 16) & 0xFF;
 
-	dev_dbg(&dev->dev, "scanning behind bridge, config %06x, pass %d\n",
-		buses & 0xffffff, pass);
+	dev_dbg(&dev->dev, "scanning [bus %02x-%02x] behind bridge, pass %d\n",
+		secondary, subordinate, pass);
 
 	/* Check if setup is sensible at all */
 	if (!pass &&
-	    ((buses & 0xff) != bus->number || ((buses >> 8) & 0xff) <= bus->number)) {
+	    (primary != bus->number || secondary <= bus->number)) {
 		dev_dbg(&dev->dev, "bus configuration invalid, reconfiguring\n");
 		broken = 1;
 	}
@@ -691,15 +695,15 @@ int __devinit pci_scan_bridge(struct pci_bus *bus, struct pci_dev *dev, int max,
 	pci_write_config_word(dev, PCI_BRIDGE_CONTROL,
 			      bctl & ~PCI_BRIDGE_CTL_MASTER_ABORT);
 
-	if ((buses & 0xffff00) && !pcibios_assign_all_busses() && !is_cardbus && !broken) {
-		unsigned int cmax, busnr;
+	if ((secondary || subordinate) && !pcibios_assign_all_busses() &&
+	    !is_cardbus && !broken) {
+		unsigned int cmax;
 		/*
 		 * Bus already configured by firmware, process it in the first
 		 * pass and just note the configuration.
 		 */
 		if (pass)
 			goto out;
-		busnr = (buses >> 8) & 0xFF;
 
 		/*
 		 * If we already got to this bus through a different bridge,
@@ -708,13 +712,13 @@ int __devinit pci_scan_bridge(struct pci_bus *bus, struct pci_dev *dev, int max,
 		 * However, we continue to descend down the hierarchy and
 		 * scan remaining child buses.
 		 */
-		child = pci_find_bus(pci_domain_nr(bus), busnr);
+		child = pci_find_bus(pci_domain_nr(bus), secondary);
 		if (!child) {
-			child = pci_add_new_bus(bus, dev, busnr);
+			child = pci_add_new_bus(bus, dev, secondary);
 			if (!child)
 				goto out;
-			child->primary = buses & 0xFF;
-			child->subordinate = (buses >> 16) & 0xFF;
+			child->primary = primary;
+			child->subordinate = subordinate;
 			child->bridge_ctl = bctl;
 		}
 
