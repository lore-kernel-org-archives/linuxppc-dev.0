Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zH8l64mkWzF0TZ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jan 2018 13:21:38 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/kernel: Print actual address of regs when oopsing
Date: Thu, 11 Jan 2018 13:21:35 +1100
Message-Id: <20180111022135.19532-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When we oops or otherwise call show_regs() we print the address of the
regs structure. Being able to see the address is fairly useful,
firstly to verify that the regs pointer is not completely bogus, and
secondly it allows you to dump the regs and surrounding memory with a
debugger if you have one.

In the normal case the regs will be located somewhere on the stack, so
printing their location discloses no further information than printing
the stack pointer does already.

So switch to %px and print the actual address, not the hashed value.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/process.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 5acb5a176dbe..72be0c32e902 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1403,7 +1403,7 @@ void show_regs(struct pt_regs * regs)
 
 	printk("NIP:  "REG" LR: "REG" CTR: "REG"\n",
 	       regs->nip, regs->link, regs->ctr);
-	printk("REGS: %p TRAP: %04lx   %s  (%s)\n",
+	printk("REGS: %px TRAP: %04lx   %s  (%s)\n",
 	       regs, regs->trap, print_tainted(), init_utsname()->release);
 	printk("MSR:  "REG" ", regs->msr);
 	print_msr_bits(regs->msr);
-- 
2.14.3
