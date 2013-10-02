Return-Path: <agordeev@dhcp-26-207.brq.redhat.com>
Received: from dhcp-26-207.brq.redhat.com (unknown [89.24.186.221])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id DFCDD2C0587
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Oct 2013 03:31:59 +1000 (EST)
From: Alexander Gordeev <agordeev@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH RFC 64/77] qlcnic: Make MSI-X initialization routine bit more
 readable
Date: Wed,  2 Oct 2013 12:49:20 +0200
Message-Id: <685e235adcdeafb5e72b5fe1efe63f8f03a8f035.1380703263.git.agordeev@redhat.com>
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

Signed-off-by: Alexander Gordeev <agordeev@redhat.com>
---
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c |  112 +++++++++++-----------
 1 files changed, 56 insertions(+), 56 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c
index a137c14..8510457 100644
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c
@@ -568,7 +568,7 @@ int qlcnic_enable_msix(struct qlcnic_adapter *adapter, u32 num_msix)
 {
 	struct pci_dev *pdev = adapter->pdev;
 	int max_tx_rings, max_sds_rings, tx_vector;
-	int err = -EINVAL, i;
+	int err, i;
 
 	if (adapter->flags & QLCNIC_TX_INTR_SHARED) {
 		max_tx_rings = 0;
@@ -589,68 +589,68 @@ int qlcnic_enable_msix(struct qlcnic_adapter *adapter, u32 num_msix)
 	adapter->max_sds_rings = 1;
 	adapter->flags &= ~(QLCNIC_MSI_ENABLED | QLCNIC_MSIX_ENABLED);
 
-	if (adapter->ahw->msix_supported) {
-		err = pci_msix_table_size(pdev);
-		if (err < 0)
+	if (!adapter->ahw->msix_supported)
+		return -EINVAL;
+
+	err = pci_msix_table_size(pdev);
+	if (err < 0)
+		goto fail;
+
+	if (err < num_msix) {
+		dev_info(&pdev->dev,
+			 "Unable to allocate %d MSI-X interrupt vectors\n",
+			 num_msix);
+		if (qlcnic_83xx_check(adapter)) {
+			if (err < (QLC_83XX_MINIMUM_VECTOR - tx_vector))
+				return -ENOSPC;
+			err -= (max_tx_rings + 1);
+			num_msix = rounddown_pow_of_two(err);
+			num_msix += (max_tx_rings + 1);
+		} else {
+			num_msix = rounddown_pow_of_two(err);
+			if (qlcnic_check_multi_tx(adapter))
+				num_msix += max_tx_rings;
+		}
+
+		if (!num_msix) {
+			err = -ENOSPC;
 			goto fail;
+		}
 
-		if (err < num_msix) {
-			dev_info(&pdev->dev,
-				 "Unable to allocate %d MSI-X interrupt vectors\n",
-				 num_msix);
-			if (qlcnic_83xx_check(adapter)) {
-				if (err < (QLC_83XX_MINIMUM_VECTOR - tx_vector))
-					return -ENOSPC;
-				err -= (max_tx_rings + 1);
-				num_msix = rounddown_pow_of_two(err);
-				num_msix += (max_tx_rings + 1);
-			} else {
-				num_msix = rounddown_pow_of_two(err);
-				if (qlcnic_check_multi_tx(adapter))
-					num_msix += max_tx_rings;
-			}
+		dev_info(&pdev->dev,
+			 "Trying to allocate %d MSI-X interrupt vectors\n",
+			 num_msix);
+	}
 
-			if (!num_msix) {
-				err = -ENOSPC;
-				goto fail;
-			}
+	for (i = 0; i < num_msix; i++)
+		adapter->msix_entries[i].entry = i;
 
-			dev_info(&pdev->dev,
-				 "Trying to allocate %d MSI-X interrupt vectors\n",
-				 num_msix);
-			}
-		}
+	err = pci_enable_msix(pdev, adapter->msix_entries, num_msix);
+	if (err)
+		goto fail;
 
-		for (i = 0; i < num_msix; i++)
-			adapter->msix_entries[i].entry = i;
-		err = pci_enable_msix(pdev, adapter->msix_entries, num_msix);
-		if (err == 0) {
-			adapter->flags |= QLCNIC_MSIX_ENABLED;
-			if (qlcnic_83xx_check(adapter)) {
-				adapter->ahw->num_msix = num_msix;
-				/* subtract mail box and tx ring vectors */
-				adapter->max_sds_rings = num_msix -
-							 max_tx_rings - 1;
-			} else {
-				adapter->ahw->num_msix = num_msix;
-				if (qlcnic_check_multi_tx(adapter) &&
-				    !adapter->ahw->diag_test &&
-				    (adapter->max_drv_tx_rings > 1))
-					max_sds_rings = num_msix - max_tx_rings;
-				else
-					max_sds_rings = num_msix;
-
-				adapter->max_sds_rings = max_sds_rings;
-			}
-			dev_info(&pdev->dev, "using msi-x interrupts\n");
-		} else {
-fail:
-			dev_info(&pdev->dev,
-				 "Unable to allocate %d MSI-X interrupt vectors\n",
-				 num_msix);
-		}
+	adapter->flags |= QLCNIC_MSIX_ENABLED;
+	if (qlcnic_83xx_check(adapter)) {
+		adapter->ahw->num_msix = num_msix;
+		/* subtract mail box and tx ring vectors */
+		adapter->max_sds_rings = num_msix - max_tx_rings - 1;
+	} else {
+		adapter->ahw->num_msix = num_msix;
+		if (qlcnic_check_multi_tx(adapter) &&
+		    !adapter->ahw->diag_test && (adapter->max_drv_tx_rings > 1))
+			max_sds_rings = num_msix - max_tx_rings;
+		else
+			max_sds_rings = num_msix;
+
+		adapter->max_sds_rings = max_sds_rings;
 	}
 
+	dev_info(&pdev->dev, "using msi-x interrupts\n");
+	return 0;
+
+fail:
+	dev_info(&pdev->dev,
+		 "Unable to allocate %d MSI-X interrupt vectors\n", num_msix);
 	return err;
 }
 
-- 
1.7.7.6
