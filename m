Return-Path: <miltonm@sullivan.realtime.net>
Received: from sullivan.realtime.net (sullivan.realtime.net [205.238.132.226])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 45E29DE002
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Mar 2007 08:06:52 +1100 (EST)
Date: Mon, 19 Mar 2007 14:58:06 -0600 (CST)
Subject: [PATCH 7/7] boot: export flush_cache
From: Milton Miller <miltonm@bga.com>
Sender: <miltonm@realtime.net>
To: linuxppc-dev@ozlabs.org
In-Reply-To: <boot-00.miltonm@bga.com>
Message-Id: <boot-07.miltonm@bga.com>
Cc: Paul Mackerras <paulus@samba.org>
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
--- 
Compiles and links with user, and that is the purpose.
 main.c |    2 --
 ops.h  |    2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

Index: kernel/arch/powerpc/boot/main.c
===================================================================
--- kernel.orig/arch/powerpc/boot/main.c	2007-03-19 04:16:06.000000000 -0500
+++ kernel/arch/powerpc/boot/main.c	2007-03-19 04:16:56.000000000 -0500
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
--- kernel.orig/arch/powerpc/boot/ops.h	2007-03-19 04:16:06.000000000 -0500
+++ kernel/arch/powerpc/boot/ops.h	2007-03-19 04:30:38.000000000 -0500
@@ -79,7 +79,7 @@ int serial_console_init(void);
 int ns16550_console_init(void *devp, struct serial_console_data *scdp);
 void *simple_alloc_init(char *base, u32 heap_size, u32 granularity,
 		u32 max_allocs);
-
+extern void flush_cache(void *, unsigned long);
 
 static inline void *finddevice(const char *name)
 {
