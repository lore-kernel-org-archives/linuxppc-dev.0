Return-Path: <linuxppc-dev+bounces-26072-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 677F8C5DF81
	for <linuxppc-dev@archiver.kernel.org>; Tue, 25 Aug 2026 02:27:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hTWrS6Bs6z2y2M;
	Tue, 25 Aug 2026 12:27:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787624824;
	cv=none; b=M7DNvYvG7PQbF50DFu7jySmZupiZmM4V3DNkMvgLRUOrZv7jUWeuuEZYY3TZSNWqv42ibUylT87tjTguzfllkcjZEMRrOCYiPp/t74Z5DDOfSnLfVjn083E19IVPKocs1ZpkwvXZGP+9ujPeLlYdcmyTklyeHOD0ImDbBPh2u+rAKKZ9wPDs/q0FCIDEiRARNcR1wdGkJ3fAhYERGfnoJwRkNowbiIUqRaUZT2M8mSEBPH4OO8BcHFwGJWgFIoF7o4RB6Mqj9GSvNWy8pRSWycaE2163vyOB6aSaeNq25vsnS07RvsMnbIVytPREdFh40sceC43eU/Xju4MeKsPpeg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787624824; c=relaxed/relaxed;
	bh=3MPEbFoU/QwRqNirYP/g92Fs3Z8hduqFFxsbmsOT820=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h/wbbts9Jxj1Hn6+Xo04QqXfgwn8io9QneQYJ8XaUw17/BYXYtUZnZo3Ydw0Ob07EUNuyxU/TVqR13kplocanuDeMS6SPRZenDfAj6JipKrzLc/5Ap2ADrln7yTplBkmcpP5MOkg9jd/2T9E09oQA+SlAjq/hUHqeVJ+C6NIsY40givl/anvaRfMwQvaBEa8dfRXz5Vl/xndU1J5N/AuerpVIgOqV39kYBiVbnFU0kIdRV2sJgc5olgT8w0cqXhnFZ7p/cM3GsnyWdf/ca2G48iAju/0ELzUDiFizjGQskHdJMpvheiRzzXZe2J7YdAHOjfI3lNFHNIV2tZOOFJzcQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CE4M8f5o; dkim-atps=neutral; spf=pass (client-ip=192.198.163.9; helo=mgamail.intel.com; envelope-from=fabio.m.de.francesco@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CE4M8f5o;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=192.198.163.9; helo=mgamail.intel.com; envelope-from=fabio.m.de.francesco@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hTWrR35Hdz2y2K
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Aug 2026 12:27:02 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787624824; x=1819160824;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xeqgpOGSccYdKjps30e3iCkBlKdPX8jK81YqHCCS7uM=;
  b=CE4M8f5orTfKK6k6P/3/N4KqHcBHB5sHIoj3idBwiD0ruyzNzG8ngCAS
   ZyIk7R6tYzlAPU3boBohbDKJYeu/3kOerEV05dC7NC6C1Fc4E3blVJjyv
   FrytoZrLdGkbRFaCFshSRpFCasJhaSxmawpcwJOKJSX+F769j0Yl36sjf
   bEHA68gYKmybYO+tdS8pLhq3W6IgHA0AaA1YiACBTRrrQ+l4fGnWKDnnc
   R+PF/zzfpdpqBlQlCs/BIfJRNjHJfCc+2qsFNVQYtI6J+rl4RbrYVM1kN
   mHrovu3h/AgRRUC0GaGQXwv+SsRDC4VmnRTslGJZzBSKaPkEi0JvUhHS0
   g==;
X-CSE-ConnectionGUID: f6bzcfx4SVmKN7AKsAtCHw==
X-CSE-MsgGUID: FnnVb7GRQia67fRmH2wHrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="98761005"
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="98761005"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 19:27:02 -0700
X-CSE-ConnectionGUID: KdGJNJfHR96baGgvXtQVSw==
X-CSE-MsgGUID: 11OofZUFRiO+d4zK+Qn7bg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="265390063"
Received: from fdefranc-mobl3.igk.intel.com ([172.28.182.157])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 19:26:56 -0700
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
Subject: [PATCH v2 03/13] cxl/hdm: Add function to restore CXL.mem decode
Date: Tue, 25 Aug 2026 04:26:18 +0200
Message-ID: <20260825022628.3651434-4-fabio.m.de.francesco@linux.intel.com>
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

A reset of a CXL Downstream Port clears HDM Decoder Enable in the CXL HDM
Decoder Global Control register of every endpoint below it, and Mem_Enable
in their DVSEC CXL Control register. Per CXL r4.0 sec 8.2.4.20.2
Table 8-118 a device decodes CXL.mem through the DVSEC range registers
while HDM Decoder Enable is clear, so a decoder committed in that state
does not establish the route, and per sec 8.1.3.2 Table 8-6 a component
with Mem_Enable clear may silently drop all CXL.mem transactions.

Add cxl_endpoint_enable_hdm_decode() to put an endpoint back in HDM decode
before its decoders are committed again. It takes the Global Control value
to enable decode in, since that register also holds Poison On Decode Error
Enable, which the driver does not model and which a read taken after the
reset returns at its default.

Leave alone an endpoint that decodes through the DVSEC ranges rather than
the HDM decoders, either because it has no HDM decoder registers or
because its decoders are emulated from those ranges. Setting HDM Decoder
Enable on such a device moves it off the ranges it is decoding through and
onto decoders that are locked against reprogramming, so it would decode
nothing.

Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
---
 drivers/cxl/core/core.h |  1 +
 drivers/cxl/core/hdm.c  | 52 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 6d536fe7b446..918d48f4422e 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -216,6 +216,7 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
 void cxl_enable_hdm(struct cxl_hdm *cxlhdm, u32 global_ctrl);
 int cxl_set_mem_enable(struct cxl_dev_state *cxlds, u16 val);
 int cxl_decoder_recommit(struct cxl_decoder *cxld, u32 ctrl);
+int cxl_endpoint_enable_hdm_decode(struct cxl_memdev *cxlmd, u32 global_ctrl);
 int cxl_port_get_possible_dports(struct cxl_port *port);
 
 #ifdef CONFIG_CXL_FEATURES
diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index d55d764895f8..7c898c60f60f 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -920,6 +920,58 @@ int cxl_decoder_recommit(struct cxl_decoder *cxld, u32 ctrl)
 	return 0;
 }
 
+static int __cxl_endpoint_decoder_is_emulated(struct device *dev, void *data)
+{
+	if (!is_endpoint_decoder(dev))
+		return 0;
+
+	return !to_cxl_decoder(dev)->commit;
+}
+
+/* Only the DVSEC setup path leaves ->commit NULL. */
+static bool cxl_endpoint_decoders_are_emulated(struct cxl_port *endpoint)
+{
+	return device_for_each_child(&endpoint->dev, NULL,
+				     __cxl_endpoint_decoder_is_emulated);
+}
+
+/*
+ * Restore CXL.mem decode on @cxlmd before any of its decoders is committed. A
+ * reset clears the endpoint's HDM Decoder Global Control and the DVSEC CXL
+ * Control, and per CXL r4.0 sec 8.2.4.20.2 Table 8-118 a device decodes CXL.mem
+ * with the DVSEC range registers while HDM Decoder Enable is clear. Committing
+ * a decoder in that state does not establish the route. An endpoint with no HDM
+ * decoder registers is driven through the DVSEC ranges and has nothing to
+ * enable. So is an endpoint whose decoders are emulated from those ranges, and
+ * setting HDM Decoder Enable there would switch it to decoders locked against
+ * reprogramming.
+ *
+ * @global_ctrl is the Global Control value to enable decode in. That register
+ * also holds Poison On Decode Error Enable, which the driver does not model, so
+ * the caller supplies the value it saved rather than one read back after the
+ * reset.
+ */
+int cxl_endpoint_enable_hdm_decode(struct cxl_memdev *cxlmd, u32 global_ctrl)
+{
+	struct cxl_port *endpoint = cxlmd->endpoint;
+	struct cxl_hdm *cxlhdm = dev_get_drvdata(&endpoint->dev);
+	int rc;
+
+	if (!cxlhdm || !cxlhdm->regs.hdm_decoder)
+		return 0;
+
+	if (cxl_endpoint_decoders_are_emulated(endpoint))
+		return 0;
+
+	cxl_enable_hdm(cxlhdm, global_ctrl);
+
+	rc = cxl_set_mem_enable(cxlmd->cxlds, PCI_DVSEC_CXL_MEM_ENABLE);
+	if (rc < 0)
+		return rc;
+
+	return 0;
+}
+
 static int commit_reap(struct device *dev, void *data)
 {
 	struct cxl_port *port = to_cxl_port(dev->parent);
-- 
2.55.0


