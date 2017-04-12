Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w31ft2j9yzDqNS
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 21:20:06 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3CBJMhh060674
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 07:20:04 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29sesmuwuq-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 07:20:04 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 12 Apr 2017 21:20:01 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3CBJnxr51576934
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 21:19:57 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3CBJLKS024943
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 21:19:21 +1000
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2] powerpc: kprobes: convert __kprobes to NOKPROBE_SYMBOL()
Date: Wed, 12 Apr 2017 16:48:51 +0530
Message-Id: <20170412111851.4708-1-naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Along similar lines as commit 9326638cbee2 ("kprobes, x86: Use
NOKPROBE_SYMBOL() instead of __kprobes annotation"), convert __kprobes
annotation to either NOKPROBE_SYMBOL() or nokprobe_inline. The latter
forces inlining, in which case the caller needs to be added to
NOKPROBE_SYMBOL().

Also:
- blacklist arch_deref_entry_point, and
- convert a few regular inlines to nokprobe_inline in lib/sstep.c

A key benefit is the ability to detect such symbols as being
blacklisted. Before this patch:

  naveen@ubuntu:~/linux/tools/perf$ sudo cat /sys/kernel/debug/kprobes/blacklist | grep read_mem
  naveen@ubuntu:~/linux/tools/perf$ sudo ./perf probe read_mem
  Failed to write event: Invalid argument
    Error: Failed to add events.
  naveen@ubuntu:~/linux/tools/perf$ dmesg | tail -1
  [ 3736.112815] Could not insert probe at _text+10014968: -22

After patch:
  naveen@ubuntu:~/linux/tools/perf$ sudo cat /sys/kernel/debug/kprobes/blacklist | grep read_mem
  0xc000000000072b50-0xc000000000072d20	read_mem
  naveen@ubuntu:~/linux/tools/perf$ sudo ./perf probe read_mem
  read_mem is blacklisted function, skip it.
  Added new events:
    (null):(null)        (on read_mem)
    probe:read_mem       (on read_mem)

  You can now use it in all perf tools, such as:

	  perf record -e probe:read_mem -aR sleep 1

  naveen@ubuntu:~/linux/tools/perf$ sudo grep " read_mem" /proc/kallsyms
  c000000000072b50 t read_mem
  c0000000005f3b40 t read_mem
  naveen@ubuntu:~/linux/tools/perf$ sudo cat /sys/kernel/debug/kprobes/list
  c0000000005f3b48  k  read_mem+0x8    [DISABLED]

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
v2:
- rebased on top of powerpc/next along with related kprobes patches
- removed incorrect blacklist of kretprobe_trampoline.

 arch/powerpc/kernel/kprobes.c    | 58 +++++++++++++++++-----------
 arch/powerpc/lib/code-patching.c |  4 +-
 arch/powerpc/lib/sstep.c         | 82 +++++++++++++++++++++-------------------
 3 files changed, 83 insertions(+), 61 deletions(-)

diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
index 23d19678a56f..1983ed2c1544 100644
--- a/arch/powerpc/kernel/kprobes.c
+++ b/arch/powerpc/kernel/kprobes.c
@@ -113,7 +113,7 @@ kprobe_opcode_t *kprobe_lookup_name(const char *name, unsigned int offset)
 	return addr;
 }
 
-int __kprobes arch_prepare_kprobe(struct kprobe *p)
+int arch_prepare_kprobe(struct kprobe *p)
 {
 	int ret = 0;
 	kprobe_opcode_t insn = *p->addr;
@@ -145,30 +145,34 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
 	p->ainsn.boostable = 0;
 	return ret;
 }
+NOKPROBE_SYMBOL(arch_prepare_kprobe);
 
-void __kprobes arch_arm_kprobe(struct kprobe *p)
+void arch_arm_kprobe(struct kprobe *p)
 {
 	*p->addr = BREAKPOINT_INSTRUCTION;
 	flush_icache_range((unsigned long) p->addr,
 			   (unsigned long) p->addr + sizeof(kprobe_opcode_t));
 }
+NOKPROBE_SYMBOL(arch_arm_kprobe);
 
-void __kprobes arch_disarm_kprobe(struct kprobe *p)
+void arch_disarm_kprobe(struct kprobe *p)
 {
 	*p->addr = p->opcode;
 	flush_icache_range((unsigned long) p->addr,
 			   (unsigned long) p->addr + sizeof(kprobe_opcode_t));
 }
+NOKPROBE_SYMBOL(arch_disarm_kprobe);
 
-void __kprobes arch_remove_kprobe(struct kprobe *p)
+void arch_remove_kprobe(struct kprobe *p)
 {
 	if (p->ainsn.insn) {
 		free_insn_slot(p->ainsn.insn, 0);
 		p->ainsn.insn = NULL;
 	}
 }
+NOKPROBE_SYMBOL(arch_remove_kprobe);
 
-static void __kprobes prepare_singlestep(struct kprobe *p, struct pt_regs *regs)
+static nokprobe_inline void prepare_singlestep(struct kprobe *p, struct pt_regs *regs)
 {
 	enable_single_step(regs);
 
@@ -181,21 +185,21 @@ static void __kprobes prepare_singlestep(struct kprobe *p, struct pt_regs *regs)
 	regs->nip = (unsigned long)p->ainsn.insn;
 }
 
-static void __kprobes save_previous_kprobe(struct kprobe_ctlblk *kcb)
+static nokprobe_inline void save_previous_kprobe(struct kprobe_ctlblk *kcb)
 {
 	kcb->prev_kprobe.kp = kprobe_running();
 	kcb->prev_kprobe.status = kcb->kprobe_status;
 	kcb->prev_kprobe.saved_msr = kcb->kprobe_saved_msr;
 }
 
-static void __kprobes restore_previous_kprobe(struct kprobe_ctlblk *kcb)
+static nokprobe_inline void restore_previous_kprobe(struct kprobe_ctlblk *kcb)
 {
 	__this_cpu_write(current_kprobe, kcb->prev_kprobe.kp);
 	kcb->kprobe_status = kcb->prev_kprobe.status;
 	kcb->kprobe_saved_msr = kcb->prev_kprobe.saved_msr;
 }
 
-static void __kprobes set_current_kprobe(struct kprobe *p, struct pt_regs *regs,
+static nokprobe_inline void set_current_kprobe(struct kprobe *p, struct pt_regs *regs,
 				struct kprobe_ctlblk *kcb)
 {
 	__this_cpu_write(current_kprobe, p);
@@ -215,16 +219,16 @@ bool arch_function_offset_within_entry(unsigned long offset)
 #endif
 }
 
-void __kprobes arch_prepare_kretprobe(struct kretprobe_instance *ri,
-				      struct pt_regs *regs)
+void arch_prepare_kretprobe(struct kretprobe_instance *ri, struct pt_regs *regs)
 {
 	ri->ret_addr = (kprobe_opcode_t *)regs->link;
 
 	/* Replace the return addr with trampoline addr */
 	regs->link = (unsigned long)kretprobe_trampoline;
 }
+NOKPROBE_SYMBOL(arch_prepare_kretprobe);
 
-int __kprobes try_to_emulate(struct kprobe *p, struct pt_regs *regs)
+int try_to_emulate(struct kprobe *p, struct pt_regs *regs)
 {
 	int ret;
 	unsigned int insn = *p->ainsn.insn;
@@ -252,8 +256,9 @@ int __kprobes try_to_emulate(struct kprobe *p, struct pt_regs *regs)
 
 	return ret;
 }
+NOKPROBE_SYMBOL(try_to_emulate);
 
-int __kprobes kprobe_handler(struct pt_regs *regs)
+int kprobe_handler(struct pt_regs *regs)
 {
 	struct kprobe *p;
 	int ret = 0;
@@ -377,6 +382,7 @@ int __kprobes kprobe_handler(struct pt_regs *regs)
 	preempt_enable_no_resched();
 	return ret;
 }
+NOKPROBE_SYMBOL(kprobe_handler);
 
 /*
  * Function return probe trampoline:
@@ -394,8 +400,7 @@ asm(".global kretprobe_trampoline\n"
 /*
  * Called when the probe at kretprobe trampoline is hit
  */
-static int __kprobes trampoline_probe_handler(struct kprobe *p,
-						struct pt_regs *regs)
+static int trampoline_probe_handler(struct kprobe *p, struct pt_regs *regs)
 {
 	struct kretprobe_instance *ri = NULL;
 	struct hlist_head *head, empty_rp;
@@ -464,6 +469,7 @@ static int __kprobes trampoline_probe_handler(struct kprobe *p,
 	 */
 	return 1;
 }
+NOKPROBE_SYMBOL(trampoline_probe_handler);
 
 /*
  * Called after single-stepping.  p->addr is the address of the
@@ -473,7 +479,7 @@ static int __kprobes trampoline_probe_handler(struct kprobe *p,
  * single-stepped a copy of the instruction.  The address of this
  * copy is p->ainsn.insn.
  */
-int __kprobes kprobe_post_handler(struct pt_regs *regs)
+int kprobe_post_handler(struct pt_regs *regs)
 {
 	struct kprobe *cur = kprobe_running();
 	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
@@ -513,8 +519,9 @@ int __kprobes kprobe_post_handler(struct pt_regs *regs)
 
 	return 1;
 }
+NOKPROBE_SYMBOL(kprobe_post_handler);
 
-int __kprobes kprobe_fault_handler(struct pt_regs *regs, int trapnr)
+int kprobe_fault_handler(struct pt_regs *regs, int trapnr)
 {
 	struct kprobe *cur = kprobe_running();
 	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
@@ -577,13 +584,15 @@ int __kprobes kprobe_fault_handler(struct pt_regs *regs, int trapnr)
 	}
 	return 0;
 }
+NOKPROBE_SYMBOL(kprobe_fault_handler);
 
 unsigned long arch_deref_entry_point(void *entry)
 {
 	return ppc_global_function_entry(entry);
 }
+NOKPROBE_SYMBOL(arch_deref_entry_point);
 
-int __kprobes setjmp_pre_handler(struct kprobe *p, struct pt_regs *regs)
+int setjmp_pre_handler(struct kprobe *p, struct pt_regs *regs)
 {
 	struct jprobe *jp = container_of(p, struct jprobe, kp);
 	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
@@ -600,17 +609,20 @@ int __kprobes setjmp_pre_handler(struct kprobe *p, struct pt_regs *regs)
 
 	return 1;
 }
+NOKPROBE_SYMBOL(setjmp_pre_handler);
 
-void __used __kprobes jprobe_return(void)
+void __used jprobe_return(void)
 {
 	asm volatile("trap" ::: "memory");
 }
+NOKPROBE_SYMBOL(jprobe_return);
 
-static void __used __kprobes jprobe_return_end(void)
+static void __used jprobe_return_end(void)
 {
-};
+}
+NOKPROBE_SYMBOL(jprobe_return_end);
 
-int __kprobes longjmp_break_handler(struct kprobe *p, struct pt_regs *regs)
+int longjmp_break_handler(struct kprobe *p, struct pt_regs *regs)
 {
 	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
 
@@ -623,6 +635,7 @@ int __kprobes longjmp_break_handler(struct kprobe *p, struct pt_regs *regs)
 	preempt_enable_no_resched();
 	return 1;
 }
+NOKPROBE_SYMBOL(longjmp_break_handler);
 
 static struct kprobe trampoline_p = {
 	.addr = (kprobe_opcode_t *) &kretprobe_trampoline,
@@ -634,10 +647,11 @@ int __init arch_init_kprobes(void)
 	return register_kprobe(&trampoline_p);
 }
 
-int __kprobes arch_trampoline_kprobe(struct kprobe *p)
+int arch_trampoline_kprobe(struct kprobe *p)
 {
 	if (p->addr == (kprobe_opcode_t *)&kretprobe_trampoline)
 		return 1;
 
 	return 0;
 }
+NOKPROBE_SYMBOL(arch_trampoline_kprobe);
diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patching.c
index 0d3002b7e2b4..500b0f6a0b64 100644
--- a/arch/powerpc/lib/code-patching.c
+++ b/arch/powerpc/lib/code-patching.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/kprobes.h>
 #include <linux/vmalloc.h>
 #include <linux/init.h>
 #include <linux/mm.h>
@@ -59,7 +60,7 @@ bool is_offset_in_branch_range(long offset)
  * Helper to check if a given instruction is a conditional branch
  * Derived from the conditional checks in analyse_instr()
  */
-bool __kprobes is_conditional_branch(unsigned int instr)
+bool is_conditional_branch(unsigned int instr)
 {
 	unsigned int opcode = instr >> 26;
 
@@ -75,6 +76,7 @@ bool __kprobes is_conditional_branch(unsigned int instr)
 	}
 	return false;
 }
+NOKPROBE_SYMBOL(is_conditional_branch);
 
 unsigned int create_branch(const unsigned int *addr,
 			   unsigned long target, int flags)
diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
index 9c542ec70c5b..33117f8a0882 100644
--- a/arch/powerpc/lib/sstep.c
+++ b/arch/powerpc/lib/sstep.c
@@ -49,7 +49,8 @@ extern int do_stxvd2x(int rn, unsigned long ea);
 /*
  * Emulate the truncation of 64 bit values in 32-bit mode.
  */
-static unsigned long truncate_if_32bit(unsigned long msr, unsigned long val)
+static nokprobe_inline unsigned long truncate_if_32bit(unsigned long msr,
+							unsigned long val)
 {
 #ifdef __powerpc64__
 	if ((msr & MSR_64BIT) == 0)
@@ -61,7 +62,7 @@ static unsigned long truncate_if_32bit(unsigned long msr, unsigned long val)
 /*
  * Determine whether a conditional branch instruction would branch.
  */
-static int __kprobes branch_taken(unsigned int instr, struct pt_regs *regs)
+static nokprobe_inline int branch_taken(unsigned int instr, struct pt_regs *regs)
 {
 	unsigned int bo = (instr >> 21) & 0x1f;
 	unsigned int bi;
@@ -81,8 +82,7 @@ static int __kprobes branch_taken(unsigned int instr, struct pt_regs *regs)
 	return 1;
 }
 
-
-static long __kprobes address_ok(struct pt_regs *regs, unsigned long ea, int nb)
+static nokprobe_inline long address_ok(struct pt_regs *regs, unsigned long ea, int nb)
 {
 	if (!user_mode(regs))
 		return 1;
@@ -92,7 +92,7 @@ static long __kprobes address_ok(struct pt_regs *regs, unsigned long ea, int nb)
 /*
  * Calculate effective address for a D-form instruction
  */
-static unsigned long __kprobes dform_ea(unsigned int instr, struct pt_regs *regs)
+static nokprobe_inline unsigned long dform_ea(unsigned int instr, struct pt_regs *regs)
 {
 	int ra;
 	unsigned long ea;
@@ -109,7 +109,7 @@ static unsigned long __kprobes dform_ea(unsigned int instr, struct pt_regs *regs
 /*
  * Calculate effective address for a DS-form instruction
  */
-static unsigned long __kprobes dsform_ea(unsigned int instr, struct pt_regs *regs)
+static nokprobe_inline unsigned long dsform_ea(unsigned int instr, struct pt_regs *regs)
 {
 	int ra;
 	unsigned long ea;
@@ -126,8 +126,8 @@ static unsigned long __kprobes dsform_ea(unsigned int instr, struct pt_regs *reg
 /*
  * Calculate effective address for an X-form instruction
  */
-static unsigned long __kprobes xform_ea(unsigned int instr,
-					struct pt_regs *regs)
+static nokprobe_inline unsigned long xform_ea(unsigned int instr,
+						struct pt_regs *regs)
 {
 	int ra, rb;
 	unsigned long ea;
@@ -145,33 +145,33 @@ static unsigned long __kprobes xform_ea(unsigned int instr,
  * Return the largest power of 2, not greater than sizeof(unsigned long),
  * such that x is a multiple of it.
  */
-static inline unsigned long max_align(unsigned long x)
+static nokprobe_inline unsigned long max_align(unsigned long x)
 {
 	x |= sizeof(unsigned long);
 	return x & -x;		/* isolates rightmost bit */
 }
 
 
-static inline unsigned long byterev_2(unsigned long x)
+static nokprobe_inline unsigned long byterev_2(unsigned long x)
 {
 	return ((x >> 8) & 0xff) | ((x & 0xff) << 8);
 }
 
-static inline unsigned long byterev_4(unsigned long x)
+static nokprobe_inline unsigned long byterev_4(unsigned long x)
 {
 	return ((x >> 24) & 0xff) | ((x >> 8) & 0xff00) |
 		((x & 0xff00) << 8) | ((x & 0xff) << 24);
 }
 
 #ifdef __powerpc64__
-static inline unsigned long byterev_8(unsigned long x)
+static nokprobe_inline unsigned long byterev_8(unsigned long x)
 {
 	return (byterev_4(x) << 32) | byterev_4(x >> 32);
 }
 #endif
 
-static int __kprobes read_mem_aligned(unsigned long *dest, unsigned long ea,
-				      int nb)
+static nokprobe_inline int read_mem_aligned(unsigned long *dest,
+					unsigned long ea, int nb)
 {
 	int err = 0;
 	unsigned long x = 0;
@@ -197,8 +197,8 @@ static int __kprobes read_mem_aligned(unsigned long *dest, unsigned long ea,
 	return err;
 }
 
-static int __kprobes read_mem_unaligned(unsigned long *dest, unsigned long ea,
-					int nb, struct pt_regs *regs)
+static nokprobe_inline int read_mem_unaligned(unsigned long *dest,
+				unsigned long ea, int nb, struct pt_regs *regs)
 {
 	int err;
 	unsigned long x, b, c;
@@ -248,7 +248,7 @@ static int __kprobes read_mem_unaligned(unsigned long *dest, unsigned long ea,
  * Read memory at address ea for nb bytes, return 0 for success
  * or -EFAULT if an error occurred.
  */
-static int __kprobes read_mem(unsigned long *dest, unsigned long ea, int nb,
+static int read_mem(unsigned long *dest, unsigned long ea, int nb,
 			      struct pt_regs *regs)
 {
 	if (!address_ok(regs, ea, nb))
@@ -257,9 +257,10 @@ static int __kprobes read_mem(unsigned long *dest, unsigned long ea, int nb,
 		return read_mem_aligned(dest, ea, nb);
 	return read_mem_unaligned(dest, ea, nb, regs);
 }
+NOKPROBE_SYMBOL(read_mem);
 
-static int __kprobes write_mem_aligned(unsigned long val, unsigned long ea,
-				       int nb)
+static nokprobe_inline int write_mem_aligned(unsigned long val,
+					unsigned long ea, int nb)
 {
 	int err = 0;
 
@@ -282,8 +283,8 @@ static int __kprobes write_mem_aligned(unsigned long val, unsigned long ea,
 	return err;
 }
 
-static int __kprobes write_mem_unaligned(unsigned long val, unsigned long ea,
-					 int nb, struct pt_regs *regs)
+static nokprobe_inline int write_mem_unaligned(unsigned long val,
+				unsigned long ea, int nb, struct pt_regs *regs)
 {
 	int err;
 	unsigned long c;
@@ -325,7 +326,7 @@ static int __kprobes write_mem_unaligned(unsigned long val, unsigned long ea,
  * Write memory at address ea for nb bytes, return 0 for success
  * or -EFAULT if an error occurred.
  */
-static int __kprobes write_mem(unsigned long val, unsigned long ea, int nb,
+static int write_mem(unsigned long val, unsigned long ea, int nb,
 			       struct pt_regs *regs)
 {
 	if (!address_ok(regs, ea, nb))
@@ -334,13 +335,14 @@ static int __kprobes write_mem(unsigned long val, unsigned long ea, int nb,
 		return write_mem_aligned(val, ea, nb);
 	return write_mem_unaligned(val, ea, nb, regs);
 }
+NOKPROBE_SYMBOL(write_mem);
 
 #ifdef CONFIG_PPC_FPU
 /*
  * Check the address and alignment, and call func to do the actual
  * load or store.
  */
-static int __kprobes do_fp_load(int rn, int (*func)(int, unsigned long),
+static int do_fp_load(int rn, int (*func)(int, unsigned long),
 				unsigned long ea, int nb,
 				struct pt_regs *regs)
 {
@@ -380,8 +382,9 @@ static int __kprobes do_fp_load(int rn, int (*func)(int, unsigned long),
 		return err;
 	return (*func)(rn, ptr);
 }
+NOKPROBE_SYMBOL(do_fp_load);
 
-static int __kprobes do_fp_store(int rn, int (*func)(int, unsigned long),
+static int do_fp_store(int rn, int (*func)(int, unsigned long),
 				 unsigned long ea, int nb,
 				 struct pt_regs *regs)
 {
@@ -425,11 +428,12 @@ static int __kprobes do_fp_store(int rn, int (*func)(int, unsigned long),
 	}
 	return err;
 }
+NOKPROBE_SYMBOL(do_fp_store);
 #endif
 
 #ifdef CONFIG_ALTIVEC
 /* For Altivec/VMX, no need to worry about alignment */
-static int __kprobes do_vec_load(int rn, int (*func)(int, unsigned long),
+static nokprobe_inline int do_vec_load(int rn, int (*func)(int, unsigned long),
 				 unsigned long ea, struct pt_regs *regs)
 {
 	if (!address_ok(regs, ea & ~0xfUL, 16))
@@ -437,7 +441,7 @@ static int __kprobes do_vec_load(int rn, int (*func)(int, unsigned long),
 	return (*func)(rn, ea);
 }
 
-static int __kprobes do_vec_store(int rn, int (*func)(int, unsigned long),
+static nokprobe_inline int do_vec_store(int rn, int (*func)(int, unsigned long),
 				  unsigned long ea, struct pt_regs *regs)
 {
 	if (!address_ok(regs, ea & ~0xfUL, 16))
@@ -447,7 +451,7 @@ static int __kprobes do_vec_store(int rn, int (*func)(int, unsigned long),
 #endif /* CONFIG_ALTIVEC */
 
 #ifdef CONFIG_VSX
-static int __kprobes do_vsx_load(int rn, int (*func)(int, unsigned long),
+static nokprobe_inline int do_vsx_load(int rn, int (*func)(int, unsigned long),
 				 unsigned long ea, struct pt_regs *regs)
 {
 	int err;
@@ -465,7 +469,7 @@ static int __kprobes do_vsx_load(int rn, int (*func)(int, unsigned long),
 	return err;
 }
 
-static int __kprobes do_vsx_store(int rn, int (*func)(int, unsigned long),
+static nokprobe_inline int do_vsx_store(int rn, int (*func)(int, unsigned long),
 				 unsigned long ea, struct pt_regs *regs)
 {
 	int err;
@@ -522,7 +526,7 @@ static int __kprobes do_vsx_store(int rn, int (*func)(int, unsigned long),
 		: "=r" (err)				\
 		: "r" (addr), "i" (-EFAULT), "0" (err))
 
-static void __kprobes set_cr0(struct pt_regs *regs, int rd)
+static nokprobe_inline void set_cr0(struct pt_regs *regs, int rd)
 {
 	long val = regs->gpr[rd];
 
@@ -539,7 +543,7 @@ static void __kprobes set_cr0(struct pt_regs *regs, int rd)
 		regs->ccr |= 0x20000000;
 }
 
-static void __kprobes add_with_carry(struct pt_regs *regs, int rd,
+static nokprobe_inline void add_with_carry(struct pt_regs *regs, int rd,
 				     unsigned long val1, unsigned long val2,
 				     unsigned long carry_in)
 {
@@ -560,7 +564,7 @@ static void __kprobes add_with_carry(struct pt_regs *regs, int rd,
 		regs->xer &= ~XER_CA;
 }
 
-static void __kprobes do_cmp_signed(struct pt_regs *regs, long v1, long v2,
+static nokprobe_inline void do_cmp_signed(struct pt_regs *regs, long v1, long v2,
 				    int crfld)
 {
 	unsigned int crval, shift;
@@ -576,7 +580,7 @@ static void __kprobes do_cmp_signed(struct pt_regs *regs, long v1, long v2,
 	regs->ccr = (regs->ccr & ~(0xf << shift)) | (crval << shift);
 }
 
-static void __kprobes do_cmp_unsigned(struct pt_regs *regs, unsigned long v1,
+static nokprobe_inline void do_cmp_unsigned(struct pt_regs *regs, unsigned long v1,
 				      unsigned long v2, int crfld)
 {
 	unsigned int crval, shift;
@@ -592,7 +596,7 @@ static void __kprobes do_cmp_unsigned(struct pt_regs *regs, unsigned long v1,
 	regs->ccr = (regs->ccr & ~(0xf << shift)) | (crval << shift);
 }
 
-static int __kprobes trap_compare(long v1, long v2)
+static nokprobe_inline int trap_compare(long v1, long v2)
 {
 	int ret = 0;
 
@@ -631,7 +635,7 @@ static int __kprobes trap_compare(long v1, long v2)
  * Returns 1 if the instruction has been executed, or 0 if not.
  * Sets *op to indicate what the instruction does.
  */
-int __kprobes analyse_instr(struct instruction_op *op, struct pt_regs *regs,
+int analyse_instr(struct instruction_op *op, struct pt_regs *regs,
 			    unsigned int instr)
 {
 	unsigned int opcode, ra, rb, rd, spr, u;
@@ -1692,6 +1696,7 @@ int __kprobes analyse_instr(struct instruction_op *op, struct pt_regs *regs,
 #endif
 }
 EXPORT_SYMBOL_GPL(analyse_instr);
+NOKPROBE_SYMBOL(analyse_instr);
 
 /*
  * For PPC32 we always use stwu with r1 to change the stack pointer.
@@ -1701,7 +1706,7 @@ EXPORT_SYMBOL_GPL(analyse_instr);
  * don't emulate the real store operation. We will do real store
  * operation safely in exception return code by checking this flag.
  */
-static __kprobes int handle_stack_update(unsigned long ea, struct pt_regs *regs)
+static nokprobe_inline int handle_stack_update(unsigned long ea, struct pt_regs *regs)
 {
 #ifdef CONFIG_PPC32
 	/*
@@ -1721,7 +1726,7 @@ static __kprobes int handle_stack_update(unsigned long ea, struct pt_regs *regs)
 	return 0;
 }
 
-static __kprobes void do_signext(unsigned long *valp, int size)
+static nokprobe_inline void do_signext(unsigned long *valp, int size)
 {
 	switch (size) {
 	case 2:
@@ -1733,7 +1738,7 @@ static __kprobes void do_signext(unsigned long *valp, int size)
 	}
 }
 
-static __kprobes void do_byterev(unsigned long *valp, int size)
+static nokprobe_inline void do_byterev(unsigned long *valp, int size)
 {
 	switch (size) {
 	case 2:
@@ -1757,7 +1762,7 @@ static __kprobes void do_byterev(unsigned long *valp, int size)
  * or -1 if the instruction is one that should not be stepped,
  * such as an rfid, or a mtmsrd that would clear MSR_RI.
  */
-int __kprobes emulate_step(struct pt_regs *regs, unsigned int instr)
+int emulate_step(struct pt_regs *regs, unsigned int instr)
 {
 	struct instruction_op op;
 	int r, err, size;
@@ -1988,3 +1993,4 @@ int __kprobes emulate_step(struct pt_regs *regs, unsigned int instr)
 	regs->nip = truncate_if_32bit(regs->msr, regs->nip + 4);
 	return 1;
 }
+NOKPROBE_SYMBOL(emulate_step);
-- 
2.12.1
