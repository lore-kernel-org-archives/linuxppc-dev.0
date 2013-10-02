Return-Path: <agordeev@dhcp-26-207.brq.redhat.com>
Received: from dhcp-26-207.brq.redhat.com (unknown [89.24.186.221])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id D8ED82C0099
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Oct 2013 03:12:39 +1000 (EST)
From: Alexander Gordeev <agordeev@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH RFC 13/77] bna: Update MSI/MSI-X interrupts enablement code
Date: Wed,  2 Oct 2013 12:48:29 +0200
Message-Id: <e138df4579979bc0f60940258525036f5da61424.1380703262.git.agordeev@redhat.com>
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
 drivers/net/ethernet/brocade/bna/bnad.c |   34 ++++++++++++------------------
 1 files changed, 14 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/brocade/bna/bnad.c b/drivers/net/ethernet/brocade/bna/bnad.c
index b78e69e..d41257c 100644
--- a/drivers/net/ethernet/brocade/bna/bnad.c
+++ b/drivers/net/ethernet/brocade/bna/bnad.c
@@ -2469,21 +2469,11 @@ bnad_enable_msix(struct bnad *bnad)
 	if (bnad->msix_table)
 		return;
 
-	bnad->msix_table =
-		kcalloc(bnad->msix_num, sizeof(struct msix_entry), GFP_KERNEL);
-
-	if (!bnad->msix_table)
+	ret = pci_msix_table_size(bnad->pcidev);
+	if (ret < 0)
 		goto intx_mode;
 
-	for (i = 0; i < bnad->msix_num; i++)
-		bnad->msix_table[i].entry = i;
-
-	ret = pci_enable_msix(bnad->pcidev, bnad->msix_table, bnad->msix_num);
-	if (ret > 0) {
-		/* Not enough MSI-X vectors. */
-		pr_warn("BNA: %d MSI-X vectors allocated < %d requested\n",
-			ret, bnad->msix_num);
-
+	if (ret < bnad->msix_num) {
 		spin_lock_irqsave(&bnad->bna_lock, flags);
 		/* ret = #of vectors that we got */
 		bnad_q_num_adjust(bnad, (ret - BNAD_MAILBOX_MSIX_VECTORS) / 2,
@@ -2495,15 +2485,19 @@ bnad_enable_msix(struct bnad *bnad)
 
 		if (bnad->msix_num > ret)
 			goto intx_mode;
+	}
 
-		/* Try once more with adjusted numbers */
-		/* If this fails, fall back to INTx */
-		ret = pci_enable_msix(bnad->pcidev, bnad->msix_table,
-				      bnad->msix_num);
-		if (ret)
-			goto intx_mode;
+	bnad->msix_table =
+		kcalloc(bnad->msix_num, sizeof(struct msix_entry), GFP_KERNEL);
+
+	if (!bnad->msix_table)
+		goto intx_mode;
 
-	} else if (ret < 0)
+	for (i = 0; i < bnad->msix_num; i++)
+		bnad->msix_table[i].entry = i;
+
+	ret = pci_enable_msix(bnad->pcidev, bnad->msix_table, bnad->msix_num);
+	if (ret)
 		goto intx_mode;
 
 	pci_intx(bnad->pcidev, 0);
-- 
1.7.7.6
