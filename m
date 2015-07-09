Return-Path: <jthumshirn@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2E0951A01CC
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jul 2015 17:39:55 +1000 (AEST)
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Ian Munsie <imunsie@au1.ibm.com>,
	Michael Neuling <mikey@neuling.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH] cxl: Destroy afu->contexts_idr on release of an afu
Date: Thu,  9 Jul 2015 09:39:42 +0200
Message-Id: <1436427582-12777-1-git-send-email-jthumshirn@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Destroy afu->contexts_idr on release of an afu, reclaiming the allocated
memory.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 drivers/misc/cxl/pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
index c68ef58..16b8e75a 100644
--- a/drivers/misc/cxl/pci.c
+++ b/drivers/misc/cxl/pci.c
@@ -551,6 +551,7 @@ static void cxl_release_afu(struct device *dev)
 
 	pr_devel("cxl_release_afu\n");
 
+	idr_destroy(&afu->contexts_idr);
 	kfree(afu);
 }
 
-- 
2.4.3
