Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t85JK4Y9yzDt3N
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Nov 2016 22:21:05 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/5] powerpc/oops: Fix missing KERN_CONT in show_stack()
Date: Wed,  2 Nov 2016 22:20:46 +1100
Message-Id: <1478085650-23618-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Previously we got away with printing the stack trace in multiple pieces
and it usually looked right.  But since commit 4bcc595ccd80 ("printk:
reinstate KERN_CONT for printing continuation lines"), KERN_CONT is now
required when printing continuation lines.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/process.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index ce6dc61b15b2..621d9b23df72 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1900,14 +1900,14 @@ void show_stack(struct task_struct *tsk, unsigned long *stack)
 			printk("["REG"] ["REG"] %pS", sp, ip, (void *)ip);
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 			if ((ip == rth) && curr_frame >= 0) {
-				printk(" (%pS)",
+				pr_cont(" (%pS)",
 				       (void *)current->ret_stack[curr_frame].ret);
 				curr_frame--;
 			}
 #endif
 			if (firstframe)
-				printk(" (unreliable)");
-			printk("\n");
+				pr_cont(" (unreliable)");
+			pr_cont("\n");
 		}
 		firstframe = 0;
 
-- 
2.7.4
