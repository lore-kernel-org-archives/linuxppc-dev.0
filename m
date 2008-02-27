Return-Path: <gorcunov@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.174])
	by ozlabs.org (Postfix) with ESMTP id C0ABFDDEE1
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Feb 2008 08:00:36 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id q7so523929uge.0
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Feb 2008 13:00:34 -0800 (PST)
Message-Id: <20080227210002.959847618@gmail.com>
References: <20080227205831.150784453@gmail.com>
Date: Wed, 27 Feb 2008 23:58:34 +0300
From: gorcunov@gmail.com
To: rth@twiddle.net, chris@zankel.net, jdike@addtoit.com,
	linuxppc-dev@ozlabs.org, paulus@samba.org, dhowells@redhat.com,
	zippel@linux-m68k.org, geert@linux-m68k.org,
	linux-m68k@lists.linux-m68k.org, takata@linux-m32r.org,
	linux-m32r@ml.linux-m32r.org, linux-kernel@vger.kernel.org
Subject: [RFC 03/10] m68k: vmlinux-std/sun3.lds.S cleanup - use PAGE_SIZE macro
Cc: gorcunov@gmail.com, sam@ravnborg.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch includes page.h header into liker script that
allow us to use PAGE_SIZE macro instead of numeric constant

Signed-off-by: Cyrill Gorcunov <gorcunov@gmail.com>
---

WARNING: COMPLETELY UNTESTED !!!

 vmlinux-std.lds  |    3 ++-
 vmlinux-sun3.lds |    7 ++++---
 2 files changed, 6 insertions(+), 4 deletions(-)

Index: linux-2.6.git/arch/m68k/kernel/vmlinux-std.lds
===================================================================
--- linux-2.6.git.orig/arch/m68k/kernel/vmlinux-std.lds	2008-01-29 18:03:46.000000000 +0300
+++ linux-2.6.git/arch/m68k/kernel/vmlinux-std.lds	2008-02-27 21:13:29.000000000 +0300
@@ -1,6 +1,7 @@
 /* ld script to make m68k Linux kernel */
 
 #include <asm-generic/vmlinux.lds.h>
+#include <asm/page.h>
 
 OUTPUT_FORMAT("elf32-m68k", "elf32-m68k", "elf32-m68k")
 OUTPUT_ARCH(m68k)
@@ -41,7 +42,7 @@ SECTIONS
   _edata = .;			/* End of data section */
 
   /* will be freed after init */
-  . = ALIGN(4096);		/* Init code and data */
+  . = ALIGN(PAGE_SIZE);		/* Init code and data */
   __init_begin = .;
   .init.text : {
 	_sinittext = .;
Index: linux-2.6.git/arch/m68k/kernel/vmlinux-sun3.lds
===================================================================
--- linux-2.6.git.orig/arch/m68k/kernel/vmlinux-sun3.lds	2008-01-29 18:03:46.000000000 +0300
+++ linux-2.6.git/arch/m68k/kernel/vmlinux-sun3.lds	2008-02-27 21:13:51.000000000 +0300
@@ -1,6 +1,7 @@
 /* ld script to make m68k Linux kernel */
 
 #include <asm-generic/vmlinux.lds.h>
+#include <asm/page.h>
 
 OUTPUT_FORMAT("elf32-m68k", "elf32-m68k", "elf32-m68k")
 OUTPUT_ARCH(m68k)
@@ -34,7 +35,7 @@ SECTIONS
   _edata = .;
 
   /* will be freed after init */
-  . = ALIGN(8192);	/* Init code and data */
+  . = ALIGN(PAGE_SIZE);	/* Init code and data */
 __init_begin = .;
 	.init.text : {
 		_sinittext = .;
@@ -61,12 +62,12 @@ __init_begin = .;
 	}
 	SECURITY_INIT
 #ifdef CONFIG_BLK_DEV_INITRD
-	. = ALIGN(8192);
+	. = ALIGN(PAGE_SIZE);
 	__initramfs_start = .;
 	.init.ramfs : { *(.init.ramfs) }
 	__initramfs_end = .;
 #endif
-	. = ALIGN(8192);
+	. = ALIGN(PAGE_SIZE);
 	__init_end = .;
 	.data.init.task : { *(.data.init_task) }
 

-- 
