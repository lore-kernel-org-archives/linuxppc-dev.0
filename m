Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8930EB6F67
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Jul 2011 01:00:47 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] powerpc/64: Make server perfmon only built on ppc64 server
	devices
Date: Wed, 13 Jul 2011 10:00:41 -0500
Message-Id: <1310569241-18267-1-git-send-email-galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The 64-bit Book-E parts (to date) dont utilize the 'server' class
perfmon.  So building or depending on it makes no sense (and does break
FSL Book-E 64-bit support).  Move the selection of PPC_HAVE_PMU_SUPPORT
to be based on PPC_BOOK3S_64.

Based on a patch from Scott Wood.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/platforms/Kconfig.cputype |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index 9abc655..50cc4d3 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -1,7 +1,6 @@
 config PPC64
 	bool "64-bit kernel"
 	default n
-	select PPC_HAVE_PMU_SUPPORT
 	help
 	  This option selects whether a 32-bit or a 64-bit kernel
 	  will be built.
@@ -70,6 +69,7 @@ config PPC_BOOK3S_64
 	bool "Server processors"
 	select PPC_FPU
 	select SYS_SUPPORTS_HUGETLBFS
+	select PPC_HAVE_PMU_SUPPORT
 
 config PPC_BOOK3E_64
 	bool "Embedded processors"
-- 
1.7.3.4
