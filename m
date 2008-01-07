Return-Path: <paul.gortmaker@windriver.com>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id 18BBADDF80
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jan 2008 01:25:38 +1100 (EST)
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 6/7] CPM2: Make support for the CPM2 optional on 8560 based
	boards
Date: Mon,  7 Jan 2008 09:25:31 -0500
Message-Id: <11997159372454-git-send-email-paul.gortmaker@windriver.com>
In-Reply-To: <11997159361079-git-send-email-paul.gortmaker@windriver.com>
References: <11997159321859-git-send-email-paul.gortmaker@windriver.com>
	<11997159331132-git-send-email-paul.gortmaker@windriver.com>
	<11997159342128-git-send-email-paul.gortmaker@windriver.com>
	<11997159352727-git-send-email-paul.gortmaker@windriver.com>
	<1199715935439-git-send-email-paul.gortmaker@windriver.com>
	<11997159361079-git-send-email-paul.gortmaker@windriver.com>
Message-Id: <25caba2d31cd9404db085c69e4d449dabbe56f1f.1199715362.git.paul.gortmaker@windriver.com>
In-Reply-To: <ef7d84e06c45289f51f35845ccaa63bbf31827db.1199715362.git.paul.gortmaker@windriver.com>
References: <ef7d84e06c45289f51f35845ccaa63bbf31827db.1199715362.git.paul.gortmaker@windriver.com>
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
