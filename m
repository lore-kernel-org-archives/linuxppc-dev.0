Return-Path: <tnt@246tNt.com>
From: Sylvain Munaut <tnt@246tNt.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 2/7] powerpc: Changes the config mechanism for rheap
Date: Sun, 16 Sep 2007 12:53:25 +0200
Message-Id: <1189940011152-git-send-email-tnt@246tNt.com>
In-Reply-To: <11899400103383-git-send-email-tnt@246tNt.com>
References: <11899400103383-git-send-email-tnt@246tNt.com>
Cc: Grant Likely <glikely@gmail.com>, Sylvain Munaut <tnt@246tNt.com>,
	PowerPC dev list <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Instead of having in the makefile all the option that
requires rheap, we define a configuration symbol
and when needed we make sure it's selected.

Signed-off-by: Sylvain Munaut <tnt@246tNt.com>
---
 arch/powerpc/Kconfig                   |    2 ++
 arch/powerpc/lib/Kconfig               |    3 +++
 arch/powerpc/lib/Makefile              |    5 +----
 arch/powerpc/platforms/Kconfig         |    2 ++
 arch/powerpc/platforms/Kconfig.cputype |    1 +
 5 files changed, 9 insertions(+), 4 deletions(-)
 create mode 100644 arch/powerpc/lib/Kconfig

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 00099ef..76063b9 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -634,6 +634,8 @@ source "fs/Kconfig"
 
 source "arch/powerpc/sysdev/qe_lib/Kconfig"
 
+source "arch/powerpc/lib/Kconfig"
+
 source "lib/Kconfig"
 
 menu "Instrumentation Support"
diff --git a/arch/powerpc/lib/Kconfig b/arch/powerpc/lib/Kconfig
new file mode 100644
index 0000000..f383ad4
--- /dev/null
+++ b/arch/powerpc/lib/Kconfig
@@ -0,0 +1,3 @@
+config PPC_LIB_RHEAP
+	bool
+	default n
diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
index 0a486d4..f75c2a1 100644
--- a/arch/powerpc/lib/Makefile
+++ b/arch/powerpc/lib/Makefile
@@ -13,7 +13,6 @@ endif
 
 obj-$(CONFIG_PPC64)	+= checksum_64.o copypage_64.o copyuser_64.o \
 			   memcpy_64.o usercopy_64.o mem_64.o string.o
-obj-$(CONFIG_QUICC_ENGINE) += rheap.o
 obj-$(CONFIG_XMON)	+= sstep.o
 obj-$(CONFIG_KPROBES)	+= sstep.o
 obj-$(CONFIG_NOT_COHERENT_CACHE)	+= dma-noncoherent.o
@@ -22,6 +21,4 @@ ifeq ($(CONFIG_PPC64),y)
 obj-$(CONFIG_SMP)	+= locks.o
 endif
 
-# Temporary hack until we have migrated to asm-powerpc
-obj-$(CONFIG_8xx)	+= rheap.o
-obj-$(CONFIG_CPM2)	+= rheap.o
+obj-$(CONFIG_PPC_LIB_RHEAP) += rheap.o
diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
index 19d4628..9189ba5 100644
--- a/arch/powerpc/platforms/Kconfig
+++ b/arch/powerpc/platforms/Kconfig
@@ -257,6 +257,7 @@ config TAU_AVERAGE
 
 config QUICC_ENGINE
 	bool
+	select PPC_LIB_RHEAP
 	help
 	  The QUICC Engine (QE) is a new generation of communications
 	  coprocessors on Freescale embedded CPUs (akin to CPM in older chips).
@@ -266,6 +267,7 @@ config QUICC_ENGINE
 config CPM2
 	bool
 	default n
+	select PPC_LIB_RHEAP
 	help
 	  The CPM2 (Communications Processor Module) is a coprocessor on
 	  embedded CPUs made by Freescale.  Selecting this option means that
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index e4b2aee..29d8eff 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -36,6 +36,7 @@ config PPC_8xx
 	bool "Freescale 8xx"
 	select FSL_SOC
 	select 8xx
+	select PPC_LIB_RHEAP
 
 config 40x
 	bool "AMCC 40x"
-- 
1.5.3
