Return-Path: <anton@ozlabs.org>
Date: Wed, 25 Aug 2010 09:15:28 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org
Subject: [PATCH] powerpc: Check end of stack canary at oops time
Message-ID: <20100824231528.GC28360@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Add a check for the stack canary when we oops, similar to x86. This should make
it clear that we overran our stack:

Unable to handle kernel paging request for data at address 0x24652f63700ac689
Faulting instruction address: 0xc000000000063d24
Thread overran stack, or stack corrupted

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: powerpc.git/arch/powerpc/mm/fault.c
===================================================================
--- powerpc.git.orig/arch/powerpc/mm/fault.c	2010-08-25 08:41:08.230086186 +1000
+++ powerpc.git/arch/powerpc/mm/fault.c	2010-08-25 09:12:38.276553103 +1000
@@ -30,6 +30,7 @@
 #include <linux/kprobes.h>
 #include <linux/kdebug.h>
 #include <linux/perf_event.h>
+#include <linux/magic.h>
 
 #include <asm/firmware.h>
 #include <asm/page.h>
@@ -385,6 +386,7 @@ do_sigbus:
 void bad_page_fault(struct pt_regs *regs, unsigned long address, int sig)
 {
 	const struct exception_table_entry *entry;
+	unsigned long *stackend;
 
 	/* Are we prepared to handle this fault?  */
 	if ((entry = search_exception_tables(regs->nip)) != NULL) {
@@ -413,5 +415,9 @@ void bad_page_fault(struct pt_regs *regs
 	printk(KERN_ALERT "Faulting instruction address: 0x%08lx\n",
 		regs->nip);
 
+	stackend = end_of_stack(current);
+	if (current != &init_task && *stackend != STACK_END_MAGIC)
+		printk(KERN_ALERT "Thread overran stack, or stack corrupted\n");
+
 	die("Kernel access of bad area", regs, sig);
 }
