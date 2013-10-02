Return-Path: <agordeev@dhcp-26-207.brq.redhat.com>
Received: from dhcp-26-207.brq.redhat.com (unknown [89.24.186.221])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 1A6782C009C
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Oct 2013 03:23:34 +1000 (EST)
From: Alexander Gordeev <agordeev@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH RFC 55/77] ntb: Update MSI/MSI-X interrupts enablement code
Date: Wed,  2 Oct 2013 12:49:11 +0200
Message-Id: <49eb592e15aaec804f9c11ca132d2b85c516aefa.1380703263.git.agordeev@redhat.com>
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
 drivers/ntb/ntb_hw.c |   41 +++++++++++++----------------------------
 drivers/ntb/ntb_hw.h |    2 --
 2 files changed, 13 insertions(+), 30 deletions(-)

diff --git a/drivers/ntb/ntb_hw.c b/drivers/ntb/ntb_hw.c
index eccd5e5..7776429 100644
--- a/drivers/ntb/ntb_hw.c
+++ b/drivers/ntb/ntb_hw.c
@@ -1032,23 +1032,26 @@ static int ntb_setup_msix(struct ntb_device *ndev)
 	struct msix_entry *msix;
 	int msix_entries;
 	int rc, i;
-	u16 val;
 
-	if (!pdev->msix_cap) {
-		rc = -EIO;
+	rc = pci_msix_table_size(pdev);
+	if (rc < 0)
 		goto err;
-	}
 
-	rc = pci_read_config_word(pdev, pdev->msix_cap + PCI_MSIX_FLAGS, &val);
-	if (rc)
+	/*
+	 * On SNB, the link interrupt is always tied to 4th vector.  If
+	 * we can't get all 4, then we can't use MSI-X.
+	 */
+	if ((rc < SNB_MSIX_CNT) && (ndev->hw_type != BWD_HW)) {
+		rc = -ENOSPC;
 		goto err;
-
-	msix_entries = msix_table_size(val);
-	if (msix_entries > ndev->limits.msix_cnt) {
+	}
+	if (rc > ndev->limits.msix_cnt) {
 		rc = -EINVAL;
 		goto err;
 	}
 
+	msix_entries = rc;
+
 	ndev->msix_entries = kmalloc(sizeof(struct msix_entry) * msix_entries,
 				     GFP_KERNEL);
 	if (!ndev->msix_entries) {
@@ -1060,26 +1063,8 @@ static int ntb_setup_msix(struct ntb_device *ndev)
 		ndev->msix_entries[i].entry = i;
 
 	rc = pci_enable_msix(pdev, ndev->msix_entries, msix_entries);
-	if (rc < 0)
+	if (rc)
 		goto err1;
-	if (rc > 0) {
-		/* On SNB, the link interrupt is always tied to 4th vector.  If
-		 * we can't get all 4, then we can't use MSI-X.
-		 */
-		if ((rc < SNB_MSIX_CNT) && (ndev->hw_type != BWD_HW)) {
-			rc = -EIO;
-			goto err1;
-		}
-
-		dev_warn(&pdev->dev,
-			 "Only %d MSI-X vectors.  Limiting the number of queues to that number.\n",
-			 rc);
-		msix_entries = rc;
-
-		rc = pci_enable_msix(pdev, ndev->msix_entries, msix_entries);
-		if (rc)
-			goto err1;
-	}
 
 	for (i = 0; i < msix_entries; i++) {
 		msix = &ndev->msix_entries[i];
diff --git a/drivers/ntb/ntb_hw.h b/drivers/ntb/ntb_hw.h
index 0a31ced..50bd760 100644
--- a/drivers/ntb/ntb_hw.h
+++ b/drivers/ntb/ntb_hw.h
@@ -60,8 +60,6 @@
 #define PCI_DEVICE_ID_INTEL_NTB_SS_HSX		0x2F0F
 #define PCI_DEVICE_ID_INTEL_NTB_B2B_BWD		0x0C4E
 
-#define msix_table_size(control)	((control & PCI_MSIX_FLAGS_QSIZE)+1)
-
 #ifndef readq
 static inline u64 readq(void __iomem *addr)
 {
-- 
1.7.7.6
