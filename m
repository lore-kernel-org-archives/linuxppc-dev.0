Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id 42895DED46
	for <linuxppc-dev@ozlabs.org>; Sat, 24 May 2008 01:58:29 +1000 (EST)
Subject: [PATCH]: Check that TASK_SIZE does not overlap KERNEL_START
To: <linuxppc-dev@ozlabs.org>
Message-Id: <20080523155915.9ABF15AF36@innovsys.com>
Date: Fri, 23 May 2008 10:59:15 -0500 (CDT)
From: runet@innovsys.com (Rune Torgersen)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Make sure CONFIG_TASK_SIZE does not overlap CONFIG_KERNEL_START
This could happen when overriding settings to get 1GB lowmem, and would lead
to userland mysteriousely hanging.

This setting is only used by PPC32.

Signed-off-by Rune Torgersen <runet@innovsys.com>

diff --git a/include/asm-powerpc/processor.h b/include/asm-powerpc/processor.h
index fd98ca9..72e0e3f 100644
--- a/include/asm-powerpc/processor.h
+++ b/include/asm-powerpc/processor.h
@@ -81,6 +81,10 @@ extern struct task_struct *last_task_used_altivec;
 extern struct task_struct *last_task_used_spe;
 
 #ifdef CONFIG_PPC32
+
+#if CONFIG_TASK_SIZE > CONFIG_KERNEL_START
+#error User TASK_SIZE overlaps with KERNEL_START address
+#endif
 #define TASK_SIZE	(CONFIG_TASK_SIZE)
 
 /* This decides where the kernel will search for a free chunk of vm
