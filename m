Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 005C11A08F5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2015 19:17:10 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: thuth@redhat.com
Subject: [PATCH] powerpc/cell: Drop CONFIG_TUNE_CELL in favour of
 CONFIG_CELL_CPU
Date: Tue, 13 Oct 2015 19:17:07 +1100
Message-Id: <1444724227-24251-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The TUNE_CELL option allows you to build a kernel that runs on multiple
CPUs but is tuned (ie. optimised) to run on Cell CPUs. Now days no one
is building a distro in that fashion, and any users who are building
custom kernels for their Cell machines are better off building with
CONFIG_CELL_CPU, which builds a kernel that only runs on Cell and
therefore can be optimised even more aggresively.

Dropping the option also avoids confusing other users, who are presented
with an option to tune for Cell when they are not building for a Cell
CPU at all.

Suggested-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/Makefile                  |  2 --
 arch/powerpc/configs/cell_defconfig    |  2 +-
 arch/powerpc/configs/ps3_defconfig     |  2 +-
 arch/powerpc/platforms/Kconfig.cputype | 11 -----------
 4 files changed, 2 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index b9b4af2af9a5..1a205c4e5bb8 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -157,8 +157,6 @@ CFLAGS-$(CONFIG_E500) += $(call cc-option,-mcpu=8540 -msoft-float,-mcpu=powerpc)
 endif
 endif
 
-CFLAGS-$(CONFIG_TUNE_CELL) += $(call cc-option,-mtune=cell)
-
 asinstr := $(call as-instr,lis 9$(comma)foo@high,-DHAVE_AS_ATHIGH=1)
 
 KBUILD_CPPFLAGS	+= -Iarch/$(ARCH) $(asinstr)
diff --git a/arch/powerpc/configs/cell_defconfig b/arch/powerpc/configs/cell_defconfig
index 9227b517560a..db328e618bb9 100644
--- a/arch/powerpc/configs/cell_defconfig
+++ b/arch/powerpc/configs/cell_defconfig
@@ -1,5 +1,5 @@
 CONFIG_PPC64=y
-CONFIG_TUNE_CELL=y
+CONFIG_CELL_CPU=y
 CONFIG_ALTIVEC=y
 CONFIG_SMP=y
 CONFIG_NR_CPUS=4
diff --git a/arch/powerpc/configs/ps3_defconfig b/arch/powerpc/configs/ps3_defconfig
index adc14e813a49..391c2ceab73a 100644
--- a/arch/powerpc/configs/ps3_defconfig
+++ b/arch/powerpc/configs/ps3_defconfig
@@ -1,5 +1,5 @@
 CONFIG_PPC64=y
-CONFIG_TUNE_CELL=y
+CONFIG_CELL_CPU=y
 CONFIG_ALTIVEC=y
 CONFIG_SMP=y
 CONFIG_NR_CPUS=2
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index c140e94c7c72..142dff5e96d6 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -147,17 +147,6 @@ config 6xx
 	depends on PPC32 && PPC_BOOK3S
 	select PPC_HAVE_PMU_SUPPORT
 
-config TUNE_CELL
-	bool "Optimize for Cell Broadband Engine"
-	depends on PPC64 && PPC_BOOK3S
-	help
-	  Cause the compiler to optimize for the PPE of the Cell Broadband
-	  Engine. This will make the code run considerably faster on Cell
-	  but somewhat slower on other machines. This option only changes
-	  the scheduling of instructions, not the selection of instructions
-	  itself, so the resulting kernel will keep running on all other
-	  machines.
-
 # this is temp to handle compat with arch=ppc
 config 8xx
 	bool
-- 
2.1.4
