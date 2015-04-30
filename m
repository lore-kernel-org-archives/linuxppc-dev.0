Return-Path: <haokexin@gmail.com>
Received: from mail-yk0-x235.google.com (mail-yk0-x235.google.com
 [IPv6:2607:f8b0:4002:c07::235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1401E1A01F1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Apr 2015 22:30:26 +1000 (AEST)
Received: by ykep21 with SMTP id p21so13075503yke.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Apr 2015 05:30:23 -0700 (PDT)
From: Kevin Hao <haokexin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/2] powerpc: merge the RELOCATABLE config entries for ppc32
 and ppc64
Date: Thu, 30 Apr 2015 20:29:57 +0800
Message-Id: <1430396997-14656-3-git-send-email-haokexin@gmail.com>
In-Reply-To: <1430396997-14656-1-git-send-email-haokexin@gmail.com>
References: <1430396997-14656-1-git-send-email-haokexin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

It makes no sense to keep two separate RELOCATABLE config entries for
ppc32 and ppc64 respectively. Merge them into one and move it to
a common place. The dependency on ADVANCED_OPTIONS for ppc32 seems
unnecessary, also drop it.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 arch/powerpc/Kconfig | 65 ++++++++++++++++++++++------------------------------
 1 file changed, 27 insertions(+), 38 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index d6bbf4f6f869..4080a14707bb 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -427,6 +427,33 @@ config KEXEC
 	  interface is strongly in flux, so no good recommendation can be
 	  made.
 
+config RELOCATABLE
+	bool "Build a relocatable kernel"
+	depends on (PPC64 && !COMPILE_TEST) || (FLATMEM && (44x || FSL_BOOKE))
+	select NONSTATIC_KERNEL
+	help
+	  This builds a kernel image that is capable of running at the
+	  location the kernel is loaded at. For ppc32, there is no any
+	  alignment restrictions, and this feature is a superset of
+	  DYNAMIC_MEMSTART and hence overrides it. For ppc64, we should use
+	  16k-aligned base address. The kernel is linked as a
+	  position-independent executable (PIE) and contains dynamic relocations
+	  which are processed early in the bootup process.
+
+	  One use is for the kexec on panic case where the recovery kernel
+	  must live at a different physical address than the primary
+	  kernel.
+
+	  Note: If CONFIG_RELOCATABLE=y, then the kernel runs from the address
+	  it has been loaded at and the compile time physical addresses
+	  CONFIG_PHYSICAL_START is ignored.  However CONFIG_PHYSICAL_START
+	  setting can still be useful to bootwrappers that need to know the
+	  load address of the kernel (eg. u-boot/mkimage).
+
+config RELOCATABLE_PPC32
+	def_bool y
+	depends on PPC32 && RELOCATABLE
+
 config CRASH_DUMP
 	bool "Build a kdump crash kernel"
 	depends on 6xx || ((PPC64 || FSL_BOOKE || (44x && !SMP)) && RELOCATABLE)
@@ -926,29 +953,6 @@ config DYNAMIC_MEMSTART
 
 	  This option is overridden by CONFIG_RELOCATABLE
 
-config RELOCATABLE
-	bool "Build a relocatable kernel"
-	depends on ADVANCED_OPTIONS && FLATMEM && (44x || FSL_BOOKE)
-	select NONSTATIC_KERNEL
-	help
-	  This builds a kernel image that is capable of running at the
-	  location the kernel is loaded at, without any alignment restrictions.
-	  This feature is a superset of DYNAMIC_MEMSTART and hence overrides it.
-
-	  One use is for the kexec on panic case where the recovery kernel
-	  must live at a different physical address than the primary
-	  kernel.
-
-	  Note: If CONFIG_RELOCATABLE=y, then the kernel runs from the address
-	  it has been loaded at and the compile time physical addresses
-	  CONFIG_PHYSICAL_START is ignored.  However CONFIG_PHYSICAL_START
-	  setting can still be useful to bootwrappers that need to know the
-	  load address of the kernel (eg. u-boot/mkimage).
-
-config RELOCATABLE_PPC32
-	def_bool y
-	depends on PPC32 && RELOCATABLE
-
 config PAGE_OFFSET_BOOL
 	bool "Set custom page offset address"
 	depends on ADVANCED_OPTIONS
@@ -1034,21 +1038,6 @@ config PIN_TLB
 endmenu
 
 if PPC64
-config RELOCATABLE
-	bool "Build a relocatable kernel"
-	depends on !COMPILE_TEST
-	select NONSTATIC_KERNEL
-	help
-	  This builds a kernel image that is capable of running anywhere
-	  in the RMA (real memory area) at any 16k-aligned base address.
-	  The kernel is linked as a position-independent executable (PIE)
-	  and contains dynamic relocations which are processed early
-	  in the bootup process.
-
-	  One use is for the kexec on panic case where the recovery kernel
-	  must live at a different physical address than the primary
-	  kernel.
-
 # This value must have zeroes in the bottom 60 bits otherwise lots will break
 config PAGE_OFFSET
 	hex
-- 
2.1.0
