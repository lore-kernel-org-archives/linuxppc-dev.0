Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 39EC1DDE2A
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Apr 2007 09:13:49 +1000 (EST)
Received: from [72.183.106.80] (helo=[192.168.1.2])
	by nommos.sslcatacombnetworking.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.63) (envelope-from <galak@kernel.crashing.org>)
	id 1Hc8U6-0002aW-0j
	for linuxppc-dev@ozlabs.org; Thu, 12 Apr 2007 18:13:46 -0500
Date: Thu, 12 Apr 2007 18:09:53 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/7] Convert 86xx platform to unified platform Kconfig
In-Reply-To: <Pine.LNX.4.64.0704121806330.28324@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0704121809290.28324@localhost.localdomain>
References: <Pine.LNX.4.64.0704121806330.28324@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Moved 86xx platform Kconfig over to being sourced by the unified
arch/powerpc/platforms/Kconfig.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/Kconfig                |    6 +++++-
 arch/powerpc/platforms/86xx/Kconfig |   18 +++---------------
 arch/powerpc/platforms/Kconfig      |    3 ++-
 3 files changed, 10 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 740892a..d37e0b8 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -380,7 +380,6 @@ source arch/powerpc/platforms/4xx/Kconfig
 source arch/powerpc/platforms/82xx/Kconfig
 source arch/powerpc/platforms/83xx/Kconfig
 source arch/powerpc/platforms/85xx/Kconfig
-source arch/powerpc/platforms/86xx/Kconfig
 source arch/powerpc/platforms/8xx/Kconfig

 menu "Kernel options"
@@ -637,6 +636,11 @@ config PPC_INDIRECT_PCI
 	default y if 40x || 44x
 	default n

+config PPC_INDIRECT_PCI_BE
+	bool
+	depends PPC_INDIRECT_PCI
+	default n
+
 config EISA
 	bool

diff --git a/arch/powerpc/platforms/86xx/Kconfig b/arch/powerpc/platforms/86xx/Kconfig
index 0c70944..d1bcff5 100644
--- a/arch/powerpc/platforms/86xx/Kconfig
+++ b/arch/powerpc/platforms/86xx/Kconfig
@@ -1,8 +1,6 @@
-menu "Platform Support"
-	depends on PPC_86xx
-
 choice
 	prompt "Machine Type"
+	depends on PPC_86xx
 	default MPC8641_HPCN

 config MPC8641_HPCN
@@ -14,20 +12,10 @@ config MPC8641_HPCN

 endchoice

-
 config MPC8641
 	bool
 	select PPC_INDIRECT_PCI
+	select PPC_INDIRECT_PCI_BE
 	select PPC_UDBG_16550
+	select MPIC
 	default y if MPC8641_HPCN
-
-config MPIC
-	bool
-	default y
-
-config PPC_INDIRECT_PCI_BE
-	bool
-	depends on PPC_86xx
-	default y
-
-endmenu
diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
index 176a27f..5f2cef0 100644
--- a/arch/powerpc/platforms/Kconfig
+++ b/arch/powerpc/platforms/Kconfig
@@ -1,5 +1,5 @@
 menu "Platform support"
-	depends on PPC64 || CLASSIC32
+	depends on PPC64 || CLASSIC32 || PPC_86xx

 choice
 	prompt "Machine type"
@@ -45,6 +45,7 @@ source "arch/powerpc/platforms/pasemi/Kconfig"
 source arch/powerpc/platforms/celleb/Kconfig
 source arch/powerpc/platforms/ps3/Kconfig
 source arch/powerpc/platforms/cell/Kconfig
+source "arch/powerpc/platforms/86xx/Kconfig"

 config PPC_NATIVE
 	bool
-- 
1.5.0.6
