Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [git pull] Please pull powerpc.git merge branch
In-reply-to: <1290059208.32570.3.camel@pasglop>
References: <1290059208.32570.3.camel@pasglop>
Date: Fri, 19 Nov 2010 08:42:35 +1100
Message-ID: <30983.1290116555@neuling.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> Michael Neuling (1):
>       powerpc: Fix call to subpage_protection()

Well that's annoying... 

Looks like the bottom of my commit got chopped as the oops message has a
"---" in it.  We lost the cc: stable@kernel.org :-(

Comparing the original post to the final commit:
  http://lists.ozlabs.org/pipermail/linuxppc-dev/2010-November/087141.html
To the final:
  http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=1c2c25c78740b2796c7c06640784cb6732fa4907

It'd be nice if we had something like this in:



powerpc: fix debug prints to avoid ---

Many commit tools assume anything below a line starting with --- is a
comment. Since the following two prints are often used as debug
outputs and hence in checkin comments avoid using --- in these

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
Let the bike shedding begin!

 arch/powerpc/kernel/process.c |    2 +-
 arch/powerpc/xmon/xmon.c      |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6-ozlabs/arch/powerpc/kernel/process.c
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/kernel/process.c
+++ linux-2.6-ozlabs/arch/powerpc/kernel/process.c
@@ -1167,7 +1167,7 @@
 			struct pt_regs *regs = (struct pt_regs *)
 				(sp + STACK_FRAME_OVERHEAD);
 			lr = regs->link;
-			printk("--- Exception: %lx at %pS\n    LR = %pS\n",
+			printk("=== Exception: %lx at %pS\n    LR = %pS\n",
 			       regs->trap, (void *)regs->nip, (void *)lr);
 			firstframe = 1;
 		}
Index: linux-2.6-ozlabs/arch/powerpc/xmon/xmon.c
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/xmon/xmon.c
+++ linux-2.6-ozlabs/arch/powerpc/xmon/xmon.c
@@ -1363,7 +1363,7 @@
 				       sp + REGS_OFFSET);
 				break;
 			}
-                        printf("--- Exception: %lx %s at ", regs.trap,
+                        printf("=== Exception: %lx %s at ", regs.trap,
 			       getvecname(TRAP(&regs)));
 			pc = regs.nip;
 			lr = regs.link;
