Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40lcd12pJdzF2MH
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 May 2018 22:41:25 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id w129-v6so7684371pfd.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 May 2018 05:41:25 -0700 (PDT)
Date: Tue, 15 May 2018 20:41:19 +0800
From: Simon Guo <wei.guo.simon@gmail.com>
To: Paul Mackerras <paulus@ozlabs.org>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
Subject: Re: [PATCH v2 07/30] KVM: PPC: Book3S PR: add C function wrapper for
 _kvmppc_save/restore_tm()
Message-ID: <20180515124119.GB10886@simonLocalRHEL7.x64>
References: <1519753057-11059-1-git-send-email-wei.guo.simon@gmail.com>
 <1519753057-11059-8-git-send-email-wei.guo.simon@gmail.com>
 <20180515060548.GB28451@fergus.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180515060548.GB28451@fergus.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, May 15, 2018 at 04:05:48PM +1000, Paul Mackerras wrote:
> On Wed, Feb 28, 2018 at 01:37:14AM +0800, wei.guo.simon@gmail.com wrote:
> > From: Simon Guo <wei.guo.simon@gmail.com>
> > 
> > Currently _kvmppc_save/restore_tm() APIs can only be invoked from
> > assembly function. This patch adds C function wrappers for them so
> > that they can be safely called from C function.
> > 
> > Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
> 
> Some relatively minor comments below:
> 
> > diff --git a/arch/powerpc/kvm/tm.S b/arch/powerpc/kvm/tm.S
> > index 2d6fe5b..269dd11 100644
> > --- a/arch/powerpc/kvm/tm.S
> > +++ b/arch/powerpc/kvm/tm.S
> > @@ -35,7 +35,7 @@
> >   * This can modify all checkpointed registers, but
> >   * restores r1, r2 before exit.
> >   */
> > -_GLOBAL(kvmppc_save_tm)
> > +_GLOBAL(__kvmppc_save_tm)
> >  	mflr	r0
> >  	std	r0, PPC_LR_STKOFF(r1)
> >  
> > @@ -149,6 +149,52 @@ _GLOBAL(kvmppc_save_tm)
> >  	blr
> >  
> >  /*
> > + * _kvmppc_save_tm() is a wrapper around __kvmppc_save_tm(), so that it can
> > + * be invoked from C function by PR KVM only.
> > + */
> > +_GLOBAL(_kvmppc_save_tm_pr)
> 
> The comment doesn't match the actual function name.
I will correct that. Thanks for point it out.

> 
> > +	mflr	r5
> > +	std	r5, PPC_LR_STKOFF(r1)
> > +	stdu    r1, -SWITCH_FRAME_SIZE(r1)
> > +	SAVE_NVGPRS(r1)
> > +
> > +	/* save MSR since TM/math bits might be impacted
> > +	 * by __kvmppc_save_tm().
> > +	 */
> > +	mfmsr	r5
> > +	SAVE_GPR(5, r1)
> > +
> > +	/* also save DSCR/CR so that it can be recovered later */
> > +	mfspr   r6, SPRN_DSCR
> > +	SAVE_GPR(6, r1)
> > +
> > +	mfcr    r7
> > +	stw     r7, _CCR(r1)
> > +
> > +	bl	__kvmppc_save_tm
> > +
> > +	ld      r7, _CCR(r1)
> > +	mtcr	r7
> > +
> > +	REST_GPR(6, r1)
> > +	mtspr   SPRN_DSCR, r6
> > +
> > +	/* need preserve current MSR's MSR_TS bits */
> > +	REST_GPR(5, r1)
> > +	mfmsr   r6
> > +	rldicl  r6, r6, 64 - MSR_TS_S_LG, 62
> > +	rldimi  r5, r6, MSR_TS_S_LG, 63 - MSR_TS_T_LG
> > +	mtmsrd  r5
> > +
> > +	REST_NVGPRS(r1)
> > +	addi    r1, r1, SWITCH_FRAME_SIZE
> > +	ld	r5, PPC_LR_STKOFF(r1)
> > +	mtlr	r5
> > +	blr
> > +
> > +EXPORT_SYMBOL_GPL(_kvmppc_save_tm_pr);
> > +
> > +/*
> >   * Restore transactional state and TM-related registers.
> >   * Called with:
> >   *  - r3 pointing to the vcpu struct.
> > @@ -158,7 +204,7 @@ _GLOBAL(kvmppc_save_tm)
> >   * This potentially modifies all checkpointed registers.
> >   * It restores r1, r2 from the PACA.
> >   */
> > -_GLOBAL(kvmppc_restore_tm)
> > +_GLOBAL(__kvmppc_restore_tm)
> >  	mflr	r0
> >  	std	r0, PPC_LR_STKOFF(r1)
> >  
> > @@ -186,6 +232,7 @@ _GLOBAL(kvmppc_restore_tm)
> >  	rldicl. r5, r5, 64 - MSR_TS_S_LG, 62
> >  	beqlr		/* TM not active in guest */
> >  	std	r1, HSTATE_SCRATCH2(r13)
> > +	std	r3, HSTATE_SCRATCH1(r13)
> 
> Why do we need to save r3 here and restore it below?
I think it is a legacy change when I did TM save/restore on each trap from
guest to host. It can be removed now.

> 
> >  
> >  	/* Make sure the failure summary is set, otherwise we'll program check
> >  	 * when we trechkpt.  It's possible that this might have been not set
> > @@ -262,6 +309,7 @@ _GLOBAL(kvmppc_restore_tm)
> >  	ld	r29, HSTATE_DSCR(r13)
> >  	mtspr	SPRN_DSCR, r29
> >  #endif
> > +	ld	r3, HSTATE_SCRATCH1(r13)
> >  	ld	r1, HSTATE_SCRATCH2(r13)
> >  	ld	r2, PACATMSCRATCH(r13)
> >  
> > @@ -273,4 +321,47 @@ _GLOBAL(kvmppc_restore_tm)
> >  	mtlr	r0
> >  	blr
> >  
> > +/*
> > + * _kvmppc_restore_tm() is a wrapper around __kvmppc_restore_tm(), so that it
> > + * can be invoked from C function by PR KVM only.
> > + */
> > +_GLOBAL(_kvmppc_restore_tm_pr)
> 
> Again, comment doesn't match the actual function name.
I will correct that.

Thanks,
 - Simon
