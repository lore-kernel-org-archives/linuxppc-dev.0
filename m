Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xyX8c5S3mzDsMC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Sep 2017 19:57:20 +1000 (AEST)
Message-ID: <1505987840.15768.18.camel@neuling.org>
Subject: Re: [PATCH v2] powerpc: Handle MCE on POWER9 with only DSISR bit 33
 set
From: Michael Neuling <mikey@neuling.org>
To: Nicholas Piggin <nicholas.piggin@gmail.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Date: Thu, 21 Sep 2017 19:57:20 +1000
In-Reply-To: <20170921181801.5a260281@roar.ozlabs.ibm.com>
References: <20170921020434.21018-1-mikey@neuling.org>
 <20170921181801.5a260281@roar.ozlabs.ibm.com>
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

On Thu, 2017-09-21 at 18:18 +1000, Nicholas Piggin wrote:
> On Thu, 21 Sep 2017 12:04:34 +1000
> Michael Neuling <mikey@neuling.org> wrote:
>=20
> > On POWER9 DD2.1 and below, it's possible to get Machine Check
> > Exception (MCE) where only DSISR bit 33 is set. This will result in
> > the linux MCE handler seeing an unknown event, which triggers linux to
> > crash.
> >=20
> > We change this by detecting unknown events in the MCE handler and
> > marking them as handled so that we no longer crash. We do this only on
> > chip revisions known to have this problem.
> >=20
> > MCE that occurs like this is spurious, so we don't need to do anything
> > in terms of servicing it. If there is something that needs to be
> > serviced, the CPU will raise the MCE again with the correct DSISR so
> > that it can be serviced properly.
> >=20
> > Signed-off-by: Michael Neuling <mikey@neuling.org>
> > ---
> > v2 update commit message based on Balbir's comments
> > ---
> > =C2=A0arch/powerpc/kernel/mce_power.c | 15 +++++++++++++++
> > =C2=A01 file changed, 15 insertions(+)
> >=20
> > diff --git a/arch/powerpc/kernel/mce_power.c
> > b/arch/powerpc/kernel/mce_power.c
> > index b76ca198e0..72ec667136 100644
> > --- a/arch/powerpc/kernel/mce_power.c
> > +++ b/arch/powerpc/kernel/mce_power.c
> > @@ -595,6 +595,7 @@ static long mce_handle_error(struct pt_regs *regs,
> > =C2=A0	uint64_t addr;
> > =C2=A0	uint64_t srr1 =3D regs->msr;
> > =C2=A0	long handled;
> > +	unsigned long pvr;
> > =C2=A0
> > =C2=A0	if (SRR1_MC_LOADSTORE(srr1))
> > =C2=A0		handled =3D mce_handle_derror(regs, dtable, &mce_err, &addr);
> > @@ -604,6 +605,20 @@ static long mce_handle_error(struct pt_regs *regs,
> > =C2=A0	if (!handled && mce_err.error_type =3D=3D MCE_ERROR_TYPE_UE)
> > =C2=A0		handled =3D mce_handle_ue_error(regs);
> > =C2=A0
> > +	/*
> > +	=C2=A0* On POWER9 DD2.1 and below, it's possible to get machine
> > +	=C2=A0* check where only DSISR bit 33 is set. This will result in
> > +	=C2=A0* the MCE handler seeing an unknown event and us crashing.
> > +	=C2=A0* Change this to mark as handled on these revisions.
> > +	=C2=A0*/
> > +	pvr =3D mfspr(SPRN_PVR);
> > +	if (((PVR_VER(pvr) =3D=3D PVR_POWER9) &&
> > +	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0(PVR_CFG(pvr) =3D=3D 2) &&
> > +	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0(PVR_MIN(pvr) <=3D 1)) || cpu_has_featu=
re(CPU_FTR_POWER9_DD1))
> > +		/* DD2.1 and below */
> > +		if (mce_err.error_type =3D=3D MCE_ERROR_TYPE_UNKNOWN)
> > +		=C2=A0=C2=A0=C2=A0=C2=A0handled =3D 1;
>=20
> I might be missing something, but can you just do
>=20
> =C2=A0 if (regs->dsisr =3D=3D 0x40000000)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 1;
>=20
> In __machine_check_early_realmode_p9() ?

You're right, thanks.

Mikey
