Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 65978B7103
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 23 Jun 2009 11:56:39 +1000 (EST)
To: <linuxppc-dev@ozlabs.org>
Message-Id: <8977d21ed6cf59b89f9a830d59968ce178420a46.1245722192.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH] powerpc/ps3: Use pr_devel() in ps3/mm.c
Date: Tue, 23 Jun 2009 11:56:39 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The non-debug case in ps3/mm.c uses pr_debug(), so that the compiler
still does type checks etc. and doesn't complain about unused
variables in the non-debug case.

However with DEBUG=n and CONFIG_DYNAMIC_DEBUG=y there's still code
generated for those pr_debugs().

size before:
   text    data     bss     dec     hex filename
  17553	   4112	     88	  21753	   54f9	arch/powerpc/platforms/ps3/mm.o

size after:
   text    data     bss     dec     hex filename
   7377	    776	     88	   8241	   2031	arch/powerpc/platforms/ps3/mm.o

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/platforms/ps3/mm.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/ps3/mm.c b/arch/powerpc/platforms/ps3/mm.c
index 846eb8b..68f1397 100644
--- a/arch/powerpc/platforms/ps3/mm.c
+++ b/arch/powerpc/platforms/ps3/mm.c
@@ -34,7 +34,7 @@
 #if defined(DEBUG)
 #define DBG udbg_printf
 #else
-#define DBG pr_debug
+#define DBG pr_devel
 #endif
 
 enum {
-- 
1.6.2.1
