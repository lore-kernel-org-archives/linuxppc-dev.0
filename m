Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vyVYk0NzVzDqHG
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Apr 2017 12:44:58 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [RFC PATCH 2/3] powerpc/powernv: Always enable SMP when building
 powernv
Date: Wed,  5 Apr 2017 12:44:50 +1000
Message-Id: <1491360291-30299-2-git-send-email-mpe@ellerman.id.au>
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

The powernv platform supports Power7 and later CPUs, all of which are
multithreaded and multicore.

As such we never build a SMP=n kernel for those machines, other than
possibly for debugging or running in a simulator.

In the debugging case we can get a similar effect by booting with
nr_cpus=1, or there's always the option of building a custom kernel with
SMP hacked out.

For running in simulators the code size reduction from building without
SMP is not particularly important, what matters is the number of
instructions executed. A quick test shows that a SMP=y kernel takes ~6%
more instructions to boot to a shell. Booting with nr_cpus=1 recovers
about half that deficit.

On the flip side, keeping the SMP=n kernel building can be a pain at
times. And although we've mostly kept it building in recent years, no
one is regularly testing that the SMP=n kernel actually boots and works
well on these machines.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/platforms/powernv/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/platforms/powernv/Kconfig b/arch/powerpc/platforms/powernv/Kconfig
index 3a07e4dcf97c..bd8d41d3a1b3 100644
--- a/arch/powerpc/platforms/powernv/Kconfig
+++ b/arch/powerpc/platforms/powernv/Kconfig
@@ -19,6 +19,7 @@ config PPC_POWERNV
 	select CPU_FREQ_GOV_ONDEMAND
 	select CPU_FREQ_GOV_CONSERVATIVE
 	select PPC_DOORBELL
+	select FORCE_SMP
 	default y
 
 config OPAL_PRD
-- 
2.7.4
