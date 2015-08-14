Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 98A561A1E2C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2015 17:44:42 +1000 (AEST)
Received: from mail-pa0-x233.google.com (mail-pa0-x233.google.com
 [IPv6:2607:f8b0:400e:c03::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id DA82F140291
 for <linuxppc-dev@ozlabs.org>; Fri, 14 Aug 2015 17:44:41 +1000 (AEST)
Received: by paccq16 with SMTP id cq16so11345569pac.1
 for <linuxppc-dev@ozlabs.org>; Fri, 14 Aug 2015 00:44:40 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linuxppc-dev@ozlabs.org
Cc: mpe@ellerman.id.au, benh@kernel.crashing.org, mikey@neuling.org,
 imunsie@au.ibm.com, Daniel Axtens <dja@axtens.net>
Subject: [PATCH v5 10/11] cxl: EEH support
Date: Fri, 14 Aug 2015 17:41:26 +1000
Message-Id: <1439538087-32137-11-git-send-email-dja@axtens.net>
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

EEH (Enhanced Error Handling) allows a driver to recover from the
temporary failure of an attached PCI card. Enable basic CXL support
for EEH.

Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 drivers/misc/cxl/cxl.h  |   1 +
 drivers/misc/cxl/pci.c  | 253 ++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/misc/cxl/vphb.c |   8 ++
 3 files changed, 262 insertions(+)

diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
index cda02412b01e..6f5386653dae 100644
--- a/drivers/misc/cxl/cxl.h
+++ b/drivers/misc/cxl/cxl.h
@@ -726,6 +726,7 @@ int cxl_psl_purge(struct cxl_afu *afu);
 
 void cxl_stop_trace(struct cxl *cxl);
 int cxl_pci_vphb_add(struct cxl_afu *afu);
+void cxl_pci_vphb_reconfigure(struct cxl_afu *afu);
 void cxl_pci_vphb_remove(struct cxl_afu *afu);
 
 extern struct pci_driver cxl_pci_driver;
diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
index bfbd6478c0c5..03ddb2d8f974 100644
--- a/drivers/misc/cxl/pci.c
+++ b/drivers/misc/cxl/pci.c
@@ -24,6 +24,7 @@
 #include <asm/io.h>
 
 #include "cxl.h"
+#include <misc/cxl.h>
 
 
 #define CXL_PCI_VSEC_ID	0x1280
@@ -1252,10 +1253,262 @@ static void cxl_remove(struct pci_dev *dev)
 	cxl_remove_adapter(adapter);
 }
 
+static pci_ers_result_t cxl_vphb_error_detected(struct cxl_afu *afu,
+						pci_channel_state_t state)
+{
+	struct pci_dev *afu_dev;
+	pci_ers_result_t result = PCI_ERS_RESULT_NEED_RESET;
+	pci_ers_result_t afu_result = PCI_ERS_RESULT_NEED_RESET;
+
+	/* There should only be one entry, but go through the list
+	 * anyway
+	 */
+	list_for_each_entry(afu_dev, &afu->phb->bus->devices, bus_list) {
+		if (!afu_dev->driver)
+			continue;
+
+		afu_dev->error_state = state;
+
+		if (afu_dev->driver->err_handler)
+			afu_result = afu_dev->driver->err_handler->error_detected(afu_dev,
+										  state);
+		/* Disconnect trumps all, NONE trumps NEED_RESET */
+		if (afu_result == PCI_ERS_RESULT_DISCONNECT)
+			result = PCI_ERS_RESULT_DISCONNECT;
+		else if ((afu_result == PCI_ERS_RESULT_NONE) &&
+			 (result == PCI_ERS_RESULT_NEED_RESET))
+			result = PCI_ERS_RESULT_NONE;
+	}
+	return result;
+}
+
+static pci_ers_result_t cxl_pci_error_detected(struct pci_dev *pdev,
+					       pci_channel_state_t state)
+{
+	struct cxl *adapter = pci_get_drvdata(pdev);
+	struct cxl_afu *afu;
+	pci_ers_result_t result = PCI_ERS_RESULT_NEED_RESET;
+	int i;
+
+	/* At this point, we could still have an interrupt pending.
+	 * Let's try to get them out of the way before they do
+	 * anything we don't like.
+	 */
+	schedule();
+
+	/* If we're permanently dead, give up. */
+	if (state == pci_channel_io_perm_failure) {
+		/* Tell the AFU drivers; but we don't care what they
+		 * say, we're going away.
+		 */
+		for (i = 0; i < adapter->slices; i++) {
+			afu = adapter->afu[i];
+			cxl_vphb_error_detected(afu, state);
+		}
+		return PCI_ERS_RESULT_DISCONNECT;
+	}
+
+	/* Are we reflashing?
+	 *
+	 * If we reflash, we could come back as something entirely
+	 * different, including a non-CAPI card. As such, by default
+	 * we don't participate in the process. We'll be unbound and
+	 * the slot re-probed. (TODO: check EEH doesn't blindly rebind
+	 * us!)
+	 *
+	 * However, this isn't the entire story: for reliablity
+	 * reasons, we usually want to reflash the FPGA on PERST in
+	 * order to get back to a more reliable known-good state.
+	 *
+	 * This causes us a bit of a problem: if we reflash we can't
+	 * trust that we'll come back the same - we could have a new
+	 * image and been PERSTed in order to load that
+	 * image. However, most of the time we actually *will* come
+	 * back the same - for example a regular EEH event.
+	 *
+	 * Therefore, we allow the user to assert that the image is
+	 * indeed the same and that we should continue on into EEH
+	 * anyway.
+	 */
+	if (adapter->perst_loads_image && !adapter->perst_same_image) {
+		/* TODO take the PHB out of CXL mode */
+		dev_info(&pdev->dev, "reflashing, so opting out of EEH!\n");
+		return PCI_ERS_RESULT_NONE;
+	}
+
+	/*
+	 * At this point, we want to try to recover.  We'll always
+	 * need a complete slot reset: we don't trust any other reset.
+	 *
+	 * Now, we go through each AFU:
+	 *  - We send the driver, if bound, an error_detected callback.
+	 *    We expect it to clean up, but it can also tell us to give
+	 *    up and permanently detach the card. To simplify things, if
+	 *    any bound AFU driver doesn't support EEH, we give up on EEH.
+	 *
+	 *  - We detach all contexts associated with the AFU. This
+	 *    does not free them, but puts them into a CLOSED state
+	 *    which causes any the associated files to return useful
+	 *    errors to userland. It also unmaps, but does not free,
+	 *    any IRQs.
+	 *
+	 *  - We clean up our side: releasing and unmapping resources we hold
+	 *    so we can wire them up again when the hardware comes back up.
+	 *
+	 * Driver authors should note:
+	 *
+	 *  - Any contexts you create in your kernel driver (except
+	 *    those associated with anonymous file descriptors) are
+	 *    your responsibility to free and recreate. Likewise with
+	 *    any attached resources.
+	 *
+	 *  - We will take responsibility for re-initialising the
+	 *    device context (the one set up for you in
+	 *    cxl_pci_enable_device_hook and accessed through
+	 *    cxl_get_context). If you've attached IRQs or other
+	 *    resources to it, they remains yours to free.
+	 *
+	 * You can call the same functions to release resources as you
+	 * normally would: we make sure that these functions continue
+	 * to work when the hardware is down.
+	 *
+	 * Two examples:
+	 *
+	 * 1) If you normally free all your resources at the end of
+	 *    each request, or if you use anonymous FDs, your
+	 *    error_detected callback can simply set a flag to tell
+	 *    your driver not to start any new calls. You can then
+	 *    clear the flag in the resume callback.
+	 *
+	 * 2) If you normally allocate your resources on startup:
+	 *     * Set a flag in error_detected as above.
+	 *     * Let CXL detach your contexts.
+	 *     * In slot_reset, free the old resources and allocate new ones.
+	 *     * In resume, clear the flag to allow things to start.
+	 */
+	for (i = 0; i < adapter->slices; i++) {
+		afu = adapter->afu[i];
+
+		result = cxl_vphb_error_detected(afu, state);
+
+		/* Only continue if everyone agrees on NEED_RESET */
+		if (result != PCI_ERS_RESULT_NEED_RESET)
+			return result;
+
+		cxl_context_detach_all(afu);
+		cxl_afu_deactivate_mode(afu);
+		cxl_deconfigure_afu(afu);
+	}
+	cxl_deconfigure_adapter(adapter);
+
+	return result;
+}
+
+static pci_ers_result_t cxl_pci_slot_reset(struct pci_dev *pdev)
+{
+	struct cxl *adapter = pci_get_drvdata(pdev);
+	struct cxl_afu *afu;
+	struct cxl_context *ctx;
+	struct pci_dev *afu_dev;
+	pci_ers_result_t afu_result = PCI_ERS_RESULT_RECOVERED;
+	pci_ers_result_t result = PCI_ERS_RESULT_RECOVERED;
+	int i;
+
+	if (cxl_configure_adapter(adapter, pdev))
+		goto err;
+
+	for (i = 0; i < adapter->slices; i++) {
+		afu = adapter->afu[i];
+
+		if (cxl_configure_afu(afu, adapter, pdev))
+			goto err;
+
+		if (cxl_afu_select_best_mode(afu))
+			goto err;
+
+		cxl_pci_vphb_reconfigure(afu);
+
+		list_for_each_entry(afu_dev, &afu->phb->bus->devices, bus_list) {
+			/* Reset the device context.
+			 * TODO: make this less disruptive
+			 */
+			ctx = cxl_get_context(afu_dev);
+
+			if (ctx && cxl_release_context(ctx))
+				goto err;
+
+			ctx = cxl_dev_context_init(afu_dev);
+			if (!ctx)
+				goto err;
+
+			afu_dev->dev.archdata.cxl_ctx = ctx;
+
+			if (cxl_afu_check_and_enable(afu))
+				goto err;
+
+			afu_dev->error_state = pci_channel_io_normal;
+
+			/* If there's a driver attached, allow it to
+			 * chime in on recovery. Drivers should check
+			 * if everything has come back OK, but
+			 * shouldn't start new work until we call
+			 * their resume function.
+			 */
+			if (!afu_dev->driver)
+				continue;
+
+			if (afu_dev->driver->err_handler &&
+			    afu_dev->driver->err_handler->slot_reset)
+				afu_result = afu_dev->driver->err_handler->slot_reset(afu_dev);
+
+			if (afu_result == PCI_ERS_RESULT_DISCONNECT)
+				result = PCI_ERS_RESULT_DISCONNECT;
+		}
+	}
+	return result;
+
+err:
+	/* All the bits that happen in both error_detected and cxl_remove
+	 * should be idempotent, so we don't need to worry about leaving a mix
+	 * of unconfigured and reconfigured resources.
+	 */
+	dev_err(&pdev->dev, "EEH recovery failed. Asking to be disconnected.\n");
+	return PCI_ERS_RESULT_DISCONNECT;
+}
+
+static void cxl_pci_resume(struct pci_dev *pdev)
+{
+	struct cxl *adapter = pci_get_drvdata(pdev);
+	struct cxl_afu *afu;
+	struct pci_dev *afu_dev;
+	int i;
+
+	/* Everything is back now. Drivers should restart work now.
+	 * This is not the place to be checking if everything came back up
+	 * properly, because there's no return value: do that in slot_reset.
+	 */
+	for (i = 0; i < adapter->slices; i++) {
+		afu = adapter->afu[i];
+
+		list_for_each_entry(afu_dev, &afu->phb->bus->devices, bus_list) {
+			if (afu_dev->driver && afu_dev->driver->err_handler &&
+			    afu_dev->driver->err_handler->resume)
+				afu_dev->driver->err_handler->resume(afu_dev);
+		}
+	}
+}
+
+static const struct pci_error_handlers cxl_err_handler = {
+	.error_detected = cxl_pci_error_detected,
+	.slot_reset = cxl_pci_slot_reset,
+	.resume = cxl_pci_resume,
+};
+
 struct pci_driver cxl_pci_driver = {
 	.name = "cxl-pci",
 	.id_table = cxl_pci_tbl,
 	.probe = cxl_probe,
 	.remove = cxl_remove,
 	.shutdown = cxl_remove,
+	.err_handler = &cxl_err_handler,
 };
diff --git a/drivers/misc/cxl/vphb.c b/drivers/misc/cxl/vphb.c
index 2930911c1e42..6dd16a6d153f 100644
--- a/drivers/misc/cxl/vphb.c
+++ b/drivers/misc/cxl/vphb.c
@@ -266,6 +266,14 @@ int cxl_pci_vphb_add(struct cxl_afu *afu)
 	return 0;
 }
 
+void cxl_pci_vphb_reconfigure(struct cxl_afu *afu)
+{
+	/* When we are reconfigured, the AFU's MMIO space is unmapped
+	 * and remapped. We need to reflect this in the PHB's view of
+	 * the world.
+	 */
+	afu->phb->cfg_addr = afu->afu_desc_mmio + afu->crs_offset;
+}
 
 void cxl_pci_vphb_remove(struct cxl_afu *afu)
 {
-- 
2.1.4
