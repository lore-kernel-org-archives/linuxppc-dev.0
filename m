Return-Path: <agordeev@dhcp-26-207.brq.redhat.com>
Received: from dhcp-26-207.brq.redhat.com (unknown [89.24.186.221])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 619952C00C6
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Oct 2013 03:00:22 +1000 (EST)
From: Alexander Gordeev <agordeev@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH RFC 67/77] rapidio: Update MSI/MSI-X interrupts enablement code
Date: Wed,  2 Oct 2013 12:49:23 +0200
Message-Id: <d73f825db39f969247aa80380da2a9c41c101f09.1380703263.git.agordeev@redhat.com>
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
 drivers/rapidio/devices/tsi721.c |   27 +++++++++++++++++----------
 1 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/rapidio/devices/tsi721.c b/drivers/rapidio/devices/tsi721.c
index ff7cbf2..5edd920 100644
--- a/drivers/rapidio/devices/tsi721.c
+++ b/drivers/rapidio/devices/tsi721.c
@@ -734,6 +734,16 @@ static int tsi721_enable_msix(struct tsi721_device *priv)
 	int err;
 	int i;
 
+	err = pci_msix_table_size(priv->pdev);
+	if (err < 0)
+		goto err_out;
+	if (err < ARRAY_SIZE(entries)) {
+		dev_info(&priv->pdev->dev,
+			 "Only %d MSI-X vectors available, not using MSI-X\n",
+			 err);
+		return -ENOSPC;
+	}
+
 	entries[TSI721_VECT_IDB].entry = TSI721_MSIX_SR2PC_IDBQ_RCV(IDB_QUEUE);
 	entries[TSI721_VECT_PWRX].entry = TSI721_MSIX_SRIO_MAC_INT;
 
@@ -769,16 +779,8 @@ static int tsi721_enable_msix(struct tsi721_device *priv)
 #endif /* CONFIG_RAPIDIO_DMA_ENGINE */
 
 	err = pci_enable_msix(priv->pdev, entries, ARRAY_SIZE(entries));
-	if (err) {
-		if (err > 0)
-			dev_info(&priv->pdev->dev,
-				 "Only %d MSI-X vectors available, "
-				 "not using MSI-X\n", err);
-		else
-			dev_err(&priv->pdev->dev,
-				"Failed to enable MSI-X (err=%d)\n", err);
-		return err;
-	}
+	if (err)
+		goto err_out;
 
 	/*
 	 * Copy MSI-X vector information into tsi721 private structure
@@ -833,6 +835,11 @@ static int tsi721_enable_msix(struct tsi721_device *priv)
 #endif /* CONFIG_RAPIDIO_DMA_ENGINE */
 
 	return 0;
+
+err_out:
+	dev_err(&priv->pdev->dev,
+		"Failed to enable MSI-X (err=%d)\n", err);
+	return err;
 }
 #endif /* CONFIG_PCI_MSI */
 
-- 
1.7.7.6
