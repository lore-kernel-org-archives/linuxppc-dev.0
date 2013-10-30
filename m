Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp06.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D414F2C05A4
 for <linuxppc-dev@ozlabs.org>; Thu, 31 Oct 2013 01:34:37 +1100 (EST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Thu, 31 Oct 2013 00:34:37 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id C98033578050
 for <linuxppc-dev@ozlabs.org>; Thu, 31 Oct 2013 01:34:35 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r9UEH4dE7471370
 for <linuxppc-dev@ozlabs.org>; Thu, 31 Oct 2013 01:17:04 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r9UEYZD5009819
 for <linuxppc-dev@ozlabs.org>; Thu, 31 Oct 2013 01:34:35 +1100
Subject: [RFC PATCH v5 04/12] powerpc/book3s: Return from interrupt if coming
 from evil context.
To: linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Wed, 30 Oct 2013 20:04:31 +0530
Message-ID: <20131030143431.26643.92502.stgit@mars>
In-Reply-To: <20131030143219.26643.24782.stgit@mars>
References: <20131030143219.26643.24782.stgit@mars>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Jeremy Kerr <jeremy.kerr@au1.ibm.com>, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

We can get machine checks from any context. We need to make sure that
we handle all of them correctly. If we are coming from hypervisor user-space,
we can continue in host kernel in virtual mode to deliver the MC event.
If we got woken up from power-saving mode then we may come in with one of
the following state:
 a. No state loss
 b. Supervisor state loss
 c. Hypervisor state loss
For (a) and (b), we go back to nap again. State (c) is fatal, keep spinning.

For all other context which we not sure of queue up the MCE event and return
from the interrupt.

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/exceptions-64s.S |   82 ++++++++++++++++++++++++++++++++++
 arch/powerpc/kernel/idle_power7.S    |    1 
 2 files changed, 83 insertions(+)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index fffb16f..9595a82 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -155,6 +155,24 @@ machine_check_pSeries_1:
 	 */
 	HMT_MEDIUM_PPR_DISCARD
 	SET_SCRATCH0(r13)		/* save r13 */
+#ifdef CONFIG_PPC_P7_NAP
+BEGIN_FTR_SECTION
+	/* Running native on arch 2.06 or later, check if we are
+	 * waking up from nap. We only handle no state loss and
+	 * supervisor state loss. We do -not- handle hypervisor
+	 * state loss at this time.
+	 */
+	mfspr	r13,SPRN_SRR1
+	rlwinm.	r13,r13,47-31,30,31
+	beq	9f
+
+	/* waking up from powersave (nap) state */
+	cmpwi	cr1,r13,2
+	/* Total loss of HV state is fatal. let's just stay stuck here */
+	bgt	cr1,.
+9:
+END_FTR_SECTION_IFSET(CPU_FTR_HVMODE | CPU_FTR_ARCH_206)
+#endif /* CONFIG_PPC_P7_NAP */
 	EXCEPTION_PROLOG_0(PACA_EXMC)
 BEGIN_FTR_SECTION
 	b	machine_check_pSeries_early
@@ -792,6 +810,70 @@ BEGIN_FTR_SECTION
 	bl	.save_nvgprs
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	bl	.machine_check_early
+	ld	r12,_MSR(r1)
+#ifdef	CONFIG_PPC_P7_NAP
+	/*
+	 * Check if thread was in power saving mode. We come here when any
+	 * of the following is true:
+	 * a. thread wasn't in power saving mode
+	 * b. thread was in power saving mode with no state loss or
+	 *    supervisor state loss
+	 *
+	 * Go back to nap again if (b) is true.
+	 */
+	rlwinm.	r11,r12,47-31,30,31	/* Was it in power saving mode? */
+	beq	4f			/* No, it wasn;t */
+	/* Thread was in power saving mode. Go back to nap again. */
+	cmpwi	r11,2
+	bne	3f
+	/* Supervisor state loss */
+	li	r0,1
+	stb	r0,PACA_NAPSTATELOST(r13)
+3:	MACHINE_CHECK_HANDLER_WINDUP
+	GET_PACA(r13)
+	ld	r1,PACAR1(r13)
+	b	.power7_enter_nap_mode
+4:
+#endif
+	/*
+	 * Check if we are coming from hypervisor userspace. If yes then we
+	 * continue in host kernel in V mode to deliver the MC event.
+	 */
+	rldicl.	r11,r12,4,63		/* See if MC hit while in HV mode. */
+	beq	5f
+	andi.	r11,r12,MSR_PR		/* See if coming from user. */
+	bne	9f			/* continue in V mode if we are. */
+
+5:
+#ifdef CONFIG_KVM_BOOK3S_64_HV
+	/*
+	 * We are coming from kernel context. Check if we are coming from
+	 * guest. if yes, then we can continue. We will fall through
+	 * do_kvm_200->kvmppc_interrupt to deliver the MC event to guest.
+	 */
+	lbz	r11,HSTATE_IN_GUEST(r13)
+	cmpwi	r11,0			/* Check if coming from guest */
+	bne	9f			/* continue if we are. */
+#endif
+	/*
+	 * At this point we are not sure about what context we come from.
+	 * Queue up the MCE event and return from the interrupt.
+	 * But before that, check if this is an un-recoverable exception.
+	 * If yes, then stay on emergency stack and panic.
+	 */
+	andi.	r11,r12,MSR_RI
+	bne	2f
+1:	addi	r3,r1,STACK_FRAME_OVERHEAD
+	bl	.unrecoverable_exception
+	b	1b
+2:
+	/*
+	 * Return from MC interrupt.
+	 * TODO: Queue up the MCE event so that we can log it later.
+	 */
+	MACHINE_CHECK_HANDLER_WINDUP
+	rfid
+9:
 	/* Deliver the machine check to host kernel in V mode. */
 	MACHINE_CHECK_HANDLER_WINDUP
 	b	machine_check_pSeries
diff --git a/arch/powerpc/kernel/idle_power7.S b/arch/powerpc/kernel/idle_power7.S
index e11863f..c4b384d 100644
--- a/arch/powerpc/kernel/idle_power7.S
+++ b/arch/powerpc/kernel/idle_power7.S
@@ -84,6 +84,7 @@ _GLOBAL(power7_nap)
 	std	r9,_MSR(r1)
 	std	r1,PACAR1(r13)
 
+_GLOBAL(power7_enter_nap_mode)
 #ifdef CONFIG_KVM_BOOK3S_64_HV
 	/* Tell KVM we're napping */
 	li	r4,KVM_HWTHREAD_IN_NAP
