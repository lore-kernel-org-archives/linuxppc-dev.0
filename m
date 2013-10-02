Return-Path: <agordeev@dhcp-26-207.brq.redhat.com>
Received: from dhcp-26-207.brq.redhat.com (unknown [89.24.186.221])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 6BC3F2C007E
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Oct 2013 02:46:06 +1000 (EST)
From: Alexander Gordeev <agordeev@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH RFC 46/77] mlx4: Update MSI/MSI-X interrupts enablement code
Date: Wed,  2 Oct 2013 12:49:02 +0200
Message-Id: <b0a9f6f455aa03b7769e6d9cc2e7fdbc06732b2f.1380703263.git.agordeev@redhat.com>
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
 drivers/net/ethernet/mellanox/mlx4/main.c |   17 ++++++++---------
 1 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/main.c b/drivers/net/ethernet/mellanox/mlx4/main.c
index 60c9f4f..377a5ea 100644
--- a/drivers/net/ethernet/mellanox/mlx4/main.c
+++ b/drivers/net/ethernet/mellanox/mlx4/main.c
@@ -1852,8 +1852,16 @@ static void mlx4_enable_msi_x(struct mlx4_dev *dev)
 	int i;
 
 	if (msi_x) {
+		err = pci_msix_table_size(dev->pdev);
+		if (err < 0)
+			goto no_msi;
+
+		/* Try if at least 2 vectors are available */
 		nreq = min_t(int, dev->caps.num_eqs - dev->caps.reserved_eqs,
 			     nreq);
+		nreq = min_t(int, nreq, err);
+		if (nreq < 2)
+			goto no_msi;
 
 		entries = kcalloc(nreq, sizeof *entries, GFP_KERNEL);
 		if (!entries)
@@ -1862,17 +1870,8 @@ static void mlx4_enable_msi_x(struct mlx4_dev *dev)
 		for (i = 0; i < nreq; ++i)
 			entries[i].entry = i;
 
-	retry:
 		err = pci_enable_msix(dev->pdev, entries, nreq);
 		if (err) {
-			/* Try again if at least 2 vectors are available */
-			if (err > 1) {
-				mlx4_info(dev, "Requested %d vectors, "
-					  "but only %d MSI-X vectors available, "
-					  "trying again\n", nreq, err);
-				nreq = err;
-				goto retry;
-			}
 			kfree(entries);
 			goto no_msi;
 		}
-- 
1.7.7.6
