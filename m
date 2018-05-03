Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40c6mG3QDYzF2Tj
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 May 2018 17:51:42 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id b26so1276027pfi.10
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 03 May 2018 00:51:42 -0700 (PDT)
Date: Thu, 3 May 2018 15:51:37 +0800
From: Simon Guo <wei.guo.simon@gmail.com>
To: Paul Mackerras <paulus@ozlabs.org>
Cc: kvm-ppc@vger.kernel.org, kvm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 02/11] KVM: PPC: mov nip/ctr/lr/xer registers to pt_regs
 in kvm_vcpu_arch
Message-ID: <20180503075137.GC6755@simonLocalRHEL7.x64>
References: <1524657284-16706-1-git-send-email-wei.guo.simon@gmail.com>
 <1524657284-16706-3-git-send-email-wei.guo.simon@gmail.com>
 <20180503054600.GC6795@fergus.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180503054600.GC6795@fergus.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 03, 2018 at 03:46:01PM +1000, Paul Mackerras wrote:
> On Wed, Apr 25, 2018 at 07:54:35PM +0800, wei.guo.simon@gmail.com wrote:
> > From: Simon Guo <wei.guo.simon@gmail.com>
> > 
> > This patch moves nip/ctr/lr/xer registers from scattered places in
> > kvm_vcpu_arch to pt_regs structure.
> > 
> > cr register is "unsigned long" in pt_regs and u32 in vcpu->arch.
> > It will need more consideration and may move in later patches.
> > 
> > Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
> 
> Mostly looks fine; some nits below.
> 
> > diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
> > index e8a78a5..731f7d4 100644
> > --- a/arch/powerpc/kernel/asm-offsets.c
> > +++ b/arch/powerpc/kernel/asm-offsets.c
> > @@ -431,14 +431,14 @@ int main(void)
> >  #ifdef CONFIG_ALTIVEC
> >  	OFFSET(VCPU_VRS, kvm_vcpu, arch.vr.vr);
> >  #endif
> > -	OFFSET(VCPU_XER, kvm_vcpu, arch.xer);
> > -	OFFSET(VCPU_CTR, kvm_vcpu, arch.ctr);
> > -	OFFSET(VCPU_LR, kvm_vcpu, arch.lr);
> > +	OFFSET(VCPU_XER, kvm_vcpu, arch.regs.xer);
> > +	OFFSET(VCPU_CTR, kvm_vcpu, arch.regs.ctr);
> > +	OFFSET(VCPU_LR, kvm_vcpu, arch.regs.link);
> >  #ifdef CONFIG_PPC_BOOK3S
> >  	OFFSET(VCPU_TAR, kvm_vcpu, arch.tar);
> >  #endif
> > -	OFFSET(VCPU_CR, kvm_vcpu, arch.cr);
> > -	OFFSET(VCPU_PC, kvm_vcpu, arch.nip);
> 
> This should be arch.pc; arch.nip doesn't exist.
Yes. That was introduced during patch split. I will correct them.

> 
> > +	OFFSET(VCPU_CR, kvm_vcpu, arch.regs.ccr);
> 
> I thought the patch description said you weren't moving CR at this
> stage?
Sorry about that. thanks for pointing out.

> 
> > +	OFFSET(VCPU_PC, kvm_vcpu, arch.regs.nip);
> >  #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
> >  	OFFSET(VCPU_MSR, kvm_vcpu, arch.shregs.msr);
> >  	OFFSET(VCPU_SRR0, kvm_vcpu, arch.shregs.srr0);
> > @@ -693,11 +693,11 @@ int main(void)
> >  #endif /* CONFIG_PPC_BOOK3S_64 */
> >  
> >  #else /* CONFIG_PPC_BOOK3S */
> > -	OFFSET(VCPU_CR, kvm_vcpu, arch.cr);
> > -	OFFSET(VCPU_XER, kvm_vcpu, arch.xer);
> > -	OFFSET(VCPU_LR, kvm_vcpu, arch.lr);
> > -	OFFSET(VCPU_CTR, kvm_vcpu, arch.ctr);
> > -	OFFSET(VCPU_PC, kvm_vcpu, arch.pc);
> > +	OFFSET(VCPU_CR, kvm_vcpu, arch.regs.ccr);
> 
> Once again VCPU_CR should not be changed.
Yep.

> 
> > +	OFFSET(VCPU_XER, kvm_vcpu, arch.regs.xer);
> > +	OFFSET(VCPU_LR, kvm_vcpu, arch.regs.link);
> > +	OFFSET(VCPU_CTR, kvm_vcpu, arch.regs.ctr);
> > +	OFFSET(VCPU_PC, kvm_vcpu, arch.regs.nip);
> >  	OFFSET(VCPU_SPRG9, kvm_vcpu, arch.sprg9);
> >  	OFFSET(VCPU_LAST_INST, kvm_vcpu, arch.last_inst);
> >  	OFFSET(VCPU_FAULT_DEAR, kvm_vcpu, arch.fault_dear);
> 
> Paul.

Thanks,
- Simon
