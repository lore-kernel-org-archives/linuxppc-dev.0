Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AD7221A1D6B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Aug 2015 14:14:38 +1000 (AEST)
Received: from mail-pa0-x22f.google.com (mail-pa0-x22f.google.com
 [IPv6:2607:f8b0:400e:c03::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 07EF8140293
 for <linuxppc-dev@ozlabs.org>; Thu, 13 Aug 2015 14:14:38 +1000 (AEST)
Received: by pacrr5 with SMTP id rr5so28694190pac.3
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Aug 2015 21:14:36 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linuxppc-dev@ozlabs.org
Cc: mpe@ellerman.id.au, benh@kernel.crashing.org, cyrilbur@gmail.com,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 Manoj Kumar <kumarmn@us.ibm.com>, mikey@neuling.org, imunsie@au.ibm.com,
 Daniel Axtens <dja@axtens.net>
Subject: [PATCH v4 07/11] cxl: Refactor AFU init/teardown
Date: Thu, 13 Aug 2015 14:11:25 +1000
Message-Id: <1439439089-25151-8-git-send-email-dja@axtens.net>
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

As with an adapter, some aspects of initialisation are done only once
in the lifetime of an AFU: for example, allocating memory, or setting
up sysfs/debugfs files.

However, we may want to be able to do some parts of the initialisation
multiple times: for example, in error recovery we want to be able to
tear down and then re-map IO memory and IRQs.

Therefore, refactor AFU init/teardown as follows.

 - Create two new functions: 'cxl_configure_afu', and its pair
   'cxl_deconfigure_afu'. As with the adapter functions,
   these (de)configure resources that do not need to last the entire
   lifetime of the AFU.

 - Allocating and releasing memory remain the task of 'cxl_alloc_afu'
   and 'cxl_release_afu'.

 - Once-only functions that do not involve allocating/releasing memory
   stay in the overarching 'cxl_init_afu'/'cxl_remove_afu' pair.
   However, the task of picking an AFU mode and activating it has been
   broken out.

Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 drivers/misc/cxl/pci.c | 124 ++++++++++++++++++++++++++++++-------------------
 1 file changed, 77 insertions(+), 47 deletions(-)

diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
index f3c5998f2f37..8e7b0f3ad254 100644
--- a/drivers/misc/cxl/pci.c
+++ b/drivers/misc/cxl/pci.c
@@ -752,45 +752,77 @@ ssize_t cxl_afu_read_err_buffer(struct cxl_afu *afu, char *buf,
 	return count;
 }
 
-static int cxl_init_afu(struct cxl *adapter, int slice, struct pci_dev *dev)
+static int cxl_configure_afu(struct cxl_afu *afu, struct cxl *adapter, struct pci_dev *dev)
 {
-	struct cxl_afu *afu;
-	bool free = true;
 	int rc;
 
-	if (!(afu = cxl_alloc_afu(adapter, slice)))
-		return -ENOMEM;
-
-	if ((rc = dev_set_name(&afu->dev, "afu%i.%i", adapter->adapter_num, slice)))
-		goto err1;
+	rc = cxl_map_slice_regs(afu, adapter, dev);
+	if (rc)
+		return rc;
 
-	if ((rc = cxl_map_slice_regs(afu, adapter, dev)))
+	rc = sanitise_afu_regs(afu);
+	if (rc)
 		goto err1;
 
-	if ((rc = sanitise_afu_regs(afu)))
-		goto err2;
-
 	/* We need to reset the AFU before we can read the AFU descriptor */
-	if ((rc = __cxl_afu_reset(afu)))
-		goto err2;
+	rc = __cxl_afu_reset(afu);
+	if (rc)
+		goto err1;
 
 	if (cxl_verbose)
 		dump_afu_descriptor(afu);
 
-	if ((rc = cxl_read_afu_descriptor(afu)))
-		goto err2;
+	rc = cxl_read_afu_descriptor(afu);
+	if (rc)
+		goto err1;
 
-	if ((rc = cxl_afu_descriptor_looks_ok(afu)))
-		goto err2;
+	rc = cxl_afu_descriptor_looks_ok(afu);
+	if (rc)
+		goto err1;
 
-	if ((rc = init_implementation_afu_regs(afu)))
-		goto err2;
+	rc = init_implementation_afu_regs(afu);
+	if (rc)
+		goto err1;
+
+	rc = cxl_register_serr_irq(afu);
+	if (rc)
+		goto err1;
 
-	if ((rc = cxl_register_serr_irq(afu)))
+	rc = cxl_register_psl_irq(afu);
+	if (rc)
 		goto err2;
 
-	if ((rc = cxl_register_psl_irq(afu)))
-		goto err3;
+	return 0;
+
+err2:
+	cxl_release_serr_irq(afu);
+err1:
+	cxl_unmap_slice_regs(afu);
+	return rc;
+}
+
+static void cxl_deconfigure_afu(struct cxl_afu *afu)
+{
+	cxl_release_psl_irq(afu);
+	cxl_release_serr_irq(afu);
+	cxl_unmap_slice_regs(afu);
+}
+
+static int cxl_init_afu(struct cxl *adapter, int slice, struct pci_dev *dev)
+{
+	struct cxl_afu *afu;
+	int rc;
+
+	if (!(afu = cxl_alloc_afu(adapter, slice)))
+		return -ENOMEM;
+
+	rc = dev_set_name(&afu->dev, "afu%i.%i", adapter->adapter_num, slice);
+	if (rc)
+		goto err_free;
+
+	rc = cxl_configure_afu(afu, adapter, dev);
+	if (rc)
+		goto err_free;
 
 	/* Don't care if this fails */
 	cxl_debugfs_afu_add(afu);
@@ -799,38 +831,32 @@ static int cxl_init_afu(struct cxl *adapter, int slice, struct pci_dev *dev)
 	 * After we call this function we must not free the afu directly, even
 	 * if it returns an error!
 	 */
-	if ((rc = cxl_register_afu(afu)))
+	rc = cxl_register_afu(afu);
+	if (rc)
 		goto err_put1;
 
-	if ((rc = cxl_sysfs_afu_add(afu)))
+	rc = cxl_sysfs_afu_add(afu);
+	if (rc)
 		goto err_put1;
 
-
-	if ((rc = cxl_afu_select_best_mode(afu)))
-		goto err_put2;
-
 	adapter->afu[afu->slice] = afu;
 
-	if ((rc = cxl_pci_vphb_add(afu)))
+	rc = cxl_pci_vphb_add(afu);
+	if (rc)
 		dev_info(&afu->dev, "Can't register vPHB\n");
 
 	return 0;
 
-err_put2:
-	cxl_sysfs_afu_remove(afu);
 err_put1:
-	device_unregister(&afu->dev);
-	free = false;
+	cxl_deconfigure_afu(afu);
 	cxl_debugfs_afu_remove(afu);
-	cxl_release_psl_irq(afu);
-err3:
-	cxl_release_serr_irq(afu);
-err2:
-	cxl_unmap_slice_regs(afu);
-err1:
-	if (free)
-		kfree(afu);
+	device_unregister(&afu->dev);
 	return rc;
+
+err_free:
+	kfree(afu);
+	return rc;
+
 }
 
 static void cxl_remove_afu(struct cxl_afu *afu)
@@ -850,10 +876,7 @@ static void cxl_remove_afu(struct cxl_afu *afu)
 	cxl_context_detach_all(afu);
 	cxl_afu_deactivate_mode(afu);
 
-	cxl_release_psl_irq(afu);
-	cxl_release_serr_irq(afu);
-	cxl_unmap_slice_regs(afu);
-
+	cxl_deconfigure_afu(afu);
 	device_unregister(&afu->dev);
 }
 
@@ -1218,8 +1241,15 @@ static int cxl_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	}
 
 	for (slice = 0; slice < adapter->slices; slice++) {
-		if ((rc = cxl_init_afu(adapter, slice, dev)))
+		rc = cxl_init_afu(adapter, slice, dev);
+		if (rc) {
 			dev_err(&dev->dev, "AFU %i failed to initialise: %i\n", slice, rc);
+			continue;
+		}
+
+		rc = cxl_afu_select_best_mode(adapter->afu[slice]);
+		if (rc)
+			dev_err(&dev->dev, "AFU %i failed to start: %i\n", slice, rc);
 	}
 
 	return 0;
-- 
2.1.4
