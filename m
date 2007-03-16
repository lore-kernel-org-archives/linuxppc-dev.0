Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D17E3DDED2
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Mar 2007 02:24:58 +1100 (EST)
Received: from [72.183.106.80] (helo=[192.168.1.2])
	by nommos.sslcatacombnetworking.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.63) (envelope-from <galak@kernel.crashing.org>)
	id 1HSEIZ-0006xz-VK
	for linuxppc-dev@ozlabs.org; Fri, 16 Mar 2007 10:24:56 -0500
Date: Fri, 16 Mar 2007 10:21:37 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] [POWERPC] [001/006] Split 52xx platforms into their own
	Kconfig file
In-Reply-To: <Pine.LNX.4.64.0703161016520.9740@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0703161018350.9740@localhost.localdomain>
References: <Pine.LNX.4.64.0703161016520.9740@localhost.localdomain>
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

Cleaning up arch/powerpc/Kconfig platform support.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/Kconfig                |   34 +---------------------------------
 arch/powerpc/platforms/52xx/Kconfig |   35 +++++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+), 33 deletions(-)
 create mode 100644 arch/powerpc/platforms/52xx/Kconfig

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index e720527..b9bffe7 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -432,39 +432,7 @@ config PPC_CHRP
 	select PPC_NATIVE
 	default y

-config PPC_MPC52xx
-	bool
-	default n
-
-config PPC_MPC5200
-	bool
-	select PPC_MPC52xx
-	default n
-
-config PPC_MPC5200_BUGFIX
-	bool "MPC5200 (L25R) bugfix support"
-	depends on PPC_MPC5200
-	default n
-	help
-	  Enable workarounds for original MPC5200 errata.  This is not required
-	  for MPC5200B based boards.
-
-	  It is safe to say 'Y' here
-
-config PPC_EFIKA
-	bool "bPlan Efika 5k2. MPC5200B based computer"
-	depends on PPC_MULTIPLATFORM && PPC32
-	select PPC_RTAS
-	select RTAS_PROC
-	select PPC_MPC52xx
-	select PPC_NATIVE
-	default n
-
-config PPC_LITE5200
-	bool "Freescale Lite5200 Eval Board"
-	depends on PPC_MULTIPLATFORM && PPC32
-	select PPC_MPC5200
-	default n
+source "arch/powerpc/platforms/52xx/Kconfig"

 config PPC_PMAC
 	bool "Apple PowerMac based machines"
diff --git a/arch/powerpc/platforms/52xx/Kconfig b/arch/powerpc/platforms/52xx/Kconfig
new file mode 100644
index 0000000..bc4aa4a
--- /dev/null
+++ b/arch/powerpc/platforms/52xx/Kconfig
@@ -0,0 +1,35 @@
+config PPC_MPC52xx
+	bool
+	default n
+
+config PPC_MPC5200
+	bool
+	select PPC_MPC52xx
+	default n
+
+config PPC_MPC5200_BUGFIX
+	bool "MPC5200 (L25R) bugfix support"
+	depends on PPC_MPC5200
+	default n
+	help
+	  Enable workarounds for original MPC5200 errata.  This is not required
+	  for MPC5200B based boards.
+
+	  It is safe to say 'Y' here
+
+config PPC_EFIKA
+	bool "bPlan Efika 5k2. MPC5200B based computer"
+	depends on PPC_MULTIPLATFORM && PPC32
+	select PPC_RTAS
+	select RTAS_PROC
+	select PPC_MPC52xx
+	select PPC_NATIVE
+	default n
+
+config PPC_LITE5200
+	bool "Freescale Lite5200 Eval Board"
+	depends on PPC_MULTIPLATFORM && PPC32
+	select PPC_MPC5200
+	default n
+
+
-- 
1.5.0.2
