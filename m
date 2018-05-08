Return-Path: <sbobroff@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40g1gs6kjtzF1nM
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 May 2018 11:12:57 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4819Au4044447
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 May 2018 21:12:55 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2htv035b6u-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 May 2018 21:12:55 -0400
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sbobroff@linux.ibm.com>;
 Tue, 8 May 2018 02:12:53 +0100
Date: Tue, 8 May 2018 11:12:48 +1000
From: Sam Bobroff <sbobroff@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 11/13] powerpc/eeh: Introduce eeh_set_irq_state()
References: <cover.1525242772.git.sbobroff@linux.ibm.com>
 <facebfcf7726c381957cc5fac0fc9510ac27c472.1525242772.git.sbobroff@linux.ibm.com>
 <87vac486nr.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="JP+T4n/bALQSJXh8"
In-Reply-To: <87vac486nr.fsf@concordia.ellerman.id.au>
Message-Id: <20180508011247.GB11802@tungsten.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--JP+T4n/bALQSJXh8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 04, 2018 at 01:02:32PM +1000, Michael Ellerman wrote:
> Sam Bobroff <sbobroff@linux.ibm.com> writes:
>=20
> > diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh=
_driver.c
> > index f63a01d336ee..b3edd0df04b8 100644
> > --- a/arch/powerpc/kernel/eeh_driver.c
> > +++ b/arch/powerpc/kernel/eeh_driver.c
> > @@ -210,6 +206,23 @@ static void eeh_set_channel_state(struct eeh_pe *r=
oot, enum pci_channel_state s)
> >  				edev->pdev->error_state =3D s;
> >  }
> > =20
> > +static void eeh_set_irq_state(struct eeh_pe *root, bool enable)
> > +{
> > +	struct eeh_pe *pe;
> > +	struct eeh_dev *edev, *tmp;
> > +
> > +	eeh_for_each_pe(root, pe)
> > +		eeh_pe_for_each_dev(pe, edev, tmp)
> > +			if (eeh_edev_actionable(edev))
> > +				if (eeh_pcid_get(edev->pdev)) {
> > +					if (enable)
> > +						eeh_enable_irq(edev);
> > +					else
> > +						eeh_disable_irq(edev);
> > +					eeh_pcid_put(edev->pdev);
> > +				}
>=20
> Yikes.
>=20
> What about?
>=20
> 	eeh_for_each_pe(root, pe) {
> 		eeh_pe_for_each_dev(pe, edev, tmp) {
> 			if (!eeh_edev_actionable(edev))
> 				continue;
>=20
> 			if (!eeh_pcid_get(edev->pdev))
> 				continue;
>=20
> 			if (enable)
> 				eeh_enable_irq(edev);
> 			else
> 				eeh_disable_irq(edev);
>=20
> 			eeh_pcid_put(edev->pdev);
> 		}
> 	}
>=20
> cheers

Sure, will do.

Cheers,

--JP+T4n/bALQSJXh8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEELWWF8pdtWK5YQRohMX8w6AQl/iIFAlrw+Y8ACgkQMX8w6AQl
/iIS7wf/dAiMByBjMLkul2WeQ89v7y6EFuvEtbG0jSevsWsGOK+B0XcycLBP+oli
c/SINQ+FfnqRHh/a/o+d2mqLIG3MZ6xXx659ZyBIJYAZEfWOyOml0W7AapdyJDBc
PkyUr4Dqn2TW9jRBf9jhxeI4jqC4cu2PJ8Cv6LeFtZgIU/Tap3fAGLNUODsKeBxL
appX/7epjXgh42XIAKaOF4mNYr4294dSdjU7JCMs0qfdgsdQl4fArth//gMeOrXw
yl8qTMcnvIUB/pOmVuocj4aXlXgKVHG+GnLkn7WQqmL2rhhBH4u5bkXHDSGV/h6Q
R3PBkXGUzSWDOi8VYc3aIsL0a0RIuw==
=olqR
-----END PGP SIGNATURE-----

--JP+T4n/bALQSJXh8--
