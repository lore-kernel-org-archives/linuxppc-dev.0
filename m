Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3F11B1A1D59
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Aug 2015 14:14:29 +1000 (AEST)
Received: from mail-pa0-x22f.google.com (mail-pa0-x22f.google.com
 [IPv6:2607:f8b0:400e:c03::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B0BB5140291
 for <linuxppc-dev@ozlabs.org>; Thu, 13 Aug 2015 14:14:28 +1000 (AEST)
Received: by pacgr6 with SMTP id gr6so28641035pac.2
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Aug 2015 21:14:27 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linuxppc-dev@ozlabs.org
Cc: mpe@ellerman.id.au, benh@kernel.crashing.org, cyrilbur@gmail.com,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 Manoj Kumar <kumarmn@us.ibm.com>, mikey@neuling.org, imunsie@au.ibm.com,
 Daniel Axtens <dja@axtens.net>
Subject: [PATCH v4 05/11] cxl: Clean up adapter MMIO unmap path.
Date: Thu, 13 Aug 2015 14:11:23 +1000
Message-Id: <1439439089-25151-6-git-send-email-dja@axtens.net>
In-Reply-To: <1439439089-25151-1-git-send-email-dja@axtens.net>
References: <1439439089-25151-1-git-send-email-dja@axtens.net>
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

Acked-by: Cyril Bur <cyrilbur@gmail.com>
Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 drivers/misc/cxl/pci.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
index 62a762d94de3..484d35a5aead 100644
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
@@ -919,10 +927,16 @@ err1:
 
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
@@ -1131,8 +1145,6 @@ static void cxl_remove_adapter(struct cxl *adapter)
 
 	device_unregister(&adapter->dev);
 
-	pci_release_region(pdev, 0);
-	pci_release_region(pdev, 2);
 	pci_disable_device(pdev);
 }
 
-- 
2.1.4
