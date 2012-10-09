Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 01/20] powerpc/udbg: Remove unused udbg_read()
Date: Wed, 10 Oct 2012 01:20:28 +1100
Message-Id: <1349792447-15714-1-git-send-email-michael@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The last user of udbg_read() was removed in 2005, in commit fca5dcd
"Simplify and clean up the xmon terminal I/O".

Given we haven't needed it for 7 years we can probably drop it.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/include/asm/udbg.h |    1 -
 arch/powerpc/kernel/udbg.c      |   23 -----------------------
 2 files changed, 24 deletions(-)

diff --git a/arch/powerpc/include/asm/udbg.h b/arch/powerpc/include/asm/udbg.h
index b303881..5a7510e 100644
--- a/arch/powerpc/include/asm/udbg.h
+++ b/arch/powerpc/include/asm/udbg.h
@@ -21,7 +21,6 @@ extern int (*udbg_getc_poll)(void);
 
 extern void udbg_puts(const char *s);
 extern int udbg_write(const char *s, int n);
-extern int udbg_read(char *buf, int buflen);
 
 extern void register_early_udbg_console(void);
 extern void udbg_printf(const char *fmt, ...)
diff --git a/arch/powerpc/kernel/udbg.c b/arch/powerpc/kernel/udbg.c
index c39c1ca..f974849 100644
--- a/arch/powerpc/kernel/udbg.c
+++ b/arch/powerpc/kernel/udbg.c
@@ -122,29 +122,6 @@ int udbg_write(const char *s, int n)
 	return n - remain;
 }
 
-int udbg_read(char *buf, int buflen)
-{
-	char *p = buf;
-	int i, c;
-
-	if (!udbg_getc)
-		return 0;
-
-	for (i = 0; i < buflen; ++i) {
-		do {
-			c = udbg_getc();
-			if (c == -1 && i == 0)
-				return -1;
-
-		} while (c == 0x11 || c == 0x13);
-		if (c == 0 || c == -1)
-			break;
-		*p++ = c;
-	}
-
-	return i;
-}
-
 #define UDBG_BUFSIZE 256
 void udbg_printf(const char *fmt, ...)
 {
-- 
1.7.9.5
