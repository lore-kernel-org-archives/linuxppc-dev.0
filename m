Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 335841A0D66
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2015 16:07:42 +1000 (AEST)
From: Michael Neuling <mikey@neuling.org>
To: mpe@ellerman.id.au,
	benh@kernel.crashing.org
Cc: imunsie@au.ibm.com, linuxppc-dev@ozlabs.org, mikey@neuling.org,
 Daniel Axtens <dja@axtens.net>,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>, brking@linux.vnet.ibm.com
Subject: [PATCH v3 11/24] cxl: Fix error path on probe
Date: Wed, 27 May 2015 16:07:05 +1000
Message-Id: <1432706838-20794-12-git-send-email-mikey@neuling.org>
In-Reply-To: <1432706838-20794-1-git-send-email-mikey@neuling.org>
References: <1432706838-20794-1-git-send-email-mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When probing we call pci_enable_device() but don't call pci_disable_device() on
fail. This causes refcounting issues in the PCI subsystem if a second driver
tries to bind to the same device.

This patch adds the pci_disable_device() to the probe error path. This error
path is hit when this cxl driver tries to bind to AFUs (on the vPHB) rather
than the physical device.

Signed-off-by: Michael Neuling <mikey@neuling.org>
Acked-by: Ian Munsie <imunsie@au1.ibm.com>
---
 drivers/misc/cxl/pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
index 3f0caa2..0d429b0 100644
--- a/drivers/misc/cxl/pci.c
+++ b/drivers/misc/cxl/pci.c
@@ -1103,6 +1103,7 @@ static int cxl_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	adapter = cxl_init_adapter(dev);
 	if (IS_ERR(adapter)) {
 		dev_err(&dev->dev, "cxl_init_adapter failed: %li\n", PTR_ERR(adapter));
+		pci_disable_device(dev);
 		return PTR_ERR(adapter);
 	}
 
-- 
2.1.0
