Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40ld0h6brYzF2Y6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 May 2018 22:58:28 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id w4-v6so7251pgq.8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 May 2018 05:58:28 -0700 (PDT)
Date: Tue, 15 May 2018 20:58:22 +0800
From: Simon Guo <wei.guo.simon@gmail.com>
To: Paul Mackerras <paulus@ozlabs.org>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
Subject: Re: [PATCH v2 17/30] KVM: PPC: Book3S PR: make mtspr/mfspr emulation
 behavior based on active TM SPRs
Message-ID: <20180515125822.GC10886@simonLocalRHEL7.x64>
References: <1519753958-11756-1-git-send-email-wei.guo.simon@gmail.com>
 <1519753958-11756-7-git-send-email-wei.guo.simon@gmail.com>
 <20180515060703.GC28451@fergus.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180515060703.GC28451@fergus.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, May 15, 2018 at 04:07:03PM +1000, Paul Mackerras wrote:
> On Wed, Feb 28, 2018 at 01:52:25AM +0800, wei.guo.simon@gmail.com wrote:
> > From: Simon Guo <wei.guo.simon@gmail.com>
> > 
> > The mfspr/mtspr on TM SPRs(TEXASR/TFIAR/TFHAR) are non-privileged
> > instructions and can be executed at PR KVM guest without trapping
> > into host in problem state. We only emulate mtspr/mfspr
> > texasr/tfiar/tfhar at guest PR=0 state.
> > 
> > When we are emulating mtspr tm sprs at guest PR=0 state, the emulation
> > result need to be visible to guest PR=1 state. That is, the actual TM
> > SPR val should be loaded into actual registers.
> > 
> > We already flush TM SPRs into vcpu when switching out of CPU, and load
> > TM SPRs when switching back.
> > 
> > This patch corrects mfspr()/mtspr() emulation for TM SPRs to make the
> > actual source/dest based on actual TM SPRs.
> > 
> > Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
> > ---
> >  arch/powerpc/include/asm/kvm_book3s.h |  1 +
> >  arch/powerpc/kvm/book3s_emulate.c     | 54 ++++++++++++++++++++++++++++-------
> >  arch/powerpc/kvm/book3s_pr.c          |  2 +-
> >  3 files changed, 46 insertions(+), 11 deletions(-)
> > 
> > diff --git a/arch/powerpc/include/asm/kvm_book3s.h b/arch/powerpc/include/asm/kvm_book3s.h
> > index 5911c3b..2ecb6a3 100644
> > --- a/arch/powerpc/include/asm/kvm_book3s.h
> > +++ b/arch/powerpc/include/asm/kvm_book3s.h
> > @@ -208,6 +208,7 @@ extern long kvmppc_hv_get_dirty_log_radix(struct kvm *kvm,
> >  extern void kvmppc_book3s_dequeue_irqprio(struct kvm_vcpu *vcpu,
> >  					  unsigned int vec);
> >  extern void kvmppc_inject_interrupt(struct kvm_vcpu *vcpu, int vec, u64 flags);
> > +extern void kvmppc_trigger_fac_interrupt(struct kvm_vcpu *vcpu, ulong fac);
> >  extern void kvmppc_set_bat(struct kvm_vcpu *vcpu, struct kvmppc_bat *bat,
> >  			   bool upper, u32 val);
> >  extern void kvmppc_giveup_ext(struct kvm_vcpu *vcpu, ulong msr);
> > diff --git a/arch/powerpc/kvm/book3s_emulate.c b/arch/powerpc/kvm/book3s_emulate.c
> > index 63af17f..a03533d 100644
> > --- a/arch/powerpc/kvm/book3s_emulate.c
> > +++ b/arch/powerpc/kvm/book3s_emulate.c
> > @@ -523,13 +523,35 @@ int kvmppc_core_emulate_mtspr_pr(struct kvm_vcpu *vcpu, int sprn, ulong spr_val)
> >  		break;
> >  #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
> >  	case SPRN_TFHAR:
> > -		vcpu->arch.tfhar = spr_val;
> > -		break;
> >  	case SPRN_TEXASR:
> > -		vcpu->arch.texasr = spr_val;
> > -		break;
> >  	case SPRN_TFIAR:
> > -		vcpu->arch.tfiar = spr_val;
> > +		if (!cpu_has_feature(CPU_FTR_TM))
> > +			break;
> > +
> > +		if (!(kvmppc_get_msr(vcpu) & MSR_TM)) {
> > +			kvmppc_trigger_fac_interrupt(vcpu, FSCR_TM_LG);
> > +			emulated = EMULATE_AGAIN;
> > +			break;
> > +		}
> > +
> > +		if (MSR_TM_ACTIVE(kvmppc_get_msr(vcpu))) {
> > +			/* it is illegal to mtspr() TM regs in
> > +			 * other than non-transactional state.
> > +			 */
> > +			kvmppc_core_queue_program(vcpu, SRR1_PROGTM);
> > +			emulated = EMULATE_AGAIN;
> 
> According to the architecture, mtspr to TFHAR is permitted in
> suspended state.
oh.. I rescan the ISA and find the corresponding statement:
"If an attempt is made to execute mtspr specifying a TM
SPR in other than Non-transactional state, with the
exception of TFAR in suspended state, a TM Bad Thing
type Program interrupt is generated."

It mentiones "TFAR" instead of "TFHAR" -- So it looks a typo
in the ISA book. I will correct the code.

Thanks,
- Simon
