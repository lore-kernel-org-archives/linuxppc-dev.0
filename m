Return-Path: <linuxppc-dev+bounces-18734-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5085F54ADB
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Mar 2026 17:00:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fgGWQ4jRrz2ypV;
	Wed, 25 Mar 2026 04:00:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.19
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774371634;
	cv=none; b=GaDBO9byQIYA+9dayy9wJh92qqxBxdFybt4C1D3jOkGFmYzBoaRBXMxIojCC1rPgc3WqVukJycUxDeUASH8WLQnhO/E9QYgPTsTyqvPnoTllTfuAYLHbr8EY1YjELerGdL3Vv5fqFN2Qc0CgjfNsBhfnsOkJdpxTytkbYADmCLQbnUKE38EG6Bs9Wm+HM+NiRAgEExCNGdkPeZfCWLak5Ew/pUZ+0foUqPtmVrkdDvIersmREJN6TiWCSBmooaYfIPVe2CNID3ceU75f8azR8KcCCnTLGKwPKy0ZeOxKJAIKtr5K2aKMcBWitiXt23atxjE0bCI5lErQXlpolrwjqw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774371634; c=relaxed/relaxed;
	bh=sI6V0alAInp+YEqTm9i0iP4YwBvR6bTOYbLWwt85RwA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=emsTg2SIuiLvwcJ6JoeVwpyUgHqKZoFxw7VJuMXhAvsKdN52+ORtZ7/BwE0ixjD0HDLBT7A+T2gc9cDlDGzuLV+xs2z1WYnVpuua4lCKFUCbKeSqlfbhsBJZyiBWhP8F4hUEJXC95vA9LzXG/wZpCtbBdyYOa+AxLAr1/FsrnnQY8LFf7acBH82Qsjdr/ArKTmnUlIPuDJgQXp0zaYtvhGQBbQSek9tG/6VEcpr2X0tCAA+XPFwnynhnwEtbv4vuVP7Iv852NR7LDkb/5byelX+7XTy2CW7p33YGLm7xGrmKzye4Qgy3Wv+6Eo45jztjtYzRCDXMIszBce7j5RrXwQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RnQfxQ6f; dkim-atps=neutral; spf=pass (client-ip=198.175.65.19; helo=mgamail.intel.com; envelope-from=ilpo.jarvinen@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RnQfxQ6f;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=198.175.65.19; helo=mgamail.intel.com; envelope-from=ilpo.jarvinen@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fgGWP5B6Nz2yng
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2026 04:00:33 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774371634; x=1805907634;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yRiNPjyR6BmckrFz9yS55d2yQZU16Z4uT3UMgBowpHk=;
  b=RnQfxQ6fF2VSviijuaxFyX6IHMyOOuFy5heSZXfQNxfxznZup8qTKw9t
   /3KUddkL2wmy16SPJ3NCBeiE5jrWWFSXv6xaict4Ew0vDGHf5pWy/szE7
   2hW2kqnxu5kwRSj5moI4geos9rb8L5ZzQ++8mUoNfyFentI5uMDZIcTVR
   mu+wW5En9PMfhynSyNrwiVHz6zo2LxhCmnYCgc084AARVDHxT7wvfL3Ya
   sdpw6/MqTwmf6vvIS291sn8KApvDBSGUZdG3N433IfD8WM2O21abD0oeL
   BetePJPJk5/8Bb+hCCIVjc0dI8qvxfjoTKLkVPRLVMM2qT09bDpoPRX2V
   w==;
X-CSE-ConnectionGUID: ERIiE1tuR56LMMcHndKJ+w==
X-CSE-MsgGUID: zriC7fVzTNKjamkhUAfDJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="75281473"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="75281473"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 10:00:31 -0700
X-CSE-ConnectionGUID: NHjFhTG1RYO9C2glveQ6yA==
X-CSE-MsgGUID: hhyUW1HYQmiP63jGpn9/jA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="219540299"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.217])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 10:00:22 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-alpha@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Helge Deller <deller@gmx.de>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Chris Zankel <chris@zankel.net>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 08/10] PCI: Rename window_alignment() to pci_min_window_alignment()
Date: Tue, 24 Mar 2026 18:56:31 +0200
Message-Id: <20260324165633.4583-9-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260324165633.4583-1-ilpo.jarvinen@linux.intel.com>
References: <20260324165633.4583-1-ilpo.jarvinen@linux.intel.com>
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

window_alignment() lacks prefix. Rename it to pci_min_window_alignment()
in order to include the prefix and also add min to indicate the returned
window alignment is the minimum PCI spec and arch allows.

Also make it available in drivers/pci/pci.h as upcoming changes will need
to call it from outside of setup-bus.c.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/pci.h       | 3 +++
 drivers/pci/setup-bus.c | 6 +++---
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 13d998fbacce..2edb03c1c6b9 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -1053,6 +1053,9 @@ static inline resource_size_t pci_resource_alignment(struct pci_dev *dev,
 	return resource_alignment(res);
 }
 
+resource_size_t pci_min_window_alignment(struct pci_bus *bus,
+					 unsigned long type);
+
 void pci_acs_init(struct pci_dev *dev);
 void pci_enable_acs(struct pci_dev *dev);
 #ifdef CONFIG_PCI_QUIRKS
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 61f769aaa2f6..edc0d682dcad 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1035,7 +1035,7 @@ resource_size_t __weak pcibios_window_alignment(struct pci_bus *bus,
 #define PCI_P2P_DEFAULT_IO_ALIGN	SZ_4K
 #define PCI_P2P_DEFAULT_IO_ALIGN_1K	SZ_1K
 
-static resource_size_t window_alignment(struct pci_bus *bus, unsigned long type)
+resource_size_t pci_min_window_alignment(struct pci_bus *bus, unsigned long type)
 {
 	resource_size_t align = 1, arch_align;
 
@@ -1084,7 +1084,7 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t add_size,
 	if (resource_assigned(b_res))
 		return;
 
-	min_align = window_alignment(bus, IORESOURCE_IO);
+	min_align = pci_min_window_alignment(bus, IORESOURCE_IO);
 	list_for_each_entry(dev, &bus->devices, bus_list) {
 		struct resource *r;
 
@@ -1339,7 +1339,7 @@ static void pbus_size_mem(struct pci_bus *bus, struct resource *b_res,
 		}
 	}
 
-	win_align = window_alignment(bus, b_res->flags);
+	win_align = pci_min_window_alignment(bus, b_res->flags);
 	min_align = calculate_head_align(aligns, max_order);
 	min_align = max(min_align, win_align);
 	size0 = calculate_memsize(size, realloc_head ? 0 : add_size,
-- 
2.39.5


