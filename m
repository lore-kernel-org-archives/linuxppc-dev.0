Return-Path: <agordeev@dhcp-26-207.brq.redhat.com>
Received: from dhcp-26-207.brq.redhat.com (unknown [89.24.186.221])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 8C5652C0077
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Oct 2013 02:59:00 +1000 (EST)
From: Alexander Gordeev <agordeev@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH RFC 40/77] ixgbevf: Update MSI/MSI-X interrupts enablement code
Date: Wed,  2 Oct 2013 12:48:56 +0200
Message-Id: <338c9012577acf694eb23622902185584987bd8f.1380703263.git.agordeev@redhat.com>
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
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c |   18 +++++++-----------
 1 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index fa0537a..d506a01 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -1749,8 +1749,7 @@ void ixgbevf_reset(struct ixgbevf_adapter *adapter)
 static int ixgbevf_acquire_msix_vectors(struct ixgbevf_adapter *adapter,
 					int vectors)
 {
-	int err = 0;
-	int vector_threshold;
+	int err, vector_threshold;
 
 	/* We'll want at least 2 (vector_threshold):
 	 * 1) TxQ[0] + RxQ[0] handler
@@ -1763,18 +1762,15 @@ static int ixgbevf_acquire_msix_vectors(struct ixgbevf_adapter *adapter,
 	 * Right now, we simply care about how many we'll get; we'll
 	 * set them up later while requesting irq's.
 	 */
-	while (vectors >= vector_threshold) {
-		err = pci_enable_msix(adapter->pdev, adapter->msix_entries,
-				      vectors);
-		if (!err || err < 0) /* Success or a nasty failure. */
-			break;
-		else /* err == number of vectors we should try again with */
-			vectors = err;
-	}
+	err = pci_msix_table_size(adapter->pdev);
+	if (err < 0)
+		return err;
 
+	vectors = min(vectors, err);
 	if (vectors < vector_threshold)
-		err = -ENOSPC;
+		return -ENOSPC;
 
+	err = pci_enable_msix(adapter->pdev, adapter->msix_entries, vectors);
 	if (err) {
 		dev_err(&adapter->pdev->dev,
 			"Unable to allocate MSI-X interrupts\n");
-- 
1.7.7.6
