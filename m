Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E6C091A019A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Mar 2015 15:28:51 +1100 (AEDT)
Date: Thu, 12 Mar 2015 15:21:29 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/2] drivers/vfio: Support EEH error injection
Message-ID: <20150312042129.GS11973@voom.redhat.com>
References: <1426055651-22925-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1426055651-22925-2-git-send-email-gwshan@linux.vnet.ibm.com>
 <20150312005721.GP11973@voom.redhat.com>
 <20150312031642.GA15888@shangw>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="GMArzDD+OGn24EFp"
In-Reply-To: <20150312031642.GA15888@shangw>
Cc: aik@ozlabs.ru, linuxppc-dev@ozlabs.org, alex.williamson@redhat.com,
 agraf@suse.de, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--GMArzDD+OGn24EFp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2015 at 02:16:42PM +1100, Gavin Shan wrote:
> On Thu, Mar 12, 2015 at 11:57:21AM +1100, David Gibson wrote:
> >On Wed, Mar 11, 2015 at 05:34:11PM +1100, Gavin Shan wrote:
> >> The patch adds one more EEH sub-command (VFIO_EEH_PE_INJECT_ERR)
> >> to inject the specified EEH error, which is represented by
> >> (struct vfio_eeh_pe_err), to the indicated PE for testing purpose.
> >>=20
> >> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> >> ---
> >>  Documentation/vfio.txt        | 47 ++++++++++++++++++++++++++++++----=
---------
> >>  drivers/vfio/vfio_spapr_eeh.c | 14 +++++++++++++
> >>  include/uapi/linux/vfio.h     | 34 ++++++++++++++++++++++++++++++-
> >>  3 files changed, 80 insertions(+), 15 deletions(-)
> >>=20
> >> diff --git a/Documentation/vfio.txt b/Documentation/vfio.txt
> >> index 96978ec..2e7f736 100644
> >> --- a/Documentation/vfio.txt
> >> +++ b/Documentation/vfio.txt
> >> @@ -328,7 +328,13 @@ So 4 additional ioctls have been added:
> >> =20
> >>  The code flow from the example above should be slightly changed:
> >> =20
> >> -	struct vfio_eeh_pe_op pe_op =3D { .argsz =3D sizeof(pe_op), .flags =
=3D 0 };
> >> +	struct vfio_eeh_pe_op *pe_op;
> >> +	struct vfio_eeh_pe_err *pe_err;
> >> +
> >> +	pe_op =3D malloc(sizeof(*pe_op) + sizeof(*pe_err));
> >> +	pe_err =3D (void *)pe_op + sizeof(*pe_op);
> >> +	pe_op->argsz =3D sizeof(*pe_op) + sizeof(*pe_err);
> >
> >Surely that argsz can't be correct for most of the operations.  The
> >extended structure should only be there for the error inject ioctl,
> >yes?
> >
>=20
> argsz isn't appropriate for most cases because kernel has the check
> "expected_argsz < passed_argsz", not "expected_argsz =3D=3D
> passed_argsz".

It works for now, but if any of those calls was extended with more
data, it would break horribly.  By setting the argsz greater than
necessary, you're effectively passing uninitialized data to the
ioctl().  At the moment, the ioctl() ignores it, but the whole point
of the argsz value is that in the future, it might not.

> However, I'll fix it as follows to avoid confusion after collecting
> more comments:
>=20
> 	struct vfio_eeh_pe_op *pe_op;
> 	struct vfio_eeh_pe_err *pe_err;
>=20
> 	/* For all cases except error injection */
> 	pe_op =3D malloc(sizeof(*pe_op));
> 	pe_op->argsz =3D sizeof(*pe_op);
>=20
> 	/* For error injection case here */
> 	pe_op =3D realloc(sizeof(*pe_op) + sizeof(*pe_err));
> 	pe_op->argsz =3D sizeof(*pe_op) + sizeof(*pe_err);
> 	pe_err =3D (void *)pe_op + sizeof(*pe_op);
>=20
> Thanks,
> Gavin
>=20
>=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--GMArzDD+OGn24EFp
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVARRJAAoJEGw4ysog2bOS8C8P/3bnNjbL82PTmqPQwglrY1tq
sV7m5V7igzJX5wjVgajJkg2ipCsCoDB8td+yloeSGFQpOFXqDIL+qMMlZz0G75mb
qYqR8WI9f9RMPdCZtZI5d8B5tFktGUblek43EFJMWBZn5IWdpLVvLQ+cX1c0OmwZ
P+Ed+1SObPtn1NhmHZpeg5u9SqjMmHhKjRI79YrfGFg4p8IDptcOGCJPRxO+MHXi
FDvA4ZIotOstAh0KMaHDOjC0w6xX9wh9D6pKAUCgevcsVvUcUkJNeahlxEJPlFCc
m7psIoSrlhDEKE/ZZfIVREQHLMFLlKaTKkJyG0xkcy7cmJymYP6NTdXsWIO05WWZ
O2TyqAwl4udOkLVQl8h7RIaubTLFyDZK4TlPmsZZMoDTQFZk/UNKrBnW7mcawLmB
j0dPc3pZX+2rSd9RFPl5c2d8Vu5dwJYlCG9Tt8wiOlbGl0A9OA5fEkKM4r3Ko9JI
u9ejiKnQA3X6pHngDmYp4ZX5ciGSmqzNijlHUIPGD6mZ2m9+glCxt03XsoRd+k+p
Sysg4RurAnwjkuxESlxXuImNDCciCwsooVwtpBNXl6YCvhMR3yqNdiIYiDcG6zIA
CqE4A8ynO2RcMkgeb8nFgp7EvE6YBFaR0VfhkOrtX6ECwsGU+dBCyt93ym9mABLD
FNVmd3u5K5ZP1h7BSQQK
=HApV
-----END PGP SIGNATURE-----

--GMArzDD+OGn24EFp--
