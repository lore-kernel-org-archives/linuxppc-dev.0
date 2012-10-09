Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 05/20] powerpc/xmon: Merge start.c into nonstdio.c
Date: Wed, 10 Oct 2012 01:20:32 +1100
Message-Id: <1349792447-15714-5-git-send-email-michael@ellerman.id.au>
In-Reply-To: <1349792447-15714-1-git-send-email-michael@ellerman.id.au>
References: <1349792447-15714-1-git-send-email-michael@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The routines in start.c are only ever called from nonstdio.c, so if we
move them in there they can become static which is nice.

I suspect the idea behind the separation was that start.c could be
replaced in order to build xmon in userland. If anyone still cares about
doing that we could handle that with an ifdef or two.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/xmon/Makefile   |    2 +-
 arch/powerpc/xmon/nonstdio.c |   14 ++++++++++++++
 arch/powerpc/xmon/nonstdio.h |    2 --
 arch/powerpc/xmon/start.c    |   23 -----------------------
 4 files changed, 15 insertions(+), 26 deletions(-)
 delete mode 100644 arch/powerpc/xmon/start.c

diff --git a/arch/powerpc/xmon/Makefile b/arch/powerpc/xmon/Makefile
index c168c54..b49fdbd 100644
--- a/arch/powerpc/xmon/Makefile
+++ b/arch/powerpc/xmon/Makefile
@@ -6,7 +6,7 @@ GCOV_PROFILE := n
 
 ccflags-$(CONFIG_PPC64) := -mno-minimal-toc
 
-obj-y			+= xmon.o start.o nonstdio.o
+obj-y			+= xmon.o nonstdio.o
 
 ifdef CONFIG_XMON_DISASSEMBLY
 obj-y			+= ppc-dis.o ppc-opc.o
diff --git a/arch/powerpc/xmon/nonstdio.c b/arch/powerpc/xmon/nonstdio.c
index 2209485..942d0f6 100644
--- a/arch/powerpc/xmon/nonstdio.c
+++ b/arch/powerpc/xmon/nonstdio.c
@@ -7,9 +7,23 @@
  *      2 of the License, or (at your option) any later version.
  */
 #include <linux/string.h>
+#include <asm/udbg.h>
 #include <asm/time.h>
 #include "nonstdio.h"
 
+
+static int xmon_write(const void *ptr, int nb)
+{
+	return udbg_write(ptr, nb);
+}
+
+static int xmon_readchar(void)
+{
+	if (udbg_getc)
+		return udbg_getc();
+	return -1;
+}
+
 int xmon_putchar(int c)
 {
 	char ch = c;
diff --git a/arch/powerpc/xmon/nonstdio.h b/arch/powerpc/xmon/nonstdio.h
index 321284f..18a51de 100644
--- a/arch/powerpc/xmon/nonstdio.h
+++ b/arch/powerpc/xmon/nonstdio.h
@@ -7,5 +7,3 @@ extern int xmon_putchar(int c);
 extern void xmon_puts(const char *);
 extern char *xmon_gets(char *, int);
 extern void xmon_printf(const char *, ...);
-extern int xmon_write(const void *ptr, int nb);
-extern int xmon_readchar(void);
diff --git a/arch/powerpc/xmon/start.c b/arch/powerpc/xmon/start.c
deleted file mode 100644
index 7769cb5..0000000
--- a/arch/powerpc/xmon/start.c
+++ /dev/null
@@ -1,23 +0,0 @@
-/*
- * Copyright (C) 1996 Paul Mackerras.
- *
- *      This program is free software; you can redistribute it and/or
- *      modify it under the terms of the GNU General Public License
- *      as published by the Free Software Foundation; either version
- *      2 of the License, or (at your option) any later version.
- */
-#include <asm/machdep.h>
-#include <asm/udbg.h>
-#include "nonstdio.h"
-
-int xmon_write(const void *ptr, int nb)
-{
-	return udbg_write(ptr, nb);
-}
-
-int xmon_readchar(void)
-{
-	if (udbg_getc)
-		return udbg_getc();
-	return -1;
-}
-- 
1.7.9.5
