Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6516EDDEBF
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jan 2008 01:41:39 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.13.8/8.13.8) with ESMTP id m0SEfYd0013112
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jan 2008 08:41:34 -0600
Date: Mon, 28 Jan 2008 08:39:07 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] [PPC] Remove 83xx from arch/ppc
Message-ID: <Pine.LNX.4.64.0801280838490.19709@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

83xx exists in arch/powerpc as well as cuImage support to boot from
a u-boot that doesn't support device trees.

---
 arch/ppc/Kconfig                       |   46 +--
 arch/ppc/Makefile                      |    1 -
 arch/ppc/configs/mpc834x_sys_defconfig |  844 --------------------------------
 arch/ppc/kernel/ppc_ksyms.c            |    3 +-
 arch/ppc/kernel/setup.c                |    2 +-
 arch/ppc/mm/mmu_context.c              |    2 +-
 arch/ppc/mm/ppc_mmu.c                  |    2 +-
 arch/ppc/platforms/83xx/Makefile       |    4 -
 arch/ppc/platforms/83xx/mpc834x_sys.c  |  346 -------------
 arch/ppc/platforms/83xx/mpc834x_sys.h  |   54 --
 arch/ppc/syslib/Makefile               |    5 -
 arch/ppc/syslib/ipic.c                 |  646 ------------------------
 arch/ppc/syslib/ipic.h                 |   47 --
 arch/ppc/syslib/mpc83xx_devices.c      |  251 ----------
 arch/ppc/syslib/mpc83xx_sys.c          |  122 -----
 arch/ppc/syslib/ppc83xx_pci.h          |  151 ------
 arch/ppc/syslib/ppc83xx_setup.c        |  410 ----------------
 arch/ppc/syslib/ppc83xx_setup.h        |   55 --
 include/asm-powerpc/irq.h              |    5 -
 include/asm-ppc/mpc83xx.h              |  107 ----
 include/asm-ppc/ppc_sys.h              |    2 -
 include/asm-ppc/ppcboot.h              |    5 +-
 include/asm-ppc/serial.h               |    2 -
 23 files changed, 15 insertions(+), 3097 deletions(-)
 delete mode 100644 arch/ppc/configs/mpc834x_sys_defconfig
 delete mode 100644 arch/ppc/platforms/83xx/Makefile
 delete mode 100644 arch/ppc/platforms/83xx/mpc834x_sys.c
 delete mode 100644 arch/ppc/platforms/83xx/mpc834x_sys.h
 delete mode 100644 arch/ppc/syslib/ipic.c
 delete mode 100644 arch/ppc/syslib/ipic.h
 delete mode 100644 arch/ppc/syslib/mpc83xx_devices.c
 delete mode 100644 arch/ppc/syslib/mpc83xx_sys.c
 delete mode 100644 arch/ppc/syslib/ppc83xx_pci.h
 delete mode 100644 arch/ppc/syslib/ppc83xx_setup.c
 delete mode 100644 arch/ppc/syslib/ppc83xx_setup.h
 delete mode 100644 include/asm-ppc/mpc83xx.h

diff --git a/arch/ppc/Kconfig b/arch/ppc/Kconfig
index 6473fa7..08e083d 100644
--- a/arch/ppc/Kconfig
+++ b/arch/ppc/Kconfig
@@ -78,18 +78,18 @@ choice
 	default 6xx

 config 6xx
-	bool "6xx/7xx/74xx/52xx/82xx/83xx"
+	bool "6xx/7xx/74xx/52xx/82xx"
 	select PPC_FPU
 	help
 	  There are four types of PowerPC chips supported.  The more common
 	  types (601, 603, 604, 740, 750, 7400), the older Freescale
 	  (formerly Motorola) embedded versions (821, 823, 850, 855, 860,
-	  52xx, 82xx, 83xx), the IBM embedded versions (403 and 405) and
+	  52xx, 82xx), the IBM embedded versions (403 and 405) and
 	  the Book E embedded processors from IBM (44x) and Freescale (85xx).
 	  For support for 64-bit processors, set ARCH=powerpc.
 	  Unless you are building a kernel for one of the embedded processor
 	  systems, choose 6xx.
-	  Also note that because the 52xx, 82xx, & 83xx family have a 603e
+	  Also note that because the 52xx, 82xx family have a 603e
 	  core, specific support for that chipset is asked later on.

 config 40x
@@ -153,7 +153,7 @@ config PHYS_64BIT
 config ALTIVEC
 	bool "AltiVec Support"
 	depends on 6xx
-	depends on !8260 && !83xx
+	depends on !8260
 	---help---
 	  This option enables kernel support for the Altivec extensions to the
 	  PowerPC processor. The kernel currently supports saving and restoring
@@ -184,7 +184,7 @@ config SPE

 config TAU
 	bool "Thermal Management Support"
-	depends on 6xx && !8260 && !83xx
+	depends on 6xx && !8260
 	help
 	  G3 and G4 processors have an on-chip temperature sensor called the
 	  'Thermal Assist Unit (TAU)', which, in theory, can measure the on-die
@@ -721,16 +721,6 @@ config LITE5200B
 	  Support for the LITE5200B dev board for the MPC5200 from Freescale.
 	  This is the new board with 2 PCI slots.

-config MPC834x_SYS
-	bool "Freescale MPC834x SYS"
-	help
-	  This option enables support for the MPC 834x SYS evaluation board.
-
-	  Be aware that PCI buses can only function when SYS board is plugged
-	  into the PIB (Platform IO Board) board from Freescale which provide
-	  3 PCI slots.  The PIBs PCI initialization is the bootloader's
-	  responsibility.
-
 config EV64360
 	bool "Marvell-EV64360BP"
 	help
@@ -774,18 +764,6 @@ config 8272
 	  The MPC8272 CPM has a different internal dpram setup than other CPM2
 	  devices

-config 83xx
-	bool
-	default y if MPC834x_SYS
-
-config MPC834x
-	bool
-	default y if MPC834x_SYS
-
-config PPC_83xx
-	bool
-	default y if 83xx
-
 config CPM1
 	bool
 	depends on 8xx
@@ -811,8 +789,7 @@ config PPC_GEN550
 	bool
 	depends on SANDPOINT || SPRUCE || PPLUS || \
 		PRPMC750 || PRPMC800 || LOPEC || \
-		(EV64260 && !SERIAL_MPSC) || CHESTNUT || RADSTONE_PPC7D || \
-		83xx
+		(EV64260 && !SERIAL_MPSC) || CHESTNUT || RADSTONE_PPC7D
 	default y

 config FORCE
@@ -1074,7 +1051,7 @@ config PPC_I8259
 config PPC_INDIRECT_PCI
 	bool
 	depends on PCI
-	default y if 40x || 44x || 85xx || 83xx || PPC_PREP
+	default y if 40x || 44x || 85xx || PPC_PREP
 	default n

 config EISA
@@ -1091,8 +1068,8 @@ config MCA
 	bool

 config PCI
-	bool "PCI support" if 40x || CPM2 || 83xx || 85xx || PPC_MPC52xx
-	default y if !40x && !CPM2 && !8xx && !83xx && !85xx
+	bool "PCI support" if 40x || CPM2 || 85xx || PPC_MPC52xx
+	default y if !40x && !CPM2 && !8xx && !85xx
 	default PCI_QSPAN if !4xx && !CPM2 && 8xx
 	help
 	  Find out whether your system includes a PCI bus. PCI is the name of
@@ -1106,11 +1083,6 @@ config PCI_DOMAINS
 config PCI_SYSCALL
 	def_bool PCI

-config MPC83xx_PCI2
-	bool "Support for 2nd PCI host controller"
-	depends on PCI && MPC834x
-	default y if MPC834x_SYS
-
 config PCI_QSPAN
 	bool "QSpan PCI"
 	depends on !4xx && !CPM2 && 8xx
diff --git a/arch/ppc/Makefile b/arch/ppc/Makefile
index 95894ef..a4fef18 100644
--- a/arch/ppc/Makefile
+++ b/arch/ppc/Makefile
@@ -65,7 +65,6 @@ core-y				+= arch/ppc/kernel/ arch/powerpc/kernel/ \
 				   arch/ppc/syslib/ arch/powerpc/sysdev/ \
 				   arch/powerpc/lib/
 core-$(CONFIG_4xx)		+= arch/ppc/platforms/4xx/
-core-$(CONFIG_83xx)		+= arch/ppc/platforms/83xx/
 core-$(CONFIG_85xx)		+= arch/ppc/platforms/85xx/
 core-$(CONFIG_MATH_EMULATION)	+= arch/powerpc/math-emu/
 core-$(CONFIG_XMON)		+= arch/ppc/xmon/
diff --git a/arch/ppc/kernel/ppc_ksyms.c b/arch/ppc/kernel/ppc_ksyms.c
index 0d53dc3..ba729ce 100644
--- a/arch/ppc/kernel/ppc_ksyms.c
+++ b/arch/ppc/kernel/ppc_ksyms.c
@@ -244,8 +244,7 @@ EXPORT_SYMBOL(debugger_fault_handler);
 EXPORT_SYMBOL(cpm_install_handler);
 EXPORT_SYMBOL(cpm_free_handler);
 #endif /* CONFIG_8xx */
-#if defined(CONFIG_8xx) || defined(CONFIG_40x) || defined(CONFIG_85xx) ||\
-	defined(CONFIG_83xx)
+#if defined(CONFIG_8xx) || defined(CONFIG_40x) || defined(CONFIG_85xx)
 EXPORT_SYMBOL(__res);
 #endif

diff --git a/arch/ppc/kernel/setup.c b/arch/ppc/kernel/setup.c
index 3c45302..5888ae6 100644
--- a/arch/ppc/kernel/setup.c
+++ b/arch/ppc/kernel/setup.c
@@ -38,7 +38,7 @@
 #include <asm/xmon.h>
 #include <asm/ocp.h>

-#define USES_PPC_SYS (defined(CONFIG_85xx) || defined(CONFIG_83xx) || \
+#define USES_PPC_SYS (defined(CONFIG_85xx) || \
 		      defined(CONFIG_MPC10X_BRIDGE) || defined(CONFIG_8260) || \
 		      defined(CONFIG_PPC_MPC52xx))

diff --git a/arch/ppc/mm/mmu_context.c b/arch/ppc/mm/mmu_context.c
index 85afa7f..dacf45c 100644
--- a/arch/ppc/mm/mmu_context.c
+++ b/arch/ppc/mm/mmu_context.c
@@ -2,7 +2,7 @@
  * This file contains the routines for handling the MMU on those
  * PowerPC implementations where the MMU substantially follows the
  * architecture specification.  This includes the 6xx, 7xx, 7xxx,
- * 8260, and 83xx implementations but excludes the 8xx and 4xx.
+ * and 8260 implementations but excludes the 8xx and 4xx.
  *  -- paulus
  *
  *  Derived from arch/ppc/mm/init.c:
diff --git a/arch/ppc/mm/ppc_mmu.c b/arch/ppc/mm/ppc_mmu.c
index 973f1e6..0c1dc15 100644
--- a/arch/ppc/mm/ppc_mmu.c
+++ b/arch/ppc/mm/ppc_mmu.c
@@ -2,7 +2,7 @@
  * This file contains the routines for handling the MMU on those
  * PowerPC implementations where the MMU substantially follows the
  * architecture specification.  This includes the 6xx, 7xx, 7xxx,
- * 8260, and 83xx implementations but excludes the 8xx and 4xx.
+ * and 8260 implementations but excludes the 8xx and 4xx.
  *  -- paulus
  *
  *  Derived from arch/ppc/mm/init.c:
diff --git a/arch/ppc/syslib/Makefile b/arch/ppc/syslib/Makefile
index 5e16228..4d158f3 100644
--- a/arch/ppc/syslib/Makefile
+++ b/arch/ppc/syslib/Makefile
@@ -93,11 +93,6 @@ obj-$(CONFIG_85xx)		+= open_pic.o ppc85xx_common.o ppc85xx_setup.o \
 ifeq ($(CONFIG_85xx),y)
 obj-$(CONFIG_PCI)		+= pci_auto.o
 endif
-obj-$(CONFIG_83xx)		+= ppc83xx_setup.o ppc_sys.o \
-					mpc83xx_sys.o mpc83xx_devices.o ipic.o
-ifeq ($(CONFIG_83xx),y)
-obj-$(CONFIG_PCI)		+= pci_auto.o
-endif
 obj-$(CONFIG_MPC8548_CDS)	+= todc_time.o
 obj-$(CONFIG_MPC8555_CDS)	+= todc_time.o
 obj-$(CONFIG_PPC_MPC52xx)	+= mpc52xx_setup.o mpc52xx_pic.o \
diff --git a/include/asm-powerpc/irq.h b/include/asm-powerpc/irq.h
index 1392db4..4a015da 100644
--- a/include/asm-powerpc/irq.h
+++ b/include/asm-powerpc/irq.h
@@ -483,11 +483,6 @@ static __inline__ int irq_canonicalize(int irq)
  */
 #define	mk_int_int_mask(IL) (1 << (7 - (IL/2)))

-#elif defined(CONFIG_83xx)
-#include <asm/mpc83xx.h>
-
-#define	NR_IRQS	(NR_IPIC_INTS)
-
 #elif defined(CONFIG_85xx)
 /* Now include the board configuration specific associations.
 */
diff --git a/include/asm-ppc/ppc_sys.h b/include/asm-ppc/ppc_sys.h
index de99e92..80c5851 100644
--- a/include/asm-ppc/ppc_sys.h
+++ b/include/asm-ppc/ppc_sys.h
@@ -23,8 +23,6 @@

 #if defined(CONFIG_8260)
 #include <asm/mpc8260.h>
-#elif defined(CONFIG_83xx)
-#include <asm/mpc83xx.h>
 #elif defined(CONFIG_85xx)
 #include <asm/mpc85xx.h>
 #elif defined(CONFIG_8xx)
diff --git a/include/asm-ppc/ppcboot.h b/include/asm-ppc/ppcboot.h
index 6b7b63f..18d04e8 100644
--- a/include/asm-ppc/ppcboot.h
+++ b/include/asm-ppc/ppcboot.h
@@ -38,8 +38,7 @@ typedef struct bd_info {
 	unsigned long	bi_flashoffset; /* reserved area for startup monitor */
 	unsigned long	bi_sramstart;	/* start of SRAM memory */
 	unsigned long	bi_sramsize;	/* size	 of SRAM memory */
-#if defined(CONFIG_8xx) || defined(CONFIG_CPM2) || defined(CONFIG_85xx) ||\
-	defined(CONFIG_83xx)
+#if defined(CONFIG_8xx) || defined(CONFIG_CPM2) || defined(CONFIG_85xx)
 	unsigned long	bi_immr_base;	/* base of IMMR register */
 #endif
 #if defined(CONFIG_PPC_MPC52xx)
@@ -74,7 +73,7 @@ typedef struct bd_info {
 	hymod_conf_t	bi_hymod_conf;	/* hymod configuration information */
 #endif
 #if defined(CONFIG_EVB64260) || defined(CONFIG_405EP) || defined(CONFIG_44x) || \
-	defined(CONFIG_85xx) ||	defined(CONFIG_83xx)
+	defined(CONFIG_85xx)
 	/* second onboard ethernet port */
 	unsigned char	bi_enet1addr[6];
 #endif
diff --git a/include/asm-ppc/serial.h b/include/asm-ppc/serial.h
index 8fc1b54..6220ef9 100644
--- a/include/asm-ppc/serial.h
+++ b/include/asm-ppc/serial.h
@@ -29,8 +29,6 @@
 #include <platforms/spruce.h>
 #elif defined(CONFIG_4xx)
 #include <asm/ibm4xx.h>
-#elif defined(CONFIG_83xx)
-#include <asm/mpc83xx.h>
 #elif defined(CONFIG_85xx)
 #include <asm/mpc85xx.h>
 #elif defined(CONFIG_RADSTONE_PPC7D)
-- 
1.5.3.7
