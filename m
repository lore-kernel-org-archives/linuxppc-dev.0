Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6E6161A089C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jun 2014 18:48:06 +1000 (EST)
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 7FC371400E0
 for <linuxppc-dev@ozlabs.org>; Wed, 11 Jun 2014 18:48:05 +1000 (EST)
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Wed, 11 Jun 2014 14:18:02 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 2CCE4125805E
 for <linuxppc-dev@ozlabs.org>; Wed, 11 Jun 2014 14:17:23 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s5B8moXW56557762
 for <linuxppc-dev@ozlabs.org>; Wed, 11 Jun 2014 14:18:50 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s5B8luSC022803
 for <linuxppc-dev@ozlabs.org>; Wed, 11 Jun 2014 14:17:57 +0530
Subject: [PATCH 1/4] powerpc/book3s: Fix machine check handling for
 unhandled errors
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 11 Jun 2014 14:17:56 +0530
Message-ID: <20140611084756.9634.82266.stgit@mars.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Michael Neuling <mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

Current code does not check for unhandled/unrecovered errors and return from
interrupt if it is recoverable exception which in-turn triggers same machine
check exception in a loop causing hypervisor to be unresponsive.

This patch fixes this situation and forces hypervisor to panic for
unhandled/unrecovered errors.

This patch also fixes another issue where unrecoverable_exception routine
was called in real mode in case of unrecoverable exception (MSR_RI = 0).
This causes another exception vector 0x300 (data access) during system crash
leading to confusion while debugging cause of the system crash.

Also turn ME bit off while going down, so that when another MCE is hit during
panic path, system will checkstop and hypervisor will get restarted cleanly
by SP.

With the above fixes we now throw correct console messages (see below) while
crashing the system in case of unhandled/unrecoverable machine checks.

--------------
Severe Machine check interrupt [[Not recovered]
  Initiator: CPU
  Error type: UE [Instruction fetch]
    Effective address: 0000000030002864
Oops: Machine check, sig: 7 [#1]
SMP NR_CPUS=2048 NUMA PowerNV
Modules linked in: bork(O) bridge stp llc kvm [last unloaded: bork]
CPU: 36 PID: 55162 Comm: bash Tainted: G           O 3.14.0mce #1
task: c000002d72d022d0 ti: c000000007ec0000 task.ti: c000002d72de4000
NIP: 0000000030002864 LR: 00000000300151a4 CTR: 000000003001518c
REGS: c000000007ec3d80 TRAP: 0200   Tainted: G           O  (3.14.0mce)
MSR: 9000000000041002 <SF,HV,ME,RI>  CR: 28222848  XER: 20000000
CFAR: 0000000030002838 DAR: d0000000004d0000 DSISR: 00000000 SOFTE: 1
GPR00: 000000003001512c 0000000031f92cb0 0000000030078af0 0000000030002864
GPR04: d0000000004d0000 0000000000000000 0000000030002864 ffffffffffffffc9
GPR08: 0000000000000024 0000000030008af0 000000000000002c c00000000150e728
GPR12: 9000000000041002 0000000031f90000 0000000010142550 0000000040000000
GPR16: 0000000010143cdc 0000000000000000 00000000101306fc 00000000101424dc
GPR20: 00000000101424e0 000000001013c6f0 0000000000000000 0000000000000000
GPR24: 0000000010143ce0 00000000100f6440 c000002d72de7e00 c000002d72860250
GPR28: c000002d72860240 c000002d72ac0038 0000000000000008 0000000000040000
NIP [0000000030002864] 0x30002864
LR [00000000300151a4] 0x300151a4
Call Trace:
Instruction dump:
XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
---[ end trace 7285f0beac1e29d3 ]---

Sending IPI to other CPUs
IPI complete
OPAL V3 detected !
--------------

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/exceptions-64s.S |   40 +++++++++++++++++++++++++++++++---
 1 file changed, 37 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 20f11eb..274a86d 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1389,6 +1389,7 @@ machine_check_handle_early:
 	bl	save_nvgprs
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	bl	machine_check_early
+	std	r3,RESULT(r1)	/* Save result */
 	ld	r12,_MSR(r1)
 #ifdef	CONFIG_PPC_P7_NAP
 	/*
@@ -1443,11 +1444,33 @@ machine_check_handle_early:
 	 */
 	andi.	r11,r12,MSR_RI
 	bne	2f
-1:	addi	r3,r1,STACK_FRAME_OVERHEAD
-	bl	unrecoverable_exception
-	b	1b
+1:	mfspr	r11,SPRN_SRR0
+	ld	r10,PACAKBASE(r13)
+	LOAD_HANDLER(r10,unrecover_mce)
+	mtspr	SPRN_SRR0,r10
+	ld	r10,PACAKMSR(r13)
+	/*
+	 * We are going down. But there are chances that we might get hit by
+	 * another MCE during panic path and we may run into unstable state
+	 * with no way out. Hence, turn ME bit off while going down, so that
+	 * when another MCE is hit during panic path, system will checkstop
+	 * and hypervisor will get restarted cleanly by SP.
+	 */
+	li	r3,MSR_ME
+	andc	r10,r10,r3		/* Turn off MSR_ME */
+	mtspr	SPRN_SRR1,r10
+	rfid
+	b	.
 2:
 	/*
+	 * Check if we have successfully handled/recovered from error, if not
+	 * then stay on emergency stack and panic.
+	 */
+	ld	r3,RESULT(r1)	/* Load result */
+	cmpdi	r3,0		/* see if we handled MCE successfully */
+
+	beq	1b		/* if !handled then panic */
+	/*
 	 * Return from MC interrupt.
 	 * Queue up the MCE event so that we can log it later, while
 	 * returning from kernel or opal call.
@@ -1460,6 +1483,17 @@ machine_check_handle_early:
 	MACHINE_CHECK_HANDLER_WINDUP
 	b	machine_check_pSeries
 
+unrecover_mce:
+	/* Invoke machine_check_exception to print MCE event and panic. */
+	addi	r3,r1,STACK_FRAME_OVERHEAD
+	bl	.machine_check_exception
+	/*
+	 * We will not reach here. Even if we did, there is no way out. Call
+	 * unrecoverable_exception and die.
+	 */
+1:	addi	r3,r1,STACK_FRAME_OVERHEAD
+	bl	.unrecoverable_exception
+	b	1b
 /*
  * r13 points to the PACA, r9 contains the saved CR,
  * r12 contain the saved SRR1, SRR0 is still ready for return
