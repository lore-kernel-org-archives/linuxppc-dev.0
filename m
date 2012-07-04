Return-Path: <B02008@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe006.messaging.microsoft.com [216.32.180.189])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 06A152C007B
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jul 2012 01:27:38 +1000 (EST)
From: Caraman Mihai Claudiu-B02008 <B02008@freescale.com>
To: Alexander Graf <agraf@suse.de>
Subject: RE: [Qemu-ppc] [RFC PATCH 12/17] PowerPC: booke64: Add DO_KVM
 kernel hooks
Date: Wed, 4 Jul 2012 15:27:30 +0000
Message-ID: <300B73AA675FCE4A93EB4FC1D42459FF15A6C6@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1340627195-11544-1-git-send-email-mihai.caraman@freescale.com>
 <1340627195-11544-13-git-send-email-mihai.caraman@freescale.com>
 <1B2CBB56-7180-4A73-8E51-6538A725F710@suse.de>
In-Reply-To: <1B2CBB56-7180-4A73-8E51-6538A725F710@suse.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "qemu-ppc@nongnu.org List" <qemu-ppc@nongnu.org>,
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

> -----Original Message-----
> From: Alexander Graf [mailto:agraf@suse.de]
> Sent: Wednesday, July 04, 2012 5:30 PM
> To: Caraman Mihai Claudiu-B02008
> Cc: <kvm-ppc@vger.kernel.org>; KVM list; linuxppc-dev; qemu-
> ppc@nongnu.org List; Benjamin Herrenschmidt
> Subject: Re: [Qemu-ppc] [RFC PATCH 12/17] PowerPC: booke64: Add DO_KVM
> kernel hooks
>=20
>=20
> On 25.06.2012, at 14:26, Mihai Caraman wrote:
>=20
> > Hook DO_KVM macro to 64-bit booke in a optimal way similar to 32-bit
> booke
> > see head_fsl_booke.S file. Extend interrupt handlers' parameter list
> with
> > interrupt vector numbers to accomodate the macro. Rework Guest Doorbell
> > handler to use the proper GSRRx save/restore registers.
> > Only the bolted version of tlb miss handers is addressed now.
> >
> > Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
> > ---
> > arch/powerpc/kernel/exceptions-64e.S |  114 ++++++++++++++++++++++++---
> -------
> > arch/powerpc/mm/tlb_low_64e.S        |   14 +++-
> > 2 files changed, 92 insertions(+), 36 deletions(-)
> >
> > diff --git a/arch/powerpc/kernel/exceptions-64e.S
> b/arch/powerpc/kernel/exceptions-64e.S
> > index 06f7aec..a60f81f 100644
> > --- a/arch/powerpc/kernel/exceptions-64e.S
> > +++ b/arch/powerpc/kernel/exceptions-64e.S
> > @@ -25,6 +25,8 @@
> > #include <asm/ppc-opcode.h>
> > #include <asm/mmu.h>
> > #include <asm/hw_irq.h>
> > +#include <asm/kvm_asm.h>
> > +#include <asm/kvm_booke_hv_asm.h>
> >
> > /* XXX This will ultimately add space for a special exception save
> >  *     structure used to save things like SRR0/SRR1, SPRGs, MAS, etc...
> > @@ -34,13 +36,24 @@
> >  */
> > #define	SPECIAL_EXC_FRAME_SIZE	INT_FRAME_SIZE
> >
> > +#ifdef CONFIG_KVM_BOOKE_HV
> > +#define KVM_BOOKE_HV_MFSPR(reg, spr)				\
> > +	BEGIN_FTR_SECTION					\
> > +		mfspr	reg, spr;			  	\
> > +	END_FTR_SECTION_IFSET(CPU_FTR_EMB_HV)
> > +#else
> > +#define KVM_BOOKE_HV_MFSPR(reg, spr)
> > +#endif
>=20
> Bleks - this is ugly.

I agree :) But I opted to keep the optimizations done for 32-bit.

> Do we really need to open-code the #ifdef here?

32-bit implementation fortunately use asm macros, we can't nest defines.

> Can't the feature section code determine that the feature is disabled and
> just always not include the code?

CPU_FTR_EMB_HV is set even if KVM is not configured.

>=20
> > +
> > /* Exception prolog code for all exceptions */
> > -#define EXCEPTION_PROLOG(n, type, srr0, srr1, addition)
> \
> > +#define EXCEPTION_PROLOG(n, intnum, type, srr0, srr1, addition)
> 	    \
> > 	mtspr	SPRN_SPRG_##type##_SCRATCH,r13;	/* get spare registers */
> \
> > 	mfspr	r13,SPRN_SPRG_PACA;	/* get PACA */			    \
> > 	std	r10,PACA_EX##type+EX_R10(r13);				    \
> > 	std	r11,PACA_EX##type+EX_R11(r13);				    \
> > 	mfcr	r10;			/* save CR */			    \
> > +	KVM_BOOKE_HV_MFSPR(r11,srr1);			    		    \
> > +	DO_KVM	intnum,srr1;				    		    \
>=20
> So if DO_KVM already knows srr1, why explicitly do something with it the
> line above, and not in DO_KVM itself?

srr1 is used to expand the interrupt handler symbol name while r11 is used
for the actual MSR[GS] optimal check:
	mtocrf	0x80, r11

> > -/* Guest Doorbell */
> > -	MASKABLE_EXCEPTION(0x2c0, guest_doorbell, .unknown_exception,
> ACK_NONE)
> > +/*
> > + *	Guest doorbell interrupt
> > + *	This general exception use GSRRx save/restore registers
> > + */
> > +	START_EXCEPTION(guest_doorbell);
> > +	EXCEPTION_PROLOG(0x2c0, BOOKE_INTERRUPT_GUEST_DBELL, GEN,
> > +			 SPRN_GSRR0, SPRN_GSRR1, PROLOG_ADDITION_NONE)
> > +	EXCEPTION_COMMON(0x2c0, PACA_EXGEN, INTS_KEEP)
> > +	addi	r3,r1,STACK_FRAME_OVERHEAD
> > +	bl	.save_nvgprs
> > +	INTS_RESTORE_HARD
> > +	bl	.unknown_exception
> > +	b	.ret_from_except
>=20
> This is independent of DO_KVM, right?

Yes, just kvm_handler definitions in bookehv_interrupts.S depends on this.

>=20
> >
> > /* Guest Doorbell critical Interrupt */
> > 	START_EXCEPTION(guest_doorbell_crit);
> > -	CRIT_EXCEPTION_PROLOG(0x2e0, PROLOG_ADDITION_NONE)
> > +	CRIT_EXCEPTION_PROLOG(0x2e0, BOOKE_INTERRUPT_GUEST_DBELL_CRIT,
> > +			      PROLOG_ADDITION_NONE)
>=20
> Shouldn't this one also use GSRR?

No, this is a critical exception.

> >
> > -.macro tlb_prolog_bolted addr
> > +.macro tlb_prolog_bolted intnum addr
> > 	mtspr	SPRN_SPRG_TLB_SCRATCH,r13
> > 	mfspr	r13,SPRN_SPRG_PACA
> > 	std	r10,PACA_EXTLB+EX_TLB_R10(r13)
> > 	mfcr	r10
> > 	std	r11,PACA_EXTLB+EX_TLB_R11(r13)
> > +#ifdef CONFIG_KVM_BOOKE_HV
> > +BEGIN_FTR_SECTION
> > +	mfspr	r11, SPRN_SRR1
> > +END_FTR_SECTION_IFSET(CPU_FTR_EMB_HV)
> > +#endif
>=20
> This thing really should vanish behind DO_KVM :)

Then let's do it first for 32-bit ;)

-Mike
