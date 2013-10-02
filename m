Return-Path: <agordeev@dhcp-26-207.brq.redhat.com>
Received: from dhcp-26-207.brq.redhat.com (unknown [89.24.186.221])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 2CA8C2C008E
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Oct 2013 02:51:27 +1000 (EST)
From: Alexander Gordeev <agordeev@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH RFC 21/77] csiostor: Update MSI/MSI-X interrupts enablement
 code
Date: Wed,  2 Oct 2013 12:48:37 +0200
Message-Id: <a4355b8061609e4a4a28104cc5014178e4720bd0.1380703262.git.agordeev@redhat.com>
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
 drivers/scsi/csiostor/csio_isr.c |   18 ++++++++++++------
 1 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/csiostor/csio_isr.c b/drivers/scsi/csiostor/csio_isr.c
index abf20ab..b8a840e 100644
--- a/drivers/scsi/csiostor/csio_isr.c
+++ b/drivers/scsi/csiostor/csio_isr.c
@@ -512,6 +512,16 @@ csio_enable_msix(struct csio_hw *hw)
 	if (hw->flags & CSIO_HWF_USING_SOFT_PARAMS || !csio_is_hw_master(hw))
 		cnt = min_t(uint8_t, hw->cfg_niq, cnt);
 
+	rv = pci_msix_table_size(hw->pdev);
+	if (rv < 0)
+		return rv;
+
+	cnt = min(cnt, rv);
+	if (cnt < min) {
+		csio_info(hw, "Not using MSI-X, remainder:%d\n", rv);
+		return -ENOSPC;
+	}
+
 	entries = kzalloc(sizeof(struct msix_entry) * cnt, GFP_KERNEL);
 	if (!entries)
 		return -ENOMEM;
@@ -521,19 +531,15 @@ csio_enable_msix(struct csio_hw *hw)
 
 	csio_dbg(hw, "FW supp #niq:%d, trying %d msix's\n", hw->cfg_niq, cnt);
 
-	while ((rv = pci_enable_msix(hw->pdev, entries, cnt)) >= min)
-		cnt = rv;
+	rv = pci_enable_msix(hw->pdev, entries, cnt);
 	if (!rv) {
 		if (cnt < (hw->num_sqsets + extra)) {
 			csio_dbg(hw, "Reducing sqsets to %d\n", cnt - extra);
 			csio_reduce_sqsets(hw, cnt - extra);
 		}
 	} else {
-		if (rv > 0)
-			csio_info(hw, "Not using MSI-X, remainder:%d\n", rv);
-
 		kfree(entries);
-		return -ENOSPC;
+		return rv;
 	}
 
 	/* Save off vectors */
-- 
1.7.7.6
