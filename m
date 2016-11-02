Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t85JM4r0NzDt3N
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Nov 2016 22:21:07 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 3/5] powerpc/oops: Fix printing of GPRs since KERN_CONT changes
Date: Wed,  2 Nov 2016 22:20:48 +1100
Message-Id: <1478085650-23618-3-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1478085650-23618-1-git-send-email-mpe@ellerman.id.au>
References: <1478085650-23618-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Since the KERN_CONT changes our print out of the GPRs is messed up:

    GPR04:
    0000000000000001 c000000000155810
    0000000000000000 0000000000000001

    GPR08: 0000000000000007

Fix it for now by using pr_cont().

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/process.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 38f85d7a1e06..3898e381556f 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1363,13 +1363,15 @@ void show_regs(struct pt_regs * regs)
 #endif
 
 	for (i = 0;  i < 32;  i++) {
-		if ((i % REGS_PER_LINE) == 0)
-			printk("\nGPR%02d: ", i);
-		printk(REG " ", regs->gpr[i]);
+		if ((i % REGS_PER_LINE) == 0) {
+			pr_cont("\n");
+			printk("GPR%02d: ", i);
+		}
+		pr_cont(REG " ", regs->gpr[i]);
 		if (i == LAST_VOLATILE && !FULL_REGS(regs))
 			break;
 	}
-	printk("\n");
+	pr_cont("\n");
 #ifdef CONFIG_KALLSYMS
 	/*
 	 * Lookup NIP late so we have the best change of getting the
-- 
2.7.4
