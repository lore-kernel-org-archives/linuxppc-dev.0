Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 2/2] powerpc/powernv: Replace CONFIG_POWERNV_MSI with just
 CONFIG_PPC_POWERNV
Date: Thu, 26 Sep 2013 17:52:17 +1000
Message-Id: <1380181937-15156-2-git-send-email-michael@ellerman.id.au>
In-Reply-To: <1380181937-15156-1-git-send-email-michael@ellerman.id.au>
References: <1380181937-15156-1-git-send-email-michael@ellerman.id.au>
Cc: shangw@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We currently have a user visible CONFIG_POWERNV_MSI option, but it
doesn't actually disable MSI for powernv. The MSI code is always built,
what it does disable is the inclusion of the MSI bitmap code, which
leads to a build error.

eg, with PPC_POWERNV=y and POWERNV_MSI=n we get:

  arch/powerpc/platforms/built-in.o: In function `.pnv_teardown_msi_irqs':
  pci.c:(.text+0x3558): undefined reference to `.msi_bitmap_free_hwirqs'

We don't really need a POWERNV_MSI symbol, just have the MSI bitmap code
depend directly on PPC_POWERNV.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/platforms/powernv/Kconfig | 5 -----
 arch/powerpc/sysdev/Kconfig            | 2 +-
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/Kconfig b/arch/powerpc/platforms/powernv/Kconfig
index 6fae5eb..09a5afd 100644
--- a/arch/powerpc/platforms/powernv/Kconfig
+++ b/arch/powerpc/platforms/powernv/Kconfig
@@ -11,11 +11,6 @@ config PPC_POWERNV
 	select PPC_UDBG_16550
 	default y
 
-config POWERNV_MSI
-	bool "Support PCI MSI on PowerNV platform"
-	depends on PCI_MSI
-	default y
-
 config PPC_POWERNV_RTAS
 	depends on PPC_POWERNV
 	bool "Support for RTAS based PowerNV platforms such as BML"
diff --git a/arch/powerpc/sysdev/Kconfig b/arch/powerpc/sysdev/Kconfig
index ab4cb54..8223f78 100644
--- a/arch/powerpc/sysdev/Kconfig
+++ b/arch/powerpc/sysdev/Kconfig
@@ -19,7 +19,7 @@ config PPC_MSI_BITMAP
 	default y if MPIC
 	default y if FSL_PCI
 	default y if PPC4xx_MSI
-	default y if POWERNV_MSI
+	default y if PPC_POWERNV
 
 source "arch/powerpc/sysdev/xics/Kconfig"
 
-- 
1.8.1.2
