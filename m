Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp09.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E28C62C0151
 for <linuxppc-dev@ozlabs.org>; Tue, 27 Aug 2013 05:31:53 +1000 (EST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Tue, 27 Aug 2013 16:26:03 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 0C44B2BB004F
 for <linuxppc-dev@ozlabs.org>; Tue, 27 Aug 2013 05:31:52 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r7QJVeB159900000
 for <linuxppc-dev@ozlabs.org>; Tue, 27 Aug 2013 05:31:40 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r7QJVp0T029474
 for <linuxppc-dev@ozlabs.org>; Tue, 27 Aug 2013 05:31:51 +1000
Subject: [RFC PATCH v3 04/12] Validate r1 value before going to host kernel in
 virtual mode.
To: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Tue, 27 Aug 2013 01:01:48 +0530
Message-ID: <20130826193148.2855.95627.stgit@mars>
In-Reply-To: <20130826192616.2855.18749.stgit@mars>
References: <20130826192616.2855.18749.stgit@mars>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Jeremy Kerr <jeremy.kerr@au1.ibm.com>, Paul Mackerras <paulus@samba.org>,
 Anton Blanchard <anton@samba.org>
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
we handle all of them correctly. Once we decode MCE reason and generate
MCE event, we continue in host kernel in virtual mode so that we can
log/display it later. But before going to virtual mode we need to make
sure that r1 points to host kernel stack. But machine check can occur
in any context and r1 may not always point to host kernel stack. In cases
where we can not trust r1 value, we should queue up the MCE event and return
from interrupt. This patch implements the additional checks that helps to
decide whether to deleiver machine check event to host kernel right away
or queue it up and return.

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/exceptions-64s.S |   72 ++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 651a213..d82ebac 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -785,8 +785,78 @@ BEGIN_FTR_SECTION
 	bl	.save_nvgprs
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	bl	.machine_check_early
+
+	/*
+	 * We are now going to host kernel in V mode. We need to make sure
+	 * that r1 points to host kernel stack.
+	 *
+	 * If we are coming from userspace then we can continue in host kernel
+	 * in V mode.
+	 * But if we are coming from kernel and r1 does not point to kernel
+	 * stack then we can not continue, instead we return from here.
+	 */
+
+	ld	r12,_MSR(r1)
+	andi.	r11,r12,MSR_PR		/* See if coming from user. */
+	bne	3f			/* continue if we are. */
+
+#ifdef CONFIG_KVM_BOOK3S_64_HV
+	/*
+	 * We are coming from kernel context. Check if we are coming from
+	 * guest. if yes, then we can continue. We will fall through
+	 * do_kvm_200->kvmppc_interrupt which will setup r1 correctly.
+	 */
+	lbz	r11,HSTATE_IN_GUEST(r13)
+	cmpwi	r11,0			/* Check if coming from guest */
+	bne	3f			/* continue if we are. */
+
+	/*
+	 * So, we did not come from guest. That leaves three possibilities:
+	 * a. We come from secondary thread which just came out of nap and
+	 *    about to call kvm_start_guest.
+	 * b. We come from secondary thread which is about to go to nap
+	 *    state (see kvm_no_guest()).
+	 * c. We come from opal context and r1 may be pointing to opal
+	 *    kernel stack.
+	 */
+
+	lbz	r11,HSTATE_HWTHREAD_STATE(r13)
+	cmpwi	r11,KVM_HWTHREAD_IN_NAP	/* Was it nap-ing? or about to */
+	beq	0f		/* Queue up event and return from interrupt */
+#endif
+
+	/*
+	 * So far we checked all possible situations where we can not
+	 * trust r1. Now we can trust r1.
+	 *	r1 < 0		r1 points to host kernel stack
+	 *	r1 > 0		r1 points to opal stack
+	 */
+	ld	r11,GPR1(r1)
+	cmpdi	r11,0			/* check if r1 is in kernel. */
+	blt+	3f			/* Continue if yes. */
+
+	/*
+	 * r1 points to opal stack. Queue up the MCE event and return
+	 * from the interrupt. But before that, check if this is an
+	 * un-recoverable exception. If yes, then stay on emergency
+	 * stack and panic.
+	 */
+0:	andi.	r11,r12,MSR_RI
+	bne	2f
+
+1:	addi	r3,r1,STACK_FRAME_OVERHEAD
+	bl	.unrecoverable_exception
+	b	1b
+
+	/*
+	 * Return from MC interrupt.
+	 * TODO: Queue up the MCE event so that we can log it later.
+	 */
+2:	MACHINE_CHECK_HANDLER_WINDUP
+	rfid
+
 	/* Deliver the machine check to host kernel in V mode. */
-	MACHINE_CHECK_HANDLER_WINDUP
+3:	MACHINE_CHECK_HANDLER_WINDUP
 	b	machine_check_pSeries
 END_FTR_SECTION_IFSET(CPU_FTR_HVMODE)
 
