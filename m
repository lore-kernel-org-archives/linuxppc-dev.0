Return-Path: <benh@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 311ADB70CF
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 22 Jul 2009 11:26:03 +1000 (EST)
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 22 Jul 2009 11:25:53 +1000
Subject: [PATCH] powerpc/mm: Fix definitions of FORCE_MAX_ZONEORDER in Kconfig
Message-Id: <20090722012603.211A3DDD1B@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The current definitions set ranges and defaults for 32 and 64-bit
only using "PPC_STD_MMU" which means hash based MMU. This uselessly
restrict the usefulness for the upcoming 64-bit BookE port, but more
than that, it's broken on 32-bit since the only 32-bit platform
supporting multiple page sizes currently is 44x which does -not-
have PPC_STD_MMU_32 set.

This fixes it by using PPC64 and PPC32 instead.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/Kconfig |   20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

--- linux-work.orig/arch/powerpc/Kconfig	2009-07-22 11:22:16.000000000 +1000
+++ linux-work/arch/powerpc/Kconfig	2009-07-22 11:22:39.000000000 +1000
@@ -492,16 +492,16 @@ endchoice
 
 config FORCE_MAX_ZONEORDER
 	int "Maximum zone order"
-	range 9 64 if PPC_STD_MMU_64 && PPC_64K_PAGES
-	default "9" if PPC_STD_MMU_64 && PPC_64K_PAGES
-	range 13 64 if PPC_STD_MMU_64 && !PPC_64K_PAGES
-	default "13" if PPC_STD_MMU_64 && !PPC_64K_PAGES
-	range 9 64 if PPC_STD_MMU_32 && PPC_16K_PAGES
-	default "9" if PPC_STD_MMU_32 && PPC_16K_PAGES
-	range 7 64 if PPC_STD_MMU_32 && PPC_64K_PAGES
-	default "7" if PPC_STD_MMU_32 && PPC_64K_PAGES
-	range 5 64 if PPC_STD_MMU_32 && PPC_256K_PAGES
-	default "5" if PPC_STD_MMU_32 && PPC_256K_PAGES
+	range 9 64 if PPC64 && PPC_64K_PAGES
+	default "9" if PPC64 && PPC_64K_PAGES
+	range 13 64 if PPC64 && !PPC_64K_PAGES
+	default "13" if PPC64 && !PPC_64K_PAGES
+	range 9 64 if PPC32 && PPC_16K_PAGES
+	default "9" if PPC32 && PPC_16K_PAGES
+	range 7 64 if PPC32 && PPC_64K_PAGES
+	default "7" if PPC32 && PPC_64K_PAGES
+	range 5 64 if PPC32 && PPC_256K_PAGES
+	default "5" if PPC32 && PPC_256K_PAGES
 	range 11 64
 	default "11"
 	help
