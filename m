Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A7C6ADDE2D
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Apr 2007 09:13:20 +1000 (EST)
Received: from [72.183.106.80] (helo=[192.168.1.2])
	by nommos.sslcatacombnetworking.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.63) (envelope-from <galak@kernel.crashing.org>)
	id 1Hc8Td-0002Zn-5n
	for linuxppc-dev@ozlabs.org; Thu, 12 Apr 2007 18:13:17 -0500
Date: Thu, 12 Apr 2007 18:09:24 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/7] Ensure platform CONFIG options have correct dependencies
In-Reply-To: <Pine.LNX.4.64.0704121806330.28324@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0704121808450.28324@localhost.localdomain>
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

We currently support TAU and CPU frequency scaling only on discrete
(non-SOC) processors.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/platforms/Kconfig |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
index 161ab79..176a27f 100644
--- a/arch/powerpc/platforms/Kconfig
+++ b/arch/powerpc/platforms/Kconfig
@@ -3,6 +3,7 @@ menu "Platform support"

 choice
 	prompt "Machine type"
+	depends on PPC64 || CLASSIC32
 	default PPC_MULTIPLATFORM

 config PPC_MULTIPLATFORM
@@ -137,6 +138,9 @@ config GENERIC_IOMAP
 	bool
 	default n

+menu "CPU Frequency support"
+	depends on PPC64 || CLASSIC32
+
 source "drivers/cpufreq/Kconfig"

 config CPU_FREQ_PMAC
@@ -155,6 +159,7 @@ config CPU_FREQ_PMAC64
 	help
 	  This adds support for frequency switching on Apple iMac G5,
 	  and some of the more recent desktop G5 machines as well.
+endmenu

 config PPC601_SYNC_FIX
 	bool "Workarounds for PPC601 bugs"
@@ -172,7 +177,7 @@ config PPC601_SYNC_FIX

 config TAU
 	bool "On-chip CPU temperature sensor support"
-	depends on 6xx
+	depends on CLASSIC32
 	help
 	  G3 and G4 processors have an on-chip temperature sensor called the
 	  'Thermal Assist Unit (TAU)', which, in theory, can measure the on-die
-- 
1.5.0.6
