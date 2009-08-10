Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id C7858B7DB5
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 10 Aug 2009 15:06:27 +1000 (EST)
To: <linuxppc-dev@ozlabs.org>
Message-Id: <67591a54fdff86f24adf7cc25302a0b3b103d6b5.1249880775.git.michael@ellerman.id.au>
In-Reply-To: <ab02e115992881a734e8e90b7d3f2d8617db4bf2.1249880775.git.michael@ellerman.id.au>
References: <ab02e115992881a734e8e90b7d3f2d8617db4bf2.1249880775.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 2/2] kmemleak: Allow kmemleak to be built on powerpc
Date: Mon, 10 Aug 2009 15:06:27 +1000 (EST)
Cc: catalin.marinas@arm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Lightly tested, doesn't crash the kernel, leak reports appear
to be mostly sane.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
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
