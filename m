Return-Path: <anton@ozlabs.org>
Date: Fri, 13 Oct 2006 12:17:16 +1000
From: Anton Blanchard <anton@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Better check in show_instructions
Message-ID: <20061013021716.GC16029@krispykreme>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Instead of just checking that an address is in the right range, use the 
provided __kernel_text_address() helper which covers both the kernel and
module text sections.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: build/arch/powerpc/kernel/process.c
===================================================================
--- build.orig/arch/powerpc/kernel/process.c	2006-07-01 20:27:57.000000000 +1000
+++ build/arch/powerpc/kernel/process.c	2006-09-22 20:01:22.000000000 +1000
@@ -341,13 +341,6 @@ struct task_struct *__switch_to(struct t
 
 static int instructions_to_print = 16;
 
-#ifdef CONFIG_PPC64
-#define BAD_PC(pc)	((REGION_ID(pc) != KERNEL_REGION_ID) && \
-		         (REGION_ID(pc) != VMALLOC_REGION_ID))
-#else
-#define BAD_PC(pc)	((pc) < KERNELBASE)
-#endif
-
 static void show_instructions(struct pt_regs *regs)
 {
 	int i;
@@ -366,7 +359,8 @@ static void show_instructions(struct pt_
 		 * bad address because the pc *should* only be a
 		 * kernel address.
 		 */
-		if (BAD_PC(pc) || __get_user(instr, (unsigned int __user *)pc)) {
+		if (!__kernel_text_address(pc) ||
+		     __get_user(instr, (unsigned int __user *)pc)) {
 			printk("XXXXXXXX ");
 		} else {
 			if (regs->nip == pc)
