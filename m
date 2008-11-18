Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.125]) by ozlabs.org (Postfix) with ESMTP id 9383CDDE1A
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Nov 2008 12:34:04 +1100 (EST)
Message-Id: <20081118013402.002336279@goodmis.org>
References: <20081118013212.470074567@goodmis.org>
Date: Mon, 17 Nov 2008 20:32:13 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] ftrace,ppc64: do not use nops for modules
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Pekka Paalanen <pq@iki.fi>, miltonm@bga.com,
	David Miller <davem@davemloft.net>, linuxppc-dev@ozlabs.org,
	Steven Rostedt <srostedt@redhat.com>, Paul Mundt <lethal@linux-sh.org>,
	Paul Mackerras <paulus@samba.org>,
	Frederic Weisbecker <fweisbec@gmail.com>, Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Impact: fix PPC64 race condition

Milton Miller pointed out a nasty race with the current code of PPC64
dynamic ftrace.  PPC64 keeps a table of content reference in the register
r2. If this gets corrupted, the kernel can crash. The calls to mcount are
replaced with nops. This is not the problem. The problem arises when we
start a trace and we can modify this code after preempting a function
being traced. Lets look at the assembly:

Origin code:

  bl <mcount-trampoline>
  ld r2,40(r1)

The mcount-trampoline includes this code:

  std r2,40(r1)
  ld  r11,32(r12)  <- 12 holds information on the jump.
  ld  r2,40(r12)
  mtctr r11
  bctr r11

We see that the trampoline stores the original TOC in the stack, replaces
the TOC with the target jump and then jumps to the target. The link
register will jump directly back to the code that called the trampoline.

But if we replace the ld r2,40(r1) as a nop and a function has been
preempted while tracing, on return, we never update the r2 back to
the module's TOC.

Milton Miller suggested instead of replacing the code with nops, to
replace the bl <mcount-trampoline> with a "b 8". Hence we would end
up with this code:

  b 1f
  ld r2,40(r1)
1:

Any new callers would not change their r2 TOC register, and any callers
that have been preempted will still return to their original TOC.

But a branch has slightly more overhead than a plain nop. Since the
first change is done before the module ever runs, there are no
race conditions. For the first change, I convert the code to nops,
only if they point to mcount. After that I convert the code to the branch.
The code only points to mcount on start up, and will point to
ftrace_caller when a trace is started.

Reported-by: Milton Miller <miltonm@bga.com>
Signed-off-by: Steven Rostedt <srostedt@redhat.com>
---
 arch/powerpc/kernel/ftrace.c |   44 +++++++++++++++++++++++++++++++++++------
 1 files changed, 37 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/kernel/ftrace.c b/arch/powerpc/kernel/ftrace.c
index cc901b1..50a3246 100644
--- a/arch/powerpc/kernel/ftrace.c
+++ b/arch/powerpc/kernel/ftrace.c
@@ -158,6 +158,9 @@ static unsigned int branch_offset(unsigned long offset)
 }
 
 #ifdef CONFIG_PPC64
+/* static variable to not confuse recordmcount.pl script */
+static const unsigned long mcount_addr = MCOUNT_ADDR;
+
 static int
 __ftrace_make_nop(struct module *mod,
 		  struct dyn_ftrace *rec, unsigned long addr)
@@ -168,7 +171,7 @@ __ftrace_make_nop(struct module *mod,
 	unsigned long *ptr = (unsigned long *)&jmp;
 	unsigned long ip = rec->ip;
 	unsigned long tramp;
-	int offset;
+	int offset, size;
 
 	/* read where this goes */
 	if (probe_kernel_read(replaced, (void *)ip, MCOUNT_INSN_SIZE))
@@ -248,10 +251,34 @@ __ftrace_make_nop(struct module *mod,
 		return -EINVAL;
 	}
 
-	op[0] = PPC_NOP_INSTR;
-	op[1] = PPC_NOP_INSTR;
+	/*
+	 * Milton Miller pointed out that we can not blindly do nops.
+	 * If a task was preempted when calling a trace function,
+	 * the nops will remove the way to restore the TOC in r2
+	 * and the r2 TOC will get corrupted.
+	 *
+	 * But, we only need to do that on shutdown of the tracer,
+	 * if the pointer is still to mcount, then this is being called
+	 * from initialization code, and we do not need to worry about
+	 * races. NOPs are a tiny bit faster than a branch, so use that first.
+	 * Why punish those that never start a trace.
+	 */
+	if (addr == (unsigned long)mcount_addr) {
+		op[0] = PPC_NOP_INSTR;
+		op[1] = PPC_NOP_INSTR;
+		size = MCOUNT_INSN_SIZE * 2;
+	} else {
+		/*
+		 * Replace with:
+		 *   bl <tramp>  <<<<< replace by "b 1f"
+		 *   ld r2,40(r1)
+		 *  1:
+		 */
+		op[0] = 0x48000008;	/* b +8 */
+		size = MCOUNT_INSN_SIZE;
+	}
 
-	if (probe_kernel_write((void *)ip, replaced, MCOUNT_INSN_SIZE * 2))
+	if (probe_kernel_write((void *)ip, replaced, size))
 		return -EPERM;
 
 	return 0;
@@ -381,9 +408,12 @@ __ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
 	if (probe_kernel_read(replaced, (void *)ip, MCOUNT_INSN_SIZE * 2))
 		return -EFAULT;
 
-	/* It should be pointing to two nops */
-	if ((op[0] != PPC_NOP_INSTR) ||
-	    (op[1] != PPC_NOP_INSTR)) {
+	/*
+	 * It should be pointing to two nops or
+	 *  b +8; ld r2,40(r1)
+	 */
+	if (((op[0] != 0x48000008) || (op[1] != 0xe8410028)) &&
+	    ((op[0] != PPC_NOP_INSTR) || (op[1] != PPC_NOP_INSTR))) {
 		printk(KERN_ERR "Expected NOPs but have %x %x\n", op[0], op[1]);
 		return -EINVAL;
 	}
-- 
1.5.6.5

-- 
