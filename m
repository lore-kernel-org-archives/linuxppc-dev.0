Return-Path: <gorcunov@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.172])
	by ozlabs.org (Postfix) with ESMTP id DE2FEDDF26
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Feb 2008 08:00:41 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id q7so523927uge.0
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Feb 2008 13:00:41 -0800 (PST)
Message-Id: <20080227210003.720942920@gmail.com>
References: <20080227205831.150784453@gmail.com>
Date: Wed, 27 Feb 2008 23:58:37 +0300
From: gorcunov@gmail.com
To: rth@twiddle.net, chris@zankel.net, jdike@addtoit.com,
	linuxppc-dev@ozlabs.org, paulus@samba.org, dhowells@redhat.com,
	zippel@linux-m68k.org, geert@linux-m68k.org,
	linux-m68k@lists.linux-m68k.org, takata@linux-m32r.org,
	linux-m32r@ml.linux-m32r.org, linux-kernel@vger.kernel.org
Subject: [RFC 06/10] powerpc: vmlinux.lds.S cleanup - use PERCPU,
	THREAD_SIZE macroses
Cc: gorcunov@gmail.com, sam@ravnborg.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch includes  thread_info.h header into liker script that
allow us to use THREAD_SIZE macro instead of numeric constant

Also PERCPU macro is used instead of explicit section definition

Signed-off-by: Cyrill Gorcunov <gorcunov@gmail.com>
---

WARNING: COMPLETELY UNTESTED !!!

 vmlinux.lds.S |   16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

Index: linux-2.6.git/arch/powerpc/kernel/vmlinux.lds.S
===================================================================
--- linux-2.6.git.orig/arch/powerpc/kernel/vmlinux.lds.S	2008-01-29 18:03:46.000000000 +0300
+++ linux-2.6.git/arch/powerpc/kernel/vmlinux.lds.S	2008-02-27 21:33:53.000000000 +0300
@@ -8,6 +8,7 @@
 #endif
 #include <asm-generic/vmlinux.lds.h>
 #include <asm/cache.h>
+#include <asm/thread_info.h>
 
 ENTRY(_stext)
 
@@ -145,13 +146,8 @@ SECTIONS
 		__initramfs_end = .;
 	}
 #endif
-	. = ALIGN(PAGE_SIZE);
-	.data.percpu : {
-		__per_cpu_start = .;
-		*(.data.percpu)
-		*(.data.percpu.shared_aligned)
-		__per_cpu_end = .;
-	}
+
+	PERCPU(PAGE_SIZE)
 
 	. = ALIGN(8);
 	.machine.desc : {
@@ -202,11 +198,7 @@ SECTIONS
 	PROVIDE32 (edata = .);
 
 	/* The initial task and kernel stack */
-#ifdef CONFIG_PPC32
-	. = ALIGN(8192);
-#else
-	. = ALIGN(16384);
-#endif
+	. = ALIGN(THREAD_SIZE);
 	.data.init_task : {
 		*(.data.init_task)
 	}

-- 
