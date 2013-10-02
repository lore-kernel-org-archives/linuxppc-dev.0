Return-Path: <agordeev@dhcp-26-207.brq.redhat.com>
Received: from dhcp-26-207.brq.redhat.com (unknown [89.24.186.221])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 8445A2C00BB
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Oct 2013 02:34:20 +1000 (EST)
From: Alexander Gordeev <agordeev@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH RFC 52/77] niu: Update MSI/MSI-X interrupts enablement code
Date: Wed,  2 Oct 2013 12:49:08 +0200
Message-Id: <9808b7b5600043632fab8fa19f5b8e7845637de0.1380703263.git.agordeev@redhat.com>
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
 drivers/net/ethernet/sun/niu.c |   20 +++++++++++---------
 1 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/sun/niu.c b/drivers/net/ethernet/sun/niu.c
index f28460c..54c41b9 100644
--- a/drivers/net/ethernet/sun/niu.c
+++ b/drivers/net/ethernet/sun/niu.c
@@ -9051,26 +9051,28 @@ static void niu_try_msix(struct niu *np, u8 *ldg_num_map)
 		    (np->port == 0 ? 3 : 1));
 	BUG_ON(num_irqs > (NIU_NUM_LDG / parent->num_ports));
 
-retry:
+	err = pci_msix_table_size(pdev);
+	if (err < 0)
+		goto fail;
+
+	num_irqs = min(num_irqs, err);
 	for (i = 0; i < num_irqs; i++) {
 		msi_vec[i].vector = 0;
 		msi_vec[i].entry = i;
 	}
 
 	err = pci_enable_msix(pdev, msi_vec, num_irqs);
-	if (err < 0) {
-		np->flags &= ~NIU_FLAGS_MSIX;
-		return;
-	}
-	if (err > 0) {
-		num_irqs = err;
-		goto retry;
-	}
+	if (err)
+		goto fail;
 
 	np->flags |= NIU_FLAGS_MSIX;
 	for (i = 0; i < num_irqs; i++)
 		np->ldg[i].irq = msi_vec[i].vector;
 	np->num_ldg = num_irqs;
+	return;
+
+fail:
+	np->flags &= ~NIU_FLAGS_MSIX;
 }
 
 static int niu_n2_irq_init(struct niu *np, u8 *ldg_num_map)
-- 
1.7.7.6
