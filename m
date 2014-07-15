Return-Path: <bernat@luffy.cx>
Received: from bart.luffy.cx (unknown [IPv6:2a01:4f8:130:64e3::7])
 (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DB39B1A0157
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 17:38:23 +1000 (EST)
From: Vincent Bernat <vincent@bernat.im>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] ppc/xmon: use isxdigit/isspace/isalnum from ctype.h
Date: Tue, 15 Jul 2014 09:28:22 +0200
Message-Id: <1405409302-5299-1-git-send-email-vincent@bernat.im>
Cc: Vincent Bernat <vincent@bernat.im>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use linux/ctype.h instead of defining custom versions of
isxdigit/isspace/isalnum.

Signed-off-by: Vincent Bernat <vincent@bernat.im>
---
 arch/powerpc/xmon/xmon.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index d199bfa2f1fa..c0c31a47c469 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -24,6 +24,7 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/bug.h>
+#include <linux/ctype.h>
 
 #include <asm/ptrace.h>
 #include <asm/string.h>
@@ -177,14 +178,6 @@ extern void xmon_leave(void);
 #define GETWORD(v)	(((v)[0] << 24) + ((v)[1] << 16) + ((v)[2] << 8) + (v)[3])
 #endif
 
-#define isxdigit(c)	(('0' <= (c) && (c) <= '9') \
-			 || ('a' <= (c) && (c) <= 'f') \
-			 || ('A' <= (c) && (c) <= 'F'))
-#define isalnum(c)	(('0' <= (c) && (c) <= '9') \
-			 || ('a' <= (c) && (c) <= 'z') \
-			 || ('A' <= (c) && (c) <= 'Z'))
-#define isspace(c)	(c == ' ' || c == '\t' || c == 10 || c == 13 || c == 0)
-
 static char *help_string = "\
 Commands:\n\
   b	show breakpoints\n\
@@ -2121,9 +2114,6 @@ static void dump_pacas(void)
 }
 #endif
 
-#define isxdigit(c)	(('0' <= (c) && (c) <= '9') \
-			 || ('a' <= (c) && (c) <= 'f') \
-			 || ('A' <= (c) && (c) <= 'F'))
 static void
 dump(void)
 {
-- 
2.0.1
