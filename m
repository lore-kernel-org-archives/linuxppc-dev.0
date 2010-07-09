Return-Path: <benh@kernel.crashing.org>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp04.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3626E1007FB
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Jul 2010 16:17:02 +1000 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
	by e23smtp04.au.ibm.com (8.14.4/8.13.1) with ESMTP id o696ChbD006874
	for <linuxppc-dev@ozlabs.org>; Fri, 9 Jul 2010 16:12:43 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o696H1CI1777776
	for <linuxppc-dev@ozlabs.org>; Fri, 9 Jul 2010 16:17:01 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o696H1nl013198
	for <linuxppc-dev@ozlabs.org>; Fri, 9 Jul 2010 16:17:01 +1000
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 06/13] powerpc/book3e: Hookup doorbells exceptions on 64-bit
	Book3E
Date: Fri,  9 Jul 2010 16:16:48 +1000
Message-Id: <1278656215-24705-6-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1278656215-24705-5-git-send-email-benh@kernel.crashing.org>
References: <1278656215-24705-1-git-send-email-benh@kernel.crashing.org>
	<1278656215-24705-2-git-send-email-benh@kernel.crashing.org>
	<1278656215-24705-3-git-send-email-benh@kernel.crashing.org>
	<1278656215-24705-4-git-send-email-benh@kernel.crashing.org>
	<1278656215-24705-5-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Note that critical doorbells are an unimplemented stub just like
other critical or machine check handlers, since we haven't done
support for "levelled" exceptions yet.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/Makefile         |    1 +
 arch/powerpc/kernel/exceptions-64e.S |   21 +++++++++++++++++----
 arch/powerpc/kernel/irq.c            |    7 +++++++
 3 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 0100604..8a33318 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -68,6 +68,7 @@ obj64-$(CONFIG_HIBERNATION)	+= swsusp_asm64.o
 obj-$(CONFIG_MODULES)		+= module.o module_$(CONFIG_WORD_SIZE).o
 obj-$(CONFIG_44x)		+= cpu_setup_44x.o
 obj-$(CONFIG_FSL_BOOKE)		+= cpu_setup_fsl_booke.o dbell.o
+obj-$(CONFIG_PPC_BOOK3E_64)	+= dbell.o
 
 extra-y				:= head_$(CONFIG_WORD_SIZE).o
 extra-$(CONFIG_PPC_BOOK3E_32)	:= head_new_booke.o
diff --git a/arch/powerpc/kernel/exceptions-64e.S b/arch/powerpc/kernel/exceptions-64e.S
index 24dcc0e..a42637c 100644
--- a/arch/powerpc/kernel/exceptions-64e.S
+++ b/arch/powerpc/kernel/exceptions-64e.S
@@ -246,11 +246,9 @@ interrupt_base_book3e:					/* fake trap */
 	EXCEPTION_STUB(0x1a0, watchdog)			/* 0x09f0 */
 	EXCEPTION_STUB(0x1c0, data_tlb_miss)
 	EXCEPTION_STUB(0x1e0, instruction_tlb_miss)
+	EXCEPTION_STUB(0x280, doorbell)
+	EXCEPTION_STUB(0x2a0, doorbell_crit)
 
-#if 0
-	EXCEPTION_STUB(0x280, processor_doorbell)
-	EXCEPTION_STUB(0x220, processor_doorbell_crit)
-#endif
 	.globl interrupt_end_book3e
 interrupt_end_book3e:
 
@@ -428,6 +426,19 @@ interrupt_end_book3e:
 kernel_dbg_exc:
 	b	.	/* NYI */
 
+/* Doorbell interrupt */
+	MASKABLE_EXCEPTION(0x2070, doorbell, .doorbell_exception, ACK_NONE)
+
+/* Doorbell critical Interrupt */
+	START_EXCEPTION(doorbell_crit);
+	CRIT_EXCEPTION_PROLOG(0x2080, PROLOG_ADDITION_NONE)
+//	EXCEPTION_COMMON(0x2080, PACA_EXCRIT, INTS_DISABLE_ALL)
+//	bl	special_reg_save_crit
+//	addi	r3,r1,STACK_FRAME_OVERHEAD
+//	bl	.doorbell_critical_exception
+//	b	ret_from_crit_except
+	b	.
+
 
 /*
  * An interrupt came in while soft-disabled; clear EE in SRR1,
@@ -563,6 +574,8 @@ BAD_STACK_TRAMPOLINE(0xd00)
 BAD_STACK_TRAMPOLINE(0xe00)
 BAD_STACK_TRAMPOLINE(0xf00)
 BAD_STACK_TRAMPOLINE(0xf20)
+BAD_STACK_TRAMPOLINE(0x2070)
+BAD_STACK_TRAMPOLINE(0x2080)
 
 	.globl	bad_stack_book3e
 bad_stack_book3e:
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index fa6f385..2f6dc7f 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -64,6 +64,8 @@
 #include <asm/ptrace.h>
 #include <asm/machdep.h>
 #include <asm/udbg.h>
+#include <asm/dbell.h>
+
 #ifdef CONFIG_PPC64
 #include <asm/paca.h>
 #include <asm/firmware.h>
@@ -153,6 +155,11 @@ notrace void raw_local_irq_restore(unsigned long en)
 	if (get_hard_enabled())
 		return;
 
+#if defined(CONFIG_BOOKE) && defined(CONFIG_SMP)
+	/* Check for pending doorbell interrupts on SMP */
+	doorbell_exception(NULL);
+#endif
+
 	/*
 	 * Need to hard-enable interrupts here.  Since currently disabled,
 	 * no need to take further asm precautions against preemption; but
-- 
1.6.3.3
