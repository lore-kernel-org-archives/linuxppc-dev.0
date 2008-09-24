Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (xc.sipsolutions.net [83.246.72.84])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6A2ADDDF37
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Sep 2008 23:25:19 +1000 (EST)
Subject: [PATCH] powerpc: enforce sane MAX_ORDER
From: Johannes Berg <johannes@sipsolutions.net>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Wed, 24 Sep 2008 15:24:14 +0200
Message-Id: <1222262654.4257.4.camel@johannes.berg>
Mime-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

powerpc uses CONFIG_FORCE_MAX_ZONEORDER, and some things depend on it
being at least 10 when 64k pages are not configured (notably the dart
iommu code with CONFIG_PM). The defaults are fine, but when going from a
64K pages config to one without 64K pages, MAX_ORDER stays at 9 which is
too low for 4K pages.

This patch makes the Kconfig enforce at least the defaults, I used 999
as the upper bound for no particular reason other than that it's plenty.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
---

--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -415,8 +415,11 @@ config PPC_64K_PAGES
 
 config FORCE_MAX_ZONEORDER
 	int "Maximum zone order"
+	range 9 999 if PPC_64K_PAGES
 	default "9" if PPC_64K_PAGES
+	range 13 999 if PPC64 && !PPC_64K_PAGES
 	default "13" if PPC64 && !PPC_64K_PAGES
+	range 11 999
 	default "11"
 	help
 	  The kernel memory allocator divides physically contiguous memory
