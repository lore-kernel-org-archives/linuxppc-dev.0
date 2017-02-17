Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vPjt21wwrzDqN0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Feb 2017 17:34:18 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/powernv: Make PCI non-optional
Date: Fri, 17 Feb 2017 17:34:13 +1100
Message-Id: <1487313253-22846-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Bare metal systems without PCI don't exist, so there's no real point in
making PCI optional, it just breaks the build from time to time. In fact
the build is broken now if you turn off PCI_MSI but enable KVM.

Using select for PCI is OK because we (powerpc) define config PCI, and it
has no dependencies. Selecting PCI_MSI is slightly fishy, because it's
in drivers/pci and it is user-visible, but its only dependency is PCI,
so selecting it can't actually lead to breakage.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/platforms/powernv/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/Kconfig b/arch/powerpc/platforms/powernv/Kconfig
index 604190cab522..3a07e4dcf97c 100644
--- a/arch/powerpc/platforms/powernv/Kconfig
+++ b/arch/powerpc/platforms/powernv/Kconfig
@@ -5,7 +5,8 @@ config PPC_POWERNV
 	select PPC_XICS
 	select PPC_ICP_NATIVE
 	select PPC_P7_NAP
-	select PPC_PCI_CHOICE if EMBEDDED
+	select PCI
+	select PCI_MSI
 	select EPAPR_BOOT
 	select PPC_INDIRECT_PIO
 	select PPC_UDBG_16550
-- 
2.7.4
