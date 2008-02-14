Return-Path: <grant.likely@secretlab.ca>
Received: from pd3mo1so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id 97563DDE2E
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Feb 2008 15:15:07 +1100 (EST)
Received: from pd2mr6so.prod.shaw.ca (pd2mr6so-qfe3.prod.shaw.ca [10.0.141.9])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JW700MMMNT5QH70@l-daemon> for linuxppc-dev@ozlabs.org;
	Wed, 13 Feb 2008 21:15:05 -0700 (MST)
Received: from pn2ml10so.prod.shaw.ca ([10.0.121.80])
	by pd2mr6so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JW7009SRNT31280@pd2mr6so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Wed, 13 Feb 2008 21:15:05 -0700 (MST)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JW700K2UNT35120@l-daemon> for linuxppc-dev@ozlabs.org;
	Wed, 13 Feb 2008 21:15:03 -0700 (MST)
Date: Wed, 13 Feb 2008 21:14:09 -0700
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH] remove unused CONFIG_WANT_DEVICE_TREE
To: paulus@samba.org, linuxppc-dev@ozlabs.org
Message-id: <20080214041301.30383.5581.stgit@trillian.secretlab.ca>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

CONFIG_DEVICE_TREE was the only user of CONFIG_WANT_DEVICE_TREE but
it was removed in commit id 25431333813686654907ab987fb5de10c10a16db
(bootwrapper: Build multiple cuImages).

This patch removes CONFIG_WANT_DEVICE_TREE from Kconfig and the defconfigs

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

Paul, this patch cleans up after a commit the multiple cuImage patch that
went in during the merge window.  It should probably be merged for .25

Thanks,
g.

 arch/powerpc/Kconfig                       |    4 ----
 arch/powerpc/platforms/512x/Kconfig        |    1 -
 arch/powerpc/platforms/52xx/Kconfig        |    2 --
 arch/powerpc/platforms/Kconfig             |    2 --
 arch/powerpc/platforms/Kconfig.cputype     |    4 ----
 arch/powerpc/platforms/embedded6xx/Kconfig |    4 ----
 6 files changed, 0 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 8dcac0b..53b0940 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -435,10 +435,6 @@ config SECCOMP
 
 	  If unsure, say Y. Only embedded should say N here.
 
-config WANT_DEVICE_TREE
-	bool
-	default n
-
 endmenu
 
 config ISA_DMA_API
diff --git a/arch/powerpc/platforms/512x/Kconfig b/arch/powerpc/platforms/512x/Kconfig
index c6fa49e..4c0da0c 100644
--- a/arch/powerpc/platforms/512x/Kconfig
+++ b/arch/powerpc/platforms/512x/Kconfig
@@ -13,7 +13,6 @@ config MPC5121_ADS
 	bool "Freescale MPC5121E ADS"
 	depends on PPC_MULTIPLATFORM && PPC32
 	select DEFAULT_UIMAGE
-	select WANT_DEVICE_TREE
 	select PPC_MPC5121
 	help
 	  This option enables support for the MPC5121E ADS board.
diff --git a/arch/powerpc/platforms/52xx/Kconfig b/arch/powerpc/platforms/52xx/Kconfig
index 515f244..cf945d5 100644
--- a/arch/powerpc/platforms/52xx/Kconfig
+++ b/arch/powerpc/platforms/52xx/Kconfig
@@ -8,7 +8,6 @@ config PPC_MPC5200_SIMPLE
 	bool "Generic support for simple MPC5200 based boards"
 	depends on PPC_MPC52xx
 	select DEFAULT_UIMAGE
-	select WANT_DEVICE_TREE
 	help
 	  This option enables support for a simple MPC52xx based boards which
 	  do not need a custom platform specific setup. Such boards are
@@ -35,7 +34,6 @@ config PPC_LITE5200
 	bool "Freescale Lite5200 Eval Board"
 	depends on PPC_MPC52xx
 	select DEFAULT_UIMAGE
-	select WANT_DEVICE_TREE
 
 config PPC_MPC5200_BUGFIX
 	bool "MPC5200 (L25R) bugfix support"
diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
index fcedbec..0afd225 100644
--- a/arch/powerpc/platforms/Kconfig
+++ b/arch/powerpc/platforms/Kconfig
@@ -15,7 +15,6 @@ config PPC_MULTIPLATFORM
 config PPC_82xx
 	bool "Freescale 82xx"
 	depends on 6xx
-	select WANT_DEVICE_TREE
 
 config PPC_83xx
 	bool "Freescale 83xx"
@@ -23,7 +22,6 @@ config PPC_83xx
 	select FSL_SOC
 	select MPC83xx
 	select IPIC
-	select WANT_DEVICE_TREE
 	select FSL_EMB_PERFMON
 
 config PPC_86xx
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index 69941ba..73d81ce 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -29,26 +29,22 @@ config PPC_85xx
 	bool "Freescale 85xx"
 	select E500
 	select FSL_SOC
-	select WANT_DEVICE_TREE
 	select MPC85xx
 
 config PPC_8xx
 	bool "Freescale 8xx"
 	select FSL_SOC
 	select 8xx
-	select WANT_DEVICE_TREE
 	select PPC_LIB_RHEAP
 
 config 40x
 	bool "AMCC 40x"
 	select PPC_DCR_NATIVE
-	select WANT_DEVICE_TREE
 	select PPC_UDBG_16550
 
 config 44x
 	bool "AMCC 44x"
 	select PPC_DCR_NATIVE
-	select WANT_DEVICE_TREE
 	select PPC_UDBG_16550
 
 config E200
diff --git a/arch/powerpc/platforms/embedded6xx/Kconfig b/arch/powerpc/platforms/embedded6xx/Kconfig
index 6c80837..4290889 100644
--- a/arch/powerpc/platforms/embedded6xx/Kconfig
+++ b/arch/powerpc/platforms/embedded6xx/Kconfig
@@ -24,7 +24,6 @@ config STORCENTER
 	select MPIC
 	select FSL_SOC
 	select PPC_UDBG_16550 if SERIAL_8250
-	select WANT_DEVICE_TREE
 	select MPC10X_OPENPIC
 	select MPC10X_BRIDGE
 	help
@@ -37,7 +36,6 @@ config MPC7448HPC2
 	select TSI108_BRIDGE
 	select DEFAULT_UIMAGE
 	select PPC_UDBG_16550
-	select WANT_DEVICE_TREE
 	select TSI108_BRIDGE
 	help
 	  Select MPC7448HPC2 if configuring for Freescale MPC7448HPC2 (Taiga)
@@ -48,7 +46,6 @@ config PPC_HOLLY
 	depends on EMBEDDED6xx
 	select TSI108_BRIDGE
 	select PPC_UDBG_16550
-	select WANT_DEVICE_TREE
 	select TSI108_BRIDGE
 	help
 	  Select PPC_HOLLY if configuring for an IBM 750GX/CL Eval
@@ -59,7 +56,6 @@ config PPC_PRPMC2800
 	depends on EMBEDDED6xx
 	select MV64X60
 	select NOT_COHERENT_CACHE
-	select WANT_DEVICE_TREE
 	help
 	  This option enables support for the Motorola PrPMC2800 board
 
