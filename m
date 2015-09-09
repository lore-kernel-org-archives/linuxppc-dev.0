Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 020581A2354
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Sep 2015 15:20:37 +1000 (AEST)
Received: from mail-pa0-x230.google.com (mail-pa0-x230.google.com
 [IPv6:2607:f8b0:400e:c03::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B99C7140663
 for <linuxppc-dev@ozlabs.org>; Wed,  9 Sep 2015 15:20:35 +1000 (AEST)
Received: by padhk3 with SMTP id hk3so61075522pad.3
 for <linuxppc-dev@ozlabs.org>; Tue, 08 Sep 2015 22:20:33 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linuxppc-dev@ozlabs.org
Cc: mpe@ellerman.id.au, benh@kernel.crashing.org, mikey@neuling.org,
 imunsie@au.ibm.com, andrew.donnellan@au1.ibm.com,
 Daniel Axtens <dja@axtens.net>
Subject: [PATCH] cxl: Fix unbalanced pci_dev_get in cxl_probe
Date: Wed,  9 Sep 2015 15:17:25 +1000
Message-Id: <1441775845-25870-1-git-send-email-dja@axtens.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently the first thing we do in cxl_probe is to grab a reference
on the pci device. Later on, we call device_register on our adapter,
which also holds the PCI device.

In our remove path, we call device_unregister, but we never call
pci_dev_put. We therefore leak the device every time we do a
reflash.

device_register/unregister is sufficient to hold the reference.
Drop the call to pci_dev_get.

Fixes: f204e0b8cedd ("cxl: Driver code for powernv PCIe based cards for userspace access")
Cc: stable@vger.kernel.org
Signed-off-by: Daniel Axtens <dja@axtens.net>

---

This is the cxl bug that caused me to catch this a few weeks back:
e642d11bdbfe ("powerpc/eeh: Probe after unbalanced kref check")

I put an printk in the unbalanced kref path and confirmed that it
was printed with the pci_dev_get in and went away with the
pci_dev_get out.
---
 drivers/misc/cxl/pci.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
index 02c85160bfe9..a5e977192b61 100644
--- a/drivers/misc/cxl/pci.c
+++ b/drivers/misc/cxl/pci.c
@@ -1249,8 +1249,6 @@ static int cxl_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	int slice;
 	int rc;
 
-	pci_dev_get(dev);
-
 	if (cxl_verbose)
 		dump_cxl_config_space(dev);
 
-- 
2.5.0
