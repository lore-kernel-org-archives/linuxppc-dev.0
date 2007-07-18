Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from inet-tsb5.toshiba.co.jp (inet-tsb5.toshiba.co.jp [202.33.96.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1B4A9DDD0B
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 19:26:53 +1000 (EST)
Date: Wed, 18 Jul 2007 18:26:40 +0900 (JST)
Message-Id: <20070718.182640.-1300542340.kouish@swc.toshiba.co.jp>
Subject: [PATCH 2/2] fix showing xmon help
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

In some configuration, xmon help string is larger than xmon_printf
buffer. We need not to use printf.  This patch adds xmon_puts and
change to use it to show help string.

Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
---

This patch depends on [PATCH 1/2].


Index: linux-powerpc-git/arch/powerpc/xmon/nonstdio.h
===================================================================
--- linux-powerpc-git.orig/arch/powerpc/xmon/nonstdio.h
+++ linux-powerpc-git/arch/powerpc/xmon/nonstdio.h
@@ -5,6 +5,7 @@
 
 extern int xmon_putchar(int c);
 extern int xmon_getchar(void);
+extern void xmon_puts(const char *);
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
-			printf(help_string);
+			xmon_puts(help_string);
 			break;
 		case 'b':
 			bpt_cmds();
Index: linux-powerpc-git/arch/powerpc/xmon/nonstdio.c
===================================================================
--- linux-powerpc-git.orig/arch/powerpc/xmon/nonstdio.c
+++ linux-powerpc-git/arch/powerpc/xmon/nonstdio.c
@@ -132,3 +132,8 @@ void xmon_printf(const char *format, ...
 	va_end(args);
 	xmon_write(xmon_outbuf, n);
 }
+
+void xmon_puts(const char *str)
+{
+	xmon_write(str, strlen(str));
+}
