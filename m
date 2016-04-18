Return-Path: <millerjo@us.ibm.com>
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qpgkQ32tHzDq5f
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Apr 2016 07:09:18 +1000 (AEST)
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <millerjo@us.ibm.com>;
 Mon, 18 Apr 2016 17:09:16 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 69879C9003E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Apr 2016 17:09:09 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3IL9E0842139872
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Apr 2016 21:09:14 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3IL9EsE019040
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Apr 2016 17:09:14 -0400
From: Jack Miller <jack@codezen.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au, mikey@neuling.org, anton@samba.org
Subject: [PATCH 1/3] powerpc: Complete FSCR context switch
Date: Mon, 18 Apr 2016 16:08:42 -0500
Message-Id: <1461013724-12784-2-git-send-email-jack@codezen.org>
In-Reply-To: <1461013724-12784-1-git-send-email-jack@codezen.org>
References: <201604190414.NkLxbSQl%fengguang.wu@intel.com>
 <1461013724-12784-1-git-send-email-jack@codezen.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Previously we just saved the FSCR, but only restored it in some
settings, and never copied it thread to thread. This patch always
restores the FSCR and formalizes new threads inheriting its setting so
that later we can manipulate FSCR bits in start_thread.

Signed-off-by: Jack Miller <jack@codezen.org>
---
 arch/powerpc/kernel/process.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index b8500b4..00bf6f5 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1019,18 +1019,12 @@ static inline void restore_sprs(struct thread_struct *old_thread,
 #ifdef CONFIG_PPC_BOOK3S_64
 	if (cpu_has_feature(CPU_FTR_DSCR)) {
 		u64 dscr = get_paca()->dscr_default;
-		u64 fscr = old_thread->fscr & ~FSCR_DSCR;
 
-		if (new_thread->dscr_inherit) {
+		if (new_thread->dscr_inherit)
 			dscr = new_thread->dscr;
-			fscr |= FSCR_DSCR;
-		}
 
 		if (old_thread->dscr != dscr)
 			mtspr(SPRN_DSCR, dscr);
-
-		if (old_thread->fscr != fscr)
-			mtspr(SPRN_FSCR, fscr);
 	}
 
 	if (cpu_has_feature(CPU_FTR_ARCH_207S)) {
@@ -1041,6 +1035,9 @@ static inline void restore_sprs(struct thread_struct *old_thread,
 		if (old_thread->ebbrr != new_thread->ebbrr)
 			mtspr(SPRN_EBBRR, new_thread->ebbrr);
 
+		if (old_thread->fscr != new_thread->fscr)
+			mtspr(SPRN_FSCR, new_thread->fscr);
+
 		if (old_thread->tar != new_thread->tar)
 			mtspr(SPRN_TAR, new_thread->tar);
 	}
@@ -1478,6 +1475,9 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
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
2.8.0
