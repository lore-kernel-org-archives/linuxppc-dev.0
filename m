Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id F38A4DDF42
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jul 2007 03:03:49 +1000 (EST)
Message-Id: <20070705170238.888212000@lixom.net>
References: <20070705170233.258351000@lixom.net>
Date: Thu, 05 Jul 2007 12:02:53 -0500
From: Olof Johansson <olof@lixom.net>
To: linuxppc-dev@ozlabs.org
Subject: [patch 20/35] Remove idle_spin function pointer
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Remove idle_spin function pointer, since it just seems to make the idle
loop run hotter by doing bl/blr.

Index: 2.6.21/arch/powerpc/platforms/pasemi/idle.c
===================================================================
--- 2.6.21.orig/arch/powerpc/platforms/pasemi/idle.c
+++ 2.6.21/arch/powerpc/platforms/pasemi/idle.c
@@ -34,7 +34,7 @@ struct sleep_mode {
 };
 
 static struct sleep_mode modes[] = {
-	{ .name = "spin", .entry = &idle_spin },
+	{ .name = "spin", .entry = NULL },
 	{ .name = "doze", .entry = &idle_doze },
 };
 
Index: 2.6.21/arch/powerpc/platforms/pasemi/powersave.S
===================================================================
--- 2.6.21.orig/arch/powerpc/platforms/pasemi/powersave.S
+++ 2.6.21/arch/powerpc/platforms/pasemi/powersave.S
@@ -49,9 +49,6 @@ _doze:
 	b	.
 
 
-_GLOBAL(idle_spin)
-	blr
-
 _GLOBAL(idle_doze)
 	LOAD_REG_ADDR(r3, _doze)
 	b	sleep_common

--
