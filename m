Return-Path: <gorcunov@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.175])
	by ozlabs.org (Postfix) with ESMTP id C813BDE057
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Feb 2008 08:00:40 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id q7so523930uge.0
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Feb 2008 13:00:34 -0800 (PST)
Message-Id: <20080227210002.625963228@gmail.com>
References: <20080227205831.150784453@gmail.com>
Date: Wed, 27 Feb 2008 23:58:33 +0300
From: gorcunov@gmail.com
To: rth@twiddle.net, chris@zankel.net, jdike@addtoit.com,
	linuxppc-dev@ozlabs.org, paulus@samba.org, dhowells@redhat.com,
	zippel@linux-m68k.org, geert@linux-m68k.org,
	linux-m68k@lists.linux-m68k.org, takata@linux-m32r.org,
	linux-m32r@ml.linux-m32r.org, linux-kernel@vger.kernel.org
Subject: [RFC 02/10] m32r: vmlinux.lds.S cleanup - use PAGE_SIZE,
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

This patch modifies PAGE_SIZE definition to be able to
include it in vmlinux.lds.S script and use it then

Also THREAD_SIZE macro is used to replace numeric constant

Signed-off-by: Cyrill Gorcunov <gorcunov@gmail.com>
---

WARNING: COMPLETELY UNTESTED !!!

 arch/m32r/kernel/vmlinux.lds.S |   19 ++++++++++---------
 include/asm-m32r/page.h        |    4 +++-
 2 files changed, 13 insertions(+), 10 deletions(-)

Index: linux-2.6.git/arch/m32r/kernel/vmlinux.lds.S
===================================================================
--- linux-2.6.git.orig/arch/m32r/kernel/vmlinux.lds.S	2008-02-21 22:26:02.000000000 +0300
+++ linux-2.6.git/arch/m32r/kernel/vmlinux.lds.S	2008-02-27 20:44:12.000000000 +0300
@@ -4,6 +4,7 @@
 #include <asm-generic/vmlinux.lds.h>
 #include <asm/addrspace.h>
 #include <asm/page.h>
+#include <asm/thread_info.h>
 
 OUTPUT_ARCH(m32r)
 #if defined(__LITTLE_ENDIAN__)
@@ -20,7 +21,7 @@ SECTIONS
   . = CONFIG_MEMORY_START + __PAGE_OFFSET;
   eit_vector = .;
 
-  . = . + 0x1000;
+  . = . + PAGE_SIZE;
   .empty_zero_page : { *(.empty_zero_page) } = 0
 
   /* read-only */
@@ -54,13 +55,13 @@ SECTIONS
 	CONSTRUCTORS
 	}
 
-  . = ALIGN(4096);
+  . = ALIGN(PAGE_SIZE);
   __nosave_begin = .;
   .data_nosave : { *(.data.nosave) }
-  . = ALIGN(4096);
+  . = ALIGN(PAGE_SIZE);
   __nosave_end = .;
 
-  . = ALIGN(4096);
+  . = ALIGN(PAGE_SIZE);
   .data.page_aligned : { *(.data.idt) }
 
   . = ALIGN(32);
@@ -68,11 +69,11 @@ SECTIONS
 
   _edata = .;			/* End of data section */
 
-  . = ALIGN(8192);		/* init_task */
+  . = ALIGN(THREAD_SIZE);	/* init_task */
   .data.init_task : { *(.data.init_task) }
 
   /* will be freed after init */
-  . = ALIGN(4096);		/* Init code and data */
+  . = ALIGN(PAGE_SIZE);		/* Init code and data */
   __init_begin = .;
   .init.text : {
 	_sinittext = .;
@@ -104,14 +105,14 @@ SECTIONS
   .exit.data : { EXIT_DATA }
 
 #ifdef CONFIG_BLK_DEV_INITRD
-  . = ALIGN(4096);
+  . = ALIGN(PAGE_SIZE);
   __initramfs_start = .;
   .init.ramfs : { *(.init.ramfs) }
   __initramfs_end = .;
 #endif
 
-  PERCPU(4096)
-  . = ALIGN(4096);
+  PERCPU(PAGE_SIZE)
+  . = ALIGN(PAGE_SIZE);
   __init_end = .;
   /* freed after init ends here */
 
Index: linux-2.6.git/include/asm-m32r/page.h
===================================================================
--- linux-2.6.git.orig/include/asm-m32r/page.h	2008-02-09 12:09:28.000000000 +0300
+++ linux-2.6.git/include/asm-m32r/page.h	2008-02-27 20:48:11.000000000 +0300
@@ -1,9 +1,11 @@
 #ifndef _ASM_M32R_PAGE_H
 #define _ASM_M32R_PAGE_H
 
+#include <linux/const.h>
+
 /* PAGE_SHIFT determines the page size */
 #define PAGE_SHIFT	12
-#define PAGE_SIZE	(1UL << PAGE_SHIFT)
+#define PAGE_SIZE	(_AC(1, UL) << PAGE_SHIFT)
 #define PAGE_MASK	(~(PAGE_SIZE-1))
 
 #ifndef __ASSEMBLY__

-- 
