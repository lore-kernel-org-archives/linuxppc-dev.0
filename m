Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vyVYk3LtmzDqHG
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Apr 2017 12:44:58 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [RFC PATCH 3/3] powerpc/pseries: Always enable SMP when building
 pseries
Date: Wed,  5 Apr 2017 12:44:51 +1000
Message-Id: <1491360291-30299-3-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1491360291-30299-1-git-send-email-mpe@ellerman.id.au>
References: <1491360291-30299-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The pseries platform supports Power4 and later CPUs, all of which are
multithreaded and/or multicore.

In practice no one ever builds a SMP=n kernel for these machines. So as
we did for powernv, have the pseries platform imply SMP=y.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/platforms/pseries/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/Kconfig b/arch/powerpc/platforms/pseries/Kconfig
index 30ec04f1c67c..913c54e23eea 100644
--- a/arch/powerpc/platforms/pseries/Kconfig
+++ b/arch/powerpc/platforms/pseries/Kconfig
@@ -17,9 +17,10 @@ config PPC_PSERIES
 	select PPC_UDBG_16550
 	select PPC_NATIVE
 	select PPC_DOORBELL
-	select HOTPLUG_CPU if SMP
+	select HOTPLUG_CPU
 	select ARCH_RANDOM
 	select PPC_DOORBELL
+	select FORCE_SMP
 	default y
 
 config PPC_SPLPAR
-- 
2.7.4
