Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0674467BD3
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Dec 2006 05:14:00 +1100 (EST)
Date: Fri, 8 Dec 2006 12:13:56 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Subject: [UPDATED] Please pull from 'for_paulus' branch
Message-ID: <Pine.LNX.4.64.0612081212520.8694@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Added a patch to build issue on MPC85xx.

Please pull from 'for_paulus' branch of
master.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git

to receive the following updates:

  arch/powerpc/Kconfig            |    2 +-
  arch/powerpc/kernel/cputable.c  |    5 ++---
  arch/powerpc/kernel/head_32.S   |    7 +++++++
  arch/powerpc/kernel/of_device.c |    4 +---
  arch/powerpc/kernel/ppc_ksyms.c |    2 +-
  arch/powerpc/kernel/traps.c     |    2 ++
  include/asm-powerpc/cputable.h  |   10 ++++++++--
  7 files changed, 22 insertions(+), 10 deletions(-)

Kim Phillips:
       [POWERPC] Add support for FP emulation for the e300c2 core

Kumar Gala:
       [POWERPC] of_device_register: propagate device_create_file return code
       [POWERPC] Fix 440SPe CPU table entry
       [POWERPC] Only export __mtdcr/__mfdcr if CONFIG_PPC_DCR is set

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 291c95a..0b2d05d 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -706,7 +706,7 @@ config FORCE_MAX_ZONEORDER

  config MATH_EMULATION
  	bool "Math emulation"
-	depends on 4xx || 8xx || E200 || E500
+	depends on 4xx || 8xx || E200 || PPC_83xx || E500
  	---help---
  	  Some PowerPC chips designed for embedded applications do not have
  	  a floating-point unit and therefore do not implement the
diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index 9d1614c..b742013 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -833,7 +833,7 @@ #if CLASSIC_PPC
  		.pvr_mask		= 0x7fff0000,
  		.pvr_value		= 0x00840000,
  		.cpu_name		= "e300c2",
-		.cpu_features		= CPU_FTRS_E300,
+		.cpu_features		= CPU_FTRS_E300C2,
  		.cpu_user_features	= PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU,
  		.icache_bsize		= 32,
  		.dcache_bsize		= 32,
@@ -1136,8 +1136,7 @@ #ifdef CONFIG_44x
  		.pvr_mask		= 0xff000fff,
  		.pvr_value		= 0x53000890,
  		.cpu_name		= "440SPe Rev. A",
-		.cpu_features		= CPU_FTR_SPLIT_ID_CACHE |
-			CPU_FTR_USE_TB,
+		.cpu_features		= CPU_FTRS_44X,
  		.cpu_user_features	= COMMON_USER_BOOKE,
  		.icache_bsize		= 32,
  		.dcache_bsize		= 32,
diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
index d88e182..9417cf5 100644
--- a/arch/powerpc/kernel/head_32.S
+++ b/arch/powerpc/kernel/head_32.S
@@ -437,6 +437,13 @@ Alignment:
  /* Floating-point unavailable */
  	. = 0x800
  FPUnavailable:
+BEGIN_FTR_SECTION
+/*
+ * Certain Freescale cores don't have a FPU and treat fp instructions
+ * as a FP Unavailable exception.  Redirect to illegal/emulation handling.
+ */
+	b 	ProgramCheck
+END_FTR_SECTION_IFSET(CPU_FTR_FPU_UNAVAILABLE)
  	EXCEPTION_PROLOG
  	bne	load_up_fpu		/* if from user, just load it up */
  	addi	r3,r1,STACK_FRAME_OVERHEAD
diff --git a/arch/powerpc/kernel/of_device.c b/arch/powerpc/kernel/of_device.c
index 8a06724..e921514 100644
--- a/arch/powerpc/kernel/of_device.c
+++ b/arch/powerpc/kernel/of_device.c
@@ -109,9 +109,7 @@ int of_device_register(struct of_device
  	if (rc)
  		return rc;

-	device_create_file(&ofdev->dev, &dev_attr_devspec);
-
-	return 0;
+	return device_create_file(&ofdev->dev, &dev_attr_devspec);
  }

  void of_device_unregister(struct of_device *ofdev)
diff --git a/arch/powerpc/kernel/ppc_ksyms.c b/arch/powerpc/kernel/ppc_ksyms.c
index 9179f07..87ab327 100644
--- a/arch/powerpc/kernel/ppc_ksyms.c
+++ b/arch/powerpc/kernel/ppc_ksyms.c
@@ -208,7 +208,7 @@ #endif /* CONFIG_SMP */
  extern long *intercept_table;
  EXPORT_SYMBOL(intercept_table);
  #endif /* CONFIG_PPC_STD_MMU_32 */
-#if defined(CONFIG_40x) || defined(CONFIG_BOOKE)
+#ifdef CONFIG_PPC_DCR
  EXPORT_SYMBOL(__mtdcr);
  EXPORT_SYMBOL(__mfdcr);
  #endif
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 0d4e203..fde820e 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -782,6 +782,8 @@ void __kprobes program_check_exception(s
  	unsigned int reason = get_reason(regs);
  	extern int do_mathemu(struct pt_regs *regs);

+	/* We can now get here via a FP Unavailable exception if the core
+	 * has no FPU, in that case no reason flags will be set */
  #ifdef CONFIG_MATH_EMULATION
  	/* (reason & REASON_ILLEGAL) would be the obvious thing here,
  	 * but there seems to be a hardware bug on the 405GP (RevD)
diff --git a/include/asm-powerpc/cputable.h b/include/asm-powerpc/cputable.h
index 6fe5c9d..aca72f9 100644
--- a/include/asm-powerpc/cputable.h
+++ b/include/asm-powerpc/cputable.h
@@ -126,6 +126,7 @@ #define CPU_FTR_BIG_PHYS		ASM_CONST(0x00
  #define CPU_FTR_NODSISRALIGN		ASM_CONST(0x0000000000100000)
  #define CPU_FTR_PPC_LE			ASM_CONST(0x0000000000200000)
  #define CPU_FTR_REAL_LE			ASM_CONST(0x0000000000400000)
+#define CPU_FTR_FPU_UNAVAILABLE		ASM_CONST(0x0000000000800000)

  /*
   * Add the 64-bit processor unique features in the top half of the word;
@@ -295,6 +296,9 @@ #define CPU_FTRS_G2_LE	(CPU_FTR_SPLIT_ID
  #define CPU_FTRS_E300	(CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_MAYBE_CAN_DOZE | \
  	    CPU_FTR_USE_TB | CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_HAS_HIGH_BATS | \
  	    CPU_FTR_COMMON)
+#define CPU_FTRS_E300C2	(CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_MAYBE_CAN_DOZE | \
+	    CPU_FTR_USE_TB | CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_HAS_HIGH_BATS | \
+	    CPU_FTR_COMMON | CPU_FTR_FPU_UNAVAILABLE)
  #define CPU_FTRS_CLASSIC32	(CPU_FTR_COMMON | CPU_FTR_SPLIT_ID_CACHE | \
  	    CPU_FTR_USE_TB | CPU_FTR_HPTE_TABLE)
  #define CPU_FTRS_8XX	(CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB)
@@ -364,7 +368,8 @@ #if CLASSIC_PPC
  	    CPU_FTRS_7450_21 | CPU_FTRS_7450_23 | CPU_FTRS_7455_1 |
  	    CPU_FTRS_7455_20 | CPU_FTRS_7455 | CPU_FTRS_7447_10 |
  	    CPU_FTRS_7447 | CPU_FTRS_7447A | CPU_FTRS_82XX |
-	    CPU_FTRS_G2_LE | CPU_FTRS_E300 | CPU_FTRS_CLASSIC32 |
+	    CPU_FTRS_G2_LE | CPU_FTRS_E300 | CPU_FTRS_E300C2 |
+	    CPU_FTRS_CLASSIC32 |
  #else
  	    CPU_FTRS_GENERIC_32 |
  #endif
@@ -403,7 +408,8 @@ #if CLASSIC_PPC
  	    CPU_FTRS_7450_21 & CPU_FTRS_7450_23 & CPU_FTRS_7455_1 &
  	    CPU_FTRS_7455_20 & CPU_FTRS_7455 & CPU_FTRS_7447_10 &
  	    CPU_FTRS_7447 & CPU_FTRS_7447A & CPU_FTRS_82XX &
-	    CPU_FTRS_G2_LE & CPU_FTRS_E300 & CPU_FTRS_CLASSIC32 &
+	    CPU_FTRS_G2_LE & CPU_FTRS_E300 & CPU_FTRS_E300C2 &
+	    CPU_FTRS_CLASSIC32 &
  #else
  	    CPU_FTRS_GENERIC_32 &
  #endif
