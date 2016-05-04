Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r0Fpp5CnVzDq60
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 May 2016 21:16:18 +1000 (AEST)
From: Michael Neuling <mikey@neuling.org>
To: Jack Miller <jack@codezen.org>,
	linuxppc-dev@lists.ozlabs.org
Cc: anton@samba.org,
	mpe@ellerman.id.au,
	mikey@neuling.org
Subject: [PATCH v4] powerpc: Complete FSCR context switch
Date: Wed,  4 May 2016 21:16:07 +1000
Message-Id: <1462360567-4360-1-git-send-email-mikey@neuling.org>
In-Reply-To: <1461013724-12784-2-git-send-email-jack@codezen.org>
References: <1461013724-12784-2-git-send-email-jack@codezen.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Jack Miller <jack@codezen.org>

Previously we just saved the FSCR, but only restored it in some
settings, and never copied it thread to thread. This patch always
restores the FSCR and formalizes new threads inheriting its setting so
that later we can manipulate FSCR bits in start_thread.

Signed-off-by: Jack Miller <jack@codezen.org>
Signed-off-by: Michael Neuling <mikey@neuling.org>
---
This version fixes breaking the dscr_inherit_test selftest.

I moved the CONFIG_ALTIVEC code around in restores_sprs() so fscr could
be declared without more ifdefs.
---
 arch/powerpc/kernel/process.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index ea8a28f..1f7f203 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1015,15 +1015,11 @@ static inline void save_sprs(struct thread_struct *t)
 static inline void restore_sprs(struct thread_struct *old_thread,
 				struct thread_struct *new_thread)
 {
-#ifdef CONFIG_ALTIVEC
-	if (cpu_has_feature(CPU_FTR_ALTIVEC) &&
-	    old_thread->vrsave != new_thread->vrsave)
-		mtspr(SPRN_VRSAVE, new_thread->vrsave);
-#endif
 #ifdef CONFIG_PPC_BOOK3S_64
+	u64 fscr = new_thread->fscr;
 	if (cpu_has_feature(CPU_FTR_DSCR)) {
 		u64 dscr = get_paca()->dscr_default;
-		u64 fscr = old_thread->fscr & ~FSCR_DSCR;
+		fscr &= ~FSCR_DSCR;
 
 		if (new_thread->dscr_inherit) {
 			dscr = new_thread->dscr;
@@ -1032,9 +1028,6 @@ static inline void restore_sprs(struct thread_struct *old_thread,
 
 		if (old_thread->dscr != dscr)
 			mtspr(SPRN_DSCR, dscr);
-
-		if (old_thread->fscr != fscr)
-			mtspr(SPRN_FSCR, fscr);
 	}
 
 	if (cpu_has_feature(CPU_FTR_ARCH_207S)) {
@@ -1045,10 +1038,18 @@ static inline void restore_sprs(struct thread_struct *old_thread,
 		if (old_thread->ebbrr != new_thread->ebbrr)
 			mtspr(SPRN_EBBRR, new_thread->ebbrr);
 
+		if (old_thread->fscr != fscr)
+			mtspr(SPRN_FSCR, fscr);
+
 		if (old_thread->tar != new_thread->tar)
 			mtspr(SPRN_TAR, new_thread->tar);
 	}
 #endif
+#ifdef CONFIG_ALTIVEC
+	if (cpu_has_feature(CPU_FTR_ALTIVEC) &&
+	    old_thread->vrsave != new_thread->vrsave)
+		mtspr(SPRN_VRSAVE, new_thread->vrsave);
+#endif
 }
 
 struct task_struct *__switch_to(struct task_struct *prev,
@@ -1486,6 +1487,9 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
 	}
 	if (cpu_has_feature(CPU_FTR_HAS_PPR))
 		p->thread.ppr = INIT_PPR;
+
+	if (cpu_has_feature(CPU_FTR_ARCH_207S))
+		p->thread.fscr = mfspr(SPRN_FSCR);
 #endif
 	kregs->nip = ppc_function_entry(f);
 	return 0;
-- 
2.7.4
