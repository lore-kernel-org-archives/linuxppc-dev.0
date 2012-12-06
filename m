Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Jimi Xenidis <jimix@pobox.com>
Subject: Re: Hijacking CPU_FTR_VSX for BGQ QPX
In-reply-to: <7FAFB642-039B-401C-9348-4D8E94511E6A@pobox.com>
References: <29970ED2-02E3-45F5-96FD-B4270385E3ED@pobox.com>
 <1352491029.23412.3.camel@pasglop> <3948.1352522003@neuling.org>
 <7FAFB642-039B-401C-9348-4D8E94511E6A@pobox.com>
Date: Thu, 06 Dec 2012 13:00:39 +1100
Message-ID: <26037.1354759239@neuling.org>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Jimi Xenidis <jimix@pobox.com> wrote:

> Sorry for the pause, lots of other things getting done... questions below.
> 
> On Nov 9, 2012, at 10:33 PM, Michael Neuling <mikey@neuling.org> wrote:
> 
> > Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> > 
> >> On Fri, 2012-11-09 at 11:43 -0600, Jimi Xenidis wrote:
> >>> The CPU_FTR_* values are pretty tight (a few bits left) yes I need to save and restore the QPX registers.
> >>> There are 32 QPX registers, each 32 bytes in size, it is otherwise managed by the FPSCR and MSR[FP]
> >>> 
> >>> I was thinking that I could hijack the VSX, since there is no plan to add it to embedded yet.
> >>> I could be explicit or create an alieas fo the same bit, but the basic effect (after increasing the save area size) would be something like the diff below.
> >>> Thoughts?
> >> 
> >> Don't. Use a different bit, we can always split the mask again if
> >> needed, move more bits to mmu_features etc...
> 
> Ok
> 
> >> 
> >>> -#ifdef CONFIG_VSX
> >>> +#if defined (CONFIG_VSX) && defined(CONFIG_BGQ)
> >>> +# error "This code depends on CONFIG_VSX and CONFIG_BGQ being exclusive
> >>> +#elif defined (CONFIG_VSX)
> >>> +# define _REST_32VSRS(n,c,base) REST_32VSRS(n,c,base)
> >>> +# define _SAVE_32VSRS(n,c,base) SAVE_32VSRS(n,c,base)
> >>> +#elif defined(CONFIG_BGQ)
> >> 
> >> Make a CONFIG_PPC_QPX or something like that specifically for the QPX
> >> stuff that you can then "select" from CONFIG_PPC_BGQ (don't do just
> >> CONFIG_BGQ).
> 
> ack
> 
> >> 
> >> And don't just "hijack" stuff like that, it should be a runtime option,
> >> so add a new set etc... it should be possible to build a kernel that
> >> boots on a BGQ or a hypothetical BookE chip with VSX.
> 
> ack
> > 
> > Yeah both bluegene and VSX are designed for HPC, so it's not completely
> > crazy that someone would put them together.
> 
> Not sure that is possible, since they both "include" FPU state, which
> is why hijacking the the FPU routines is so delicious.

I have this patch in my tree to push upstream at some point.  It packs
all the CPU_FTR_* bits so that we have a few free at the end.

Benh: How about we take this now (or whatever merges).  Then we add a
the new bits we know we need in the near future like PPR, DOORBELLS, TM,
and JIMIS_VERY_CRAZY_BGQ_FPU?  

Or, can we all just post random CPU_FTR bits and you'll (benh) fix the
merge issues?

Mikey

commit 35f9a3ed7065b80013df87e33a832537c2ce224e
Author: Michael Neuling <mikey@neuling.org>
Date:   Fri Nov 30 16:40:56 2012 +1100

    repack 64bit cpu features to remove holes

diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index 2111032..7e4c7a4 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -148,30 +148,30 @@ extern const char *powerpc_base_platform;
 #define LONG_ASM_CONST(x)		0
 #endif
 
-#define CPU_FTR_HVMODE			LONG_ASM_CONST(0x0000000200000000)
-#define CPU_FTR_ARCH_201		LONG_ASM_CONST(0x0000000400000000)
-#define CPU_FTR_ARCH_206		LONG_ASM_CONST(0x0000000800000000)
-#define CPU_FTR_CFAR			LONG_ASM_CONST(0x0000001000000000)
-#define CPU_FTR_IABR			LONG_ASM_CONST(0x0000002000000000)
-#define CPU_FTR_MMCRA			LONG_ASM_CONST(0x0000004000000000)
-#define CPU_FTR_CTRL			LONG_ASM_CONST(0x0000008000000000)
-#define CPU_FTR_SMT			LONG_ASM_CONST(0x0000010000000000)
-#define CPU_FTR_PAUSE_ZERO		LONG_ASM_CONST(0x0000200000000000)
-#define CPU_FTR_PURR			LONG_ASM_CONST(0x0000400000000000)
-#define CPU_FTR_CELL_TB_BUG		LONG_ASM_CONST(0x0000800000000000)
-#define CPU_FTR_SPURR			LONG_ASM_CONST(0x0001000000000000)
-#define CPU_FTR_DSCR			LONG_ASM_CONST(0x0002000000000000)
-#define CPU_FTR_VSX			LONG_ASM_CONST(0x0010000000000000)
-#define CPU_FTR_SAO			LONG_ASM_CONST(0x0020000000000000)
-#define CPU_FTR_CP_USE_DCBTZ		LONG_ASM_CONST(0x0040000000000000)
-#define CPU_FTR_UNALIGNED_LD_STD	LONG_ASM_CONST(0x0080000000000000)
-#define CPU_FTR_ASYM_SMT		LONG_ASM_CONST(0x0100000000000000)
-#define CPU_FTR_STCX_CHECKS_ADDRESS	LONG_ASM_CONST(0x0200000000000000)
-#define CPU_FTR_POPCNTB			LONG_ASM_CONST(0x0400000000000000)
-#define CPU_FTR_POPCNTD			LONG_ASM_CONST(0x0800000000000000)
-#define CPU_FTR_ICSWX			LONG_ASM_CONST(0x1000000000000000)
-#define CPU_FTR_VMX_COPY		LONG_ASM_CONST(0x2000000000000000)
-#define CPU_FTR_TM			LONG_ASM_CONST(0x4000000000000000)
+#define CPU_FTR_HVMODE			LONG_ASM_CONST(0x0000000100000000)
+#define CPU_FTR_ARCH_201		LONG_ASM_CONST(0x0000000200000000)
+#define CPU_FTR_ARCH_206		LONG_ASM_CONST(0x0000000400000000)
+#define CPU_FTR_CFAR			LONG_ASM_CONST(0x0000000800000000)
+#define CPU_FTR_IABR			LONG_ASM_CONST(0x0000001000000000)
+#define CPU_FTR_MMCRA			LONG_ASM_CONST(0x0000002000000000)
+#define CPU_FTR_CTRL			LONG_ASM_CONST(0x0000004000000000)
+#define CPU_FTR_SMT			LONG_ASM_CONST(0x0000008000000000)
+#define CPU_FTR_PAUSE_ZERO		LONG_ASM_CONST(0x0000010000000000)
+#define CPU_FTR_PURR			LONG_ASM_CONST(0x0000020000000000)
+#define CPU_FTR_CELL_TB_BUG		LONG_ASM_CONST(0x0000040000000000)
+#define CPU_FTR_SPURR			LONG_ASM_CONST(0x0000080000000000)
+#define CPU_FTR_DSCR			LONG_ASM_CONST(0x0000100000000000)
+#define CPU_FTR_VSX			LONG_ASM_CONST(0x0000200000000000)
+#define CPU_FTR_SAO			LONG_ASM_CONST(0x0000400000000000)
+#define CPU_FTR_CP_USE_DCBTZ		LONG_ASM_CONST(0x0000800000000000)
+#define CPU_FTR_UNALIGNED_LD_STD	LONG_ASM_CONST(0x0001000000000000)
+#define CPU_FTR_ASYM_SMT		LONG_ASM_CONST(0x0002000000000000)
+#define CPU_FTR_STCX_CHECKS_ADDRESS	LONG_ASM_CONST(0x0004000000000000)
+#define CPU_FTR_POPCNTB			LONG_ASM_CONST(0x0008000000000000)
+#define CPU_FTR_POPCNTD			LONG_ASM_CONST(0x0010000000000000)
+#define CPU_FTR_ICSWX			LONG_ASM_CONST(0x0020000000000000)
+#define CPU_FTR_VMX_COPY		LONG_ASM_CONST(0x0040000000000000)
+#define CPU_FTR_TM			LONG_ASM_CONST(0x0080000000000000)
 
 #ifndef __ASSEMBLY__
 
