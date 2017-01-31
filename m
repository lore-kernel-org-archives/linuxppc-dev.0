Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vCMkk5VHjzDq96
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jan 2017 21:22:06 +1100 (AEDT)
Received: by mail-pf0-x243.google.com with SMTP id f144so27175302pfa.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jan 2017 02:22:06 -0800 (PST)
Date: Tue, 31 Jan 2017 20:21:43 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Paul Mackerras <paulus@ozlabs.org>
Cc: Alexander Graf <agraf@suse.com>, kvm-ppc@vger.kernel.org, Michael
 Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 3/3] KVM: PPC: Book3S: 64-bit CONFIG_RELOCATABLE support
 for interrupts
Message-ID: <20170131202143.4033c5ea@roar.ozlabs.ibm.com>
In-Reply-To: <20170131080152.GA2112@fergus.ozlabs.ibm.com>
References: <20161221182927.24562-1-npiggin@gmail.com>
 <20161221182927.24562-4-npiggin@gmail.com>
 <20170131080152.GA2112@fergus.ozlabs.ibm.com>
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

On Tue, 31 Jan 2017 19:01:52 +1100
Paul Mackerras <paulus@ozlabs.org> wrote:

> On Thu, Dec 22, 2016 at 04:29:27AM +1000, Nicholas Piggin wrote:
> > 64-bit Book3S exception handlers must find the dynamic kernel base
> > to add to the target address when branching beyond __end_interrupts,
> > in order to support kernel running at non-0 physical address.
> > 
> > Support this in KVM by branching with CTR, similarly to regular
> > interrupt handlers. The guest CTR saved in HSTATE_SCRATCH1 and
> > restored after the branch.
> > 
> > Without this, the host kernel hangs and crashes randomly when it is
> > running at a non-0 address and a KVM guest is started.
> > 
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>  
> 
> Unfortunately, this patch causes guests to crash in various ways when
> running under a CONFIG_RELOCATABLE kernel.  See below...
> 
> > diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> > index 11882aac8216..c18ce740452b 100644
> > --- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> > +++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> > @@ -1060,15 +1060,16 @@ kvmppc_interrupt_hv:
> >  	 * R12		= (guest CR << 32) | interrupt vector
> >  	 * R13		= PACA
> >  	 * guest R12 saved in shadow VCPU SCRATCH0
> > +	 * guest CTR saved in shadow VCPU SCRATCH1 if RELOCATABLE
> >  	 * guest R13 saved in SPRN_SCRATCH0
> >  	 */
> > -	std	r9, HSTATE_SCRATCH1(r13)
> > +	std	r9, HSTATE_SCRATCH2(r13)
> >  	lbz	r9, HSTATE_IN_GUEST(r13)
> >  	cmpwi	r9, KVM_GUEST_MODE_HOST_HV
> >  	beq	kvmppc_bad_host_intr
> >  #ifdef CONFIG_KVM_BOOK3S_PR_POSSIBLE
> >  	cmpwi	r9, KVM_GUEST_MODE_GUEST
> > -	ld	r9, HSTATE_SCRATCH1(r13)
> > +	ld	r9, HSTATE_SCRATCH2(r13)
> >  	beq	kvmppc_interrupt_pr
> >  #endif
> >  	/* We're now back in the host but in guest MMU context */
> > @@ -1088,7 +1089,7 @@ kvmppc_interrupt_hv:
> >  	std	r6, VCPU_GPR(R6)(r9)
> >  	std	r7, VCPU_GPR(R7)(r9)
> >  	std	r8, VCPU_GPR(R8)(r9)
> > -	ld	r0, HSTATE_SCRATCH1(r13)
> > +	ld	r0, HSTATE_SCRATCH2(r13)
> >  	std	r0, VCPU_GPR(R9)(r9)
> >  	std	r10, VCPU_GPR(R10)(r9)
> >  	std	r11, VCPU_GPR(R11)(r9)
> > @@ -1151,7 +1152,11 @@ END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
> >  11:	stw	r3,VCPU_HEIR(r9)
> >  
> >  	/* these are volatile across C function calls */
> > +#ifdef CONFIG_RELOCATABLE
> > +	ld	r3, HSTATE_SCRATCH1(r13)  
> 
> The problem is here.  Depending on what sort of interrupt it is, we
> can end up going back to the guest via fast_guest_return, which
> doesn't reload CTR.  Adding
> 
> 	mtctr	r3
> 
> at this point makes things work.

Thanks for tracking it down. Not enough testing on my end, I'm
sorry.

Thanks,
Nick
