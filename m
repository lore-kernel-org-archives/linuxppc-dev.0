Return-Path: <agordeev@dhcp-26-207.brq.redhat.com>
Received: from dhcp-26-207.brq.redhat.com (unknown [89.24.186.221])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 944342C1DFB
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Oct 2013 04:04:59 +1000 (EST)
From: Alexander Gordeev <agordeev@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH RFC 74/77] vmxnet3: Limit number of rx queues to 1 if
 per-queue MSI-Xs failed
Date: Wed,  2 Oct 2013 12:49:30 +0200
Message-Id: <f029865a23808e2f788f90f878355fddf3b04ad2.1380703263.git.agordeev@redhat.com>
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
 drivers/net/vmxnet3/vmxnet3_drv.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/vmxnet3/vmxnet3_drv.c b/drivers/net/vmxnet3/vmxnet3_drv.c
index 3df7f32..00dc0d0 100644
--- a/drivers/net/vmxnet3/vmxnet3_drv.c
+++ b/drivers/net/vmxnet3/vmxnet3_drv.c
@@ -2814,12 +2814,14 @@ vmxnet3_alloc_intr_resources(struct vmxnet3_adapter *adapter)
 
 		err = vmxnet3_acquire_msix_vectors(adapter,
 						   adapter->intr.num_intrs);
-		/* If we cannot allocate one MSIx vector per queue
-		 * then limit the number of rx queues to 1
-		 */
-		if (err == VMXNET3_LINUX_MIN_MSIX_VECT) {
-			if (adapter->share_intr != VMXNET3_INTR_BUDDYSHARE
-			    || adapter->num_rx_queues != 1) {
+		if (!err) {
+			/* If we cannot allocate one MSIx vector per queue
+			 * then limit the number of rx queues to 1
+			 */
+			if ((adapter->intr.num_intrs ==
+			     VMXNET3_LINUX_MIN_MSIX_VECT) &&
+			    ((adapter->share_intr != VMXNET3_INTR_BUDDYSHARE) ||
+			     (adapter->num_rx_queues != 1))) {
 				adapter->share_intr = VMXNET3_INTR_TXSHARE;
 				netdev_err(adapter->netdev,
 					   "Number of rx queues : 1\n");
@@ -2829,8 +2831,6 @@ vmxnet3_alloc_intr_resources(struct vmxnet3_adapter *adapter)
 			}
 			return;
 		}
-		if (!err)
-			return;
 
 		/* If we cannot allocate MSIx vectors use only one rx queue */
 		dev_info(&adapter->pdev->dev,
-- 
1.7.7.6
