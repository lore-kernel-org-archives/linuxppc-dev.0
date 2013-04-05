Return-Path: <R65777@freescale.com>
Received: from db3outboundpool.messaging.microsoft.com
 (db3ehsobe003.messaging.microsoft.com [213.199.154.141])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 622FD2C00B1
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Apr 2013 18:53:54 +1100 (EST)
From: Bhushan Bharat-R65777 <R65777@freescale.com>
To: Alexander Graf <agraf@suse.de>, Kumar Gala <galak@kernel.crashing.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: RE: [PATCH] bookehv: Handle debug exception on guest exit
Date: Fri, 5 Apr 2013 07:53:43 +0000
Message-ID: <6A3DF150A5B70D4F9B66A25E3F7C888D06FC1773@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1363801557-27436-1-git-send-email-Bharat.Bhushan@freescale.com>
 <436085E0-D605-40C1-BCDF-EB4D24B01AFA@suse.de>
 <6A3DF150A5B70D4F9B66A25E3F7C888D06FC04D4@039-SN2MPN1-013.039d.mgd.msft.net>
In-Reply-To: <6A3DF150A5B70D4F9B66A25E3F7C888D06FC04D4@039-SN2MPN1-013.039d.mgd.msft.net>
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

Hi Kumar/Benh,

After further looking into the code I think that if we correct the vector r=
ange below in DebugDebug handler then we do not need the change I provided =
in this patch.

Here is the snapshot for 32 bit (head_booke.h, same will be true for 64 bit=
):

#define DEBUG_DEBUG_EXCEPTION                                              =
   \
        START_EXCEPTION(DebugDebug);                                       =
   \
        DEBUG_EXCEPTION_PROLOG;                                            =
   \
                                                                           =
   \
        /*                                                                 =
   \
         * If there is a single step or branch-taken exception in an       =
   \
         * exception entry sequence, it was probably meant to apply to     =
   \
         * the code where the exception occurred (since exception entry    =
   \
         * doesn't turn off DE automatically).  We simulate the effect     =
   \
         * of turning off DE on entry to an exception handler by turning   =
   \
         * off DE in the DSRR1 value and clearing the debug status.        =
   \
         */                                                                =
   \
        mfspr   r10,SPRN_DBSR;          /* check single-step/branch taken *=
/  \
        andis.  r10,r10,(DBSR_IC|DBSR_BT)@h;                               =
   \
        beq+    2f;                                                        =
   \
                                                                           =
   \
        lis     r10,KERNELBASE@h;       /* check if exception in vectors */=
   \
        ori     r10,r10,KERNELBASE@l;                                      =
   \
        cmplw   r12,r10;                                                   =
   \
        blt+    2f;                     /* addr below exception vectors */ =
   \
                                                                           =
   \
        lis     r10,DebugDebug@h;                                        \
        ori     r10,r10,DebugDebug@l;                                      =
      \

^^^^
	Here we assume all exception vector ends at DebugDebug, which is not corre=
ct.
	We probably should get proper end by using some start_vector and end_vecto=
r lebels
	or at least use end at Ehvpriv (which is last defined in head_fsl_booke.S =
for PowerPC. Is that correct?

=09
        cmplw   r12,r10;                                                   =
   \
        bgt+    2f;                     /* addr above exception vectors */ =
   \

Thanks
-Bharat


> -----Original Message-----
> From: kvm-ppc-owner@vger.kernel.org [mailto:kvm-ppc-owner@vger.kernel.org=
] On
> Behalf Of Bhushan Bharat-R65777
> Sent: Thursday, April 04, 2013 8:29 PM
> To: Alexander Graf
> Cc: linuxppc-dev@lists.ozlabs.org; kvm@vger.kernel.org; kvm-ppc@vger.kern=
el.org;
> Wood Scott-B07421
> Subject: RE: [PATCH] bookehv: Handle debug exception on guest exit
>=20
>=20
>=20
> > -----Original Message-----
> > From: Alexander Graf [mailto:agraf@suse.de]
> > Sent: Thursday, April 04, 2013 6:55 PM
> > To: Bhushan Bharat-R65777
> > Cc: linuxppc-dev@lists.ozlabs.org; kvm@vger.kernel.org;
> > kvm-ppc@vger.kernel.org; Wood Scott-B07421; Bhushan Bharat-R65777
> > Subject: Re: [PATCH] bookehv: Handle debug exception on guest exit
> >
> >
> > On 20.03.2013, at 18:45, Bharat Bhushan wrote:
> >
> > > EPCR.DUVD controls whether the debug events can come in hypervisor
> > > mode or not. When KVM guest is using the debug resource then we do
> > > not want debug events to be captured in guest entry/exit path. So we
> > > set EPCR.DUVD when entering and clears EPCR.DUVD when exiting from gu=
est.
> > >
> > > Debug instruction complete is a post-completion debug exception but
> > > debug event gets posted on the basis of MSR before the instruction
> > > is executed. Now if the instruction switches the context from guest
> > > mode (MSR.GS =3D 1) to hypervisor mode (MSR.GS =3D 0) then the xSRR0
> > > points to first instruction of KVM handler and xSRR1 points that
> > > MSR.GS is clear (hypervisor context). Now as xSRR1.GS is used to
> > > decide whether KVM handler will be invoked to handle the exception
> > > or host host kernel debug handler will be invoked to handle the excep=
tion.
> > > This leads to host kernel debug handler handling the exception which
> > > should either be handled by KVM.
> > >
> > > This is tested on e500mc in 32 bit mode
> > >
> > > Signed-off-by: Bharat Bhushan <bharat.bhushan@freescale.com>
> > > ---
> > > v0:
> > > - Do not apply this change for debug_crit as we do not know those
> > > chips have
> > issue or not.
> > > - corrected 64bit case branching
> > >
> > > arch/powerpc/kernel/exceptions-64e.S |   29 +++++++++++++++++++++++++=
+++-
> > > arch/powerpc/kernel/head_booke.h     |   26 +++++++++++++++++++++++++=
+
> > > 2 files changed, 54 insertions(+), 1 deletions(-)
> > >
> > > diff --git a/arch/powerpc/kernel/exceptions-64e.S
> > > b/arch/powerpc/kernel/exceptions-64e.S
> > > index 4684e33..8b26294 100644
> > > --- a/arch/powerpc/kernel/exceptions-64e.S
> > > +++ b/arch/powerpc/kernel/exceptions-64e.S
> > > @@ -516,6 +516,33 @@ kernel_dbg_exc:
> > > 	andis.	r15,r14,DBSR_IC@h
> > > 	beq+	1f
> > >
> > > +#ifdef CONFIG_KVM_BOOKE_HV
> > > +	/*
> > > +	 * EPCR.DUVD controls whether the debug events can come in
> > > +	 * hypervisor mode or not. When KVM guest is using the debug
> > > +	 * resource then we do not want debug events to be captured
> > > +	 * in guest entry/exit path. So we set EPCR.DUVD when entering
> > > +	 * and clears EPCR.DUVD when exiting from guest.
> > > +	 * Debug instruction complete is a post-completion debug
> > > +	 * exception but debug event gets posted on the basis of MSR
> > > +	 * before the instruction is executed. Now if the instruction
> > > +	 * switches the context from guest mode (MSR.GS =3D 1) to hyperviso=
r
> > > +	 * mode (MSR.GS =3D 0) then the xSRR0 points to first instruction o=
f
> >
> > Can't we just execute that code path with MSR.DE=3D0?
>=20
> Single stepping uses DBCR0.IC (instruction complete).
> Can you describe how MSR.DE =3D 0 will work?
>=20
> >
> >
> > Alex
> >
> > > +	 * KVM handler and xSRR1 points that MSR.GS is clear
> > > +	 * (hypervisor context). Now as xSRR1.GS is used to decide whether
> > > +	 * KVM handler will be invoked to handle the exception or host
> > > +	 * host kernel debug handler will be invoked to handle the exceptio=
n.
> > > +	 * This leads to host kernel debug handler handling the exception
> > > +	 * which should either be handled by KVM.
> > > +	 */
> > > +	mfspr	r10, SPRN_EPCR
> > > +	andis.	r10,r10,SPRN_EPCR_DUVD@h
> > > +	beq+	2f
> > > +
> > > +	andis.	r10,r9,MSR_GS@h
> > > +	beq+	3f
> > > +2:
> > > +#endif
> > > 	LOAD_REG_IMMEDIATE(r14,interrupt_base_book3e)
> > > 	LOAD_REG_IMMEDIATE(r15,interrupt_end_book3e)
> > > 	cmpld	cr0,r10,r14
> > > @@ -523,7 +550,7 @@ kernel_dbg_exc:
> > > 	blt+	cr0,1f
> > > 	bge+	cr1,1f
> > >
> > > -	/* here it looks like we got an inappropriate debug exception. */
> > > +3:	/* here it looks like we got an inappropriate debug exception. */
> > > 	lis	r14,DBSR_IC@h		/* clear the IC event */
> > > 	rlwinm	r11,r11,0,~MSR_DE	/* clear DE in the DSRR1 value */
> > > 	mtspr	SPRN_DBSR,r14
> > > diff --git a/arch/powerpc/kernel/head_booke.h
> > > b/arch/powerpc/kernel/head_booke.h
> > > index 5f051ee..edc6a3b 100644
> > > --- a/arch/powerpc/kernel/head_booke.h
> > > +++ b/arch/powerpc/kernel/head_booke.h
> > > @@ -285,7 +285,33 @@ label:
> > > 	mfspr	r10,SPRN_DBSR;		/* check single-step/branch taken */  \
> > > 	andis.	r10,r10,(DBSR_IC|DBSR_BT)@h;				      \
> > > 	beq+	2f;							      \
> > > +#ifdef CONFIG_KVM_BOOKE_HV						      \
> > > +	/*								      \
> > > +	 * EPCR.DUVD controls whether the debug events can come in	      \
> > > +	 * hypervisor mode or not. When KVM guest is using the debug	      =
\
> > > +	 * resource then we do not want debug events to be captured 	      =
\
> > > +	 * in guest entry/exit path. So we set EPCR.DUVD when entering	    =
  \
> > > +	 * and clears EPCR.DUVD when exiting from guest.		      \
> > > +	 * Debug instruction complete is a post-completion debug	      \
> > > +	 * exception but debug event gets posted on the basis of MSR	      =
\
> > > +	 * before the instruction is executed. Now if the instruction	     =
 \
> > > +	 * switches the context from guest mode (MSR.GS =3D 1) to hyperviso=
r    \
> > > +	 * mode (MSR.GS =3D 0) then the xSRR0 points to first instruction o=
f    \
> > > +	 * KVM handler and xSRR1 points that MSR.GS is clear 		      \
> > > +	 * (hypervisor context). Now as xSRR1.GS is used to decide whether =
   \
> > > +	 * KVM handler will be invoked to handle the exception or host	    =
  \
> > > +	 * host kernel debug handler will be invoked to handle the exceptio=
n. \
> > > +	 * This leads to host kernel debug handler handling the exception  =
   \
> > > +	 * which should either be handled by KVM.			      \
> > > +	 */								      \
> > > +	mfspr	r10, SPRN_EPCR;						      \
> > > +	andis.	r10,r10,SPRN_EPCR_DUVD@h;				      \
> > > +	beq+	3f;							      \
> > > 									      \
> > > +	andis.	r10,r9,MSR_GS@h;				    	      \
> > > +	beq+	1f;							      \
> > > +3:									      \
> > > +#endif									      \
> > > 	lis	r10,KERNELBASE@h;	/* check if exception in vectors */   \
> > > 	ori	r10,r10,KERNELBASE@l;					      \
> > > 	cmplw	r12,r10;						      \
> > > --
> > > 1.7.0.4
> > >
> > >
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe kvm-ppc"
> > > in the body of a message to majordomo@vger.kernel.org More majordomo
> > > info at  http://vger.kernel.org/majordomo-info.html
> >
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe kvm-ppc" in the=
 body
> of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
