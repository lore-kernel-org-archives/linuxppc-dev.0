Return-Path: <paul.gortmaker@windriver.com>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id C93EBDDE03
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jan 2008 10:41:38 +1100 (EST)
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 3/10] CPM2: Make support for the CPM2 optional on 8560 based
	boards
Date: Thu, 24 Jan 2008 18:41:25 -0500
Message-Id: <12012180951674-git-send-email-paul.gortmaker@windriver.com>
In-Reply-To: <12012180944056-git-send-email-paul.gortmaker@windriver.com>
References: <12012180922447-git-send-email-paul.gortmaker@windriver.com>
	<12012180943940-git-send-email-paul.gortmaker@windriver.com>
	<12012180944056-git-send-email-paul.gortmaker@windriver.com>
Message-Id: <e314406ab20b7a8fd11365f7475e3cc9175d2b72.1201217172.git.paul.gortmaker@windriver.com>
In-Reply-To: <e3ccba7097a77e66f07663fe9d1f174c06183528.1201217172.git.paul.gortmaker@windriver.com>
References: <e3ccba7097a77e66f07663fe9d1f174c06183528.1201217172.git.paul.gortmaker@windriver.com>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Currently there is no way to disable the CPM2 support.  Some boards,
like the SBC8560 have their own external UART and don't have any direct
dependencies on the CPM for a serial console or anything else.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/powerpc/platforms/85xx/Kconfig |    4 ++--
 arch/powerpc/platforms/Kconfig      |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
index 0eb497b..33d3bea 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -13,6 +13,7 @@ config MPC8560_ADS
 	bool "Freescale MPC8560 ADS"
 	select DEFAULT_UIMAGE
 	select PPC_CPM_NEW_BINDING
+	select CPM2
 	help
 	  This option enables support for the MPC 8560 ADS board
 
@@ -41,7 +42,7 @@ config MPC85xx_DS
 config SBC8560
 	bool "Wind River SBC8560"
 	select DEFAULT_UIMAGE
-	select PPC_CPM_NEW_BINDING
+	select PPC_CPM_NEW_BINDING if CPM2
 	help
 	  This option enables support for the Wind River SBC8560 board
 
@@ -55,7 +56,6 @@ config MPC8540
 
 config MPC8560
 	bool
-	select CPM2
 	default y if MPC8560_ADS || SBC8560
 
 config MPC85xx
diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
index 2cec343..27b74e9 100644
--- a/arch/powerpc/platforms/Kconfig
+++ b/arch/powerpc/platforms/Kconfig
@@ -278,8 +278,8 @@ config QUICC_ENGINE
 	  for a machine with a QE coprocessor.
 
 config CPM2
-	bool
-	default n
+	bool "Enable support for the CPM2 (Communications Processor Module)"
+	depends on MPC8560 || 8260
 	select CPM
 	select PPC_LIB_RHEAP
 	help
-- 
1.5.0.rc1.gf4b6c
