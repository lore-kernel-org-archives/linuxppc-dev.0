Return-Path: <linuxppc-dev+bounces-20280-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6490FFF8867
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Apr 2026 12:27:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g5GlV6r8qz2yrm;
	Wed, 29 Apr 2026 22:27:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.20
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777465638;
	cv=none; b=g4JHSgOIOeDr+bREhNS1FgqF3qzs4IdxANckhNTOITi6MN6NrxIxdZPCANj1gyYSedliLseWoGVN6GTkY4nBl9ZsEN+eooNOgIG1wg6QqeNBEkI8a6XvTbCvQmpmuEPP2ZjgpG8pL9k9q1C1IyerJt7KHhx7+LgkZZ42QN+dqrDBUvDEp+Q5c63Kff/QobwrXJmpM8WLaytnCqvFIenezfNHvPnz/t3UNvj+uPDxL+Dwc5+VV7h2jOeLEFAl6xltjIAyCQRVm3zMazFDKb2hz2ossN9Awoto/GCk1TuH7TO4PS5EbZRD9f9/QNim9B80nCFqGhR0kvHZbEufRcw8qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777465638; c=relaxed/relaxed;
	bh=5cL1g2pORqz3nJeZdztVKSdCakx1Wb++LgESqlnSbxk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mopYTvKGhzZ22Z1x0sjZx+l4E4R0Z/ozp8ohaXiq+ISt1r+aa+iLP9hFt7Z3h++Vou4mhTJq4+aRJchUyGsEJ3RQBwt/Fyms6SOGS1L2Zc3vJ8bQlY27Gq3wdX7kqOtRUgyom11LYtjZ7ibSRqEMPOeffwMDAWU2jgp0l7ougeGVUq73WOhsve6ZOuu8ytbrMvvgMCnKzIiWWXOmZpbAY7KYk3x2xIlaT0JZ7T0O9chKIwecbV+l6+TLM9mKvQIaygAfNMKEADb8UZhNm4mJsTuLRLs8uKfr0k2yo67+zawS3ZxyS+CAjQMH6/sngbng178tSTn8vQqGtmHdYUdvcw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=drLBnNYY; dkim-atps=neutral; spf=pass (client-ip=198.175.65.20; helo=mgamail.intel.com; envelope-from=ilpo.jarvinen@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=drLBnNYY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=198.175.65.20; helo=mgamail.intel.com; envelope-from=ilpo.jarvinen@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g5GlT1Bktz2ySf
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Apr 2026 22:27:16 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777465638; x=1809001638;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iICkACAhlqRNjUyJ4saFH4NtsQfflsE2R1I8yMUAK3s=;
  b=drLBnNYY1yxYhC60rkb2QzzpkTRwuuMqmoo591JTOHM+asq6JQr35ZVM
   DoiJ56tdCW4dC5SDR3TPpISk7LqYhWeEN9Kb5P5P+tNgud17kQ/1vlrep
   fJof6xCqecu4TgvHfYTlsSC7NZ/zu1IoWhHc/dmsipAWeDnvvFLIwSAF8
   80D/jTqEv2jHUsJdiuTuRQo8muGGpRHLPqHIY6CbsSHuC9KD/rmk+upD3
   hlfS+514vmpSGNLFCuDUxdQM3sWP8Qj0Ek6YnNpV3IEabj+Ru8iHaD0EF
   md42B9tAQHPe2jt2fW4blS2D4W3n6aQD7G6Pqg15DSGduzFTAIDkjLJ4m
   g==;
X-CSE-ConnectionGUID: oq8VtVOaQVeMWN0YJCCmkw==
X-CSE-MsgGUID: O3CRwkR6SF2km056URAehg==
X-IronPort-AV: E=McAfee;i="6800,10657,11770"; a="78101789"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="78101789"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 05:27:13 -0700
X-CSE-ConnectionGUID: 5Wxn3kxaSMiU9A0qp47Zcg==
X-CSE-MsgGUID: SE6lrUwIRuKuzbGOxcD7Qg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="234512137"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.212])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 05:27:09 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Jin <shawn.jin@asteralabs.com>,
	linuxppc-dev@lists.ozlabs.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 04/11] PCI: Remove const removal cast
Date: Wed, 29 Apr 2026 15:26:10 +0300
Message-Id: <20260429122617.7324-5-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260429122617.7324-1-ilpo.jarvinen@linux.intel.com>
References: <20260429122617.7324-1-ilpo.jarvinen@linux.intel.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

__pci_bridge_assign_resources() inputs const pci_dev *bridge, but then
immediately casts const away to pass the bridge to
pdev_assign_resources_sorted().

As pdev_assign_resources_sorted() performs assignment of resources, it
is not possible to make its input parameter to const. Neither of the
__pci_bridge_assign_resources() callers requires the bridge parameter
to be const.

Thus, simply remove the out of place cast and convert the input
parameter to non-const.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/setup-bus.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 1e0e28efe8b8..c0a949f2c995 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1622,14 +1622,13 @@ void pci_bus_claim_resources(struct pci_bus *b)
 }
 EXPORT_SYMBOL(pci_bus_claim_resources);
 
-static void __pci_bridge_assign_resources(const struct pci_dev *bridge,
+static void __pci_bridge_assign_resources(struct pci_dev *bridge,
 					  struct list_head *add_list,
 					  struct list_head *fail_head)
 {
 	struct pci_bus *b;
 
-	pdev_assign_resources_sorted((struct pci_dev *)bridge,
-				     add_list, fail_head);
+	pdev_assign_resources_sorted(bridge, add_list, fail_head);
 
 	b = bridge->subordinate;
 	if (!b)
-- 
2.39.5


