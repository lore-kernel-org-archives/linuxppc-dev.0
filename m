Return-Path: <linuxppc-dev+bounces-20285-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8979AFF8875
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Apr 2026 12:28:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g5Gmf25tsz2yvK;
	Wed, 29 Apr 2026 22:28:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.20
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777465698;
	cv=none; b=TmFknhws8CuxDoQrQavhHa7OPOL3/7tUrnLUFCBuRr+35YVJSRDEfM7eVHB6l3sxYuLBWLCjUO3q8K2z/sZbK9IP96Oy4yYsdFui7g/vld+DHs73h/Z5i0dLdsT3gR5KIKRW8MBy6Cqko1yIuYJxCl1Tb5hWm+gifCNjOWvbcfzq9uWZG7f9hCLYnmmp+LjSic8PHxcvKvvTjp/O90lJLYhiPJMDeE3Zlld+ZvYmTfTXvMQLbDUjeouQY/kz9G//0Kpqz1LtnuSKFzl0wc30DDa15A5SNYryRiU+ZawV56jCiLGcIoEvJhOVGeuskdQ0pqz/OvltIoX5N0y564nR4w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777465698; c=relaxed/relaxed;
	bh=jodr/HDOcMyiLzSkvlj57t7Pdz3lCcp2zEYLo214XdE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JVt6eQUljbLo+5ytAf7o+Pj+wS02+3Mqek0Qk9roKDl+sfhhsJ36HmI11XKrG2/o9pDKBnVfBoN20KbFQXHcjO8XG9hBUy0Pz5Zb3BDZo0/5aWpvs45dnLdcOIKsTJ0XRO3BQ7O5gckR4eln4Fzo662HEiDIwgr3pVlMn6wNlgCrxTvzMLIRZhwVkkoPkVdpCjbEJooYmRvgy6wfJRtHVM69SPAdJZosJ97lPUtHsQ3SBRY0bRFvKsZf3cFRo7Z/O9NKohWW6Gh9hQUY4M2oDAMMgtxEjIsF4iMFr1ObZIo+EnUNCKpkcs80bInSgFfjP4pwYT/H2KBB181cTOPbag==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RSE2kf8H; dkim-atps=neutral; spf=pass (client-ip=198.175.65.20; helo=mgamail.intel.com; envelope-from=ilpo.jarvinen@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RSE2kf8H;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=198.175.65.20; helo=mgamail.intel.com; envelope-from=ilpo.jarvinen@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g5Gmd05Ywz2yVL
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Apr 2026 22:28:16 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777465698; x=1809001698;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oeSgNgDXBsgR0efD4S75suw6nUvLdg/+OHFHO/cn4ws=;
  b=RSE2kf8HXDhdy3t0m3cmDzTcLqOQ9EWpbbD444YVrU/kwjTf56Sy/xMe
   PbgHA9ICPraqezHVbNYyXrRUHP1E6uVndNqBoptNqYqhm2D1q39zxSjgT
   ByBETddxuzXz+yKRXDW8aC8+oDycaz1e71560TOjDwgpWqY9ifiQuP7s1
   rI5MklfcHFoqXClD+FUqtzPJnyC1nzKvF0kmMnkifMeJU3J8tNInIQQXv
   Dpg8OaGmXLs4T7BHcZV6XGgvHrG5gOhksN5qAIbY6SBRXXH4+9kFRqKAC
   l52meSxNkBj84iDj9KiDcxKs52gSgZm1b2NF2RoucpIwDu/t22gQWy0XU
   A==;
X-CSE-ConnectionGUID: 7PM+DGxDTpWXSB4I6Oqo1g==
X-CSE-MsgGUID: 4rRxR0hkQCqv0ZEmMN5UJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11770"; a="78101867"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="78101867"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 05:28:14 -0700
X-CSE-ConnectionGUID: M7JSCq3WQimiDepsf6U6sQ==
X-CSE-MsgGUID: /7sDIPHHQWeOjNW11AQIwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="257573749"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.212])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 05:28:11 -0700
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
Subject: [PATCH 09/11] PCI: Move pci_resource_alignment() to setup-res.c file
Date: Wed, 29 Apr 2026 15:26:15 +0300
Message-Id: <20260429122617.7324-10-ilpo.jarvinen@linux.intel.com>
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

pci_resource_alignment() is a bit one the complex side to have in a
header so put it into setup-res.c.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/pci.h       | 13 ++-----------
 drivers/pci/setup-res.c | 12 ++++++++++++
 2 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index e0fcc33dfef6..472b6c2f7c4d 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -1044,17 +1044,8 @@ static inline void pci_suspend_ptm(struct pci_dev *dev) { }
 static inline void pci_resume_ptm(struct pci_dev *dev) { }
 #endif
 
-static inline resource_size_t pci_resource_alignment(const struct pci_dev *dev,
-						     const struct resource *res)
-{
-	int resno = pci_resource_num(dev, res);
-
-	if (pci_resource_is_iov(resno))
-		return pci_sriov_resource_alignment(dev, resno);
-	if (dev->class >> 8 == PCI_CLASS_BRIDGE_CARDBUS)
-		return pci_cardbus_resource_alignment(res);
-	return resource_alignment(res);
-}
+resource_size_t pci_resource_alignment(const struct pci_dev *dev,
+				       const struct resource *res);
 
 resource_size_t pci_min_window_alignment(struct pci_bus *bus,
 					 unsigned long type);
diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index 0d203325562b..18e8775ea848 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -246,6 +246,18 @@ static int pci_revert_fw_address(struct resource *res, struct pci_dev *dev,
 	return 0;
 }
 
+resource_size_t pci_resource_alignment(const struct pci_dev *dev,
+				       const struct resource *res)
+{
+	int resno = pci_resource_num(dev, res);
+
+	if (pci_resource_is_iov(resno))
+		return pci_sriov_resource_alignment(dev, resno);
+	if (dev->class >> 8 == PCI_CLASS_BRIDGE_CARDBUS)
+		return pci_cardbus_resource_alignment(res);
+	return resource_alignment(res);
+}
+
 /*
  * For mem bridge windows, try to relocate tail remainder space to space
  * before res->start if there's enough free space there. This enables
-- 
2.39.5


