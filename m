Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E06C51A1D49
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Aug 2015 14:14:43 +1000 (AEST)
Received: from mail-pa0-x22a.google.com (mail-pa0-x22a.google.com
 [IPv6:2607:f8b0:400e:c03::22a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id AE2F7140297
 for <linuxppc-dev@ozlabs.org>; Thu, 13 Aug 2015 14:14:42 +1000 (AEST)
Received: by pacgr6 with SMTP id gr6so28645065pac.2
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Aug 2015 21:14:41 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linuxppc-dev@ozlabs.org
Cc: mpe@ellerman.id.au, benh@kernel.crashing.org, cyrilbur@gmail.com,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 Manoj Kumar <kumarmn@us.ibm.com>, mikey@neuling.org, imunsie@au.ibm.com,
 Daniel Axtens <dja@axtens.net>
Subject: [PATCH v4 08/11] cxl: Don't remove AFUs/vPHBs in cxl_reset
Date: Thu, 13 Aug 2015 14:11:26 +1000
Message-Id: <1439439089-25151-9-git-send-email-dja@axtens.net>
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

If the driver doesn't participate in EEH, the AFUs will be removed
by cxl_remove, which will be invoked by EEH.

If the driver does particpate in EEH, the vPHB needs to stick around
so that the it can particpate.

In both cases, we shouldn't remove the AFU/vPHB.

Reviewed-by: Cyril Bur <cyrilbur@gmail.com>
Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 drivers/misc/cxl/pci.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
index 8e7b0f3ad254..e7976deed1f8 100644
--- a/drivers/misc/cxl/pci.c
+++ b/drivers/misc/cxl/pci.c
@@ -889,11 +889,6 @@ int cxl_reset(struct cxl *adapter)
 
 	dev_info(&dev->dev, "CXL reset\n");
 
-	for (i = 0; i < adapter->slices; i++) {
-		cxl_pci_vphb_remove(adapter->afu[i]);
-		cxl_remove_afu(adapter->afu[i]);
-	}
-
 	/* pcie_warm_reset requests a fundamental pci reset which includes a
 	 * PERST assert/deassert.  PERST triggers a loading of the image
 	 * if "user" or "factory" is selected in sysfs */
-- 
2.1.4
