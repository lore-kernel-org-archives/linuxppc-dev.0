Return-Path: <agordeev@dhcp-26-207.brq.redhat.com>
Received: from dhcp-26-207.brq.redhat.com (unknown [89.24.186.221])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id F005B2C00BD
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Oct 2013 02:47:27 +1000 (EST)
From: Alexander Gordeev <agordeev@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH RFC 16/77] cciss: Update MSI/MSI-X interrupts enablement code
Date: Wed,  2 Oct 2013 12:48:32 +0200
Message-Id: <0498333a0ddc360d43d4496310917a5d0f9a51fd.1380703262.git.agordeev@redhat.com>
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
 drivers/block/cciss.c |   17 +++++++----------
 1 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/block/cciss.c b/drivers/block/cciss.c
index d2d95ff..80068a0 100644
--- a/drivers/block/cciss.c
+++ b/drivers/block/cciss.c
@@ -4079,7 +4079,11 @@ static void cciss_interrupt_mode(ctlr_info_t *h)
 		goto default_int_mode;
 
 	if (pci_find_capability(h->pdev, PCI_CAP_ID_MSIX)) {
-		err = pci_enable_msix(h->pdev, cciss_msix_entries, 4);
+		err = pci_msix_table_size(h->pdev);
+		if (err < ARRAY_SIZE(cciss_msix_entries))
+			goto default_int_mode;
+		err = pci_enable_msix(h->pdev, cciss_msix_entries,
+				      ARRAY_SIZE(cciss_msix_entries));
 		if (!err) {
 			h->intr[0] = cciss_msix_entries[0].vector;
 			h->intr[1] = cciss_msix_entries[1].vector;
@@ -4088,15 +4092,8 @@ static void cciss_interrupt_mode(ctlr_info_t *h)
 			h->msix_vector = 1;
 			return;
 		}
-		if (err > 0) {
-			dev_warn(&h->pdev->dev,
-				"only %d MSI-X vectors available\n", err);
-			goto default_int_mode;
-		} else {
-			dev_warn(&h->pdev->dev,
-				"MSI-X init failed %d\n", err);
-			goto default_int_mode;
-		}
+		dev_warn(&h->pdev->dev, "MSI-X init failed %d\n", err);
+		goto default_int_mode;
 	}
 	if (pci_find_capability(h->pdev, PCI_CAP_ID_MSI)) {
 		if (!pci_enable_msi(h->pdev))
-- 
1.7.7.6
