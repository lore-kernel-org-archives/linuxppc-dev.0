Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F1D6F1A2B68
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2015 03:54:53 +1100 (AEDT)
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3ECD8140134
 for <linuxppc-dev@ozlabs.org>; Tue, 24 Mar 2015 03:54:53 +1100 (AEDT)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Mon, 23 Mar 2015 22:24:50 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id D69F9394004E
 for <linuxppc-dev@ozlabs.org>; Mon, 23 Mar 2015 22:24:47 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2NGsk4r26607826
 for <linuxppc-dev@ozlabs.org>; Mon, 23 Mar 2015 22:24:47 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2NGm829025649
 for <linuxppc-dev@ozlabs.org>; Mon, 23 Mar 2015 22:18:08 +0530
Subject: [RESEND PATCH] KVM: PPC: Book3S HV: Deliver machine check with
 MSR(RI=0) to guest as MCE.
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Date: Mon, 23 Mar 2015 22:24:45 +0530
Message-ID: <20150323165056.18415.21045.stgit@mars>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: David Gibson <dgibson@redhat.com>, Alexander Graf <agraf@suse.de>,
 KVM-PPC <kvm-ppc@vger.kernel.org>, KVM <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

For the machine check interrupt that happens while we are in the guest,
kvm layer attempts the recovery, and then delivers the machine check interrupt
directly to the guest if recovery fails. On successful recovery we go back to
normal functioning of the guest. But there can be cases where a machine check
interrupt can happen with MSR(RI=0) while we are in the guest. This means
MC interrupt is unrecoverable and we have to deliver a machine check to the
guest since the machine check interrupt might have trashed valid values in
SRR0/1. The current implementation do not handle this case, causing guest
to crash with Bad kernel stack pointer instead of machine check oops message.

[26281.490060] Bad kernel stack pointer 3fff9ccce5b0 at c00000000000490c
[26281.490434] Oops: Bad kernel stack pointer, sig: 6 [#1]
[26281.490472] SMP NR_CPUS=2048 NUMA pSeries

This patch fixes this issue by checking MSR(RI=0) in KVM layer and forwarding
unrecoverable interrupt to guest which then panics with proper machine check
Oops message.

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
Acked-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/kvm/book3s_hv_rmhandlers.S |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index bb94e6f..258f46d 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -2063,7 +2063,6 @@ machine_check_realmode:
 	mr	r3, r9		/* get vcpu pointer */
 	bl	kvmppc_realmode_machine_check
 	nop
-	cmpdi	r3, 0		/* Did we handle MCE ? */
 	ld	r9, HSTATE_KVM_VCPU(r13)
 	li	r12, BOOK3S_INTERRUPT_MACHINE_CHECK
 	/*
@@ -2076,13 +2075,18 @@ machine_check_realmode:
 	 * The old code used to return to host for unhandled errors which
 	 * was causing guest to hang with soft lockups inside guest and
 	 * makes it difficult to recover guest instance.
+	 *
+	 * if we receive machine check with MSR(RI=0) then deliver it to
+	 * guest as machine check causing guest to crash.
 	 */
-	ld	r10, VCPU_PC(r9)
 	ld	r11, VCPU_MSR(r9)
+	andi.	r10, r11, MSR_RI	/* check for unrecoverable exception */
+	beq	1f			/* Deliver a machine check to guest */
+	ld	r10, VCPU_PC(r9)
+	cmpdi	r3, 0		/* Did we handle MCE ? */
 	bne	2f	/* Continue guest execution. */
 	/* If not, deliver a machine check.  SRR0/1 are already set */
-	li	r10, BOOK3S_INTERRUPT_MACHINE_CHECK
-	ld	r11, VCPU_MSR(r9)
+1:	li	r10, BOOK3S_INTERRUPT_MACHINE_CHECK
 	bl	kvmppc_msr_interrupt
 2:	b	fast_interrupt_c_return
 
