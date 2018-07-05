Return-Path: <bharat.bhushan@nxp.com>
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01on0086.outbound.protection.outlook.com [104.47.2.86])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41M2Dq3bmLzF1sY
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Jul 2018 01:42:50 +1000 (AEST)
From: Bharat Bhushan <bharat.bhushan@nxp.com>
To: Michael Ellerman <mpe@ellerman.id.au>, "benh@kernel.crashing.org"
 <benh@kernel.crashing.org>, "paulus@samba.org" <paulus@samba.org>,
 "robh@kernel.org" <robh@kernel.org>, "geoff@infradead.org"
 <geoff@infradead.org>, "tyreld@linux.vnet.ibm.com"
 <tyreld@linux.vnet.ibm.com>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] powerpc/mpic: Cleanup irq vector accounting
Date: Thu, 5 Jul 2018 15:42:44 +0000
Message-ID: <AM5PR0401MB2545E56D1B38A07D1FB9D2499A400@AM5PR0401MB2545.eurprd04.prod.outlook.com>
References: <1530267872-31244-1-git-send-email-Bharat.Bhushan@nxp.com>
 <87efgjku6k.fsf@concordia.ellerman.id.au>
In-Reply-To: <87efgjku6k.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Michael Ellerman [mailto:mpe@ellerman.id.au]
> Sent: Wednesday, July 4, 2018 6:57 PM
> To: Bharat Bhushan <bharat.bhushan@nxp.com>;
> benh@kernel.crashing.org; paulus@samba.org; robh@kernel.org;
> geoff@infradead.org; tyreld@linux.vnet.ibm.com; linuxppc-
> dev@lists.ozlabs.org; linux-kernel@vger.kernel.org
> Cc: Bharat Bhushan <bharat.bhushan@nxp.com>
> Subject: Re: [PATCH] powerpc/mpic: Cleanup irq vector accounting
>=20
> Bharat Bhushan <Bharat.Bhushan@nxp.com> writes:
>=20
> > Available vector space accounts ipis and timer interrupts while
> > spurious vector was not accounted.
>=20
> OK. What is the symptom of that? Nothing? Total system crash?
>=20
> Looks like this can be tagged:
>=20
> Fixes: 0a4081641d72 ("powerpc/mpic: FSL MPIC error interrupt support.")
>=20
> Which added the code that uses "12".
>=20
> > Also later
> > mpic_setup_error_int() escape one more vector, seemingly it assumes
> > one spurious vector.
>=20
> Ah right, I get it now.
>=20
> So there is no bug. It's just a disagreement about whether the "intvec"
> argument to mpic_setup_error_int() indicates the first number that's free=
 to
> use or the last number that has been allocated.
>=20
> Right?

Yes, it is not any bug fix. This is minor cleanup where passing rather than=
 passing "last intvec used" to "intvec to be used" in mpic_setup_error_int(=
).

Thanks
-Bharat

>=20
> cheers
>=20
> > Signed-off-by: Bharat Bhushan <Bharat.Bhushan@nxp.com>
> > ---
> >  arch/powerpc/sysdev/fsl_mpic_err.c | 2 +-
> >  arch/powerpc/sysdev/mpic.c         | 6 +++---
> >  2 files changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/powerpc/sysdev/fsl_mpic_err.c
> > b/arch/powerpc/sysdev/fsl_mpic_err.c
> > index 488ec45..2a98837 100644
> > --- a/arch/powerpc/sysdev/fsl_mpic_err.c
> > +++ b/arch/powerpc/sysdev/fsl_mpic_err.c
> > @@ -76,7 +76,7 @@ int mpic_setup_error_int(struct mpic *mpic, int
> intvec)
> >  	mpic->flags |=3D MPIC_FSL_HAS_EIMR;
> >  	/* allocate interrupt vectors for error interrupts */
> >  	for (i =3D MPIC_MAX_ERR - 1; i >=3D 0; i--)
> > -		mpic->err_int_vecs[i] =3D --intvec;
> > +		mpic->err_int_vecs[i] =3D intvec--;
> >
> >  	return 0;
> >  }
> > diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
> > index 1d4e0ef6..e098d1e 100644
> > --- a/arch/powerpc/sysdev/mpic.c
> > +++ b/arch/powerpc/sysdev/mpic.c
> > @@ -1380,12 +1380,12 @@ struct mpic * __init mpic_alloc(struct
> device_node *node,
> >  		 * global vector number space, as in case of ipis
> >  		 * and timer interrupts.
> >  		 *
> > -		 * Available vector space =3D intvec_top - 12, where 12
> > +		 * Available vector space =3D intvec_top - 13, where 13
> >  		 * is the number of vectors which have been consumed by
> > -		 * ipis and timer interrupts.
> > +		 * ipis, timer interrupts and spurious.
> >  		 */
> >  		if (fsl_version >=3D 0x401) {
> > -			ret =3D mpic_setup_error_int(mpic, intvec_top - 12);
> > +			ret =3D mpic_setup_error_int(mpic, intvec_top - 13);
> >  			if (ret)
> >  				return NULL;
> >  		}
> > --
> > 1.9.3
