Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9B27CDDED8
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Mar 2007 02:26:11 +1100 (EST)
Received: from [72.183.106.80] (helo=[192.168.1.2])
	by nommos.sslcatacombnetworking.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.63) (envelope-from <galak@kernel.crashing.org>)
	id 1HSEJk-0007xE-GV
	for linuxppc-dev@ozlabs.org; Fri, 16 Mar 2007 10:26:08 -0500
Date: Fri, 16 Mar 2007 10:22:50 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH][POWERPC] [002/006] Split powermac platforms into their own
	Kconfig file
In-Reply-To: <Pine.LNX.4.64.0703161016520.9740@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0703161021430.9740@localhost.localdomain>
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


>From 7b3e208ad495435a79a65dccf0324a14eef44ee4 Mon Sep 17 00:00:00 2001
From: Kumar Gala <galak@kernel.crashing.org>
Date: Thu, 15 Mar 2007 18:15:07 -0500
Subject: [PATCH] [POWERPC] Split powermac platforms into their own Kconfig file

Cleaning up arch/powerpc/Kconfig platform support.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/Kconfig                    |   20 +-------------------
 arch/powerpc/platforms/powermac/Kconfig |   20 ++++++++++++++++++++
 2 files changed, 21 insertions(+), 19 deletions(-)
 create mode 100644 arch/powerpc/platforms/powermac/Kconfig

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index b9bffe7..ecc4302 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -433,25 +433,7 @@ config PPC_CHRP
 	default y

 source "arch/powerpc/platforms/52xx/Kconfig"
-
-config PPC_PMAC
-	bool "Apple PowerMac based machines"
-	depends on PPC_MULTIPLATFORM
-	select MPIC
-	select PPC_INDIRECT_PCI if PPC32
-	select PPC_MPC106 if PPC32
-	select PPC_NATIVE
-	default y
-
-config PPC_PMAC64
-	bool
-	depends on PPC_PMAC && POWER4
-	select MPIC
-	select U3_DART
-	select MPIC_BROKEN_U3
-	select GENERIC_TBSYNC
-	select PPC_970_NAP
-	default y
+source "arch/powerpc/platforms/powermac/Kconfig"

 config PPC_PREP
 	bool "PowerPC Reference Platform (PReP) based machines"
diff --git a/arch/powerpc/platforms/powermac/Kconfig b/arch/powerpc/platforms/powermac/Kconfig
new file mode 100644
index 0000000..02d9c7d
--- /dev/null
+++ b/arch/powerpc/platforms/powermac/Kconfig
@@ -0,0 +1,20 @@
+config PPC_PMAC
+	bool "Apple PowerMac based machines"
+	depends on PPC_MULTIPLATFORM
+	select MPIC
+	select PPC_INDIRECT_PCI if PPC32
+	select PPC_MPC106 if PPC32
+	select PPC_NATIVE
+	default y
+
+config PPC_PMAC64
+	bool
+	depends on PPC_PMAC && POWER4
+	select MPIC
+	select U3_DART
+	select MPIC_BROKEN_U3
+	select GENERIC_TBSYNC
+	select PPC_970_NAP
+	default y
+
+
-- 
1.5.0.2
