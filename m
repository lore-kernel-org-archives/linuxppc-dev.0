Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pl0-x243.google.com (mail-pl0-x243.google.com
 [IPv6:2607:f8b0:400e:c01::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40wk1Q3YShzDrCl
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 May 2018 18:15:38 +1000 (AEST)
Received: by mail-pl0-x243.google.com with SMTP id t12-v6so10616558plo.7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 May 2018 01:15:38 -0700 (PDT)
Date: Wed, 30 May 2018 16:15:33 +0800
From: Simon Guo <wei.guo.simon@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@ozlabs.org>,
 "Naveen N.  Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Cyril Bur <cyrilbur@gmail.com>
Subject: Re: [PATCH v6 2/4] powerpc/64: enhance memcmp() with VMX instruction
 for long bytes comparision
Message-ID: <20180530081533.GC5951@simonLocalRHEL7.x64>
References: <1527221256-17029-1-git-send-email-wei.guo.simon@gmail.com>
 <1527221256-17029-3-git-send-email-wei.guo.simon@gmail.com>
 <87fu2c3s9q.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87fu2c3s9q.fsf@concordia.ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael,
On Mon, May 28, 2018 at 09:59:29PM +1000, Michael Ellerman wrote:
> Hi Simon,
> 
> wei.guo.simon@gmail.com writes:
> > diff --git a/arch/powerpc/lib/memcmp_64.S b/arch/powerpc/lib/memcmp_64.S
> > index f20e883..4ba7bb6 100644
> > --- a/arch/powerpc/lib/memcmp_64.S
> > +++ b/arch/powerpc/lib/memcmp_64.S
> > @@ -174,6 +235,13 @@ _GLOBAL(memcmp)
> >  	blr
> >  
> >  .Llong:
> > +#ifdef CONFIG_ALTIVEC
> > +	/* Try to use vmx loop if length is equal or greater than 4K */
> > +	cmpldi  cr6,r5,VMX_THRESH
> > +	bge	cr6,.Lsameoffset_vmx_cmp
> > +
> 
> Here we decide to use vmx, but we don't do any CPU feature checks.
> 
> 
> > @@ -332,7 +400,94 @@ _GLOBAL(memcmp)
> >  8:
> >  	blr
> >  
> > +#ifdef CONFIG_ALTIVEC
> > +.Lsameoffset_vmx_cmp:
> > +	/* Enter with src/dst addrs has the same offset with 8 bytes
> > +	 * align boundary
> > +	 */
> > +	ENTER_VMX_OPS
> > +	beq     cr1,.Llong_novmx_cmp
> > +
> > +3:
> > +	/* need to check whether r4 has the same offset with r3
> > +	 * for 16 bytes boundary.
> > +	 */
> > +	xor	r0,r3,r4
> > +	andi.	r0,r0,0xf
> > +	bne	.Ldiffoffset_vmx_cmp_start
> > +
> > +	/* len is no less than 4KB. Need to align with 16 bytes further.
> > +	 */
> > +	andi.	rA,r3,8
> > +	LD	rA,0,r3
> > +	beq	4f
> > +	LD	rB,0,r4
> > +	cmpld	cr0,rA,rB
> > +	addi	r3,r3,8
> > +	addi	r4,r4,8
> > +	addi	r5,r5,-8
> > +
> > +	beq	cr0,4f
> > +	/* save and restore cr0 */
> > +	mfocrf  r5,64
> > +	EXIT_VMX_OPS
> > +	mtocrf	64,r5
> > +	b	.LcmpAB_lightweight
> > +
> > +4:
> > +	/* compare 32 bytes for each loop */
> > +	srdi	r0,r5,5
> > +	mtctr	r0
> > +	clrldi  r5,r5,59
> > +	li	off16,16
> > +
> > +.balign 16
> > +5:
> > +	lvx 	v0,0,r3
> > +	lvx 	v1,0,r4
> > +	vcmpequd. v0,v0,v1
> 
> vcmpequd is only available on Power8 and later CPUs.
> 
> Which means this will crash on Power7 or earlier.
> 
> Something like this should fix it I think.
> 
> diff --git a/arch/powerpc/lib/memcmp_64.S b/arch/powerpc/lib/memcmp_64.S
> index 96eb08b2be2e..0a11ff14dcd9 100644
> --- a/arch/powerpc/lib/memcmp_64.S
> +++ b/arch/powerpc/lib/memcmp_64.S
> @@ -236,9 +236,11 @@ _GLOBAL(memcmp)
>  
>  .Llong:
>  #ifdef CONFIG_ALTIVEC
> +BEGIN_FTR_SECTION
>  	/* Try to use vmx loop if length is equal or greater than 4K */
>  	cmpldi  cr6,r5,VMX_THRESH
>  	bge	cr6,.Lsameoffset_vmx_cmp
> +END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
>  
>  .Llong_novmx_cmp:
>  #endif
Thanks for the good catch! I will update that.
> 
> 
> There's another problem which is that old toolchains don't know about
> vcmpequd. To fix that we'll need to add a macro that uses .long to
> construct the instruction.
Right. I will add the corresponding macros.

Thanks for your review.

BR,
 - Simon
