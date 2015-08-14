Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 18F091A1DB0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2015 17:44:31 +1000 (AEST)
Received: from mail-pa0-x235.google.com (mail-pa0-x235.google.com
 [IPv6:2607:f8b0:400e:c03::235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 88721140293
 for <linuxppc-dev@ozlabs.org>; Fri, 14 Aug 2015 17:44:30 +1000 (AEST)
Received: by paccq16 with SMTP id cq16so11342527pac.1
 for <linuxppc-dev@ozlabs.org>; Fri, 14 Aug 2015 00:44:29 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linuxppc-dev@ozlabs.org
Cc: mpe@ellerman.id.au, benh@kernel.crashing.org, mikey@neuling.org,
 imunsie@au.ibm.com, Daniel Axtens <dja@axtens.net>
Subject: [PATCH v5 07/11] cxl: Refactor AFU init/teardown
Date: Fri, 14 Aug 2015 17:41:23 +1000
Message-Id: <1439538087-32137-8-git-send-email-dja@axtens.net>
In-Reply-To: <1439538087-32137-1-git-send-email-dja@axtens.net>
References: <1439538087-32137-1-git-send-email-dja@axtens.net>
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
 drivers/misc/cxl/pci.c | 95 ++++++++++++++++++++++++++++++--------------------
 1 file changed, 57 insertions(+), 38 deletions(-)

diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
index feec4800e922..b63d96023c50 100644
--- a/drivers/misc/cxl/pci.c
+++ b/drivers/misc/cxl/pci.c
@@ -753,45 +753,70 @@ ssize_t cxl_afu_read_err_buffer(struct cxl_afu *afu, char *buf,
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
-
 	if ((rc = cxl_map_slice_regs(afu, adapter, dev)))
-		goto err1;
+		return rc;
 
 	if ((rc = sanitise_afu_regs(afu)))
-		goto err2;
+		goto err1;
 
 	/* We need to reset the AFU before we can read the AFU descriptor */
 	if ((rc = __cxl_afu_reset(afu)))
-		goto err2;
+		goto err1;
 
 	if (cxl_verbose)
 		dump_afu_descriptor(afu);
 
 	if ((rc = cxl_read_afu_descriptor(afu)))
-		goto err2;
+		goto err1;
 
 	if ((rc = cxl_afu_descriptor_looks_ok(afu)))
-		goto err2;
+		goto err1;
 
 	if ((rc = init_implementation_afu_regs(afu)))
-		goto err2;
+		goto err1;
 
 	if ((rc = cxl_register_serr_irq(afu)))
-		goto err2;
+		goto err1;
 
 	if ((rc = cxl_register_psl_irq(afu)))
-		goto err3;
+		goto err2;
+
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
+	afu = cxl_alloc_afu(adapter, slice);
+	if (!afu)
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
@@ -806,10 +831,6 @@ static int cxl_init_afu(struct cxl *adapter, int slice, struct pci_dev *dev)
 	if ((rc = cxl_sysfs_afu_add(afu)))
 		goto err_put1;
 
-
-	if ((rc = cxl_afu_select_best_mode(afu)))
-		goto err_put2;
-
 	adapter->afu[afu->slice] = afu;
 
 	if ((rc = cxl_pci_vphb_add(afu)))
@@ -817,21 +838,16 @@ static int cxl_init_afu(struct cxl *adapter, int slice, struct pci_dev *dev)
 
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
@@ -851,10 +867,7 @@ static void cxl_remove_afu(struct cxl_afu *afu)
 	cxl_context_detach_all(afu);
 	cxl_afu_deactivate_mode(afu);
 
-	cxl_release_psl_irq(afu);
-	cxl_release_serr_irq(afu);
-	cxl_unmap_slice_regs(afu);
-
+	cxl_deconfigure_afu(afu);
 	device_unregister(&afu->dev);
 }
 
@@ -1206,8 +1219,14 @@ static int cxl_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	}
 
 	for (slice = 0; slice < adapter->slices; slice++) {
-		if ((rc = cxl_init_afu(adapter, slice, dev)))
+		if ((rc = cxl_init_afu(adapter, slice, dev))) {
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
