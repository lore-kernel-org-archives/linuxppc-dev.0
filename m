Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 896511A08B0
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Jun 2015 14:38:56 +1000 (AEST)
From: Michael Neuling <mikey@neuling.org>
To: mpe@ellerman.id.au,
	benh@kernel.crashing.org
Cc: imunsie@au.ibm.com, linuxppc-dev@ozlabs.org, mikey@neuling.org,
 Daniel Axtens <dja@axtens.net>,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>, brking@linux.vnet.ibm.com
Subject: [PATCH] cxl: Reset default context for vPHB on release
Date: Fri,  5 Jun 2015 14:38:26 +1000
Message-Id: <1433479106-19699-1-git-send-email-mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When we release the device, we should also invalidate the default context.
With this cxl_get_context() will return null after removal.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 drivers/misc/cxl/vphb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/cxl/vphb.c b/drivers/misc/cxl/vphb.c
index f733309..b1d1983a 100644
--- a/drivers/misc/cxl/vphb.c
+++ b/drivers/misc/cxl/vphb.c
@@ -72,6 +72,7 @@ static void cxl_pci_disable_device(struct pci_dev *dev)
 			dev_err(&dev->dev, "Default context started\n");
 			return;
 		}
+		dev->dev.archdata.cxl_ctx = NULL;
 		cxl_release_context(ctx);
 	}
 }
-- 
2.1.0
