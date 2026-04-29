Return-Path: <linuxppc-dev+bounces-20284-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27947FF8867
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Apr 2026 12:28:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g5GmQ6R91z2ykf;
	Wed, 29 Apr 2026 22:28:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.20
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777465686;
	cv=none; b=iudkQrARJjVYyCdZhr2qfbD6O3/TcMrTEcyxCDai8ARLO4JTDXOjUsY2/Ai4LfCuhOM2bVw3SG0T8AcnrMNBsPGVRBYnj/cLNjGGa8za0HpWpvBU1oDJd8/ERRyPisAjD9bgPVMxuVzIsZv2xGHI50hrhIq1zs+aD+pFH5J7C+PPwRlW+PJoxY0l6FXLAp7HR/c6WTNAF15A1kNN0CiF6EdVOTLATo+QzQCGgILWBzsHTXMOnqB4fJD5nQvIOgJ5DQXT4z+w9ai3X2ovf9OHJxMH/ZEmZJrxATuKGA4N9nl6/33XpPBwv9kT0Bff6pNnhiMINnVuOixdb3dPHkQ7HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777465686; c=relaxed/relaxed;
	bh=1tr7ELEGjiLyc8Dv5hucsIRD/tzhmBAvexTzwFvQodg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dcUNng9nn55jqPQ7rQe7zE5npSskgJcghP9zTqPBF1C9Na2P5a0/Veh362ZmyM8bvdQ8FN9d1cu3lph0edxKtunL1RXi6P3yDmFA2F1HopYsvVN5uyjFQbznIYky3ccWzFBac9gCS8vh9C8A7eaiN5QZVI59nhXkzs5g+OtkgUsw55RNI3++z/fpdRmLLd1fuoWQI7VguPpUYzfg6btEq+LNJXkIKHU8m4fT4fCaz3dguhl7QJKbJraNgGk6H8JFQco8mXVCBFTT2vfQMjECEkbvkEnECHdIu+8xIjiaw/C51AaDqsINOTHG6WKnce5lfiiMI7LcTd7JdW/JGSM4Zw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=XjfnhiTv; dkim-atps=neutral; spf=pass (client-ip=198.175.65.20; helo=mgamail.intel.com; envelope-from=ilpo.jarvinen@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=XjfnhiTv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=198.175.65.20; helo=mgamail.intel.com; envelope-from=ilpo.jarvinen@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g5GmN4l4Tz2yVL
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Apr 2026 22:28:04 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777465685; x=1809001685;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fw+Loat2qyLgqvGvG/Jk0dbdhzaYJWuE1SAW/SPTWpo=;
  b=XjfnhiTvgU9fvb1IE+LeHkv171ThaX7zexpKAXBR1lnvkFoo4/ws6rWe
   At3ufizAvPRKDuCaVFu8gvA5ODvRcdoSOSoYRB7gz7DpwuH10T2iGeuec
   HyQ97gfWc/KSfKd4kiZt1my83HzsgnEhBpMqznNxUskhSUWMeADJtNxUt
   cCSp/31SymXni9zcZT4RnS9hEHR7GK+ySpPDFE+6qvnLjzNtg8b6O1C3M
   whs/3dXbJUmgF2lk0T/dXq+5fKi3AL42D4IjL6K/1t9laTIGQQajex/U+
   MBSjgoLAUFyI00pqH5D1sn+vxD++2TgDbLTf7YJGLIIWcXckRLdjb9p3p
   g==;
X-CSE-ConnectionGUID: nKkG5hYYTY2t9zkDhFwrrw==
X-CSE-MsgGUID: su1iTnqeQxedUIxB0kT3Rg==
X-IronPort-AV: E=McAfee;i="6800,10657,11770"; a="78101857"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="78101857"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 05:28:02 -0700
X-CSE-ConnectionGUID: A2voe4hURxKRu6GvpKDDDg==
X-CSE-MsgGUID: zK9kVFhfSe2LF3GcQiLeoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="257573702"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.212])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 05:27:58 -0700
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
Subject: [PATCH 08/11] PCI: Convert pci_resource_alignment() input parameters to const
Date: Wed, 29 Apr 2026 15:26:14 +0300
Message-Id: <20260429122617.7324-9-ilpo.jarvinen@linux.intel.com>
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

pci_resource_alignment() calculates resource alignment and should not
alter its input structs. Make its input parameters const.

It requires making also pci_cardbus_resource_alignment() input const.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/pci.h           | 8 ++++----
 drivers/pci/setup-cardbus.c | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 710803be3a79..e0fcc33dfef6 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -419,7 +419,7 @@ static inline bool pci_is_cardbus_bridge(struct pci_dev *dev)
 	return dev->hdr_type == PCI_HEADER_TYPE_CARDBUS;
 }
 #ifdef CONFIG_CARDBUS
-unsigned long pci_cardbus_resource_alignment(struct resource *res);
+unsigned long pci_cardbus_resource_alignment(const struct resource *res);
 int pci_bus_size_cardbus_bridge(struct pci_bus *bus,
 				struct list_head *realloc_head);
 int pci_cardbus_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
@@ -428,7 +428,7 @@ int pci_cardbus_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 int pci_setup_cardbus(char *str);
 
 #else
-static inline unsigned long pci_cardbus_resource_alignment(struct resource *res)
+static inline unsigned long pci_cardbus_resource_alignment(const struct resource *res)
 {
 	return 0;
 }
@@ -1044,8 +1044,8 @@ static inline void pci_suspend_ptm(struct pci_dev *dev) { }
 static inline void pci_resume_ptm(struct pci_dev *dev) { }
 #endif
 
-static inline resource_size_t pci_resource_alignment(struct pci_dev *dev,
-						     struct resource *res)
+static inline resource_size_t pci_resource_alignment(const struct pci_dev *dev,
+						     const struct resource *res)
 {
 	int resno = pci_resource_num(dev, res);
 
diff --git a/drivers/pci/setup-cardbus.c b/drivers/pci/setup-cardbus.c
index 1ebd13a1f730..0cba404080ad 100644
--- a/drivers/pci/setup-cardbus.c
+++ b/drivers/pci/setup-cardbus.c
@@ -22,7 +22,7 @@
 static unsigned long pci_cardbus_io_size = DEFAULT_CARDBUS_IO_SIZE;
 static unsigned long pci_cardbus_mem_size = DEFAULT_CARDBUS_MEM_SIZE;
 
-unsigned long pci_cardbus_resource_alignment(struct resource *res)
+unsigned long pci_cardbus_resource_alignment(const struct resource *res)
 {
 	if (res->flags & IORESOURCE_IO)
 		return pci_cardbus_io_size;
-- 
2.39.5


