Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-03.arcor-online.net (mail-in-03.arcor-online.net
	[151.189.21.43])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D9410DDE9E
	for <linuxppc-dev@ozlabs.org>; Wed, 16 May 2007 22:45:24 +1000 (EST)
From: Segher Boessenkool <segher@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Fix sed command lines for zlib source construction
Date: Wed, 16 May 2007 14:49:22 +0200
Message-Id: <11793197622278-git-send-email-segher@kernel.crashing.org>
Message-Id: <f091c72d76dd8407db9c32cc28dcedcbbe797349.1179319683.git.segher@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Not every sed understands \+ so use the more portable * instead.

Signed-off-by: Segher Boessenkool <segher@kernel.crashing.org>
---
 arch/powerpc/boot/Makefile |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index d4f9fef..6e0c8e0 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -54,13 +54,13 @@ obj-wlib := $(addsuffix .o, $(basename $(addprefix $(obj)/, $(src-wlib))))
 obj-plat := $(addsuffix .o, $(basename $(addprefix $(obj)/, $(src-plat))))
 
 quiet_cmd_copy_zlib = COPY    $@
-      cmd_copy_zlib = sed "s@__attribute_used__@@;s@<linux/\([^>]\+\).*@\"\1\"@" $< > $@
+      cmd_copy_zlib = sed "s@__attribute_used__@@;s@<linux/\([^>]*\).*@\"\1\"@" $< > $@
 
 quiet_cmd_copy_zlibheader = COPY    $@
-      cmd_copy_zlibheader = sed "s@<linux/\([^>]\+\).*@\"\1\"@" $< > $@
+      cmd_copy_zlibheader = sed "s@<linux/\([^>]*\).*@\"\1\"@" $< > $@
 # stddef.h for NULL
 quiet_cmd_copy_zliblinuxheader = COPY    $@
-      cmd_copy_zliblinuxheader = sed "s@<linux/string.h>@\"string.h\"@;s@<linux/kernel.h>@<stddef.h>@;s@<linux/\([^>]\+\).*@\"\1\"@" $< > $@
+      cmd_copy_zliblinuxheader = sed "s@<linux/string.h>@\"string.h\"@;s@<linux/kernel.h>@<stddef.h>@;s@<linux/\([^>]*\).*@\"\1\"@" $< > $@
 
 $(addprefix $(obj)/,$(zlib)): $(obj)/%: $(srctree)/lib/zlib_inflate/%
 	$(call cmd,copy_zlib)
-- 
1.5.2.rc0.g4342-dirty
