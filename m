Return-Path: <agordeev@dhcp-26-207.brq.redhat.com>
Received: from dhcp-26-207.brq.redhat.com (unknown [89.24.186.221])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 0815F2C00A2
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Oct 2013 03:14:58 +1000 (EST)
From: Alexander Gordeev <agordeev@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH RFC 12/77] benet: Update MSI/MSI-X interrupts enablement code
Date: Wed,  2 Oct 2013 12:48:28 +0200
Message-Id: <4a8384c64f822aaed962169532bde927ac382ca0.1380703262.git.agordeev@redhat.com>
In-Reply-To: <cover.1380703262.git.agordeev@redhat.com>
References: <cover.1380703262.git.agordeev@redhat.com>
Cc: linux-mips@linux-mips.org, "VMware, Inc." <pv-drivers@vmware.com>,
 linux-nvme@lists.infradead.org, linux-ide@vger.kernel.org,
 linux-s390@vger.kernel.org, Andy King <acking@vmware.com>,
 linux-scsi@vger.kernel.org, linux-rdma@vger.kernel.org, x86@kernel.org,
 Alexander Gordeev <agordeev@redhat.com>, linux-pci@vger.kernel.org,
 iss_storagedev@hp.com, linux-driver@qlogic.com, Tejun Heo <tj@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <dan.j.williams@intel.com>,
 Jon Mason <jon.mason@intel.com>, Ingo Molnar <mingo@redhat.com>,
 Solarflare linux maintainers <linux-net-drivers@solarflare.com>,
 netdev@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
 e1000-devel@lists.sourceforge.net, Martin Schwidefsky <schwidefsky@de.ibm.com>,
 linux390@de.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

As result of recent re-design of the MSI/MSI-X interrupts enabling
pattern this driver has to be updated to use the new technique to
obtain a optimal number of MSI/MSI-X interrupts required.

Signed-off-by: Alexander Gordeev <agordeev@redhat.com>
---
 drivers/net/ethernet/emulex/benet/be_main.c |   38 ++++++++++++++------------
 1 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/emulex/benet/be_main.c b/drivers/net/ethernet/emulex/benet/be_main.c
index 3e2c834..84d560d 100644
--- a/drivers/net/ethernet/emulex/benet/be_main.c
+++ b/drivers/net/ethernet/emulex/benet/be_main.c
@@ -2366,29 +2366,23 @@ static int be_msix_enable(struct be_adapter *adapter)
 	else
 		num_vec = adapter->cfg_num_qs;
 
-	for (i = 0; i < num_vec; i++)
-		adapter->msix_entries[i].entry = i;
+	status = pci_msix_table_size(adapter->pdev);
+	if (status < 0)
+		goto fail;
 
-	status = pci_enable_msix(adapter->pdev, adapter->msix_entries, num_vec);
-	if (status == 0) {
-		goto done;
-	} else if (status >= MIN_MSIX_VECTORS) {
-		num_vec = status;
-		status = pci_enable_msix(adapter->pdev, adapter->msix_entries,
-					 num_vec);
-		if (!status)
-			goto done;
-	} else (status > 0) {
+	num_vec = min(num_vec, status);
+	if (num_vec < MIN_MSIX_VECTORS) {
 		status = -ENOSPC;
+		goto fail;
 	}
 
-	dev_warn(dev, "MSIx enable failed\n");
+	for (i = 0; i < num_vec; i++)
+		adapter->msix_entries[i].entry = i;
+
+	status = pci_enable_msix(adapter->pdev, adapter->msix_entries, num_vec);
+	if (status)
+		goto fail;
 
-	/* INTx is not supported in VFs, so fail probe if enable_msix fails */
-	if (!be_physfn(adapter))
-		return status;
-	return 0;
-done:
 	if (be_roce_supported(adapter) && num_vec > MIN_MSIX_VECTORS) {
 		adapter->num_msix_roce_vec = num_vec / 2;
 		dev_info(dev, "enabled %d MSI-x vector(s) for RoCE\n",
@@ -2400,6 +2394,14 @@ done:
 	dev_info(dev, "enabled %d MSI-x vector(s) for NIC\n",
 		 adapter->num_msix_vec);
 	return 0;
+
+fail:
+	dev_warn(dev, "MSIx enable failed\n");
+
+	/* INTx is not supported in VFs, so fail probe if enable_msix fails */
+	if (!be_physfn(adapter))
+		return status;
+	return 0;
 }
 
 static inline int be_msix_vec_get(struct be_adapter *adapter,
-- 
1.7.7.6
