Return-Path: <benh@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 9EFB4B70FF
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 15 Jun 2009 10:46:24 +1000 (EST)
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 15 Jun 2009 10:45:50 +1000
Subject: [PATCH] powerpc: Fix invalid construct in our CPU selection Kconfig
Message-Id: <20090615004624.8A3DADDD1C@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

commit 5b7c3c918c9c26c50d220b2b50359208cb5a1dbe introduced an invalid
construct in our CPU selection. This caused warnings, though it still
appeared to do the right thing.

This fixes it properly by having separate formal definitions of
PPC_BOOK3S_32 and PPC_BOOK3S_64 and one statement defining
PPC_BOOK3S based on the two above.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/platforms/Kconfig.cputype |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- linux-work.orig/arch/powerpc/platforms/Kconfig.cputype	2009-06-15 10:39:54.000000000 +1000
+++ linux-work/arch/powerpc/platforms/Kconfig.cputype	2009-06-15 10:41:48.000000000 +1000
@@ -21,7 +21,7 @@ choice
 
 	  If unsure, select 52xx/6xx/7xx/74xx/82xx/83xx/86xx.
 
-config PPC_BOOK3S
+config PPC_BOOK3S_32
 	bool "512x/52xx/6xx/7xx/74xx/82xx/83xx/86xx"
 	select PPC_FPU
 
@@ -57,11 +57,14 @@ config E200
 
 endchoice
 
-config PPC_BOOK3S
-	default y
+config PPC_BOOK3S_64
+	def_bool y
 	depends on PPC64
 	select PPC_FPU
 
+config PPC_BOOK3S
+	def_bool y
+	depends on PPC_BOOK3S_32 || PPC_BOOK3S_64
 
 config POWER4_ONLY
 	bool "Optimize for POWER4"
