Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (xc.sipsolutions.net [83.246.72.84])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7BAD7DDDEF
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Nov 2008 21:12:03 +1100 (EST)
Subject: [PATCH] powerpc: allow configuring max stack dump depth
From: Johannes Berg <johannes@sipsolutions.net>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Date: Sat, 01 Nov 2008 11:11:57 +0100
Message-Id: <1225534317.3560.8.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On my screen, when something crashes, I only have space for maybe
16 functions of the stack trace before the information above it
scrolls off the screen. It's easy to hack the kernel to print out
only that much, but it's harder to remember to do it. This patch
introduces a config option for it so that I can keep the setting
in my config.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
---
 arch/powerpc/Kconfig.debug    |    7 +++++++
 arch/powerpc/kernel/process.c |    2 +-
 2 files changed, 8 insertions(+), 1 deletion(-)

--- everything.orig/arch/powerpc/Kconfig.debug	2008-11-01 11:03:29.000000000 +0100
+++ everything/arch/powerpc/Kconfig.debug	2008-11-01 11:05:45.000000000 +0100
@@ -2,6 +2,13 @@ menu "Kernel hacking"
 
 source "lib/Kconfig.debug"
 
+config PRINT_STACK_DEPTH
+	int "Stack depth to print"
+	default 64
+	help
+	  This option allows you to set the stack depth that the kernel
+	  prints out in case your display is too small.
+
 config DEBUG_STACKOVERFLOW
 	bool "Check for stack overflows"
 	depends on DEBUG_KERNEL
--- everything.orig/arch/powerpc/kernel/process.c	2008-11-01 11:03:09.000000000 +0100
+++ everything/arch/powerpc/kernel/process.c	2008-11-01 11:03:21.000000000 +0100
@@ -998,7 +998,7 @@ unsigned long get_wchan(struct task_stru
 	return 0;
 }
 
-static int kstack_depth_to_print = 64;
+static int kstack_depth_to_print = CONFIG_PRINT_STACK_DEPTH;
 
 void show_stack(struct task_struct *tsk, unsigned long *stack)
 {
