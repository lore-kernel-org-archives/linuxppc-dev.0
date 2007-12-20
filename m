Return-Path: <Paul.Gortmaker@windriver.com>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id 4E1E8DDE2A
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Dec 2007 05:20:02 +1100 (EST)
Received: from ALA-MAIL03.corp.ad.wrs.com (ala-mail03 [147.11.57.144])
	by mail.wrs.com (8.13.6/8.13.6) with ESMTP id lBKEsZAr025821
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Dec 2007 06:54:35 -0800 (PST)
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/4] CPM2: Make support for the CPM2 optional on 8560 based
	boards
Date: Thu, 20 Dec 2007 09:54:30 -0500
Message-Id: <11981624741263-git-send-email-paul.gortmaker@windriver.com>
In-Reply-To: <11981624732110-git-send-email-paul.gortmaker@windriver.com>
References: <11981624722785-git-send-email-paul.gortmaker@windriver.com>
	<11981624732110-git-send-email-paul.gortmaker@windriver.com>
Message-Id: <5864c84d6edc3562db2216ed46841f8004670106.1198107769.git.paul.gortmaker@windriver.com>
In-Reply-To: <442fe9c9343f3c694932bcdc5f819c493c33c76b.1198107769.git.paul.gortmaker@windriver.com>
References: <442fe9c9343f3c694932bcdc5f819c493c33c76b.1198107769.git.paul.gortmaker@windriver.com>
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
index ea22cad..d355dd6 100644
--- a/arch/powerpc/platforms/Kconfig
+++ b/arch/powerpc/platforms/Kconfig
@@ -272,8 +272,8 @@ config QUICC_ENGINE
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
