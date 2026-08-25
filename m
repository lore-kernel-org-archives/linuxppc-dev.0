Return-Path: <linuxppc-dev+bounces-26082-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89812C5DF81
	for <linuxppc-dev@archiver.kernel.org>; Tue, 25 Aug 2026 02:28:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hTWsx1f2Qz2yrX;
	Tue, 25 Aug 2026 12:28:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787624901;
	cv=none; b=DFvloyxWylMEEt+Qw+rIEaBqu+kHyq3z4wujaheoKm9Euz5YRSNHvY3DYm6AbfQOmIlpNRaau/GbEEYUuh2BF0SzJbznvPNOqtedvPWmrO2l42xpgtyUbCTAX4NidWTfL8zqojp9/N6aXpKHJWW0qxlw9cYDEhd/AAs9httZ1EGfsjmmikOAs4f/Of00ACUv4vZC+E2k5OzmIEBFHQxvEulWb3qJgAeWj6gx6GkhEBnnkqa2a+SBNlO7hRaF9ebwSkc7g0p8H+QJjn2JAGbRLq7Ta2fgaxrbPnEVPC7q/eBYrKM630g4YFEjk70QTn0LT+W7AX+TMEFDH+Tidl41ow==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787624901; c=relaxed/relaxed;
	bh=eFoGkw61yrTpvSi9Hrtm/h8z3f6hMLs6W1Ix5GODQJU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cbxucRWHy44j92BhlEbYUvqC1okszSMPZV+EFrZqlDLVA9XvAut/I2N4vOWPGt8Ls+eawXMtfB0psdDZqDCrdcr8AEc7bGKDx4c9N/EF3b9+oWtYXco4N2tz8jSD9T+zqzKbqZ7XdE3T7dRV+2XeL6gldg4I1QmebAi1NX3GHs4cEkqt5Uf9cPMz6WC/ee2Gf5n1aYokLGWmIGBRTLS7VwV15M3EgFMU4btwV2gTrizu2WCDG2t0qNIKR513cARNmy8oRrXuZ9ys4ECQAke59wEoOnAyyXbnmfyOtMLzTMR+TtdBQV5wC/PicvA03ERSveHT9vU0k1PxZPNBbHfWKA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KwI1y8Mx; dkim-atps=neutral; spf=pass (client-ip=192.198.163.9; helo=mgamail.intel.com; envelope-from=fabio.m.de.francesco@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KwI1y8Mx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=192.198.163.9; helo=mgamail.intel.com; envelope-from=fabio.m.de.francesco@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hTWsv6XLKz2yqs
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Aug 2026 12:28:19 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787624900; x=1819160900;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=p35ooKxDDEqYJs00+ywe+gwGYag0qhbr8UgYGTT8yA4=;
  b=KwI1y8Mx+ANjS51grDfDtJkWxofDU1Ifu4l8EaJtJwrJpDKu9ESxogJC
   3IO1qrUZm26v5cLsKuxx0FH2s7QaSIlWzYJLxSHMbmk+P9aY70el/y8K+
   z5/ULUcfys7m9NlEzTs898FSjdl3LYLZVvWd6RLOcUjwnC8Bl9clEmxTC
   A2qK/qymOwacNxj77Nz3PgZVTiTQjMMiRZChJplwfNO+FsfgFLvsD3zk4
   jS1FOZ/uy/i02XfTEq4w0WbztmHish+qOgX4Z5t/g39nHRBn13Cj5JWDb
   ZHzg9gho9v/wBtiFhA915yJZa9+cc+8v2W8OxELqMQ5bxD+oW/Hn3CR7A
   g==;
X-CSE-ConnectionGUID: RuBtR3a/ShSP9Zs9hhbrDA==
X-CSE-MsgGUID: 1yboiB0xROu/5+NWxHdHeQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="98761243"
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="98761243"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 19:28:16 -0700
X-CSE-ConnectionGUID: KQlGpQmQRWef0MiKW/Zq2g==
X-CSE-MsgGUID: n6NeHPHmT6KWhioKt0tOhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="265390156"
Received: from fdefranc-mobl3.igk.intel.com ([172.28.182.157])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 19:28:09 -0700
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
Subject: [PATCH v2 13/13] PCI/CXL: Refuse an SBR of a CXL DPort unless authorized
Date: Tue, 25 Aug 2026 04:26:28 +0200
Message-ID: <20260825022628.3651434-14-fabio.m.de.francesco@linux.intel.com>
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

CXL r4.0 sec 8.1.5.2 Table 8-32 describes a bit that makes the SBR bit
in Bridge Control take effect at all, so a Port left at the firmware
default is one the reset must not silently unmask.

Add cxl_sbr_allowed() to answer if SBR is allowed: check if a Port whose
Unmask SBR is already set needs no consent, as it happens with cxl_bus
reset.

Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
---
 drivers/pci/pci.c | 26 ++++++++++++++++++++++++++
 drivers/pci/pci.h |  1 +
 2 files changed, 27 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index eedd516f8484..08873ea3957b 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4881,6 +4881,11 @@ static int cxl_sbr_prepare(struct pci_dev *bridge, u16 dvsec,
 {
 	int rc;
 
+	if (action == CXL_SBR_OFFLINE_AND_UNBIND && !cxl_sbr_allowed(bridge)) {
+		pci_info(bridge, "SBR masked, write 1 to cxl_unmask_sbr to allow a bus reset\n");
+		return -ENOTTY;
+	}
+
 	/*
 	 * CXL_SBR_UNBIND: the link is already down, so offlining the regions'
 	 * memory would take the reads that page migration performs as a machine
@@ -5138,6 +5143,27 @@ static bool cxl_sbr_masked(struct pci_dev *dev)
 	return true;
 }
 
+/*
+ * cxl_sbr_allowed - whether an SBR of a CXL Downstream Port may go ahead
+ * @dev: Downstream Port to test
+ *
+ * Per CXL r4.0 sec 8.1.5.2 Table 8-32 the SBR bit in a CXL Port's Bridge
+ * Control register has no effect while the Port's Unmask SBR bit is clear, and
+ * sec 9.12.3 says System Firmware may leave it clear "to prevent CXL-unaware
+ * PCIe software from resetting the device and the link". A Port that already
+ * has it set needs no further permission; otherwise unmasking it takes the
+ * administrator's consent, given by writing 1 to the Port's cxl_unmask_sbr.
+ *
+ * Return: true if the reset paths may unmask and generate an SBR of @dev.
+ */
+bool cxl_sbr_allowed(struct pci_dev *dev)
+{
+	if (!cxl_port_dvsec(dev))
+		return false;
+
+	return dev->cxl_unmask_sbr || !cxl_sbr_masked(dev);
+}
+
 static int pci_reset_bus_function(struct pci_dev *dev, bool probe)
 {
 	struct pci_dev *bridge = pci_upstream_bridge(dev);
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index b6d873b077ed..bea05acc58f0 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -248,6 +248,7 @@ int __pci_bridge_secondary_bus_reset(struct pci_dev *dev,
 				     enum cxl_sbr_region_action action);
 bool is_cxl_dport(struct pci_dev *dev);
 u16 cxl_port_dvsec(struct pci_dev *dev);
+bool cxl_sbr_allowed(struct pci_dev *dev);
 int pci_bus_error_reset(struct pci_dev *dev);
 int pci_try_reset_bridge(struct pci_dev *bridge);
 
-- 
2.55.0


