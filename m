Return-Path: <tony@bakeyournoodle.com>
Received: from pythia.bakeyournoodle.com (pythia.bakeyournoodle.com
	[203.82.209.197]) by ozlabs.org (Postfix) with ESMTP id 869D8DDEFB
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Jul 2008 13:51:44 +1000 (EST)
To: Paul Mackerras <paulus@samba.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-Id: <a41d4296d440c7ba582587243d9add875d68cba7.1217476198.git.tony@bakeyournoodle.com>
In-Reply-To: <cac86e24e42bd05087b43663b687f04df91326ba.1217476198.git.tony@bakeyournoodle.com>
References: <cac86e24e42bd05087b43663b687f04df91326ba.1217476198.git.tony@bakeyournoodle.com>
From: Tony Breeds <tony@bakeyournoodle.com>
Subject: [PATCH 8/8] Enable -Werror in arch/powerpc/{kernel,lib,mm,platforms}
Date: Thu, 31 Jul 2008 13:51:43 +1000 (EST)
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>
---
 arch/powerpc/kernel/Makefile                |    1 +
 arch/powerpc/lib/Makefile                   |    1 +
 arch/powerpc/mm/Makefile                    |    1 +
 arch/powerpc/platforms/40x/Makefile         |    2 ++
 arch/powerpc/platforms/44x/Makefile         |    2 ++
 arch/powerpc/platforms/512x/Makefile        |    2 ++
 arch/powerpc/platforms/52xx/Makefile        |    4 +++-
 arch/powerpc/platforms/82xx/Makefile        |    2 ++
 arch/powerpc/platforms/83xx/Makefile        |    2 ++
 arch/powerpc/platforms/85xx/Makefile        |    2 ++
 arch/powerpc/platforms/86xx/Makefile        |    1 +
 arch/powerpc/platforms/8xx/Makefile         |    2 ++
 arch/powerpc/platforms/Makefile             |    1 +
 arch/powerpc/platforms/cell/Makefile        |    2 ++
 arch/powerpc/platforms/chrp/Makefile        |    2 ++
 arch/powerpc/platforms/embedded6xx/Makefile |    2 ++
 arch/powerpc/platforms/iseries/Makefile     |    2 +-
 arch/powerpc/platforms/maple/Makefile       |    2 ++
 arch/powerpc/platforms/pasemi/Makefile      |    2 ++
 arch/powerpc/platforms/powermac/Makefile    |    2 ++
 arch/powerpc/platforms/ps3/Makefile         |    2 ++
 arch/powerpc/platforms/pseries/Makefile     |    2 ++
 22 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 1a40947..11ba982 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -1,6 +1,7 @@
 #
 # Makefile for the linux kernel.
 #
+EXTRA_CFLAGS	:= -Werror
 
 CFLAGS_ptrace.o		+= -DUTS_MACHINE='"$(UTS_MACHINE)"'
 
diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
index 2a88e8b..78a3022 100644
--- a/arch/powerpc/lib/Makefile
+++ b/arch/powerpc/lib/Makefile
@@ -1,6 +1,7 @@
 #
 # Makefile for ppc-specific library files..
 #
+EXTRA_CFLAGS	:= -Werror
 
 ifeq ($(CONFIG_PPC64),y)
 EXTRA_CFLAGS		+= -mno-minimal-toc
diff --git a/arch/powerpc/mm/Makefile b/arch/powerpc/mm/Makefile
index 1c00e01..c2e44c4 100644
--- a/arch/powerpc/mm/Makefile
+++ b/arch/powerpc/mm/Makefile
@@ -2,6 +2,7 @@
 # Makefile for the linux ppc-specific parts of the memory manager.
 #
 
+EXTRA_CFLAGS	:= -Werror
 ifeq ($(CONFIG_PPC64),y)
 EXTRA_CFLAGS	+= -mno-minimal-toc
 endif
diff --git a/arch/powerpc/platforms/40x/Makefile b/arch/powerpc/platforms/40x/Makefile
index 5533a5c..3788b2e 100644
--- a/arch/powerpc/platforms/40x/Makefile
+++ b/arch/powerpc/platforms/40x/Makefile
@@ -1,3 +1,5 @@
+EXTRA_CFLAGS	:= -Werror
+
 obj-$(CONFIG_KILAUEA)				+= kilauea.o
 obj-$(CONFIG_MAKALU)				+= makalu.o
 obj-$(CONFIG_WALNUT)				+= walnut.o
diff --git a/arch/powerpc/platforms/44x/Makefile b/arch/powerpc/platforms/44x/Makefile
index 8d0b1a1..58cc668 100644
--- a/arch/powerpc/platforms/44x/Makefile
+++ b/arch/powerpc/platforms/44x/Makefile
@@ -1,3 +1,5 @@
+EXTRA_CFLAGS	:= -Werror
+
 obj-$(CONFIG_44x)	:= misc_44x.o idle.o
 obj-$(CONFIG_EBONY)	+= ebony.o
 obj-$(CONFIG_TAISHAN)	+= taishan.o
diff --git a/arch/powerpc/platforms/512x/Makefile b/arch/powerpc/platforms/512x/Makefile
index 90be2f5..8a6141d 100644
--- a/arch/powerpc/platforms/512x/Makefile
+++ b/arch/powerpc/platforms/512x/Makefile
@@ -1,6 +1,8 @@
 #
 # Makefile for the Freescale PowerPC 512x linux kernel.
 #
+EXTRA_CFLAGS	:= -Werror
+
 obj-y				+= clock.o mpc512x_shared.o
 obj-$(CONFIG_MPC5121_ADS)	+= mpc5121_ads.o mpc5121_ads_cpld.o
 obj-$(CONFIG_MPC5121_GENERIC)	+= mpc5121_generic.o
diff --git a/arch/powerpc/platforms/52xx/Makefile b/arch/powerpc/platforms/52xx/Makefile
index daf0e15..2616db3 100644
--- a/arch/powerpc/platforms/52xx/Makefile
+++ b/arch/powerpc/platforms/52xx/Makefile
@@ -1,6 +1,8 @@
 #
 # Makefile for 52xx based boards
 #
+EXTRA_CFLAGS	:= -Werror
+
 ifeq ($(CONFIG_PPC_MERGE),y)
 obj-y				+= mpc52xx_pic.o mpc52xx_common.o
 obj-$(CONFIG_PCI)		+= mpc52xx_pci.o
@@ -15,4 +17,4 @@ ifeq ($(CONFIG_PPC_LITE5200),y)
 	obj-$(CONFIG_PM)	+= lite5200_sleep.o lite5200_pm.o
 endif
 
-obj-$(CONFIG_PPC_MPC5200_GPIO)	+= mpc52xx_gpio.o
\ No newline at end of file
+obj-$(CONFIG_PPC_MPC5200_GPIO)	+= mpc52xx_gpio.o
diff --git a/arch/powerpc/platforms/82xx/Makefile b/arch/powerpc/platforms/82xx/Makefile
index 6cd5cd5..f88fb41 100644
--- a/arch/powerpc/platforms/82xx/Makefile
+++ b/arch/powerpc/platforms/82xx/Makefile
@@ -1,6 +1,8 @@
 #
 # Makefile for the PowerPC 82xx linux kernel.
 #
+EXTRA_CFLAGS	:= -Werror
+
 obj-$(CONFIG_MPC8272_ADS) += mpc8272_ads.o
 obj-$(CONFIG_CPM2) += pq2.o
 obj-$(CONFIG_PQ2_ADS_PCI_PIC) += pq2ads-pci-pic.o
diff --git a/arch/powerpc/platforms/83xx/Makefile b/arch/powerpc/platforms/83xx/Makefile
index ba5028e..523c03d 100644
--- a/arch/powerpc/platforms/83xx/Makefile
+++ b/arch/powerpc/platforms/83xx/Makefile
@@ -1,6 +1,8 @@
 #
 # Makefile for the PowerPC 83xx linux kernel.
 #
+EXTRA_CFLAGS	:= -Werror
+
 obj-y				:= misc.o usb.o
 obj-$(CONFIG_SUSPEND)		+= suspend.o suspend-asm.o
 obj-$(CONFIG_MPC831x_RDB)	+= mpc831x_rdb.o
diff --git a/arch/powerpc/platforms/85xx/Makefile b/arch/powerpc/platforms/85xx/Makefile
index cb3054e..0767384 100644
--- a/arch/powerpc/platforms/85xx/Makefile
+++ b/arch/powerpc/platforms/85xx/Makefile
@@ -1,6 +1,8 @@
 #
 # Makefile for the PowerPC 85xx linux kernel.
 #
+EXTRA_CFLAGS	:= -Werror
+
 obj-$(CONFIG_MPC8540_ADS) += mpc85xx_ads.o
 obj-$(CONFIG_MPC8560_ADS) += mpc85xx_ads.o
 obj-$(CONFIG_MPC85xx_CDS) += mpc85xx_cds.o
diff --git a/arch/powerpc/platforms/86xx/Makefile b/arch/powerpc/platforms/86xx/Makefile
index 8fee37d..24c58e1 100644
--- a/arch/powerpc/platforms/86xx/Makefile
+++ b/arch/powerpc/platforms/86xx/Makefile
@@ -1,6 +1,7 @@
 #
 # Makefile for the PowerPC 86xx linux kernel.
 #
+EXTRA_CFLAGS	:= -Werror
 
 obj-y				:= pic.o
 obj-$(CONFIG_SMP)		+= mpc86xx_smp.o
diff --git a/arch/powerpc/platforms/8xx/Makefile b/arch/powerpc/platforms/8xx/Makefile
index 7b71d9c..fdccd47 100644
--- a/arch/powerpc/platforms/8xx/Makefile
+++ b/arch/powerpc/platforms/8xx/Makefile
@@ -1,6 +1,8 @@
 #
 # Makefile for the PowerPC 8xx linux kernel.
 #
+EXTRA_CFLAGS	:= -Werror
+
 obj-$(CONFIG_PPC_8xx)	  += m8xx_setup.o
 obj-$(CONFIG_MPC885ADS)   += mpc885ads_setup.o
 obj-$(CONFIG_MPC86XADS)   += mpc86xads_setup.o
diff --git a/arch/powerpc/platforms/Makefile b/arch/powerpc/platforms/Makefile
index 423a023..bc9e246 100644
--- a/arch/powerpc/platforms/Makefile
+++ b/arch/powerpc/platforms/Makefile
@@ -1,3 +1,4 @@
+EXTRA_CFLAGS	:= -Werror
 
 obj-$(CONFIG_FSL_ULI1575)	+= fsl_uli1575.o
 
diff --git a/arch/powerpc/platforms/cell/Makefile b/arch/powerpc/platforms/cell/Makefile
index 7fd8308..2366dd1 100644
--- a/arch/powerpc/platforms/cell/Makefile
+++ b/arch/powerpc/platforms/cell/Makefile
@@ -1,3 +1,5 @@
+EXTRA_CFLAGS	:= -Werror
+
 obj-$(CONFIG_PPC_CELL_NATIVE)		+= interrupt.o iommu.o setup.o \
 					   cbe_regs.o spider-pic.o \
 					   pervasive.o pmu.o io-workarounds.o \
diff --git a/arch/powerpc/platforms/chrp/Makefile b/arch/powerpc/platforms/chrp/Makefile
index 4b3bfad..6282c65 100644
--- a/arch/powerpc/platforms/chrp/Makefile
+++ b/arch/powerpc/platforms/chrp/Makefile
@@ -1,3 +1,5 @@
+EXTRA_CFLAGS	:= -Werror
+
 obj-y				+= setup.o time.o pegasos_eth.o pci.o
 obj-$(CONFIG_SMP)		+= smp.o
 obj-$(CONFIG_NVRAM)		+= nvram.o
diff --git a/arch/powerpc/platforms/embedded6xx/Makefile b/arch/powerpc/platforms/embedded6xx/Makefile
index 0773c08..919cc1a 100644
--- a/arch/powerpc/platforms/embedded6xx/Makefile
+++ b/arch/powerpc/platforms/embedded6xx/Makefile
@@ -1,6 +1,8 @@
 #
 # Makefile for the 6xx/7xx/7xxxx linux kernel.
 #
+EXTRA_CFLAGS	:= -Werror
+
 obj-$(CONFIG_MPC7448HPC2)	+= mpc7448_hpc2.o
 obj-$(CONFIG_LINKSTATION)	+= linkstation.o ls_uart.o
 obj-$(CONFIG_STORCENTER)	+= storcenter.o
diff --git a/arch/powerpc/platforms/iseries/Makefile b/arch/powerpc/platforms/iseries/Makefile
index cc7161f..2602d1b 100644
--- a/arch/powerpc/platforms/iseries/Makefile
+++ b/arch/powerpc/platforms/iseries/Makefile
@@ -1,4 +1,4 @@
-EXTRA_CFLAGS	+= -mno-minimal-toc
+EXTRA_CFLAGS	+= -mno-minimal-toc -Werror
 
 extra-y += dt.o
 
diff --git a/arch/powerpc/platforms/maple/Makefile b/arch/powerpc/platforms/maple/Makefile
index 1be1a99..c073d91 100644
--- a/arch/powerpc/platforms/maple/Makefile
+++ b/arch/powerpc/platforms/maple/Makefile
@@ -1 +1,3 @@
+EXTRA_CFLAGS	:= -Werror
+
 obj-y	+= setup.o pci.o time.o
diff --git a/arch/powerpc/platforms/pasemi/Makefile b/arch/powerpc/platforms/pasemi/Makefile
index ce6d789..acc25d3 100644
--- a/arch/powerpc/platforms/pasemi/Makefile
+++ b/arch/powerpc/platforms/pasemi/Makefile
@@ -1,3 +1,5 @@
+EXTRA_CFLAGS	:= -Werror
+
 obj-y	+= setup.o pci.o time.o idle.o powersave.o iommu.o dma_lib.o misc.o
 obj-$(CONFIG_PPC_PASEMI_MDIO)	+= gpio_mdio.o
 obj-$(CONFIG_PPC_PASEMI_CPUFREQ) += cpufreq.o
diff --git a/arch/powerpc/platforms/powermac/Makefile b/arch/powerpc/platforms/powermac/Makefile
index 8977417..6ec9314 100644
--- a/arch/powerpc/platforms/powermac/Makefile
+++ b/arch/powerpc/platforms/powermac/Makefile
@@ -1,3 +1,5 @@
+EXTRA_CFLAGS	:= -Werror
+
 CFLAGS_bootx_init.o  		+= -fPIC
 
 ifdef CONFIG_FTRACE
diff --git a/arch/powerpc/platforms/ps3/Makefile b/arch/powerpc/platforms/ps3/Makefile
index ac1bdf8..16b00f3 100644
--- a/arch/powerpc/platforms/ps3/Makefile
+++ b/arch/powerpc/platforms/ps3/Makefile
@@ -1,3 +1,5 @@
+EXTRA_CFLAGS	:= -Werror
+
 obj-y += setup.o mm.o time.o hvcall.o htab.o repository.o
 obj-y += interrupt.o exports.o os-area.o
 obj-y += system-bus.o
diff --git a/arch/powerpc/platforms/pseries/Makefile b/arch/powerpc/platforms/pseries/Makefile
index dfe574a..2e122e9 100644
--- a/arch/powerpc/platforms/pseries/Makefile
+++ b/arch/powerpc/platforms/pseries/Makefile
@@ -1,3 +1,5 @@
+EXTRA_CFLAGS	:= -Werror
+
 ifeq ($(CONFIG_PPC64),y)
 EXTRA_CFLAGS		+= -mno-minimal-toc
 endif
-- 
1.5.6.3
