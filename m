Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 8652D67B85
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Sep 2006 13:42:46 +1000 (EST)
Date: Tue, 26 Sep 2006 13:39:10 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH 5/7] [POWERPC] Allow combined iSeries and MULTIPLATFORM build
Message-Id: <20060926133910.23948614.sfr@canb.auug.org.au>
In-Reply-To: <20060926133756.071a981f.sfr@canb.auug.org.au>
References: <20060926133413.8ca8142e.sfr@canb.auug.org.au>
	<20060926133548.43afd711.sfr@canb.auug.org.au>
	<20060926133651.897ad602.sfr@canb.auug.org.au>
	<20060926133756.071a981f.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This will build with ISERIES, PSERIES and PMAC64 selected, but will only
boot on iSeries so far.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/Kconfig |   20 +++++++++-----------
 1 files changed, 9 insertions(+), 11 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index de1ef2f..a715b28 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -328,20 +328,10 @@ menu "Platform support"
 	depends on PPC64 || CLASSIC32
 
 choice
+	depends on PPC32
 	prompt "Machine type"
 	default PPC_MULTIPLATFORM
 
-config PPC_MULTIPLATFORM
-	bool "Generic desktop/server/laptop"
-	help
-	  Select this option if configuring for an IBM pSeries or
-	  RS/6000 machine, an Apple machine, or a PReP, CHRP,
-	  Maple or Cell-based machine.
-
-config PPC_ISERIES
-	bool "IBM Legacy iSeries"
-	depends on PPC64
-
 config EMBEDDED6xx
 	bool "Embedded 6xx/7xx/7xxx-based board"
 	depends on PPC32 && (BROKEN||BROKEN_ON_SMP)
@@ -355,6 +345,10 @@ config APUS
 	  <http://linux-apus.sourceforge.net/>.
 endchoice
 
+config PPC_MULTIPLATFORM
+	depends on PPC64
+	def_bool y
+
 config PPC_PSERIES
 	depends on PPC_MULTIPLATFORM && PPC64
 	bool "IBM pSeries & new (POWER5-based) iSeries"
@@ -365,6 +359,10 @@ config PPC_PSERIES
 	select PPC_UDBG_16550
 	default y
 
+config PPC_ISERIES
+	bool "IBM Legacy iSeries"
+	depends on PPC_MULTIPLATFORM && PPC64
+
 config PPC_CHRP
 	bool "Common Hardware Reference Platform (CHRP) based machines"
 	depends on PPC_MULTIPLATFORM && PPC32
-- 
1.4.2.1
