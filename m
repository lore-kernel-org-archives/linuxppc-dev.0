Return-Path: <millerjo@us.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qpd4d3fbrzDq60
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Apr 2016 05:09:53 +1000 (AEST)
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <millerjo@us.ibm.com>;
 Mon, 18 Apr 2016 13:09:51 -0600
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 50B533E40067
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Apr 2016 13:09:49 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3IJ9ndZ37683394
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Apr 2016 12:09:49 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3IJ9mkH001625
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Apr 2016 13:09:48 -0600
From: Jack Miller <jack@codezen.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au, mikey@neuling.org, anton@samba.org
Subject: [PATCH 1/3] powerpc: Complete FSCR context switch
Date: Mon, 18 Apr 2016 14:08:00 -0500
Message-Id: <1461006482-20595-2-git-send-email-jack@codezen.org>
In-Reply-To: <1461006482-20595-1-git-send-email-jack@codezen.org>
References: <1461006482-20595-1-git-send-email-jack@codezen.org>
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
