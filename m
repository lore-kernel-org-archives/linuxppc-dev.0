Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B08CA1A0163
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Oct 2014 20:27:18 +1100 (EST)
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org,
	paulus@samba.org,
	mpe@ellerman.id.au
Subject: [PATCH] powerpc: Use probe_kernel_address in show_instructions
Date: Mon, 13 Oct 2014 20:27:15 +1100
Message-Id: <1413192435-2797-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We really don't want to take a pagefault in show_instructions,
so use probe_kernel_address instead of __get_user.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/kernel/process.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 923cd2d..e5698f1 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -37,9 +37,9 @@
 #include <linux/personality.h>
 #include <linux/random.h>
 #include <linux/hw_breakpoint.h>
+#include <linux/uaccess.h>
 
 #include <asm/pgtable.h>
-#include <asm/uaccess.h>
 #include <asm/io.h>
 #include <asm/processor.h>
 #include <asm/mmu.h>
@@ -921,12 +921,8 @@ static void show_instructions(struct pt_regs *regs)
 			pc = (unsigned long)phys_to_virt(pc);
 #endif
 
-		/* We use __get_user here *only* to avoid an OOPS on a
-		 * bad address because the pc *should* only be a
-		 * kernel address.
-		 */
 		if (!__kernel_text_address(pc) ||
-		     __get_user(instr, (unsigned int __user *)pc)) {
+		     probe_kernel_address((unsigned int __user *)pc, instr)) {
 			printk(KERN_CONT "XXXXXXXX ");
 		} else {
 			if (regs->nip == pc)
-- 
1.9.1
