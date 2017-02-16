Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vPVby2zHtzDq8X
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Feb 2017 09:06:22 +1100 (AEDT)
Date: Fri, 17 Feb 2017 09:06:21 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, PowerPC <linuxppc-dev@lists.ozlabs.org>
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, Rashmica Gupta
 <rashmicy@gmail.com>
Subject: linux-next: manual merge of the powerpc tree with Linus' tree
Message-ID: <20170217090621.29b02a59@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi all,

FIXME: Add owner of second tree to To:
       Add author(s)/SOB of conflicting commits.

Today's linux-next merge of the powerpc tree got a conflict in:

  arch/powerpc/kernel/asm-offsets.c

between commit:

  f2574030b0e3 ("powerpc: Revert the initial stack protector support")

from Linus' tree and commit:

  454656155110 ("powerpc/asm: Use OFFSET macro in asm-offsets.c")

from the powerpc tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

-- 
Cheers,
Stephen Rothwell

diff --cc arch/powerpc/kernel/asm-offsets.c
index 195a9fc8f81c,b6709021fee5..000000000000
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@@ -88,39 -91,42 +91,39 @@@ int main(void
  #endif /* CONFIG_PPC64 */
  
  #ifdef CONFIG_LIVEPATCH
- 	DEFINE(TI_livepatch_sp, offsetof(struct thread_info, livepatch_sp));
+ 	OFFSET(TI_livepatch_sp, thread_info, livepatch_sp);
  #endif
  
- 	DEFINE(KSP, offsetof(struct thread_struct, ksp));
- 	DEFINE(PT_REGS, offsetof(struct thread_struct, regs));
 -#ifdef CONFIG_CC_STACKPROTECTOR
 -	DEFINE(TSK_STACK_CANARY, offsetof(struct task_struct, stack_canary));
 -#endif
+ 	OFFSET(KSP, thread_struct, ksp);
+ 	OFFSET(PT_REGS, thread_struct, regs);
  #ifdef CONFIG_BOOKE
- 	DEFINE(THREAD_NORMSAVES, offsetof(struct thread_struct, normsave[0]));
+ 	OFFSET(THREAD_NORMSAVES, thread_struct, normsave[0]);
  #endif
- 	DEFINE(THREAD_FPEXC_MODE, offsetof(struct thread_struct, fpexc_mode));
- 	DEFINE(THREAD_FPSTATE, offsetof(struct thread_struct, fp_state));
- 	DEFINE(THREAD_FPSAVEAREA, offsetof(struct thread_struct, fp_save_area));
- 	DEFINE(FPSTATE_FPSCR, offsetof(struct thread_fp_state, fpscr));
- 	DEFINE(THREAD_LOAD_FP, offsetof(struct thread_struct, load_fp));
+ 	OFFSET(THREAD_FPEXC_MODE, thread_struct, fpexc_mode);
+ 	OFFSET(THREAD_FPSTATE, thread_struct, fp_state);
+ 	OFFSET(THREAD_FPSAVEAREA, thread_struct, fp_save_area);
+ 	OFFSET(FPSTATE_FPSCR, thread_fp_state, fpscr);
+ 	OFFSET(THREAD_LOAD_FP, thread_struct, load_fp);
  #ifdef CONFIG_ALTIVEC
- 	DEFINE(THREAD_VRSTATE, offsetof(struct thread_struct, vr_state));
- 	DEFINE(THREAD_VRSAVEAREA, offsetof(struct thread_struct, vr_save_area));
- 	DEFINE(THREAD_VRSAVE, offsetof(struct thread_struct, vrsave));
- 	DEFINE(THREAD_USED_VR, offsetof(struct thread_struct, used_vr));
- 	DEFINE(VRSTATE_VSCR, offsetof(struct thread_vr_state, vscr));
- 	DEFINE(THREAD_LOAD_VEC, offsetof(struct thread_struct, load_vec));
+ 	OFFSET(THREAD_VRSTATE, thread_struct, vr_state);
+ 	OFFSET(THREAD_VRSAVEAREA, thread_struct, vr_save_area);
+ 	OFFSET(THREAD_VRSAVE, thread_struct, vrsave);
+ 	OFFSET(THREAD_USED_VR, thread_struct, used_vr);
+ 	OFFSET(VRSTATE_VSCR, thread_vr_state, vscr);
+ 	OFFSET(THREAD_LOAD_VEC, thread_struct, load_vec);
  #endif /* CONFIG_ALTIVEC */
  #ifdef CONFIG_VSX
- 	DEFINE(THREAD_USED_VSR, offsetof(struct thread_struct, used_vsr));
+ 	OFFSET(THREAD_USED_VSR, thread_struct, used_vsr);
  #endif /* CONFIG_VSX */
  #ifdef CONFIG_PPC64
- 	DEFINE(KSP_VSID, offsetof(struct thread_struct, ksp_vsid));
+ 	OFFSET(KSP_VSID, thread_struct, ksp_vsid);
  #else /* CONFIG_PPC64 */
- 	DEFINE(PGDIR, offsetof(struct thread_struct, pgdir));
+ 	OFFSET(PGDIR, thread_struct, pgdir);
  #ifdef CONFIG_SPE
- 	DEFINE(THREAD_EVR0, offsetof(struct thread_struct, evr[0]));
- 	DEFINE(THREAD_ACC, offsetof(struct thread_struct, acc));
- 	DEFINE(THREAD_SPEFSCR, offsetof(struct thread_struct, spefscr));
- 	DEFINE(THREAD_USED_SPE, offsetof(struct thread_struct, used_spe));
+ 	OFFSET(THREAD_EVR0, thread_struct, evr[0]);
+ 	OFFSET(THREAD_ACC, thread_struct, acc);
+ 	OFFSET(THREAD_SPEFSCR, thread_struct, spefscr);
+ 	OFFSET(THREAD_USED_SPE, thread_struct, used_spe);
  #endif /* CONFIG_SPE */
  #endif /* CONFIG_PPC64 */
  #if defined(CONFIG_4xx) || defined(CONFIG_BOOKE)
