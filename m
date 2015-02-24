Return-Path: <bhelgaas@google.com>
Received: from mail-pa0-x235.google.com (mail-pa0-x235.google.com
 [IPv6:2607:f8b0:400e:c03::235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46E8A1A12D6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Feb 2015 19:33:56 +1100 (AEDT)
Received: by pablf10 with SMTP id lf10so34397676pab.6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Feb 2015 00:33:54 -0800 (PST)
Subject: [PATCH v12 08/21] PCI: Add pcibios_sriov_enable() and
 pcibios_sriov_disable()
To: Wei Yang <weiyang@linux.vnet.ibm.com>, benh@au1.ibm.com,
 gwshan@linux.vnet.ibm.com
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 24 Feb 2015 02:33:52 -0600
Message-ID: <20150224083352.32124.63952.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20150224082939.32124.45744.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20150224082939.32124.45744.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Wei Yang <weiyang@linux.vnet.ibm.com>

VFs are dynamically created when a driver enables them.  On some platforms,
like PowerNV, special resources are necessary to enable VFs.

Add platform hooks for enabling and disabling VFs.

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/iov.c |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 5643a1011e23..cc6fedf4a1b9 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -220,6 +220,11 @@ static void virtfn_remove(struct pci_dev *dev, int id, int reset)
 	pci_dev_put(dev);
 }
 
+int __weak pcibios_sriov_enable(struct pci_dev *pdev, u16 vf_num)
+{
+       return 0;
+}
+
 static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
 {
 	int rc;
@@ -231,6 +236,7 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
 	struct pci_sriov *iov = dev->sriov;
 	int bars = 0;
 	int bus;
+	int retval;
 
 	if (!nr_virtfn)
 		return 0;
@@ -307,6 +313,12 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
 	if (nr_virtfn < initial)
 		initial = nr_virtfn;
 
+	if ((retval = pcibios_sriov_enable(dev, initial))) {
+		dev_err(&dev->dev, "failure %d from pcibios_sriov_enable()\n",
+			retval);
+		return retval;
+	}
+
 	for (i = 0; i < initial; i++) {
 		rc = virtfn_add(dev, i, 0);
 		if (rc)
@@ -335,6 +347,11 @@ failed:
 	return rc;
 }
 
+int __weak pcibios_sriov_disable(struct pci_dev *pdev)
+{
+       return 0;
+}
+
 static void sriov_disable(struct pci_dev *dev)
 {
 	int i;
@@ -346,6 +363,8 @@ static void sriov_disable(struct pci_dev *dev)
 	for (i = 0; i < iov->num_VFs; i++)
 		virtfn_remove(dev, i, 0);
 
+	pcibios_sriov_disable(dev);
+
 	iov->ctrl &= ~(PCI_SRIOV_CTRL_VFE | PCI_SRIOV_CTRL_MSE);
 	pci_cfg_access_lock(dev);
 	pci_write_config_word(dev, iov->pos + PCI_SRIOV_CTRL, iov->ctrl);
