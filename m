Return-Path: <bjorn.helgaas@hp.com>
Received: from g1t0028.austin.hp.com (g1t0028.austin.hp.com [15.216.28.35])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp1.hp.com",
	Issuer "VeriSign Class 3 Secure Server CA - G2" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 692ABB6F0D
	for <linuxppc-dev@ozlabs.org>; Sat, 13 Feb 2010 04:05:25 +1100 (EST)
Subject: [PATCH v3 1/7] PCI: split up pci_read_bridge_bases()
To: Jesse Barnes <jbarnes@virtuousgeek.org>
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Date: Fri, 12 Feb 2010 09:59:52 -0700
Message-ID: <20100212165952.19522.19555.stgit@bob.kio>
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


No functional change; this breaks up pci_read_bridge_bases() into separate
pieces for the I/O, memory, and prefetchable memory windows, similar to how
Yinghai recently split up pci_setup_bridge() in 68e84ff3bdc.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---

 drivers/pci/probe.c |   54 +++++++++++++++++++++++++++++++++++++--------------
 1 files changed, 39 insertions(+), 15 deletions(-)


diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index d300943..3d305c1 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -281,26 +281,12 @@ static void pci_read_bases(struct pci_dev *dev, unsigned int howmany, int rom)
 	}
 }
 
-void __devinit pci_read_bridge_bases(struct pci_bus *child)
+static void __devinit pci_read_bridge_io(struct pci_bus *child)
 {
 	struct pci_dev *dev = child->self;
 	u8 io_base_lo, io_limit_lo;
-	u16 mem_base_lo, mem_limit_lo;
 	unsigned long base, limit;
 	struct resource *res;
-	int i;
-
-	if (pci_is_root_bus(child))	/* It's a host bus, nothing to read */
-		return;
-
-	dev_info(&dev->dev, "PCI bridge to [bus %02x-%02x]%s\n",
-		 child->secondary, child->subordinate,
-		 dev->transparent ? " (subtractive decode)": "");
-
-	if (dev->transparent) {
-		for(i = 3; i < PCI_BUS_NUM_RESOURCES; i++)
-			child->resource[i] = child->parent->resource[i - 3];
-	}
 
 	res = child->resource[0];
 	pci_read_config_byte(dev, PCI_IO_BASE, &io_base_lo);
@@ -328,6 +314,14 @@ void __devinit pci_read_bridge_bases(struct pci_bus *child)
 			 "  bridge window [io  %04lx - %04lx] reg reading\n",
 				 base, limit);
 	}
+}
+
+static void __devinit pci_read_bridge_mmio(struct pci_bus *child)
+{
+	struct pci_dev *dev = child->self;
+	u16 mem_base_lo, mem_limit_lo;
+	unsigned long base, limit;
+	struct resource *res;
 
 	res = child->resource[1];
 	pci_read_config_word(dev, PCI_MEMORY_BASE, &mem_base_lo);
@@ -344,6 +338,14 @@ void __devinit pci_read_bridge_bases(struct pci_bus *child)
 			"  bridge window [mem 0x%08lx - 0x%08lx] reg reading\n",
 					 base, limit + 0xfffff);
 	}
+}
+
+static void __devinit pci_read_bridge_mmio_pref(struct pci_bus *child)
+{
+	struct pci_dev *dev = child->self;
+	u16 mem_base_lo, mem_limit_lo;
+	unsigned long base, limit;
+	struct resource *res;
 
 	res = child->resource[2];
 	pci_read_config_word(dev, PCI_PREF_MEMORY_BASE, &mem_base_lo);
@@ -389,6 +391,28 @@ void __devinit pci_read_bridge_bases(struct pci_bus *child)
 	}
 }
 
+void __devinit pci_read_bridge_bases(struct pci_bus *child)
+{
+	struct pci_dev *dev = child->self;
+	int i;
+
+	if (pci_is_root_bus(child))	/* It's a host bus, nothing to read */
+		return;
+
+	dev_info(&dev->dev, "PCI bridge to [bus %02x-%02x]%s\n",
+		 child->secondary, child->subordinate,
+		 dev->transparent ? " (subtractive decode)": "");
+
+	if (dev->transparent) {
+		for(i = 3; i < PCI_BUS_NUM_RESOURCES; i++)
+			child->resource[i] = child->parent->resource[i - 3];
+	}
+
+	pci_read_bridge_io(child);
+	pci_read_bridge_mmio(child);
+	pci_read_bridge_mmio_pref(child);
+}
+
 static struct pci_bus * pci_alloc_bus(void)
 {
 	struct pci_bus *b;
