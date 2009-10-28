Return-Path: <anton@ozlabs.org>
Date: Wed, 28 Oct 2009 15:46:55 +1100
From: Anton Blanchard <anton@samba.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 2/3] powerpc: Create PPC_WARN_ALIGNMENT to match
	PPC_WARN_EMULATED
Message-ID: <20091028044655.GK3085@kryten>
References: <20091018110929.GK4808@kryten> <20091018111126.GL4808@kryten>
	<20091018233749.0a17ff78.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20091018233749.0a17ff78.sfr@canb.auug.org.au>
Cc: a.p.zijlstra@chello.nl, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, paulus@samba.org, mingo@elte.hu
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

 
Hi Stephen,

> I think this last line is not needed?

Right you are!

Anton

--

perf_event wants a separate event for alignment and emulation faults,
so create another emulation event. This will make it easy to hook in
perf_event at one spot.

We pass in regs which will be required for these events.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Updated to remove unused define, as suggested by Stephen.

Index: linux.trees.git/arch/powerpc/include/asm/emulated_ops.h
===================================================================
--- linux.trees.git.orig/arch/powerpc/include/asm/emulated_ops.h	2009-10-19 09:46:58.000000000 +1100
+++ linux.trees.git/arch/powerpc/include/asm/emulated_ops.h	2009-10-21 14:57:00.000000000 +1100
@@ -57,7 +57,7 @@ extern u32 ppc_warn_emulated;
 
 extern void ppc_warn_emulated_print(const char *type);
 
-#define PPC_WARN_EMULATED(type)						 \
+#define __PPC_WARN_EMULATED(type)					 \
 	do {								 \
 		atomic_inc(&ppc_emulated.type.val);			 \
 		if (ppc_warn_emulated)					 \
@@ -66,8 +66,11 @@ extern void ppc_warn_emulated_print(cons
 
 #else /* !CONFIG_PPC_EMULATED_STATS */
 
-#define PPC_WARN_EMULATED(type)	do { } while (0)
+#define __PPC_WARN_EMULATED(type)	do { } while (0)
 
 #endif /* !CONFIG_PPC_EMULATED_STATS */
 
+#define PPC_WARN_EMULATED(type, regs)	__PPC_WARN_EMULATED(type)
+#define PPC_WARN_ALIGNMENT(type, regs)	__PPC_WARN_EMULATED(type)
+
 #endif /* _ASM_POWERPC_EMULATED_OPS_H */
Index: linux.trees.git/arch/powerpc/kernel/align.c
===================================================================
--- linux.trees.git.orig/arch/powerpc/kernel/align.c	2009-10-19 09:46:58.000000000 +1100
+++ linux.trees.git/arch/powerpc/kernel/align.c	2009-10-21 10:21:35.000000000 +1100
@@ -732,7 +732,7 @@ int fix_alignment(struct pt_regs *regs)
 
 #ifdef CONFIG_SPE
 	if ((instr >> 26) == 0x4) {
-		PPC_WARN_EMULATED(spe);
+		PPC_WARN_ALIGNMENT(spe, regs);
 		return emulate_spe(regs, reg, instr);
 	}
 #endif
@@ -786,7 +786,7 @@ int fix_alignment(struct pt_regs *regs)
 			flags |= SPLT;
 			nb = 8;
 		}
-		PPC_WARN_EMULATED(vsx);
+		PPC_WARN_ALIGNMENT(vsx, regs);
 		return emulate_vsx(addr, reg, areg, regs, flags, nb);
 	}
 #endif
@@ -794,7 +794,7 @@ int fix_alignment(struct pt_regs *regs)
 	 * the exception of DCBZ which is handled as a special case here
 	 */
 	if (instr == DCBZ) {
-		PPC_WARN_EMULATED(dcbz);
+		PPC_WARN_ALIGNMENT(dcbz, regs);
 		return emulate_dcbz(regs, addr);
 	}
 	if (unlikely(nb == 0))
@@ -804,7 +804,7 @@ int fix_alignment(struct pt_regs *regs)
 	 * function
 	 */
 	if (flags & M) {
-		PPC_WARN_EMULATED(multiple);
+		PPC_WARN_ALIGNMENT(multiple, regs);
 		return emulate_multiple(regs, addr, reg, nb,
 					flags, instr, swiz);
 	}
@@ -825,11 +825,11 @@ int fix_alignment(struct pt_regs *regs)
 
 	/* Special case for 16-byte FP loads and stores */
 	if (nb == 16) {
-		PPC_WARN_EMULATED(fp_pair);
+		PPC_WARN_ALIGNMENT(fp_pair, regs);
 		return emulate_fp_pair(addr, reg, flags);
 	}
 
-	PPC_WARN_EMULATED(unaligned);
+	PPC_WARN_ALIGNMENT(unaligned, regs);
 
 	/* If we are loading, get the data from user space, else
 	 * get it from register values
Index: linux.trees.git/arch/powerpc/kernel/traps.c
===================================================================
--- linux.trees.git.orig/arch/powerpc/kernel/traps.c	2009-10-19 09:46:58.000000000 +1100
+++ linux.trees.git/arch/powerpc/kernel/traps.c	2009-10-21 10:21:35.000000000 +1100
@@ -759,7 +759,7 @@ static int emulate_instruction(struct pt
 
 	/* Emulate the mfspr rD, PVR. */
 	if ((instword & PPC_INST_MFSPR_PVR_MASK) == PPC_INST_MFSPR_PVR) {
-		PPC_WARN_EMULATED(mfpvr);
+		PPC_WARN_EMULATED(mfpvr, regs);
 		rd = (instword >> 21) & 0x1f;
 		regs->gpr[rd] = mfspr(SPRN_PVR);
 		return 0;
@@ -767,7 +767,7 @@ static int emulate_instruction(struct pt
 
 	/* Emulating the dcba insn is just a no-op.  */
 	if ((instword & PPC_INST_DCBA_MASK) == PPC_INST_DCBA) {
-		PPC_WARN_EMULATED(dcba);
+		PPC_WARN_EMULATED(dcba, regs);
 		return 0;
 	}
 
@@ -776,7 +776,7 @@ static int emulate_instruction(struct pt
 		int shift = (instword >> 21) & 0x1c;
 		unsigned long msk = 0xf0000000UL >> shift;
 
-		PPC_WARN_EMULATED(mcrxr);
+		PPC_WARN_EMULATED(mcrxr, regs);
 		regs->ccr = (regs->ccr & ~msk) | ((regs->xer >> shift) & msk);
 		regs->xer &= ~0xf0000000UL;
 		return 0;
@@ -784,19 +784,19 @@ static int emulate_instruction(struct pt
 
 	/* Emulate load/store string insn. */
 	if ((instword & PPC_INST_STRING_GEN_MASK) == PPC_INST_STRING) {
-		PPC_WARN_EMULATED(string);
+		PPC_WARN_EMULATED(string, regs);
 		return emulate_string_inst(regs, instword);
 	}
 
 	/* Emulate the popcntb (Population Count Bytes) instruction. */
 	if ((instword & PPC_INST_POPCNTB_MASK) == PPC_INST_POPCNTB) {
-		PPC_WARN_EMULATED(popcntb);
+		PPC_WARN_EMULATED(popcntb, regs);
 		return emulate_popcntb_inst(regs, instword);
 	}
 
 	/* Emulate isel (Integer Select) instruction */
 	if ((instword & PPC_INST_ISEL_MASK) == PPC_INST_ISEL) {
-		PPC_WARN_EMULATED(isel);
+		PPC_WARN_EMULATED(isel, regs);
 		return emulate_isel(regs, instword);
 	}
 
@@ -995,7 +995,7 @@ void SoftwareEmulation(struct pt_regs *r
 #ifdef CONFIG_MATH_EMULATION
 	errcode = do_mathemu(regs);
 	if (errcode >= 0)
-		PPC_WARN_EMULATED(math);
+		PPC_WARN_EMULATED(math, regs);
 
 	switch (errcode) {
 	case 0:
@@ -1018,7 +1018,7 @@ void SoftwareEmulation(struct pt_regs *r
 #elif defined(CONFIG_8XX_MINIMAL_FPEMU)
 	errcode = Soft_emulate_8xx(regs);
 	if (errcode >= 0)
-		PPC_WARN_EMULATED(8xx);
+		PPC_WARN_EMULATED(8xx, regs);
 
 	switch (errcode) {
 	case 0:
@@ -1129,7 +1129,7 @@ void altivec_assist_exception(struct pt_
 
 	flush_altivec_to_thread(current);
 
-	PPC_WARN_EMULATED(altivec);
+	PPC_WARN_EMULATED(altivec, regs);
 	err = emulate_altivec(regs);
 	if (err == 0) {
 		regs->nip += 4;		/* skip emulated instruction */
