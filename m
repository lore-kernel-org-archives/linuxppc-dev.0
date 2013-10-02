Return-Path: <agordeev@dhcp-26-207.brq.redhat.com>
Received: from dhcp-26-207.brq.redhat.com (unknown [89.24.186.221])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 2AB102C0077
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Oct 2013 03:10:42 +1000 (EST)
From: Alexander Gordeev <agordeev@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH RFC 31/77] hpsa: Update MSI/MSI-X interrupts enablement code
Date: Wed,  2 Oct 2013 12:48:47 +0200
Message-Id: <2ebbbb417719ad6501bbe59969409c1f5c63ae48.1380703263.git.agordeev@redhat.com>
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
 drivers/scsi/hpsa.c |   28 +++++++++++++---------------
 1 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/scsi/hpsa.c b/drivers/scsi/hpsa.c
index 393c8db..eb17b3d 100644
--- a/drivers/scsi/hpsa.c
+++ b/drivers/scsi/hpsa.c
@@ -4103,34 +4103,32 @@ static void hpsa_interrupt_mode(struct ctlr_info *h)
 	int err, i;
 	struct msix_entry hpsa_msix_entries[MAX_REPLY_QUEUES];
 
-	for (i = 0; i < MAX_REPLY_QUEUES; i++) {
-		hpsa_msix_entries[i].vector = 0;
-		hpsa_msix_entries[i].entry = i;
-	}
-
 	/* Some boards advertise MSI but don't really support it */
 	if ((h->board_id == 0x40700E11) || (h->board_id == 0x40800E11) ||
 	    (h->board_id == 0x40820E11) || (h->board_id == 0x40830E11))
 		goto default_int_mode;
 	if (pci_find_capability(h->pdev, PCI_CAP_ID_MSIX)) {
 		dev_info(&h->pdev->dev, "MSIX\n");
+
+		err = pci_msix_table_size(h->pdev);
+		if (err < ARRAY_SIZE(hpsa_msix_entries))
+			goto default_int_mode;
+
+		for (i = 0; i < ARRAY_SIZE(hpsa_msix_entries); i++) {
+			hpsa_msix_entries[i].vector = 0;
+			hpsa_msix_entries[i].entry = i;
+		}
+
 		err = pci_enable_msix(h->pdev, hpsa_msix_entries,
-						MAX_REPLY_QUEUES);
+				      ARRAY_SIZE(hpsa_msix_entries));
 		if (!err) {
 			for (i = 0; i < MAX_REPLY_QUEUES; i++)
 				h->intr[i] = hpsa_msix_entries[i].vector;
 			h->msix_vector = 1;
 			return;
 		}
-		if (err > 0) {
-			dev_warn(&h->pdev->dev, "only %d MSI-X vectors "
-			       "available\n", err);
-			goto default_int_mode;
-		} else {
-			dev_warn(&h->pdev->dev, "MSI-X init failed %d\n",
-			       err);
-			goto default_int_mode;
-		}
+		dev_warn(&h->pdev->dev, "MSI-X init failed %d\n", err);
+		goto default_int_mode;
 	}
 	if (pci_find_capability(h->pdev, PCI_CAP_ID_MSI)) {
 		dev_info(&h->pdev->dev, "MSI\n");
-- 
1.7.7.6
