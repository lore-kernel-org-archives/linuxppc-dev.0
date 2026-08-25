Return-Path: <linuxppc-dev+bounces-26080-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3789AC5DF81
	for <linuxppc-dev@archiver.kernel.org>; Tue, 25 Aug 2026 02:28:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hTWsc21hSz2yrF;
	Tue, 25 Aug 2026 12:28:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787624884;
	cv=none; b=Hzf0HRFqo8M8/4AAeQs0keho/8So1DfV0KB4VShT8EwlGmNkr66Ar/0MfE74ZwocBiciUiEdKq6GfugMNtEhApj1ZaN2H0DSvII+1jr+4i59KnCExm/pjL4bDH19IYs0ITDhHwKKGzvQCDth6HFTwesY3JAV8a3crUkG1D8pXz9CZpI5JA9ed/nqkAjuxSQ/i6zQNn6r+SGtbr4UZX3nJF/vm0d+0hLefDQDfpD+97kV3yjwf2gs9TUS8/eaaPF1iVq/11rWTD+d356Ez4lQAYyWQmwS/nDo/Hovf1/y8MJUkGwYww17TXB1jpuEUcSMFflnJGTHEWb0y2O/DCIcXg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787624884; c=relaxed/relaxed;
	bh=05Ed6q5NEEJ4G20xSHNOhijKox9Q69Rn2iIQYJ+Nw2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hVBFML4dqfOnYFkIhsgtTS1LJ4qlztdGYm+AlNGuBgwlqNEB7hRuKiMdboyqKa1R8iJVxBGk9f7af+tgEYT6g6hnfYuz3ncw2nvjApQXzM1rsp2JgIjEX94dkA5hBeG919CazNnXFJP1gfmgqVbD8usKztvNIgSLKZBXbQKukIdWnnCudFoTvkSS4Cx4wAwB1yKRjQ6idFN+dqsphdMmiImYuWpLutVMkygb3FVfewnDY6pvt2znUfQfSvgp7ABPOkiyJnpXw/GPgmSFPx1hZ5zwo80C2IHO9wAocxQ5PTDwTHlwObW+dnMtJwiJOOh1B1MFz7iyjZ+g8We6jaUIKQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MDLsQXYd; dkim-atps=neutral; spf=pass (client-ip=192.198.163.9; helo=mgamail.intel.com; envelope-from=fabio.m.de.francesco@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MDLsQXYd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=192.198.163.9; helo=mgamail.intel.com; envelope-from=fabio.m.de.francesco@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hTWsZ3660z2yqs
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Aug 2026 12:28:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787624883; x=1819160883;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lLAmS+6fx1hM9aMTHu0jgGA0tViKEKeCH7C1d/uKsLI=;
  b=MDLsQXYdBpyH09Kvwxxy2ccixtHabXq2Aho90zlgWu0QpWYsBw3fl5gG
   a9znFScxLqIDkqSd2g/OgtjLv7lKblgr4NVNYni6TWj1M2Sj02KSQiB08
   r2zMivvdYD68TAq4wCtYmapiq6PVAN+K1Pi3c0K2Awi3t8bxASPGQwt24
   UTEOnpuN07lfJ2pcmy9RxRb7tDt5CCL2h6j8H9OnornFhbuVCUCoG+2iO
   P0Dj1OZ4c2IndTKoykwSzjbj/Y9oJ+c/enskDrGCSW8+8e3+NEvy1j9H/
   N8yRj5CUdETDvC5ZiTaIgtjb352V/nQgKDDec5kqKO8kR99Vq1Vjhz4fY
   w==;
X-CSE-ConnectionGUID: Kuh2LOaGTYSvwdu17IfzQA==
X-CSE-MsgGUID: ecvH+QGaS0GiVe6lUECp4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="98761203"
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="98761203"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 19:28:01 -0700
X-CSE-ConnectionGUID: 7kvMfD87SW+PktZoskkogA==
X-CSE-MsgGUID: T0wshLSRTB+ulYRvr8Pn5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="265390121"
Received: from fdefranc-mobl3.igk.intel.com ([172.28.182.157])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 19:27:54 -0700
From: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
To: linux-cxl@vger.kernel.org
Cc: David Hildenbrand <david@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	driver-core@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Subject: [PATCH v2 11/13] PCI/DPC: Unbind regions for DPC recovery
Date: Tue, 25 Aug 2026 04:26:26 +0200
Message-ID: <20260825022628.3651434-12-fabio.m.de.francesco@linux.intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260825022628.3651434-1-fabio.m.de.francesco@linux.intel.com>
References: <20260825022628.3651434-1-fabio.m.de.francesco@linux.intel.com>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CXL r4.0 sec 8.1.5.1 lists Downstream Port Containment among the
conditions that reset the Downstream Component's bus number. DPC
recovery needs to wait for the link to come back up, but if Access
Control Services Source Validation bit is enables PM Initialization will
fail to complete. 

Have dpc_reset_link() reset the secondary bus of a CXL Downstream Port.
Split pci_bridge_secondary_bus_reset() so the reset takes an action
saying what to do with the CXL regions routed through the Port, and pass
the action that unbinds them without offlining their memory. Offlining
migrates the memory that the memdev back and on a contained link are not
addressable.  Don't release the memdev driver in cxl_error_detected(). 

Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
---
 drivers/cxl/core/dport_sbr.c | 57 ++++++++++++++++++++++++++++++++-
 drivers/cxl/core/ras.c       | 10 ++++++
 drivers/pci/pci.c            | 62 ++++++++++++++++++++++++++----------
 drivers/pci/pci.h            | 15 +++++++++
 drivers/pci/pcie/dpc.c       | 46 +++++++++++++++++++++++++-
 include/linux/aer.h          |  9 ++++++
 include/linux/pci.h          |  3 ++
 7 files changed, 183 insertions(+), 19 deletions(-)

diff --git a/drivers/cxl/core/dport_sbr.c b/drivers/cxl/core/dport_sbr.c
index 2b6f840e22a7..823b63012f45 100644
--- a/drivers/cxl/core/dport_sbr.c
+++ b/drivers/cxl/core/dport_sbr.c
@@ -9,6 +9,30 @@
 #include <cxl.h>
 #include "core.h"
 
+/*
+ * cxl_region_unbind - take a region out of service ahead of a reset
+ * @cxlr: region routed through the CXL Downstream Port being reset
+ *
+ * Unbind the region driver, which tears down everything built on the region:
+ * the dax region device, its dax device and the driver bound to it. An SBR
+ * zeroes the downstream bus number, so a region left bound would decode to a
+ * device in reset.
+ *
+ * The memory the region hosts is left as it is. A caller that reaches a live
+ * device offlines it first; see cxl_region_disable().
+ *
+ * Context: process context. Driver unbind sleeps, so this cannot run in atomic
+ * context.
+ */
+static void cxl_region_unbind(struct cxl_region *cxlr)
+{
+	struct cxl_region_params *p = &cxlr->params;
+
+	device_release_driver(&cxlr->dev);
+	dev_dbg(&cxlr->dev, "%s: region unbound before reset, HPA %pr\n",
+		__func__, p->res);
+}
+
 /*
  * cxl_region_disable - make a region inactive ahead of a Secondary Bus Reset
  * @cxlr: region routed through the CXL Downstream Port being reset
@@ -58,7 +82,7 @@ static int cxl_region_disable(struct cxl_region *cxlr)
 		return rc;
 	}
 
-	device_release_driver(&cxlr->dev);
+	cxl_region_unbind(cxlr);
 	dev_dbg(&cxlr->dev, "%s: System RAM offline, region disabled before reset, HPA %pr\n",
 		__func__, p->res);
 
@@ -284,6 +308,36 @@ static int cxl_sbr_disable_regions(struct pci_dev *dport_pci)
 	return rc;
 }
 
+/*
+ * Unbind the regions routed through the Downstream Port being reset, leaving
+ * their memory online. Used on the DPC recovery path, where dpc_reset_link()
+ * clears DPC Trigger Status and enters the reset without waiting for the link,
+ * so the device may still be unreachable and the page migration that an offline
+ * performs would have no device to read from.
+ *
+ * Unbinding cannot fail, so unlike cxl_sbr_disable_regions() this never aborts
+ * the reset. The memory stays online across the reset with no region decoding
+ * it; cxl_sbr_enable_regions() reprograms the decoders on the way out.
+ */
+static void cxl_sbr_unbind_regions(struct pci_dev *dport_pci)
+{
+	struct cxl_region *cxlr;
+	struct xarray regions;
+	unsigned long index;
+
+	if (cxl_sbr_save_hdm_state(dport_pci))
+		pci_warn(dport_pci, "HDM state not saved, decode will not be restored\n");
+
+	xa_init(&regions);
+
+	cxl_sbr_collect_regions(dport_pci, &regions);
+
+	xa_for_each(&regions, index, cxlr)
+		cxl_region_unbind(cxlr);
+
+	cxl_sbr_put_regions(&regions);
+}
+
 /*
  * Re-enable the regions disabled by cxl_sbr_disable_regions(). Restore the HDM
  * decode first: a region cannot serve memory through decoders that are not
@@ -315,5 +369,6 @@ static void cxl_sbr_enable_regions(struct pci_dev *dport_pci)
 
 const struct pci_cxl_sbr_region_ops cxl_sbr_region_ops = {
 	.disable_regions = cxl_sbr_disable_regions,
+	.unbind_regions = cxl_sbr_unbind_regions,
 	.enable_regions = cxl_sbr_enable_regions,
 };
diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index 99fb00949c2f..568a906f3b50 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -323,6 +323,16 @@ pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
 		}
 		return PCI_ERS_RESULT_CAN_RECOVER;
 	case pci_channel_io_frozen:
+		/*
+		 * A Port on the path in DPC means dpc_reset_link() is about to
+		 * reset the link, and that path takes the CXL regions out of
+		 * service and restores the HDM decode itself. Keep the memdev
+		 * driver bound so the endpoint and its decoders are still there
+		 * to restore.
+		 */
+		if (pci_dpc_containment_active(pdev))
+			return PCI_ERS_RESULT_NEED_RESET;
+
 		dev_warn(&pdev->dev,
 			 "%s: frozen state error detected, disable CXL.mem\n",
 			 dev_name(dev));
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index f3781d1e8f6e..eedd516f8484 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4864,24 +4864,37 @@ struct cxl_sbr_ctx {
 	u16 command;
 };
 
-static bool is_cxl_dport(struct pci_dev *dev)
+bool is_cxl_dport(struct pci_dev *dev)
 {
 	return pcie_is_cxl(dev) && pcie_downstream_port(dev);
 }
 
-static u16 cxl_port_dvsec(struct pci_dev *dev)
+u16 cxl_port_dvsec(struct pci_dev *dev)
 {
 	return pci_find_dvsec_capability(dev, PCI_VENDOR_ID_CXL,
 					 PCI_DVSEC_CXL_PORT);
 }
 
 static int cxl_sbr_prepare(struct pci_dev *bridge, u16 dvsec,
-			   struct cxl_sbr_ctx *ctx)
+			   struct cxl_sbr_ctx *ctx,
+			   enum cxl_sbr_region_action action)
 {
 	int rc;
 
-	/* Abort before touching hardware if the regions cannot be disabled. */
-	if (cxl_sbr_region_ops) {
+	/*
+	 * CXL_SBR_UNBIND: the link is already down, so offlining the regions'
+	 * memory would take the reads that page migration performs as a machine
+	 * check. Per PCIe r7.0 sec 2.9.3 the Port answers a Non-Posted Request
+	 * with an Unsupported Request or Completer Abort completion while it is
+	 * in DPC. Unbinding never fails, so the reset always goes ahead.
+	 *
+	 * CXL_SBR_OFFLINE_AND_UNBIND: the device is reachable, so offline the
+	 * memory first and abort the reset before touching hardware if that
+	 * fails.
+	 */
+	if (cxl_sbr_region_ops && action == CXL_SBR_UNBIND) {
+		cxl_sbr_region_ops->unbind_regions(bridge);
+	} else if (cxl_sbr_region_ops) {
 		rc = cxl_sbr_region_ops->disable_regions(bridge);
 		if (rc)
 			return rc;
@@ -5003,19 +5016,17 @@ static void cxl_sbr_complete(struct pci_dev *bridge, u16 dvsec,
 		cxl_sbr_region_ops->enable_regions(bridge);
 }
 
-/**
- * pci_bridge_secondary_bus_reset - Reset the secondary bus on a PCI bridge.
- * @dev: Bridge device
- *
- * Use the bridge control register to assert reset on the secondary bus.
- * Devices on the secondary bus are left in power-on state.
+/*
+ * __pci_bridge_secondary_bus_reset - assert Secondary Bus Reset on a bridge
+ * @dev: bridge device
+ * @action: what to do with the CXL regions reached through @dev
  *
- * When @dev is a CXL Downstream Port, clear ACS Source Validation and Bus
- * Master Enable across the reset, per the workaround in CXL r4.0 sec 8.1.5.1,
- * so that Port Power Management Initialization completes at link-up. The
- * bits stay cleared until the secondary bus is back, then are restored.
+ * See pci_bridge_secondary_bus_reset(). Pass CXL_SBR_UNBIND when the link is
+ * already down, which leaves the regions' memory online because offlining it
+ * needs a reachable device.
  */
-int pci_bridge_secondary_bus_reset(struct pci_dev *dev)
+int __pci_bridge_secondary_bus_reset(struct pci_dev *dev,
+				     enum cxl_sbr_region_action action)
 {
 	struct cxl_sbr_ctx ctx = {};
 	u16 dvsec = 0;
@@ -5028,7 +5039,7 @@ int pci_bridge_secondary_bus_reset(struct pci_dev *dev)
 	if (is_cxl_dport(dev))
 		dvsec = cxl_port_dvsec(dev);
 	if (dvsec) {
-		rc = cxl_sbr_prepare(dev, dvsec, &ctx);
+		rc = cxl_sbr_prepare(dev, dvsec, &ctx, action);
 		if (rc)
 			return rc;
 	}
@@ -5042,6 +5053,23 @@ int pci_bridge_secondary_bus_reset(struct pci_dev *dev)
 
 	return rc;
 }
+
+/**
+ * pci_bridge_secondary_bus_reset - Reset the secondary bus on a PCI bridge.
+ * @dev: Bridge device
+ *
+ * Use the bridge control register to assert reset on the secondary bus.
+ * Devices on the secondary bus are left in power-on state.
+ *
+ * When @dev is a CXL Downstream Port, clear ACS Source Validation and Bus
+ * Master Enable across the reset, per the workaround in CXL r4.0 sec 8.1.5.1,
+ * so that Port Power Management Initialization completes at link-up. The
+ * bits stay cleared until the secondary bus is back, then are restored.
+ */
+int pci_bridge_secondary_bus_reset(struct pci_dev *dev)
+{
+	return __pci_bridge_secondary_bus_reset(dev, CXL_SBR_OFFLINE_AND_UNBIND);
+}
 EXPORT_SYMBOL_GPL(pci_bridge_secondary_bus_reset);
 
 static int pci_parent_bus_reset(struct pci_dev *dev, bool probe)
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 4469e1a77f3c..b6d873b077ed 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -233,6 +233,21 @@ int pci_mmap_fits(struct pci_dev *pdev, int resno, struct vm_area_struct *vmai,
 bool pci_reset_supported(struct pci_dev *dev);
 void pci_init_reset_methods(struct pci_dev *dev);
 int pci_bridge_secondary_bus_reset(struct pci_dev *dev);
+
+/*
+ * What to do with the CXL regions reached through a Downstream Port before it
+ * is reset. Offlining their memory needs a reachable device, so a Port whose
+ * link is already down only unbinds and leaves the memory online.
+ */
+enum cxl_sbr_region_action {
+	CXL_SBR_OFFLINE_AND_UNBIND,
+	CXL_SBR_UNBIND,
+};
+
+int __pci_bridge_secondary_bus_reset(struct pci_dev *dev,
+				     enum cxl_sbr_region_action action);
+bool is_cxl_dport(struct pci_dev *dev);
+u16 cxl_port_dvsec(struct pci_dev *dev);
 int pci_bus_error_reset(struct pci_dev *dev);
 int pci_try_reset_bridge(struct pci_dev *bridge);
 
diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index 2b779bd1d861..ad74086bf82c 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -127,6 +127,44 @@ bool pci_dpc_recovered(struct pci_dev *pdev)
 }
 #endif /* CONFIG_HOTPLUG_PCI_PCIE */
 
+/**
+ * pci_dpc_containment_active - whether a Port above @pdev is contained by DPC
+ * @pdev: PCI device below the Port
+ *
+ * Per PCIe r7.0 sec 2.9.3 the Port's LTSSM stays in the Disabled state while
+ * DPC Trigger Status is set, and dpc_reset_link() clears that bit only after
+ * pcie_do_recovery() has broadcast error_detected. A ->error_detected()
+ * callback can therefore use this to tell a DPC containment from any other
+ * frozen-channel error, and to know that the link is about to be reset.
+ *
+ * The Port that triggered is on the path to @pdev, because the broadcast walks
+ * that Port's subordinate bus, so test every bridge above @pdev.
+ *
+ * Return: true if a Port on the path to @pdev has DPC Trigger Status set.
+ */
+bool pci_dpc_containment_active(struct pci_dev *pdev)
+{
+	struct pci_dev *bridge;
+
+	for (bridge = pci_upstream_bridge(pdev); bridge;
+	     bridge = pci_upstream_bridge(bridge)) {
+		u16 status;
+
+		if (!bridge->dpc_cap)
+			continue;
+
+		pci_read_config_word(bridge,
+				     bridge->dpc_cap + PCI_EXP_DPC_STATUS,
+				     &status);
+		if (!PCI_POSSIBLE_ERROR(status) &&
+		    (status & PCI_EXP_DPC_STATUS_TRIGGER))
+			return true;
+	}
+
+	return false;
+}
+EXPORT_SYMBOL_GPL(pci_dpc_containment_active);
+
 static int dpc_wait_rp_inactive(struct pci_dev *pdev)
 {
 	unsigned long timeout = jiffies + HZ;
@@ -149,6 +187,7 @@ pci_ers_result_t dpc_reset_link(struct pci_dev *pdev)
 {
 	pci_ers_result_t ret;
 	u16 cap;
+	int rc;
 
 	set_bit(PCI_DPC_RECOVERING, &pdev->priv_flags);
 
@@ -174,7 +213,12 @@ pci_ers_result_t dpc_reset_link(struct pci_dev *pdev)
 	pci_write_config_word(pdev, cap + PCI_EXP_DPC_STATUS,
 			      PCI_EXP_DPC_STATUS_TRIGGER);
 
-	if (pci_bridge_wait_for_secondary_bus(pdev, "DPC")) {
+	if (is_cxl_dport(pdev) && cxl_port_dvsec(pdev))
+		rc = __pci_bridge_secondary_bus_reset(pdev, CXL_SBR_UNBIND);
+	else
+		rc = pci_bridge_wait_for_secondary_bus(pdev, "DPC");
+
+	if (rc) {
 		clear_bit(PCI_DPC_RECOVERED, &pdev->priv_flags);
 		ret = PCI_ERS_RESULT_DISCONNECT;
 	} else {
diff --git a/include/linux/aer.h b/include/linux/aer.h
index df0f5c382286..7ac029f01c25 100644
--- a/include/linux/aer.h
+++ b/include/linux/aer.h
@@ -66,6 +66,15 @@ static inline int pcie_aer_is_native(struct pci_dev *dev) { return 0; }
 static inline void pci_aer_unmask_internal_errors(struct pci_dev *dev) { }
 #endif
 
+#if defined(CONFIG_PCIE_DPC)
+bool pci_dpc_containment_active(struct pci_dev *pdev);
+#else
+static inline bool pci_dpc_containment_active(struct pci_dev *pdev)
+{
+	return false;
+}
+#endif
+
 void pci_print_aer(struct pci_dev *dev, int aer_severity,
 		    struct aer_capability_regs *aer);
 int cper_severity_to_aer(int cper_severity);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 2feb0e355305..0d9832ce6f3d 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1609,10 +1609,13 @@ int pci_bridge_secondary_bus_reset(struct pci_dev *dev);
 /**
  * struct pci_cxl_sbr_region_ops - CXL region callbacks for a bus reset
  * @disable_regions: disable the regions below @dport, 0 or errno
+ * @unbind_regions: unbind the drivers of the regions below @dport, leaving
+ *		    their memory online, for a link already contained
  * @enable_regions: re-enable the regions below @dport
  */
 struct pci_cxl_sbr_region_ops {
 	int (*disable_regions)(struct pci_dev *dport);
+	void (*unbind_regions)(struct pci_dev *dport);
 	void (*enable_regions)(struct pci_dev *dport);
 };
 
-- 
2.55.0


