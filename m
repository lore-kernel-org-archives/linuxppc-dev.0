Return-Path: <grant.likely@secretlab.ca>
Received: from pd2mo2so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id 26147DDEEE
	for <linuxppc-dev@ozlabs.org>; Sun, 14 Oct 2007 14:42:25 +1000 (EST)
Received: from pd2mr3so.prod.shaw.ca
	(pd2mr3so-qfe3.prod.shaw.ca [10.0.141.108]) by l-daemon
	(Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
	with ESMTP id <0JPV009R0X29AM50@l-daemon> for linuxppc-dev@ozlabs.org;
	Sat, 13 Oct 2007 22:42:09 -0600 (MDT)
Received: from pn2ml9so.prod.shaw.ca ([10.0.121.7])
	by pd2mr3so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JPV00ELIX1VX020@pd2mr3so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Sat, 13 Oct 2007 22:42:09 -0600 (MDT)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JPV00DYAX1UY3X1@l-daemon> for linuxppc-dev@ozlabs.org;
	Sat, 13 Oct 2007 22:41:55 -0600 (MDT)
Date: Sat, 13 Oct 2007 22:41:55 -0600
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH v2 2/7] rheap: Changes config mechanism
In-reply-to: <20071014044041.23438.14070.stgit@trillian.cg.shawcable.net>
To: galak@kernel.crashing.org, paulus@samba.org, linuxppc-dev@ozlabs.org,
	tnt@246tnt.com, domen.puncer@telargo.com
Message-id: <20071014044154.23438.58701.stgit@trillian.cg.shawcable.net>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
References: <20071014044041.23438.14070.stgit@trillian.cg.shawcable.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Sylvain Munaut <tnt@246tNt.com>

Instead of having in the makefile all the option that
requires rheap, we define a configuration symbol
and when needed we make sure it's selected.

Signed-off-by: Sylvain Munaut <tnt@246tNt.com>
Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 arch/powerpc/Kconfig                   |    4 ++++
 arch/powerpc/lib/Makefile              |    5 +----
 arch/powerpc/platforms/Kconfig         |    2 ++
 arch/powerpc/platforms/Kconfig.cputype |    1 +
 arch/ppc/Kconfig                       |    6 ++++++
 5 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 037664d..8300e6a 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -698,3 +698,7 @@ source "crypto/Kconfig"
 config PPC_CLOCK
 	bool
 	default n
+
+config PPC_LIB_RHEAP
+	bool
+
diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
index 65d492e..4bb023f 100644
--- a/arch/powerpc/lib/Makefile
+++ b/arch/powerpc/lib/Makefile
@@ -14,7 +14,6 @@ endif
 
 obj-$(CONFIG_PPC64)	+= copypage_64.o copyuser_64.o \
 			   memcpy_64.o usercopy_64.o mem_64.o string.o
-obj-$(CONFIG_QUICC_ENGINE) += rheap.o
 obj-$(CONFIG_XMON)	+= sstep.o
 obj-$(CONFIG_KPROBES)	+= sstep.o
 obj-$(CONFIG_NOT_COHERENT_CACHE)	+= dma-noncoherent.o
@@ -23,6 +22,4 @@ ifeq ($(CONFIG_PPC64),y)
 obj-$(CONFIG_SMP)	+= locks.o
 endif
 
-# Temporary hack until we have migrated to asm-powerpc
-obj-$(CONFIG_8xx)	+= rheap.o
-obj-$(CONFIG_CPM2)	+= rheap.o
+obj-$(CONFIG_PPC_LIB_RHEAP) += rheap.o
diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
index cc6013f..3724cb4 100644
--- a/arch/powerpc/platforms/Kconfig
+++ b/arch/powerpc/platforms/Kconfig
@@ -264,6 +264,7 @@ config TAU_AVERAGE
 
 config QUICC_ENGINE
 	bool
+	select PPC_LIB_RHEAP
 	help
 	  The QUICC Engine (QE) is a new generation of communications
 	  coprocessors on Freescale embedded CPUs (akin to CPM in older chips).
@@ -274,6 +275,7 @@ config CPM2
 	bool
 	default n
 	select CPM
+	select PPC_LIB_RHEAP
 	help
 	  The CPM2 (Communications Processor Module) is a coprocessor on
 	  embedded CPUs made by Freescale.  Selecting this option means that
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index 4c315be..3c7325e 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -37,6 +37,7 @@ config PPC_8xx
 	select FSL_SOC
 	select 8xx
 	select WANT_DEVICE_TREE
+	select PPC_LIB_RHEAP
 
 config 40x
 	bool "AMCC 40x"
diff --git a/arch/ppc/Kconfig b/arch/ppc/Kconfig
index 20dce46..607925c 100644
--- a/arch/ppc/Kconfig
+++ b/arch/ppc/Kconfig
@@ -102,6 +102,7 @@ config 44x
 
 config 8xx
 	bool "8xx"
+	select PPC_LIB_RHEAP
 
 config E200
 	bool "e200"
@@ -798,6 +799,7 @@ config CPM1
 config CPM2
 	bool
 	depends on 8260 || MPC8560 || MPC8555
+	select PPC_LIB_RHEAP
 	default y
 	help
 	  The CPM2 (Communications Processor Module) is a coprocessor on
@@ -1277,6 +1279,10 @@ config BOOT_LOAD
 config PIN_TLB
 	bool "Pinned Kernel TLBs (860 ONLY)"
 	depends on ADVANCED_OPTIONS && 8xx
+
+config PPC_LIB_RHEAP
+	bool
+
 endmenu
 
 source "net/Kconfig"
