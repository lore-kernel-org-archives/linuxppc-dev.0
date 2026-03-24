Return-Path: <linuxppc-dev+bounces-18727-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA5BBF54ADA
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Mar 2026 16:58:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fgGTH1Pb2z2yrZ;
	Wed, 25 Mar 2026 03:58:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.13
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774371523;
	cv=none; b=WrldIR0lAD/n/dT4ToDEnnTnkUgCW91ggYb3ECcFGBuxV0kXyOhZxAuxNls3Gq1c4jKVupn5M3btIqnprtJ/H6gBuhuaINoBMIGCf/uT4LOTsyCg0iZ52RftALUgFX4goB1Ro2eyPVsWS8WdjLPJo8NhLRtEAHM/sUeO+uun7dV8X/96cnHLDHQd5aGMK7XNkQ1OgBUpRx0ZwfqJ39ylkViFMU4wFC7mFCXs0591RsK4AxIMX5Ko9pvGxsb0s0nU2Zv8gzBShwymln1zND28oX17zQL7d0Sd92n67tTevCpMRJt7+B6u7Juq0X/Ga5M4P00fwBrIU1jlB8XsHnKgYA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774371523; c=relaxed/relaxed;
	bh=s16obLPlfxX3ODE8B6LSIvb7UDetCIb25s0h37Tlk74=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jv8pcPDT+GGf0tUAM4YMn6qGs4AQPd8WRxoW+70+jTjl0jdqyW7H2xOy7okD3Mo+AkNdGpsrvmwa2e/T4zqKjlGphq9bPhyEub8CLGRwGSFdFQHsjus2jSsQ595zwuptGJKV2n9K92Mxt6AICqf3yCwy61oIRu+gkIpAYNgvQTCxb9ttyRNIhsdO+ijp48GQeQVGSsfIOhwB/u2XQia0nXonpBpAEJAZx2C9mJehamxv7bwQucFNDQWiYp1SU/L4zUqdDnmdObxCROrybohHrT8fTVlboJb22YKgzgIwmFnyMmWjSCsjLG88iroAx0Kru5f6qxIb6t9STO9Cj7Lkag==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=J8PRjTnR; dkim-atps=neutral; spf=pass (client-ip=198.175.65.13; helo=mgamail.intel.com; envelope-from=ilpo.jarvinen@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=J8PRjTnR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=198.175.65.13; helo=mgamail.intel.com; envelope-from=ilpo.jarvinen@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fgGTG1tWQz2yqs
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2026 03:58:41 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774371523; x=1805907523;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rU3n+FhgkyydByVdKs0lqSkLocKXu14IaAOX593F5w8=;
  b=J8PRjTnRJZDm7GsGDYHMsHfZJayLvO0munVlqFK+Md8Kz4GgrELoHZcB
   aegXvPJPg1VKML5LMbP+K4k1ti4nAP6F553PfAIOf4tqI+BMI0iL0WuUo
   3eiJxsa0mhmQ2yd/uo+PTpGE31iYwAO/vk6mX9pWNyhCyzigIJk5HAWjj
   1rQ8dyuS5p2wilfb2hIN87etXRQefx0thMD2KBWT8wRaba6j/akPBCu3f
   xvI8spWgpvutlCAlLGGD4joi5as62ujgtUIf3qU9zhCC5AXLfWlGTQto7
   DFw0eY6MxB2oBrsgznf9/Dqrmv5qwHlcazbYHqHHEdYpCtpwgemQxDJCH
   A==;
X-CSE-ConnectionGUID: SnV2FONwR2KU2V+51iJ15A==
X-CSE-MsgGUID: Igt6sdxESVKmEeuiol1kkg==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="86471573"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="86471573"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 09:58:40 -0700
X-CSE-ConnectionGUID: cUSLjl01TreRSEfKEtoT3A==
X-CSE-MsgGUID: UG9hoz2GT3+u65rMjcqTqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="224421884"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.217])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 09:58:30 -0700
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
Subject: [PATCH 01/10] resource: Add __resource_contains_unbound() for internal contains checks
Date: Tue, 24 Mar 2026 18:56:24 +0200
Message-Id: <20260324165633.4583-2-ilpo.jarvinen@linux.intel.com>
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

__find_resource_space() currently uses resource_contains() but for
tentative resources that are not yet crafted into the resource tree. As
resource_contains() checks that IORESOURCE_UNSET is not set for either
of the resources, the caller has to hack around this problem by
clearing the IORESOURCE_UNSET flag (essentially lying to
resource_contains()).

Instead of the hack, introduce __resource_contains_unbound() for cases
like this.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 include/linux/ioport.h | 20 +++++++++++++++++---
 kernel/resource.c      |  4 ++--
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index 5533a5debf3f..19d5e04564d9 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -304,14 +304,28 @@ static inline unsigned long resource_ext_type(const struct resource *res)
 {
 	return res->flags & IORESOURCE_EXT_TYPE_BITS;
 }
-/* True iff r1 completely contains r2 */
-static inline bool resource_contains(const struct resource *r1, const struct resource *r2)
+
+/*
+ * For checking if @r1 completely contains @r2 for resources that have real
+ * addresses but are not yet crafted into the resource tree. Normally
+ * resource_contains() should be used instead of this function as it checks
+ * also IORESOURCE_UNSET flag.
+ */
+static inline bool __resource_contains_unbound(const struct resource *r1,
+					       const struct resource *r2)
 {
 	if (resource_type(r1) != resource_type(r2))
 		return false;
+
+	return r1->start <= r2->start && r1->end >= r2->end;
+}
+/* True iff r1 completely contains r2 */
+static inline bool resource_contains(const struct resource *r1, const struct resource *r2)
+{
 	if (r1->flags & IORESOURCE_UNSET || r2->flags & IORESOURCE_UNSET)
 		return false;
-	return r1->start <= r2->start && r1->end >= r2->end;
+
+	return __resource_contains_unbound(r1, r2);
 }
 
 /* True if any part of r1 overlaps r2 */
diff --git a/kernel/resource.c b/kernel/resource.c
index bb966699da31..1e2f1dfc0edd 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -754,7 +754,7 @@ static int __find_resource_space(struct resource *root, struct resource *old,
 		/* Check for overflow after ALIGN() */
 		avail.start = ALIGN(tmp.start, constraint->align);
 		avail.end = tmp.end;
-		avail.flags = new->flags & ~IORESOURCE_UNSET;
+		avail.flags = new->flags;
 		if (avail.start >= tmp.start) {
 			alloc.flags = avail.flags;
 			if (alignf) {
@@ -765,7 +765,7 @@ static int __find_resource_space(struct resource *root, struct resource *old,
 			}
 			alloc.end = alloc.start + size - 1;
 			if (alloc.start <= alloc.end &&
-			    resource_contains(&avail, &alloc)) {
+			    __resource_contains_unbound(&avail, &alloc)) {
 				new->start = alloc.start;
 				new->end = alloc.end;
 				return 0;
-- 
2.39.5


