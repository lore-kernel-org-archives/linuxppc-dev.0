Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 32DC11A030A
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Mar 2015 12:21:04 +1100 (AEDT)
Date: Mon, 16 Mar 2015 12:01:22 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH 2/2] drivers/vfio: Support EEH error injection
Message-ID: <20150316010122.GA17789@voom.fritz.box>
References: <1426055651-22925-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1426055651-22925-2-git-send-email-gwshan@linux.vnet.ibm.com>
 <20150312005721.GP11973@voom.redhat.com>
 <20150312031642.GA15888@shangw>
 <20150312042129.GS11973@voom.redhat.com>
 <1426278489.3643.116.camel@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
In-Reply-To: <1426278489.3643.116.camel@redhat.com>
Cc: aik@ozlabs.ru, linuxppc-dev@ozlabs.org,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, kvm@vger.kernel.org, agraf@suse.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 13, 2015 at 02:28:09PM -0600, Alex Williamson wrote:
> On Thu, 2015-03-12 at 15:21 +1100, David Gibson wrote:
> > On Thu, Mar 12, 2015 at 02:16:42PM +1100, Gavin Shan wrote:
> > > On Thu, Mar 12, 2015 at 11:57:21AM +1100, David Gibson wrote:
> > > >On Wed, Mar 11, 2015 at 05:34:11PM +1100, Gavin Shan wrote:
> > > >> The patch adds one more EEH sub-command (VFIO_EEH_PE_INJECT_ERR)
> > > >> to inject the specified EEH error, which is represented by
> > > >> (struct vfio_eeh_pe_err), to the indicated PE for testing purpose.
> > > >>=20
> > > >> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> > > >> ---
> > > >>  Documentation/vfio.txt        | 47 ++++++++++++++++++++++++++++++=
-------------
> > > >>  drivers/vfio/vfio_spapr_eeh.c | 14 +++++++++++++
> > > >>  include/uapi/linux/vfio.h     | 34 ++++++++++++++++++++++++++++++-
> > > >>  3 files changed, 80 insertions(+), 15 deletions(-)
> > > >>=20
> > > >> diff --git a/Documentation/vfio.txt b/Documentation/vfio.txt
> > > >> index 96978ec..2e7f736 100644
> > > >> --- a/Documentation/vfio.txt
> > > >> +++ b/Documentation/vfio.txt
> > > >> @@ -328,7 +328,13 @@ So 4 additional ioctls have been added:
> > > >> =20
> > > >>  The code flow from the example above should be slightly changed:
> > > >> =20
> > > >> -	struct vfio_eeh_pe_op pe_op =3D { .argsz =3D sizeof(pe_op), .fla=
gs =3D 0 };
> > > >> +	struct vfio_eeh_pe_op *pe_op;
> > > >> +	struct vfio_eeh_pe_err *pe_err;
> > > >> +
> > > >> +	pe_op =3D malloc(sizeof(*pe_op) + sizeof(*pe_err));
> > > >> +	pe_err =3D (void *)pe_op + sizeof(*pe_op);
> > > >> +	pe_op->argsz =3D sizeof(*pe_op) + sizeof(*pe_err);
> > > >
> > > >Surely that argsz can't be correct for most of the operations.  The
> > > >extended structure should only be there for the error inject ioctl,
> > > >yes?
> > > >
> > >=20
> > > argsz isn't appropriate for most cases because kernel has the check
> > > "expected_argsz < passed_argsz", not "expected_argsz =3D=3D
> > > passed_argsz".
> >=20
> > It works for now, but if any of those calls was extended with more
> > data, it would break horribly.  By setting the argsz greater than
> > necessary, you're effectively passing uninitialized data to the
> > ioctl().  At the moment, the ioctl() ignores it, but the whole point
> > of the argsz value is that in the future, it might not.
>=20
> argsz tells us how much data the user is passing, we're always going to
> need to figure out what the extra data is, so I don't really see the
> point of this objection.  In fact, it might make use of this interface
> quite a bit easier if vfio_eeh_pe_op ended with a union including
> vfio_eeh_pe_err.  op =3D=3D VFIO_EEH_PE_INJECT_ERR defines that the user =
has
> passed vfio_eeh_pe_err in the union, other ops may add new unions later.

*thinks*

Yeah, I missed the fact that all these ioctls are using a common
arguments structure.  In which case, yes, absolutely the error field
should be added to that structure rather than bolted on afterwards.

A union is the obvious way to do that, but I think we should make sure
to include a padding field in that union as well, so we've got some
room to move if we both need to add other union options and add common
things after the union in future.
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVBitiAAoJEGw4ysog2bOSWEQQAMxdhK9oHBlZmj9WyuvtwGBK
+JONwJkmfQfrpl+3maL63NzIiyoy3qkB5fGrK7aOphRnCU+EwbwJQvT3abZLlUK0
HOgykbWHhYd6CtRYttkVlTpnWgaJdcCv9V4cUiod3ZkqlWrNniTb0o1FE+GO66F+
gc64rQKOwc1kTIF9U7SlIYSLhGd1edaMaBdUm8YmyhUpjA1bWjt9bmxvxqBetSdR
R9ET20IuQb0bCQD9AnorBljGnS0kbQhGYQmNlDr4XIYAYgoWHUi/JRtt9DLMMgO4
Y05OBizU2ToKjrNiWlfULolhOpVTbIRripMt/2uGCwVzjW6aVXaJBdtNILRCvVfa
SJ0uOHl4mIR8eNVakprk/4oDUr11YQvSYmPiwR1h34tWXh9/uKr9rK+nrpiEK4F4
6a50n6vywfRvBG60EHY8486cFChsGi3f1XPrN4SJpdI0zP4iHppsmnQVsH4qlTWg
diQlMxLMKk++svs249LQK/ithVP+RH19A6eYo8Tzb0Lb86+otTU7BUbyNRMZvcqp
HSQ2yLLLmwDwtCqi1kA/cw9oLeV3CVfLS+lci/xVI4JVK6X/7rqJeH9hnTwxAUtC
fNix728QmH5DO/1aneJ4PLMx43tRUvyFaVhGZVZ/VuFhMMZcKyjgTeRTY0SDkpek
y/hT4gc6tgox4CoV0FPg
=ouFc
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--
