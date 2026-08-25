Return-Path: <linuxppc-dev+bounces-26076-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 412B9C5DF81
	for <linuxppc-dev@archiver.kernel.org>; Tue, 25 Aug 2026 02:27:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hTWs507Hvz2y2K;
	Tue, 25 Aug 2026 12:27:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787624856;
	cv=none; b=EtSdmQuLgr7Y2l6eSuiwg4vqG/qS1f+7y+9z+kr3I6XpRjAZumPHSJwBxpkbVYIsEQI4p11YDPYLz9pHxevbh203y9Rg4P3eDPQfal6NBxARHgvoUFa78nkHMT5AY9KLzR9KNvc3dXvULTuOm3vdUv9WtZo4TH2YtIMHuOpbVVtRXzWtnEaRLIZJvWgJEh/vaEQdt7ccS1zQfZm2i+/uvLCZ/4pnHDTf0BIyswVy8nQGjE0nRMsgFd0rPuG7U5fQMgNHuUN7+7Itetd8tvJiXFUSMg8W8wdPKug8UjeItQ6PEii6UmnBuc+ekENkgKXwemiALv2uOI00NvNKin8RJw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787624856; c=relaxed/relaxed;
	bh=Gg63PhMraaFvL8DloQlOafHaxDCdsaa0LL08JCLdwZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dDVVFtHDcuIGRbuPgPJ16lBh9PyJlCdrTSm5g/h2YgSNHSsK5LGTg6z86/XDNOIxpVOQVzXh3SuulGM7QBqj4WBUkbExwr3NYrK8iB7xh39kk2kEJ9ac41f9QCUR/ofkzRv/GTJG8kOCMpXVol5D0eP5nlYMRCWeEO9z5ds10KkM5hcMSLlZViMglPoA16XXLua5un6jY55oSp0Qi0r0WDEQLxM+tqnfIfvINSaaT1glGrEw247Qoo/JlabLa9BqElN3WkfBu6RVMmFSpxrgKfSoWB357NhX87zF/8DsLOgHhyGTBIb3vuKTEmtDE8i+3Tz0SpFqFomWZR/oJtadXw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=IbIe3tYI; dkim-atps=neutral; spf=pass (client-ip=192.198.163.9; helo=mgamail.intel.com; envelope-from=fabio.m.de.francesco@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=IbIe3tYI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=192.198.163.9; helo=mgamail.intel.com; envelope-from=fabio.m.de.francesco@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hTWs34gw0z2ynZ
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Aug 2026 12:27:35 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787624856; x=1819160856;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pWL2Fx2f1XZ+ch7E4+5dIo1Wx0My4gYiTT+UYgnRcCg=;
  b=IbIe3tYIIES90aMH2SCeJU/a3dW++NNq02DcNMhYkgfex4uGBueKFjUQ
   fuFibRR6jhmhAiFRtig957l8GlmCrDOtzCucmDAelkV3ZWsR64UhwG4Fd
   EcEXUJvx0NxYnP7Hs4+RiGBsxyFHA3K4XVocDacm4y9s6XddIXXlsHRjR
   pdeg99kAgebCdx3XvhCpOibkMoDSnltK9wOMaoRiiO3jMY7S2WYm7AGkc
   bejrnR+YWiWQT6N9gTulZ7vKE586kQD/5MdQQo/07aAmXBhoOeNP915nj
   BRUkHnivVmboEnTyPm2GYCKzv/9RPh3+fQQQpnVCHORzXxQxnEfDgXZDL
   Q==;
X-CSE-ConnectionGUID: RveuyJBGSSuKlt/g2eSjhg==
X-CSE-MsgGUID: Uzei5jGlRmugijdVA4p9tQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="98761126"
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="98761126"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 19:27:32 -0700
X-CSE-ConnectionGUID: 7NtM2xUoQvWwCT7qK5iedg==
X-CSE-MsgGUID: cG6ZbR99R2KFBRJD6RIbrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="265390100"
Received: from fdefranc-mobl3.igk.intel.com ([172.28.182.157])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 19:27:25 -0700
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
Subject: [PATCH v2 07/13] cxl/core: Add region disable and enable for a DPort SBR
Date: Tue, 25 Aug 2026 04:26:22 +0200
Message-ID: <20260825022628.3651434-8-fabio.m.de.francesco@linux.intel.com>
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

A Secondary Bus Reset of a CXL Downstream Port removes the downstream
component from the bus, so a CXL region reached through that Port has to
be disabled while the reset runs.

Add cxl_region_disable() to offline memory, invalidate the CPU caches
for its range and release its driver, and cxl_region_enable() to
re-attach the driver afterwards.

Neither function has a caller yet. Both are driven by the reset once the
set of regions routed through the Port is known.

Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
---
 drivers/cxl/core/core.h      |  3 ++
 drivers/cxl/core/dport_sbr.c | 79 ++++++++++++++++++++++++++++++++++++
 drivers/cxl/core/region.c    |  3 +-
 3 files changed, 84 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index a8b9d7990d32..ac55f9e8160e 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -56,6 +56,9 @@ u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
 int devm_cxl_add_dax_region(struct cxl_region *cxlr);
 int devm_cxl_add_pmem_region(struct cxl_region *cxlr);
 void kill_regions(struct cxl_root_decoder *cxlrd);
+int cxl_region_invalidate_memregion(struct cxl_region *cxlr);
+int cxl_region_disable(struct cxl_region *cxlr);
+void cxl_region_enable(struct cxl_region *cxlr);
 struct pci_dev;
 void cxl_sbr_recommit_decoders(struct pci_dev *dport_pci,
 			       struct xarray *hdm_state);
diff --git a/drivers/cxl/core/dport_sbr.c b/drivers/cxl/core/dport_sbr.c
index 55c35386d0cb..0f398ab0d3a4 100644
--- a/drivers/cxl/core/dport_sbr.c
+++ b/drivers/cxl/core/dport_sbr.c
@@ -1,11 +1,90 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright(c) 2026 Intel Corporation. */
 
+#include <linux/memregion.h>
+#include <linux/memory_hotplug.h>
+#include <linux/memory.h>
 #include <linux/device.h>
 #include <linux/pci.h>
 #include <cxl.h>
 #include "core.h"
 
+/*
+ * cxl_region_disable - make a region inactive ahead of a Secondary Bus Reset
+ * @cxlr: region routed through the CXL Downstream Port being reset
+ *
+ * Offline the memory blocks the region owns and unbind its driver. An SBR
+ * zeroes the downstream bus number, so a region left live as System RAM would
+ * be accessed while the device is in reset. On offline failure return the error
+ * so the caller aborts the reset; the memory is never force-removed.
+ *
+ * Context: process context. Offlining and driver unbind sleep and take the
+ * memory hotplug lock, so this cannot run in atomic context.
+ */
+int cxl_region_disable(struct cxl_region *cxlr)
+{
+	struct cxl_region_params *p = &cxlr->params;
+	unsigned long block_size;
+	u64 start, end;
+	int rc;
+
+	/*
+	 * Per CXL r4.0 sec 9.13.1 an Interleave Set has a Base HPA and a Size
+	 * that are multiples of 256 MB, while a memory block spans up to 2 GB.
+	 * A block overlapping either end of the range therefore also covers
+	 * memory outside this region, so round the range inward to block
+	 * granularity as dax_kmem did when it onlined the range. Offlining a
+	 * straddling block would migrate pages that the reset does not affect.
+	 */
+	block_size = memory_block_size_bytes();
+	start = ALIGN(p->res->start, block_size);
+	end = ALIGN_DOWN(p->res->end + 1, block_size);
+	if (start >= end) {
+		dev_dbg(&cxlr->dev, "%s: HPA %pr spans no whole memory block, no System RAM to offline\n",
+			__func__, p->res);
+	} else {
+		rc = cxl_offline_memory(start, end - start);
+		if (rc) {
+			dev_warn(&cxlr->dev, "offline System RAM failed before reset: %d\n",
+				 rc);
+			return rc;
+		}
+	}
+
+	rc = cxl_region_invalidate_memregion(cxlr);
+	if (rc) {
+		dev_warn(&cxlr->dev, "CPU cache invalidate failed before reset: %d\n",
+			 rc);
+		return rc;
+	}
+
+	device_release_driver(&cxlr->dev);
+	dev_dbg(&cxlr->dev, "%s: System RAM offline, region disabled before reset, HPA %pr\n",
+		__func__, p->res);
+
+	return 0;
+}
+
+/*
+ * cxl_region_enable - restore a region after a Secondary Bus Reset
+ * @cxlr: region disabled by cxl_region_disable() before the reset
+ *
+ * Rebind the region driver. The System RAM is left offline; bringing it back
+ * online is a separate administrative step.
+ */
+void cxl_region_enable(struct cxl_region *cxlr)
+{
+	struct cxl_region_params *p = &cxlr->params;
+
+	if (device_attach(&cxlr->dev) < 0) {
+		dev_dbg(&cxlr->dev, "driver re-attach failed after reset\n");
+		return;
+	}
+
+	dev_dbg(&cxlr->dev, "%s: region re-enabled after reset, HPA %pr, IW %d, IG %d\n",
+		__func__, p->res, p->interleave_ways, p->interleave_granularity);
+}
+
 /*
  * The reset cleared the HDM Decoder registers of every CXL component below
  * @dport_pci, so restore them from the settings the driver holds and from
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 1e211542b6b6..fc0bec991a69 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -222,7 +222,7 @@ static struct cxl_region_ref *cxl_rr_load(struct cxl_port *port,
 	return xa_load(&port->regions, (unsigned long)cxlr);
 }
 
-static int cxl_region_invalidate_memregion(struct cxl_region *cxlr)
+int cxl_region_invalidate_memregion(struct cxl_region *cxlr)
 {
 	if (!cpu_cache_has_invalidate_memregion()) {
 		if (IS_ENABLED(CONFIG_CXL_REGION_INVALIDATION_TEST)) {
@@ -4273,4 +4273,5 @@ void cxl_region_exit(void)
 
 MODULE_IMPORT_NS("CXL");
 MODULE_IMPORT_NS("DEVMEM");
+MODULE_IMPORT_NS("CXL_MHP");
 MODULE_ALIAS_CXL(CXL_DEVICE_REGION);
-- 
2.55.0


