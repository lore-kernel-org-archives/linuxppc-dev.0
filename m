Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id B5592B7B61
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 16 Jul 2009 11:25:22 +1000 (EST)
To: <catalin.marinas@arm.com>
Message-Id: <f18967360113efe4354a9ad0d71ead9a0f7579ea.1247707485.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH] kmemleak: Allow kmemleak to be built on powerpc
Date: Thu, 16 Jul 2009 11:25:22 +1000 (EST)
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Very lightly tested, doesn't crash the kernel.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

It doesn't look like we actually need to add any support in the
arch code - or is there something I'm missing?


 lib/Kconfig.debug |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 12327b2..d5ca9a5 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -338,7 +338,7 @@ config SLUB_STATS
 
 config DEBUG_KMEMLEAK
 	bool "Kernel memory leak detector"
-	depends on DEBUG_KERNEL && EXPERIMENTAL && (X86 || ARM) && \
+	depends on DEBUG_KERNEL && EXPERIMENTAL && (X86 || ARM || PPC) && \
 		!MEMORY_HOTPLUG
 	select DEBUG_FS if SYSFS
 	select STACKTRACE if STACKTRACE_SUPPORT
-- 
1.6.2.1
