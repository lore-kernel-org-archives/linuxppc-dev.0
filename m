Return-Path: <agordeev@dhcp-26-207.brq.redhat.com>
Received: from dhcp-26-207.brq.redhat.com (unknown [89.24.186.221])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id C63102C0429
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Oct 2013 04:01:32 +1000 (EST)
From: Alexander Gordeev <agordeev@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH RFC 73/77] vmxnet3: Return -ENOSPC when not enough MSI-X
 vectors available
Date: Wed,  2 Oct 2013 12:49:29 +0200
Message-Id: <a24303b6fa85cfb01b4e1b6c67ff26825824d7f7.1380703263.git.agordeev@redhat.com>
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
 drivers/net/vmxnet3/vmxnet3_drv.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/vmxnet3/vmxnet3_drv.c b/drivers/net/vmxnet3/vmxnet3_drv.c
index 3518173..3df7f32 100644
--- a/drivers/net/vmxnet3/vmxnet3_drv.c
+++ b/drivers/net/vmxnet3/vmxnet3_drv.c
@@ -2752,7 +2752,10 @@ vmxnet3_acquire_msix_vectors(struct vmxnet3_adapter *adapter,
 				   "Failed to enable MSI-X, error: %d\n", err);
 			return err;
 		} else if (err < vector_threshold) {
-			break;
+			dev_info(&adapter->pdev->dev,
+				 "Number of MSI-Xs which can be allocated "
+				 "is lower than min threshold required.\n");
+			return -ENOSPC;
 		} else {
 			/* If fails to enable required number of MSI-x vectors
 			 * try enabling minimum number of vectors required.
@@ -2764,9 +2767,6 @@ vmxnet3_acquire_msix_vectors(struct vmxnet3_adapter *adapter,
 		}
 	}
 
-	dev_info(&adapter->pdev->dev,
-		 "Number of MSI-X interrupts which can be allocated "
-		 "is lower than min threshold required.\n");
 	return err;
 }
 
-- 
1.7.7.6
