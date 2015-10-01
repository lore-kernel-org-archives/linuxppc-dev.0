Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8DB0B1A00C5
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Oct 2015 16:44:37 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 1/4] powerpc/pseries: Make PCI non-optional
Date: Thu,  1 Oct 2015 16:44:31 +1000
Message-Id: <1443681874-28145-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The pseries build with PCI=n looks to have been broken for at least 5
years, and no one's noticed or cared.

Following the obvious breakages backward, the first commit I can find
that builds is the parent of 2eb4afb69ff3 ("powerpc/pci: Move pseries
code into pseries platform specific area") from April 2009.

A distro would never ship a PCI=n kernel, so it is only useful for folks
building custom kernels. Also on KVM the virtio devices appear on PCI,
so it would only be useful if you were building kernels specifically to
run on PowerVM and with no PCI devices.

The added code complexity, and testing load (which we've clearly not
been doing), is not justified by the small reduction in kernel size for
such a niche use case.

So just make PCI non-optional on pseries.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/platforms/pseries/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/Kconfig b/arch/powerpc/platforms/pseries/Kconfig
index 54c87d5d349d..d9068a3d6af4 100644
--- a/arch/powerpc/platforms/pseries/Kconfig
+++ b/arch/powerpc/platforms/pseries/Kconfig
@@ -4,6 +4,7 @@ config PPC_PSERIES
 	select HAVE_PCSPKR_PLATFORM
 	select MPIC
 	select OF_DYNAMIC
+	select PCI
 	select PCI_MSI
 	select PPC_XICS
 	select PPC_ICP_NATIVE
@@ -15,7 +16,6 @@ config PPC_PSERIES
 	select RTAS_ERROR_LOGGING
 	select PPC_UDBG_16550
 	select PPC_NATIVE
-	select PPC_PCI_CHOICE if EXPERT
 	select PPC_DOORBELL
 	select HAVE_CONTEXT_TRACKING
 	select HOTPLUG_CPU if SMP
-- 
2.1.4
