Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tCpCl5MYxzDvPF
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Nov 2016 23:14:59 +1100 (AEDT)
Received: by mail-pf0-x244.google.com with SMTP id i88so19280186pfk.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Nov 2016 04:14:59 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/2] powerpc: fix graceful debugger recovery
Date: Tue,  8 Nov 2016 23:14:44 +1100
Message-Id: <20161108121445.15303-2-npiggin@gmail.com>
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

When exiting xmon with 'x' (exit and recover), oops_begin bails
out immediately, but die then calls __die() and oops_end(), which
cause a lot of bad things to happen.

If the debugger was attached then went to graceful recovery, exit
from die() immediately.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/traps.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 7480902..26c3ba4 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -122,9 +122,6 @@ static unsigned long oops_begin(struct pt_regs *regs)
 	int cpu;
 	unsigned long flags;
 
-	if (debugger(regs))
-		return 1;
-
 	oops_enter();
 
 	/* racy, but better than risking deadlock. */
@@ -227,8 +224,12 @@ NOKPROBE_SYMBOL(__die);
 
 void die(const char *str, struct pt_regs *regs, long err)
 {
-	unsigned long flags = oops_begin(regs);
+	unsigned long flags;
+
+	if (debugger(regs))
+		return;
 
+	flags = oops_begin(regs);
 	if (__die(str, regs, err))
 		err = 0;
 	oops_end(flags, regs, err);
-- 
2.10.2
