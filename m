Return-Path: <cyrilbur@gmail.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qVJXH0bnXzDqD7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Mar 2016 16:48:47 +1100 (AEDT)
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3qVJXG4lypz9snk
 for <linuxppc-dev@ozlabs.org>; Wed, 23 Mar 2016 16:48:46 +1100 (AEDT)
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <cyrilbur@gmail.com>;
 Wed, 23 Mar 2016 15:48:46 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 415533578053
 for <linuxppc-dev@ozlabs.org>; Wed, 23 Mar 2016 16:48:40 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2N5mWGc3998078
 for <linuxppc-dev@ozlabs.org>; Wed, 23 Mar 2016 16:48:40 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2N5m7Ei006556
 for <linuxppc-dev@ozlabs.org>; Wed, 23 Mar 2016 16:48:07 +1100
From: Cyril Bur <cyrilbur@gmail.com>
To: linuxppc-dev@ozlabs.org
Cc: mikey@neuling.org
Subject: [PATCH 5/5] powerpc: Preserve the SPR values across fork() syscalls
Date: Wed, 23 Mar 2016 16:47:05 +1100
Message-Id: <1458712025-3525-5-git-send-email-cyrilbur@gmail.com>
In-Reply-To: <1458712025-3525-1-git-send-email-cyrilbur@gmail.com>
References: <1458712025-3525-1-git-send-email-cyrilbur@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently copy_thread() doesn't flush SPRs to the parent thread struct.
Currently this only affects the TAR register as perf takes care of some of the
others and the remaining ones are all Event Based Branch (EBB) registers which
are cleared across fork().

Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
---
 arch/powerpc/kernel/process.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 7625976..892c76d 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1037,6 +1037,8 @@ void flush_all_to_thread(struct task_struct *tsk)
 		BUG_ON(tsk != current);
 		save_all(tsk);
 
+		save_sprs(&tsk->thread);
+
 #ifdef CONFIG_SPE
 		if (tsk->thread.regs->msr & MSR_SPE)
 			tsk->thread.spefscr = mfspr(SPRN_SPEFSCR);
-- 
2.7.4
