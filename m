Return-Path: <linuxppc-dev+bounces-26077-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34773C5DF9C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 25 Aug 2026 02:27:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hTWs95YSMz2ynZ;
	Tue, 25 Aug 2026 12:27:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787624861;
	cv=none; b=HwrAnYo2NgKigbWzG/uGxyQMXRQn3XRqF8losm++FtEY54AD+UtxkFz1099b3xYgW5K2jHtD/JOyQg2DqMSDw78luN0y96JB9T6zCv0d9EE9/AEJyEhSYeDS7pi2CyIhv9ZPYZqQXGAuVWgcZKBIs0bLMpJzWlwAQ0gH1e2jKoToREuOp5M+xeAGqWx7CRRuCMqSWncBBoz85RZtItoOE98p03lJWY2fAw5X99n2z5HuvwhPZkr9WvLODyg17ldN4IQUiwLprdS8++oEt7rohyxAG2zQWd2OufwmhpZVstdrcklDtYKxbePy9TZCG2FaDO/8PSVur3uzZ0TwdNac4g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787624861; c=relaxed/relaxed;
	bh=kGejBX/jF835Z7IuXuPdOkPiAbyPz3KcX/iP21XURIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fr5wkmUN5KGsiVT5QsfTZKs2hafATTwigvviDkFKdg6ysz3Qcr08/+QgXXUZE2vvM9gTS7lZexWhdk7IeriaYk2Jk27hCUtVxTh6IO4lXYHfTApdu94Gj/hXkJ7zxIBt/KQebYjF+znVcSpPwoLiJZhj5P483yjUXzxju3jdzaZdVLXjPuAcu4+q2P0DXXjGh/CrhvrUgUHtyKipBpmJpEQ6fuA8hkfLlt5QX4kDjo7878DyB2+WfPT/RuAp1vqQ2hLE5FjqXOihaXFjSlcUd6VSEHRnl+fXig/8y5LgjhzCjEWi4MUs8wHXXEdfAjGytXZCBoImTXS0PzuaBQ5YeA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FDVAK7Wq; dkim-atps=neutral; spf=pass (client-ip=192.198.163.9; helo=mgamail.intel.com; envelope-from=fabio.m.de.francesco@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FDVAK7Wq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=192.198.163.9; helo=mgamail.intel.com; envelope-from=fabio.m.de.francesco@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hTWs83Lncz2yqs
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Aug 2026 12:27:40 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787624861; x=1819160861;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Q3mRxBLSI2WW9TzR6U+x8ypVb6e1keaDDN/taWRABaw=;
  b=FDVAK7WqFu436oBZPqAxP949gVUBRKJW/fwZduWZheUWIT02Gzd6Ax7+
   WhohXchzXQbzYdsrkJ3Oef2FwZATpwuKRvyNWRlIZdIv1FpKrJ7E1sX5d
   YjI0jxHXyT2WIcqkrF4fjsCsO5kS2GbUWHL6ri8TRz4yyolqoQPLATElb
   mU0roCKrMcN1DHuTWItyFmS6SNcSXqnp3mco2imT+OCjs9/wckU2FCgrn
   xcBOKEFM8tw2nKkLBP/kUprHKJtYzwJvKbiNLLsbrZoK1CkIeq+hJ/Ns4
   BvthHUxQLyAdXOh1Is77bHWjJZy/hRVPv2Qz+yoiuyRGFvWPKZvAqy/ng
   g==;
X-CSE-ConnectionGUID: vHvsnkx0RKCoPQn0YxQfgw==
X-CSE-MsgGUID: IBmS8QYESbWS3vpj9zAo5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="98761138"
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="98761138"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 19:27:39 -0700
X-CSE-ConnectionGUID: XnmQbxFWQXSTf4T6etYNMw==
X-CSE-MsgGUID: 3BIjarGVQuW5Vhplv4Uj1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="265390104"
Received: from fdefranc-mobl3.igk.intel.com ([172.28.182.157])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 19:27:32 -0700
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
Subject: [PATCH v2 08/13] cxl/core: Collect the regions routed through a DPort
Date: Tue, 25 Aug 2026 04:26:23 +0200
Message-ID: <20260825022628.3651434-9-fabio.m.de.francesco@linux.intel.com>
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

Disabling the CXL regions ahead of a Secondary Bus Reset needs the set of
regions with a member endpoint below the Port being reset.

Add cxl_sbr_collect_regions() to walk the CXL port that owns the Downstream
Port and return every region with an endpoint below it, and
cxl_sbr_put_regions() to release the set.

Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
---
 drivers/cxl/core/core.h      |  2 ++
 drivers/cxl/core/dport_sbr.c | 66 ++++++++++++++++++++++++++++++++++++
 2 files changed, 68 insertions(+)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index ac55f9e8160e..077a2af9cf0c 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -60,6 +60,8 @@ int cxl_region_invalidate_memregion(struct cxl_region *cxlr);
 int cxl_region_disable(struct cxl_region *cxlr);
 void cxl_region_enable(struct cxl_region *cxlr);
 struct pci_dev;
+int cxl_sbr_collect_regions(struct pci_dev *dport_pci, struct xarray *regions);
+void cxl_sbr_put_regions(struct xarray *regions);
 void cxl_sbr_recommit_decoders(struct pci_dev *dport_pci,
 			       struct xarray *hdm_state);
 
diff --git a/drivers/cxl/core/dport_sbr.c b/drivers/cxl/core/dport_sbr.c
index 0f398ab0d3a4..233499bc1fad 100644
--- a/drivers/cxl/core/dport_sbr.c
+++ b/drivers/cxl/core/dport_sbr.c
@@ -85,6 +85,72 @@ void cxl_region_enable(struct cxl_region *cxlr)
 		__func__, p->res, p->interleave_ways, p->interleave_granularity);
 }
 
+/*
+ * Collect the regions with a member endpoint routed through @dport_pci, the
+ * CXL Downstream Port about to be reset. cxl_rwsem.region keeps the topology
+ * stable for the duration of the walk only. Each collected region is pinned
+ * with get_device() so the object survives after the lock is dropped, since
+ * cxl_region_disable()/cxl_region_enable() run with the rwsem released (they
+ * unbind and rebind the region driver). Hence snapshot the set first.
+ */
+int cxl_sbr_collect_regions(struct pci_dev *dport_pci,
+			    struct xarray *regions)
+{
+	struct cxl_region_ref *cxl_rr;
+	struct cxl_dport *dport;
+	unsigned long index;
+	int count = 0;
+	int rc;
+
+	struct cxl_port *port __free(put_cxl_port) =
+		find_cxl_port(&dport_pci->dev, &dport);
+	if (!port) {
+		pci_dbg(dport_pci, "no CXL port found for reset dport\n");
+		return 0;
+	}
+
+	guard(rwsem_read)(&cxl_rwsem.region);
+	xa_for_each(&port->regions, index, cxl_rr) {
+		struct cxl_region *cxlr = cxl_rr->region;
+		struct cxl_ep *ep;
+		unsigned long ep_index;
+
+		/* Skip unless a region endpoint sits below the reset dport. */
+		xa_for_each(&cxl_rr->endpoints, ep_index, ep)
+			if (ep->dport == dport)
+				break;
+		if (!ep) {
+			dev_dbg(&cxlr->dev, "%s: no endpoint below %s, region excluded\n",
+				__func__, dev_name(dport->dport_dev));
+			continue;
+		}
+
+		get_device(&cxlr->dev);
+		rc = xa_insert(regions, (unsigned long)cxlr, cxlr, GFP_KERNEL);
+		if (rc) {
+			put_device(&cxlr->dev);
+			return rc;
+		}
+		dev_dbg(&cxlr->dev, "%s: endpoint below %s, region collected\n",
+			__func__, dev_name(dport->dport_dev));
+		count++;
+	}
+
+	dev_dbg(&port->dev, "%d region(s) routed through %s\n", count,
+		dev_name(dport->dport_dev));
+	return 0;
+}
+
+void cxl_sbr_put_regions(struct xarray *regions)
+{
+	struct cxl_region *cxlr;
+	unsigned long index;
+
+	xa_for_each(regions, index, cxlr)
+		put_device(&cxlr->dev);
+	xa_destroy(regions);
+}
+
 /*
  * The reset cleared the HDM Decoder registers of every CXL component below
  * @dport_pci, so restore them from the settings the driver holds and from
-- 
2.55.0


