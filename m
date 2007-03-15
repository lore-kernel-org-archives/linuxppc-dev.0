Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1F6CEDDE0E
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Mar 2007 02:10:52 +1100 (EST)
Date: Thu, 15 Mar 2007 10:07:31 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH][POWERPC] QE: Make QUICC Engine support a
	configurableoption
In-Reply-To: <45F94472.6010803@freescale.com>
Message-ID: <Pine.LNX.4.64.0703151006110.28961@localhost.localdomain>
References: <989B956029373F45A0B8AF02970818902DB124@zch01exm26.fsl.freescale.net>
	<45F94472.6010803@freescale.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Phillips Kim-R1AAHA <Kim.Phillips@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Here's the new patch, we will add in the 85xx version once 8568 is
functional.

- k

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 5e1ac10..ae181d3 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -396,11 +396,7 @@ endchoice

 config QUICC_ENGINE
 	bool
-	help
-	  The QUICC Engine (QE) is a new generation of communications
-	  coprocessors on Freescale embedded CPUs (akin to CPM in older chips).
-	  Selecting this option means that you wish to build a kernel
-	  for a machine with a QE coprocessor.
+	default n

 config PPC_PSERIES
 	depends on PPC_MULTIPLATFORM && PPC64
diff --git a/arch/powerpc/platforms/83xx/Kconfig b/arch/powerpc/platforms/83xx/Kconfig
index 713b31a..9e0f457 100644
--- a/arch/powerpc/platforms/83xx/Kconfig
+++ b/arch/powerpc/platforms/83xx/Kconfig
@@ -14,7 +14,6 @@ config MPC8313_RDB
 config MPC832x_MDS
 	bool "Freescale MPC832x MDS"
 	select DEFAULT_UIMAGE
-	select QUICC_ENGINE
 	help
 	  This option enables support for the MPC832x MDS evaluation board.

@@ -41,12 +40,22 @@ config MPC834x_ITX
 config MPC836x_MDS
 	bool "Freescale MPC836x MDS"
 	select DEFAULT_UIMAGE
-	select QUICC_ENGINE
 	help
 	  This option enables support for the MPC836x MDS Processor Board.

 endchoice

+config QUICC_ENGINE_83xx
+	bool "QUICC Engine Support"
+	select QUICC_ENGINE
+	depends on PPC_MPC836x || PPC_MPC832x
+	default y
+	---help---
+	  The QUICC Engine (QE) is a new generation of communications
+	  coprocessors on Freescale embedded CPUs (akin to CPM in older chips).
+	  Selecting this option means that you wish to build a kernel
+	  for a machine with a QE coprocessor.
+
 config PPC_MPC831x
 	bool
 	select PPC_UDBG_16550
