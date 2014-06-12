Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id ADDD91A02C2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jun 2014 16:53:14 +1000 (EST)
Date: Thu, 12 Jun 2014 16:53:08 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Reduce scariness of interrupt frames in stack traces
Message-ID: <20140612065308.GB16578@drongo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Some people see things like "Exception: 501" in stack traces in dmesg
and assume that means that something has gone badly wrong, when in
fact "Exception: 501" just means a device interrupt was taken.
This changes "Exception" to "interrupt" to make it clearer that we
are just recording the fact of a change in control flow rather than
some error condition.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/kernel/process.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 31d0215..aa103dc 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1577,7 +1577,7 @@ void show_stack(struct task_struct *tsk, unsigned long *stack)
 			struct pt_regs *regs = (struct pt_regs *)
 				(sp + STACK_FRAME_OVERHEAD);
 			lr = regs->link;
-			printk("--- Exception: %lx at %pS\n    LR = %pS\n",
+			printk("--- interrupt: %lx at %pS\n    LR = %pS\n",
 			       regs->trap, (void *)regs->nip, (void *)lr);
 			firstframe = 1;
 		}
-- 
2.0.0.rc4
