Return-Path: <linuxppc-dev+bounces-26078-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD367C5DF81
	for <linuxppc-dev@archiver.kernel.org>; Tue, 25 Aug 2026 02:28:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hTWsN2mFPz2yqx;
	Tue, 25 Aug 2026 12:27:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787624872;
	cv=none; b=GfV7qcE654+CFCR29DFyi3CJw7uk48HfQTIG5f6X/IysGyaGmis1cXllAQczuC0tOZzYULlHXGvLLGqO+kY3Ai+7SHTd53GqGZCspJPaINjtnr0dOx5yhQ50RDBFnhXx+AkvE39Tcp7vhM4F9iZSdBVC299LUumY3PmZw4KQZhz3W6DyIuQ7Bvo61Zu78KAQNVfmKi9lZ9aPARJu67T7zVnRIjC6WzXsLdG65Q3yPHgNoUm4Dsqrc6QS8Dx97RdYmiywtRCRGXiuFjRr7/dBYesqKfNuILEaupiYCFgjWc8vFtS9D8NAXbC2lKnDZjejdjdiHywp9a153N/p22jr4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787624872; c=relaxed/relaxed;
	bh=KY/aFj/stJo1CE7RylgoJbEoIPDAMPyqnpDBZzXjraM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m1I8azDd345TGbpq3Ql67eLePlxtnbdmpdbUZstVYIg/D8L0+nDbu+eXWwLahNH+Nt6vtWgfExzytfElFb6mp/qST8Ly+3UAevYWmjfxui8/PWviUDl0rLDmXrN7CWNJaWm/s2TvgaGna922i2PidD4dte3/h4eFHppPoSKcTYWVG7ciHQWsqLcRFwwnA92Kp+vN4ki7ld2mwuIgV5iFmbJxMqm6GsCrNShw0Bh6m1KhxqZ9qh1zE5SHJeeeTmVHDGTZk+hxdNib1B3NIWi/OPcdIcBV5z8pGBM4DNaE/vHsLhaFlq/R55222c+0XWffmNnWan8/iAr8/JH6Qiy3XQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dRvjkvWs; dkim-atps=neutral; spf=pass (client-ip=192.198.163.9; helo=mgamail.intel.com; envelope-from=fabio.m.de.francesco@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dRvjkvWs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=192.198.163.9; helo=mgamail.intel.com; envelope-from=fabio.m.de.francesco@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hTWsL4TWbz2yqs
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Aug 2026 12:27:50 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787624871; x=1819160871;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0VoRnnTQayChxBzG4acN6XeGhlm8VUhd+VjdCd1S3xA=;
  b=dRvjkvWslrX70wWpXWuFcnDjq/2jVAtiI8ckz595r5Jl2VzkI4b8JWIv
   y0BvLY4RYFwWvFufT+oWpueF9k0OvWS03yV9xrqRmF9QauCitwgWgjXgO
   kCNhByKDJYhC0hoPW16bAh4apw/k0gNMpCc2Mu2UcudEPDFMPzajXSH9C
   Gh72AA/KAbw0vYjWs72ikcpPBzcXL7t6gx+WKVmU8aj2ZvjPFAIcCCn/p
   6nduURn7EQTgoWMM04mS5ebrRx8kkGONH0YwowvOCuQJTBSQk33eTpuB2
   wT9c0uqeyCf0It6LcC9bn1cQ6f0KSPpUvku8UTQslMd6dfCwE6pQ6UM6E
   w==;
X-CSE-ConnectionGUID: ZzkGsrkPRf+PGfQVa5ll9g==
X-CSE-MsgGUID: Qz5NiuPsS3eXbYs+pu1TbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="98761160"
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="98761160"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 19:27:47 -0700
X-CSE-ConnectionGUID: FzrjbiKsTl227JOq1FD4UQ==
X-CSE-MsgGUID: IuaxB+CZRSy5ERI6aEK7+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="265390111"
Received: from fdefranc-mobl3.igk.intel.com ([172.28.182.157])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 19:27:40 -0700
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
Subject: [PATCH v2 09/13] PCI/CXL: Disable and re-enable CXL regions
Date: Tue, 25 Aug 2026 04:26:24 +0200
Message-ID: <20260825022628.3651434-10-fabio.m.de.francesco@linux.intel.com>
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

A Secondary Bus Reset of a CXL Downstream Port needs every CXL region
routed through that Port disabled for the duration.

Add struct pci_cxl_sbr_region_ops, holding a disable_regions() and an
enable_regions() callback, and pci_cxl_set_sbr_region_ops() for the CXL
core to register them. The pointer is NULL whenever the CXL region code
is absent, either not built or built as a module that is not loaded.

Add cxl_sbr_disable_regions(), which collects the regions with a member
endpoint below the Port and disables each one. If any fails, re-enable
the whole collected set and return the error, so the PCI core aborts the
reset before touching hardware; re-enabling a region left untouched is a
no-op, which also recovers the one that failed midway.

Add cxl_sbr_enable_regions() for the other side. It restores the HDM
decoders below the Port before it re-attaches any region driver, since a
region cannot serve memory through decoders that are not programmed.

cxl_sbr_disable_regions() records the decoder registers before it
touches anything and cxl_sbr_enable_regions() hands them to the restore
and releases them. They are held in an xarray indexed by the Downstream
Port's struct pci_dev, so resets of different Ports do not share an
entry, and they are released on the abort path too, where
enable_regions() never runs.

Register both ops from cxl_region_init() and clear the pointer in
cxl_region_exit().

Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
---
 drivers/cxl/core/core.h      |   9 +--
 drivers/cxl/core/dport_sbr.c | 152 +++++++++++++++++++++++++++++++++--
 drivers/cxl/core/region.c    |   3 +
 drivers/pci/pci.c            |  13 +++
 include/linux/pci.h          |  12 +++
 5 files changed, 175 insertions(+), 14 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 077a2af9cf0c..b250fa346184 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -57,13 +57,8 @@ int devm_cxl_add_dax_region(struct cxl_region *cxlr);
 int devm_cxl_add_pmem_region(struct cxl_region *cxlr);
 void kill_regions(struct cxl_root_decoder *cxlrd);
 int cxl_region_invalidate_memregion(struct cxl_region *cxlr);
-int cxl_region_disable(struct cxl_region *cxlr);
-void cxl_region_enable(struct cxl_region *cxlr);
-struct pci_dev;
-int cxl_sbr_collect_regions(struct pci_dev *dport_pci, struct xarray *regions);
-void cxl_sbr_put_regions(struct xarray *regions);
-void cxl_sbr_recommit_decoders(struct pci_dev *dport_pci,
-			       struct xarray *hdm_state);
+struct pci_cxl_sbr_region_ops;
+extern const struct pci_cxl_sbr_region_ops cxl_sbr_region_ops;
 
 #else
 static inline u64 cxl_dpa_to_hpa(struct cxl_region *cxlr,
diff --git a/drivers/cxl/core/dport_sbr.c b/drivers/cxl/core/dport_sbr.c
index 233499bc1fad..2b6f840e22a7 100644
--- a/drivers/cxl/core/dport_sbr.c
+++ b/drivers/cxl/core/dport_sbr.c
@@ -21,7 +21,7 @@
  * Context: process context. Offlining and driver unbind sleep and take the
  * memory hotplug lock, so this cannot run in atomic context.
  */
-int cxl_region_disable(struct cxl_region *cxlr)
+static int cxl_region_disable(struct cxl_region *cxlr)
 {
 	struct cxl_region_params *p = &cxlr->params;
 	unsigned long block_size;
@@ -72,7 +72,7 @@ int cxl_region_disable(struct cxl_region *cxlr)
  * Rebind the region driver. The System RAM is left offline; bringing it back
  * online is a separate administrative step.
  */
-void cxl_region_enable(struct cxl_region *cxlr)
+static void cxl_region_enable(struct cxl_region *cxlr)
 {
 	struct cxl_region_params *p = &cxlr->params;
 
@@ -93,8 +93,8 @@ void cxl_region_enable(struct cxl_region *cxlr)
  * cxl_region_disable()/cxl_region_enable() run with the rwsem released (they
  * unbind and rebind the region driver). Hence snapshot the set first.
  */
-int cxl_sbr_collect_regions(struct pci_dev *dport_pci,
-			    struct xarray *regions)
+static int cxl_sbr_collect_regions(struct pci_dev *dport_pci,
+				   struct xarray *regions)
 {
 	struct cxl_region_ref *cxl_rr;
 	struct cxl_dport *dport;
@@ -141,7 +141,7 @@ int cxl_sbr_collect_regions(struct pci_dev *dport_pci,
 	return 0;
 }
 
-void cxl_sbr_put_regions(struct xarray *regions)
+static void cxl_sbr_put_regions(struct xarray *regions)
 {
 	struct cxl_region *cxlr;
 	unsigned long index;
@@ -159,8 +159,8 @@ void cxl_sbr_put_regions(struct xarray *regions)
  * requires. The caller has already disabled the regions, so nothing reaches the
  * decoders being reprogrammed.
  */
-void cxl_sbr_recommit_decoders(struct pci_dev *dport_pci,
-			       struct xarray *hdm_state)
+static void cxl_sbr_recommit_decoders(struct pci_dev *dport_pci,
+				      struct xarray *hdm_state)
 {
 	struct cxl_dport *dport;
 	int rc;
@@ -179,3 +179,141 @@ void cxl_sbr_recommit_decoders(struct pci_dev *dport_pci,
 	if (rc)
 		pci_warn(dport_pci, "HDM decode restore failed: %d\n", rc);
 }
+
+/*
+ * The HDM decoder control registers the reset is about to clear, held from the
+ * disable to the enable of one Downstream Port and indexed by that Port's
+ * struct pci_dev, so resets of different Ports do not share an entry.
+ */
+static DEFINE_XARRAY(cxl_sbr_hdm_state);
+
+static void cxl_sbr_drop_hdm_state(struct pci_dev *dport_pci)
+{
+	struct xarray *hdm_state;
+
+	hdm_state = xa_erase(&cxl_sbr_hdm_state, (unsigned long)dport_pci);
+	if (!hdm_state)
+		return;
+
+	cxl_port_put_hdm_state(hdm_state);
+	kfree(hdm_state);
+}
+
+/*
+ * Record the control registers of every port below @dport_pci before the reset
+ * clears them. cxl_sbr_enable_regions() consumes the set and drops it.
+ */
+static int cxl_sbr_save_hdm_state(struct pci_dev *dport_pci)
+{
+	struct xarray *hdm_state;
+	struct cxl_dport *dport;
+	int rc;
+
+	struct cxl_port *port __free(put_cxl_port) =
+		find_cxl_port(&dport_pci->dev, &dport);
+	if (!port)
+		return 0;
+
+	hdm_state = kzalloc_obj(*hdm_state);
+	if (!hdm_state)
+		return -ENOMEM;
+
+	xa_init(hdm_state);
+
+	scoped_guard(rwsem_read, &cxl_rwsem.region)
+		rc = cxl_port_save_hdm_state(port, hdm_state);
+
+	if (!rc)
+		rc = xa_insert(&cxl_sbr_hdm_state, (unsigned long)dport_pci,
+			       hdm_state, GFP_KERNEL);
+	if (rc) {
+		cxl_port_put_hdm_state(hdm_state);
+		kfree(hdm_state);
+		return rc;
+	}
+
+	return 0;
+}
+
+/*
+ * Disable the regions routed through the Downstream Port being reset. On
+ * failure re-enable the regions already disabled and return the error so the
+ * PCI core aborts the reset with the topology unchanged.
+ */
+static int cxl_sbr_disable_regions(struct pci_dev *dport_pci)
+{
+	struct cxl_region *cxlr;
+	struct xarray regions;
+	unsigned long index;
+	int rc;
+
+	rc = cxl_sbr_save_hdm_state(dport_pci);
+	if (rc)
+		return rc;
+
+	xa_init(&regions);
+
+	rc = cxl_sbr_collect_regions(dport_pci, &regions);
+	if (rc)
+		goto out;
+
+	xa_for_each(&regions, index, cxlr) {
+		rc = cxl_region_disable(cxlr);
+		if (rc)
+			break;
+	}
+
+	/*
+	 * On failure restore every collected region and return the error so the
+	 * PCI core aborts the reset before touching the hardware. Re-enabling a
+	 * region left untouched is a no-op, so enabling the whole set also
+	 * recovers the region whose offline failed midway.
+	 */
+	if (rc) {
+		dev_dbg(&dport_pci->dev, "%s: disable failed (%d), re-enabling collected regions and aborting reset\n",
+			__func__, rc);
+		xa_for_each(&regions, index, cxlr)
+			cxl_region_enable(cxlr);
+	}
+
+out:
+	cxl_sbr_put_regions(&regions);
+	/* No enable_regions() call follows an aborted reset, so drop the set. */
+	if (rc)
+		cxl_sbr_drop_hdm_state(dport_pci);
+	return rc;
+}
+
+/*
+ * Re-enable the regions disabled by cxl_sbr_disable_regions(). Restore the HDM
+ * decode first: a region cannot serve memory through decoders that are not
+ * programmed, so its driver must not re-attach before they are.
+ */
+static void cxl_sbr_enable_regions(struct pci_dev *dport_pci)
+{
+	struct xarray *hdm_state;
+	struct cxl_region *cxlr;
+	struct xarray regions;
+	unsigned long index;
+
+	xa_init(&regions);
+
+	cxl_sbr_collect_regions(dport_pci, &regions);
+
+	hdm_state = xa_load(&cxl_sbr_hdm_state, (unsigned long)dport_pci);
+	if (hdm_state)
+		cxl_sbr_recommit_decoders(dport_pci, hdm_state);
+	else
+		pci_warn(dport_pci, "no saved HDM state, decode not restored\n");
+
+	xa_for_each(&regions, index, cxlr)
+		cxl_region_enable(cxlr);
+
+	cxl_sbr_put_regions(&regions);
+	cxl_sbr_drop_hdm_state(dport_pci);
+}
+
+const struct pci_cxl_sbr_region_ops cxl_sbr_region_ops = {
+	.disable_regions = cxl_sbr_disable_regions,
+	.enable_regions = cxl_sbr_enable_regions,
+};
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index fc0bec991a69..d1dd4924fba1 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -12,6 +12,7 @@
 #include <linux/idr.h>
 #include <linux/memory-tiers.h>
 #include <linux/string_choices.h>
+#include <linux/pci.h>
 #include <cxlmem.h>
 #include <cxl.h>
 #include "core.h"
@@ -4263,12 +4264,14 @@ static struct cxl_driver cxl_region_driver = {
 
 int cxl_region_init(void)
 {
+	pci_cxl_set_sbr_region_ops(&cxl_sbr_region_ops);
 	return cxl_driver_register(&cxl_region_driver);
 }
 
 void cxl_region_exit(void)
 {
 	cxl_driver_unregister(&cxl_region_driver);
+	pci_cxl_set_sbr_region_ops(NULL);
 }
 
 MODULE_IMPORT_NS("CXL");
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 77b17b13ee61..417b6b44473e 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4844,6 +4844,19 @@ void __weak pcibios_reset_secondary_bus(struct pci_dev *dev)
 	pci_reset_secondary_bus(dev);
 }
 
+/*
+ * Registered by the CXL core to disable and re-enable the regions mapped
+ * through a CXL Downstream Port across a Secondary Bus Reset. NULL whenever
+ * the CXL region code is absent: not built, or built as a module not loaded.
+ */
+static const struct pci_cxl_sbr_region_ops *cxl_sbr_region_ops;
+
+void pci_cxl_set_sbr_region_ops(const struct pci_cxl_sbr_region_ops *ops)
+{
+	cxl_sbr_region_ops = ops;
+}
+EXPORT_SYMBOL_GPL(pci_cxl_set_sbr_region_ops);
+
 /**
  * pci_bridge_secondary_bus_reset - Reset the secondary bus on a PCI bridge.
  * @dev: Bridge device
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 64b308b6e61c..2feb0e355305 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1606,6 +1606,18 @@ int devm_request_pci_bus_resources(struct device *dev,
 /* Temporary until new and working PCI SBR API in place */
 int pci_bridge_secondary_bus_reset(struct pci_dev *dev);
 
+/**
+ * struct pci_cxl_sbr_region_ops - CXL region callbacks for a bus reset
+ * @disable_regions: disable the regions below @dport, 0 or errno
+ * @enable_regions: re-enable the regions below @dport
+ */
+struct pci_cxl_sbr_region_ops {
+	int (*disable_regions)(struct pci_dev *dport);
+	void (*enable_regions)(struct pci_dev *dport);
+};
+
+void pci_cxl_set_sbr_region_ops(const struct pci_cxl_sbr_region_ops *ops);
+
 #define __pci_bus_for_each_res0(bus, res, ...)				\
 	for (unsigned int __b = 0;					\
 	     (res = pci_bus_resource_n(bus, __b)) || __b < PCI_BRIDGE_RESOURCE_NUM; \
-- 
2.55.0


