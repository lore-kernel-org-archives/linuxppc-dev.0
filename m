Return-Path: <agordeev@dhcp-26-207.brq.redhat.com>
Received: from dhcp-26-207.brq.redhat.com (unknown [89.24.186.221])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 6A6722C0085
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Oct 2013 03:17:50 +1000 (EST)
From: Alexander Gordeev <agordeev@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH RFC 37/77] ipr: Update MSI/MSI-X interrupts enablement code
Date: Wed,  2 Oct 2013 12:48:53 +0200
Message-Id: <5bc4414bf44d7ded72c38333225b9057b3427869.1380703263.git.agordeev@redhat.com>
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
 drivers/scsi/ipr.c |   46 +++++++++++++++++++++++-----------------------
 1 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/scsi/ipr.c b/drivers/scsi/ipr.c
index 762a93e..86ed0a2 100644
--- a/drivers/scsi/ipr.c
+++ b/drivers/scsi/ipr.c
@@ -9247,45 +9247,45 @@ static int ipr_enable_msix(struct ipr_ioa_cfg *ioa_cfg)
 	struct msix_entry entries[IPR_MAX_MSIX_VECTORS];
 	int i, err, vectors;
 
-	for (i = 0; i < ARRAY_SIZE(entries); ++i)
-		entries[i].entry = i;
+	err = pci_msix_table_size(ioa_cfg->pdev);
+	if (err < 0)
+		return err;
 
-	vectors = ipr_number_of_msix;
+	vectors = min_t(int, err, ipr_number_of_msix);
 
-	while ((err = pci_enable_msix(ioa_cfg->pdev, entries, vectors)) > 0)
-			vectors = err;
+	BUG_ON(vectors > ARRAY_SIZE(entries));
+	for (i = 0; i < vectors; ++i)
+		entries[i].entry = i;
 
-	if (err < 0)
+	err = pci_enable_msix(ioa_cfg->pdev, entries, vectors);
+	if (err)
 		return err;
 
-	if (!err) {
-		for (i = 0; i < vectors; i++)
-			ioa_cfg->vectors_info[i].vec = entries[i].vector;
-		ioa_cfg->nvectors = vectors;
-	}
+	for (i = 0; i < vectors; i++)
+		ioa_cfg->vectors_info[i].vec = entries[i].vector;
+	ioa_cfg->nvectors = vectors;
 
-	return err;
+	return 0;
 }
 
 static int ipr_enable_msi(struct ipr_ioa_cfg *ioa_cfg)
 {
 	int i, err, vectors;
 
-	vectors = ipr_number_of_msix;
-
-	while ((err = pci_enable_msi_block(ioa_cfg->pdev, vectors)) > 0)
-			vectors = err;
-
+	err = pci_get_msi_cap(ioa_cfg->pdev);
 	if (err < 0)
 		return err;
 
-	if (!err) {
-		for (i = 0; i < vectors; i++)
-			ioa_cfg->vectors_info[i].vec = ioa_cfg->pdev->irq + i;
-		ioa_cfg->nvectors = vectors;
-	}
+	vectors = min_t(int, err, ipr_number_of_msix);
+	err = pci_enable_msi_block(ioa_cfg->pdev, vectors);
+	if (err)
+		return err;
+
+	for (i = 0; i < vectors; i++)
+		ioa_cfg->vectors_info[i].vec = ioa_cfg->pdev->irq + i;
+	ioa_cfg->nvectors = vectors;
 
-	return err;
+	return 0;
 }
 
 static void name_msi_vectors(struct ipr_ioa_cfg *ioa_cfg)
-- 
1.7.7.6
