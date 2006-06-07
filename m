Return-Path: <benh@au1.ibm.com>
Received: from ausmtp04.au.ibm.com (ausmtp04.au.ibm.com [202.81.18.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ausmtp04.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D496067B39
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Jun 2006 12:07:52 +1000 (EST)
Received: from sd0112e0.au.ibm.com (d23rh903.au.ibm.com [202.81.18.201])
	by ausmtp04.au.ibm.com (8.13.6/8.13.5) with ESMTP id k572Avxi268988
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Jun 2006 12:10:57 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.250.244])
	by sd0112e0.au.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k572B23G283720
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Jun 2006 12:11:03 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k5726bab026165
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Jun 2006 12:06:37 +1000
Subject: [PATCH] powerpc: Add udbg-immortal kernel option
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Date: Wed, 07 Jun 2006 12:06:20 +1000
Message-Id: <1149645981.27572.96.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

When debugging early kernel crashes that happen after console_init() and
before a proper console driver takes over, we often have to go hack into
udbg.c to prevent it from unregistering so we can "see" what is
happening. This patch adds a kernel command line option "udbg-immortal"
instead to avoid having to modify the kernel.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

---
Paul: this is not 2.6.17 material

Index: linux-work/arch/powerpc/kernel/udbg.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/udbg.c	2006-05-31 14:13:59.000000000 +1000
+++ linux-work/arch/powerpc/kernel/udbg.c	2006-05-31 14:48:07.000000000 +1000
@@ -14,6 +14,7 @@
 #include <linux/types.h>
 #include <linux/sched.h>
 #include <linux/console.h>
+#include <linux/init.h>
 #include <asm/processor.h>
 #include <asm/udbg.h>
 
@@ -141,12 +142,14 @@ static int early_console_initialized;
 
 void __init disable_early_printk(void)
 {
-#if 1
 	if (!early_console_initialized)
 		return;
+	if (strstr(saved_command_line, "udbg-immortal")) {
+		printk(KERN_INFO "early console immortal !\n");
+		return;
+	}
 	unregister_console(&udbg_console);
 	early_console_initialized = 0;
-#endif
 }
 
 /* called by setup_system */
