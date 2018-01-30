Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zVs5Y341wzDqhZ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jan 2018 14:18:09 +1100 (AEDT)
Received: by mail-pg0-x244.google.com with SMTP id 136so6114601pgd.8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jan 2018 19:18:09 -0800 (PST)
Date: Tue, 30 Jan 2018 11:18:04 +0800
From: Simon Guo <wei.guo.simon@gmail.com>
To: Paul Mackerras <paulus@ozlabs.org>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
Subject: Re: [PATCH 21/26] KVM: PPC: Book3S PR: adds emulation for treclaim.
Message-ID: <20180130031804.GI3261@simonLocalRHEL7.x64>
References: <1515665499-31710-1-git-send-email-wei.guo.simon@gmail.com>
 <1515665499-31710-22-git-send-email-wei.guo.simon@gmail.com>
 <20180123092323.GM3924@fergus.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180123092323.GM3924@fergus.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Paul,
On Tue, Jan 23, 2018 at 08:23:23PM +1100, Paul Mackerras wrote:
> On Thu, Jan 11, 2018 at 06:11:34PM +0800, wei.guo.simon@gmail.com wrote:
> > From: Simon Guo <wei.guo.simon@gmail.com>
> > 
> > This patch adds support for "treclaim." emulation when PR KVM guest
> > executes treclaim. and traps to host.
> > 
> > We will firstly doing treclaim. and save TM checkpoint and doing
> > treclaim. Then it is necessary to update vcpu current reg content
> > with checkpointed vals. When rfid into guest again, those vcpu
> > current reg content(now the checkpoint vals) will be loaded into
> > regs.
> > 
> > Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
> > ---
> >  arch/powerpc/include/asm/reg.h    |  4 +++
> >  arch/powerpc/kvm/book3s_emulate.c | 66 ++++++++++++++++++++++++++++++++++++++-
> >  2 files changed, 69 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
> > index 6c293bc..b3bcf6b 100644
> > --- a/arch/powerpc/include/asm/reg.h
> > +++ b/arch/powerpc/include/asm/reg.h
> > @@ -244,12 +244,16 @@
> >  #define SPRN_TEXASR	0x82	/* Transaction EXception & Summary */
> >  #define SPRN_TEXASRU	0x83	/* ''	   ''	   ''	 Upper 32  */
> >  #define TEXASR_FC_LG	(63 - 7)	/* Failure Code */
> > +#define TEXASR_AB_LG	(63 - 31)	/* Abort */
> > +#define TEXASR_SU_LG	(63 - 32)	/* Suspend */
> >  #define TEXASR_HV_LG	(63 - 34)	/* Hypervisor state*/
> >  #define TEXASR_PR_LG	(63 - 35)	/* Privilege level */
> >  #define TEXASR_FS_LG	(63 - 36)	/* failure summary */
> >  #define TEXASR_EX_LG	(63 - 37)	/* TFIAR exact bit */
> >  #define TEXASR_ROT_LG	(63 - 38)	/* ROT bit */
> >  #define TEXASR_FC	(ASM_CONST(0xFF) << TEXASR_FC_LG)
> > +#define TEXASR_AB	__MASK(TEXASR_AB_LG)
> > +#define TEXASR_SU	__MASK(TEXASR_SU_LG)
> >  #define TEXASR_HV	__MASK(TEXASR_HV_LG)
> >  #define TEXASR_PR	__MASK(TEXASR_PR_LG)
> >  #define TEXASR_FS	__MASK(TEXASR_FS_LG)
> 
> It would be good to collect up all the modifications you need to make
> to reg.h into a single patch at the beginning of the patch series --
> that will make it easier to merge it all.
> 
OK.

> > diff --git a/arch/powerpc/kvm/book3s_emulate.c b/arch/powerpc/kvm/book3s_emulate.c
> > index 1eb1900..51c0e20 100644
> > --- a/arch/powerpc/kvm/book3s_emulate.c
> > +++ b/arch/powerpc/kvm/book3s_emulate.c
> 
> [snip]
> 
> > @@ -127,6 +130,42 @@ void kvmppc_copyfrom_vcpu_tm(struct kvm_vcpu *vcpu)
> >  	vcpu->arch.vrsave = vcpu->arch.vrsave_tm;
> >  }
> >  
> > +static void kvmppc_emulate_treclaim(struct kvm_vcpu *vcpu, int ra_val)
> > +{
> > +	unsigned long guest_msr = kvmppc_get_msr(vcpu);
> > +	int fc_val = ra_val ? ra_val : 1;
> > +
> > +	kvmppc_save_tm_pr(vcpu);
> > +
> > +	preempt_disable();
> > +	kvmppc_copyfrom_vcpu_tm(vcpu);
> > +	preempt_enable();
> > +
> > +	/*
> > +	 * treclaim need quit to non-transactional state.
> > +	 */
> > +	guest_msr &= ~(MSR_TS_MASK);
> > +	kvmppc_set_msr(vcpu, guest_msr);
> > +
> > +	preempt_disable();
> > +	tm_enable();
> > +	vcpu->arch.texasr = mfspr(SPRN_TEXASR);
> > +	vcpu->arch.texasr &= ~TEXASR_FC;
> > +	vcpu->arch.texasr |= ((u64)fc_val << TEXASR_FC_LG);
> 
> You're doing failure recording here unconditionally, but the
> architecture says that treclaim. only does failure recording if
> TEXASR_FS is not already set.
> 
I need add that. And the CR0 setting is also missed. 
Thanks for the catch.

[snip]

BR,
- Simon
