Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xSVXk4CYCzDqp7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Aug 2017 11:14:30 +1000 (AEST)
Date: Thu, 10 Aug 2017 10:54:09 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 08/10] powerpc/xive: take into account
 '/ibm,plat-res-int-priorities'
Message-ID: <20170810005409.GT13670@umbus.fritz.box>
References: <1502182579-990-1-git-send-email-clg@kaod.org>
 <1502182579-990-9-git-send-email-clg@kaod.org>
 <20170809040227.GE13670@umbus.fritz.box>
 <0aaa22ae-6bb7-719c-f772-4f24b8eb9dc9@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="7Ha3rcGc4ZVRbLT1"
In-Reply-To: <0aaa22ae-6bb7-719c-f772-4f24b8eb9dc9@kaod.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--7Ha3rcGc4ZVRbLT1
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 09, 2017 at 09:14:49AM +0200, C=E9dric Le Goater wrote:
> On 08/09/2017 06:02 AM, David Gibson wrote:
> > On Tue, Aug 08, 2017 at 10:56:18AM +0200, C=E9dric Le Goater wrote:
> >> '/ibm,plat-res-int-priorities' contains a list of priorities that the
> >> hypervisor has reserved for its own use. Scan these ranges to choose
> >> the lowest unused priority for the xive spapr backend.
> >>
> >> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> >> ---
> >>  arch/powerpc/sysdev/xive/spapr.c | 62 +++++++++++++++++++++++++++++++=
++++++++-
> >>  1 file changed, 61 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/arch/powerpc/sysdev/xive/spapr.c b/arch/powerpc/sysdev/xi=
ve/spapr.c
> >> index 7fc40047c23d..220331986bd8 100644
> >> --- a/arch/powerpc/sysdev/xive/spapr.c
> >> +++ b/arch/powerpc/sysdev/xive/spapr.c
> >> @@ -532,13 +532,70 @@ static const struct xive_ops xive_spapr_ops =3D {
> >>  	.name			=3D "spapr",
> >>  };
> >> =20
> >> +/*
> >> + * get max priority from "/ibm,plat-res-int-priorities"
> >> + */
> >> +static bool xive_get_max_prio(u8 *max_prio)
> >> +{
> >> +	struct device_node *rootdn;
> >> +	const __be32 *reg;
> >> +	u32 len;
> >> +	int prio, found;
> >> +
> >> +	rootdn =3D of_find_node_by_path("/");
> >> +	if (!rootdn) {
> >> +		pr_err("not root node found !\n");
> >> +		return false;
> >> +	}
> >> +
> >> +	reg =3D of_get_property(rootdn, "ibm,plat-res-int-priorities", &len);
> >> +	if (!reg) {
> >> +		pr_err("Failed to read 'ibm,plat-res-int-priorities' property\n");
> >> +		return false;
> >> +	}
> >> +
> >> +	if (len % (2 * sizeof(u32)) !=3D 0) {
> >> +		pr_err("invalid 'ibm,plat-res-int-priorities' property\n");
> >> +		return false;
> >> +	}
> >> +
> >> +	/* HW supports priorities in the range [0-7] and 0xFF is a
> >> +	 * wildcard priority used to mask. We scan the ranges reserved
> >> +	 * by the hypervisor to find the lowest priority we can use.
> >> +	 */
> >> +	found =3D 0xFF;
> >> +	for (prio =3D 0; prio < 8; prio++) {
> >> +		int reserved =3D 0;
> >> +		int i;
> >> +
> >> +		for (i =3D 0; i < len / (2 * sizeof(u32)); i++) {
> >> +			int base  =3D be32_to_cpu(reg[2 * i]);
> >> +			int range =3D be32_to_cpu(reg[2 * i + 1]);
> >> +
> >> +			if (prio >=3D base && prio < base + range)
> >> +				reserved++;
> >> +		}
> >> +
> >> +		if (!reserved)
> >> +			found =3D prio;
> >=20
> > So you continue the loop here, rather than using break.  Which means
> > found will be the highest valued priority that's not reserved.  Is
> > that what you intended?  The commit message says you find the lowest
> > unused, but do lower numbers mean higher priorities or the other way ar=
ound?
>=20
> yes. I should probably add a statement on how the priorities are=20
> ordered : the most privileged is the lowest value.

Ok.  My inclination would be to reverse the order of the loop, and
break; on the first (=3D=3Dlowest priority) unused entry.  But you could
fairly argue that's premature optimization.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--7Ha3rcGc4ZVRbLT1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmLrrEACgkQbDjKyiDZ
s5ITug//eRq5V4JvQHnBhc3hNbj+mjkJUPNiNj9xJbPLW7NCiPQWKjrSBrk3Aaqx
08rr0gc0FxJ4YCv0xNok0KBfc1VrNkTiGRaimj8Rcqtm4z4qQSNlpNijPUvQR0Z/
xCtHSRw1yq6GAnWazsP6SNK4j+UFEh6oNhoRDi5JyeMFnooaGz5TIKmh54fp6lCJ
pGS75QyHHcF7xJa5izdvx/yeZiscdbuxUqgSScjUVJ5W6iuSVKyrOsigd7ukJAum
8zMyT6kMVh9r+MycFNtnl64KyCUZYZzeLF4sL/CNUVqpy6D2Q+GR/4hqPe8jy6PF
MPGpYg0TWn6bOPMfB1pia1NW5GfSGs6cRzXQrmYYHUN1W65LwPf5yMO9b5GJOfum
dK/aRYgo5SdAnJQbjb4NS4domT7E1nr904qazDuQx2a/xptZSP90PCWlsCt+l33M
9PqbRR+kXzIT3ZNLohQkNouym8uv2PwtA+iBAuYMWJ9iJ/xoVs1NMimT3ztADDd9
FmmetcqeA2kBKutCqAkIC9o6yFn8KD9t5dMZf9jg9sDCrpWYZdRp3W32crZaQrxi
tyOLyL4kf0FWokdoLHEQNhbzR7e9OZNTyQNonWmHvwkan0QoZn5d6Zspsu+qQvSD
s0GxtmNYkKGw7vGm1A1yVsU+SsxmUrqMe+6yPVJCldBR1rriLQY=
=OtHX
-----END PGP SIGNATURE-----

--7Ha3rcGc4ZVRbLT1--
