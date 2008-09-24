Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (xc.sipsolutions.net [83.246.72.84])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0B218DDF96
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Sep 2008 00:29:59 +1000 (EST)
Subject: [PATCH v2] powerpc: enforce sane MAX_ORDER
From: Johannes Berg <johannes@sipsolutions.net>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <61059ECE-2B42-46B3-B5B3-E5CFA3A5EFC9@kernel.crashing.org>
References: <1222262654.4257.4.camel@johannes.berg>
	<B38CBE3A-B9DA-44BA-8646-AEE81FB82437@kernel.crashing.org>
	<1222265583.4257.21.camel@johannes.berg>
	<61059ECE-2B42-46B3-B5B3-E5CFA3A5EFC9@kernel.crashing.org>
Content-Type: text/plain
Date: Wed, 24 Sep 2008 16:29:08 +0200
Message-Id: <1222266548.4257.26.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
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

This patch makes the Kconfig enforce at least the defaults.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
---

> We'll I'm ok with that, but I dont think we should be values that
> make  
> no sense.  64 would seem the max even in a 64-bit system.

Indeed, it makes little sense to allow you to set more than the address
space, so here's a version with max 64.

--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -415,8 +415,11 @@ config PPC_64K_PAGES
 
 config FORCE_MAX_ZONEORDER
 	int "Maximum zone order"
+	range 9 64 if PPC_64K_PAGES
 	default "9" if PPC_64K_PAGES
+	range 13 64 if PPC64 && !PPC_64K_PAGES
 	default "13" if PPC64 && !PPC_64K_PAGES
+	range 11 64
 	default "11"
 	help
 	  The kernel memory allocator divides physically contiguous memory
