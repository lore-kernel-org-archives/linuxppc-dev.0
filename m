Return-Path: <helgaas@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tSVYZ4RBmzDwBf
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2016 15:14:26 +1100 (AEDT)
Subject: [PATCH v4 1/7] PCI: Do any VF BAR updates before enabling the BARs
From: Bjorn Helgaas <bhelgaas@google.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: clsoto@us.ibm.com, benh@kernel.crashing.org, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au
Date: Mon, 28 Nov 2016 22:14:06 -0600
Message-ID: <20161129041406.21453.62657.stgit@bhelgaas-glaptop.roam.corp.google.com>
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

From: Gavin Shan <gwshan@linux.vnet.ibm.com>

Previously we enabled VFs and enable their memory space before calling
pcibios_sriov_enable().  But pcibios_sriov_enable() may update the VF BARs:
for example, on PPC PowerNV we may change them to manage the association of
VFs to PEs.

Because 64-bit BARs cannot be updated atomically, it's unsafe to update
them while they're enabled.  The half-updated state may conflict with other
devices in the system.

Call pcibios_sriov_enable() before enabling the VFs so any BAR updates
happen while the VF BARs are disabled.

[bhelgaas: changelog]
Tested-by: Carol Soto <clsoto@us.ibm.com>
Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/iov.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index e30f05c..d41ec29 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -306,13 +306,6 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
 			return rc;
 	}
 
-	pci_iov_set_numvfs(dev, nr_virtfn);
-	iov->ctrl |= PCI_SRIOV_CTRL_VFE | PCI_SRIOV_CTRL_MSE;
-	pci_cfg_access_lock(dev);
-	pci_write_config_word(dev, iov->pos + PCI_SRIOV_CTRL, iov->ctrl);
-	msleep(100);
-	pci_cfg_access_unlock(dev);
-
 	iov->initial_VFs = initial;
 	if (nr_virtfn < initial)
 		initial = nr_virtfn;
@@ -323,6 +316,13 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
 		goto err_pcibios;
 	}
 
+	pci_iov_set_numvfs(dev, nr_virtfn);
+	iov->ctrl |= PCI_SRIOV_CTRL_VFE | PCI_SRIOV_CTRL_MSE;
+	pci_cfg_access_lock(dev);
+	pci_write_config_word(dev, iov->pos + PCI_SRIOV_CTRL, iov->ctrl);
+	msleep(100);
+	pci_cfg_access_unlock(dev);
+
 	for (i = 0; i < initial; i++) {
 		rc = pci_iov_add_virtfn(dev, i, 0);
 		if (rc)
