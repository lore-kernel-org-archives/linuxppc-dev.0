Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] Reorganise and then fixup the pseries cpu hotplug code
From: Michael Ellerman <michael@ellerman.id.au>
To: Linas Vepstas <linas@austin.ibm.com>
In-Reply-To: <20061117181133.GH23600@austin.ibm.com>
References: <20061116154051.GB2008@localdomain>
	<20061117033638.0E24B67BCE@ozlabs.org>
	<20061117153105.edca0777.sfr@canb.auug.org.au>
	<1163738640.16815.45.camel@localhost.localdomain>
	<20061117181133.GH23600@austin.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-YmjbtmhGlrO2xZ1ZcOiN"
Date: Mon, 20 Nov 2006 11:44:16 +1100
Message-Id: <1163983456.7832.6.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, ego@in.ibm.com,
	linuxppc-dev@ozlabs.org, ntl@pobox.com,
	Anton Blanchard <anton@samba.org>, srinivasa@in.ibm.com, paulus@samba.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-YmjbtmhGlrO2xZ1ZcOiN
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2006-11-17 at 12:11 -0600, Linas Vepstas wrote:
> On Fri, Nov 17, 2006 at 03:44:00PM +1100, Michael Ellerman wrote:
> > On Fri, 2006-11-17 at 15:31 +1100, Stephen Rothwell wrote:
> > > One small nit ...
> > >=20
> > > On Fri, 17 Nov 2006 14:36:35 +1100 Michael Ellerman <michael@ellerman=
.id.au> wrote:
> > > >
> > > > +static int __init pseries_cpu_hotplug_init(void)
> > > > +{
> > > > +	rtas_stop_self_args.token =3D rtas_token("stop-self");
> > > > +	qcss_tok =3D rtas_token("query-cpu-stopped-state");
> > > > +
> > > > +	if (rtas_stop_self_args.token =3D=3D RTAS_UNKNOWN_SERVICE ||
> > > > +			qcss_tok =3D=3D RTAS_UNKNOWN_SERVICE)
> > > > +		return 1;
> > >=20
> > > initcall fucntions should return 0 or -<error>;  -ENODEV is ignored,
> > > other nonzero values cause a log message if initcall debugging is ena=
bled.
> >=20
> > OK. I wanted to return an error, so there's something in the log to sho=
w
> > that cpu hotplug was disabled - but I didn't check what to return. I'll
> > fix it up on Monday to return -ENOENT.
>=20
> I presume the default config from RedHat/SuSE is to have
> CONFIG_HOTPLUG_CPU turned on. In this case, all sorts of=20
> pseries boxes will spew a warning. I suppose this is a=20
> form of subliminal advertising: "Hey Schmo, upgrade your=20
> box to something that supports CPU hotplug!".=20

Yeah the distros would have it on for everything. I'm not sure what
machines support it, but I think it'd best to have some indication in
the log that we disabled it.

I'll change it to printk, and always return success. As an aside, I
don't really see the point of having return codes from init routines if
nothing is done with them by default ... but whatever.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-YmjbtmhGlrO2xZ1ZcOiN
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBFYPpgdSjSd0sB4dIRAoPuAJ9ciJfPTYhfZkZS3UShua8o3H5k3wCfWSJD
+/i05bd7yfeL7t+Y6ogngBE=
=WrxK
-----END PGP SIGNATURE-----

--=-YmjbtmhGlrO2xZ1ZcOiN--
