Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 676802C0080
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jul 2012 08:25:44 +1000 (EST)
Message-ID: <1341440735.16808.42.camel@pasglop>
Subject: Re: [Qemu-ppc] [RFC PATCH 12/17] PowerPC: booke64: Add DO_KVM
 kernel hooks
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alexander Graf <agraf@suse.de>
Date: Thu, 05 Jul 2012 08:25:35 +1000
In-Reply-To: <1B2CBB56-7180-4A73-8E51-6538A725F710@suse.de>
References: <1340627195-11544-1-git-send-email-mihai.caraman@freescale.com>
 <1340627195-11544-13-git-send-email-mihai.caraman@freescale.com>
 <1B2CBB56-7180-4A73-8E51-6538A725F710@suse.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: "qemu-ppc@nongnu.org List" <qemu-ppc@nongnu.org>,
 Mihai Caraman <mihai.caraman@freescale.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, KVM list <kvm@vger.kernel.org>,
 "<kvm-ppc@vger.kernel.org>" <kvm-ppc@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2012-07-04 at 16:29 +0200, Alexander Graf wrote:
 
> > +#ifdef CONFIG_KVM_BOOKE_HV
> > +#define KVM_BOOKE_HV_MFSPR(reg, spr)				\
> > +	BEGIN_FTR_SECTION					\
> > +		mfspr	reg, spr;			  	\
> > +	END_FTR_SECTION_IFSET(CPU_FTR_EMB_HV)
> > +#else
> > +#define KVM_BOOKE_HV_MFSPR(reg, spr)
> > +#endif
> 
> Bleks - this is ugly. Do we really need to open-code the #ifdef here?
> Can't the feature section code determine that the feature is disabled
> and just always not include the code?

You can't but in any case I don't see the point of the conditional here,
we'll eventually have to load srr1 no ? We can move the load up to here
in all cases or can't we ? If really not, we could have it inside DO_KVM
and be done with it no ?

> > +
> > /* Exception prolog code for all exceptions */
> > -#define EXCEPTION_PROLOG(n, type, srr0, srr1, addition)		     	    \
> > +#define EXCEPTION_PROLOG(n, intnum, type, srr0, srr1, addition)		    \
> > 	mtspr	SPRN_SPRG_##type##_SCRATCH,r13;	/* get spare registers */   \
> > 	mfspr	r13,SPRN_SPRG_PACA;	/* get PACA */			    \
> > 	std	r10,PACA_EX##type+EX_R10(r13);				    \
> > 	std	r11,PACA_EX##type+EX_R11(r13);				    \
> > 	mfcr	r10;			/* save CR */			    \
> > +	KVM_BOOKE_HV_MFSPR(r11,srr1);			    		    \
> > +	DO_KVM	intnum,srr1;				    		    \
> 
> So if DO_KVM already knows srr1, why explicitly do something with it
> the line above, and not in DO_KVM itself?

Yeah that or just move things around in the prolog.

> > 	addition;			/* additional code for that exc. */ \
> > 	std	r1,PACA_EX##type+EX_R1(r13); /* save old r1 in the PACA */  \
> > 	stw	r10,PACA_EX##type+EX_CR(r13); /* save old CR in the PACA */ \
> > @@ -69,17 +82,21 @@
> > 	ld	r1,PACA_MC_STACK(r13);					    \
> > 	subi	r1,r1,SPECIAL_EXC_FRAME_SIZE;
> > 
> > -#define NORMAL_EXCEPTION_PROLOG(n, addition)				    \
> > -	EXCEPTION_PROLOG(n, GEN, SPRN_SRR0, SPRN_SRR1, addition##_GEN(n))
> > +#define NORMAL_EXCEPTION_PROLOG(n, intnum, addition)			    \
> > +	EXCEPTION_PROLOG(n, intnum, GEN, SPRN_SRR0, SPRN_SRR1,		    \
> 
> We would we want to pass in 2 numbers? Let's please confine this onto
> a single ID per interrupt vector. Either we use the hardcoded ones
> available here in the KVM code or we use the KVM ones instead of the
> hardcoded ones here. But not both please. Just because it's like that
> on 32bit doesn't count as an excuse :).

Right. Also I already objected to the explicit passing of the srr's
anyway.

Cheers,
Ben.
