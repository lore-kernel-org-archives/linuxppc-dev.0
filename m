Return-Path: <bernat@luffy.cx>
Received: from bart.luffy.cx (unknown [IPv6:2a01:4f8:130:64e3::7])
 (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3E15F1A014E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 21:44:13 +1000 (EST)
From: Vincent Bernat <vincent@bernat.im>
To: David Laight <David.Laight@ACULAB.COM>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] ppc/xmon: use isspace/isxdigit/isalnum from linux/ctype.h
Date: Tue, 15 Jul 2014 13:43:47 +0200
Message-Id: <1405424627-31411-1-git-send-email-vincent@bernat.im>
In-Reply-To: <m3pph7x8pg.fsf@neo.luffy.cx>
References: <m3pph7x8pg.fsf@neo.luffy.cx>
Cc: Vincent Bernat <vincent@bernat.im>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

isxdigit() macro definition is the same.

isalnum() from linux/ctype.h will accept additional latin non-ASCII
characters. This is harmless since this macro is used in scanhex() which
parses user input.

isspace() from linux/ctype.h will accept vertical tab and form feed but
not NULL. The use of this macro is modified to accept NULL as
well. Additional characters are harmless since this macro is also only
used in scanhex().

Signed-off-by: Vincent Bernat <vincent@bernat.im>
---
 arch/powerpc/xmon/xmon.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index d199bfa2f1fa..55d9b48774b7 100644
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
@@ -2526,7 +2516,7 @@ scanhex(unsigned long *vp)
 		int i;
 		for (i=0; i<63; i++) {
 			c = inchar();
-			if (isspace(c)) {
+			if (isspace(c) || c == '\0') {
 				termch = c;
 				break;
 			}
-- 
2.0.1
