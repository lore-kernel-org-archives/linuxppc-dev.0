Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vyVYj5j1TzDqHG
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Apr 2017 12:44:57 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [RFC PATCH 1/3] powerpc: Allow platforms to force-enable CONFIG_SMP
Date: Wed,  5 Apr 2017 12:44:49 +1000
Message-Id: <1491360291-30299-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Of the 64-bit Book3S platforms, only powermac supports booting on an
actual non-SMP system. The other platforms can be built with SMP
disabled, but it doesn't make a lot of sense given the CPUs they support
are all multicore or multithreaded.

So give platforms the option of forcing SMP=y.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/platforms/Kconfig.cputype | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index 99b0ae8acb78..5c011e4baf0b 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -371,9 +371,15 @@ config PPC_PERF_CTRS
        help
          This enables the powerpc-specific perf_event back-end.
 
+config FORCE_SMP
+	# Allow platforms to force SMP=y by selecting this
+	bool
+	default n
+	select SMP
+
 config SMP
 	depends on PPC_BOOK3S || PPC_BOOK3E || FSL_BOOKE || PPC_47x
-	bool "Symmetric multi-processing support"
+	bool "Symmetric multi-processing support" if !FORCE_SMP
 	---help---
 	  This enables support for systems with more than one CPU. If you have
 	  a system with only one CPU, say N. If you have a system with more
-- 
2.7.4
