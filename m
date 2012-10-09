Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 04/20] powerpc/xmon: Make xmon_getchar() static
Date: Wed, 10 Oct 2012 01:20:31 +1100
Message-Id: <1349792447-15714-4-git-send-email-michael@ellerman.id.au>
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

xmon_getchar() is only called from within nonstdio.c, so make it static.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/xmon/nonstdio.c |    2 +-
 arch/powerpc/xmon/nonstdio.h |    1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/xmon/nonstdio.c b/arch/powerpc/xmon/nonstdio.c
index a225d80..2209485 100644
--- a/arch/powerpc/xmon/nonstdio.c
+++ b/arch/powerpc/xmon/nonstdio.c
@@ -23,7 +23,7 @@ static char line[256];
 static char *lineptr;
 static int lineleft;
 
-int xmon_getchar(void)
+static int xmon_getchar(void)
 {
 	int c;
 
diff --git a/arch/powerpc/xmon/nonstdio.h b/arch/powerpc/xmon/nonstdio.h
index 8799ccf..321284f 100644
--- a/arch/powerpc/xmon/nonstdio.h
+++ b/arch/powerpc/xmon/nonstdio.h
@@ -4,7 +4,6 @@
 #define putchar	xmon_putchar
 
 extern int xmon_putchar(int c);
-extern int xmon_getchar(void);
 extern void xmon_puts(const char *);
 extern char *xmon_gets(char *, int);
 extern void xmon_printf(const char *, ...);
-- 
1.7.9.5
