Return-Path: <linuxppc-dev+bounces-21857-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B031CD6E57
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Jun 2026 08:46:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gV4FW4QhHz3bpG;
	Tue, 02 Jun 2026 18:46:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780390015;
	cv=none; b=B3dgl16Tbp7idkq8TUZp4d0g04W/jwnCyK82xdMQS1t/EajnBFp9w6GxmhfVnZwPbfpsOjmTvQf6mmf0zb7N2E2Y2TtujEzojLQOqkj0j7bAOMLLgo2MGDcb1/f9+Kttfns/LNupluEnnF1h86hoOXLRypQI1dHMA01opXtGKpROEYrcmFe8wsOBDuLGTLt1x/qrW3TEFK6nXuLaB1g5AnR0Y+DwaG8PIkFeMm3kgv+9wwbDPJhldFJnmDU1OMRQnw3FSMkeCuqgMngtvb67izroJZ08UX31Rw801v+Ev1bfN5m5848BV8+Ezwsgsir7MLdZUJsYvLQZzVKBagoWAw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780390015; c=relaxed/relaxed;
	bh=1vwc/KR3sNRx33HkEWDynGkEORnc/I5YEMTBxDajIjw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fiF0rs8XPayosZIg6bY73IB3UKcHrBxAQQiWTH6fVLnLD/Q6RF6WsZQHM7rK0pXDKpEfil/Z3l/vSNcF4svI/GJ6pbg2PNKLq57ohRZbB1At7tleKFxBopcizGTR4fQKiaoQrd9xX7LkL20o0BvU0r/BL0OkiNKME6UsA2oa14YQ6WOFsNE1XDMwF6m3UPN6JvMCZlCV5ot9hn9wP7OYu4zvOVcxkkqitMeLoMcWCy4cHuiOo+l2vcEFaLLA7nUj4P/edfsiR769ZB3y+Tl39jJlI46ZpTBl5wWQOVE1VCg1MENtpyqF5AMJFpi/bgdUjOmCeqCyQjrSUNXVz/vXqQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kj0n5IlR; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kj0n5IlR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gV4FV1B6nz2xLm
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Jun 2026 18:46:54 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 0763041832;
	Tue,  2 Jun 2026 08:46:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 099511F00899;
	Tue,  2 Jun 2026 08:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780390011;
	bh=1vwc/KR3sNRx33HkEWDynGkEORnc/I5YEMTBxDajIjw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Kj0n5IlRAZfZSFbi59rB0HGzhF20u2WsE8XpvBC0d7g3o6i/LEmkzds0Rn8XGIQ7i
	 lL6pSv+ozbtcfdXgETwtvXqCpWc3N1m4B1vrmu9fXbQmF/FIybGABvtSPq1q4dxYFG
	 qU7OuIK04KWoLtx9LyD2LGV1hD29FxvW9DNc3WzYvJovn3WVR7n7Qqi9W1VR/CPFH7
	 QCXjqX91WbWtDTYUQZMLgVNm0e0vK2DSHZmXi6B7Brxkuai8xUf6FLsJOjxtzdRhVc
	 +akc+d5l576Ok4D7QXl+BfDnf8RsdyQcco52vbpu+xM9qBKomuosbLGBWGTREHoYZd
	 YuKbDMPNc9Bjg==
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 1/8] powerpc/signal32: Convert to scoped user access
Date: Tue,  2 Jun 2026 10:46:30 +0200
Message-ID: <4d101e232543f54dfb4eb7a2806e180e63f6c918.1780389863.git.chleroy@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1780389863.git.chleroy@kernel.org>
References: <cover.1780389863.git.chleroy@kernel.org>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=23207; i=chleroy@kernel.org; h=from:subject:message-id; bh=NudAOrXGuk31+TSU2hNrOuNcV501EprG3myB9gtNJ/8=; b=owGbwMvMwCV2d0KB2p7V54MZT6slMWTJzcg9OV2FYdLi4xKJGUrP/S6VyeXkZEy+uSrvXYSmu qPmrT/bO0pYGMS4GGTFFFmO/+feNaPrS2r+1F36MHNYmUCGMHBxCsBETLYzfNOb0ML2RYFT5jW/ bc5LyVMsIYLX/R2+Pm6uisnYssHgJMP/kOk/ePZu4mi+IHZGSN8qRFEoTUL3bV2T4cuLou6v3rH wAgA=
X-Developer-Key: i=chleroy@kernel.org; a=openpgp; fpr=10FFE6F8B390DE17ACC2632368A92FEB01B8DD78
Content-Transfer-Encoding: 8bit

Commit 861574d51bbd ("powerpc/uaccess: Implement masked user access")
provides optimised user access by avoiding the cost of access_ok().

Convert signal32 functions to scoped user access.

Scoped user access also make the code simpler.

Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
---
 arch/powerpc/kernel/signal_32.c | 456 +++++++++++++++-----------------
 1 file changed, 217 insertions(+), 239 deletions(-)

diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
index 7a718ed32b27..f5d5139a1426 100644
--- a/arch/powerpc/kernel/signal_32.c
+++ b/arch/powerpc/kernel/signal_32.c
@@ -468,98 +468,98 @@ static long restore_user_regs(struct pt_regs *regs,
 {
 	unsigned int save_r2 = 0;
 	unsigned long msr;
-#ifdef CONFIG_VSX
-	int i;
-#endif
 
-	if (!user_read_access_begin(sr, sizeof(*sr)))
-		return 1;
-	/*
-	 * restore general registers but not including MSR or SOFTE. Also
-	 * take care of keeping r2 (TLS) intact if not a signal
-	 */
-	if (!sig)
-		save_r2 = (unsigned int)regs->gpr[2];
-	unsafe_restore_general_regs(regs, sr, failed);
-	set_trap_norestart(regs);
-	unsafe_get_user(msr, &sr->mc_gregs[PT_MSR], failed);
-	if (!sig)
-		regs->gpr[2] = (unsigned long) save_r2;
-
-	/* if doing signal return, restore the previous little-endian mode */
-	if (sig)
-		regs_set_return_msr(regs, (regs->msr & ~MSR_LE) | (msr & MSR_LE));
+	scoped_user_read_access(sr, failed) {
+		/*
+		 * restore general registers but not including MSR or SOFTE. Also
+		 * take care of keeping r2 (TLS) intact if not a signal
+		 */
+		if (!sig)
+			save_r2 = (unsigned int)regs->gpr[2];
+		unsafe_restore_general_regs(regs, sr, failed);
+		set_trap_norestart(regs);
+		unsafe_get_user(msr, &sr->mc_gregs[PT_MSR], failed);
+		if (!sig)
+			regs->gpr[2] = (unsigned long)save_r2;
+
+		/* if doing signal return, restore the previous little-endian mode */
+		if (sig)
+			regs_set_return_msr(regs, (regs->msr & ~MSR_LE) | (msr & MSR_LE));
 
 #ifdef CONFIG_ALTIVEC
-	/*
-	 * Force the process to reload the altivec registers from
-	 * current->thread when it next does altivec instructions
-	 */
-	regs_set_return_msr(regs, regs->msr & ~MSR_VEC);
-	if (msr & MSR_VEC) {
-		/* restore altivec registers from the stack */
-		unsafe_copy_from_user(&current->thread.vr_state, &sr->mc_vregs,
-				      sizeof(sr->mc_vregs), failed);
-		current->thread.used_vr = true;
-	} else if (current->thread.used_vr)
-		memset(&current->thread.vr_state, 0,
-		       ELF_NVRREG * sizeof(vector128));
-
-	/* Always get VRSAVE back */
-	unsafe_get_user(current->thread.vrsave, (u32 __user *)&sr->mc_vregs[32], failed);
-	if (cpu_has_feature(CPU_FTR_ALTIVEC))
-		mtspr(SPRN_VRSAVE, current->thread.vrsave);
+		/*
+		 * Force the process to reload the altivec registers from
+		 * current->thread when it next does altivec instructions
+		 */
+		regs_set_return_msr(regs, regs->msr & ~MSR_VEC);
+		if (msr & MSR_VEC) {
+			/* restore altivec registers from the stack */
+			unsafe_copy_from_user(&current->thread.vr_state, &sr->mc_vregs,
+					      sizeof(sr->mc_vregs), failed);
+			current->thread.used_vr = true;
+		} else if (current->thread.used_vr) {
+			memset(&current->thread.vr_state, 0,
+			       ELF_NVRREG * sizeof(vector128));
+		}
+
+		/* Always get VRSAVE back */
+		unsafe_get_user(current->thread.vrsave, (u32 __user *)&sr->mc_vregs[32], failed);
+		if (cpu_has_feature(CPU_FTR_ALTIVEC))
+			mtspr(SPRN_VRSAVE, current->thread.vrsave);
 #endif /* CONFIG_ALTIVEC */
-	unsafe_copy_fpr_from_user(current, &sr->mc_fregs, failed);
+		unsafe_copy_fpr_from_user(current, &sr->mc_fregs, failed);
 
 #ifdef CONFIG_VSX
-	/*
-	 * Force the process to reload the VSX registers from
-	 * current->thread when it next does VSX instruction.
-	 */
-	regs_set_return_msr(regs, regs->msr & ~MSR_VSX);
-	if (msr & MSR_VSX) {
 		/*
-		 * Restore altivec registers from the stack to a local
-		 * buffer, then write this out to the thread_struct
+		 * Force the process to reload the VSX registers from
+		 * current->thread when it next does VSX instruction.
 		 */
-		unsafe_copy_vsx_from_user(current, &sr->mc_vsregs, failed);
-		current->thread.used_vsr = true;
-	} else if (current->thread.used_vsr)
-		for (i = 0; i < 32 ; i++)
-			current->thread.fp_state.fpr[i][TS_VSRLOWOFFSET] = 0;
+		regs_set_return_msr(regs, regs->msr & ~MSR_VSX);
+		if (msr & MSR_VSX) {
+			/*
+			 * Restore altivec registers from the stack to a local
+			 * buffer, then write this out to the thread_struct
+			 */
+			unsafe_copy_vsx_from_user(current, &sr->mc_vsregs, failed);
+			current->thread.used_vsr = true;
+		} else if (current->thread.used_vsr) {
+			int i;
+
+			for (i = 0; i < 32 ; i++)
+				current->thread.fp_state.fpr[i][TS_VSRLOWOFFSET] = 0;
+		}
 #endif /* CONFIG_VSX */
-	/*
-	 * force the process to reload the FP registers from
-	 * current->thread when it next does FP instructions
-	 */
-	regs_set_return_msr(regs, regs->msr & ~(MSR_FP | MSR_FE0 | MSR_FE1));
+		/*
+		 * force the process to reload the FP registers from
+		 * current->thread when it next does FP instructions
+		 */
+		regs_set_return_msr(regs, regs->msr & ~(MSR_FP | MSR_FE0 | MSR_FE1));
 
 #ifdef CONFIG_SPE
-	/*
-	 * Force the process to reload the spe registers from
-	 * current->thread when it next does spe instructions.
-	 * Since this is user ABI, we must enforce the sizing.
-	 */
-	BUILD_BUG_ON(sizeof(current->thread.spe) != ELF_NEVRREG * sizeof(u32));
-	regs_set_return_msr(regs, regs->msr & ~MSR_SPE);
-	if (msr & MSR_SPE) {
-		/* restore spe registers from the stack */
-		unsafe_copy_from_user(&current->thread.spe, &sr->mc_vregs,
-				      sizeof(current->thread.spe), failed);
-		current->thread.used_spe = true;
-	} else if (current->thread.used_spe)
-		memset(&current->thread.spe, 0, sizeof(current->thread.spe));
-
-	/* Always get SPEFSCR back */
-	unsafe_get_user(current->thread.spefscr, (u32 __user *)&sr->mc_vregs + ELF_NEVRREG, failed);
-#endif /* CONFIG_SPE */
+		/*
+		 * Force the process to reload the spe registers from
+		 * current->thread when it next does spe instructions.
+		 * Since this is user ABI, we must enforce the sizing.
+		 */
+		BUILD_BUG_ON(sizeof(current->thread.spe) != ELF_NEVRREG * sizeof(u32));
+		regs_set_return_msr(regs, regs->msr & ~MSR_SPE);
+		if (msr & MSR_SPE) {
+			/* restore spe registers from the stack */
+			unsafe_copy_from_user(&current->thread.spe, &sr->mc_vregs,
+					      sizeof(current->thread.spe), failed);
+			current->thread.used_spe = true;
+		} else if (current->thread.used_spe) {
+			memset(&current->thread.spe, 0, sizeof(current->thread.spe));
+		}
 
-	user_read_access_end();
+		/* Always get SPEFSCR back */
+		unsafe_get_user(current->thread.spefscr,
+				(u32 __user *)&sr->mc_vregs + ELF_NEVRREG, failed);
+#endif /* CONFIG_SPE */
+	}
 	return 0;
 
 failed:
-	user_read_access_end();
 	return 1;
 }
 
@@ -574,7 +574,6 @@ static long restore_tm_user_regs(struct pt_regs *regs,
 				 struct mcontext __user *tm_sr)
 {
 	unsigned long msr, msr_hi;
-	int i;
 
 	if (tm_suspend_disabled)
 		return 1;
@@ -585,86 +584,81 @@ static long restore_tm_user_regs(struct pt_regs *regs,
 	 * TFHAR is restored from the checkpointed NIP; TEXASR and TFIAR
 	 * were set by the signal delivery.
 	 */
-	if (!user_read_access_begin(sr, sizeof(*sr)))
-		return 1;
-
-	unsafe_restore_general_regs(&current->thread.ckpt_regs, sr, failed);
-	unsafe_get_user(current->thread.tm_tfhar, &sr->mc_gregs[PT_NIP], failed);
-	unsafe_get_user(msr, &sr->mc_gregs[PT_MSR], failed);
+	scoped_user_read_access(sr, failed) {
+		unsafe_restore_general_regs(&current->thread.ckpt_regs, sr, failed);
+		unsafe_get_user(current->thread.tm_tfhar, &sr->mc_gregs[PT_NIP], failed);
+		unsafe_get_user(msr, &sr->mc_gregs[PT_MSR], failed);
 
-	/* Restore the previous little-endian mode */
-	regs_set_return_msr(regs, (regs->msr & ~MSR_LE) | (msr & MSR_LE));
+		/* Restore the previous little-endian mode */
+		regs_set_return_msr(regs, (regs->msr & ~MSR_LE) | (msr & MSR_LE));
 
-	regs_set_return_msr(regs, regs->msr & ~MSR_VEC);
-	if (msr & MSR_VEC) {
-		/* restore altivec registers from the stack */
-		unsafe_copy_from_user(&current->thread.ckvr_state, &sr->mc_vregs,
-				      sizeof(sr->mc_vregs), failed);
-		current->thread.used_vr = true;
-	} else if (current->thread.used_vr) {
-		memset(&current->thread.vr_state, 0,
-		       ELF_NVRREG * sizeof(vector128));
-		memset(&current->thread.ckvr_state, 0,
-		       ELF_NVRREG * sizeof(vector128));
-	}
+		regs_set_return_msr(regs, regs->msr & ~MSR_VEC);
+		if (msr & MSR_VEC) {
+			/* restore altivec registers from the stack */
+			unsafe_copy_from_user(&current->thread.ckvr_state, &sr->mc_vregs,
+					      sizeof(sr->mc_vregs), failed);
+			current->thread.used_vr = true;
+		} else if (current->thread.used_vr) {
+			memset(&current->thread.vr_state, 0, ELF_NVRREG * sizeof(vector128));
+			memset(&current->thread.ckvr_state, 0, ELF_NVRREG * sizeof(vector128));
+		}
 
-	/* Always get VRSAVE back */
-	unsafe_get_user(current->thread.ckvrsave,
-			(u32 __user *)&sr->mc_vregs[32], failed);
-	if (cpu_has_feature(CPU_FTR_ALTIVEC))
-		mtspr(SPRN_VRSAVE, current->thread.ckvrsave);
+		/* Always get VRSAVE back */
+		unsafe_get_user(current->thread.ckvrsave,
+				(u32 __user *)&sr->mc_vregs[32], failed);
+		if (cpu_has_feature(CPU_FTR_ALTIVEC))
+			mtspr(SPRN_VRSAVE, current->thread.ckvrsave);
 
-	regs_set_return_msr(regs, regs->msr & ~(MSR_FP | MSR_FE0 | MSR_FE1));
+		regs_set_return_msr(regs, regs->msr & ~(MSR_FP | MSR_FE0 | MSR_FE1));
 
-	unsafe_copy_fpr_from_user(current, &sr->mc_fregs, failed);
+		unsafe_copy_fpr_from_user(current, &sr->mc_fregs, failed);
 
-	regs_set_return_msr(regs, regs->msr & ~MSR_VSX);
-	if (msr & MSR_VSX) {
-		/*
-		 * Restore altivec registers from the stack to a local
-		 * buffer, then write this out to the thread_struct
-		 */
-		unsafe_copy_ckvsx_from_user(current, &sr->mc_vsregs, failed);
-		current->thread.used_vsr = true;
-	} else if (current->thread.used_vsr)
-		for (i = 0; i < 32 ; i++) {
-			current->thread.fp_state.fpr[i][TS_VSRLOWOFFSET] = 0;
-			current->thread.ckfp_state.fpr[i][TS_VSRLOWOFFSET] = 0;
+		regs_set_return_msr(regs, regs->msr & ~MSR_VSX);
+		if (msr & MSR_VSX) {
+			/*
+			 * Restore altivec registers from the stack to a local
+			 * buffer, then write this out to the thread_struct
+			 */
+			unsafe_copy_ckvsx_from_user(current, &sr->mc_vsregs, failed);
+			current->thread.used_vsr = true;
+		} else if (current->thread.used_vsr) {
+			int i;
+
+			for (i = 0; i < 32 ; i++) {
+				current->thread.fp_state.fpr[i][TS_VSRLOWOFFSET] = 0;
+				current->thread.ckfp_state.fpr[i][TS_VSRLOWOFFSET] = 0;
+			}
 		}
+	}
 
-	user_read_access_end();
-
-	if (!user_read_access_begin(tm_sr, sizeof(*tm_sr)))
-		return 1;
+	scoped_user_read_access(tm_sr, failed) {
+		unsafe_restore_general_regs(regs, tm_sr, failed);
 
-	unsafe_restore_general_regs(regs, tm_sr, failed);
+		/* restore altivec registers from the stack */
+		if (msr & MSR_VEC)
+			unsafe_copy_from_user(&current->thread.vr_state, &tm_sr->mc_vregs,
+					      sizeof(sr->mc_vregs), failed);
 
-	/* restore altivec registers from the stack */
-	if (msr & MSR_VEC)
-		unsafe_copy_from_user(&current->thread.vr_state, &tm_sr->mc_vregs,
-				      sizeof(sr->mc_vregs), failed);
+		/* Always get VRSAVE back */
+		unsafe_get_user(current->thread.vrsave,
+				(u32 __user *)&tm_sr->mc_vregs[32], failed);
 
-	/* Always get VRSAVE back */
-	unsafe_get_user(current->thread.vrsave,
-			(u32 __user *)&tm_sr->mc_vregs[32], failed);
+		unsafe_copy_ckfpr_from_user(current, &tm_sr->mc_fregs, failed);
 
-	unsafe_copy_ckfpr_from_user(current, &tm_sr->mc_fregs, failed);
+		if (msr & MSR_VSX) {
+			/*
+			 * Restore altivec registers from the stack to a local
+			 * buffer, then write this out to the thread_struct
+			 */
+			unsafe_copy_vsx_from_user(current, &tm_sr->mc_vsregs, failed);
+			current->thread.used_vsr = true;
+		}
 
-	if (msr & MSR_VSX) {
-		/*
-		 * Restore altivec registers from the stack to a local
-		 * buffer, then write this out to the thread_struct
-		 */
-		unsafe_copy_vsx_from_user(current, &tm_sr->mc_vsregs, failed);
-		current->thread.used_vsr = true;
+		/* Get the top half of the MSR from the user context */
+		unsafe_get_user(msr_hi, &tm_sr->mc_gregs[PT_MSR], failed);
+		msr_hi <<= 32;
 	}
 
-	/* Get the top half of the MSR from the user context */
-	unsafe_get_user(msr_hi, &tm_sr->mc_gregs[PT_MSR], failed);
-	msr_hi <<= 32;
-
-	user_read_access_end();
-
 	/* If TM bits are set to the reserved value, it's an invalid context */
 	if (MSR_TM_RESV(msr_hi))
 		return 1;
@@ -712,7 +706,6 @@ static long restore_tm_user_regs(struct pt_regs *regs,
 	return 0;
 
 failed:
-	user_read_access_end();
 	return 1;
 }
 #else
@@ -737,8 +730,6 @@ int handle_rt_signal32(struct ksignal *ksig, sigset_t *oldset,
 		       struct task_struct *tsk)
 {
 	struct rt_sigframe __user *frame;
-	struct mcontext __user *mctx;
-	struct mcontext __user *tm_mctx = NULL;
 	unsigned long newsp = 0;
 	unsigned long tramp;
 	struct pt_regs *regs = tsk->thread.regs;
@@ -747,52 +738,53 @@ int handle_rt_signal32(struct ksignal *ksig, sigset_t *oldset,
 
 	/* Set up Signal Frame */
 	frame = get_sigframe(ksig, tsk, sizeof(*frame), 1);
-	mctx = &frame->uc.uc_mcontext;
-#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
-	tm_mctx = &frame->uc_transact.uc_mcontext;
-#endif
 	if (MSR_TM_ACTIVE(msr))
 		prepare_save_tm_user_regs();
 	else
 		prepare_save_user_regs(1);
 
-	if (!user_access_begin(frame, sizeof(*frame)))
-		goto badframe;
+	scoped_user_rw_access(frame, badframe) {
+		struct mcontext __user *mctx;
+		struct mcontext __user *tm_mctx = NULL;
 
-	/* Put the siginfo & fill in most of the ucontext */
-	unsafe_put_user(0, &frame->uc.uc_flags, failed);
+		mctx = &frame->uc.uc_mcontext;
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+		tm_mctx = &frame->uc_transact.uc_mcontext;
+#endif
+		/* Put the siginfo & fill in most of the ucontext */
+		unsafe_put_user(0, &frame->uc.uc_flags, badframe);
 #ifdef CONFIG_PPC64
-	unsafe_compat_save_altstack(&frame->uc.uc_stack, regs->gpr[1], failed);
+		unsafe_compat_save_altstack(&frame->uc.uc_stack, regs->gpr[1], badframe);
 #else
-	unsafe_save_altstack(&frame->uc.uc_stack, regs->gpr[1], failed);
+		unsafe_save_altstack(&frame->uc.uc_stack, regs->gpr[1], badframe);
 #endif
-	unsafe_put_user(to_user_ptr(&frame->uc.uc_mcontext), &frame->uc.uc_regs, failed);
+		unsafe_put_user(to_user_ptr(&frame->uc.uc_mcontext), &frame->uc.uc_regs, badframe);
 
-	if (MSR_TM_ACTIVE(msr)) {
+		if (MSR_TM_ACTIVE(msr)) {
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
-		unsafe_put_user((unsigned long)&frame->uc_transact,
-				&frame->uc.uc_link, failed);
-		unsafe_put_user((unsigned long)tm_mctx,
-				&frame->uc_transact.uc_regs, failed);
+			unsafe_put_user((unsigned long)&frame->uc_transact,
+					&frame->uc.uc_link, badframe);
+			unsafe_put_user((unsigned long)tm_mctx,
+					&frame->uc_transact.uc_regs, badframe);
 #endif
-		unsafe_save_tm_user_regs(regs, mctx, tm_mctx, msr, failed);
-	} else {
-		unsafe_put_user(0, &frame->uc.uc_link, failed);
-		unsafe_save_user_regs(regs, mctx, tm_mctx, 1, failed);
-	}
+			unsafe_save_tm_user_regs(regs, mctx, tm_mctx, msr, badframe);
+		} else {
+			unsafe_put_user(0, &frame->uc.uc_link, badframe);
+			unsafe_save_user_regs(regs, mctx, tm_mctx, 1, badframe);
+		}
 
-	/* Save user registers on the stack */
-	if (tsk->mm->context.vdso) {
-		tramp = VDSO32_SYMBOL(tsk->mm->context.vdso, sigtramp_rt32);
-	} else {
-		tramp = (unsigned long)mctx->mc_pad;
-		unsafe_put_user(PPC_RAW_LI(_R0, __NR_rt_sigreturn), &mctx->mc_pad[0], failed);
-		unsafe_put_user(PPC_RAW_SC(), &mctx->mc_pad[1], failed);
-		asm("dcbst %y0; sync; icbi %y0; sync" :: "Z" (mctx->mc_pad[0]));
+		/* Save user registers on the stack */
+		if (tsk->mm->context.vdso) {
+			tramp = VDSO32_SYMBOL(tsk->mm->context.vdso, sigtramp_rt32);
+		} else {
+			tramp = (unsigned long)mctx->mc_pad;
+			unsafe_put_user(PPC_RAW_LI(_R0, __NR_rt_sigreturn), &mctx->mc_pad[0],
+					badframe);
+			unsafe_put_user(PPC_RAW_SC(), &mctx->mc_pad[1], badframe);
+			asm("dcbst %y0; sync; icbi %y0; sync" :: "Z" (mctx->mc_pad[0]));
+		}
+		unsafe_put_sigset_t(&frame->uc.uc_sigmask, oldset, badframe);
 	}
-	unsafe_put_sigset_t(&frame->uc.uc_sigmask, oldset, failed);
-
-	user_access_end();
 
 	if (copy_siginfo_to_user(&frame->info, &ksig->info))
 		goto badframe;
@@ -820,9 +812,6 @@ int handle_rt_signal32(struct ksignal *ksig, sigset_t *oldset,
 
 	return 0;
 
-failed:
-	user_access_end();
-
 badframe:
 	signal_fault(tsk, regs, "handle_rt_signal32", frame);
 
@@ -837,8 +826,6 @@ int handle_signal32(struct ksignal *ksig, sigset_t *oldset,
 {
 	struct sigcontext __user *sc;
 	struct sigframe __user *frame;
-	struct mcontext __user *mctx;
-	struct mcontext __user *tm_mctx = NULL;
 	unsigned long newsp = 0;
 	unsigned long tramp;
 	struct pt_regs *regs = tsk->thread.regs;
@@ -847,46 +834,49 @@ int handle_signal32(struct ksignal *ksig, sigset_t *oldset,
 
 	/* Set up Signal Frame */
 	frame = get_sigframe(ksig, tsk, sizeof(*frame), 1);
-	mctx = &frame->mctx;
-#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
-	tm_mctx = &frame->mctx_transact;
-#endif
 	if (MSR_TM_ACTIVE(msr))
 		prepare_save_tm_user_regs();
 	else
 		prepare_save_user_regs(1);
 
-	if (!user_access_begin(frame, sizeof(*frame)))
-		goto badframe;
-	sc = (struct sigcontext __user *) &frame->sctx;
+	scoped_user_rw_access(frame, badframe) {
+		struct mcontext __user *mctx;
+		struct mcontext __user *tm_mctx = NULL;
+
+		mctx = &frame->mctx;
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+		tm_mctx = &frame->mctx_transact;
+#endif
+		sc = (struct sigcontext __user *)&frame->sctx;
 
 #if _NSIG != 64
 #error "Please adjust handle_signal()"
 #endif
-	unsafe_put_user(to_user_ptr(ksig->ka.sa.sa_handler), &sc->handler, failed);
-	unsafe_put_user(oldset->sig[0], &sc->oldmask, failed);
+		unsafe_put_user(to_user_ptr(ksig->ka.sa.sa_handler), &sc->handler, badframe);
+		unsafe_put_user(oldset->sig[0], &sc->oldmask, badframe);
 #ifdef CONFIG_PPC64
-	unsafe_put_user((oldset->sig[0] >> 32), &sc->_unused[3], failed);
+		unsafe_put_user((oldset->sig[0] >> 32), &sc->_unused[3], badframe);
 #else
-	unsafe_put_user(oldset->sig[1], &sc->_unused[3], failed);
+		unsafe_put_user(oldset->sig[1], &sc->_unused[3], badframe);
 #endif
-	unsafe_put_user(to_user_ptr(mctx), &sc->regs, failed);
-	unsafe_put_user(ksig->sig, &sc->signal, failed);
+		unsafe_put_user(to_user_ptr(mctx), &sc->regs, badframe);
+		unsafe_put_user(ksig->sig, &sc->signal, badframe);
 
-	if (MSR_TM_ACTIVE(msr))
-		unsafe_save_tm_user_regs(regs, mctx, tm_mctx, msr, failed);
-	else
-		unsafe_save_user_regs(regs, mctx, tm_mctx, 1, failed);
-
-	if (tsk->mm->context.vdso) {
-		tramp = VDSO32_SYMBOL(tsk->mm->context.vdso, sigtramp32);
-	} else {
-		tramp = (unsigned long)mctx->mc_pad;
-		unsafe_put_user(PPC_RAW_LI(_R0, __NR_sigreturn), &mctx->mc_pad[0], failed);
-		unsafe_put_user(PPC_RAW_SC(), &mctx->mc_pad[1], failed);
-		asm("dcbst %y0; sync; icbi %y0; sync" :: "Z" (mctx->mc_pad[0]));
+		if (MSR_TM_ACTIVE(msr))
+			unsafe_save_tm_user_regs(regs, mctx, tm_mctx, msr, badframe);
+		else
+			unsafe_save_user_regs(regs, mctx, tm_mctx, 1, badframe);
+
+		if (tsk->mm->context.vdso) {
+			tramp = VDSO32_SYMBOL(tsk->mm->context.vdso, sigtramp32);
+		} else {
+			tramp = (unsigned long)mctx->mc_pad;
+			unsafe_put_user(PPC_RAW_LI(_R0, __NR_sigreturn), &mctx->mc_pad[0],
+					badframe);
+			unsafe_put_user(PPC_RAW_SC(), &mctx->mc_pad[1], badframe);
+			asm("dcbst %y0; sync; icbi %y0; sync" :: "Z" (mctx->mc_pad[0]));
+		}
 	}
-	user_access_end();
 
 	regs->link = tramp;
 
@@ -908,9 +898,6 @@ int handle_signal32(struct ksignal *ksig, sigset_t *oldset,
 
 	return 0;
 
-failed:
-	user_access_end();
-
 badframe:
 	signal_fault(tsk, regs, "handle_signal32", frame);
 
@@ -922,21 +909,19 @@ static int do_setcontext(struct ucontext __user *ucp, struct pt_regs *regs, int
 	sigset_t set;
 	struct mcontext __user *mcp;
 
-	if (!user_read_access_begin(ucp, sizeof(*ucp)))
-		return -EFAULT;
-
-	unsafe_get_sigset_t(&set, &ucp->uc_sigmask, failed);
+	scoped_user_read_access(ucp, failed) {
+		unsafe_get_sigset_t(&set, &ucp->uc_sigmask, failed);
 #ifdef CONFIG_PPC64
-	{
-		u32 cmcp;
+		{
+			u32 cmcp;
 
-		unsafe_get_user(cmcp, &ucp->uc_regs, failed);
-		mcp = (struct mcontext __user *)(u64)cmcp;
-	}
+			unsafe_get_user(cmcp, &ucp->uc_regs, failed);
+			mcp = (struct mcontext __user *)(u64)cmcp;
+		}
 #else
-	unsafe_get_user(mcp, &ucp->uc_regs, failed);
+		unsafe_get_user(mcp, &ucp->uc_regs, failed);
 #endif
-	user_read_access_end();
+	}
 
 	set_current_blocked(&set);
 	if (restore_user_regs(regs, mcp, sig))
@@ -945,7 +930,6 @@ static int do_setcontext(struct ucontext __user *ucp, struct pt_regs *regs, int
 	return 0;
 
 failed:
-	user_read_access_end();
 	return -EFAULT;
 }
 
@@ -960,13 +944,10 @@ static int do_setcontext_tm(struct ucontext __user *ucp,
 	u32 cmcp;
 	u32 tm_cmcp;
 
-	if (!user_read_access_begin(ucp, sizeof(*ucp)))
-		return -EFAULT;
-
-	unsafe_get_sigset_t(&set, &ucp->uc_sigmask, failed);
-	unsafe_get_user(cmcp, &ucp->uc_regs, failed);
-
-	user_read_access_end();
+	scoped_user_read_access(ucp, failed) {
+		unsafe_get_sigset_t(&set, &ucp->uc_sigmask, failed);
+		unsafe_get_user(cmcp, &ucp->uc_regs, failed);
+	}
 
 	if (__get_user(tm_cmcp, &tm_ucp->uc_regs))
 		return -EFAULT;
@@ -981,7 +962,6 @@ static int do_setcontext_tm(struct ucontext __user *ucp,
 	return 0;
 
 failed:
-	user_read_access_end();
 	return -EFAULT;
 }
 #endif
@@ -1051,12 +1031,11 @@ SYSCALL_DEFINE3(swapcontext, struct ucontext __user *, old_ctx,
 		mctx = (struct mcontext __user *)
 			((unsigned long) &old_ctx->uc_mcontext & ~0xfUL);
 		prepare_save_user_regs(ctx_has_vsx_region);
-		if (!user_write_access_begin(old_ctx, ctx_size))
-			return -EFAULT;
-		unsafe_save_user_regs(regs, mctx, NULL, ctx_has_vsx_region, failed);
-		unsafe_put_sigset_t(&old_ctx->uc_sigmask, &current->blocked, failed);
-		unsafe_put_user(to_user_ptr(mctx), &old_ctx->uc_regs, failed);
-		user_write_access_end();
+		scoped_user_write_access_size(old_ctx, ctx_size, failed) {
+			unsafe_save_user_regs(regs, mctx, NULL, ctx_has_vsx_region, failed);
+			unsafe_put_sigset_t(&old_ctx->uc_sigmask, &current->blocked, failed);
+			unsafe_put_user(to_user_ptr(mctx), &old_ctx->uc_regs, failed);
+		}
 	}
 	if (new_ctx == NULL)
 		return 0;
@@ -1084,7 +1063,6 @@ SYSCALL_DEFINE3(swapcontext, struct ucontext __user *, old_ctx,
 	return 0;
 
 failed:
-	user_write_access_end();
 	return -EFAULT;
 }
 
-- 
2.54.0


