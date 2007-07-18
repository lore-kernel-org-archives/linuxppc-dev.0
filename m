Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2E0C1DDE23
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 19:30:47 +1000 (EST)
Date: Wed, 18 Jul 2007 18:30:29 +0900 (JST)
Message-Id: <20070718.183029.-432835271.kouish@swc.toshiba.co.jp>
Subject: [PATCH 1/2] Make xmon_write accept a const buffer
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

Because xmon_write doesn't change the buffer, we should add 'const'
qualifier to the argument which points it.

Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
---

Index: linux-powerpc-git/arch/powerpc/xmon/start.c
===================================================================
--- linux-powerpc-git.orig/arch/powerpc/xmon/start.c
+++ linux-powerpc-git/arch/powerpc/xmon/start.c
@@ -14,7 +14,7 @@ void xmon_map_scc(void)
 {
 }
 
-int xmon_write(void *ptr, int nb)
+int xmon_write(const void *ptr, int nb)
 {
 	return udbg_write(ptr, nb);
 }
Index: linux-powerpc-git/arch/powerpc/xmon/nonstdio.h
===================================================================
--- linux-powerpc-git.orig/arch/powerpc/xmon/nonstdio.h
+++ linux-powerpc-git/arch/powerpc/xmon/nonstdio.h
@@ -9,6 +9,6 @@ extern char *xmon_gets(char *, int);
 extern void xmon_printf(const char *, ...);
 extern void xmon_map_scc(void);
 extern int xmon_expect(const char *str, unsigned long timeout);
-extern int xmon_write(void *ptr, int nb);
+extern int xmon_write(const void *ptr, int nb);
 extern int xmon_readchar(void);
 extern int xmon_read_poll(void);
