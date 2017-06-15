Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wpMmX2vDzzDqL8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jun 2017 22:11:24 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id w12so1544363pfk.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jun 2017 05:11:24 -0700 (PDT)
Date: Thu, 15 Jun 2017 22:11:08 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>, "Vaidyanathan Srinivasan"
 <svaidy@linux.vnet.ibm.com>
Subject: Re: [PATCH 07/13] powerpc/64s: idle avoid SRR usage in idle
 sleep/wake paths
Message-ID: <20170615221108.3f9abd33@roar.ozlabs.ibm.com>
In-Reply-To: <20170613130557.26315-8-npiggin@gmail.com>
References: <20170613130557.26315-1-npiggin@gmail.com>
 <20170613130557.26315-8-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 13 Jun 2017 23:05:51 +1000
Nicholas Piggin <npiggin@gmail.com> wrote:

> Idle code now always runs at the 0xc... effective address whether
> in real or virtual mode. This means rfid can be ditched, along
> with a lot of SRR manipulations.
> 
> In the wakeup path, carry SRR1 around in r12. Use mtmsrd to change
> MSR states as required.
> 
> This also balances the return prediction for the idle call, by
> doing blr rather than rfid to return to the idle caller.
> 
> On POWER9, 2-process context switch on different cores, with snooze
> disabled, increases performance by 2%.

This patch has a few stupid bugs in the kvm_start_guest path. It needs
the following incremental patch.

- mtspr dst/src wrong
- Did not pass SRR1 in r3 to kvm_start_guest
- Didn't take into account the return back to pnv_wakeup_loss, so
  r1 was getting lost.

This would cause crashes when starting KVM guests with -smp cores=2,threads=8

I've also tested HMI wakeup by adjusting SRR1 in the simulator, but
can't do an HMI injection on real hardware when it is in nap state
AFAIK.

Thanks,
Nick

---
 arch/powerpc/kernel/idle_book3s.S       | 10 +++++++---
 arch/powerpc/kvm/book3s_hv_rmhandlers.S |  6 ++++--
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
index 6305d4d7a268..ebe80b5d5ce4 100644
--- a/arch/powerpc/kernel/idle_book3s.S
+++ b/arch/powerpc/kernel/idle_book3s.S
@@ -402,16 +402,16 @@ BEGIN_FTR_SECTION
 BEGIN_FTR_SECTION_NESTED(70)
 	bl	power9_dd1_recover_paca
 END_FTR_SECTION_NESTED_IFSET(CPU_FTR_POWER9_DD1, 70)
-	ld	r1,PACAR1(r13)
 	bl	pnv_restore_hyp_resource_arch300
 FTR_SECTION_ELSE
-	ld	r1,PACAR1(r13)
 	bl	pnv_restore_hyp_resource_arch207
 ALT_FTR_SECTION_END_IFSET(CPU_FTR_ARCH_300)
 
 	li	r0,PNV_THREAD_RUNNING
 	stb	r0,PACA_THREAD_IDLE_STATE(r13)	/* Clear thread state */
 
+	mr	r3,r12
+
 #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
 	li	r0,KVM_HWTHREAD_IN_KERNEL
 	stb	r0,HSTATE_HWTHREAD_STATE(r13)
@@ -425,7 +425,6 @@ ALT_FTR_SECTION_END_IFSET(CPU_FTR_ARCH_300)
 #endif
 
 	/* Return SRR1 from power7_nap() */
-	mr	r3,r12
 	blt	cr3,pnv_wakeup_noloss
 	b	pnv_wakeup_loss
 
@@ -499,6 +498,7 @@ pnv_restore_hyp_resource_arch207:
  * r4 - PACA_THREAD_IDLE_STATE
  */
 pnv_wakeup_tb_loss:
+	ld	r1,PACAR1(r13)
 	/*
 	 * Before entering any idle state, the NVGPRs are saved in the stack.
 	 * If there was a state loss, or PACA_NAPSTATELOST was set, then the
@@ -789,9 +789,11 @@ fastsleep_workaround_at_exit:
 /*
  * R3 here contains the value that will be returned to the caller
  * of power7_nap.
+ * R12 contains SRR1 for CHECK_HMI_INTERRUPT.
  */
 .global pnv_wakeup_loss
 pnv_wakeup_loss:
+	ld	r1,PACAR1(r13)
 BEGIN_FTR_SECTION
 	CHECK_HMI_INTERRUPT
 END_FTR_SECTION_IFSET(CPU_FTR_HVMODE)
@@ -809,11 +811,13 @@ END_FTR_SECTION_IFSET(CPU_FTR_HVMODE)
 /*
  * R3 here contains the value that will be returned to the caller
  * of power7_nap.
+ * R12 contains SRR1 for CHECK_HMI_INTERRUPT.
  */
 pnv_wakeup_noloss:
 	lbz	r0,PACA_NAPSTATELOST(r13)
 	cmpwi	r0,0
 	bne	pnv_wakeup_loss
+	ld	r1,PACAR1(r13)
 BEGIN_FTR_SECTION
 	CHECK_HMI_INTERRUPT
 END_FTR_SECTION_IFSET(CPU_FTR_HVMODE)
diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index eb5b78b6bacf..ecb69c4ee943 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -342,7 +342,7 @@ kvm_start_guest:
 	 * Could avoid this and pass it through in r3. For now,
 	 * code expects it to be in SRR1.
 	 */
-	mtspr	r3,SPRN_SRR1
+	mtspr	SPRN_SRR1,r3
 
 	ld	r2,PACATOC(r13)
 
@@ -462,13 +462,15 @@ kvm_no_guest:
 /*
  * We jump to pnv_wakeup_loss, which will return to the caller
  * of power7_nap in the powernv cpu offline loop.  The value we
- * put in r3 becomes the return value for power7_nap.
+ * put in r3 becomes the return value for power7_nap. pnv_wakeup_loss
+ * requires SRR1 in r12.
  */
 	li	r3, LPCR_PECE0
 	mfspr	r4, SPRN_LPCR
 	rlwimi	r4, r3, 0, LPCR_PECE0 | LPCR_PECE1
 	mtspr	SPRN_LPCR, r4
 	li	r3, 0
+	mfspr	r12,SPRN_SRR1
 	b	pnv_wakeup_loss
 
 53:	HMT_LOW
-- 
2.11.0
