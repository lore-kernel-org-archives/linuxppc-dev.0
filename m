Return-Path: <linuxppc-dev+bounces-20287-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DA36FF8875
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Apr 2026 12:29:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g5GpJ2kGzz2ySf;
	Wed, 29 Apr 2026 22:29:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777465784;
	cv=none; b=OHR7FqtXVHtipEHA+Dakz9R2l+P/ep4hO9tHMB8FCzUbghnyyOE46n6djapLKpopFt6MYnHeiIeFXwDnZIiCIjMLQSDQXogYdfabaIA5ug5LIJH26shUIG96dMkHwkBRY+8yO9vQMjEQ2mpuZcAdusuoOYecrQJ6pSj2B09jVvfEgae+p8xtEkKodGcOzkc07uR9UErJodRZ88UioL8H7QdHvOyok01lqtPstPZKqvoXyqpgVkmRmidTc+o/e3SRnRZbYJZcxKTNm+pGsUD4DL4CfdG6yp+N1GNKXAXnRl3YlGcFT08jUKbQRrAFwy0ffNLsZZFcY4S7BynB2iTlgg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777465784; c=relaxed/relaxed;
	bh=kblWfe9kTibuhrRU5efH3gDMw18eS1z20lnTSnESx6k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R42rOVEeO5ee5evRt21j6vj2KHU5kmn5eMyxDq9QfxYHjhcvTnRI8uO2iE/XwHYk1B5gtHQ64aawGD0PyFFIHLCgEF9iyfqzNrzKRPiHb9ngiKBHWlqcshhJPVnGJMOpNrLLEs+BUWAODhGZkT6N62PlnvmOhGsjY3+uus+zoIG2rD3ej+oCvb5owqjpXBP5UE+9SU1mGOQJNGO7iiw1E+lUAOAoSa6Bz4xDDmYD8ITIHXcdv+2xbxux13+/SXoWSI5wxnFtSsehKELxUVArR2V/G3XG6QAal74E8vAceZPEW7cvtkFJnc9uGrj0iYTNahjSfZQzWDiHAq8sR2sAyg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Rz7bv+4s; dkim-atps=neutral; spf=pass (client-ip=198.175.65.12; helo=mgamail.intel.com; envelope-from=ilpo.jarvinen@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Rz7bv+4s;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=198.175.65.12; helo=mgamail.intel.com; envelope-from=ilpo.jarvinen@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g5GpH22Nnz2ytV
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Apr 2026 22:29:42 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777465784; x=1809001784;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GKXpXP0HLpIzXt9FVzTWoltHAc5rYgaa1I20ERAvp2k=;
  b=Rz7bv+4shmMBpxa7imBuP1+bJy9EpetkMooa8aS08Vty+wirFcWxrgew
   FAx7gqbXvSYaQ4ejEy/sYlnvlGitXLv1PTlmnhzkHIw5K5M/76JOdAet0
   WVylXaocGUP+QVJ/fHJtGSubO8hAUnEcgS6espO1vIoKUENg0tQF8JUAS
   FWg+IYhLgvQ/ZuPq1ybgSFFNoB+galtU6vGr3/zZgGmZPXJJ8ZDVU0zOe
   fKTTh6KrCypUU2TRg0ogfnf474VgjbPrf9oqEAGn83B03MS1iwO9PLtnz
   bSJN0XYs9OmjMe+zfi2XuVkOx46NZWeCl6od9/DbybYNMf5+V7UslEIUE
   Q==;
X-CSE-ConnectionGUID: VAKngYhsRruYprushhlp3g==
X-CSE-MsgGUID: G2Jtn3QZRMmG0QochOB1lA==
X-IronPort-AV: E=McAfee;i="6800,10657,11770"; a="89853560"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="89853560"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 05:28:36 -0700
X-CSE-ConnectionGUID: wGp35jvkToyaC0AQ8zhvVw==
X-CSE-MsgGUID: vJjmMR20RrCYutR71IFsrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="264639579"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.212])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 05:28:33 -0700
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
Subject: [PATCH 11/11] PCI: Return valid alignment for assigned resources
Date: Wed, 29 Apr 2026 15:26:17 +0300
Message-Id: <20260429122617.7324-12-ilpo.jarvinen@linux.intel.com>
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

When a resource is assigned, IORESOURCE_STARTALIGN flag is cleared,
resulting in pci_resource_alignment() returning 0 in some situations
(at least for bridge windows).

Add heuristic to pci_resource_alignment() which mimics start and size
alignment by taking minimum of those for an assigned resource. It may
overestimate alignment when start has large alignment but the exact
alignment information is not available and regenerating it by sizing
the bridge again is costly.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/setup-res.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index c15bce20815d..03098f159ec9 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -13,6 +13,7 @@
  *	     Resource sorting
  */
 
+#include <linux/bitops.h>
 #include <linux/kernel.h>
 #include <linux/export.h>
 #include <linux/pci.h>
@@ -265,6 +266,18 @@ resource_size_t pci_resource_alignment(const struct pci_dev *dev,
 	    (res->flags & (IORESOURCE_IO|IORESOURCE_MEM)))
 		min_align = pci_min_window_alignment(dev->bus, res->flags);
 
+	if (resource_assigned(res)) {
+		resource_size_t start_align = 1, size_align;
+
+		size_align = roundup_pow_of_two(resource_size(res));
+		if (res->start)
+			start_align <<= __ffs(res->start);
+		else
+			start_align = size_align;
+
+		return max(min(start_align, size_align), min_align);
+	}
+
 	return max(resource_alignment(res), min_align);
 }
 
-- 
2.39.5


