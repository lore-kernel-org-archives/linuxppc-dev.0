Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xcpr60Gl6zDrJk
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Aug 2017 23:56:38 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 5/5] powerpc/oops: Line up NIP & MSR with other rows
Date: Wed, 23 Aug 2017 23:56:24 +1000
Message-Id: <1503496584-21970-5-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1503496584-21970-1-git-send-email-mpe@ellerman.id.au>
References: <1503496584-21970-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is purely cosmetic, but does look nicer IMHO:

Before:

  task: c000000001453400 task.stack: c000000001c6c000
  NIP: c000000000a0fbfc LR: c000000000a0fbf4 CTR: c000000000ba6220
  REGS: c0000001fffef820 TRAP: 0300   Not tainted  (4.13.0-rc6-gcc-6.3.1-00234-g423af27f7d81)
  MSR: 8000000000009033 <SF,EE,ME,IR,DR,RI,LE>  CR: 88088242  XER: 00000000
  CFAR: c0000000000b3488 DAR: 0000000000000000 DSISR: 42000000 SOFTE: 0

After:
  task: c000000001453400 task.stack: c000000001c6c000
  NIP:  c000000000a0fbfc LR: c000000000a0fbf4 CTR: c000000000ba6220
  REGS: c0000001fffef820 TRAP: 0300   Not tainted  (4.13.0-rc6-gcc-6.3.1-00234-g423af27f7d81-dirty)
  MSR:  8000000000009033 <SF,EE,ME,IR,DR,RI,LE>  CR: 88088242  XER: 00000000
  CFAR: c0000000000b34a4 DAR: 0000000000000000 DSISR: 42000000 SOFTE: 0

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/process.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 91f9819cb51b..234b1ee7864e 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1380,11 +1380,11 @@ void show_regs(struct pt_regs * regs)
 
 	show_regs_print_info(KERN_DEFAULT);
 
-	printk("NIP: "REG" LR: "REG" CTR: "REG"\n",
+	printk("NIP:  "REG" LR: "REG" CTR: "REG"\n",
 	       regs->nip, regs->link, regs->ctr);
 	printk("REGS: %p TRAP: %04lx   %s  (%s)\n",
 	       regs, regs->trap, print_tainted(), init_utsname()->release);
-	printk("MSR: "REG" ", regs->msr);
+	printk("MSR:  "REG" ", regs->msr);
 	print_msr_bits(regs->msr);
 	pr_cont("  CR: %08lx  XER: %08lx\n", regs->ccr, regs->xer);
 	trap = TRAP(regs);
-- 
2.7.4
