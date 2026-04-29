Return-Path: <linuxppc-dev+bounces-20286-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCFD8FF8867
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Apr 2026 12:29:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g5GpG47xwz2yVL;
	Wed, 29 Apr 2026 22:29:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777465782;
	cv=none; b=cC+YL0QDqTBggkgZXxigs4C05WvHM87mD792AXs/ZLEb+9rvfxVcHO7FQZkTlVc0LPWlBwu8oyE39V+lMmYLYBrVgqFwj53jAx0eGOHwbzd6+Kcw4NbBq9d/GZm7MKFMBam+Qq/nzfk7IjU94PyDWlo8e06hCqqctrPPjeFlGMUVMr+6XwMbXSyVgreGzifpL8xWYaY3FQR/u6EJwYSKxxbH8tRHoyT9O+Ue8H7m/gqqmJh1e1OyNAZk/GGVABRiDs2vti5V3+bJBCtDnWYRCo55EdB54a5ht+jIF5bR6hsBR5XFz8KU4uIOtk0XJgLqA4lqUJHKJjz1iQaUlghEEA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777465782; c=relaxed/relaxed;
	bh=7IhhC7Vo1n0pUixItwd3TBALOlTK4aOxR3OhWmz6me4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BcaFU/TicgECqxdpGkOpQByWHpzi6jl+yRgBFHb84VYbQCmW09BD6C7LT8I9Kz0esvIl6fhUeXEfqOJ/BPdXu8XqD5A3jBfcD97b+TZOfJqwePrt6jzYacu9Cjgv7jyjeiFBN+xMXFhHFUwPVt3k/EEDTDchW+QjfexgW+HH37AecGATb7YbxnTtvQP7EtnUSTkBSGDJQgChdd1DcTOakIis8NsS5vbj+CNDoR18QtL03jGQVWqzJkmjOlzqoE6Z72sAgAxM93zVKSctAq+4+tB9P1GcIaFfUt60y8m9+/X/SxoP6A57g6oknNXVEPTSIxWhs9ChD7eFI2udF6LpPg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dlIlnp1P; dkim-atps=neutral; spf=pass (client-ip=198.175.65.12; helo=mgamail.intel.com; envelope-from=ilpo.jarvinen@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dlIlnp1P;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=198.175.65.12; helo=mgamail.intel.com; envelope-from=ilpo.jarvinen@linux.intel.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 65 seconds by postgrey-1.37 at boromir; Wed, 29 Apr 2026 22:29:41 AEST
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g5GpF2SlCz2ySf
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Apr 2026 22:29:40 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777465782; x=1809001782;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fqkZl+gRhl4cKQbh+rABk9mPSNA9e1YAdoDCW18qzQY=;
  b=dlIlnp1PPjXkFhrhGjyF5sPjW3bG0Svjv6UatwoOWGszzjV0+DIDDEW2
   9R1S/AM1Yf9fq3TVHybrI8wlK+8PHa7cHV9YDH63gJNj+scPMXfWMsyS2
   UlSlxiyQXKDI+P1U4Zvt4934QKinrPy6jhGbWlI4pQ1/b0Q+ds/foFOWM
   cu7AaKqZ4nNdnV1l6Q97xZHhF7dJ4SLJt5MF6H4vvcJVOwxuGsYKmCxJ0
   4FgWtpbegj5vjUxaMaoEBUo3vHJLvEH0DGyNvF3w/+CowgKwUx2/+hcq5
   vMmNMTWS3RXA8ImD59AELwiqBTqhC121pz/G+iKlL+C/sCPNeG7aqxw0C
   w==;
X-CSE-ConnectionGUID: c+WMKdboRSWg3iijy5Dbdg==
X-CSE-MsgGUID: kzBLuxrZS0q625bgv2xdiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11770"; a="89853543"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="89853543"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 05:28:25 -0700
X-CSE-ConnectionGUID: 0b2tYkpVQgm1CLfL2p4dAw==
X-CSE-MsgGUID: uI4xITOIRG2N/6phtyIxUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="264639555"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.212])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 05:28:22 -0700
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
Subject: [PATCH 10/11] PCI: Lower bound bridge window alignment
Date: Wed, 29 Apr 2026 15:26:16 +0300
Message-Id: <20260429122617.7324-11-ilpo.jarvinen@linux.intel.com>
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

pci_resource_alignment() does not consider bridge windows special,
yet their alignment is subject to different requirements from BAR
alignment.

Add lower bound to bridge window alignment to help callers out to
always have large enough alignment.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/setup-res.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index 18e8775ea848..c15bce20815d 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -19,7 +19,10 @@
 #include <linux/errno.h>
 #include <linux/ioport.h>
 #include <linux/cache.h>
+#include <linux/minmax.h>
 #include <linux/slab.h>
+#include <linux/types.h>
+
 #include "pci.h"
 
 static void pci_std_update_resource(struct pci_dev *dev, int resno)
@@ -250,12 +253,19 @@ resource_size_t pci_resource_alignment(const struct pci_dev *dev,
 				       const struct resource *res)
 {
 	int resno = pci_resource_num(dev, res);
+	resource_size_t min_align = 0;
 
 	if (pci_resource_is_iov(resno))
 		return pci_sriov_resource_alignment(dev, resno);
+
 	if (dev->class >> 8 == PCI_CLASS_BRIDGE_CARDBUS)
 		return pci_cardbus_resource_alignment(res);
-	return resource_alignment(res);
+
+	if (pci_resource_is_bridge_win(resno) &&
+	    (res->flags & (IORESOURCE_IO|IORESOURCE_MEM)))
+		min_align = pci_min_window_alignment(dev->bus, res->flags);
+
+	return max(resource_alignment(res), min_align);
 }
 
 /*
-- 
2.39.5


