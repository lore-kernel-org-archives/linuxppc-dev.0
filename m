Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 855FF1A0DB0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jul 2015 15:31:20 +1000 (AEST)
Received: from mail-pd0-x22a.google.com (mail-pd0-x22a.google.com
 [IPv6:2607:f8b0:400e:c02::22a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 03DA5140E1A
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Jul 2015 15:31:20 +1000 (AEST)
Received: by pdbnt7 with SMTP id nt7so64326514pdb.0
 for <linuxppc-dev@ozlabs.org>; Mon, 27 Jul 2015 22:31:18 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linuxppc-dev@ozlabs.org
Cc: mpe@ellerman.id.au, benh@kernel.crashing.org, mikey@neuling.org,
 imunsie@au.ibm.com, "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 Manoj Kumar <kumarmn@us.ibm.com>, Daniel Axtens <dja@axtens.net>
Subject: [PATCH v2 04/10] cxl: Clean up adapter MMIO unmap path.
Date: Tue, 28 Jul 2015 15:28:37 +1000
Message-Id: <1438061323-20710-5-git-send-email-dja@axtens.net>
In-Reply-To: <1438061323-20710-1-git-send-email-dja@axtens.net>
References: <1438061323-20710-1-git-send-email-dja@axtens.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

 - MMIO pointer unmapping is guarded by a null pointer check.
   However, iounmap doesn't null the pointer, just invalidate it.
   Therefore, explicitly null the pointer after unmapping.

 - afu_desc_mmio also needs to be unmapped.

 - PCI regions are allocated in cxl_map_adapter_regs.
   Therefore they should be released in unmap, not elsewhere.

Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 drivers/misc/cxl/pci.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
index 1849c1785b49..adcf938f2fdb 100644
--- a/drivers/misc/cxl/pci.c
+++ b/drivers/misc/cxl/pci.c
@@ -539,10 +539,18 @@ err:
 
 static void cxl_unmap_slice_regs(struct cxl_afu *afu)
 {
-	if (afu->p2n_mmio)
+	if (afu->p2n_mmio) {
 		iounmap(afu->p2n_mmio);
-	if (afu->p1n_mmio)
+		afu->p2n_mmio = NULL;
+	}
+	if (afu->p1n_mmio) {
 		iounmap(afu->p1n_mmio);
+		afu->p1n_mmio = NULL;
+	}
+	if (afu->afu_desc_mmio) {
+		iounmap(afu->afu_desc_mmio);
+		afu->afu_desc_mmio = NULL;
+	}
 }
 
 static void cxl_release_afu(struct device *dev)
@@ -920,10 +928,16 @@ err1:
 
 static void cxl_unmap_adapter_regs(struct cxl *adapter)
 {
-	if (adapter->p1_mmio)
+	if (adapter->p1_mmio) {
 		iounmap(adapter->p1_mmio);
-	if (adapter->p2_mmio)
+		adapter->p1_mmio = NULL;
+		pci_release_region(to_pci_dev(adapter->dev.parent), 2);
+	}
+	if (adapter->p2_mmio) {
 		iounmap(adapter->p2_mmio);
+		adapter->p2_mmio = NULL;
+		pci_release_region(to_pci_dev(adapter->dev.parent), 0);
+	}
 }
 
 static int cxl_read_vsec(struct cxl *adapter, struct pci_dev *dev)
@@ -1132,8 +1146,6 @@ static void cxl_remove_adapter(struct cxl *adapter)
 
 	device_unregister(&adapter->dev);
 
-	pci_release_region(pdev, 0);
-	pci_release_region(pdev, 2);
 	pci_disable_device(pdev);
 }
 
-- 
2.1.4
