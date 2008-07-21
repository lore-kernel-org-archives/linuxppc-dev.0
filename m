Return-Path: <marvin24@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 6F270DDE1F
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Jul 2008 17:05:48 +1000 (EST)
From: Marvin <marvin24@gmx.de>
To: linuxppc-dev@ozlabs.org
Subject: [4/5] replace CONFIG_POWER4_ONLY by new tuning mechanism
Date: Mon, 21 Jul 2008 08:57:03 +0200
References: <200807210845.30434.marvin24@gmx.de>
In-Reply-To: <200807210845.30434.marvin24@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200807210857.03775.marvin24@gmx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


This patch replaces CONFIG_POWER4_ONLY by (CONFIG_OPT_EXCLUSIVE && 
CONFIG_TUNE_POWER4). This gets overwritten in the next patch.

It also introduces integer values of CPU generations. This is useful to enable 
features available only since a certain CPU gen (see last hunk). 
Unfortunately, kbuild system can't (yet) compare int values, so MIN_POWERn is 
also defined (but not used yet).

Subject: [PATCH] replace CONFIG_POWER4_ONLY by new tuning mechanism

---
 arch/powerpc/Kconfig                    |    2 +-
 arch/powerpc/Makefile                   |    5 ++++-
 arch/powerpc/configs/cell_defconfig     |    1 -
 arch/powerpc/configs/celleb_defconfig   |    1 -
 arch/powerpc/configs/g5_defconfig       |    3 ++-
 arch/powerpc/configs/iseries_defconfig  |    1 -
 arch/powerpc/configs/maple_defconfig    |    3 ++-
 arch/powerpc/configs/pasemi_defconfig   |    3 ++-
 arch/powerpc/configs/ppc64_defconfig    |    1 -
 arch/powerpc/configs/ps3_defconfig      |    1 -
 arch/powerpc/configs/pseries_defconfig  |    1 -
 arch/powerpc/platforms/Kconfig.cputype  |   31 
++++++++++++++++++++++++-------
 arch/powerpc/platforms/powermac/Kconfig |    2 +-
 include/asm-powerpc/asm-compat.h        |    2 +-
 14 files changed, 37 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index de88972..9b2aaf5 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -528,7 +528,7 @@ config ZONE_DMA
 
 config GENERIC_ISA_DMA
 	bool
-	depends on PPC64 || POWER4 || 6xx && !CPM2
+	depends on PPC64 || 6xx && !CPM2
 	default y
 
 config PPC_INDIRECT_PCI
diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 624a896..9629c5e 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -77,7 +77,8 @@ CHECKFLAGS	
+= -m$(CONFIG_WORD_SIZE) -D__powerpc__ -D__powerpc$(CONFIG_WORD_SIZE)
 ifeq ($(CONFIG_PPC64),y)
 GCC_BROKEN_VEC	:= $(shell if [ $(call cc-version) -lt 0400 ] ; then echo "y"; 
fi)
 
-ifeq ($(CONFIG_POWER4_ONLY),y)
+ifeq ($(CONFIG_TUNE_POWER4),y)
+ifeq ($(CONFIG_OPT_EXCLUSIVE),y)
 ifeq ($(CONFIG_ALTIVEC),y)
 ifeq ($(GCC_BROKEN_VEC),y)
 	KBUILD_CFLAGS += $(call cc-option,-mcpu=970)
@@ -90,6 +91,8 @@ endif
 else
 	KBUILD_CFLAGS += $(call cc-option,-mtune=power4)
 endif
+	KBUILD_CFLAGS += $(call cc-option,-mtune=power4)
+endif
 else
 LDFLAGS_MODULE	+= arch/powerpc/lib/crtsavres.o
 endif
diff --git a/arch/powerpc/configs/cell_defconfig 
b/arch/powerpc/configs/cell_defconfig
index 42290e8..7e8e581 100644
--- a/arch/powerpc/configs/cell_defconfig
+++ b/arch/powerpc/configs/cell_defconfig
@@ -8,7 +8,6 @@ CONFIG_PPC64=y
 #
 # Processor support
 #
-# CONFIG_POWER4_ONLY is not set
 CONFIG_BATS64=y
 CONFIG_TUNE_CELL=y
 CONFIG_PPC_FPU=y
diff --git a/arch/powerpc/configs/celleb_defconfig 
b/arch/powerpc/configs/celleb_defconfig
index a405836..e11e991 100644
--- a/arch/powerpc/configs/celleb_defconfig
+++ b/arch/powerpc/configs/celleb_defconfig
@@ -8,7 +8,6 @@ CONFIG_PPC64=y
 #
 # Processor support
 #
-# CONFIG_POWER4_ONLY is not set
 CONFIG_BATS64=y
 CONFIG_TUNE_CELL=y
 CONFIG_PPC_FPU=y
diff --git a/arch/powerpc/configs/g5_defconfig 
b/arch/powerpc/configs/g5_defconfig
index 747088a..e2c92ed 100644
--- a/arch/powerpc/configs/g5_defconfig
+++ b/arch/powerpc/configs/g5_defconfig
@@ -8,7 +8,8 @@ CONFIG_PPC64=y
 #
 # Processor support
 #
-CONFIG_POWER4_ONLY=y
+CONFIG_TUNE_POWER4=y
+CONFIG_OPT_EXCLUSIVE=y
 # CONFIG_TUNE_CELL is not set
 CONFIG_PPC_FPU=y
 CONFIG_ALTIVEC=y
diff --git a/arch/powerpc/configs/iseries_defconfig 
b/arch/powerpc/configs/iseries_defconfig
index 1b46033..abe72fd 100644
--- a/arch/powerpc/configs/iseries_defconfig
+++ b/arch/powerpc/configs/iseries_defconfig
@@ -8,7 +8,6 @@ CONFIG_PPC64=y
 #
 # Processor support
 #
-# CONFIG_POWER4_ONLY is not set
 CONFIG_BATS64=y
 # CONFIG_TUNE_CELL is not set
 CONFIG_PPC_FPU=y
diff --git a/arch/powerpc/configs/maple_defconfig 
b/arch/powerpc/configs/maple_defconfig
index 4becb7b..6dee9f2 100644
--- a/arch/powerpc/configs/maple_defconfig
+++ b/arch/powerpc/configs/maple_defconfig
@@ -8,7 +8,8 @@ CONFIG_PPC64=y
 #
 # Processor support
 #
-CONFIG_POWER4_ONLY=y
+CONFIG_TUNE_POWER4=y
+CONFIG_OPT_EXCLUSIVE=y
 # CONFIG_TUNE_CELL is not set
 CONFIG_PPC_FPU=y
 # CONFIG_ALTIVEC is not set
diff --git a/arch/powerpc/configs/pasemi_defconfig 
b/arch/powerpc/configs/pasemi_defconfig
index d816a3a..adef0fe 100644
--- a/arch/powerpc/configs/pasemi_defconfig
+++ b/arch/powerpc/configs/pasemi_defconfig
@@ -8,7 +8,8 @@ CONFIG_PPC64=y
 #
 # Processor support
 #
-CONFIG_POWER4_ONLY=y
+CONFIG_TUNE_POWER4=y
+CONFIG_OPT_EXCLUSIVE=y
 # CONFIG_TUNE_CELL is not set
 CONFIG_PPC_FPU=y
 CONFIG_ALTIVEC=y
diff --git a/arch/powerpc/configs/ppc64_defconfig 
b/arch/powerpc/configs/ppc64_defconfig
index 22276d2..7f14276 100644
--- a/arch/powerpc/configs/ppc64_defconfig
+++ b/arch/powerpc/configs/ppc64_defconfig
@@ -8,7 +8,6 @@ CONFIG_PPC64=y
 #
 # Processor support
 #
-# CONFIG_POWER4_ONLY is not set
 CONFIG_BATS64=y
 # CONFIG_TUNE_CELL is not set
 CONFIG_PPC_FPU=y
diff --git a/arch/powerpc/configs/ps3_defconfig 
b/arch/powerpc/configs/ps3_defconfig
index 52a0895..da02852 100644
--- a/arch/powerpc/configs/ps3_defconfig
+++ b/arch/powerpc/configs/ps3_defconfig
@@ -8,7 +8,6 @@ CONFIG_PPC64=y
 #
 # Processor support
 #
-# CONFIG_POWER4_ONLY is not set
 CONFIG_BATS64=y
 CONFIG_TUNE_CELL=y
 CONFIG_PPC_FPU=y
diff --git a/arch/powerpc/configs/pseries_defconfig 
b/arch/powerpc/configs/pseries_defconfig
index e0194e7..d4a7330 100644
--- a/arch/powerpc/configs/pseries_defconfig
+++ b/arch/powerpc/configs/pseries_defconfig
@@ -8,7 +8,6 @@ CONFIG_PPC64=y
 #
 # Processor support
 #
-# CONFIG_POWER4_ONLY is not set
 CONFIG_BATS64=y
 # CONFIG_TUNE_CELL is not set
 CONFIG_PPC_FPU=y
diff --git a/arch/powerpc/platforms/Kconfig.cputype 
b/arch/powerpc/platforms/Kconfig.cputype
index 5af2123..70928c8 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -115,13 +115,30 @@ config OPT_EXCLUSIVE
 	  
 	  If you are unsure, select no.
 
-config BATS64
+config PPC64_GEN
 	depends on PPC64
-	def_bool y if !POWER4_ONLY
+	int
+	default "1" if !OPT_EXCLUSIVE
+	default "2" if TUNE_RS64
+	default "3" if TUNE_POWER3
+	default "4" if TUNE_POWER4 || TUNE_CELL || TUNE_970
+	default "5" if TUNE_POWER5
+	default "6" if TUNE_POWER6
+
+# needed until kbuild understands comparision of int values
+config MIN_POWER4
+	def_bool y if ( PPC64_GEN = 4 || PPC64_GEN = 5 || PPC64_GEN = 6 || PPC64_GEN 
= 7 )
+
+config MIN_POWER5
+	def_bool y if ( PPC64_GEN = 5 || PPC64_GEN = 6 || PPC64_GEN = 7 )
 
-config POWER4_ONLY
+config MIN_POWER6
+	def_bool y if ( PPC64_GEN = 6 || PPC64_GEN = 7 )
+
+config BATS64
 	depends on PPC64
-	def_bool y if TUNE_POWER4 && OPT_EXCLUSIVE
+	def_bool y if !OPT_EXCLUSIVE
+	def_bool y if TUNE_RS64 || TUNE_POWER3
 
 config 6xx
 	bool
@@ -185,7 +202,7 @@ config PHYS_64BIT
 
 config ALTIVEC
 	bool "AltiVec Support"
-	depends on CLASSIC32 || POWER4
+	depends on CLASSIC32 || PPC64
 	---help---
 	  This option enables kernel support for the Altivec extensions to the
 	  PowerPC processor. The kernel currently supports saving and restoring
@@ -201,7 +218,7 @@ config ALTIVEC
 
 config VSX
 	bool "VSX Support"
-	depends on POWER4 && ALTIVEC && PPC_FPU
+	depends on PPC64 && ALTIVEC && PPC_FPU
 	---help---
 
 	  This option enables kernel support for the Vector Scaler extensions
@@ -233,7 +250,7 @@ config SPE
 
 config PPC_STD_MMU
 	bool
-	depends on 6xx || POWER3 || POWER4 || PPC64
+	depends on 6xx || PPC64
 	default y
 
 config PPC_STD_MMU_32
diff --git a/arch/powerpc/platforms/powermac/Kconfig 
b/arch/powerpc/platforms/powermac/Kconfig
index 055990c..28d32c5 100644
--- a/arch/powerpc/platforms/powermac/Kconfig
+++ b/arch/powerpc/platforms/powermac/Kconfig
@@ -10,7 +10,7 @@ config PPC_PMAC
 
 config PPC_PMAC64
 	bool
-	depends on PPC_PMAC && POWER4
+	depends on PPC_PMAC && PPC64
 	select MPIC
 	select U3_DART
 	select MPIC_U3_HT_IRQS
diff --git a/include/asm-powerpc/asm-compat.h 
b/include/asm-powerpc/asm-compat.h
index 8ec2e1d..d7cf3e4 100644
--- a/include/asm-powerpc/asm-compat.h
+++ b/include/asm-powerpc/asm-compat.h
@@ -30,7 +30,7 @@
 /* Move to CR, single-entry optimized version. Only available
  * on POWER4 and later.
  */
-#ifdef CONFIG_POWER4_ONLY
+#if CONFIG_PPC64_GEN >= 4
 #define PPC_MTOCRF	stringify_in_c(mtocrf)
 #else
 #define PPC_MTOCRF	stringify_in_c(mtcrf)
-- 
1.5.6.2
