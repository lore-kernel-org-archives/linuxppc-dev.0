Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from inet-tsb5.toshiba.co.jp (inet-tsb5.toshiba.co.jp [202.33.96.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2F970DDE9A
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Jul 2007 12:57:50 +1000 (EST)
Date: Wed, 25 Jul 2007 11:57:35 +0900 (JST)
Message-Id: <200707250257.l6P2va65006958@toshiba.co.jp>
Subject: [PATCH] xmon consistency clean up
To: paulus@samba.org
From: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch cleans up xmon to keep consistency.

In xmon, we should use console I/O functions that are named the same
as user space stdio functions. But commit
4d404edce30f911004850d472e05a31efd751662 broke this consistency.

Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
---

Index: linux-powerpc-git/arch/powerpc/xmon/nonstdio.c
===================================================================
--- linux-powerpc-git.orig/arch/powerpc/xmon/nonstdio.c
+++ linux-powerpc-git/arch/powerpc/xmon/nonstdio.c
@@ -133,7 +133,7 @@ void xmon_printf(const char *format, ...
 	xmon_write(xmon_outbuf, n);
 }
 
-void xmon_puts(const char *str)
+void xmon_fputs(const char *str)
 {
 	xmon_write(str, strlen(str));
 }
Index: linux-powerpc-git/arch/powerpc/xmon/nonstdio.h
===================================================================
--- linux-powerpc-git.orig/arch/powerpc/xmon/nonstdio.h
+++ linux-powerpc-git/arch/powerpc/xmon/nonstdio.h
@@ -2,10 +2,11 @@
 
 #define printf	xmon_printf
 #define putchar	xmon_putchar
+#define fputs(str,stream)	xmon_fputs(str)	/* stream is ignored. */
 
 extern int xmon_putchar(int c);
 extern int xmon_getchar(void);
-extern void xmon_puts(const char *);
+extern void xmon_fputs(const char *);
 extern char *xmon_gets(char *, int);
 extern void xmon_printf(const char *, ...);
 extern void xmon_map_scc(void);
Index: linux-powerpc-git/arch/powerpc/xmon/xmon.c
===================================================================
--- linux-powerpc-git.orig/arch/powerpc/xmon/xmon.c
+++ linux-powerpc-git/arch/powerpc/xmon/xmon.c
@@ -833,7 +833,7 @@ cmds(struct pt_regs *excp)
 			mdelay(2000);
 			return cmd;
 		case '?':
-			xmon_puts(help_string);
+			fputs(help_string, stdout);
 			break;
 		case 'b':
 			bpt_cmds();
