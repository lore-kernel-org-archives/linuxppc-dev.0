Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5AFF7DDE27
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Mar 2007 05:18:28 +1100 (EST)
Date: Wed, 14 Mar 2007 13:15:05 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH][POWERPC] QE: Make QUICC Engine support a configurable option
Message-ID: <Pine.LNX.4.64.0703141314400.18994@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Allow us choose if we want QE support or not.  This is similiar to what
we do for the CPM2.  Its feasible to use a processor that has QE HW and not
use any of the QE functionality.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

---
commit a554f9b39496127face86d3afc6eb4a9aebef65b
tree f144b3290bc2cc04aa27591f4003f9b9249216f6
parent bfbb5a94dd58d2492d34338419a912440b660132
author Kumar Gala <galak@kernel.crashing.org> Wed, 14 Mar 2007 13:14:02 -0500
committer Kumar Gala <galak@kernel.crashing.org> Wed, 14 Mar 2007 13:14:02 -0500

 arch/powerpc/Kconfig                |    8 --------
 arch/powerpc/platforms/83xx/Kconfig |   12 ++++++++++--
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 5e1ac10..927f512 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -394,14 +394,6 @@ config APUS
 	  <http://linux-apus.sourceforge.net/>.
 endchoice

-config QUICC_ENGINE
-	bool
-	help
-	  The QUICC Engine (QE) is a new generation of communications
-	  coprocessors on Freescale embedded CPUs (akin to CPM in older chips).
-	  Selecting this option means that you wish to build a kernel
-	  for a machine with a QE coprocessor.
-
 config PPC_PSERIES
 	depends on PPC_MULTIPLATFORM && PPC64
 	bool "IBM pSeries & new (POWER5-based) iSeries"
diff --git a/arch/powerpc/platforms/83xx/Kconfig b/arch/powerpc/platforms/83xx/Kconfig
index 713b31a..745378d 100644
--- a/arch/powerpc/platforms/83xx/Kconfig
+++ b/arch/powerpc/platforms/83xx/Kconfig
@@ -14,7 +14,6 @@ config MPC8313_RDB
 config MPC832x_MDS
 	bool "Freescale MPC832x MDS"
 	select DEFAULT_UIMAGE
-	select QUICC_ENGINE
 	help
 	  This option enables support for the MPC832x MDS evaluation board.

@@ -41,12 +40,21 @@ config MPC834x_ITX
 config MPC836x_MDS
 	bool "Freescale MPC836x MDS"
 	select DEFAULT_UIMAGE
-	select QUICC_ENGINE
 	help
 	  This option enables support for the MPC836x MDS Processor Board.

 endchoice

+config QUICC_ENGINE
+	bool "QUICC Engine Support"
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
