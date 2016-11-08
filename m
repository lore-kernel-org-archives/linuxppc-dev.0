Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tCpCp3wp6zDvRM
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Nov 2016 23:15:02 +1100 (AEDT)
Received: by mail-pf0-x244.google.com with SMTP id 144so10923796pfv.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Nov 2016 04:15:02 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/2] powerpc: fix second nested oops hang
Date: Tue,  8 Nov 2016 23:14:45 +1100
Message-Id: <20161108121445.15303-3-npiggin@gmail.com>
In-Reply-To: <20161108121445.15303-1-npiggin@gmail.com>
References: <20161108121445.15303-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When ending an oops, don't clear die_owner unless the nest count
went to zero. This prevents a second nested oops from hanging forever
on the die_lock.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/traps.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 26c3ba4..ba78e38 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -147,14 +147,15 @@ static void oops_end(unsigned long flags, struct pt_regs *regs,
 			       int signr)
 {
 	bust_spinlocks(0);
-	die_owner = -1;
 	add_taint(TAINT_DIE, LOCKDEP_NOW_UNRELIABLE);
 	die_nest_count--;
 	oops_exit();
 	printk("\n");
-	if (!die_nest_count)
+	if (!die_nest_count) {
 		/* Nest count reaches zero, release the lock. */
+		die_owner = -1;
 		arch_spin_unlock(&die_lock);
+	}
 	raw_local_irq_restore(flags);
 
 	crash_fadump(regs, "die oops");
-- 
2.10.2
