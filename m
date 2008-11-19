Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (xc.sipsolutions.net [83.246.72.84])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A9EE5DDDFB
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Nov 2008 22:49:20 +1100 (EST)
Subject: [PATCH v2] powerpc: allow configuring max stack dump depth
From: Johannes Berg <johannes@sipsolutions.net>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <18723.38125.245930.196074@cargo.ozlabs.ibm.com>
References: <1225534317.3560.8.camel@johannes.berg>
	<18723.38125.245930.196074@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Wed, 19 Nov 2008 12:48:38 +0100
Message-Id: <1227095318.26243.17.camel@johannes.berg>
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
Sure, here's an updated version. I used DEBUG_KERNEL since the
ADVANCED_CONFIGURATION help text implies it's for MM and can cause the
kernel to not boot, not something this config is related to.

Thanks for your comments.

 arch/powerpc/Kconfig.debug    |   10 ++++++++++
 arch/powerpc/kernel/process.c |    2 +-
 2 files changed, 11 insertions(+), 1 deletion(-)

--- everything.orig/arch/powerpc/Kconfig.debug	2008-11-19 01:13:16.000000000 +0100
+++ everything/arch/powerpc/Kconfig.debug	2008-11-19 12:47:24.000000000 +0100
@@ -2,6 +2,16 @@ menu "Kernel hacking"
 
 source "lib/Kconfig.debug"
 
+config PRINT_STACK_DEPTH
+	int "Stack depth to print"
+	depends on DEBUG_KERNEL
+	default 64
+	help
+	  This option allows you to set the stack depth that the kernel
+	  prints in stack traces. This can be useful if your display is
+	  too small and stack traces cause important information to
+	  scroll off the screen.
+
 config DEBUG_STACKOVERFLOW
 	bool "Check for stack overflows"
 	depends on DEBUG_KERNEL
--- everything.orig/arch/powerpc/kernel/process.c	2008-11-19 01:13:16.000000000 +0100
+++ everything/arch/powerpc/kernel/process.c	2008-11-19 12:45:28.000000000 +0100
@@ -998,7 +998,7 @@ unsigned long get_wchan(struct task_stru
 	return 0;
 }
 
-static int kstack_depth_to_print = 64;
+static int kstack_depth_to_print = CONFIG_PRINT_STACK_DEPTH;
 
 void show_stack(struct task_struct *tsk, unsigned long *stack)
 {
