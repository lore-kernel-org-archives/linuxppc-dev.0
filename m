Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 8B489B6EEA
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Feb 2012 07:47:43 +1100 (EST)
Message-ID: <1328820440.2903.72.camel@pasglop>
Subject: Re: [PATCH v2] powerpc: Rework lazy-interrupt handling
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Tudor Laurentiu <Laurentiu.Tudor@freescale.com>
Date: Fri, 10 Feb 2012 07:47:20 +1100
In-Reply-To: <4F33FC65.40702@freescale.com>
References: <1328761532.2903.53.camel@pasglop> <4F33FC65.40702@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>, Stuart Yoder <b08248@gmail.com>,
 Anton Blanchard <anton@au1.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Paul Mackerras <pmac@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2012-02-09 at 19:03 +0200, Tudor Laurentiu wrote:

> > +masked_interrupt_book3e_0x900:
> > +	ACK_DEC(r11);
> > +	li	r11,PACA_HAPPENED_DEC
> > +	b	masked_interrupt_book3e_no_mask
> > +masked_interrupt_book3e_0x980:
> > +	ACK_FIT(r11);
> > +	li	r11,PACA_HAPPENED_DEC
> > +	b	masked_interrupt_book3e_no_mask
> > +masked_interrupt_book3e_0x280:
> > +masked_interrupt_book3e_0x2c0:
> > +	li	r11,PACA_HAPPENED_DBELL
> > +	b	masked_interrupt_book3e_no_mask
> > +
> > +masked_interrupt_book3e_no_mask:
> > +	mtcr	r10
> > +	lbz	r10,PACAIRQHAPPENED(r13)
> > +	ori	r10,r10,r11
> 
> Shouldn't this be an 'or'?

Yes, absolutely. This is a typo/thinko I do all the time ... oops.

> > +	stb	r10,PACAIRQHAPPENED(r13)
> > +	b	1f
> > +masked_interrupt_book3e_full_mask:
> >   	mtcr	r10
> > -masked_interrupt_book3e_common:
> > -	stb	r11,PACAHARDIRQEN(r13)
> > +	lbz	r10,PACAIRQHAPPENED(r13)
> > +	ori	r10,r10,r11
> 
> Same comment.

I'll respin and fix.

Cheers,
Ben

> > +	stb	r10,PACAIRQHAPPENED(r13)
> >   	mfspr	r10,SPRN_SRR1
> >   	rldicl	r11,r10,48,1		/* clear MSR_EE */
> >   	rotldi	r10,r11,16
> >   	mtspr	SPRN_SRR1,r10
> > -	ld	r10,PACA_EXGEN+EX_R10(r13);	/* restore registers */
> > +1:	ld	r10,PACA_EXGEN+EX_R10(r13);
> >   	ld	r11,PACA_EXGEN+EX_R11(r13);
> >   	mfspr	r13,SPRN_SPRG_GEN_SCRATCH;
> >   	rfi
> >   	b	.
> >
> >   /*
> > + * Called from arch_local_irq_enable when an interrupt needs
> > + * to be resent. r3 contains either 0x500,0x900,0x260 or 0x280
> > + * to indicate the kind of interrupt. MSR:EE is already off.
> > + * We generate a stackframe like if a real interrupt had happened.
> > + *
> > + * Note: While MSR:EE is off, we need to make sure that _MSR
> > + * in the generated frame has EE set to 1 or the exception
> > + * handler will not properly re-enable them.
> > + */
> > +_GLOBAL(__reemit_interrupt)
> > +	/* We are going to jump to the exception common code which
> > +	 * will retrieve various register values from the PACA which
> > +	 * we don't give a damn about.
> > +	 */
> > +	mflr	r10
> > +	mfmsr	r11
> > +	mfcr	r4;
> > +	mtspr	SPRN_SPRG_GEN_SCRATCH,r13;
> > +	std	r1,PACA_EXGEN+EX_R1(r13);
> > +	stw	r4,PACA_EXGEN+EX_CR(r13);
> > +	ori	r11,r11,MSR_EE
> > +	subi	r1,r1,INT_FRAME_SIZE;
> > +	cmpwi	cr0,r3,0x500
> > +	beq	exc_0x500_common
> > +	cmpwi	cr0,r3,0x900
> > +	beq+	exc_0x900_common
> > +	cmpwi	cr0,r3,0x280
> > +	beq+	exc_0x280_common
> > +	blr
> > +
> > +/*
> >    * This is called from 0x300 and 0x400 handlers after the prologs with
> >    * r14 and r15 containing the fault address and error code, with the
> >    * original values stashed away in the PACA
> > @@ -680,6 +762,8 @@ BAD_STACK_TRAMPOLINE(0x000)
> >   BAD_STACK_TRAMPOLINE(0x100)
> >   BAD_STACK_TRAMPOLINE(0x200)
> >   BAD_STACK_TRAMPOLINE(0x260)
> > +BAD_STACK_TRAMPOLINE(0x280)
> > +BAD_STACK_TRAMPOLINE(0x2a0)
> >   BAD_STACK_TRAMPOLINE(0x2c0)
> >   BAD_STACK_TRAMPOLINE(0x2e0)
> >   BAD_STACK_TRAMPOLINE(0x300)
> 
> ---
> Best Regards, Laurentiu
