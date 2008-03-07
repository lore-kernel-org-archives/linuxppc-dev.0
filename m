Return-Path: <afleming@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5CCCADDF79
	for <linuxppc-dev@ozlabs.org>; Sat,  8 Mar 2008 10:41:48 +1100 (EST)
From: Andy Fleming <afleming@freescale.com>
To: paulus@samba.org, galak@kernel.crashing.org, linuxppc-dev@ozlabs.org
Subject: [PATCH] Make 83xx perfmon support selectable
Date: Fri,  7 Mar 2008 17:41:36 -0600
Message-Id: <1204933296-28417-1-git-send-email-afleming@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Not all e300 cores support the performance monitors, and the ones
that don't will be confused by the mf/mtpmr instructions.  This
allows the support to be optional, so the 8349 can turn it off
while the 8379 can turn it on.  Sadly, those aren't config options,
so it will be left to the defconfigs and the users to make that
determination.

Signed-off-by: Andy Fleming <afleming@freescale.com>
---

This needs to go in for 2.6.25 if possible.  It breaks the build
for some boards, and would cause them to crash or perform
indefinite operations.

 arch/powerpc/platforms/Kconfig         |    1 -
 arch/powerpc/platforms/Kconfig.cputype |    7 ++++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
index 0afd225..a578b96 100644
--- a/arch/powerpc/platforms/Kconfig
+++ b/arch/powerpc/platforms/Kconfig
@@ -22,7 +22,6 @@ config PPC_83xx
 	select FSL_SOC
 	select MPC83xx
 	select IPIC
-	select FSL_EMB_PERFMON
 
 config PPC_86xx
 	bool "Freescale 86xx"
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index 73d81ce..db6e2c4 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -113,7 +113,12 @@ config FSL_BOOKE
 	default y
 
 config FSL_EMB_PERFMON
-	bool
+	bool "Freescale Embedded Perfmon"
+	depends on E500 || 83xx
+	help
+	  This is the Performance Monitor support found on the e500 core
+	  and some e300 cores (c3 and c4).  Select this only if your
+	  core supports the Embedded Performance Monitor APU
 
 config PTE_64BIT
 	bool
-- 
1.5.4.23.gef5b9
