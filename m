Return-Path: <bhelgaas@google.com>
Received: from mail-pa0-x22f.google.com (mail-pa0-x22f.google.com
 [IPv6:2607:f8b0:400e:c03::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CD9341A10FA
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Feb 2015 19:33:27 +1100 (AEDT)
Received: by pablf10 with SMTP id lf10so34324729pab.12
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Feb 2015 00:33:26 -0800 (PST)
Subject: [PATCH v12 04/21] PCI: Index IOV resources in the conventional style
To: Wei Yang <weiyang@linux.vnet.ibm.com>, benh@au1.ibm.com,
 gwshan@linux.vnet.ibm.com
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 24 Feb 2015 02:33:24 -0600
Message-ID: <20150224083324.32124.74934.stgit@bhelgaas-glaptop2.roam.corp.google.com>
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

Most of PCI uses "res = &dev->resource[i]", not "res = dev->resource + i".
Use that style in iov.c also.

No functional change.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/iov.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 5bca0e1a2799..27b98c361823 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -95,7 +95,7 @@ static int virtfn_add(struct pci_dev *dev, int id, int reset)
 	virtfn->multifunction = 0;
 
 	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
-		res = dev->resource + PCI_IOV_RESOURCES + i;
+		res = &dev->resource[i + PCI_IOV_RESOURCES];
 		if (!res->parent)
 			continue;
 		virtfn->resource[i].name = pci_name(virtfn);
@@ -212,7 +212,7 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
 	nres = 0;
 	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
 		bars |= (1 << (i + PCI_IOV_RESOURCES));
-		res = dev->resource + PCI_IOV_RESOURCES + i;
+		res = &dev->resource[i + PCI_IOV_RESOURCES];
 		if (res->parent)
 			nres++;
 	}
@@ -373,7 +373,7 @@ found:
 
 	nres = 0;
 	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
-		res = dev->resource + PCI_IOV_RESOURCES + i;
+		res = &dev->resource[i + PCI_IOV_RESOURCES];
 		bar64 = __pci_read_base(dev, pci_bar_unknown, res,
 					pos + PCI_SRIOV_BAR + i * 4);
 		if (!res->flags)
@@ -417,7 +417,7 @@ found:
 
 failed:
 	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
-		res = dev->resource + PCI_IOV_RESOURCES + i;
+		res = &dev->resource[i + PCI_IOV_RESOURCES];
 		res->flags = 0;
 	}
 
