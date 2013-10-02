Return-Path: <agordeev@dhcp-26-207.brq.redhat.com>
Received: from dhcp-26-207.brq.redhat.com (unknown [89.24.186.221])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 4F4162C0085
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Oct 2013 02:53:47 +1000 (EST)
From: Alexander Gordeev <agordeev@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH RFC 24/77] cxgb3: Update MSI/MSI-X interrupts enablement code
Date: Wed,  2 Oct 2013 12:48:40 +0200
Message-Id: <a23ee43c52ece3e83885caff72ae2f2cfe0de935.1380703262.git.agordeev@redhat.com>
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
 drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c |   29 ++++++++++++-----------
 1 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c b/drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c
index 915729c..bf14fd6 100644
--- a/drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c
+++ b/drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c
@@ -3090,25 +3090,26 @@ static int cxgb_enable_msix(struct adapter *adap)
 	int vectors;
 	int i, err;
 
-	vectors = ARRAY_SIZE(entries);
+	err = pci_msix_table_size(adap->pdev);
+	if (err < 0)
+		return err;
+
+	vectors = min_t(int, err, ARRAY_SIZE(entries));
+	if (vectors < (adap->params.nports + 1))
+		return -ENOSPC;
+
 	for (i = 0; i < vectors; ++i)
 		entries[i].entry = i;
 
-	while ((err = pci_enable_msix(adap->pdev, entries, vectors)) > 0)
-		vectors = err;
-
-	if (!err && vectors < (adap->params.nports + 1)) {
-		pci_disable_msix(adap->pdev);
-		err = -ENOSPC;
-	}
+	err = pci_enable_msix(adap->pdev, entries, vectors);
+	if (err)
+		return err;
 
-	if (!err) {
-		for (i = 0; i < vectors; ++i)
-			adap->msix_info[i].vec = entries[i].vector;
-		adap->msix_nvectors = vectors;
-	}
+	for (i = 0; i < vectors; ++i)
+		adap->msix_info[i].vec = entries[i].vector;
+	adap->msix_nvectors = vectors;
 
-	return err;
+	return 0;
 }
 
 static void print_port_info(struct adapter *adap, const struct adapter_info *ai)
-- 
1.7.7.6
