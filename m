Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <431bd20fec52ff41fb47808954993ab6369eb45e.1302249358.git.michael@ellerman.id.au>
In-Reply-To: <ca7cc2a36bbf492c11cd98d3d1dea0835731c75f.1302249358.git.michael@ellerman.id.au>
References: <ca7cc2a36bbf492c11cd98d3d1dea0835731c75f.1302249358.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 2/3] powerpc: Use MSR_64BIT in places
Date: Fri,  8 Apr 2011 17:56:03 +1000 (EST)
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use the new MSR_64BIT in a few places. Some of these are already ifdef'ed
for BOOKE vs BOOKS, but it's still clearer, MSR_SF does not immediately
parse as "MSR bit for 64bit".

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/kernel/head_64.S   |    2 +-
 arch/powerpc/kernel/signal_64.c |    4 ++--
 arch/powerpc/kernel/traps.c     |    2 +-
 arch/powerpc/xmon/xmon.c        |   14 +++++++-------
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index 271140b..e7e03f8 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -645,7 +645,7 @@ _GLOBAL(enable_64b_mode)
 	oris	r11,r11,0x8000		/* CM bit set, we'll set ICM later */
 	mtmsr	r11
 #else /* CONFIG_PPC_BOOK3E */
-	li	r12,(MSR_SF | MSR_ISF)@highest
+	li	r12,(MSR_64BIT | MSR_ISF)@highest
 	sldi	r12,r12,48
 	or	r11,r11,r12
 	mtmsrd	r11
diff --git a/arch/powerpc/kernel/signal_64.c b/arch/powerpc/kernel/signal_64.c
index 27c4a45..da989ff 100644
--- a/arch/powerpc/kernel/signal_64.c
+++ b/arch/powerpc/kernel/signal_64.c
@@ -381,7 +381,7 @@ badframe:
 	       regs, uc, &uc->uc_mcontext);
 #endif
 	if (show_unhandled_signals && printk_ratelimit())
-		printk(regs->msr & MSR_SF ? fmt64 : fmt32,
+		printk(regs->msr & MSR_64BIT ? fmt64 : fmt32,
 			current->comm, current->pid, "rt_sigreturn",
 			(long)uc, regs->nip, regs->link);
 
@@ -469,7 +469,7 @@ badframe:
 	       regs, frame, newsp);
 #endif
 	if (show_unhandled_signals && printk_ratelimit())
-		printk(regs->msr & MSR_SF ? fmt64 : fmt32,
+		printk(regs->msr & MSR_64BIT ? fmt64 : fmt32,
 			current->comm, current->pid, "setup_rt_frame",
 			(long)frame, regs->nip, regs->link);
 
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index bd74fac..443353a 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -199,7 +199,7 @@ void _exception(int signr, struct pt_regs *regs, int code, unsigned long addr)
 	} else if (show_unhandled_signals &&
 		    unhandled_signal(current, signr) &&
 		    printk_ratelimit()) {
-			printk(regs->msr & MSR_SF ? fmt64 : fmt32,
+			printk(regs->msr & MSR_64BIT ? fmt64 : fmt32,
 				current->comm, current->pid, signr,
 				addr, regs->nip, regs->link, code);
 		}
diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 33794c1..ef9756e 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -399,7 +399,7 @@ static int xmon_core(struct pt_regs *regs, int fromipi)
 	cpu_set(cpu, cpus_in_xmon);
 
 	bp = NULL;
-	if ((regs->msr & (MSR_IR|MSR_PR|MSR_SF)) == (MSR_IR|MSR_SF))
+	if ((regs->msr & (MSR_IR|MSR_PR|MSR_64BIT)) == (MSR_IR|MSR_64BIT))
 		bp = at_breakpoint(regs->nip);
 	if (bp || unrecoverable_excp(regs))
 		fromipi = 0;
@@ -529,7 +529,7 @@ static int xmon_core(struct pt_regs *regs, int fromipi)
 		}
 	}
 #else
-	if ((regs->msr & (MSR_IR|MSR_PR|MSR_SF)) == (MSR_IR|MSR_SF)) {
+	if ((regs->msr & (MSR_IR|MSR_PR|MSR_64BIT)) == (MSR_IR|MSR_64BIT)) {
 		bp = at_breakpoint(regs->nip);
 		if (bp != NULL) {
 			int stepped = emulate_step(regs, bp->instr[0]);
@@ -578,7 +578,7 @@ static int xmon_bpt(struct pt_regs *regs)
 	struct bpt *bp;
 	unsigned long offset;
 
-	if ((regs->msr & (MSR_IR|MSR_PR|MSR_SF)) != (MSR_IR|MSR_SF))
+	if ((regs->msr & (MSR_IR|MSR_PR|MSR_64BIT)) != (MSR_IR|MSR_64BIT))
 		return 0;
 
 	/* Are we at the trap at bp->instr[1] for some bp? */
@@ -609,7 +609,7 @@ static int xmon_sstep(struct pt_regs *regs)
 
 static int xmon_dabr_match(struct pt_regs *regs)
 {
-	if ((regs->msr & (MSR_IR|MSR_PR|MSR_SF)) != (MSR_IR|MSR_SF))
+	if ((regs->msr & (MSR_IR|MSR_PR|MSR_64BIT)) != (MSR_IR|MSR_64BIT))
 		return 0;
 	if (dabr.enabled == 0)
 		return 0;
@@ -619,7 +619,7 @@ static int xmon_dabr_match(struct pt_regs *regs)
 
 static int xmon_iabr_match(struct pt_regs *regs)
 {
-	if ((regs->msr & (MSR_IR|MSR_PR|MSR_SF)) != (MSR_IR|MSR_SF))
+	if ((regs->msr & (MSR_IR|MSR_PR|MSR_64BIT)) != (MSR_IR|MSR_64BIT))
 		return 0;
 	if (iabr == NULL)
 		return 0;
@@ -644,7 +644,7 @@ static int xmon_fault_handler(struct pt_regs *regs)
 	if (in_xmon && catch_memory_errors)
 		handle_fault(regs);	/* doesn't return */
 
-	if ((regs->msr & (MSR_IR|MSR_PR|MSR_SF)) == (MSR_IR|MSR_SF)) {
+	if ((regs->msr & (MSR_IR|MSR_PR|MSR_64BIT)) == (MSR_IR|MSR_64BIT)) {
 		bp = in_breakpoint_table(regs->nip, &offset);
 		if (bp != NULL) {
 			regs->nip = bp->address + offset;
@@ -929,7 +929,7 @@ static int do_step(struct pt_regs *regs)
 	int stepped;
 
 	/* check we are in 64-bit kernel mode, translation enabled */
-	if ((regs->msr & (MSR_SF|MSR_PR|MSR_IR)) == (MSR_SF|MSR_IR)) {
+	if ((regs->msr & (MSR_64BIT|MSR_PR|MSR_IR)) == (MSR_64BIT|MSR_IR)) {
 		if (mread(regs->nip, &instr, 4) == 4) {
 			stepped = emulate_step(regs, instr);
 			if (stepped < 0) {
-- 
1.7.1
