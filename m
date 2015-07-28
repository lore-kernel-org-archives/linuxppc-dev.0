Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 112011A0D70
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jul 2015 15:31:32 +1000 (AEST)
Received: from mail-pa0-x22d.google.com (mail-pa0-x22d.google.com
 [IPv6:2607:f8b0:400e:c03::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 7A0B7140E19
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Jul 2015 15:31:31 +1000 (AEST)
Received: by pabkd10 with SMTP id kd10so63832368pab.2
 for <linuxppc-dev@ozlabs.org>; Mon, 27 Jul 2015 22:31:29 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linuxppc-dev@ozlabs.org
Cc: mpe@ellerman.id.au, benh@kernel.crashing.org, mikey@neuling.org,
 imunsie@au.ibm.com, "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 Manoj Kumar <kumarmn@us.ibm.com>, Daniel Axtens <dja@axtens.net>
Subject: [PATCH v2 07/10] cxl: Don't remove AFUs/vPHBs in cxl_reset
Date: Tue, 28 Jul 2015 15:28:40 +1000
Message-Id: <1438061323-20710-8-git-send-email-dja@axtens.net>
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

If the driver doesn't participate in EEH, the AFUs will be removed
by cxl_remove, which will be invoked by EEH.

If the driver does particpate in EEH, the vPHB needs to stick around
so that the it can particpate.

In both cases, we shouldn't remove the AFU/vPHB.

Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 drivers/misc/cxl/pci.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
index 98a8207da88d..0acf9e62733e 100644
--- a/drivers/misc/cxl/pci.c
+++ b/drivers/misc/cxl/pci.c
@@ -877,11 +877,6 @@ int cxl_reset(struct cxl *adapter)
 
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
