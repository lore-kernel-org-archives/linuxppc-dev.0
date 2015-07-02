Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2C4931A0FFD
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Jul 2015 15:56:55 +1000 (AEST)
Received: from mail-pd0-x234.google.com (mail-pd0-x234.google.com
 [IPv6:2607:f8b0:400e:c02::234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 0ACDE1402B9
 for <linuxppc-dev@ozlabs.org>; Thu,  2 Jul 2015 15:56:53 +1000 (AEST)
Received: by pdjd13 with SMTP id d13so38894087pdj.0
 for <linuxppc-dev@ozlabs.org>; Wed, 01 Jul 2015 22:56:52 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linuxppc-dev@ozlabs.org
Cc: mpe@ellerman.id.au, benh@kernel.crashing.org, mikey@neuling.org,
 imunsie@au.ibm.com, Daniel Axtens <dja@axtens.net>
Subject: [PATCH] cxl: Test the correct mmio space before unmapping
Date: Thu,  2 Jul 2015 15:55:21 +1000
Message-Id: <1435816521-13159-1-git-send-email-dja@axtens.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Before freeing p2n, test p2n, not p1n.

Signed-off-by: Daniel Axtens <dja@axtens.net>

---

While a potentially nasty bug, this is only hit (at the moment)
in cxl_remove, so it's probably not a candidate for stable.
---
 drivers/misc/cxl/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
index a16988d..fd43462 100644
--- a/drivers/misc/cxl/pci.c
+++ b/drivers/misc/cxl/pci.c
@@ -540,7 +540,7 @@ err:
 
 static void cxl_unmap_slice_regs(struct cxl_afu *afu)
 {
-	if (afu->p1n_mmio)
+	if (afu->p2n_mmio)
 		iounmap(afu->p2n_mmio);
 	if (afu->p1n_mmio)
 		iounmap(afu->p1n_mmio);
-- 
2.1.4
