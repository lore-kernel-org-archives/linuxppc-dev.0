Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, rusty@rustcorp.com.au,
 ulrich.weigand@de.ibm.com, amodra@gmail.com, mikey@neuling.org,
 mjw@linux.vnet.ibm.com, rostedt@goodmis.org, philippe.bergheaud@fr.ibm.com
Subject: [PATCH 7/7] powerpc/ftrace: Fix ABIv2 issues with __ftrace_make_call
Date: Fri,  4 Apr 2014 17:09:10 +1100
Message-Id: <1396591750-8203-8-git-send-email-anton@samba.org>
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

__ftrace_make_call assumed ABIv1 TOC stack offsets, so it
broke on ABIv2.

While we are here, we can simplify the instruction modification
code. Since we always update one instruction there is no need to
probe_kernel_write and flush_icache_range, just use patch_branch.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/kernel/ftrace.c | 40 +++++++++++++++++++---------------------
 1 file changed, 19 insertions(+), 21 deletions(-)

diff --git a/arch/powerpc/kernel/ftrace.c b/arch/powerpc/kernel/ftrace.c
index b68e0ef..6ab510d 100644
--- a/arch/powerpc/kernel/ftrace.c
+++ b/arch/powerpc/kernel/ftrace.c
@@ -292,19 +292,24 @@ static int
 __ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
 {
 	unsigned int op[2];
-	unsigned long ip = rec->ip;
+	void *ip = (void *)rec->ip;
 
 	/* read where this goes */
-	if (probe_kernel_read(op, (void *)ip, MCOUNT_INSN_SIZE * 2))
+	if (probe_kernel_read(op, ip, sizeof(op)))
 		return -EFAULT;
 
 	/*
-	 * It should be pointing to two nops or
-	 *  b +8; ld r2,40(r1)
+	 * We expect to see:
+	 *
+	 * b +8
+	 * ld r2,XX(r1)
+	 *
+	 * The load offset is different depending on the ABI. For simplicity
+	 * just mask it out when doing the compare.
 	 */
-	if (((op[0] != 0x48000008) || (op[1] != 0xe8410028)) &&
-	    ((op[0] != PPC_INST_NOP) || (op[1] != PPC_INST_NOP))) {
-		printk(KERN_ERR "Expected NOPs but have %x %x\n", op[0], op[1]);
+	if ((op[0] != 0x48000008) || ((op[1] & 0xffff00000) != 0xe8410000)) {
+		printk(KERN_ERR "Unexpected call sequence: %x %x\n",
+			op[0], op[1]);
 		return -EINVAL;
 	}
 
@@ -314,23 +319,16 @@ __ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
 		return -EINVAL;
 	}
 
-	/* create the branch to the trampoline */
-	op[0] = create_branch((unsigned int *)ip,
-			      rec->arch.mod->arch.tramp, BRANCH_SET_LINK);
-	if (!op[0]) {
-		printk(KERN_ERR "REL24 out of range!\n");
+	/* Ensure branch is within 24 bits */
+	if (create_branch(ip, rec->arch.mod->arch.tramp, BRANCH_SET_LINK)) {
+		printk(KERN_ERR "Branch out of range");
 		return -EINVAL;
 	}
 
-	/* ld r2,40(r1) */
-	op[1] = 0xe8410028;
-
-	pr_devel("write to %lx\n", rec->ip);
-
-	if (probe_kernel_write((void *)ip, op, MCOUNT_INSN_SIZE * 2))
-		return -EPERM;
-
-	flush_icache_range(ip, ip + 8);
+	if (patch_branch(ip, rec->arch.mod->arch.tramp, BRANCH_SET_LINK)) {
+		printk(KERN_ERR "REL24 out of range!\n");
+		return -EINVAL;
+	}
 
 	return 0;
 }
-- 
1.8.3.2
