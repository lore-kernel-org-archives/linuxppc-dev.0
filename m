Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc/pseries: Select ARCH_RANDOM on pseries
Date: Tue, 10 Dec 2013 14:02:49 +1100
Message-Id: <1386644569-4882-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We have a driver for the ARCH_RANDOM hook in rng.c, so we should select
ARCH_RANDOM on pseries.

Without this the build breaks if you turn ARCH_RANDOM off.

This hasn't broken the build because pseries_defconfig doesn't specify a
value for PPC_POWERNV, which is default y, and selects ARCH_RANDOM.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/platforms/pseries/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/platforms/pseries/Kconfig b/arch/powerpc/platforms/pseries/Kconfig
index 62b4f80..c8fe7be 100644
--- a/arch/powerpc/platforms/pseries/Kconfig
+++ b/arch/powerpc/platforms/pseries/Kconfig
@@ -20,6 +20,7 @@ config PPC_PSERIES
 	select PPC_DOORBELL
 	select HAVE_CONTEXT_TRACKING
 	select HOTPLUG_CPU if SMP
+	select ARCH_RANDOM
 	default y
 
 config PPC_SPLPAR
-- 
1.8.3.2
