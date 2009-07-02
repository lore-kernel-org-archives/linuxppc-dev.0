Return-Path: <martyn.welch@gefanuc.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 1D24CB710B
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  3 Jul 2009 02:15:03 +1000 (EST)
Received: from exprod5og104.obsmtp.com (exprod5og104.obsmtp.com [64.18.0.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D6E5FDDD04
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Jul 2009 02:15:01 +1000 (EST)
From: Martyn Welch <martyn.welch@gefanuc.com>
Subject: [PATCH 4/5] powerpc/86xx: Support for NVRAM on GE Fanuc's SBC310
To: linuxppc-dev@ozlabs.org
Date: Thu, 02 Jul 2009 17:12:37 +0100
Message-ID: <20090702161237.31202.95547.stgit@ES-J7S4D2J.amer.consind.ge.com>
In-Reply-To: <20090702154928.31202.65107.stgit@ES-J7S4D2J.amer.consind.ge.com>
References: <20090702154928.31202.65107.stgit@ES-J7S4D2J.amer.consind.ge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add support for NVRAM on GE Fanuc's SBC310.

Signed-off-by: Martyn Welch <martyn.welch@gefanuc.com>
---

 arch/powerpc/boot/dts/gef_sbc310.dts           |    6 ++++++
 arch/powerpc/configs/86xx/gef_sbc310_defconfig |    4 ++--
 arch/powerpc/platforms/86xx/Kconfig            |    1 +
 arch/powerpc/platforms/86xx/gef_sbc310.c       |    5 +++++
 4 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/dts/gef_sbc310.dts b/arch/powerpc/boot/dts/gef_sbc310.dts
index 2107d3c..820c2b3 100644
--- a/arch/powerpc/boot/dts/gef_sbc310.dts
+++ b/arch/powerpc/boot/dts/gef_sbc310.dts
@@ -115,6 +115,12 @@
 			};
 		};
 
+		nvram@3,0 {
+			device_type = "nvram";
+			compatible = "simtek,stk14ca8";
+			reg = <0x3 0x0 0x20000>;
+		};
+
 		fpga@4,0 {
 			compatible = "gef,fpga-regs";
 			reg = <0x4 0x0 0x40>;
diff --git a/arch/powerpc/configs/86xx/gef_sbc310_defconfig b/arch/powerpc/configs/86xx/gef_sbc310_defconfig
index f2362e5..3d70f2a 100644
--- a/arch/powerpc/configs/86xx/gef_sbc310_defconfig
+++ b/arch/powerpc/configs/86xx/gef_sbc310_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
 # Linux kernel version: 2.6.30
-# Thu Jul  2 14:10:12 2009
+# Thu Jul  2 14:10:51 2009
 #
 # CONFIG_PPC64 is not set
 
@@ -214,7 +214,7 @@ CONFIG_MPIC=y
 # CONFIG_MPIC_WEIRD is not set
 # CONFIG_PPC_I8259 is not set
 # CONFIG_PPC_RTAS is not set
-# CONFIG_MMIO_NVRAM is not set
+CONFIG_MMIO_NVRAM=y
 # CONFIG_PPC_MPC106 is not set
 # CONFIG_PPC_970_NAP is not set
 # CONFIG_PPC_INDIRECT_IO is not set
diff --git a/arch/powerpc/platforms/86xx/Kconfig b/arch/powerpc/platforms/86xx/Kconfig
index 9d02dea..6012022 100644
--- a/arch/powerpc/platforms/86xx/Kconfig
+++ b/arch/powerpc/platforms/86xx/Kconfig
@@ -43,6 +43,7 @@ config GEF_PPC9A
 config GEF_SBC310
 	bool "GE Fanuc SBC310"
 	select DEFAULT_UIMAGE
+	select MMIO_NVRAM
 	select GENERIC_GPIO
 	select ARCH_REQUIRE_GPIOLIB
 	help
diff --git a/arch/powerpc/platforms/86xx/gef_sbc310.c b/arch/powerpc/platforms/86xx/gef_sbc310.c
index 90754e7..6a1a613 100644
--- a/arch/powerpc/platforms/86xx/gef_sbc310.c
+++ b/arch/powerpc/platforms/86xx/gef_sbc310.c
@@ -33,6 +33,7 @@
 #include <asm/udbg.h>
 
 #include <asm/mpic.h>
+#include <asm/nvram.h>
 
 #include <sysdev/fsl_pci.h>
 #include <sysdev/fsl_soc.h>
@@ -95,6 +96,10 @@ static void __init gef_sbc310_setup_arch(void)
 			printk(KERN_WARNING "Unable to map board registers\n");
 		of_node_put(regs);
 	}
+
+#if defined(CONFIG_MMIO_NVRAM)
+	mmio_nvram_init();
+#endif
 }
 
 /* Return the PCB revision */
