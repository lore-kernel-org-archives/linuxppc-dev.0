Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] Reorganise and then fixup the pseries cpu hotplug code
From: Michael Ellerman <michael@ellerman.id.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20061117153105.edca0777.sfr@canb.auug.org.au>
References: <20061116154051.GB2008@localdomain>
	<20061117033638.0E24B67BCE@ozlabs.org>
	<20061117153105.edca0777.sfr@canb.auug.org.au>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-uLy//FRnBZHv1axYGnKM"
Date: Fri, 17 Nov 2006 15:44:00 +1100
Message-Id: <1163738640.16815.45.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: ego@in.ibm.com, linuxppc-dev@ozlabs.org, srinivasa@in.ibm.com,
	Anton Blanchard <anton@samba.org>, ntl@pobox.com, paulus@samba.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-uLy//FRnBZHv1axYGnKM
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2006-11-17 at 15:31 +1100, Stephen Rothwell wrote:
> One small nit ...
>=20
> On Fri, 17 Nov 2006 14:36:35 +1100 Michael Ellerman <michael@ellerman.id.=
au> wrote:
> >
> > +static int __init pseries_cpu_hotplug_init(void)
> > +{
> > +	rtas_stop_self_args.token =3D rtas_token("stop-self");
> > +	qcss_tok =3D rtas_token("query-cpu-stopped-state");
> > +
> > +	if (rtas_stop_self_args.token =3D=3D RTAS_UNKNOWN_SERVICE ||
> > +			qcss_tok =3D=3D RTAS_UNKNOWN_SERVICE)
> > +		return 1;
>=20
> initcall fucntions should return 0 or -<error>;  -ENODEV is ignored,
> other nonzero values cause a log message if initcall debugging is enabled=
.

OK. I wanted to return an error, so there's something in the log to show
that cpu hotplug was disabled - but I didn't check what to return. I'll
fix it up on Monday to return -ENOENT.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-uLy//FRnBZHv1axYGnKM
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBFXT4QdSjSd0sB4dIRArDOAJ0RI9Lko67j11VMBwCZiBT1kV7GiwCfU/Va
fcMeTAVh4A2G8QTel4diExw=
=2lr+
-----END PGP SIGNATURE-----

--=-uLy//FRnBZHv1axYGnKM--
