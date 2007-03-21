Return-Path: <miltonm@sullivan.realtime.net>
Received: from sullivan.realtime.net (sullivan.realtime.net [205.238.132.226])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C7EF3DE0B2
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Mar 2007 02:03:09 +1100 (EST)
Received: from sullivan.realtime.net (localhost [127.0.0.1])
	by sullivan.realtime.net (8.13.1/8.9.3) with ESMTP id l2LF36qU008518
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Mar 2007 09:03:06 -0600 (CST)
	(envelope-from miltonm@sullivan.realtime.net)
Received: (from miltonm@localhost)
	by sullivan.realtime.net (8.13.1/8.12.7/Submit) id l2LF36jj008517
	for linuxppc-dev@ozlabs.org; Wed, 21 Mar 2007 09:03:06 -0600 (CST)
Date: Wed, 21 Mar 2007 09:03:06 -0600 (CST)
Subject: [PATCH 4/8] boot: export flush_cache
Sender: <miltonm@realtime.net>
From: Milton Miller <miltonm@bga.com>
To: linuxppc-dev@ozlabs.org
Message-Id: <boot-2-04.miltonm@bga.com>
In-Reply-To: <boot-2-00.miltonm@bga.com>
Cc: Paul Mackerras <paulus@samba.org>, david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Move the declaration of flush_cache to ops.h for use by platform code.

Signed-off-by: Milton Miller <miltonm@bga.com>
--
Compiles and links with user, and that is the purpose.

Index: kernel/arch/powerpc/boot/main.c
===================================================================
--- kernel.orig/arch/powerpc/boot/main.c	2007-03-21 02:13:49.000000000 -0500
+++ kernel/arch/powerpc/boot/main.c	2007-03-21 02:15:06.000000000 -0500
@@ -18,8 +18,6 @@
 #include "gunzip_util.h"
 #include "flatdevtree.h"
 
-extern void flush_cache(void *, unsigned long);
-
 extern char _start[];
 extern char __bss_start[];
 extern char _end[];
Index: kernel/arch/powerpc/boot/ops.h
===================================================================
--- kernel.orig/arch/powerpc/boot/ops.h	2007-03-21 02:13:49.000000000 -0500
+++ kernel/arch/powerpc/boot/ops.h	2007-03-21 02:15:06.000000000 -0500
@@ -72,7 +72,7 @@ int serial_console_init(void);
 int ns16550_console_init(void *devp, struct serial_console_data *scdp);
 void *simple_alloc_init(char *base, u32 heap_size, u32 granularity,
 		u32 max_allocs);
-
+extern void flush_cache(void *, unsigned long);
 
 static inline void *finddevice(const char *name)
 {
