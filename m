Return-Path: <ego@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F5F11A09F3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Oct 2015 17:06:35 +1100 (AEDT)
Received: from localhost
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Thu, 15 Oct 2015 00:06:32 -0600
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id E107F19D8042
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2015 23:54:40 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9F65CKc8389094
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2015 23:05:12 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9F65eIk028059
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Oct 2015 00:06:29 -0600
From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
To: kvm-ppc@vger.kernel.org, kvm@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Alexander Graf <agraf@suse.com>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Subject: [PATCH] book3s_hv: Handle H_DOORBELL on the guest exit path
Date: Thu, 15 Oct 2015 11:29:58 +0530
Message-Id: <1444888798-30924-1-git-send-email-ego@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently a CPU running a guest can receive a H_DOORBELL in the
following two cases:
1) When the CPU is napping due to CEDE or there not being a guest
vcpu.
2) The CPU is running the guest vcpu.

Case 1), the doorbell message is not cleared since we were waking up
from nap. Hence when the EE bit gets set on transition from guest to
host, the H_DOORBELL interrupt is delivered to the host and the
corresponding handler is invoked.

However in Case 2), the message gets cleared by the action of taking
the H_DOORBELL interrupt. Since the CPU was running a guest, instead
of invoking the doorbell handler, the code invokes the second-level
interrupt handler to switch the context from the guest to the host. At
this point the setting of the EE bit doesn't result in the CPU getting
the doorbell interrupt since it has already been delivered once. So,
the handler for this doorbell is never invoked!

This causes softlockups if the missed DOORBELL was as IPI sent from a
sibling subcore CPU.

This patch fixes it by explitly invoking the doorbell handler on the
exit path if the exit reason is H_DOORBELL similar to the way an
EXTERNAL interrupt is handled. Since this will also handle Case 1), we
can unconditionally clear the doorbell message in
kvmppc_check_wake_reason.

Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
---
 arch/powerpc/kvm/book3s_hv_rmhandlers.S | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index b98889e..106c7f9 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -150,6 +150,8 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
 	cmpwi	cr1, r12, BOOK3S_INTERRUPT_MACHINE_CHECK
 	cmpwi	r12, BOOK3S_INTERRUPT_EXTERNAL
 	beq	11f
+	cmpwi	r12, BOOK3S_INTERRUPT_H_DOORBELL
+	beq 	15f	/* Invoke the H_DOORBELL handler */
 	cmpwi	cr2, r12, BOOK3S_INTERRUPT_HMI
 	beq	cr2, 14f			/* HMI check */
 
@@ -174,6 +176,10 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
 	mtspr	SPRN_HSRR1, r7
 	b	hmi_exception_after_realmode
 
+15:	mtspr SPRN_HSRR0, r8
+	mtspr SPRN_HSRR1, r7
+	ba    0xe80
+
 kvmppc_primary_no_guest:
 	/* We handle this much like a ceded vcpu */
 	/* put the HDEC into the DEC, since HDEC interrupts don't wake us */
@@ -2436,14 +2442,19 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
 
 	/* hypervisor doorbell */
 3:	li	r12, BOOK3S_INTERRUPT_H_DOORBELL
+
+	/*
+	 * Clear the doorbell as we will invoke the handler
+	 * explicitly in the guest exit path.
+	 */
+	lis	r6, (PPC_DBELL_SERVER << (63-36))@h
+	PPC_MSGCLR(6)
 	/* see if it's a host IPI */
 	li	r3, 1
 	lbz	r0, HSTATE_HOST_IPI(r13)
 	cmpwi	r0, 0
 	bnelr
-	/* if not, clear it and return -1 */
-	lis	r6, (PPC_DBELL_SERVER << (63-36))@h
-	PPC_MSGCLR(6)
+	/* if not, return -1 */
 	li	r3, -1
 	blr
 
-- 
1.9.3
