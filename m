Return-Path: <sbobroff@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40g1br1j5JzF1Pp
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 May 2018 11:09:27 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4819Fmq096288
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 May 2018 21:09:25 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2htwcvjhvp-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 May 2018 21:09:25 -0400
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sbobroff@linux.ibm.com>;
 Tue, 8 May 2018 02:09:23 +0100
Date: Tue, 8 May 2018 11:09:15 +1000
From: Sam Bobroff <sbobroff@linux.ibm.com>
To: Russell Currey <ruscur@russell.cc>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 07/13] powerpc/eeh: Clean up pci_ers_result handling
References: <cover.1525242772.git.sbobroff@linux.ibm.com>
 <a4aae83e02d8a5424a92321659a2100a5589d366.1525242772.git.sbobroff@linux.ibm.com>
 <1525417081.2560.10.camel@russell.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="0OAP2g/MAC+5xKAE"
In-Reply-To: <1525417081.2560.10.camel@russell.cc>
Message-Id: <20180508010915.GA11802@tungsten.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 04, 2018 at 04:58:01PM +1000, Russell Currey wrote:
> On Wed, 2018-05-02 at 16:36 +1000, Sam Bobroff wrote:
> > As EEH event handling progresses, a cumulative result of type
> > pci_ers_result is built up by (some of) the eeh_report_*() functions
> > using either:
> > 	if (rc =3D=3D PCI_ERS_RESULT_NEED_RESET) *res =3D rc;
> > 	if (*res =3D=3D PCI_ERS_RESULT_NONE) *res =3D rc;
> > or:
> > 	if ((*res =3D=3D PCI_ERS_RESULT_NONE) ||
> > 	    (*res =3D=3D PCI_ERS_RESULT_RECOVERED)) *res =3D rc;
> > 	if (*res =3D=3D PCI_ERS_RESULT_DISCONNECT &&
> > 	    rc =3D=3D PCI_ERS_RESULT_NEED_RESET) *res =3D rc;
> > (Where *res is the accumulator.)
> >=20
> > However, the intent is not immediately clear and the result in some
> > situations is order dependent.
> >=20
> > Address this by assigning a priority to each result value, and always
> > merging to the highest priority. This renders the intent clear, and
> > provides a stable value for all orderings.
> >=20
> > Signed-off-by: Sam Bobroff <sbobroff@linux.ibm.com>
> > ---
> >  arch/powerpc/kernel/eeh_driver.c | 36 ++++++++++++++++++++++++++--
> > --------
> >  1 file changed, 26 insertions(+), 10 deletions(-)
> >=20
> > diff --git a/arch/powerpc/kernel/eeh_driver.c
> > b/arch/powerpc/kernel/eeh_driver.c
> > index 188d15c4fe3a..f33dd68a9ca2 100644
> > --- a/arch/powerpc/kernel/eeh_driver.c
> > +++ b/arch/powerpc/kernel/eeh_driver.c
> > @@ -39,6 +39,29 @@ struct eeh_rmv_data {
> >  	int removed;
> >  };
> > =20
> > +static int eeh_result_priority(enum pci_ers_result result)
> > +{
> > +	switch (result) {
> > +	case PCI_ERS_RESULT_NONE: return 0;
> > +	case PCI_ERS_RESULT_NO_AER_DRIVER: return 1;
> > +	case PCI_ERS_RESULT_RECOVERED: return 2;
> > +	case PCI_ERS_RESULT_CAN_RECOVER: return 3;
> > +	case PCI_ERS_RESULT_DISCONNECT: return 4;
> > +	case PCI_ERS_RESULT_NEED_RESET: return 5;
> > +	default:
> > +		WARN_ONCE(1, "Unknown pci_ers_result value");
>=20
> Missing newline and also would be good to print the value was

Sounds good, will do! I'm not sure if it's mentioned elsewhere but I'll
fix the same issues in pci_ers_result_name() as well.

> > +		return 0;
> > +	}
> > +};
> > +
> > +static enum pci_ers_result merge_result(enum pci_ers_result old,
> > +					enum pci_ers_result new)
>=20
> merge_result() sounds like something really generic, maybe call it
> pci_ers_merge_result() or something?

Sounds good, will do.

> Note: just learned that it stands for Error Recovery System and that's
> a thing (?)
>=20
> > +{
> > +	if (eeh_result_priority(new) > eeh_result_priority(old))
> > +		return new;
> > +	return old;
>=20
> MAX would be nicer as per mpe's suggestion

Sorry, I don't understand. The return value isn't MAX(new, old) so
how can MAX() do this?

> > +}
> > +
> >  /**
> >   * eeh_pcid_get - Get the PCI device driver
> >   * @pdev: PCI device
> > @@ -206,9 +229,7 @@ static void *eeh_report_error(struct eeh_dev
> > *edev, void *userdata)
> > =20
> >  	rc =3D driver->err_handler->error_detected(dev,
> > pci_channel_io_frozen);
> > =20
> > -	/* A driver that needs a reset trumps all others */
> > -	if (rc =3D=3D PCI_ERS_RESULT_NEED_RESET) *res =3D rc;
> > -	if (*res =3D=3D PCI_ERS_RESULT_NONE) *res =3D rc;
> > +	*res =3D merge_result(*res, rc);
> > =20
> >  	edev->in_error =3D true;
> >  	pci_uevent_ers(dev, PCI_ERS_RESULT_NONE);
> > @@ -249,9 +270,7 @@ static void *eeh_report_mmio_enabled(struct
> > eeh_dev *edev, void *userdata)
> > =20
> >  	rc =3D driver->err_handler->mmio_enabled(dev);
> > =20
> > -	/* A driver that needs a reset trumps all others */
> > -	if (rc =3D=3D PCI_ERS_RESULT_NEED_RESET) *res =3D rc;
> > -	if (*res =3D=3D PCI_ERS_RESULT_NONE) *res =3D rc;
> > +	*res =3D merge_result(*res, rc);
> > =20
> >  out:
> >  	eeh_pcid_put(dev);
> > @@ -294,10 +313,7 @@ static void *eeh_report_reset(struct eeh_dev
> > *edev, void *userdata)
> >  		goto out;
> > =20
> >  	rc =3D driver->err_handler->slot_reset(dev);
> > -	if ((*res =3D=3D PCI_ERS_RESULT_NONE) ||
> > -	    (*res =3D=3D PCI_ERS_RESULT_RECOVERED)) *res =3D rc;
> > -	if (*res =3D=3D PCI_ERS_RESULT_DISCONNECT &&
> > -	     rc =3D=3D PCI_ERS_RESULT_NEED_RESET) *res =3D rc;
> > +	*res =3D merge_result(*res, rc);
> > =20
> >  out:
> >  	eeh_pcid_put(dev);
>=20

--0OAP2g/MAC+5xKAE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEELWWF8pdtWK5YQRohMX8w6AQl/iIFAlrw+LQACgkQMX8w6AQl
/iJ29Af/f5WjoJ8FerMfdsO5Jbyr9tZx+NysKp41uHxjgJPaTDkF7maad6ouDVNL
TgevgWzHGMd2EDWltkV0h9aTlFX3jjcqNyI4zvRRiu0wJ8M/3Y4GkNRxI8fTwseT
22C7tgdxFBlaFrOWOYcN0GkphdZD4/BuaIqbag8jawPgXzVjngR8kDN7Qb9aWcjM
6oCBh5ROCAIL2M0Q+W7JEOA3+y0W2lAsALRfaeWHn/bwzl6Tj5eIz/qFzSHRqjAy
LMil9/a+FnT7/qptlMfvra2RwYuA7VFHanRiPWIKFPhLwIKAOrbhhqhGodKYIq4L
myqDRb4caUDwaSBPzUxaG/+GjxYj6Q==
=FeLM
-----END PGP SIGNATURE-----

--0OAP2g/MAC+5xKAE--
