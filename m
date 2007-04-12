Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2BCA4DDE23
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Apr 2007 09:14:18 +1000 (EST)
Received: from [72.183.106.80] (helo=[192.168.1.2])
	by nommos.sslcatacombnetworking.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.63) (envelope-from <galak@kernel.crashing.org>)
	id 1Hc8UY-0002fH-QD
	for linuxppc-dev@ozlabs.org; Thu, 12 Apr 2007 18:14:14 -0500
Date: Thu, 12 Apr 2007 18:10:21 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 3/7] Convert 83xx platform to unified platform Kconfig
In-Reply-To: <Pine.LNX.4.64.0704121806330.28324@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0704121809590.28324@localhost.localdomain>
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

Moved 83xx platform Kconfig over to being sourced by the unified
arch/powerpc/platforms/Kconfig.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/Kconfig                |    1 -
 arch/powerpc/platforms/83xx/Kconfig |    6 +-----
 arch/powerpc/platforms/Kconfig      |    3 ++-
 3 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index d37e0b8..8576ff3 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -378,7 +378,6 @@ source "arch/powerpc/platforms/Kconfig"
 source arch/powerpc/platforms/embedded6xx/Kconfig
 source arch/powerpc/platforms/4xx/Kconfig
 source arch/powerpc/platforms/82xx/Kconfig
-source arch/powerpc/platforms/83xx/Kconfig
 source arch/powerpc/platforms/85xx/Kconfig
 source arch/powerpc/platforms/8xx/Kconfig

diff --git a/arch/powerpc/platforms/83xx/Kconfig b/arch/powerpc/platforms/83xx/Kconfig
index 2a23392..19cafdf 100644
--- a/arch/powerpc/platforms/83xx/Kconfig
+++ b/arch/powerpc/platforms/83xx/Kconfig
@@ -1,8 +1,6 @@
-menu "Platform support"
-	depends on PPC_83xx
-
 choice
 	prompt "Machine Type"
+	depends on PPC_83xx
 	default MPC834x_MDS

 config MPC8313_RDB
@@ -77,5 +75,3 @@ config PPC_MPC836x
 	select PPC_UDBG_16550
 	select PPC_INDIRECT_PCI
 	default y if MPC836x_MDS
-
-endmenu
diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
index 5f2cef0..d686806 100644
--- a/arch/powerpc/platforms/Kconfig
+++ b/arch/powerpc/platforms/Kconfig
@@ -1,5 +1,5 @@
 menu "Platform support"
-	depends on PPC64 || CLASSIC32 || PPC_86xx
+	depends on PPC64 || CLASSIC32 || PPC_83xx || PPC_86xx

 choice
 	prompt "Machine type"
@@ -45,6 +45,7 @@ source "arch/powerpc/platforms/pasemi/Kconfig"
 source arch/powerpc/platforms/celleb/Kconfig
 source arch/powerpc/platforms/ps3/Kconfig
 source arch/powerpc/platforms/cell/Kconfig
+source "arch/powerpc/platforms/83xx/Kconfig"
 source "arch/powerpc/platforms/86xx/Kconfig"

 config PPC_NATIVE
-- 
1.5.0.6
