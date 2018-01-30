Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zVrfQ10kxzDqqL
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jan 2018 13:58:02 +1100 (AEDT)
Received: by mail-pf0-x241.google.com with SMTP id y26so7359778pfi.10
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jan 2018 18:58:02 -0800 (PST)
Date: Tue, 30 Jan 2018 10:57:58 +0800
From: Simon Guo <wei.guo.simon@gmail.com>
To: Paul Mackerras <paulus@ozlabs.org>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
Subject: Re: [PATCH 16/26] KVM: PPC: Book3S PR: add transaction memory
 save/restore skeleton for PR KVM
Message-ID: <20180130025758.GD3261@simonLocalRHEL7.x64>
References: <1515665499-31710-1-git-send-email-wei.guo.simon@gmail.com>
 <1515665499-31710-17-git-send-email-wei.guo.simon@gmail.com>
 <20180123060409.GG3924@fergus.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180123060409.GG3924@fergus.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Paul,
On Tue, Jan 23, 2018 at 05:04:09PM +1100, Paul Mackerras wrote:
> On Thu, Jan 11, 2018 at 06:11:29PM +0800, wei.guo.simon@gmail.com wrote:
> > From: Simon Guo <wei.guo.simon@gmail.com>
> > 
> > The transaction memory checkpoint area save/restore behavior is
> > triggered when VCPU qemu process is switching out/into CPU. ie.
> > at kvmppc_core_vcpu_put_pr() and kvmppc_core_vcpu_load_pr().
> > 
> > MSR TM active state is determined by TS bits:
> >     active: 10(transactional) or 01 (suspended)
> >     inactive: 00 (non-transactional)
> > We don't "fake" TM functionality for guest. We "sync" guest virtual
> > MSR TM active state(10 or 01) with shadow MSR. That is to say,
> > we don't emulate a transactional guest with a TM inactive MSR.
> > 
> > TM SPR support(TFIAR/TFAR/TEXASR) has already been supported by
> > commit 9916d57e64a4 ("KVM: PPC: Book3S PR: Expose TM registers").
> > Math register support (FPR/VMX/VSX) will be done at subsequent
> > patch.
> > 
> > - TM save:
> > When kvmppc_save_tm_pr() is invoked, whether TM context need to
> > be saved can be determined by current host MSR state:
> > 	* TM active - save TM context
> > 	* TM inactive - no need to do so and only save TM SPRs.
> > 
> > - TM restore:
> > However when kvmppc_restore_tm_pr() is invoked, there is an
> > issue to determine whether TM restore should be performed.
> > The TM active host MSR val saved in kernel stack is not loaded yet.
> 
> I don't follow this exactly.  What is the value saved on the kernel
> stack?
> 
> I get that we may not have done the sync from the shadow MSR back to
> the guest MSR, since that is done in kvmppc_handle_exit_pr() with
> interrupts enabled and we might be unloading because we got
> preempted.  In that case we would have svcpu->in_use = 1, and we
> should in fact do the sync of the TS bits from shadow_msr to the vcpu
> MSR value in kvmppc_copy_from_svcpu().  If you did that then both the
> load and put functions could just rely on the vcpu's MSR value.
> 
Yes. that looks more clean and simpler!

> > We don't know whether there is a transaction to be restored from
> > current host MSR TM status at kvmppc_restore_tm_pr(). To solve this
> > issue, we save current MSR into vcpu->arch.save_msr_tm at
> > kvmppc_save_tm_pr(), and kvmppc_restore_tm_pr() check TS bits of
> > vcpu->arch.save_msr_tm to decide whether to do TM restore.
> > 
> > Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
> > Suggested-by: Paul Mackerras <paulus@ozlabs.org>
> > ---
> >  arch/powerpc/include/asm/kvm_book3s.h |  6 +++++
> >  arch/powerpc/include/asm/kvm_host.h   |  1 +
> >  arch/powerpc/kvm/book3s_pr.c          | 41 +++++++++++++++++++++++++++++++++++
> >  3 files changed, 48 insertions(+)
> > 
> > diff --git a/arch/powerpc/include/asm/kvm_book3s.h b/arch/powerpc/include/asm/kvm_book3s.h
> > index 9a66700..d8dbfa5 100644
> > --- a/arch/powerpc/include/asm/kvm_book3s.h
> > +++ b/arch/powerpc/include/asm/kvm_book3s.h
> > @@ -253,6 +253,12 @@ extern void kvmppc_copy_to_svcpu(struct kvmppc_book3s_shadow_vcpu *svcpu,
> >  				 struct kvm_vcpu *vcpu);
> >  extern void kvmppc_copy_from_svcpu(struct kvm_vcpu *vcpu,
> >  				   struct kvmppc_book3s_shadow_vcpu *svcpu);
> > +
> > +#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
> > +void kvmppc_save_tm_pr(struct kvm_vcpu *vcpu);
> > +void kvmppc_restore_tm_pr(struct kvm_vcpu *vcpu);
> > +#endif
> 
> It would be cleaner at the point where you use these if you added a
> #else clause to define a null version for the case when transactional
> memory support is not configured, like this:
> 
> +#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
> +void kvmppc_save_tm_pr(struct kvm_vcpu *vcpu);
> +void kvmppc_restore_tm_pr(struct kvm_vcpu *vcpu);
> +#else
> +static inline void kvmppc_save_tm_pr(struct kvm_vcpu *vcpu) {}
> +static inline void kvmppc_restore_tm_pr(struct kvm_vcpu *vcpu) {}
> +#endif
> 
> That way you don't need the #ifdef at the call site.
> 
Thanks for the tip.

> > @@ -131,6 +135,10 @@ static void kvmppc_core_vcpu_put_pr(struct kvm_vcpu *vcpu)
> >  	if (kvmppc_is_split_real(vcpu))
> >  		kvmppc_unfixup_split_real(vcpu);
> >  
> > +#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
> > +	kvmppc_save_tm_pr(vcpu);
> > +#endif
> > +
> >  	kvmppc_giveup_ext(vcpu, MSR_FP | MSR_VEC | MSR_VSX);
> >  	kvmppc_giveup_fac(vcpu, FSCR_TAR_LG);
> 
> I think you should do these giveup_ext/giveup_fac calls before calling
> kvmppc_save_tm_pr, because the treclaim in kvmppc_save_tm_pr will
> modify all the FP/VEC/VSX registers and the TAR.
I handled giveup_ext/giveup_fac() within kvmppc_save_tm_pr(), so that
other place (like kvmppc_emulate_treclaim() can invoke
kvmppc_save_tm_pr() easily). But I think moving the calls sequence as 
you suggested above will be more readable.

Thanks,
- Simon
