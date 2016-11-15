Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tHtdK1LHrzDvhf
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Nov 2016 14:47:49 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 3/3] powerpc/pseries: Disable IBMEBUS on little endian builds
Date: Tue, 15 Nov 2016 14:47:44 +1100
Message-Id: <1479181664-6699-3-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1479181664-6699-1-git-send-email-mpe@ellerman.id.au>
References: <1479181664-6699-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The IBMEBUS code supports the GX bus found on Power7 and earlier CPUs.
On Power8 it has been replaced, and so we have no need for it.

We don't actually have a config symbol for Power8 vs Power7 etc., but
we only support booting little endian on Power8 or later, so use that as
a reasonable approximation.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/platforms/pseries/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/Kconfig b/arch/powerpc/platforms/pseries/Kconfig
index fbf2e4477f88..e1c280a95d58 100644
--- a/arch/powerpc/platforms/pseries/Kconfig
+++ b/arch/powerpc/platforms/pseries/Kconfig
@@ -134,7 +134,7 @@ config IBMVIO
 	default y
 
 config IBMEBUS
-	depends on PPC_PSERIES
+	depends on PPC_PSERIES && !CPU_LITTLE_ENDIAN
 	bool "Support for GX bus based adapters"
 	help
 	  Bus device driver for GX bus based adapters.
-- 
2.7.4
