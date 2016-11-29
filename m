Return-Path: <helgaas@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tSVZJ2786zDwCn
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2016 15:15:04 +1100 (AEDT)
Subject: [PATCH v4 2/7] PCI: Ignore BAR updates on virtual functions
From: Bjorn Helgaas <bhelgaas@google.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: clsoto@us.ibm.com, benh@kernel.crashing.org, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au
Date: Mon, 28 Nov 2016 22:14:29 -0600
Message-ID: <20161129041429.21453.83322.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20161129035218.21453.93986.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20161129035218.21453.93986.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

VF BARs are read-only zero, so updating VF BARs will not have any effect.
See the SR-IOV spec r1.1, sec 3.4.1.11.

We already ignore these updates because of 70675e0b6a1a ("PCI: Don't try to
restore VF BARs"); this merely restructures it slightly to make it easier
to split updates for standard and SR-IOV BARs.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
CC: Wei Yang <richard.weiyang@gmail.com>
---
 drivers/pci/pci.c       |    4 ----
 drivers/pci/setup-res.c |    5 ++---
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index ba34907..631eac2 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -564,10 +564,6 @@ static void pci_restore_bars(struct pci_dev *dev)
 {
 	int i;
 
-	/* Per SR-IOV spec 3.4.1.11, VF BARs are RO zero */
-	if (dev->is_virtfn)
-		return;
-
 	for (i = 0; i < PCI_BRIDGE_RESOURCES; i++)
 		pci_update_resource(dev, i);
 }
diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index 66c4d8f..d2a32d8 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -36,10 +36,9 @@ void pci_update_resource(struct pci_dev *dev, int resno)
 	enum pci_bar_type type;
 	struct resource *res = dev->resource + resno;
 
-	if (dev->is_virtfn) {
-		dev_warn(&dev->dev, "can't update VF BAR%d\n", resno);
+	/* Per SR-IOV spec 3.4.1.11, VF BARs are RO zero */
+	if (dev->is_virtfn)
 		return;
-	}
 
 	/*
 	 * Ignore resources for unimplemented BARs and unused resource slots
