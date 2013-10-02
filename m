Return-Path: <agordeev@dhcp-26-207.brq.redhat.com>
Received: from dhcp-26-207.brq.redhat.com (unknown [89.24.186.221])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 99DC02C112F
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Oct 2013 03:58:31 +1000 (EST)
From: Alexander Gordeev <agordeev@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH RFC 32/77] hpsa: Fallback to single MSI mode in case MSI-X
 failed
Date: Wed,  2 Oct 2013 12:48:48 +0200
Message-Id: <a8343fb00f8dfdcb637913b5a691dcea7ecffffc.1380703263.git.agordeev@redhat.com>
In-Reply-To: <cover.1380703262.git.agordeev@redhat.com>
References: <cover.1380703262.git.agordeev@redhat.com>
Cc: linux-mips@linux-mips.org, "VMware, Inc." <pv-drivers@vmware.com>,
 linux-nvme@lists.infradead.org, linux-ide@vger.kernel.org,
 stable@vger.kernel.org, linux-s390@vger.kernel.org,
 Andy King <acking@vmware.com>, linux-scsi@vger.kernel.org,
 linux-rdma@vger.kernel.org, x86@kernel.org,
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
 drivers/scsi/hpsa.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/hpsa.c b/drivers/scsi/hpsa.c
index eb17b3d..252b65d 100644
--- a/drivers/scsi/hpsa.c
+++ b/drivers/scsi/hpsa.c
@@ -4112,7 +4112,7 @@ static void hpsa_interrupt_mode(struct ctlr_info *h)
 
 		err = pci_msix_table_size(h->pdev);
 		if (err < ARRAY_SIZE(hpsa_msix_entries))
-			goto default_int_mode;
+			goto single_msi_mode;
 
 		for (i = 0; i < ARRAY_SIZE(hpsa_msix_entries); i++) {
 			hpsa_msix_entries[i].vector = 0;
@@ -4128,8 +4128,9 @@ static void hpsa_interrupt_mode(struct ctlr_info *h)
 			return;
 		}
 		dev_warn(&h->pdev->dev, "MSI-X init failed %d\n", err);
-		goto default_int_mode;
+		goto single_msi_mode;
 	}
+single_msi_mode:
 	if (pci_find_capability(h->pdev, PCI_CAP_ID_MSI)) {
 		dev_info(&h->pdev->dev, "MSI\n");
 		if (!pci_enable_msi(h->pdev))
-- 
1.7.7.6
