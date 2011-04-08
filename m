Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <ca7cc2a36bbf492c11cd98d3d1dea0835731c75f.1302249358.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 1/3] powerpc: Add MSR_64BIT
Date: Fri,  8 Apr 2011 17:56:02 +1000 (EST)
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The MSR bit which indicates 64-bit-ness is different between server and
booke, so add a #define which gives you the right mask regardless.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/include/asm/reg.h       |   10 ++++++++--
 arch/powerpc/include/asm/reg_booke.h |    6 ++++--
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index 7e4abeb..fdaafd0 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -99,17 +99,23 @@
 #define MSR_LE		__MASK(MSR_LE_LG)	/* Little Endian */
 
 #if defined(CONFIG_PPC_BOOK3S_64)
+#define MSR_64BIT	MSR_SF
+
 /* Server variant */
 #define MSR_		MSR_ME | MSR_RI | MSR_IR | MSR_DR | MSR_ISF |MSR_HV
-#define MSR_KERNEL      MSR_ | MSR_SF
+#define MSR_KERNEL	MSR_ | MSR_64BIT
 #define MSR_USER32	MSR_ | MSR_PR | MSR_EE
-#define MSR_USER64	MSR_USER32 | MSR_SF
+#define MSR_USER64	MSR_USER32 | MSR_64BIT
 #elif defined(CONFIG_PPC_BOOK3S_32) || defined(CONFIG_8xx)
 /* Default MSR for kernel mode. */
 #define MSR_KERNEL	(MSR_ME|MSR_RI|MSR_IR|MSR_DR)
 #define MSR_USER	(MSR_KERNEL|MSR_PR|MSR_EE)
 #endif
 
+#ifndef MSR_64BIT
+#define MSR_64BIT	0
+#endif
+
 /* Floating Point Status and Control Register (FPSCR) Fields */
 #define FPSCR_FX	0x80000000	/* FPU exception summary */
 #define FPSCR_FEX	0x40000000	/* FPU enabled exception summary */
diff --git a/arch/powerpc/include/asm/reg_booke.h b/arch/powerpc/include/asm/reg_booke.h
index 3b1a9b7..36d7dbd 100644
--- a/arch/powerpc/include/asm/reg_booke.h
+++ b/arch/powerpc/include/asm/reg_booke.h
@@ -27,10 +27,12 @@
 #define MSR_CM		(1<<31) /* Computation Mode (0=32-bit, 1=64-bit) */
 
 #if defined(CONFIG_PPC_BOOK3E_64)
+#define MSR_64BIT	MSR_CM
+
 #define MSR_		MSR_ME | MSR_CE
-#define MSR_KERNEL      MSR_ | MSR_CM
+#define MSR_KERNEL	MSR_ | MSR_64BIT
 #define MSR_USER32	MSR_ | MSR_PR | MSR_EE | MSR_DE
-#define MSR_USER64	MSR_USER32 | MSR_CM | MSR_DE
+#define MSR_USER64	MSR_USER32 | MSR_64BIT
 #elif defined (CONFIG_40x)
 #define MSR_KERNEL	(MSR_ME|MSR_RI|MSR_IR|MSR_DR|MSR_CE)
 #define MSR_USER	(MSR_KERNEL|MSR_PR|MSR_EE)
-- 
1.7.1
