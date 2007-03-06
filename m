Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] Fix interrupt distribution in ppc970
From: Michael Ellerman <michael@ellerman.id.au>
To: mohan@in.ibm.com
In-Reply-To: <20070306135754.GB7476@in.ibm.com>
References: <20061208045537.GA14626@in.ibm.com>
	<17798.6928.378248.28903@cargo.ozlabs.ibm.com>
	<20061218105706.GB3911@in.ibm.com> <20070306135754.GB7476@in.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-PxOuLcJHhwVZfj+KpdiZ"
Date: Tue, 06 Mar 2007 15:16:55 +0100
Message-Id: <1173190615.4675.30.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: ppcdev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>,
	fastboot@lists.osdl.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-PxOuLcJHhwVZfj+KpdiZ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2007-03-06 at 19:27 +0530, Mohan Kumar M wrote:
> Hi,
>=20
> Here comes the revised version of patch to fix the interrupt missing
> problem when a kdump kernel is booted with "maxcpus=3D1" kernel parameter=
.
>=20
> In the xics initialization code a check is made to detemine whether
> maxcpus kernel parameter is present and if its present then
> default_distrib_server variable is initialized to the current boot cpu
> id (by default_server variable). So that when ever a kernel is booted
> with maxcpus kernel parameter all interrupts are routed to the boot cpu
> only.
>=20
> Tested on POWER5 and JS20 systems.

First, I don't know why we keep telling people to use maxcpus=3D1 for
kexec/kdump - it's causing bugs, and I don't know of any that it fixes?

Second, the way you've written this is not so good. The xics code should
not be checking that "maxcpus" exists on the command line, it should be
checking that the distrib server points to a cpu that is online - using
cpu_online() etc.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-PxOuLcJHhwVZfj+KpdiZ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBF7XfXdSjSd0sB4dIRAky8AJ0WjzUjyIV4CjKQn3HoLWfHkLGiHACfS4Rm
tUPzHTNCYFXOgxfXHa7zdBU=
=i+hX
-----END PGP SIGNATURE-----

--=-PxOuLcJHhwVZfj+KpdiZ--
