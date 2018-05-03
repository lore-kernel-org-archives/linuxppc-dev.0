Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40c9Dp6bVPzF2VC
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 May 2018 19:43:06 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id a22so165605pfn.6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 03 May 2018 02:43:06 -0700 (PDT)
Date: Thu, 3 May 2018 17:43:01 +0800
From: Simon Guo <wei.guo.simon@gmail.com>
To: Paul Mackerras <paulus@ozlabs.org>
Cc: kvm-ppc@vger.kernel.org, kvm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 10/11] KVM: PPC: reconstruct LOAD_VMX/STORE_VMX
 instruction mmio emulation with analyse_intr() input
Message-ID: <20180503094301.GJ6755@simonLocalRHEL7.x64>
References: <1524657284-16706-1-git-send-email-wei.guo.simon@gmail.com>
 <1524657284-16706-11-git-send-email-wei.guo.simon@gmail.com>
 <20180503061715.GK6795@fergus.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180503061715.GK6795@fergus.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 03, 2018 at 04:17:15PM +1000, Paul Mackerras wrote:
> On Wed, Apr 25, 2018 at 07:54:43PM +0800, wei.guo.simon@gmail.com wrote:
> > From: Simon Guo <wei.guo.simon@gmail.com>
> > 
> > This patch reconstructs LOAD_VMX/STORE_VMX instruction MMIO emulation with
> > analyse_intr() input. When emulating the store, the VMX reg will need to
> > be flushed so that the right reg val can be retrieved before writing to
> > IO MEM.
> > 
> > Suggested-by: Paul Mackerras <paulus@ozlabs.org>
> > Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
> 
> This looks fine for lvx and stvx, but now we are also doing something
> for the vector element loads and stores (lvebx, stvebx, lvehx, stvehx,
> etc.) without having the logic to insert or extract the correct
> element in the vector register image.  We need either to generate an
> error for the element load/store instructions, or handle them
> correctly.
Yes. I will consider that.

> 
> > diff --git a/arch/powerpc/kvm/emulate_loadstore.c b/arch/powerpc/kvm/emulate_loadstore.c
> > index 2dbdf9a..0bfee2f 100644
> > --- a/arch/powerpc/kvm/emulate_loadstore.c
> > +++ b/arch/powerpc/kvm/emulate_loadstore.c
> > @@ -160,6 +160,27 @@ int kvmppc_emulate_loadstore(struct kvm_vcpu *vcpu)
> >  					KVM_MMIO_REG_FPR|op.reg, size, 1);
> >  			break;
> >  #endif
> > +#ifdef CONFIG_ALTIVEC
> > +		case LOAD_VMX:
> > +			if (kvmppc_check_altivec_disabled(vcpu))
> > +				return EMULATE_DONE;
> > +
> > +			/* VMX access will need to be size aligned */
> 
> This comment isn't quite right; it isn't that the address needs to be
> size-aligned, it's that the hardware forcibly aligns it.  So I would
> say something like /* Hardware enforces alignment of VMX accesses */.
> 
I will update that.

> > +			vcpu->arch.vaddr_accessed &= ~((unsigned long)size - 1);
> > +			vcpu->arch.paddr_accessed &= ~((unsigned long)size - 1);
> > +
> > +			if (size == 16) {
> > +				vcpu->arch.mmio_vmx_copy_nums = 2;
> > +				emulated = kvmppc_handle_load128_by2x64(run,
> > +						vcpu, KVM_MMIO_REG_VMX|op.reg,
> > +						1);
> > +			} else if (size <= 8)
> > +				emulated = kvmppc_handle_load(run, vcpu,
> > +						KVM_MMIO_REG_VMX|op.reg,
> > +						size, 1);
> > +
> > +			break;
> > +#endif
> >  		case STORE:
> >  			if (op.type & UPDATE) {
> >  				vcpu->arch.mmio_ra = op.update_reg;
> > @@ -197,6 +218,36 @@ int kvmppc_emulate_loadstore(struct kvm_vcpu *vcpu)
> >  					VCPU_FPR(vcpu, op.reg), size, 1);
> >  			break;
> >  #endif
> > +#ifdef CONFIG_ALTIVEC
> > +		case STORE_VMX:
> > +			if (kvmppc_check_altivec_disabled(vcpu))
> > +				return EMULATE_DONE;
> > +
> > +			/* VMX access will need to be size aligned */
> > +			vcpu->arch.vaddr_accessed &= ~((unsigned long)size - 1);
> > +			vcpu->arch.paddr_accessed &= ~((unsigned long)size - 1);
> > +
> > +			/* if it is PR KVM, the FP/VEC/VSX registers need to
> > +			 * be flushed so that kvmppc_handle_store() can read
> > +			 * actual VMX vals from vcpu->arch.
> > +			 */
> > +			if (!is_kvmppc_hv_enabled(vcpu->kvm))
> 
> As before, I suggest just testing that the function pointer isn't
> NULL.
Got it.

Thanks,
- Simon
