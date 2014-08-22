Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CFE6A1A003F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Aug 2014 14:54:06 +1000 (EST)
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 2C0C4140093
 for <linuxppc-dev@ozlabs.org>; Fri, 22 Aug 2014 14:54:05 +1000 (EST)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Fri, 22 Aug 2014 10:24:02 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 2A682394004E
 for <linuxppc-dev@ozlabs.org>; Fri, 22 Aug 2014 10:24:01 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s7M4sTQH56033526
 for <linuxppc-dev@ozlabs.org>; Fri, 22 Aug 2014 10:24:29 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s7M4s0jv018549
 for <linuxppc-dev@ozlabs.org>; Fri, 22 Aug 2014 10:24:00 +0530
Subject: [PATCH] powerpc/book3s: Deliver machine check with MSR(RI=0) to
 guest as MCE
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
To: Michael Ellerman <michael@ellerman.id.au>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
Date: Fri, 22 Aug 2014 10:23:59 +0530
Message-ID: <20140822045332.16250.41099.stgit@mars>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Aravinda Prasad <aravinda@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

For machine check occurring while in guest, KVM layer tries recovery
and deliver MCE to guest if recovery is failed. For recovered errors
we just go back to normal functioning of guest. But there are cases
where we may hit MCE in guest with MSR(RI=0), which means MCE interrupt is
not recoverable and guest can not function normally it should go down to
panic path. The current implementation does not have check for MSR(RI=0)
which can cause guest to crash with Bad kernel stack pointer instead of
machine check oops message.

[26281.490060] Bad kernel stack pointer 3fff9ccce5b0 at c00000000000490c
[26281.490434] Oops: Bad kernel stack pointer, sig: 6 [#1]
[26281.490472] SMP NR_CPUS=2048 NUMA pSeries

This patch fixes this issue by checking MSR(RI=0) in KVM layer and forwarding
unrecoverable interrupt to guest which then panics with proper machine check
Oops message.

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
---
 arch/powerpc/kvm/book3s_hv_rmhandlers.S |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index f0c4db7..b6844fb 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -2275,7 +2275,6 @@ machine_check_realmode:
 	mr	r3, r9		/* get vcpu pointer */
 	bl	kvmppc_realmode_machine_check
 	nop
-	cmpdi	r3, 0		/* Did we handle MCE ? */
 	ld	r9, HSTATE_KVM_VCPU(r13)
 	li	r12, BOOK3S_INTERRUPT_MACHINE_CHECK
 	/*
@@ -2288,13 +2287,18 @@ machine_check_realmode:
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
 
