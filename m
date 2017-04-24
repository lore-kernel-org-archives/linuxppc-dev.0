Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wB8Pj5W32zDqH6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Apr 2017 11:48:25 +1000 (AEST)
Message-ID: <1492998468.25766.195.camel@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/powernv: Fix opal entry/exit MSR_RI coverage
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: Michael Ellerman <mpe@ellerman.id.au>, Mahesh Salgaonkar
 <mahesh@linux.vnet.ibm.com>
Date: Mon, 24 Apr 2017 11:47:48 +1000
In-Reply-To: <20170330121004.11991-1-npiggin@gmail.com>
References: <20170330121004.11991-1-npiggin@gmail.com>
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

On Thu, 2017-03-30 at 22:10 +1000, Nicholas Piggin wrote:
> There are some windows in opal entry/exit that can not recover from a
> re-entrant interrupt (e.g., machine check) due to using SRR registers,
> but they currently do not have MSR_RI clear.
> 
> These were found by machine check injection coverage tests using the
> powerpc system simulator (Mambo).

So you make us enter/exit OPAL with RI off with your patch.

OPAL currently won't re-enable it (which is a problem... we need to
deal with MCEs happening while in OPAL, especially the ones with
the special recovery table).

So if we do that we need to make OPAL turn it back on. In that case
I would suggest making OPAL also turn it back off, thus avoiding
touching FIXUP_ENDIAN...

Ben.

> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  arch/powerpc/boot/ppc_asm.h                    | 12 +++++++-----
>  arch/powerpc/include/asm/ppc_asm.h             | 10 ++++++----
>  arch/powerpc/platforms/powernv/opal-wrappers.S | 15 +++++++++------
>  3 files changed, 22 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/powerpc/boot/ppc_asm.h b/arch/powerpc/boot/ppc_asm.h
> index b03373d8b386..68e388ee94fe 100644
> --- a/arch/powerpc/boot/ppc_asm.h
> +++ b/arch/powerpc/boot/ppc_asm.h
> @@ -67,13 +67,15 @@
> >  #define MSR_LE		0x0000000000000001
>  
> >  #define FIXUP_ENDIAN						   \
> > > -	tdi   0, 0, 0x48; /* Reverse endian of b . + 8		*/ \
> > > > -	b     $+36;	  /* Skip trampoline if endian is good	*/ \
> > > -	.long 0x05009f42; /* bcl 20,31,$+4			*/ \
> > > -	.long 0xa602487d; /* mflr r10				*/ \
> > > -	.long 0x1c004a39; /* addi r10,r10,28			*/ \
> > > > +	tdi   0,0,0x48;	  /* Reverse endian of b . + 8		*/ \
> > > > +	b     $+44;	  /* Skip trampoline if endian is good	*/ \
> > >  	.long 0xa600607d; /* mfmsr r11				*/ \
> > >  	.long 0x01006b69; /* xori r11,r11,1			*/ \
> > > +	.long 0x00004039; /* li r10,0				*/ \
> > > +	.long 0x6401417d; /* mtmsrd r10,1			*/ \
> > > +	.long 0x05009f42; /* bcl 20,31,$+4			*/ \
> > > +	.long 0xa602487d; /* mflr r10				*/ \
> > > +	.long 0x14004a39; /* addi r10,r10,20			*/ \
> > >  	.long 0xa6035a7d; /* mtsrr0 r10				*/ \
> > >  	.long 0xa6037b7d; /* mtsrr1 r11				*/ \
> > >  	.long 0x2400004c  /* rfid				*/
> diff --git a/arch/powerpc/include/asm/ppc_asm.h b/arch/powerpc/include/asm/ppc_asm.h
> index 359c44341761..9d47cba1da3f 100644
> --- a/arch/powerpc/include/asm/ppc_asm.h
> +++ b/arch/powerpc/include/asm/ppc_asm.h
> @@ -770,12 +770,14 @@ END_FTR_SECTION_IFCLR(CPU_FTR_601)
>  #else
> >  #define FIXUP_ENDIAN						   \
> > > >  	tdi   0,0,0x48;	  /* Reverse endian of b . + 8		*/ \
> > > > -	b     $+36;	  /* Skip trampoline if endian is good	*/ \
> > > -	.long 0x05009f42; /* bcl 20,31,$+4			*/ \
> > > -	.long 0xa602487d; /* mflr r10				*/ \
> > > -	.long 0x1c004a39; /* addi r10,r10,28			*/ \
> > > > +	b     $+44;	  /* Skip trampoline if endian is good	*/ \
> > >  	.long 0xa600607d; /* mfmsr r11				*/ \
> > >  	.long 0x01006b69; /* xori r11,r11,1			*/ \
> > > +	.long 0x00004039; /* li r10,0				*/ \
> > > +	.long 0x6401417d; /* mtmsrd r10,1			*/ \
> > > +	.long 0x05009f42; /* bcl 20,31,$+4			*/ \
> > > +	.long 0xa602487d; /* mflr r10				*/ \
> > > +	.long 0x14004a39; /* addi r10,r10,20			*/ \
> > >  	.long 0xa6035a7d; /* mtsrr0 r10				*/ \
> > >  	.long 0xa6037b7d; /* mtsrr1 r11				*/ \
> > >  	.long 0x2400004c  /* rfid				*/
> diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
> index da8a0f7a035c..458109b1c291 100644
> --- a/arch/powerpc/platforms/powernv/opal-wrappers.S
> +++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
> > @@ -67,15 +67,14 @@ END_FTR_SECTION(0, 1);						\
> >  	OPAL_BRANCH(opal_tracepoint_entry) \
> > > >  	mfcr	r11;			\
> > > >  	stw	r11,8(r1);		\
> > > > -	li	r11,0;			\
> > > > -	ori	r11,r11,MSR_EE;		\
> > > >  	std	r12,PACASAVEDMSR(r13);	\
> > > > -	andc	r12,r12,r11;		\
> > > > -	mtmsrd	r12,1;			\
> > >  	LOAD_REG_ADDR(r11,opal_return);	\
> > > >  	mtlr	r11;			\
> > > -	li	r11,MSR_DR|MSR_IR|MSR_LE;\
> > > > > +	lis	r11,MSR_EE@h;		\
> > > +	ori	r11,r11,MSR_DR|MSR_IR|MSR_LE;\
> > > >  	andc	r12,r12,r11;		\
> > > > +	li	r11,0;			\
> > > > +	mtmsrd	r11,1; /* EE=0 RI=0 */	\
> > > >  	mtspr	SPRN_HSRR1,r12;		\
> > >  	LOAD_REG_ADDR(r11,opal);	\
> > > >  	ld	r12,8(r11);		\
> @@ -95,9 +94,11 @@ opal_return:
> > >  	lwz	r4,8(r1);
> > >  	ld	r5,PPC_LR_STKOFF(r1);
> > >  	ld	r6,PACASAVEDMSR(r13);
> > > +	mtcr	r4;
> > > +	li	r4,0;
> > > +	mtmsrd	r4,1; /* EE=0 RI=0 */
> > >  	mtspr	SPRN_SRR0,r5;
> > >  	mtspr	SPRN_SRR1,r6;
> > > -	mtcr	r4;
> >  	rfid
>  
>  opal_real_call:
> @@ -108,6 +109,8 @@ opal_real_call:
> > >  	mtlr	r11
> > >  	li	r11,MSR_LE
> > >  	andc	r12,r12,r11
> > > +	li	r11,0;
> > > +	mtmsrd	r11,1; /* EE=0 RI=0 */
> > >  	mtspr	SPRN_HSRR1,r12
> >  	LOAD_REG_ADDR(r11,opal)
> > >  	ld	r12,8(r11)
