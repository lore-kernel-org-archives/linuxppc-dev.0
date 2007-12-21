Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 8C542DDE0F
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Dec 2007 15:37:07 +1100 (EST)
Date: Fri, 21 Dec 2007 15:37:07 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH] [POWERPC] Make non-PCI build work again
Message-Id: <20071221153707.5195fc8f.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Maple and pasemi both require PCI as does CONFIG_OF_PLATFORM_PCI.
The default setting of CONFIG_ISA_DMA_API is set to match the protection
around the relevant routines in asm/dma.h.

I also had to remove the PMAC platform from the combined build.  The
precis is that to build a 64 bit kernel with no PCI, you can only include
pSeries and iSeries.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/Kconfig                  |    3 ++-
 arch/powerpc/platforms/maple/Kconfig  |    1 +
 arch/powerpc/platforms/pasemi/Kconfig |    1 +
 3 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 232c298..d40844f 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -160,6 +160,7 @@ config PPC_DCR
 
 config PPC_OF_PLATFORM_PCI
 	bool
+	depends on PCI
 	depends on PPC64 # not supported on 32 bits yet
 	default n
 
@@ -417,7 +418,7 @@ endmenu
 
 config ISA_DMA_API
 	bool
-	default y
+	default !PPC_ISERIES || PCI
 
 menu "Bus options"
 
diff --git a/arch/powerpc/platforms/maple/Kconfig b/arch/powerpc/platforms/maple/Kconfig
index f7c95eb..a6467a5 100644
--- a/arch/powerpc/platforms/maple/Kconfig
+++ b/arch/powerpc/platforms/maple/Kconfig
@@ -1,6 +1,7 @@
 config PPC_MAPLE
 	depends on PPC_MULTIPLATFORM && PPC64
 	bool "Maple 970FX Evaluation Board"
+	select PCI
 	select MPIC
 	select U3_DART
 	select MPIC_U3_HT_IRQS
diff --git a/arch/powerpc/platforms/pasemi/Kconfig b/arch/powerpc/platforms/pasemi/Kconfig
index 2f4dd6e..b3458a1 100644
--- a/arch/powerpc/platforms/pasemi/Kconfig
+++ b/arch/powerpc/platforms/pasemi/Kconfig
@@ -3,6 +3,7 @@ config PPC_PASEMI
 	bool "PA Semi SoC-based platforms"
 	default n
 	select MPIC
+	select PCI
 	select PPC_UDBG_16550
 	select PPC_NATIVE
 	select MPIC_BROKEN_REGREAD
-- 
1.5.3.7

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
