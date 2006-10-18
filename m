Return-Path: <michael@ellerman.id.au>
Subject: Re: [Cbe-oss-dev] [PATCH 2/2] Add support for dumping spu info
	from xmon
From: Michael Ellerman <michael@ellerman.id.au>
To: Geoff Levand <geoffrey.levand@am.sony.com>
In-Reply-To: <452E7E8E.8000808@am.sony.com>
References: <20061012120312.10FDD67BE5@ozlabs.org>
	<452E7E8E.8000808@am.sony.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-USzTjjNqaJ4uo6OpNSOf"
Date: Wed, 18 Oct 2006 16:56:13 +1000
Message-Id: <1161154573.7906.11.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd.bergmann@de.ibm.com>,
	cbe-oss-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-USzTjjNqaJ4uo6OpNSOf
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2006-10-12 at 10:42 -0700, Geoff Levand wrote:
> Michael Ellerman wrote:
> > This patch adds a command to xmon for dumping information about
> > spu structs. The command is 'sf' for "spu fields" perhaps, and
> > takes the spu number as an argument. This is the same value as the
> > spu->number field, or the "phys-id" value of a context when it is
> > bound to a physical spu.
>=20
> > +static void dump_spu_fields(struct spu *spu)
> > +{
> ...
> > +	DUMP_FIELD(spu, "0x%x", problem->spu_npc_RW);
> > +	DUMP_FIELD(spu, "0x%p", priv1);
> > +
> > +	if (spu->priv1)
> > +		DUMP_FIELD(spu, "0x%lx", priv1->mfc_sr1_RW);
> > +
> > +	DUMP_FIELD(spu, "0x%p", priv2);
>=20
> Just to let you know, I've been doing some work to abstract the platform
> specific parts out of the spu support to better support running on a
> hypervisor.  It shouldn't make much difference, but maybe I'll try to set
> something up like this for you:
> =20
> 	DUMP_FIELD(spu, "0x%x", problem->spu_npc_RW);
> 	DUMP_FIELD(spu, "0x%p", priv2);
> 	spu_dump_platform_fields(spu);

We already have the spu_priv1_ops abstracted out, is that not enough? I
decided to check explicitly for the priv1 pointer because calling the
hypervisor from a panicked kernel is risky at best. Although I haven't
seen how you guys implement hypervisor calls, so perhaps it's not so
bad.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-USzTjjNqaJ4uo6OpNSOf
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBFNdANdSjSd0sB4dIRAhr6AKC6rDYbWu4MFGWNKYwpBJ/wY/YiXwCff1+U
2RR9ukdWkJ/B+PKLeekgM6Q=
=hy3f
-----END PGP SIGNATURE-----

--=-USzTjjNqaJ4uo6OpNSOf--
