Return-Path: <linuxppc-dev+bounces-18393-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBB0D10775E7
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Mar 2026 17:05:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fbZvP0wnYz2ykX;
	Thu, 19 Mar 2026 04:05:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773853505;
	cv=none; b=ozWTMRe/hxZ9xoaw8wwwV3kzrs4yusZBo/3UKk9AyWbiTsJTesv6HhNdW3fD2PC7zgSNKUao1QfeTQlkO3jV51OSfXUPFteUtgxmlWrntt7+3u8+4cIicW3AEfY0Pdv++PkTDnbFKLt6Z9a+RIWYo4dTVLUYqUakjPYNGDKRVemkNyTlBmDvBblwhhcgPTqz4+BGdr3wVJEyB0/e2A5XAFcVUYXrSWUwqE8pPV9zGWN2LUON/xj9oyFlBKZ5DJCpj2B0KbT3CGX1DA9uQGM0HFO99rgRVz0kXmtImbOrKEDy1MDzsEqpzPagInKEvzKU28hTzMhkdT0Rpk+vRPUzUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773853505; c=relaxed/relaxed;
	bh=TZhJMei2QF0gr5M8KDHzhyTXoGI6hqjqsiO9BJuwGrE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=npcq3U73Cb0U/fvcJV8nu3Z1Nb5/x8lOvNC97e3QA2cgI4Oqf3QfWkR39e07UMjh+zKVCEQQwUC5wboO3e+Pkb/DZL6u5I96TTXk5KoPnCRwDEbXte+/2Z+r+WB8NMFDxHdc7aOUU/5y+qYIR4WH9DCzfc0A4b+diC5W6OoqOgGS8C5AppkrvSDGhPUQ5H/5bgTvFoo2IztmXF7vYg8+nOnsQwiby8+H3zqYgmT6Kg0yyqIJixoUEUtoGQKf++rdDTM7TjeFgL1RCIwjIyiwPABc/injhCtyQAQMDkTYOJlua2+UQCJDUS6lhcJpipo9f9VQEpbvFV09MX3HXcNJKg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Htwv+jxG; dkim-atps=neutral; spf=pass (client-ip=198.175.65.14; helo=mgamail.intel.com; envelope-from=sathyanarayanan.kuppuswamy@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Htwv+jxG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=198.175.65.14; helo=mgamail.intel.com; envelope-from=sathyanarayanan.kuppuswamy@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fbZvK5W4xz2yjV
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Mar 2026 04:04:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773853503; x=1805389503;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JtkfgY2QPGPlp2YTL4Yb4oB5GPkIA4rMRtXgFu47Ayg=;
  b=Htwv+jxGZVj5NaU0eknV/fm4XwqPSPanQOk1NddkmkUZgRIolp/uJP5c
   RSMZaLFqOGaRmt3D7aHCegM0ZMiaOl1LKvLwBt/tIsWvn9tv5zV2g+bGp
   DI3japgecypddV7MSY8V/meUGO4D1CBIBKyAe/a2XyYR9VIpciUjxYsD/
   jQZcHUiFAFgPJLp2wNVTXapIgw2+tl3mMwMYO2JLIK4PWAT7hhiFLcHow
   eBcqPRULOvtq8HPCnDBldsE/0MQlNpDFHs6LiwCXikhY8v1KiEj7yotVr
   uEEFrPBeAnv48DSsdGrvLfRJeRZvsT4z4bO6pgQ9WhGHjqVAgaoQhUr5X
   g==;
X-CSE-ConnectionGUID: PhUiwHa1QgeKfYnimAuQQA==
X-CSE-MsgGUID: ZOuaRihJRw+p/jJymbSI5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="78774963"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="78774963"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 10:04:57 -0700
X-CSE-ConnectionGUID: F7LWEGyJR2GziehxoTJuZw==
X-CSE-MsgGUID: ux+rqs3zSjyAZj1JDjCzOw==
X-ExtLoop1: 1
Received: from skuppusw-desk2.jf.intel.com ([10.165.154.101])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 10:04:55 -0700
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>
Cc: Oliver OHalloran <oohall@gmail.com>,
	Jon Pan-Doh <pandoh@google.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v1] PCI/DPC: Fix AER error logging for DPC/EDR triggered events
Date: Wed, 18 Mar 2026 10:04:49 -0700
Message-ID: <20260318170449.2733581-1-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.43.0
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

aer_print_error() skips printing if ratelimit_print[i] is not set.
In the native AER path, ratelimit_print is initialized by
add_error_device() during source device discovery, and is set to 1
for fatal errors to bypass rate limiting since fatal errors should
always be logged.

The DPC/EDR path uses the DPC-capable port as the error source and
reads its AER uncorrectable error status registers directly in
dpc_get_aer_uncorrect_severity(). Since it does not go through
add_error_device(), ratelimit_print[0] is left uninitialized and zero.
As a result, aer_print_error() silently drops all AER error messages
for DPC/EDR triggered events.

Set ratelimit_print[0] to 1 to bypass rate limiting and always print
AER logs for fatal errors.

Fixes: a57f2bfb4a58 ("PCI/AER: Ratelimit correctable and non-fatal error logging")
Co-developed-by: Goudar Manjunath Ramanagouda <manjunath.ramanagouda.goudar@intel.com>
Signed-off-by: Goudar Manjunath Ramanagouda <manjunath.ramanagouda.goudar@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/pci/pcie/dpc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index fc18349614d7..7605ddd9f0ba 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -256,6 +256,7 @@ static int dpc_get_aer_uncorrect_severity(struct pci_dev *dev,
 
 	info->dev[0] = dev;
 	info->error_dev_num = 1;
+	info->ratelimit_print[0] = 1;
 
 	return 1;
 }
-- 
2.43.0


