Return-Path: <oohall@gmail.com>
Received: from mail-pa0-x244.google.com (mail-pa0-x244.google.com
 [IPv6:2607:f8b0:400e:c03::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sNh6b3lZrzDrhT
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Aug 2016 18:11:03 +1000 (AEST)
Received: by mail-pa0-x244.google.com with SMTP id hh10so755077pac.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Aug 2016 01:11:03 -0700 (PDT)
From: Oliver O'Halloran <oohall@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: stewart@linux.vnet.ibm.com,
	Oliver O'Halloran <oohall@gmail.com>
Subject: [PATCH 1/6] powerpc/boot: add sed script
Date: Tue, 30 Aug 2016 18:10:31 +1000
Message-Id: <1472544636-7837-2-git-send-email-oohall@gmail.com>
In-Reply-To: <1472544636-7837-1-git-send-email-oohall@gmail.com>
References: <1472544636-7837-1-git-send-email-oohall@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The powerpc boot wrapper is compiled with a separate "bootcc" toolchain
rather than the toolchain used for the rest of the kernel. The main
problem with this is that the wrapper does not have access to the kernel
headers (without a lot of gross hacks). To get around this the required
headers are copied into the build directory via several sed scripts
which rewrite problematic includes. This patch moves these fixups out of
the makefile into a separate .sed script file to clean up makefile
slightly.

Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
---
 arch/powerpc/boot/Makefile          | 18 ++++++------------
 arch/powerpc/boot/fixup-headers.sed | 12 ++++++++++++
 2 files changed, 18 insertions(+), 12 deletions(-)
 create mode 100644 arch/powerpc/boot/fixup-headers.sed

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 1a2a6e8dc40d..f98e42ee2534 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -125,23 +125,17 @@ obj-wlib := $(addsuffix .o, $(basename $(addprefix $(obj)/, $(src-wlib))))
 obj-plat := $(addsuffix .o, $(basename $(addprefix $(obj)/, $(src-plat))))
 obj-plat: $(libfdt)
 
-quiet_cmd_copy_zlib = COPY    $@
-      cmd_copy_zlib = sed "s@__used@@;s@<linux/\([^>]*\).*@\"\1\"@" $< > $@
-
-quiet_cmd_copy_zlibheader = COPY    $@
-      cmd_copy_zlibheader = sed "s@<linux/\([^>]*\).*@\"\1\"@" $< > $@
-# stddef.h for NULL
-quiet_cmd_copy_zliblinuxheader = COPY    $@
-      cmd_copy_zliblinuxheader = sed "s@<linux/string.h>@\"string.h\"@;s@<linux/kernel.h>@<stddef.h>@;s@<linux/\([^>]*\).*@\"\1\"@" $< > $@
+quiet_cmd_copy_kern_src = COPY    $@
+      cmd_copy_kern_src = sed -f $(srctree)/arch/powerpc/boot/fixup-headers.sed $< > $@
 
 $(addprefix $(obj)/,$(zlib)): $(obj)/%: $(srctree)/lib/zlib_inflate/%
-	$(call cmd,copy_zlib)
+	$(call cmd,copy_kern_src)
 
-$(addprefix $(obj)/,$(zlibheader)): $(obj)/%: $(srctree)/lib/zlib_inflate/%
-	$(call cmd,copy_zlibheader)
+$(addprefix $(obj)/,$(zlibheaders)): $(obj)/%: $(srctree)/lib/zlib_inflate/%
+	$(call cmd,copy_kern_src)
 
 $(addprefix $(obj)/,$(zliblinuxheader)): $(obj)/%: $(srctree)/include/linux/%
-	$(call cmd,copy_zliblinuxheader)
+	$(call cmd,copy_kern_src)
 
 quiet_cmd_copy_libfdt = COPY    $@
       cmd_copy_libfdt = cp $< $@
diff --git a/arch/powerpc/boot/fixup-headers.sed b/arch/powerpc/boot/fixup-headers.sed
new file mode 100644
index 000000000000..96362428eb37
--- /dev/null
+++ b/arch/powerpc/boot/fixup-headers.sed
@@ -0,0 +1,12 @@
+# Copyright 2016 IBM Corporation.
+#
+# This program is free software; you can redistribute it and/or modify it
+# under the terms of the GNU General Public License version 2 or later as
+# published by the Free Software Foundation.
+
+s@#include <linux/decompress/mm\.h>@@;
+s@\"zlib_inflate/\([^\"]*\).*@"\1"@;
+s@<linux/kernel.h>@<stddef.h>@;
+
+s@__used@@;
+s@<linux/\([^>]*\).*@"\1"@;
-- 
2.5.5
