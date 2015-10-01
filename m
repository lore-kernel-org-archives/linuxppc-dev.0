Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F3B4F1A00C5
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Oct 2015 16:44:37 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 3/4] powerpc/pseries: Move PCI objects to obj-y
Date: Thu,  1 Oct 2015 16:44:33 +1000
Message-Id: <1443681874-28145-3-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1443681874-28145-1-git-send-email-mpe@ellerman.id.au>
References: <1443681874-28145-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Make it entirely clear in the Makefile that we always build the pci
related files by moving them to obj-y.

Note that CONFIG_EEH is now always enabled on pseries, because it
depends on PSERIES && PCI.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/platforms/pseries/Makefile | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/Makefile b/arch/powerpc/platforms/pseries/Makefile
index 03480796af9a..952f4ba0546e 100644
--- a/arch/powerpc/platforms/pseries/Makefile
+++ b/arch/powerpc/platforms/pseries/Makefile
@@ -3,12 +3,11 @@ ccflags-$(CONFIG_PPC_PSERIES_DEBUG)	+= -DDEBUG
 
 obj-y			:= lpar.o hvCall.o nvram.o reconfig.o \
 			   setup.o iommu.o event_sources.o ras.o \
-			   firmware.o power.o dlpar.o mobility.o rng.o
+			   firmware.o power.o dlpar.o mobility.o rng.o \
+			   pci.o pci_dlpar.o eeh_pseries.o
 obj-$(CONFIG_SMP)	+= smp.o
 obj-$(CONFIG_SCANLOG)	+= scanlog.o
-obj-$(CONFIG_EEH)	+= eeh_pseries.o
 obj-$(CONFIG_KEXEC)	+= kexec.o
-obj-$(CONFIG_PCI)	+= pci.o pci_dlpar.o
 obj-$(CONFIG_PSERIES_MSI)	+= msi.o
 obj-$(CONFIG_PSERIES_ENERGY)	+= pseries_energy.o
 
-- 
2.1.4
