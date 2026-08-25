Return-Path: <linuxppc-dev+bounces-26070-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26CF3C61CE2
	for <linuxppc-dev@archiver.kernel.org>; Tue, 25 Aug 2026 02:26:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hTWrF31Q2z2y83;
	Tue, 25 Aug 2026 12:26:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787624813;
	cv=none; b=LrdUojmFmaA7xyQdIFnwCHGhDZU5I9moH3ZDDMHvjcwJL3t2I+FWsghsaN1rtDDWZhK9fxQ43qmkpxqKGWFqLwyp42oGC4ohKXGtNEi7gAp66wSwj+d69aJvDIxwT6nCwbDtMZ87HSZEMd1AgElu5GVGdklIiBHJKM/niGUer2psiNLfe/BgE7IaeE3UqqNtNXMaEj03ZwUo1GCsHYaIKnc4KqYBiYd1MqTPpQBsJF9BoH6dSW0US9VL0Pa9Zddt4NHxHAVQtXcKHnI4kDGdGfn1OnnZQgEuwhjVcqVRS2vpS4SCRaYdZgiyN2R7Rnb6NdIsTEC830c1LDlokiHcwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787624813; c=relaxed/relaxed;
	bh=fJzASNNSG+QiH++4gzj7pnCDSF9TUeGXmyxhBzuXNVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H2Fy/d4CohLtLHO1fecsj19RHpgWJYqbM6gw+2JmUQuA2s+mAerjQwBy5RaLRQWW3v7N0RFz2CM8bRAFaImRPdAzCS4ei3vDHeBcAfduF5nd3v0P+c7PpsklLU0S8m1aHZFRFTGS0x64q4Bu8UNHUEjzlfDJYnmvMD3ND4nUsVWSnctvhWqH/xR1StBEhPnFc23x6pb0bTj7xymHiLZTy5S75f6ncYgnc9p10zn+CIrU8mSJZ0jl8nGsRpHgFyZPc9Jd+gmO531DcKgC9vUSq02715S6uLTZDQdHb9O7ogxkhYgu2vqP4EXeOOZsPG3PLEU6FLYjkiHgD6+yCffWhA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ADOerkmz; dkim-atps=neutral; spf=pass (client-ip=192.198.163.9; helo=mgamail.intel.com; envelope-from=fabio.m.de.francesco@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ADOerkmz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=192.198.163.9; helo=mgamail.intel.com; envelope-from=fabio.m.de.francesco@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hTWrD0hrnz2y2K
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Aug 2026 12:26:51 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787624812; x=1819160812;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tsn1ZiUbzdaF4vYy7trPOo26c92bIqiH3qklxnc8dFw=;
  b=ADOerkmzcqvab0vVpEOBmZ1fsmHDBf3Ya920RvztZGjwErORFa8Fn1pv
   GfnSUOf2nMSyafN71z6hsm2a8Zu/gPfa/g8xyDmCP8Y6hsbFvHWFNLM1C
   fnBipoZOucCczg9dsEfr1AAip+fnzmjQUKJ41OOfQJu6S5qB41ha6BR9B
   IQmXbSllORjhCrvr92RujGd/dJgAxyGhFDFmQoSF5Q+NZBuLVXL+ga2gH
   UatdZBI5FB3M3tWnb3GJk7Oog+vnYF2cCk+O+37Xn6D9XfUk/DwMANTMg
   kqB/ZqbDCjbD9v+0+tiUj9uaFtPL52aETejKp2YE77i/GsTPeAHfxrx0X
   A==;
X-CSE-ConnectionGUID: noWIB3ZwQwSqypMJTPP3Vg==
X-CSE-MsgGUID: QxWEX/CyRxKDz2EnYo6E/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="98760950"
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="98760950"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 19:26:48 -0700
X-CSE-ConnectionGUID: lF9tHVnlTmmDi5NsgwZhEQ==
X-CSE-MsgGUID: NWBh33+kSD+0V6l964YYkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="265390038"
Received: from fdefranc-mobl3.igk.intel.com ([172.28.182.157])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 19:26:42 -0700
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
Subject: [PATCH v2 01/13] cxl/pci: Make the HDM and Mem_Enable writes callable from CXL
Date: Tue, 25 Aug 2026 04:26:16 +0200
Message-ID: <20260825022628.3651434-2-fabio.m.de.francesco@linux.intel.com>
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

Split the Global Control write out of devm_cxl_enable_hdm() as
cxl_enable_hdm() and drop the static from cxl_set_mem_enable(), so both
are reachable from the rest of cxl_core. Declare them in core.h.

Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
---
 drivers/cxl/core/core.h |  2 ++
 drivers/cxl/core/pci.c  | 19 ++++++++++++++-----
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 07555ae63859..4dc324f019ab 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -213,6 +213,8 @@ int cxl_gpf_port_setup(struct cxl_dport *dport);
 struct cxl_hdm;
 int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
 			struct cxl_endpoint_dvsec_info *info);
+void cxl_enable_hdm(struct cxl_hdm *cxlhdm, u32 global_ctrl);
+int cxl_set_mem_enable(struct cxl_dev_state *cxlds, u16 val);
 int cxl_port_get_possible_dports(struct cxl_port *port);
 
 #ifdef CONFIG_CXL_FEATURES
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index e4338fd7e01b..a7a2b84293e9 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -179,7 +179,7 @@ int cxl_await_media_ready(struct cxl_dev_state *cxlds)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_await_media_ready, "CXL");
 
-static int cxl_set_mem_enable(struct cxl_dev_state *cxlds, u16 val)
+int cxl_set_mem_enable(struct cxl_dev_state *cxlds, u16 val)
 {
 	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
 	int d = cxlds->cxl_dvsec;
@@ -247,14 +247,23 @@ static void disable_hdm(void *_cxlhdm)
 	       hdm + CXL_HDM_DECODER_CTRL_OFFSET);
 }
 
-static int devm_cxl_enable_hdm(struct device *host, struct cxl_hdm *cxlhdm)
+/*
+ * @global_ctrl is the CXL HDM Decoder Global Control value to enable decode in.
+ * A caller restoring decode after a reset passes the value it saved, so the
+ * fields the driver does not model are not left at their reset defaults.
+ */
+void cxl_enable_hdm(struct cxl_hdm *cxlhdm, u32 global_ctrl)
 {
 	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
-	u32 global_ctrl;
 
-	global_ctrl = readl(hdm + CXL_HDM_DECODER_CTRL_OFFSET);
 	writel(global_ctrl | CXL_HDM_DECODER_ENABLE,
 	       hdm + CXL_HDM_DECODER_CTRL_OFFSET);
+}
+
+static int devm_cxl_enable_hdm(struct device *host, struct cxl_hdm *cxlhdm,
+			       u32 global_ctrl)
+{
+	cxl_enable_hdm(cxlhdm, global_ctrl);
 
 	return devm_add_action_or_reset(host, disable_hdm, cxlhdm);
 }
@@ -398,7 +407,7 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
 	 * enable and use the HDM Decoder Capability registers.
 	 */
 	if (!info->mem_enabled) {
-		rc = devm_cxl_enable_hdm(&port->dev, cxlhdm);
+		rc = devm_cxl_enable_hdm(&port->dev, cxlhdm, global_ctrl);
 		if (rc)
 			return rc;
 
-- 
2.55.0


