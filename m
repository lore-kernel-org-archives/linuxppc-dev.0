Return-Path: <geoffrey.levand@am.sony.com>
Received: from mgw2.sony.co.jp (MGW2.Sony.CO.JP [137.153.0.14])
	by ozlabs.org (Postfix) with ESMTP id 42A5A6856E
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Nov 2006 14:44:04 +1100 (EST)
Received: from mail3.sony.co.jp (localhost [127.0.0.1])
	by mail3.sony.co.jp (R8/Sony) with ESMTP id kAH3i3bC003090
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Nov 2006 12:44:03 +0900 (JST)
Received: from mailgw01.scei.sony.co.jp (mailgw01.scei.sony.co.jp [43.27.73.7])
	by mail3.sony.co.jp (R8/Sony) with SMTP id kAH3i3l5003077
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Nov 2006 12:44:03 +0900 (JST)
Message-ID: <455D2FFD.3060208@am.sony.com>
Date: Thu, 16 Nov 2006 19:43:57 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 12/16] powerpc: add ps3 platform lpar addressing
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Adds some needed bits for a config option PS3PF_USE_LPAR_ADDR that disables
the ps3pf lpar address translation mechanism.  This is a currently needed
workaround for limitations in the design of the spu support.

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

---
 arch/powerpc/platforms/ps3pf/Kconfig |   11 +++++++++++
 include/asm-powerpc/sparsemem.h      |    6 ++++++
 2 files changed, 17 insertions(+)

Index: cell--common--6/arch/powerpc/platforms/ps3pf/Kconfig
===================================================================
--- cell--common--6.orig/arch/powerpc/platforms/ps3pf/Kconfig
+++ cell--common--6/arch/powerpc/platforms/ps3pf/Kconfig
@@ -29,4 +29,15 @@
 	  This support is mainly for Linux kernel development.  If unsure,
 	  say N.
 
+config PS3PF_USE_LPAR_ADDR
+	depends on PS3PF && EXPERIMENTAL
+	bool "PS3 Platform use lpar address space"
+	default y
+	help
+	  This option is solely for experimentation by experts.  Disables
+	  translation of lpar addresses.  SPE support currently won't work
+	  without this set to y.
+
+	  If you have any doubt, choose the default y.
+
 endmenu
Index: cell--common--6/include/asm-powerpc/sparsemem.h
===================================================================
--- cell--common--6.orig/include/asm-powerpc/sparsemem.h
+++ cell--common--6/include/asm-powerpc/sparsemem.h
@@ -9,8 +9,14 @@
  * MAX_PHYSMEM_BITS		2^N: how much memory we can have in that space
  */
 #define SECTION_SIZE_BITS       24
+
+#if defined(CONFIG_PS3PF_USE_LPAR_ADDR)
+#define MAX_PHYSADDR_BITS       47
+#define MAX_PHYSMEM_BITS        47
+#else
 #define MAX_PHYSADDR_BITS       44
 #define MAX_PHYSMEM_BITS        44
+#endif
 
 #ifdef CONFIG_MEMORY_HOTPLUG
 extern void create_section_mapping(unsigned long start, unsigned long end);
