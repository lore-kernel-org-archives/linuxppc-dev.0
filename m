Return-Path: <R65777@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe005.messaging.microsoft.com [65.55.88.15])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3DDAD2C01EA
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Apr 2013 01:59:06 +1100 (EST)
From: Bhushan Bharat-R65777 <R65777@freescale.com>
To: Alexander Graf <agraf@suse.de>
Subject: RE: [PATCH] bookehv: Handle debug exception on guest exit
Date: Thu, 4 Apr 2013 14:58:55 +0000
Message-ID: <6A3DF150A5B70D4F9B66A25E3F7C888D06FC04D4@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1363801557-27436-1-git-send-email-Bharat.Bhushan@freescale.com>
 <436085E0-D605-40C1-BCDF-EB4D24B01AFA@suse.de>
In-Reply-To: <436085E0-D605-40C1-BCDF-EB4D24B01AFA@suse.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>
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
> Sent: Thursday, April 04, 2013 6:55 PM
> To: Bhushan Bharat-R65777
> Cc: linuxppc-dev@lists.ozlabs.org; kvm@vger.kernel.org; kvm-ppc@vger.kern=
el.org;
> Wood Scott-B07421; Bhushan Bharat-R65777
> Subject: Re: [PATCH] bookehv: Handle debug exception on guest exit
>=20
>=20
> On 20.03.2013, at 18:45, Bharat Bhushan wrote:
>=20
> > EPCR.DUVD controls whether the debug events can come in hypervisor
> > mode or not. When KVM guest is using the debug resource then we do not
> > want debug events to be captured in guest entry/exit path. So we set
> > EPCR.DUVD when entering and clears EPCR.DUVD when exiting from guest.
> >
> > Debug instruction complete is a post-completion debug exception but
> > debug event gets posted on the basis of MSR before the instruction is
> > executed. Now if the instruction switches the context from guest mode
> > (MSR.GS =3D 1) to hypervisor mode (MSR.GS =3D 0) then the xSRR0 points =
to
> > first instruction of KVM handler and xSRR1 points that MSR.GS is clear
> > (hypervisor context). Now as xSRR1.GS is used to decide whether KVM
> > handler will be invoked to handle the exception or host host kernel
> > debug handler will be invoked to handle the exception.
> > This leads to host kernel debug handler handling the exception which
> > should either be handled by KVM.
> >
> > This is tested on e500mc in 32 bit mode
> >
> > Signed-off-by: Bharat Bhushan <bharat.bhushan@freescale.com>
> > ---
> > v0:
> > - Do not apply this change for debug_crit as we do not know those chips=
 have
> issue or not.
> > - corrected 64bit case branching
> >
> > arch/powerpc/kernel/exceptions-64e.S |   29 +++++++++++++++++++++++++++=
+-
> > arch/powerpc/kernel/head_booke.h     |   26 ++++++++++++++++++++++++++
> > 2 files changed, 54 insertions(+), 1 deletions(-)
> >
> > diff --git a/arch/powerpc/kernel/exceptions-64e.S
> > b/arch/powerpc/kernel/exceptions-64e.S
> > index 4684e33..8b26294 100644
> > --- a/arch/powerpc/kernel/exceptions-64e.S
> > +++ b/arch/powerpc/kernel/exceptions-64e.S
> > @@ -516,6 +516,33 @@ kernel_dbg_exc:
> > 	andis.	r15,r14,DBSR_IC@h
> > 	beq+	1f
> >
> > +#ifdef CONFIG_KVM_BOOKE_HV
> > +	/*
> > +	 * EPCR.DUVD controls whether the debug events can come in
> > +	 * hypervisor mode or not. When KVM guest is using the debug
> > +	 * resource then we do not want debug events to be captured
> > +	 * in guest entry/exit path. So we set EPCR.DUVD when entering
> > +	 * and clears EPCR.DUVD when exiting from guest.
> > +	 * Debug instruction complete is a post-completion debug
> > +	 * exception but debug event gets posted on the basis of MSR
> > +	 * before the instruction is executed. Now if the instruction
> > +	 * switches the context from guest mode (MSR.GS =3D 1) to hypervisor
> > +	 * mode (MSR.GS =3D 0) then the xSRR0 points to first instruction of
>=20
> Can't we just execute that code path with MSR.DE=3D0?

Single stepping uses DBCR0.IC (instruction complete).
Can you describe how MSR.DE =3D 0 will work?

>=20
>=20
> Alex
>=20
> > +	 * KVM handler and xSRR1 points that MSR.GS is clear
> > +	 * (hypervisor context). Now as xSRR1.GS is used to decide whether
> > +	 * KVM handler will be invoked to handle the exception or host
> > +	 * host kernel debug handler will be invoked to handle the exception.
> > +	 * This leads to host kernel debug handler handling the exception
> > +	 * which should either be handled by KVM.
> > +	 */
> > +	mfspr	r10, SPRN_EPCR
> > +	andis.	r10,r10,SPRN_EPCR_DUVD@h
> > +	beq+	2f
> > +
> > +	andis.	r10,r9,MSR_GS@h
> > +	beq+	3f
> > +2:
> > +#endif
> > 	LOAD_REG_IMMEDIATE(r14,interrupt_base_book3e)
> > 	LOAD_REG_IMMEDIATE(r15,interrupt_end_book3e)
> > 	cmpld	cr0,r10,r14
> > @@ -523,7 +550,7 @@ kernel_dbg_exc:
> > 	blt+	cr0,1f
> > 	bge+	cr1,1f
> >
> > -	/* here it looks like we got an inappropriate debug exception. */
> > +3:	/* here it looks like we got an inappropriate debug exception. */
> > 	lis	r14,DBSR_IC@h		/* clear the IC event */
> > 	rlwinm	r11,r11,0,~MSR_DE	/* clear DE in the DSRR1 value */
> > 	mtspr	SPRN_DBSR,r14
> > diff --git a/arch/powerpc/kernel/head_booke.h
> > b/arch/powerpc/kernel/head_booke.h
> > index 5f051ee..edc6a3b 100644
> > --- a/arch/powerpc/kernel/head_booke.h
> > +++ b/arch/powerpc/kernel/head_booke.h
> > @@ -285,7 +285,33 @@ label:
> > 	mfspr	r10,SPRN_DBSR;		/* check single-step/branch taken */  \
> > 	andis.	r10,r10,(DBSR_IC|DBSR_BT)@h;				      \
> > 	beq+	2f;							      \
> > +#ifdef CONFIG_KVM_BOOKE_HV						      \
> > +	/*								      \
> > +	 * EPCR.DUVD controls whether the debug events can come in	      \
> > +	 * hypervisor mode or not. When KVM guest is using the debug	      \
> > +	 * resource then we do not want debug events to be captured 	      \
> > +	 * in guest entry/exit path. So we set EPCR.DUVD when entering	      =
\
> > +	 * and clears EPCR.DUVD when exiting from guest.		      \
> > +	 * Debug instruction complete is a post-completion debug	      \
> > +	 * exception but debug event gets posted on the basis of MSR	      \
> > +	 * before the instruction is executed. Now if the instruction	      \
> > +	 * switches the context from guest mode (MSR.GS =3D 1) to hypervisor =
   \
> > +	 * mode (MSR.GS =3D 0) then the xSRR0 points to first instruction of =
   \
> > +	 * KVM handler and xSRR1 points that MSR.GS is clear 		      \
> > +	 * (hypervisor context). Now as xSRR1.GS is used to decide whether   =
 \
> > +	 * KVM handler will be invoked to handle the exception or host	      =
\
> > +	 * host kernel debug handler will be invoked to handle the exception.=
 \
> > +	 * This leads to host kernel debug handler handling the exception    =
 \
> > +	 * which should either be handled by KVM.			      \
> > +	 */								      \
> > +	mfspr	r10, SPRN_EPCR;						      \
> > +	andis.	r10,r10,SPRN_EPCR_DUVD@h;				      \
> > +	beq+	3f;							      \
> > 									      \
> > +	andis.	r10,r9,MSR_GS@h;				    	      \
> > +	beq+	1f;							      \
> > +3:									      \
> > +#endif									      \
> > 	lis	r10,KERNELBASE@h;	/* check if exception in vectors */   \
> > 	ori	r10,r10,KERNELBASE@l;					      \
> > 	cmplw	r12,r10;						      \
> > --
> > 1.7.0.4
> >
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe kvm-ppc" in
> > the body of a message to majordomo@vger.kernel.org More majordomo info
> > at  http://vger.kernel.org/majordomo-info.html
>=20
