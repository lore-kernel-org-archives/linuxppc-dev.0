Return-Path: <grant.likely@secretlab.ca>
Received: from sandbox.secretlab.ca (S01060016b61d1226.cg.shawcable.net
	[68.147.191.145]) by ozlabs.org (Postfix) with ESMTP id CE4BFDDF4D
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Jan 2007 09:45:33 +1100 (EST)
From: grant.likely@secretlab.ca
To: vwool@ru.mvista.com, tnt@246tnt.com, paulus@samba.org,
	linuxppc-dev@ozlabs.org
Subject: [POWERPC] don't include powerpc/sysdev/rom.o for arch/ppc builds
Date: Tue,  2 Jan 2007 15:45:29 -0700
Message-Id: <11677779291409-git-send-email-grant.likely@secretlab.ca>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

sysdev/rom.c is for arch/powerpc only.  Don't compile it when building
an arch/ppc kernel.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

Please include for .20; without this patch you cannot use MTD on an arch/ppc
kernel for the mpc52xx.

 arch/powerpc/sysdev/Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/Makefile
index 04d4917..2621a7e 100644
--- a/arch/powerpc/sysdev/Makefile
+++ b/arch/powerpc/sysdev/Makefile
@@ -12,7 +12,6 @@ obj-$(CONFIG_MMIO_NVRAM)	+= mmio_nvram.o
 obj-$(CONFIG_FSL_SOC)		+= fsl_soc.o
 obj-$(CONFIG_TSI108_BRIDGE)	+= tsi108_pci.o tsi108_dev.o
 obj-$(CONFIG_QUICC_ENGINE)	+= qe_lib/
-obj-$(CONFIG_MTD)		+= rom.o
 
 ifeq ($(CONFIG_PPC_MERGE),y)
 obj-$(CONFIG_PPC_I8259)		+= i8259.o
@@ -21,5 +20,6 @@ endif
 
 # Temporary hack until we have migrated to asm-powerpc
 ifeq ($(ARCH),powerpc)
+obj-$(CONFIG_MTD)		+= rom.o
 obj-$(CONFIG_CPM2)		+= cpm2_common.o cpm2_pic.o
 endif
-- 
1.4.3.rc2.g0503
