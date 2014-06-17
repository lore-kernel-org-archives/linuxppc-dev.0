Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DC4981A0168
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jun 2014 18:45:01 +1000 (EST)
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 354A0140098
 for <linuxppc-dev@ozlabs.org>; Tue, 17 Jun 2014 18:45:01 +1000 (EST)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Tue, 17 Jun 2014 14:14:54 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id CBFF6E0056
 for <linuxppc-dev@ozlabs.org>; Tue, 17 Jun 2014 14:15:56 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s5H8jpb59175366
 for <linuxppc-dev@ozlabs.org>; Tue, 17 Jun 2014 14:15:52 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s5H8inHQ008998
 for <linuxppc-dev@ozlabs.org>; Tue, 17 Jun 2014 14:14:50 +0530
Date: Tue, 17 Jun 2014 14:14:41 +0530
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 4/4] powerpc/book3s: Fix guest MC delivery mechanism to
 avoid soft lockups in guest.
Message-ID: <20140617084441.GA18798@in.ibm.com>
References: <20140611084756.9634.82266.stgit@mars.in.ibm.com>
 <20140611084821.9634.7119.stgit@mars.in.ibm.com>
 <20140617062358.GB12120@drongo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140617062358.GB12120@drongo>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Michael Neuling <mikey@neuling.org>
Reply-To: mahesh@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2014-06-17 16:23:58 Tue, Paul Mackerras wrote:
> On Wed, Jun 11, 2014 at 02:18:21PM +0530, Mahesh J Salgaonkar wrote:
> > From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> > 
> > Currently we forward MCEs to guest which have been recovered by guest.
> > And for unhandled errors we do not deliver the MCE to guest. It looks like
> > with no support of FWNMI in qemu, guest just panics whenever we deliver the
> > recovered MCEs to guest. Also, the existig code used to return to host for
> > unhandled errors which was casuing guest to hang with soft lockups inside
> > guest and makes it difficult to recover guest instance.
> > 
> > This patch now forwards all fatal MCEs to guest causing guest to crash/panic.
> > And, for recovered errors we just go back to normal functioning of guest
> > instead of returning to host.
> 
> ... having corrupted possibly live values that the guest had in SRR0/1.
> 
> Ideally the guest should have cleared MSR[RI] before putting values in
> SRR0/1, so perhaps you could check that and return to the guest
> without giving it a machine check if MSR[RI] is set.  But if MSR[RI]
> is clear, the guest is unfixably corrupted because the machine check
> overwrote SRR0/1, and the only thing we can do, in the absence of
> FWNMI support, is give the guest a machine check interrupt and let it
> crash.

Yes agree. I have patch (below) ready for the same, will test/verify and send it
out soon.

Thanks,
-Mahesh.

-------------
Deliver machine check with MSR(RI=0) to guest as MCE

From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>


---
 arch/powerpc/kvm/book3s_hv_rmhandlers.S |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index 868347e..c9c56ee 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -2257,7 +2257,6 @@ machine_check_realmode:
 	mr	r3, r9		/* get vcpu pointer */
 	bl	kvmppc_realmode_machine_check
 	nop
-	cmpdi	r3, 0		/* Did we handle MCE ? */
 	ld	r9, HSTATE_KVM_VCPU(r13)
 	li	r12, BOOK3S_INTERRUPT_MACHINE_CHECK
 	/*
@@ -2270,13 +2269,18 @@ machine_check_realmode:
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
 
