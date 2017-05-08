Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wLsrt293wzDqFx
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 May 2017 16:23:42 +1000 (AEST)
From: Michael Neuling <mikey@neuling.org>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
	mikey@neuling.org,
	cyrilbur@gmail.com
Subject: [PATCH] powerpc: Fix asm offsets to point to actual FP and VMX regs
Date: Mon,  8 May 2017 16:23:31 +1000
Message-Id: <20170508062331.11074-1-mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The asm code assumes the FP regs are at the start of fp_state. While
this is true now, it may not always be the case and there is nothing
enforcing it.

This fixes the asm-offsets to point to the actual FP registers inside
the fp_state.  Similarly for VMX.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/kernel/asm-offsets.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 439c257dec..ef1b873fae 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -100,12 +100,12 @@ int main(void)
 	OFFSET(THREAD_NORMSAVES, thread_struct, normsave[0]);
 #endif
 	OFFSET(THREAD_FPEXC_MODE, thread_struct, fpexc_mode);
-	OFFSET(THREAD_FPSTATE, thread_struct, fp_state);
+	OFFSET(THREAD_FPSTATE, thread_struct, fp_state.fpr);
 	OFFSET(THREAD_FPSAVEAREA, thread_struct, fp_save_area);
 	OFFSET(FPSTATE_FPSCR, thread_fp_state, fpscr);
 	OFFSET(THREAD_LOAD_FP, thread_struct, load_fp);
 #ifdef CONFIG_ALTIVEC
-	OFFSET(THREAD_VRSTATE, thread_struct, vr_state);
+	OFFSET(THREAD_VRSTATE, thread_struct, vr_state.vr);
 	OFFSET(THREAD_VRSAVEAREA, thread_struct, vr_save_area);
 	OFFSET(THREAD_VRSAVE, thread_struct, vrsave);
 	OFFSET(THREAD_USED_VR, thread_struct, used_vr);
@@ -145,9 +145,9 @@ int main(void)
 	OFFSET(THREAD_TM_PPR, thread_struct, tm_ppr);
 	OFFSET(THREAD_TM_DSCR, thread_struct, tm_dscr);
 	OFFSET(PT_CKPT_REGS, thread_struct, ckpt_regs);
-	OFFSET(THREAD_CKVRSTATE, thread_struct, ckvr_state);
+	OFFSET(THREAD_CKVRSTATE, thread_struct, ckvr_state.vr);
 	OFFSET(THREAD_CKVRSAVE, thread_struct, ckvrsave);
-	OFFSET(THREAD_CKFPSTATE, thread_struct, ckfp_state);
+	OFFSET(THREAD_CKFPSTATE, thread_struct, ckfp_state.fpr);
 	/* Local pt_regs on stack for Transactional Memory funcs. */
 	DEFINE(TM_FRAME_SIZE, STACK_FRAME_OVERHEAD +
 	       sizeof(struct pt_regs) + 16);
-- 
2.11.0
