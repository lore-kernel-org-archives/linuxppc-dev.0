Return-Path: <gorcunov@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.173])
	by ozlabs.org (Postfix) with ESMTP id B48B8DDF39
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Feb 2008 08:00:41 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id q7so523934uge.0
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Feb 2008 13:00:41 -0800 (PST)
Message-Id: <20080227210004.611037191@gmail.com>
References: <20080227205831.150784453@gmail.com>
Date: Wed, 27 Feb 2008 23:58:41 +0300
From: gorcunov@gmail.com
To: rth@twiddle.net, chris@zankel.net, jdike@addtoit.com,
	linuxppc-dev@ozlabs.org, paulus@samba.org, dhowells@redhat.com,
	zippel@linux-m68k.org, geert@linux-m68k.org,
	linux-m68k@lists.linux-m68k.org, takata@linux-m32r.org,
	linux-m32r@ml.linux-m32r.org, linux-kernel@vger.kernel.org
Subject: [RFC 10/10] xtensa: vmlinux.lds.S - use PAGE_SIZE,
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

This patch includes page.h and thread_info.h headers into the linker
script that allow us to use PAGE_SIZE and THREAD_SIZE macroses
instead of numeric constants

Also a few spaces removed

Signed-off-by: Cyrill Gorcunov <gorcunov@gmail.com>
---

WARNING: COMPLETELY UNTESTED !!!

 vmlinux.lds.S |   19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

Index: linux-2.6.git/arch/xtensa/kernel/vmlinux.lds.S
===================================================================
--- linux-2.6.git.orig/arch/xtensa/kernel/vmlinux.lds.S	2008-02-26 21:45:46.000000000 +0300
+++ linux-2.6.git/arch/xtensa/kernel/vmlinux.lds.S	2008-02-27 22:15:04.000000000 +0300
@@ -15,6 +15,8 @@
  */
 
 #include <asm-generic/vmlinux.lds.h>
+#include <asm/page.h>
+#include <asm/thread_info.h>
 
 #include <asm/variant/core.h>
 OUTPUT_ARCH(xtensa)
@@ -127,16 +129,16 @@ SECTIONS
   _edata = .;
 
   /* The initial task */
-  . = ALIGN(8192);
+  . = ALIGN(THREAD_SIZE);
   .data.init_task : { *(.data.init_task) }
 
   /* Initialization code and data: */
 
-  . = ALIGN(1 << 12);
+  . = ALIGN(PAGE_SIZE);
   __init_begin = .;
   .init.text : {
   	_sinittext = .;
-	*(.init.literal) *(.cpuinit.literal) 
+	*(.init.literal) *(.cpuinit.literal)
 	*(.devinit.literal) *(.meminit.literal)
 	INIT_TEXT
 	_einittext = .;
@@ -165,7 +167,7 @@ SECTIONS
 		   .DoubleExceptionVector.text);
     RELOCATE_ENTRY(_DebugInterruptVector_text,
 		   .DebugInterruptVector.text);
-  
+
     __boot_reloc_table_end = ABSOLUTE(.) ;
   }
 
@@ -189,14 +191,13 @@ SECTIONS
 
 
 #ifdef CONFIG_BLK_DEV_INITRD
-  . = ALIGN(4096);
+  . = ALIGN(PAGE_SIZE);
   __initramfs_start =.;
   .init.ramfs : { *(.init.ramfs) }
   __initramfs_end = .;
 #endif
 
-  PERCPU(4096)
-
+  PERCPU(PAGE_SIZE)
 
   /* We need this dummy segment here */
 
@@ -251,7 +252,7 @@ SECTIONS
 		  .DoubleExceptionVector.literal)
 
   . = (LOADADDR( .DoubleExceptionVector.text ) + SIZEOF( .DoubleExceptionVector.text ) + 3) & ~ 3;
-  . = ALIGN(1 << 12);
+  . = ALIGN(PAGE_SIZE);
 
   __init_end = .;
 
@@ -269,7 +270,7 @@ SECTIONS
   . = ALIGN(0x10);
   .bootstrap : { *(.bootstrap.literal .bootstrap.text .bootstrap.data) }
 
-  . = ALIGN(0x1000);
+  . = ALIGN(PAGE_SIZE);
   __initrd_start = .;
   .initrd : { *(.initrd) }
   __initrd_end = .;

-- 
