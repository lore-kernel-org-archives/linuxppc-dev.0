Return-Path: <agordeev@dhcp-26-207.brq.redhat.com>
Received: from dhcp-26-207.brq.redhat.com (unknown [89.24.186.221])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 802492C06B4
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Oct 2013 03:26:28 +1000 (EST)
From: Alexander Gordeev <agordeev@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH RFC 26/77] cxgb4: Update MSI/MSI-X interrupts enablement code
Date: Wed,  2 Oct 2013 12:48:42 +0200
Message-Id: <384501214b90270df2f9414e3ddcffbe0335ddff.1380703262.git.agordeev@redhat.com>
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
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c |   62 +++++++++++++----------
 1 files changed, 35 insertions(+), 27 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
index 9425bc6..e5fbbd3 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
@@ -5699,9 +5699,6 @@ static int enable_msix(struct adapter *adap)
 	unsigned int nchan = adap->params.nports;
 	struct msix_entry entries[MAX_INGQ + 1];
 
-	for (i = 0; i < ARRAY_SIZE(entries); ++i)
-		entries[i].entry = i;
-
 	want = s->max_ethqsets + EXTRA_VECS;
 	if (is_offload(adap)) {
 		want += s->rdmaqs + s->ofldqsets;
@@ -5710,34 +5707,45 @@ static int enable_msix(struct adapter *adap)
 	}
 	need = adap->params.nports + EXTRA_VECS + ofld_need;
 
-	while ((err = pci_enable_msix(adap->pdev, entries, want)) >= need)
-		want = err;
+	err = pci_msix_table_size(adap->pdev);
+	if (err < 0)
+		return err;
 
-	if (!err) {
-		/*
-		 * Distribute available vectors to the various queue groups.
-		 * Every group gets its minimum requirement and NIC gets top
-		 * priority for leftovers.
-		 */
-		i = want - EXTRA_VECS - ofld_need;
-		if (i < s->max_ethqsets) {
-			s->max_ethqsets = i;
-			if (i < s->ethqsets)
-				reduce_ethqs(adap, i);
-		}
-		if (is_offload(adap)) {
-			i = want - EXTRA_VECS - s->max_ethqsets;
-			i -= ofld_need - nchan;
-			s->ofldqsets = (i / nchan) * nchan;  /* round down */
-		}
-		for (i = 0; i < want; ++i)
-			adap->msix_info[i].vec = entries[i].vector;
-	} else if (err > 0) {
+	want = min(want, err);
+	if (want < need) {
 		dev_info(adap->pdev_dev,
 			 "only %d MSI-X vectors left, not using MSI-X\n", err);
-		err = -ENOSPC;
+		return -ENOSPC;
 	}
-	return err;
+
+	BUG_ON(want > ARRAY_SIZE(entries));
+	for (i = 0; i < want; ++i)
+		entries[i].entry = i;
+
+	err = pci_enable_msix(adap->pdev, entries, want);
+	if (err)
+		return err;
+
+	/*
+	 * Distribute available vectors to the various queue groups.
+	 * Every group gets its minimum requirement and NIC gets top
+	 * priority for leftovers.
+	 */
+	i = want - EXTRA_VECS - ofld_need;
+	if (i < s->max_ethqsets) {
+		s->max_ethqsets = i;
+		if (i < s->ethqsets)
+			reduce_ethqs(adap, i);
+	}
+	if (is_offload(adap)) {
+		i = want - EXTRA_VECS - s->max_ethqsets;
+		i -= ofld_need - nchan;
+		s->ofldqsets = (i / nchan) * nchan;  /* round down */
+	}
+	for (i = 0; i < want; ++i)
+		adap->msix_info[i].vec = entries[i].vector;
+
+	return 0;
 }
 
 #undef EXTRA_VECS
-- 
1.7.7.6
