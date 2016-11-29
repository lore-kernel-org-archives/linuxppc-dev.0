Return-Path: <helgaas@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tSVb03MxpzDwGs
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2016 15:15:40 +1100 (AEDT)
Subject: [PATCH v4 4/7] PCI: Don't update VF BARs while VF memory space is
 enabled
From: Bjorn Helgaas <bhelgaas@google.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: clsoto@us.ibm.com, benh@kernel.crashing.org, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au
Date: Mon, 28 Nov 2016 22:15:21 -0600
Message-ID: <20161129041521.21453.33146.stgit@bhelgaas-glaptop.roam.corp.google.com>
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

If we update a VF BAR while it's enabled, there are two potential problems:

  1) Any driver that's using the VF has a cached BAR value that is stale
     after the update, and

  2) We can't update 64-bit BARs atomically, so the intermediate state
     (new lower dword with old upper dword) may conflict with another
     device, and an access by a driver unrelated to the VF may cause a bus
     error.

Warn about attempts to update VF BARs while they are enabled.  This is a
programming error, so use dev_WARN() to get a backtrace.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/iov.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index d00ed5c..a800ba2 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -584,6 +584,7 @@ void pci_iov_update_resource(struct pci_dev *dev, int resno)
 	struct resource *res = dev->resource + resno;
 	int vf_bar = resno - PCI_IOV_RESOURCES;
 	struct pci_bus_region region;
+	u16 cmd;
 	u32 new;
 	int reg;
 
@@ -595,6 +596,13 @@ void pci_iov_update_resource(struct pci_dev *dev, int resno)
 	if (!iov)
 		return;
 
+	pci_read_config_word(dev, iov->pos + PCI_SRIOV_CTRL, &cmd);
+	if ((cmd & PCI_SRIOV_CTRL_VFE) && (cmd & PCI_SRIOV_CTRL_MSE)) {
+		dev_WARN(&dev->dev, "can't update enabled VF BAR%d %pR\n",
+			 vf_bar, res);
+		return;
+	}
+
 	/*
 	 * Ignore unimplemented BARs, unused resource slots for 64-bit
 	 * BARs, and non-movable resources, e.g., those described via
