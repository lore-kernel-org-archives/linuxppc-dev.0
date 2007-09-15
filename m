Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id 5A967DDDFA
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Sep 2007 10:26:39 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] add Kconfig option for optimizing for cell
Date: Sat, 15 Sep 2007 02:21:57 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200709150221.57825.arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Since the PPE on cell is an in-order core, it suffers significantly
from wrong instruction scheduling. This adds an Kconfig option that
enables passing -mtune=cell to gcc in order to generate object
code that runs well on cell.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 6015a92..87aff53 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -92,6 +92,10 @@ else
 endif
 endif
 
+ifeq ($(CONFIG_TUNE_CELL),y)
+	CFLAGS += $(call cc-option,-mtune=cell)
+endif
+
 # No AltiVec instruction when building kernel
 CFLAGS += $(call cc-option,-mno-altivec)
 
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index 86eb4cf..4c315be 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -71,6 +71,18 @@ config POWER4
 	depends on PPC64
 	def_bool y
 
+config TUNE_CELL
+	bool "Optimize for Cell Broadband Engine"
+	depends on PPC64
+	help
+	  Cause the compiler to optimize for the PPE of the Cell Broadband
+	  Engine. This will make the code run considerably faster on Cell
+	  but somewhat slower on other machines. This option only changes
+	  the scheduling of instructions, not the selection of instructions
+	  itself, so the resulting kernel will keep running on all other
+	  machines. When building a kernel that is supposed to run only
+	  on Cell, you should also select the POWER4_ONLY option.
+
 config 6xx
 	bool
 
