Return-Path: <millerjo@us.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qkK9h0qfMzDqBC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Apr 2016 04:59:19 +1000 (AEST)
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <millerjo@us.ibm.com>;
 Mon, 11 Apr 2016 12:59:17 -0600
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 5F0F51FF0049
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Apr 2016 12:47:24 -0600 (MDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3BIxFkF41222220
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Apr 2016 18:59:15 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3BIxFv0024556
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Apr 2016 14:59:15 -0400
From: Jack Miller <jack@codezen.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: michaele@au1.ibm.com, michael.neuling@au1.ibm.com
Subject: [PATCH 1/3] powerpc: Complete FSCR context switch
Date: Mon, 11 Apr 2016 13:57:43 -0500
Message-Id: <1460401065-10540-2-git-send-email-jack@codezen.org>
In-Reply-To: <1460401065-10540-1-git-send-email-jack@codezen.org>
References: <1460401065-10540-1-git-send-email-jack@codezen.org>
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
 arch/powerpc/kernel/process.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index b8500b4..0c7e797 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1043,6 +1043,10 @@ static inline void restore_sprs(struct thread_struct *old_thread,
 
 		if (old_thread->tar != new_thread->tar)
 			mtspr(SPRN_TAR, new_thread->tar);
+
+		if (old_thread->fscr != new_thread->fscr)
+			mtspr(SPRN_FSCR, new_thread->fscr);
+
 	}
 #endif
 }
@@ -1478,6 +1482,9 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
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
