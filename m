Return-Path: <R65777@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe003.messaging.microsoft.com [65.55.88.13])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2B0252C0297
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Sep 2013 17:37:29 +1000 (EST)
From: Bharat Bhushan <r65777@freescale.com>
To: <alex.williamson@redhat.com>, <joro@8bytes.org>,
 <benh@kernel.crashing.org>, <galak@kernel.crashing.org>,
 <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-pci@vger.kernel.org>, <agraf@suse.de>, <scottwood@freescale.com>,
 <iommu@lists.linux-foundation.org>
Subject: [PATCH 5/7] iommu: supress loff_t compilation error on powerpc
Date: Thu, 19 Sep 2013 12:59:21 +0530
Message-ID: <1379575763-2091-6-git-send-email-Bharat.Bhushan@freescale.com>
In-Reply-To: <1379575763-2091-1-git-send-email-Bharat.Bhushan@freescale.com>
References: <1379575763-2091-1-git-send-email-Bharat.Bhushan@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Bharat Bhushan <bharat.bhushan@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Bharat Bhushan <bharat.bhushan@freescale.com>
---
 drivers/vfio/pci/vfio_pci_rdwr.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_rdwr.c b/drivers/vfio/pci/vfio_pci_rdwr.c
index 210db24..8a8156a 100644
--- a/drivers/vfio/pci/vfio_pci_rdwr.c
+++ b/drivers/vfio/pci/vfio_pci_rdwr.c
@@ -181,7 +181,8 @@ ssize_t vfio_pci_vga_rw(struct vfio_pci_device *vdev, char __user *buf,
 			       size_t count, loff_t *ppos, bool iswrite)
 {
 	int ret;
-	loff_t off, pos = *ppos & VFIO_PCI_OFFSET_MASK;
+	loff_t off;
+	u64 pos = (u64 )(*ppos & VFIO_PCI_OFFSET_MASK);
 	void __iomem *iomem = NULL;
 	unsigned int rsrc;
 	bool is_ioport;
-- 
1.7.0.4
