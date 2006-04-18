Return-Path: <bgill@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 763DC679FD
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Apr 2006 05:29:46 +1000 (EST)
Date: Tue, 18 Apr 2006 14:29:34 -0500 (CDT)
From: Becky Bruce <bgill@freescale.com>
To: paulus@samba.org
Subject: Re: 7447A strange problem with MSR:POW (WAS: can't boot 2.6.17-rc1)
Message-ID: <Pine.LNX.4.61.0604181416160.15527@cde-tx32-ldt329.sps.mot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, schmitz@zirkon.biophys.uni-duesseldorf.de,
	debian-powerpc@lists.debian.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul,

This new version of the patch breaks 32-bit arch/ppc builds. The changes 
to the idle_6xx code are shared between architectures, but the entry.S 
code and asm-offsets.c are not.  

Here's a patch that puts the changes in arch/ppc as well.  Builds and 
boots on 834x (which is CONFIG_6xx).  

-B

ppc: Fix powersave on arch/ppc

Fix asm_offsets.c and entry.S to work with the new power save code.  
Changes in arch/powerpc needed to exist in arch/ppc as well since the 
idle code is shared by both ppc and powerpc..

Signed-off-by: Becky Bruce <becky.bruce@freescale.com>

---
commit c9b42c4b6ad17aea51066604b70ea7ec399d2e45
tree 38642212d6396ecad721efca967ae1fc8924e096
parent c85f35d06479bf7cb5cfc7cda0ea218a23ed2dc4
author Becky Bruce <becky.bruce@freescale.com> Tue, 18 Apr 2006 14:12:03 -0500
committer Becky Bruce <becky.bruce@freescale.com> Tue, 18 Apr 2006 14:12:03 -0500

 arch/ppc/kernel/asm-offsets.c |    1 +
 arch/ppc/kernel/entry.S       |   33 ++++++++++++++++-----------------
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/arch/ppc/kernel/asm-offsets.c b/arch/ppc/kernel/asm-offsets.c
index 77e4dc7..cc7c4ae 100644
--- a/arch/ppc/kernel/asm-offsets.c
+++ b/arch/ppc/kernel/asm-offsets.c
@@ -134,6 +134,7 @@ main(void)
 	DEFINE(TI_TASK, offsetof(struct thread_info, task));
 	DEFINE(TI_EXECDOMAIN, offsetof(struct thread_info, exec_domain));
 	DEFINE(TI_FLAGS, offsetof(struct thread_info, flags));
+	DEFINE(TI_LOCAL_FLAGS, offsetof(struct thread_info, flags));
 	DEFINE(TI_CPU, offsetof(struct thread_info, cpu));
 	DEFINE(TI_PREEMPT, offsetof(struct thread_info, preempt_count));
 
diff --git a/arch/ppc/kernel/entry.S b/arch/ppc/kernel/entry.S
index 5891ecb..1adc914 100644
--- a/arch/ppc/kernel/entry.S
+++ b/arch/ppc/kernel/entry.S
@@ -128,29 +128,26 @@ transfer_to_handler:
 	stw	r12,4(r11)
 #endif
 	b	3f
+
 2:	/* if from kernel, check interrupted DOZE/NAP mode and
          * check for stack overflow
          */
+	lwz	r9,THREAD_INFO-THREAD(r12)
+	cmplw	r1,r9			/* if r1 <= current->thread_info */
+	ble-	stack_ovf		/* then the kernel stack overflowed */
+5:
 #ifdef CONFIG_6xx
-	mfspr	r11,SPRN_HID0
-	mtcr	r11
-BEGIN_FTR_SECTION
-	bt-	8,4f			/* Check DOZE */
-END_FTR_SECTION_IFSET(CPU_FTR_CAN_DOZE)
-BEGIN_FTR_SECTION
-	bt-	9,4f			/* Check NAP */
-END_FTR_SECTION_IFSET(CPU_FTR_CAN_NAP)
+	tophys(r9,r9)			/* check local flags */
+	lwz	r12,TI_LOCAL_FLAGS(r9)
+	mtcrf	0x01,r12
+	bt-	31-TLF_NAPPING,4f
 #endif /* CONFIG_6xx */
 	.globl transfer_to_handler_cont
 transfer_to_handler_cont:
-	lwz	r11,THREAD_INFO-THREAD(r12)
-	cmplw	r1,r11			/* if r1 <= current->thread_info */
-	ble-	stack_ovf		/* then the kernel stack overflowed */
 3:
 	mflr	r9
 	lwz	r11,0(r9)		/* virtual address of handler */
 	lwz	r9,4(r9)		/* where to go when done */
-	FIX_SRR1(r10,r12)
 	mtspr	SPRN_SRR0,r11
 	mtspr	SPRN_SRR1,r10
 	mtlr	r9
@@ -158,7 +155,9 @@ transfer_to_handler_cont:
 	RFI				/* jump to handler, enable MMU */
 
 #ifdef CONFIG_6xx
-4:	b	power_save_6xx_restore
+4:	rlwinm	r12,r12,0,~_TLF_NAPPING
+	stw	r12,TI_LOCAL_FLAGS(r9)
+	b	power_save_6xx_restore
 #endif
 
 /*
@@ -167,10 +166,10 @@ transfer_to_handler_cont:
  */
 stack_ovf:
 	/* sometimes we use a statically-allocated stack, which is OK. */
-	lis	r11,_end@h
-	ori	r11,r11,_end@l
-	cmplw	r1,r11
-	ble	3b			/* r1 <= &_end is OK */
+	lis	r12,_end@h
+	ori	r12,r12,_end@l
+	cmplw	r1,r12
+	ble	5b			/* r1 <= &_end is OK */
 	SAVE_NVGPRS(r11)
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	lis	r1,init_thread_union@ha
