Return-Path: <anton@ozlabs.org>
Date: Wed, 11 Aug 2010 21:40:27 +1000
From: Anton Blanchard <anton@samba.org>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] powerpc: Feature nop out reservation clear when stcx
	checks address
Message-ID: <20100811114027.GW29316@kryten>
References: <20100811052005.GV29316@kryten>
 <20100811064152.GC15252@drongo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100811064152.GC15252@drongo>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi Paul,

> Nice...  Just one nit, and that is that I think we now need a dummy
> stcx in the context switch code so there is no possibility of getting
> from one user context to another with a reservation still pending from
> the first context.  I guess our chances of getting through schedule()
> without doing any atomics, bitops or spinlocks are pretty remote, but
> nevertheless it might be as well to make sure.

Good point. How does this look? It also swaps uses a larx in the exception
exit path if we can, it's a clear win too.

Anton
--

[PATCH] powerpc: Feature nop out reservation clear when stcx checks address

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

Another suggestion was to use a larx to something in the L1 instead of a stcx.
This was almost as fast as removing the larx on POWER6, but only 3.5% faster
on POWER7. We can use this to speed up the reservation clear in our
exception exit code.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: powerpc.git/arch/powerpc/kernel/entry_64.S
===================================================================
--- powerpc.git.orig/arch/powerpc/kernel/entry_64.S	2010-08-11 21:04:52.644491970 +1000
+++ powerpc.git/arch/powerpc/kernel/entry_64.S	2010-08-11 21:13:46.210740998 +1000
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
@@ -419,6 +421,17 @@ END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
 	sync
 #endif /* CONFIG_SMP */
 
+	/*
+	 * If we optimise away the clear of the reservation in system
+	 * calls because we know the CPU tracks the address of the
+	 * reservation, then we need to clear it here to cover the
+	 * case that the kernel context switch path has no larx
+	 * instructions.
+	 */
+BEGIN_FTR_SECTION
+	ldarx	r6,0,r1
+END_FTR_SECTION_IFSET(CPU_FTR_STCX_CHECKS_ADDRESS)
+
 	addi	r6,r4,-THREAD	/* Convert THREAD to 'current' */
 	std	r6,PACACURRENT(r13)	/* Set new 'current' */
 
@@ -576,7 +589,16 @@ ALT_FW_FTR_SECTION_END_IFCLR(FW_FEATURE_
 	andi.	r0,r3,MSR_RI
 	beq-	unrecov_restore
 
+	/*
+	 * Clear the reservation. If we know the CPU tracks the address of
+	 * the reservation then we can potentially save some cycles and use
+	 * a larx. On POWER6 and POWER7 this is significantly faster.
+	 */
+BEGIN_FTR_SECTION
 	stdcx.	r0,0,r1		/* to clear the reservation */
+FTR_SECTION_ELSE
+	ldarx	r4,0,r1
+ALT_FTR_SECTION_END_IFCLR(CPU_FTR_STCX_CHECKS_ADDRESS)
 
 	/*
 	 * Clear RI before restoring r13.  If we are returning to
Index: powerpc.git/arch/powerpc/include/asm/cputable.h
===================================================================
--- powerpc.git.orig/arch/powerpc/include/asm/cputable.h	2010-08-11 21:04:52.614491766 +1000
+++ powerpc.git/arch/powerpc/include/asm/cputable.h	2010-08-11 21:13:14.190741348 +1000
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
