Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 94D81DDDFF
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2008 23:41:39 +1100 (EST)
Date: Wed, 23 Jan 2008 06:38:29 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] [POWERPC] Move RapidIO support code from arch/ppc
Message-ID: <Pine.LNX.4.64.0801230637510.4478@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Wei.Zhang@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Do just enough to move the RapidIO support code for 85xx over from arch/ppc
into arch/powerpc and make it still build.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/kernel/Makefile                       |    1 +
 arch/{ppc => powerpc}/kernel/rio.c                 |    0
 arch/powerpc/sysdev/Makefile                       |    1 +
 .../ppc85xx_rio.c => powerpc/sysdev/fsl_rio.c}     |    0
 .../ppc85xx_rio.h => powerpc/sysdev/fsl_rio.h}     |    0
 arch/ppc/kernel/Makefile                           |    1 -
 arch/ppc/platforms/85xx/mpc85xx_ads_common.c       |    3 +--
 arch/ppc/platforms/85xx/stx_gp3.c                  |    2 +-
 arch/ppc/platforms/85xx/tqm85xx.c                  |    2 +-
 arch/ppc/syslib/Makefile                           |    1 -
 10 files changed, 5 insertions(+), 6 deletions(-)
 rename arch/{ppc => powerpc}/kernel/rio.c (100%)
 rename arch/{ppc/syslib/ppc85xx_rio.c => powerpc/sysdev/fsl_rio.c} (100%)
 rename arch/{ppc/syslib/ppc85xx_rio.h => powerpc/sysdev/fsl_rio.h} (100%)

diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index d9b3770..58dbfef 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -70,6 +70,7 @@ pci64-$(CONFIG_PPC64)		+= pci_dn.o isa-bridge.o
 obj-$(CONFIG_PCI)		+= pci_$(CONFIG_WORD_SIZE).o $(pci64-y) \
 				   pci-common.o
 obj-$(CONFIG_PCI_MSI)		+= msi.o
+obj-$(CONFIG_RAPIDIO)		+= rio.o
 obj-$(CONFIG_KEXEC)		+= machine_kexec.o crash.o \
 				   machine_kexec_$(CONFIG_WORD_SIZE).o
 obj-$(CONFIG_AUDIT)		+= audit.o
diff --git a/arch/ppc/kernel/rio.c b/arch/powerpc/kernel/rio.c
similarity index 100%
rename from arch/ppc/kernel/rio.c
rename to arch/powerpc/kernel/rio.c
diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/Makefile
index 66fe39c..f17e7b8 100644
--- a/arch/powerpc/sysdev/Makefile
+++ b/arch/powerpc/sysdev/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_U3_DART)		+= dart_iommu.o
 obj-$(CONFIG_MMIO_NVRAM)	+= mmio_nvram.o
 obj-$(CONFIG_FSL_SOC)		+= fsl_soc.o
 obj-$(CONFIG_FSL_PCI)		+= fsl_pci.o
+obj-$(CONFIG_RAPIDIO)		+= fsl_rio.o
 obj-$(CONFIG_TSI108_BRIDGE)	+= tsi108_pci.o tsi108_dev.o
 obj-$(CONFIG_QUICC_ENGINE)	+= qe_lib/
 obj-$(CONFIG_PPC_BESTCOMM)	+= bestcomm/
diff --git a/arch/ppc/syslib/ppc85xx_rio.c b/arch/powerpc/sysdev/fsl_rio.c
similarity index 100%
rename from arch/ppc/syslib/ppc85xx_rio.c
rename to arch/powerpc/sysdev/fsl_rio.c
diff --git a/arch/ppc/syslib/ppc85xx_rio.h b/arch/powerpc/sysdev/fsl_rio.h
similarity index 100%
rename from arch/ppc/syslib/ppc85xx_rio.h
rename to arch/powerpc/sysdev/fsl_rio.h
diff --git a/arch/ppc/kernel/Makefile b/arch/ppc/kernel/Makefile
index 6b4f022..5da0ca7 100644
--- a/arch/ppc/kernel/Makefile
+++ b/arch/ppc/kernel/Makefile
@@ -13,7 +13,6 @@ obj-y				:= entry.o traps.o time.o misc.o \
 					ppc_htab.o
 obj-$(CONFIG_MODULES)		+= ppc_ksyms.o
 obj-$(CONFIG_PCI)		+= pci.o
-obj-$(CONFIG_RAPIDIO)		+= rio.o
 obj-$(CONFIG_KGDB)		+= ppc-stub.o
 obj-$(CONFIG_SMP)		+= smp.o smp-tbsync.o
 obj-$(CONFIG_KEXEC)		+= machine_kexec.o relocate_kernel.o
diff --git a/arch/ppc/platforms/85xx/mpc85xx_ads_common.c b/arch/ppc/platforms/85xx/mpc85xx_ads_common.c
index 674806e..0706dca 100644
--- a/arch/ppc/platforms/85xx/mpc85xx_ads_common.c
+++ b/arch/ppc/platforms/85xx/mpc85xx_ads_common.c
@@ -42,8 +42,6 @@

 #include <mm/mmu_decl.h>

-#include <syslib/ppc85xx_rio.h>
-
 #include <platforms/85xx/mpc85xx_ads_common.h>

 #ifndef CONFIG_PCI
@@ -190,6 +188,7 @@ mpc85xx_exclude_device(u_char bus, u_char devfn)
 #endif /* CONFIG_PCI */

 #ifdef CONFIG_RAPIDIO
+extern void mpc85xx_rio_setup(int law_start, int law_size);
 void platform_rio_init(void)
 {
 	/* 512MB RIO LAW at 0xc0000000 */
diff --git a/arch/ppc/platforms/85xx/stx_gp3.c b/arch/ppc/platforms/85xx/stx_gp3.c
index 731b40e..8748da3 100644
--- a/arch/ppc/platforms/85xx/stx_gp3.c
+++ b/arch/ppc/platforms/85xx/stx_gp3.c
@@ -54,7 +54,6 @@

 #include <syslib/cpm2_pic.h>
 #include <syslib/ppc85xx_common.h>
-#include <syslib/ppc85xx_rio.h>


 unsigned char __res[sizeof(bd_t)];
@@ -270,6 +269,7 @@ int mpc85xx_exclude_device(u_char bus, u_char devfn)
 #endif /* CONFIG_PCI */

 #ifdef CONFIG_RAPIDIO
+extern void mpc85xx_rio_setup(int law_start, int law_size);
 void
 platform_rio_init(void)
 {
diff --git a/arch/ppc/platforms/85xx/tqm85xx.c b/arch/ppc/platforms/85xx/tqm85xx.c
index 4ee2bd1..2a863a8 100644
--- a/arch/ppc/platforms/85xx/tqm85xx.c
+++ b/arch/ppc/platforms/85xx/tqm85xx.c
@@ -54,7 +54,6 @@
 #include <syslib/ppc85xx_setup.h>
 #include <syslib/cpm2_pic.h>
 #include <syslib/ppc85xx_common.h>
-#include <syslib/ppc85xx_rio.h>

 #ifndef CONFIG_PCI
 unsigned long isa_io_base = 0;
@@ -309,6 +308,7 @@ int mpc85xx_exclude_device(u_char bus, u_char devfn)
 #endif /* CONFIG_PCI */

 #ifdef CONFIG_RAPIDIO
+extern void mpc85xx_rio_setup(int law_start, int law_size);
 void platform_rio_init(void)
 {
 	/* 512MB RIO LAW at 0xc0000000 */
diff --git a/arch/ppc/syslib/Makefile b/arch/ppc/syslib/Makefile
index 543795b..5e16228 100644
--- a/arch/ppc/syslib/Makefile
+++ b/arch/ppc/syslib/Makefile
@@ -93,7 +93,6 @@ obj-$(CONFIG_85xx)		+= open_pic.o ppc85xx_common.o ppc85xx_setup.o \
 ifeq ($(CONFIG_85xx),y)
 obj-$(CONFIG_PCI)		+= pci_auto.o
 endif
-obj-$(CONFIG_RAPIDIO)		+= ppc85xx_rio.o
 obj-$(CONFIG_83xx)		+= ppc83xx_setup.o ppc_sys.o \
 					mpc83xx_sys.o mpc83xx_devices.o ipic.o
 ifeq ($(CONFIG_83xx),y)
-- 
1.5.3.7
