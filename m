Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tSckB6MC7zDvp2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2016 19:52:18 +1100 (AEDT)
Message-Id: <e05f3a6fe3534a454ffc4a9ef45da89337bf9285.1480408631.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1480408630.git.christophe.leroy@c-s.fr>
References: <cover.1480408630.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 2/2] powerpc/8xx: Implement hw_breakpoint
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Tue, 29 Nov 2016 09:52:15 +0100 (CET)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch implements HW breakpoint on the 8xx. The 8xx has
capability to manage HW breakpoints, which is slightly different
than BOOK3S:
1/ The breakpoint match doesn't trigger a DSI exception but a
dedicated data breakpoint exception.
2/ The breakpoint happens after the instruction has completed,
no need to single step or emulate the instruction,
3/ Matched address is not set in DAR but in BAR,
4/ DABR register doesn't exist, instead we have registers
LCTRL1, LCTRL2 and CMPx registers,
5/ The match on one comparator is not on a double word but
on a single word.

The patch does:
1/ Prepare the dedicated registers in call to __set_dabr(). In order
to emulate the double word handling of BOOK3S, comparator E is set to
DABR address value and comparator F to address + 4. Then breakpoint 1
is set to match comparator E or F,
2/ Skip the singlestepping stage when compiled for CONFIG_PPC_8xx,
3/ Implement the exception. In that exception, the matched address
is taken from SPRN_BAR and manage as if it was from SPRN_DAR.
4/ I/D TLB error exception routines perform a tlbie on bad TLBs. That
tlbie triggers the breakpoint exception when performed on the
breakpoint address. For this reason, the routine returns if the match
is from one of those two tlbie.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/Kconfig                |  2 +-
 arch/powerpc/include/asm/reg_8xx.h  |  7 +++++++
 arch/powerpc/kernel/head_8xx.S      | 28 +++++++++++++++++++++++++++-
 arch/powerpc/kernel/hw_breakpoint.c |  6 +++++-
 arch/powerpc/kernel/process.c       | 22 ++++++++++++++++++++++
 5 files changed, 62 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 5b736e4..75459cf 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -113,7 +113,7 @@ config PPC
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
 	select HAVE_REGS_AND_STACK_ACCESS_API
-	select HAVE_HW_BREAKPOINT if PERF_EVENTS && PPC_BOOK3S
+	select HAVE_HW_BREAKPOINT if PERF_EVENTS && (PPC_BOOK3S || PPC_8xx)
 	select ARCH_WANT_IPC_PARSE_VERSION
 	select SPARSE_IRQ
 	select IRQ_DOMAIN
diff --git a/arch/powerpc/include/asm/reg_8xx.h b/arch/powerpc/include/asm/reg_8xx.h
index 0197e12..8c5c7f2 100644
--- a/arch/powerpc/include/asm/reg_8xx.h
+++ b/arch/powerpc/include/asm/reg_8xx.h
@@ -29,6 +29,13 @@
 #define SPRN_EIE	80	/* External interrupt enable (EE=1, RI=1) */
 #define SPRN_EID	81	/* External interrupt disable (EE=0, RI=1) */
 
+/* Debug registers */
+#define SPRN_CMPE	152
+#define SPRN_CMPF	153
+#define SPRN_LCTRL1	156
+#define SPRN_LCTRL2	157
+#define SPRN_BAR	159
+
 /* Commands.  Only the first few are available to the instruction cache.
 */
 #define	IDC_ENABLE	0x02000000	/* Cache enable */
diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index fb133a1..d4f3335 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -478,6 +478,7 @@ InstructionTLBError:
 	andis.	r10,r5,0x4000
 	beq+	1f
 	tlbie	r4
+itlbie:
 	/* 0x400 is InstructionAccess exception, needed by bad_page_fault() */
 1:	EXC_XFER_LITE(0x400, handle_page_fault)
 
@@ -502,6 +503,7 @@ DARFixed:/* Return from dcbx instruction bug workaround */
 	andis.	r10,r5,0x4000
 	beq+	1f
 	tlbie	r4
+dtlbie:
 1:	li	r10,RPN_PATTERN
 	mtspr	SPRN_DAR,r10	/* Tag DAR, to be used in DTLB Error */
 	/* 0x300 is DataAccess exception, needed by bad_page_fault() */
@@ -519,7 +521,27 @@ DARFixed:/* Return from dcbx instruction bug workaround */
  * support of breakpoints and such.  Someday I will get around to
  * using them.
  */
-	EXCEPTION(0x1c00, Trap_1c, unknown_exception, EXC_XFER_EE)
+	. = 0x1c00
+DataBreakpoint:
+	EXCEPTION_PROLOG_0
+	mfcr	r10
+	mfspr	r11, SPRN_SRR0
+	cmplwi	cr0, r11, (dtlbie - PAGE_OFFSET)@l
+	cmplwi	cr7, r11, (itlbie - PAGE_OFFSET)@l
+	beq-	cr0, 11f
+	beq-	cr7, 11f
+	EXCEPTION_PROLOG_1
+	EXCEPTION_PROLOG_2
+	addi	r3,r1,STACK_FRAME_OVERHEAD
+	mfspr	r4,SPRN_BAR
+	stw	r4,_DAR(r11)
+	mfspr	r5,SPRN_DSISR
+	EXC_XFER_EE(0x1c00, do_break)
+11:
+	mtcr	r10
+	EXCEPTION_EPILOG_0
+	rfi
+
 	EXCEPTION(0x1d00, Trap_1d, unknown_exception, EXC_XFER_EE)
 	EXCEPTION(0x1e00, Trap_1e, unknown_exception, EXC_XFER_EE)
 	EXCEPTION(0x1f00, Trap_1f, unknown_exception, EXC_XFER_EE)
@@ -870,6 +892,10 @@ initial_mmu:
 	lis	r8, IDC_ENABLE@h
 	mtspr	SPRN_DC_CST, r8
 #endif
+	/* Disable debug mode entry on data breakpoints */
+	mfspr	r8, SPRN_DER
+	rlwinm	r8, r8, 0, ~0x8
+	mtspr	SPRN_DER, r8
 	blr
 
 
diff --git a/arch/powerpc/kernel/hw_breakpoint.c b/arch/powerpc/kernel/hw_breakpoint.c
index 03d089b..4b70a53 100644
--- a/arch/powerpc/kernel/hw_breakpoint.c
+++ b/arch/powerpc/kernel/hw_breakpoint.c
@@ -211,9 +211,11 @@ int hw_breakpoint_handler(struct die_args *args)
 	int rc = NOTIFY_STOP;
 	struct perf_event *bp;
 	struct pt_regs *regs = args->regs;
+#ifndef CONFIG_PPC_8xx
 	int stepped = 1;
-	struct arch_hw_breakpoint *info;
 	unsigned int instr;
+#endif
+	struct arch_hw_breakpoint *info;
 	unsigned long dar = regs->dar;
 
 	/* Disable breakpoints during exception handling */
@@ -255,6 +257,7 @@ int hw_breakpoint_handler(struct die_args *args)
 	      (dar - bp->attr.bp_addr < bp->attr.bp_len)))
 		info->type |= HW_BRK_TYPE_EXTRANEOUS_IRQ;
 
+#ifndef CONFIG_PPC_8xx
 	/* Do not emulate user-space instructions, instead single-step them */
 	if (user_mode(regs)) {
 		current->thread.last_hit_ubp = bp;
@@ -278,6 +281,7 @@ int hw_breakpoint_handler(struct die_args *args)
 		perf_event_disable_inatomic(bp);
 		goto out;
 	}
+#endif
 	/*
 	 * As a policy, the callback is invoked in a 'trigger-after-execute'
 	 * fashion
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 04885ce..2dcb65f 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -736,6 +736,28 @@ static inline int __set_dabr(unsigned long dabr, unsigned long dabrx)
 		mtspr(SPRN_DABRX, dabrx);
 	return 0;
 }
+#elif defined(CONFIG_PPC_8xx)
+static inline int __set_dabr(unsigned long dabr, unsigned long dabrx)
+{
+	unsigned long addr = dabr & ~HW_BRK_TYPE_DABR;
+	unsigned long lctrl1 = 0x90000000; /* compare type: equal on E & F */
+	unsigned long lctrl2 = 0x8e000002; /* watchpoint 1 on cmp E | F */
+
+	if ((dabr & HW_BRK_TYPE_RDWR) == HW_BRK_TYPE_READ)
+		lctrl1 |= 0xa0000;
+	else if ((dabr & HW_BRK_TYPE_RDWR) == HW_BRK_TYPE_WRITE)
+		lctrl1 |= 0xf0000;
+	else if ((dabr & HW_BRK_TYPE_RDWR) == 0)
+		lctrl2 = 0;
+
+	mtspr(SPRN_LCTRL2, 0);
+	mtspr(SPRN_CMPE, addr);
+	mtspr(SPRN_CMPF, addr + 4);
+	mtspr(SPRN_LCTRL1, lctrl1);
+	mtspr(SPRN_LCTRL2, lctrl2);
+
+	return 0;
+}
 #else
 static inline int __set_dabr(unsigned long dabr, unsigned long dabrx)
 {
-- 
2.10.1
