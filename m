Return-Path: <sbobroff@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40zcld0Cy5zF0dm
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Jun 2018 11:28:44 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w541OG1e064804
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 3 Jun 2018 21:28:42 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2jc870m1dr-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 03 Jun 2018 21:28:42 -0400
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sbobroff@linux.ibm.com>;
 Mon, 4 Jun 2018 02:28:40 +0100
Date: Mon, 4 Jun 2018 11:28:34 +1000
From: Sam Bobroff <sbobroff@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 07/13] powerpc/eeh: Clean up pci_ers_result handling
References: <cover.1527217866.git.sbobroff@linux.ibm.com>
 <e638159f9e6dfc4931f5164220741dd99bb4c0c7.1527217866.git.sbobroff@linux.ibm.com>
 <87muwe3475.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="XsQoSWH+UP9D9v3l"
In-Reply-To: <87muwe3475.fsf@concordia.ellerman.id.au>
Message-Id: <20180604012833.GA6139@tungsten.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 02, 2018 at 01:40:46AM +1000, Michael Ellerman wrote:
> Sam Bobroff <sbobroff@linux.ibm.com> writes:
>=20
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
> >
> > However, the intent is not immediately clear and the result in some
> > situations is order dependent.
> >
> > Address this by assigning a priority to each result value, and always
> > merging to the highest priority. This renders the intent clear, and
> > provides a stable value for all orderings.
> >
> > Signed-off-by: Sam Bobroff <sbobroff@linux.ibm.com>
> > ---
> > =3D=3D=3D=3D=3D=3D v1 -> v2: =3D=3D=3D=3D=3D=3D
> >
> > * Added the value, and missing newline, to some WARN()s.
> > * Improved name of merge_result() to pci_ers_merge_result().
> > * Adjusted the result priorities so that unknown doesn't overlap with _=
NONE.
>=20
> These =3D=3D=3D markers seem to have confused patchwork, they ended up in=
 the
> patch, and then git put them in the changelog.
>=20
> http://patchwork.ozlabs.org/patch/920194/
>=20
> The usual format is just something like:
>=20
> v2 - Added the value, and missing newline, to some WARN()s.
>    - Improved name of merge_result() to pci_ers_merge_result().
>    - Adjusted the result priorities so that unknown doesn't overlap with =
_NONE.
>=20
> cheers

Oh! I'll change it!

Sam.

>=20
> >  arch/powerpc/kernel/eeh_driver.c | 36 ++++++++++++++++++++++++++------=
----
> >  1 file changed, 26 insertions(+), 10 deletions(-)
> >
> > diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh=
_driver.c
> > index 188d15c4fe3a..2d3cac584899 100644
> > --- a/arch/powerpc/kernel/eeh_driver.c
> > +++ b/arch/powerpc/kernel/eeh_driver.c
> > @@ -39,6 +39,29 @@ struct eeh_rmv_data {
> >  	int removed;
> >  };
> > =20
> > +static int eeh_result_priority(enum pci_ers_result result)
> > +{
> > +	switch (result) {
> > +	case PCI_ERS_RESULT_NONE: return 1;
> > +	case PCI_ERS_RESULT_NO_AER_DRIVER: return 2;
> > +	case PCI_ERS_RESULT_RECOVERED: return 3;
> > +	case PCI_ERS_RESULT_CAN_RECOVER: return 4;
> > +	case PCI_ERS_RESULT_DISCONNECT: return 5;
> > +	case PCI_ERS_RESULT_NEED_RESET: return 6;
> > +	default:
> > +		WARN_ONCE(1, "Unknown pci_ers_result value: %d\n", (int)result);
> > +		return 0;
> > +	}
> > +};
> > +
> > +static enum pci_ers_result pci_ers_merge_result(enum pci_ers_result ol=
d,
> > +						enum pci_ers_result new)
> > +{
> > +	if (eeh_result_priority(new) > eeh_result_priority(old))
> > +		return new;
> > +	return old;
> > +}
> > +
> >  /**
> >   * eeh_pcid_get - Get the PCI device driver
> >   * @pdev: PCI device
> > @@ -206,9 +229,7 @@ static void *eeh_report_error(struct eeh_dev *edev,=
 void *userdata)
> > =20
> >  	rc =3D driver->err_handler->error_detected(dev, pci_channel_io_frozen=
);
> > =20
> > -	/* A driver that needs a reset trumps all others */
> > -	if (rc =3D=3D PCI_ERS_RESULT_NEED_RESET) *res =3D rc;
> > -	if (*res =3D=3D PCI_ERS_RESULT_NONE) *res =3D rc;
> > +	*res =3D pci_ers_merge_result(*res, rc);
> > =20
> >  	edev->in_error =3D true;
> >  	pci_uevent_ers(dev, PCI_ERS_RESULT_NONE);
> > @@ -249,9 +270,7 @@ static void *eeh_report_mmio_enabled(struct eeh_dev=
 *edev, void *userdata)
> > =20
> >  	rc =3D driver->err_handler->mmio_enabled(dev);
> > =20
> > -	/* A driver that needs a reset trumps all others */
> > -	if (rc =3D=3D PCI_ERS_RESULT_NEED_RESET) *res =3D rc;
> > -	if (*res =3D=3D PCI_ERS_RESULT_NONE) *res =3D rc;
> > +	*res =3D pci_ers_merge_result(*res, rc);
> > =20
> >  out:
> >  	eeh_pcid_put(dev);
> > @@ -294,10 +313,7 @@ static void *eeh_report_reset(struct eeh_dev *edev=
, void *userdata)
> >  		goto out;
> > =20
> >  	rc =3D driver->err_handler->slot_reset(dev);
> > -	if ((*res =3D=3D PCI_ERS_RESULT_NONE) ||
> > -	    (*res =3D=3D PCI_ERS_RESULT_RECOVERED)) *res =3D rc;
> > -	if (*res =3D=3D PCI_ERS_RESULT_DISCONNECT &&
> > -	     rc =3D=3D PCI_ERS_RESULT_NEED_RESET) *res =3D rc;
> > +	*res =3D pci_ers_merge_result(*res, rc);
> > =20
> >  out:
> >  	eeh_pcid_put(dev);
> > --=20
> > 2.16.1.74.g9b0b1f47b
>=20

--XsQoSWH+UP9D9v3l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEELWWF8pdtWK5YQRohMX8w6AQl/iIFAlsUlbgACgkQMX8w6AQl
/iKH8Af/ZbAJ/CUyw+nkdUvssi0JndK+2JIEabfm7V1p24kxa8/4YHnc168A3okU
dRKzZ4q1PGrMy3GgrE6mgO42YbUeXqzOyK7du70jBsZNs5WaZwIVV2B3uRCGTWPl
I8hjTGrAAykgWKzN7m/6/YaoiUXHJ06nAbySVeQBA/4DMsKoCN2K0LrwcgwJo6sz
RsOVnwbzILBgdT7wBe0WxBEMaxIQwGONiWYKuDkpEh0o8ha6qAka4Yhf7iUO3qcV
ykKMoHpfcxvOQ/1/NW+uBwqVuBHS11tDtPMAKmJCAIfmqi2CVrp4E3bgZk0npzZB
5Ijsgl9jGZjEZ15xr0c3IL+p7Oj4og==
=wmnL
-----END PGP SIGNATURE-----

--XsQoSWH+UP9D9v3l--
