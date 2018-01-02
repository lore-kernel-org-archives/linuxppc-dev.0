Return-Path: <srs0=nhoa=d5=gmail.com=sjitindarsingh@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zB9094p9XzF0Q3
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jan 2018 10:15:37 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3zB90927tJz8t1b
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jan 2018 10:15:37 +1100 (AEDT)
Message-ID: <1514934921.2175.2.camel@gmail.com>
Subject: Re: [RFC PATCH 2/2] KVM: PPC: Book3S HV: Work around transactional
 memory bugs in POWER9
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
To: Paul Mackerras <paulus@ozlabs.org>, linuxppc-dev@ozlabs.org,
 kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
Cc: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 03 Jan 2018 10:15:21 +1100
In-Reply-To: <20171208061113.sm2cuug2uypdduw5@rohan>
References: <20171208060803.relvzabipgl2lub6@rohan>
 <20171208061113.sm2cuug2uypdduw5@rohan>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-12-08 at 17:11 +1100, Paul Mackerras wrote:
> POWER9 has hardware bugs relating to transactional memory and thread
> reconfiguration (changes to hardware SMT mode).  Specifically, the
> core
> does not have enough storage to store a complete checkpoint of all
> the
> architected state for all four threads.  The DD2.2 version of POWER9
> includes hardware modifications designed to allow hypervisor software
> to implement workarounds for these problems.  This patch implements
> those workarounds in KVM code so that KVM guests see a full, working
> transactional memory implementation.
> 
> The problems center around the use of TM suspended state, where the
> CPU has a checkpointed state but execution is not transactional.  The
> workaround is to implement a "fake suspend" state, which looks to the
> guest like suspended state but the CPU does not store a checkpoint.
> In this state, any instruction that would cause a transition to
> transactional state (rfid, rfebb, mtmsrd, tresume) or would use the
> checkpointed state (treclaim) causes a "soft patch" interrupt (vector
> 0x1500) to the hypervisor so that it can be emulated.  The trechkpt
> instruction also causes a soft patch interrupt.
> 
> On POWER9 DD2.2, we avoid returning to the guest in any state which
> would require a checkpoint to be present.  The trechkpt in the guest
> entry path which would normally create that checkpoint is replaced by
> either a transition to fake suspend state, if the guest is in suspend
> state, or a rollback to the pre-transactional state if the guest is
> in
> transactional state.  Fake suspend state is indicated by a flag in
> the
> PACA plus a new bit in the PSSCR.  The new PSSCR bit is write-only
> and
> reads back as 0.
> 
> On exit from the guest, if the guest is in fake suspend state, we
> still
> do the treclaim instruction as we would in real suspend state, in
> order
> to get into non-transactional state, but we do not save the resulting
> register state since there was no checkpoint.
> 
> Emulation of the instructions that cause a softpath interrupt is
> handled
> in two paths.  If the guest is in real suspend mode, we call
> kvmhv_p9_tm_emulation_early() to handle the cases where the guest is
> transitioning to transactional state.  This is called before we do
> the treclaim in the guest exit path; because we haven't done
> treclaim,
> we can get back to the guest with the transaction still active.
> If the instruction is a case that kvmhv_p9_tm_emulation_early()
> doesn't
> handle, or if the guest is in fake suspend state, then we proceed to
> do the complete guest exit path and subsequently call
> kvmhv_p9_tm_emulation() in host context with the MMU on.  This
> handles all the cases including the cases that generate program
> interrupts (illegal instruction or TM Bad Thing) and facility
> unavailable interrupts.
> 
> The emulation is reasonably straightforward and is mostly concerned
> with checking for exception conditions and updating the state of
> registers such as MSR and CR0.  The treclaim emulation takes care to
> ensure that the TEXASR register gets updated as if it were the guest
> treclaim instruction that had done failure recording, not the
> treclaim
> done in hypervisor state in the guest exit path.
> 
> Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
> 

With the following patch applied on top of the TM emulation code I was
able to get at least a basic test to run on the guest on real hardware.

[snip]

diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index c7fe377ff6bc..adf2da6b2211 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -3049,6 +3049,7 @@ BEGIN_FTR_SECTION
        li      r0, PSSCR_FAKE_SUSPEND
        andc    r3, r3, r0
        mtspr   SPRN_PSSCR, r3
+       ld      r9, HSTATE_KVM_VCPU(r13)
        b       1f
 2:
 END_FTR_SECTION_IFSET(CPU_FTR_P9_TM_EMUL)
@@ -3273,8 +3274,10 @@ END_FTR_SECTION_IFSET(CPU_FTR_P9_TM_EMUL)
        b       9b              /* and return */
 10:    stdu    r1, -PPC_MIN_STKFRM(r1)
        /* guest is in transactional state, so simulate rollback */
+       mr      r3, r4
        bl      kvmhv_emulate_tm_rollback
        nop
+       ld      r4, HSTATE_KVM_VCPU(r13) /* our vcpu pointer has been
trashed */
        addi    r1, r1, PPC_MIN_STKFRM
        b       9b
 #endif
