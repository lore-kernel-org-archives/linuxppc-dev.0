Return-Path: <agordeev@dhcp-26-207.brq.redhat.com>
Received: from dhcp-26-207.brq.redhat.com (unknown [89.24.186.221])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 471D12C00AA
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Oct 2013 03:08:50 +1000 (EST)
From: Alexander Gordeev <agordeev@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH RFC 77/77] vxge: Update MSI/MSI-X interrupts enablement code
Date: Wed,  2 Oct 2013 12:49:33 +0200
Message-Id: <467ce10b1df795edf80ed222816ab739fee7b0ea.1380703263.git.agordeev@redhat.com>
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
 drivers/net/ethernet/neterion/vxge/vxge-main.c |   36 ++++++++++-------------
 1 files changed, 16 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/neterion/vxge/vxge-main.c b/drivers/net/ethernet/neterion/vxge/vxge-main.c
index b81ff8b..b4d40dd 100644
--- a/drivers/net/ethernet/neterion/vxge/vxge-main.c
+++ b/drivers/net/ethernet/neterion/vxge/vxge-main.c
@@ -2297,7 +2297,21 @@ static int vxge_alloc_msix(struct vxgedev *vdev)
 	int msix_intr_vect = 0, temp;
 	vdev->intr_cnt = 0;
 
-start:
+	ret = pci_msix_table_size(vdev->pdev);
+	if (ret < 0)
+		goto alloc_entries_failed;
+
+	if (ret < (vdev->no_of_vpath * 2 + 1)) {
+		if ((max_config_vpath != VXGE_USE_DEFAULT) || (ret < 3)) {
+			ret = -ENOSPC;
+			goto alloc_entries_failed;
+		}
+		/* Try with less no of vector by reducing no of vpaths count */
+		temp = (ret - 1)/2;
+		vxge_close_vpaths(vdev, temp);
+		vdev->no_of_vpath = temp;
+	}
+
 	/* Tx/Rx MSIX Vectors count */
 	vdev->intr_cnt = vdev->no_of_vpath * 2;
 
@@ -2347,25 +2361,7 @@ start:
 	vdev->vxge_entries[j].in_use = 0;
 
 	ret = pci_enable_msix(vdev->pdev, vdev->entries, vdev->intr_cnt);
-	if (ret > 0) {
-		vxge_debug_init(VXGE_ERR,
-			"%s: MSI-X enable failed for %d vectors, ret: %d",
-			VXGE_DRIVER_NAME, vdev->intr_cnt, ret);
-		if ((max_config_vpath != VXGE_USE_DEFAULT) || (ret < 3)) {
-			ret = -ENOSPC;
-			goto enable_msix_failed;
-		}
-
-		kfree(vdev->entries);
-		kfree(vdev->vxge_entries);
-		vdev->entries = NULL;
-		vdev->vxge_entries = NULL;
-		/* Try with less no of vector by reducing no of vpaths count */
-		temp = (ret - 1)/2;
-		vxge_close_vpaths(vdev, temp);
-		vdev->no_of_vpath = temp;
-		goto start;
-	} else if (ret < 0)
+	if (ret)
 		goto enable_msix_failed;
 	return 0;
 
-- 
1.7.7.6
