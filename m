Return-Path: <agordeev@dhcp-26-207.brq.redhat.com>
Received: from dhcp-26-207.brq.redhat.com (unknown [89.24.186.221])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 69AE62C00BB
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Oct 2013 02:42:35 +1000 (EST)
From: Alexander Gordeev <agordeev@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH RFC 15/77] bnx2: Update MSI/MSI-X interrupts enablement code
Date: Wed,  2 Oct 2013 12:48:31 +0200
Message-Id: <69c0bf5f6ee4b2a913891cfc94442a3c9a3f9434.1380703262.git.agordeev@redhat.com>
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
 drivers/net/ethernet/broadcom/bnx2.c |   27 ++++++++++++++-------------
 1 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2.c b/drivers/net/ethernet/broadcom/bnx2.c
index e838a3f..c902627 100644
--- a/drivers/net/ethernet/broadcom/bnx2.c
+++ b/drivers/net/ethernet/broadcom/bnx2.c
@@ -6202,25 +6202,26 @@ bnx2_enable_msix(struct bnx2 *bp, int msix_vecs)
 	 *  is setup properly */
 	BNX2_RD(bp, BNX2_PCI_MSIX_CONTROL);
 
-	for (i = 0; i < BNX2_MAX_MSIX_VEC; i++) {
-		msix_ent[i].entry = i;
-		msix_ent[i].vector = 0;
-	}
-
 	total_vecs = msix_vecs;
 #ifdef BCM_CNIC
 	total_vecs++;
 #endif
-	rc = -ENOSPC;
-	while (total_vecs >= BNX2_MIN_MSIX_VEC) {
-		rc = pci_enable_msix(bp->pdev, msix_ent, total_vecs);
-		if (rc <= 0)
-			break;
-		if (rc > 0)
-			total_vecs = rc;
+	rc = pci_msix_table_size(bp->pdev);
+	if (rc < 0)
+		return;
+
+	total_vecs = min(total_vecs, rc);
+	if (total_vecs < BNX2_MIN_MSIX_VEC)
+		return;
+
+	BUG_ON(total_vecs > ARRAY_SIZE(msix_ent));
+	for (i = 0; i < total_vecs; i++) {
+		msix_ent[i].entry = i;
+		msix_ent[i].vector = 0;
 	}
 
-	if (rc != 0)
+	rc = pci_enable_msix(bp->pdev, msix_ent, total_vecs);
+	if (rc)
 		return;
 
 	msix_vecs = total_vecs;
-- 
1.7.7.6
