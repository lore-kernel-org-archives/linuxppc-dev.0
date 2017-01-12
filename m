Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tzhXJ3DzzzDq60
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jan 2017 21:17:36 +1100 (AEDT)
From: Anton Blanchard <anton@ozlabs.org>
To: benh@kernel.crashing.org,
	paulus@samba.org,
	mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/2] powerpc/64: Move HAVE_CONTEXT_TRACKING from pseries to
 common Kconfig
Date: Thu, 12 Jan 2017 21:17:33 +1100
Message-Id: <20170112101734.5608-1-anton@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Anton Blanchard <anton@samba.org>

We added support for HAVE_CONTEXT_TRACKING, but placed the option inside
PPC_PSERIES.

This has the undesirable effect that NO_HZ_FULL can be enabled on a
kernel with both powernv and pseries support, but cannot on a kernel
with powernv only support.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/Kconfig                   | 1 +
 arch/powerpc/platforms/pseries/Kconfig | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 48001e7..f072f82 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -164,6 +164,7 @@ config PPC
 	select HAVE_ARCH_HARDENED_USERCOPY
 	select HAVE_KERNEL_GZIP
 	select HAVE_CC_STACKPROTECTOR
+	select HAVE_CONTEXT_TRACKING if PPC64
 
 config GENERIC_CSUM
 	def_bool CPU_LITTLE_ENDIAN
diff --git a/arch/powerpc/platforms/pseries/Kconfig b/arch/powerpc/platforms/pseries/Kconfig
index e1c280a..30ec04f 100644
--- a/arch/powerpc/platforms/pseries/Kconfig
+++ b/arch/powerpc/platforms/pseries/Kconfig
@@ -17,7 +17,6 @@ config PPC_PSERIES
 	select PPC_UDBG_16550
 	select PPC_NATIVE
 	select PPC_DOORBELL
-	select HAVE_CONTEXT_TRACKING
 	select HOTPLUG_CPU if SMP
 	select ARCH_RANDOM
 	select PPC_DOORBELL
-- 
2.9.3
