Return-Path: <benh@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Benjamin Herrenschmidt <benh@ozlabs.org>
Date: Wed, 02 Apr 2008 15:58:40 +1100
Subject: [PATCH] [POWERPC] Fix iSeries hard irq enabling regression
Message-Id: <20080402045924.12CA6DDE0A@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

A subtle bug sneaked into iSeries recently. On this platform, we
must not normally clear MSR:EE unless it's for short periods of
time. Taking an interrupt while soft-disabled doesn't cause us to
clear it for example.

The iSeries kernel expects to mostly run with MSR:EE enabled at
all times except a few exception entry/exit code path. Thus
local_irq_enable() doesn't check if it needs to hard-enable as
it expects this to be unnecessary on iSeries.

However, hard_irq_disable() _does_ cause MSR:EE to be cleared,
including on iSeries. A call to it was recently added to the
context switch code, thus causing interrupts to become disabled
for a long period of time, causing the iSeries watchdog to kick
in under some circumstances and other nasty things.

This patch fixes it by making local_irq_enable() properly re-enable
MSR:EE on iSeries. It basically removes a return statement here
to make iSeries use the same code path as everybody else. That does
mean that we might occasionally get spurrious decrementer interrupts
but I don't think that matters.

Another option would have been to make hard_irq_disable() a nop
on iSeries but I didn't like it much, in case we have good reasons
to hard-disable.

Part of the patch is fixes to make sure the hard_enabled PACA field
is properly set on iSeries as it used not to be before, since it
was mostly unused.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
--

 arch/powerpc/kernel/head_64.S |   13 +++++++------
 arch/powerpc/kernel/irq.c     |    1 -
 2 files changed, 7 insertions(+), 7 deletions(-)

--- linux-work.orig/arch/powerpc/kernel/head_64.S	2008-04-02 15:47:20.000000000 +1100
+++ linux-work/arch/powerpc/kernel/head_64.S	2008-04-02 15:48:50.000000000 +1100
@@ -1387,12 +1387,14 @@ __secondary_start:
 #ifdef CONFIG_PPC_ISERIES
 BEGIN_FW_FTR_SECTION
 	ori	r4,r4,MSR_EE
+	li	r8,1
+	stb	r8,PACAHARDIRQEN(r13)
 END_FW_FTR_SECTION_IFSET(FW_FEATURE_ISERIES)
 #endif
 BEGIN_FW_FTR_SECTION
-	stb	r7,PACASOFTIRQEN(r13)
 	stb	r7,PACAHARDIRQEN(r13)
 END_FW_FTR_SECTION_IFCLR(FW_FEATURE_ISERIES)
+	stb	r7,PACASOFTIRQEN(r13)
 
 	mtspr	SPRN_SRR0,r3
 	mtspr	SPRN_SRR1,r4
@@ -1520,15 +1522,14 @@ _INIT_GLOBAL(start_here_common)
 #ifdef CONFIG_PPC_ISERIES
 BEGIN_FW_FTR_SECTION
 	mfmsr	r5
-	ori	r5,r5,MSR_EE		/* Hard Enabled */
+	ori	r5,r5,MSR_EE		/* Hard Enabled on iSeries*/
 	mtmsrd	r5
+	li	r5,1
 END_FW_FTR_SECTION_IFSET(FW_FEATURE_ISERIES)
 #endif
-BEGIN_FW_FTR_SECTION
-	stb	r5,PACAHARDIRQEN(r13)
-END_FW_FTR_SECTION_IFCLR(FW_FEATURE_ISERIES)
+	stb	r5,PACAHARDIRQEN(r13)	/* Hard Disabled on others */
 
-	bl .start_kernel
+	bl	.start_kernel
 
 	/* Not reached */
 	BUG_OPCODE
Index: linux-work/arch/powerpc/kernel/irq.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/irq.c	2008-04-02 15:46:34.000000000 +1100
+++ linux-work/arch/powerpc/kernel/irq.c	2008-04-02 15:46:37.000000000 +1100
@@ -143,7 +143,6 @@ void local_irq_restore(unsigned long en)
 		 */
 		if (local_paca->lppaca_ptr->int_dword.any_int)
 			iseries_handle_interrupts();
-		return;
 	}
 
 	/*
