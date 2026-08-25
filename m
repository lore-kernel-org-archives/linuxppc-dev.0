Return-Path: <linuxppc-dev+bounces-26074-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57EE4C5DF9C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 25 Aug 2026 02:27:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hTWrl706Qz2yps;
	Tue, 25 Aug 2026 12:27:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787624839;
	cv=none; b=bGfgCVGax85F2yOpRPpFZKN2dFCxx2KLlM3rUdbB5fh0YeyQ3tpXvzChYiAYiW3SWHC+mzxwYY1TxHXhC19jxzT+ES+Dsb0Ag2hspfC4AYjXBUl5VMKWs92ks7cCvugsDrmWyvVH3MWi9EtloysPfjbVbcWgrxxSnfMvtUmeCiyDNkc2Dppg3oJ1BCUpdDMUlicQtjZ64uwPh0me6O8fltbC/22+qMs724JVLnDaQScTiu6CGK/Tw6sxbJZgrp8Pz6ecMjvsWheM50dXQRDwezflRZgNgxKzDicyMOhLqg6U9+5Kp3WFDseQey2/zwRd3U3wmNUVgDgfOEsjr/mNSg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787624839; c=relaxed/relaxed;
	bh=7jeLjlOYa7PXwb2mErSpf6zXoDgFdbgFFzGGOuic07s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KKOlANNMXTOuMcvNcNn94nixhxxaLVHB+GGgCZbi9Lau+pfqbYOMSsV9zYcQHo1Uoyy6/YQGdaAPxA3m6tQ2HPL2E9zkxfoGNANQktAQM+r75g1i4b5d/4MjBM49WiQCVJmZcpaVs8s/1GVRL6haJNrJBS1gm/cYMpcuBAZyORCCt5W6TI0PFfdjep414MvtoczHEdPD85kSsoJhO5uIB+3MIbnhXicR9viRn2Cd6nz58jGN7zj1e5IFMRp5wDpHa4hNpjLfKJ6jHM3Z9yOQX9KlBEceqyZmISXoLYGnFwQWpQhQc8XxOF93K83ZbdmJ4Mue1HMpyO+7e1CYRZJwug==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jj3SWHQW; dkim-atps=neutral; spf=pass (client-ip=192.198.163.9; helo=mgamail.intel.com; envelope-from=fabio.m.de.francesco@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jj3SWHQW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=192.198.163.9; helo=mgamail.intel.com; envelope-from=fabio.m.de.francesco@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hTWrk57TRz2y2K
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Aug 2026 12:27:18 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787624839; x=1819160839;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aXTtEnO6MnuWppdHZS1gvwOd5SjDHPsW8ORjbcfJWQQ=;
  b=jj3SWHQWNA8+h1UjbIHga8UQBQYf1JCFrRAsGLRf1k+SaeWpuSurfnyY
   rq3ZaRK2EeQbZrhUhYJWo0IQ6TWvypJ3xPgt+1blm1FqBRK8+brnWSd9F
   xi9DnrF520MbWekmtRcZ4IWujk1WcFB9DTyyrSumujVTkFF74BLzLEFVa
   i9viZRCY3OXYlfR92jrTnGQhrsXJq3B2yRBk6DisVl6riPq9P6NtKN+DO
   dm2RxLaJbF4M1F3dEesfcWwOLvrA9VHOciKt3PFL+bmwDSXLSjOOIFDO8
   XNN/yHzRGXflbcyPLQ7XFKHlh+LU4efxvT8KY94Qb6hspFcKL/RW9UN/g
   Q==;
X-CSE-ConnectionGUID: bsztFyT6TqObQWLKRya2Fg==
X-CSE-MsgGUID: eE1JH65gSpuDZXBsnC9HdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="98761071"
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="98761071"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 19:27:18 -0700
X-CSE-ConnectionGUID: bh8BLriISryoZmUmpOxQeQ==
X-CSE-MsgGUID: pETfxswFQYytmM6PaR59QA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="265390086"
Received: from fdefranc-mobl3.igk.intel.com ([172.28.182.157])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 19:27:10 -0700
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
Subject: [PATCH v2 05/13] cxl/core: Restore the HDM decoders below DPort
Date: Tue, 25 Aug 2026 04:26:20 +0200
Message-ID: <20260825022628.3651434-6-fabio.m.de.francesco@linux.intel.com>
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

A Secondary Bus Reset clears the HDM Decoder registers of every CXL
component below the Port, so the decoders have to be reprogrammed from the
settings the driver holds before anything reaches the region again.

Add cxl_sbr_recommit_decoders() to find the CXL port that owns the
Downstream Port and reprogram the decoders below it. It takes
cxl_rwsem.region for read across the walk: the walk reads the endpoint set
below the Port, each endpoint's parent chain and the switch decoder target
lists, all of which change only under that lock held for write.

The driver's cached settings do not cover the whole of either control
register, so the saved state that cxl_port_recommit_decoders() needs is
passed through as well, an xarray of struct cxl_hdm_state keyed by
struct cxl_port and read before the reset.

Put it in a new dport_sbr.c, which collects what a Secondary Bus Reset of a
CXL Downstream Port needs from the CXL core. find_cxl_port() loses its
static since the lookup now has a caller outside port.c.

It has no caller yet. It is used on the way out of the reset, once the
regions routed through the Port are back.

Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
---
 drivers/cxl/core/Makefile    |  2 +-
 drivers/cxl/core/core.h      |  6 ++++++
 drivers/cxl/core/dport_sbr.c | 36 ++++++++++++++++++++++++++++++++++++
 drivers/cxl/core/port.c      |  4 ++--
 tools/testing/cxl/Kbuild     |  2 +-
 5 files changed, 46 insertions(+), 4 deletions(-)
 create mode 100644 drivers/cxl/core/dport_sbr.c

diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
index ce7213818d3c..4d4538182d81 100644
--- a/drivers/cxl/core/Makefile
+++ b/drivers/cxl/core/Makefile
@@ -15,7 +15,7 @@ cxl_core-y += hdm.o
 cxl_core-y += pmu.o
 cxl_core-y += cdat.o
 cxl_core-$(CONFIG_TRACING) += trace.o
-cxl_core-$(CONFIG_CXL_REGION) += region.o region_pmem.o region_dax.o
+cxl_core-$(CONFIG_CXL_REGION) += region.o region_pmem.o region_dax.o dport_sbr.o
 cxl_core-$(CONFIG_CXL_MCE) += mce.o
 cxl_core-$(CONFIG_CXL_FEATURES) += features.o
 cxl_core-$(CONFIG_CXL_EDAC_MEM_FEATURES) += edac.o
diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index d23f0bbd7bf0..a8b9d7990d32 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -13,6 +13,9 @@ extern const struct device_type cxl_pmu_type;
 
 extern struct attribute_group cxl_base_attribute_group;
 
+struct cxl_port *find_cxl_port(struct device *dport_dev,
+			       struct cxl_dport **dport);
+
 enum cxl_detach_mode {
 	DETACH_ONLY,
 	DETACH_INVALIDATE,
@@ -53,6 +56,9 @@ u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
 int devm_cxl_add_dax_region(struct cxl_region *cxlr);
 int devm_cxl_add_pmem_region(struct cxl_region *cxlr);
 void kill_regions(struct cxl_root_decoder *cxlrd);
+struct pci_dev;
+void cxl_sbr_recommit_decoders(struct pci_dev *dport_pci,
+			       struct xarray *hdm_state);
 
 #else
 static inline u64 cxl_dpa_to_hpa(struct cxl_region *cxlr,
diff --git a/drivers/cxl/core/dport_sbr.c b/drivers/cxl/core/dport_sbr.c
new file mode 100644
index 000000000000..55c35386d0cb
--- /dev/null
+++ b/drivers/cxl/core/dport_sbr.c
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2026 Intel Corporation. */
+
+#include <linux/device.h>
+#include <linux/pci.h>
+#include <cxl.h>
+#include "core.h"
+
+/*
+ * The reset cleared the HDM Decoder registers of every CXL component below
+ * @dport_pci, so restore them from the settings the driver holds and from
+ * @hdm_state, the register fields the driver does not model, saved before the
+ * reset. Takes cxl_rwsem.region for read, which cxl_port_recommit_decoders()
+ * requires. The caller has already disabled the regions, so nothing reaches the
+ * decoders being reprogrammed.
+ */
+void cxl_sbr_recommit_decoders(struct pci_dev *dport_pci,
+			       struct xarray *hdm_state)
+{
+	struct cxl_dport *dport;
+	int rc;
+
+	struct cxl_port *port __free(put_cxl_port) =
+		find_cxl_port(&dport_pci->dev, &dport);
+	if (!port) {
+		pci_dbg(dport_pci, "no CXL port owns this Downstream Port\n");
+		return;
+	}
+
+	pci_dbg(dport_pci, "restoring HDM decode below %s\n", dev_name(&port->dev));
+
+	guard(rwsem_read)(&cxl_rwsem.region);
+	rc = cxl_port_recommit_decoders(port, hdm_state);
+	if (rc)
+		pci_warn(dport_pci, "HDM decode restore failed: %d\n", rc);
+}
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 1215ee4f4035..66a6d513843e 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1392,8 +1392,8 @@ static struct cxl_port *__find_cxl_port(struct cxl_find_port_ctx *ctx)
 	return NULL;
 }
 
-static struct cxl_port *find_cxl_port(struct device *dport_dev,
-				      struct cxl_dport **dport)
+struct cxl_port *find_cxl_port(struct device *dport_dev,
+			       struct cxl_dport **dport)
 {
 	struct cxl_find_port_ctx ctx = {
 		.dport_dev = dport_dev,
diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
index 2be1df80fcc9..f18d41b299fe 100644
--- a/tools/testing/cxl/Kbuild
+++ b/tools/testing/cxl/Kbuild
@@ -63,7 +63,7 @@ cxl_core-y += $(CXL_CORE_SRC)/hdm.o
 cxl_core-y += $(CXL_CORE_SRC)/pmu.o
 cxl_core-y += $(CXL_CORE_SRC)/cdat.o
 cxl_core-$(CONFIG_TRACING) += $(CXL_CORE_SRC)/trace.o
-cxl_core-$(CONFIG_CXL_REGION) += $(CXL_CORE_SRC)/region.o $(CXL_CORE_SRC)/region_pmem.o $(CXL_CORE_SRC)/region_dax.o
+cxl_core-$(CONFIG_CXL_REGION) += $(CXL_CORE_SRC)/region.o $(CXL_CORE_SRC)/region_pmem.o $(CXL_CORE_SRC)/region_dax.o $(CXL_CORE_SRC)/dport_sbr.o
 cxl_core-$(CONFIG_CXL_MCE) += $(CXL_CORE_SRC)/mce.o
 cxl_core-$(CONFIG_CXL_FEATURES) += $(CXL_CORE_SRC)/features.o
 cxl_core-$(CONFIG_CXL_EDAC_MEM_FEATURES) += $(CXL_CORE_SRC)/edac.o
-- 
2.55.0


