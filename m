Return-Path: <anton@ozlabs.org>
Date: Wed, 11 Aug 2010 15:20:05 +1000
From: Anton Blanchard <anton@samba.org>
To: paulus@samba.org, benh@kernel.crashing.org
Subject: [PATCH] powerpc: Feature nop out reservation clear when stcx
	checks address
Message-ID: <20100811052005.GV29316@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


The POWER architecture does not require stcx to check that it is operating
on the same address as the larx. This means it is possible for an
an exception handler to execute a larx, get a reservation, decide
not to do the stcx and then return back with an active reservation. If the
interrupted code was in the middle of a larx/stcx sequence the stcx could
incorrectly succeed.

All recent POWER CPUs check the address before letting the stcx succeed
so we can create a CPU feature and nop it out. As Ben suggested, we can
only do this in our syscall path because there is a remote possibility
some kernel code gets interrupted by an exception that ends up operating
on the same cacheline.

Thanks to Paul Mackerras and Derek Williams for the idea.

To test this I used a very simple null syscall (actually getppid) testcase
at http://ozlabs.org/~anton/junkcode/null_syscall.c

I tested against 2.6.35-git10 with the following changes against the
pseries_defconfig:

CONFIG_VIRT_CPU_ACCOUNTING=n
CONFIG_AUDIT=n
CONFIG_PPC_4K_PAGES=n
CONFIG_PPC_64K_PAGES=y
CONFIG_FORCE_MAX_ZONEORDER=9
CONFIG_PPC_SUBPAGE_PROT=n
CONFIG_FUNCTION_TRACER=n
CONFIG_FUNCTION_GRAPH_TRACER=n
CONFIG_IRQSOFF_TRACER=n
CONFIG_STACK_TRACER=n

to remove the overhead of virtual CPU accounting, syscall auditing and
the ftrace mcount tracers. 64kB pages were enabled to minimise TLB misses.

POWER6: +8.2%
POWER7: +7.0%

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: powerpc.git/arch/powerpc/include/asm/cputable.h
===================================================================
--- powerpc.git.orig/arch/powerpc/include/asm/cputable.h	2010-08-11 12:56:03.340741765 +1000
+++ powerpc.git/arch/powerpc/include/asm/cputable.h	2010-08-11 13:02:30.131470190 +1000
@@ -198,6 +198,7 @@ extern const char *powerpc_base_platform
 #define CPU_FTR_CP_USE_DCBTZ		LONG_ASM_CONST(0x0040000000000000)
 #define CPU_FTR_UNALIGNED_LD_STD	LONG_ASM_CONST(0x0080000000000000)
 #define CPU_FTR_ASYM_SMT		LONG_ASM_CONST(0x0100000000000000)
+#define CPU_FTR_STCX_CHECKS_ADDRESS	LONG_ASM_CONST(0x0200000000000000)
 
 #ifndef __ASSEMBLY__
 
@@ -392,28 +393,31 @@ extern const char *powerpc_base_platform
 	    CPU_FTR_MMCRA | CPU_FTR_CTRL)
 #define CPU_FTRS_POWER4	(CPU_FTR_USE_TB | CPU_FTR_LWSYNC | \
 	    CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
-	    CPU_FTR_MMCRA | CPU_FTR_CP_USE_DCBTZ)
+	    CPU_FTR_MMCRA | CPU_FTR_CP_USE_DCBTZ | \
+	    CPU_FTR_STCX_CHECKS_ADDRESS)
 #define CPU_FTRS_PPC970	(CPU_FTR_USE_TB | CPU_FTR_LWSYNC | \
 	    CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
 	    CPU_FTR_ALTIVEC_COMP | CPU_FTR_CAN_NAP | CPU_FTR_MMCRA | \
-	    CPU_FTR_CP_USE_DCBTZ)
+	    CPU_FTR_CP_USE_DCBTZ | CPU_FTR_STCX_CHECKS_ADDRESS)
 #define CPU_FTRS_POWER5	(CPU_FTR_USE_TB | CPU_FTR_LWSYNC | \
 	    CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
 	    CPU_FTR_MMCRA | CPU_FTR_SMT | \
 	    CPU_FTR_COHERENT_ICACHE | CPU_FTR_LOCKLESS_TLBIE | \
-	    CPU_FTR_PURR)
+	    CPU_FTR_PURR | CPU_FTR_STCX_CHECKS_ADDRESS)
 #define CPU_FTRS_POWER6 (CPU_FTR_USE_TB | CPU_FTR_LWSYNC | \
 	    CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
 	    CPU_FTR_MMCRA | CPU_FTR_SMT | \
 	    CPU_FTR_COHERENT_ICACHE | CPU_FTR_LOCKLESS_TLBIE | \
 	    CPU_FTR_PURR | CPU_FTR_SPURR | CPU_FTR_REAL_LE | \
-	    CPU_FTR_DSCR | CPU_FTR_UNALIGNED_LD_STD)
+	    CPU_FTR_DSCR | CPU_FTR_UNALIGNED_LD_STD | \
+	    CPU_FTR_STCX_CHECKS_ADDRESS)
 #define CPU_FTRS_POWER7 (CPU_FTR_USE_TB | CPU_FTR_LWSYNC | \
 	    CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
 	    CPU_FTR_MMCRA | CPU_FTR_SMT | \
 	    CPU_FTR_COHERENT_ICACHE | CPU_FTR_LOCKLESS_TLBIE | \
 	    CPU_FTR_PURR | CPU_FTR_SPURR | CPU_FTR_REAL_LE | \
-	    CPU_FTR_DSCR | CPU_FTR_SAO  | CPU_FTR_ASYM_SMT)
+	    CPU_FTR_DSCR | CPU_FTR_SAO  | CPU_FTR_ASYM_SMT | \
+	    CPU_FTR_STCX_CHECKS_ADDRESS)
 #define CPU_FTRS_CELL	(CPU_FTR_USE_TB | CPU_FTR_LWSYNC | \
 	    CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
 	    CPU_FTR_ALTIVEC_COMP | CPU_FTR_MMCRA | CPU_FTR_SMT | \
Index: powerpc.git/arch/powerpc/kernel/entry_64.S
===================================================================
--- powerpc.git.orig/arch/powerpc/kernel/entry_64.S	2010-08-11 12:56:03.360742333 +1000
+++ powerpc.git/arch/powerpc/kernel/entry_64.S	2010-08-11 13:00:08.862283406 +1000
@@ -202,7 +202,9 @@ syscall_exit:
 	bge-	syscall_error
 syscall_error_cont:
 	ld	r7,_NIP(r1)
+BEGIN_FTR_SECTION
 	stdcx.	r0,0,r1			/* to clear the reservation */
+END_FTR_SECTION_IFCLR(CPU_FTR_STCX_CHECKS_ADDRESS)
 	andi.	r6,r8,MSR_PR
 	ld	r4,_LINK(r1)
 	/*
