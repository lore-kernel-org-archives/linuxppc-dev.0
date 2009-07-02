Return-Path: <martyn.welch@gefanuc.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 21547B7E08
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  3 Jul 2009 02:12:51 +1000 (EST)
Received: from exprod5og105.obsmtp.com (exprod5og105.obsmtp.com [64.18.0.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 44116DDD04
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Jul 2009 02:12:49 +1000 (EST)
From: Martyn Welch <martyn.welch@gefanuc.com>
Subject: [PATCH 3/5] powerpc/86xx: Enable NVRAM on GE Fanuc's SBC610
To: linuxppc-dev@ozlabs.org
Date: Thu, 02 Jul 2009 17:12:31 +0100
Message-ID: <20090702161231.31202.87763.stgit@ES-J7S4D2J.amer.consind.ge.com>
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

This patch enables the NVRAM found on the GE Fanuc SBC610

Signed-off-by: Martyn Welch <martyn.welch@gefanuc.com>
---

 arch/powerpc/boot/dts/gef_sbc610.dts           |    6 ++++++
 arch/powerpc/configs/86xx/gef_sbc610_defconfig |    4 ++--
 arch/powerpc/platforms/86xx/Kconfig            |    1 +
 arch/powerpc/platforms/86xx/gef_sbc610.c       |    5 +++++
 4 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/dts/gef_sbc610.dts b/arch/powerpc/boot/dts/gef_sbc610.dts
index 35a6318..30911ad 100644
--- a/arch/powerpc/boot/dts/gef_sbc610.dts
+++ b/arch/powerpc/boot/dts/gef_sbc610.dts
@@ -84,6 +84,12 @@
 			  6 0 0xfd000000 0x00800000     // IO FPGA (8-bit)
 			  7 0 0xfd800000 0x00800000>;   // IO FPGA (32-bit)
 
+		nvram@3,0 {
+			device_type = "nvram";
+			compatible = "simtek,stk14ca8";
+			reg = <0x3 0x0 0x20000>;
+		};
+
 		fpga@4,0 {
 			compatible = "gef,fpga-regs";
 			reg = <0x4 0x0 0x40>;
diff --git a/arch/powerpc/configs/86xx/gef_sbc610_defconfig b/arch/powerpc/configs/86xx/gef_sbc610_defconfig
index c6a7fc8..b4a7c03 100644
--- a/arch/powerpc/configs/86xx/gef_sbc610_defconfig
+++ b/arch/powerpc/configs/86xx/gef_sbc610_defconfig
@@ -201,7 +201,7 @@ CONFIG_MPIC=y
 # CONFIG_MPIC_WEIRD is not set
 # CONFIG_PPC_I8259 is not set
 # CONFIG_PPC_RTAS is not set
-# CONFIG_MMIO_NVRAM is not set
+CONFIG_MMIO_NVRAM=y
 # CONFIG_PPC_MPC106 is not set
 # CONFIG_PPC_970_NAP is not set
 # CONFIG_PPC_INDIRECT_IO is not set
@@ -1083,7 +1083,7 @@ CONFIG_UNIX98_PTYS=y
 # CONFIG_IPMI_HANDLER is not set
 CONFIG_HW_RANDOM=y
 # CONFIG_HW_RANDOM_TIMERIOMEM is not set
-# CONFIG_NVRAM is not set
+CONFIG_NVRAM=y
 # CONFIG_R3964 is not set
 # CONFIG_APPLICOM is not set
 # CONFIG_RAW_DRIVER is not set
diff --git a/arch/powerpc/platforms/86xx/Kconfig b/arch/powerpc/platforms/86xx/Kconfig
index 9c7b64a..9d02dea 100644
--- a/arch/powerpc/platforms/86xx/Kconfig
+++ b/arch/powerpc/platforms/86xx/Kconfig
@@ -51,6 +51,7 @@ config GEF_SBC310
 config GEF_SBC610
 	bool "GE Fanuc SBC610"
 	select DEFAULT_UIMAGE
+	select MMIO_NVRAM
 	select GENERIC_GPIO
 	select ARCH_REQUIRE_GPIOLIB
 	select HAS_RAPIDIO
diff --git a/arch/powerpc/platforms/86xx/gef_sbc610.c b/arch/powerpc/platforms/86xx/gef_sbc610.c
index 72b31a6..e10688a 100644
--- a/arch/powerpc/platforms/86xx/gef_sbc610.c
+++ b/arch/powerpc/platforms/86xx/gef_sbc610.c
@@ -33,6 +33,7 @@
 #include <asm/udbg.h>
 
 #include <asm/mpic.h>
+#include <asm/nvram.h>
 
 #include <sysdev/fsl_pci.h>
 #include <sysdev/fsl_soc.h>
@@ -95,6 +96,10 @@ static void __init gef_sbc610_setup_arch(void)
 			printk(KERN_WARNING "Unable to map board registers\n");
 		of_node_put(regs);
 	}
+
+#if defined(CONFIG_MMIO_NVRAM)
+	mmio_nvram_init();
+#endif
 }
 
 /* Return the PCB revision */
