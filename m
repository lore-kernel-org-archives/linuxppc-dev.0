Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 02/20] powerpc/xmon: Remove unused xmon_expect() &
 xmon_read_poll()
Date: Wed, 10 Oct 2012 01:20:29 +1100
Message-Id: <1349792447-15714-2-git-send-email-michael@ellerman.id.au>
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

It looks like xmon_expect() was used for doing xmon over a modem (!?),
that code was dropped in 2005 in commit 51d3082 "Unify udbg (#2)".

Once xmon_expect() is gone xmon_read_poll() is unused, drop it too.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/xmon/nonstdio.c |   27 ---------------------------
 arch/powerpc/xmon/nonstdio.h |    2 --
 arch/powerpc/xmon/start.c    |    7 -------
 3 files changed, 36 deletions(-)

diff --git a/arch/powerpc/xmon/nonstdio.c b/arch/powerpc/xmon/nonstdio.c
index bfac84f..a225d80 100644
--- a/arch/powerpc/xmon/nonstdio.c
+++ b/arch/powerpc/xmon/nonstdio.c
@@ -23,33 +23,6 @@ static char line[256];
 static char *lineptr;
 static int lineleft;
 
-int xmon_expect(const char *str, unsigned long timeout)
-{
-	int c;
-	unsigned long t0;
-
-	/* assume 25MHz default timebase if tb_ticks_per_sec not set yet */
-	timeout *= tb_ticks_per_sec? tb_ticks_per_sec: 25000000;
-	t0 = get_tbl();
-	do {
-		lineptr = line;
-		for (;;) {
-			c = xmon_read_poll();
-			if (c == -1) {
-				if (get_tbl() - t0 > timeout)
-					return 0;
-				continue;
-			}
-			if (c == '\n')
-				break;
-			if (c != '\r' && lineptr < &line[sizeof(line) - 1])
-				*lineptr++ = c;
-		}
-		*lineptr = 0;
-	} while (strstr(line, str) == NULL);
-	return 1;
-}
-
 int xmon_getchar(void)
 {
 	int c;
diff --git a/arch/powerpc/xmon/nonstdio.h b/arch/powerpc/xmon/nonstdio.h
index 23dd95f..d8cec38 100644
--- a/arch/powerpc/xmon/nonstdio.h
+++ b/arch/powerpc/xmon/nonstdio.h
@@ -9,7 +9,5 @@ extern void xmon_puts(const char *);
 extern char *xmon_gets(char *, int);
 extern void xmon_printf(const char *, ...);
 extern void xmon_map_scc(void);
-extern int xmon_expect(const char *str, unsigned long timeout);
 extern int xmon_write(const void *ptr, int nb);
 extern int xmon_readchar(void);
-extern int xmon_read_poll(void);
diff --git a/arch/powerpc/xmon/start.c b/arch/powerpc/xmon/start.c
index 8864de2..84f3a15 100644
--- a/arch/powerpc/xmon/start.c
+++ b/arch/powerpc/xmon/start.c
@@ -25,10 +25,3 @@ int xmon_readchar(void)
 		return udbg_getc();
 	return -1;
 }
-
-int xmon_read_poll(void)
-{
-	if (udbg_getc_poll)
-		return udbg_getc_poll();
-	return -1;
-}
-- 
1.7.9.5
