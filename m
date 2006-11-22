Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from mail86-sin-R.bigfish.com (mail-sin.bigfish.com [207.46.51.74])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id E5D2F68014
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Nov 2006 15:46:54 +1100 (EST)
Message-ID: <4563D01A.9080901@am.sony.com>
Date: Tue, 21 Nov 2006 20:20:42 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 10/14] powerpc: add ps3 platform lpar addressing
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

From: Geoff Levand <geoffrey.levand@am.sony.com>

Adds some needed bits for a config option PS3_USE_LPAR_ADDR that disables
the PS3 lpar address translation mechanism.  This is a currently needed
workaround for limitations in the design of the generic cell spu support.

Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>

---
 arch/powerpc/platforms/ps3/Kconfig |   11 +++++++++++
 include/asm-powerpc/sparsemem.h    |    6 ++++++
 2 files changed, 17 insertions(+)

Index: cell--common--6/arch/powerpc/platforms/ps3/Kconfig
===================================================================
--- cell--common--6.orig/arch/powerpc/platforms/ps3/Kconfig
+++ cell--common--6/arch/powerpc/platforms/ps3/Kconfig
@@ -29,4 +29,15 @@
 	  This support is mainly for Linux kernel development.  If unsure,
 	  say N.
 
+config PS3_USE_LPAR_ADDR
+	depends on PS3 && EXPERIMENTAL
+	bool "PS3 use lpar address space"
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
+#if defined(CONFIG_PS3_USE_LPAR_ADDR)
+#define MAX_PHYSADDR_BITS       47
+#define MAX_PHYSMEM_BITS        47
+#else
 #define MAX_PHYSADDR_BITS       44
 #define MAX_PHYSMEM_BITS        44
+#endif
 
 #ifdef CONFIG_MEMORY_HOTPLUG
 extern void create_section_mapping(unsigned long start, unsigned long end);
