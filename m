Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 311E61A2C5D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2015 15:08:23 +1000 (AEST)
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 0AA961401CD
 for <linuxppc-dev@ozlabs.org>; Tue, 15 Sep 2015 15:08:23 +1000 (AEST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <dja@axtens.net>;
 Tue, 15 Sep 2015 15:08:21 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id DFB092BB0051
 for <linuxppc-dev@ozlabs.org>; Tue, 15 Sep 2015 15:08:17 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8F589Dw64028742
 for <linuxppc-dev@ozlabs.org>; Tue, 15 Sep 2015 15:08:17 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8F57iQk011399
 for <linuxppc-dev@ozlabs.org>; Tue, 15 Sep 2015 15:07:45 +1000
From: Daniel Axtens <dja@axtens.net>
To: linuxppc-dev@ozlabs.org
Cc: mpe@ellerman.id.au, benh@kernel.crashing.org, mikey@neuling.org,
 imunsie@au1.ibm.com, andrew.donnellan@au1.ibm.com,
 Daniel Axtens <dja@axtens.net>
Subject: [PATCH v2] cxl: Fix unbalanced pci_dev_get in cxl_probe
Date: Tue, 15 Sep 2015 15:04:07 +1000
Message-Id: <1442293447-1843-1-git-send-email-dja@axtens.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently the first thing we do in cxl_probe is to grab a reference
on the pci device. Later on, we call device_register on our adapter.
In our remove path, we call device_unregister, but we never call
pci_dev_put. We therefore leak the device every time we do a
reflash.

device_register/unregister is sufficient to hold the reference.
Therefore, drop the call to pci_dev_get.

Here's why this is safe.
The proposed cxl_probe(pdev) calls cxl_adapter_init:
    a) init calls cxl_adapter_alloc, which creates a struct cxl,
       conventionally called adapter. This struct contains a
       device entry, adapter->dev.

    b) init calls cxl_configure_adapter, where we set
       adapter->dev.parent = &dev->dev (here dev is the pci dev)

So at this point, the cxl adapter's device's parent is the PCI
device that I want to be refcounted properly.

    c) init calls cxl_register_adapter
       *) cxl_register_adapter calls device_register(&adapter->dev)

So now we're in device_register, where dev is the adapter device, and
we want to know if the PCI device is safe after we return.

device_register(&adapter->dev) calls device_initialize() and then
device_add().

device_add() does a get_device(). device_add() also explicitly grabs
the device's parent, and calls get_device() on it:

         parent = get_device(dev->parent);

So therefore, device_register() takes a lock on the parent PCI dev,
which is what pci_dev_get() was guarding. pci_dev_get() can therefore
be safely removed.

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
