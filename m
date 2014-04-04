Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, rusty@rustcorp.com.au,
 ulrich.weigand@de.ibm.com, amodra@gmail.com, mikey@neuling.org,
 mjw@linux.vnet.ibm.com, rostedt@goodmis.org, philippe.bergheaud@fr.ibm.com
Subject: [PATCH 6/7] powerpc/ftrace: Use module loader helpers to parse
 trampolines
Date: Fri,  4 Apr 2014 17:09:09 +1100
Message-Id: <1396591750-8203-7-git-send-email-anton@samba.org>
In-Reply-To: <1396591750-8203-1-git-send-email-anton@samba.org>
References: <1396591750-8203-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Now we have is_module_trampoline() and module_trampoline_target()
we can remove a bunch of intimate kernel module trampoline
knowledge from ftrace.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/kernel/ftrace.c | 97 +++++++++-----------------------------------
 1 file changed, 20 insertions(+), 77 deletions(-)

diff --git a/arch/powerpc/kernel/ftrace.c b/arch/powerpc/kernel/ftrace.c
index b0ded97..b68e0ef 100644
--- a/arch/powerpc/kernel/ftrace.c
+++ b/arch/powerpc/kernel/ftrace.c
@@ -105,11 +105,9 @@ __ftrace_make_nop(struct module *mod,
 		  struct dyn_ftrace *rec, unsigned long addr)
 {
 	unsigned int op;
-	unsigned int jmp[5];
 	unsigned long ptr;
 	unsigned long ip = rec->ip;
-	unsigned long tramp;
-	int offset;
+	void *tramp;
 
 	/* read where this goes */
 	if (probe_kernel_read(&op, (void *)ip, sizeof(int)))
@@ -122,96 +120,41 @@ __ftrace_make_nop(struct module *mod,
 	}
 
 	/* lets find where the pointer goes */
-	tramp = find_bl_target(ip, op);
-
-	/*
-	 * On PPC64 the trampoline looks like:
-	 * 0x3d, 0x82, 0x00, 0x00,    addis   r12,r2, <high>
-	 * 0x39, 0x8c, 0x00, 0x00,    addi    r12,r12, <low>
-	 *   Where the bytes 2,3,6 and 7 make up the 32bit offset
-	 *   to the TOC that holds the pointer.
-	 *   to jump to.
-	 * 0xf8, 0x41, 0x00, 0x28,    std     r2,40(r1)
-	 * 0xe9, 0x6c, 0x00, 0x20,    ld      r11,32(r12)
-	 *   The actually address is 32 bytes from the offset
-	 *   into the TOC.
-	 * 0xe8, 0x4c, 0x00, 0x28,    ld      r2,40(r12)
-	 */
+	tramp = (void *)find_bl_target(ip, op);
 
-	pr_devel("ip:%lx jumps to %lx r2: %lx", ip, tramp, mod->arch.toc);
+	pr_devel("ip:%lx jumps to %p", ip, tramp);
 
-	/* Find where the trampoline jumps to */
-	if (probe_kernel_read(jmp, (void *)tramp, sizeof(jmp))) {
-		printk(KERN_ERR "Failed to read %lx\n", tramp);
-		return -EFAULT;
-	}
-
-	pr_devel(" %08x %08x", jmp[0], jmp[1]);
-
-	/* verify that this is what we expect it to be */
-	if (((jmp[0] & 0xffff0000) != 0x3d820000) ||
-	    ((jmp[1] & 0xffff0000) != 0x398c0000) ||
-	    (jmp[2] != 0xf8410028) ||
-	    (jmp[3] != 0xe96c0020) ||
-	    (jmp[4] != 0xe84c0028)) {
+	if (!is_module_trampoline(tramp)) {
 		printk(KERN_ERR "Not a trampoline\n");
 		return -EINVAL;
 	}
 
-	/* The bottom half is signed extended */
-	offset = ((unsigned)((unsigned short)jmp[0]) << 16) +
-		(int)((short)jmp[1]);
-
-	pr_devel(" %x ", offset);
-
-	/* get the address this jumps too */
-	tramp = mod->arch.toc + offset + 32;
-	pr_devel("toc: %lx", tramp);
-
-	if (probe_kernel_read(jmp, (void *)tramp, 8)) {
-		printk(KERN_ERR "Failed to read %lx\n", tramp);
+	if (module_trampoline_target(mod, tramp, &ptr)) {
+		printk(KERN_ERR "Failed to get trampoline target\n");
 		return -EFAULT;
 	}
 
-	pr_devel(" %08x %08x\n", jmp[0], jmp[1]);
-
-#ifdef __LITTLE_ENDIAN__
-	ptr = ((unsigned long)jmp[1] << 32) + jmp[0];
-#else
-	ptr = ((unsigned long)jmp[0] << 32) + jmp[1];
-#endif
+	pr_devel("trampoline target %lx", ptr);
 
 	/* This should match what was called */
 	if (ptr != ppc_function_entry((void *)addr)) {
-		printk(KERN_ERR "addr does not match %lx\n", ptr);
+		printk(KERN_ERR "addr %lx does not match expected %lx\n",
+			ptr, ppc_function_entry((void *)addr));
 		return -EINVAL;
 	}
 
 	/*
-	 * We want to nop the line, but the next line is
-	 *  0xe8, 0x41, 0x00, 0x28   ld r2,40(r1)
-	 * This needs to be turned to a nop too.
-	 */
-	if (probe_kernel_read(&op, (void *)(ip+4), MCOUNT_INSN_SIZE))
-		return -EFAULT;
-
-	if (op != 0xe8410028) {
-		printk(KERN_ERR "Next line is not ld! (%08x)\n", op);
-		return -EINVAL;
-	}
-
-	/*
-	 * Milton Miller pointed out that we can not blindly do nops.
-	 * If a task was preempted when calling a trace function,
-	 * the nops will remove the way to restore the TOC in r2
-	 * and the r2 TOC will get corrupted.
-	 */
-
-	/*
-	 * Replace:
-	 *   bl <tramp>  <==== will be replaced with "b 1f"
-	 *   ld r2,40(r1)
-	 *  1:
+	 * Our original call site looks like:
+	 *
+	 * bl <tramp>
+	 * ld r2,XX(r1)
+	 *
+	 * Milton Miller pointed out that we can not simply nop the branch.
+	 * If a task was preempted when calling a trace function, the nops
+	 * will remove the way to restore the TOC in r2 and the r2 TOC will
+	 * get corrupted.
+	 *
+	 * Use a b +8 to jump over the load.
 	 */
 	op = 0x48000008;	/* b +8 */
 
-- 
1.8.3.2
