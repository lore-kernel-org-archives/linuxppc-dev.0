Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] enable RTAS /proc for PowerPC/CHRP platform
From: Michael Ellerman <michael@ellerman.id.au>
To: Nicolas DET <nd@bplan-gmbh.de>
In-Reply-To: <4535C0F8.1070905@bplan-gmbh.de>
References: <4534BE9D.7030908@bplan-gmbh.de> <20061017132243.GA6773@lst.de>
	<4535C0F8.1070905@bplan-gmbh.de>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-HWWv2gB2THa/Lh7jpNQ5"
Date: Wed, 18 Oct 2006 16:15:09 +1000
Message-Id: <1161152109.7906.6.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: akpm@osdl.org, linuxppc-dev@ozlabs.org, Sven Luther <sl@bplan-gmbh.de>,
	tilmann@bitterberg.de
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-HWWv2gB2THa/Lh7jpNQ5
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-10-18 at 07:51 +0200, Nicolas DET wrote:
> Christoph Hellwig wrote:
>  >> --- a/arch/powerpc/kernel/rtas-proc.c    2006-10-14=20
> 05:34:03.000000000 +0200
>  >> +++ b/arch/powerpc/kernel/rtas-proc.c    2006-10-16=20
> 10:46:16.000000000 +0200
>  >> @@ -253,43 +253,70 @@ static void get_location_code(struct seq
>  >>  static void check_location_string(struct seq_file *m, char *c);
>  >>  static void check_location(struct seq_file *m, char *c);
>  >>
>  >> +#ifdef CONFIG_PPC64
>  >> +#define PROCRTAS_ROOT "ppc64"
>  >> +#else
>  >> +#define PROCRTAS_ROOT "ppc"
>  >
>  > Please don't do any pathname changes.  Even if ppc64 isn't correct it'=
s
>  > what applications expect and what we should provide for a coherent use=
r
>  > interface.
>=20
> Humm, ok.
> However, in this case 'ppc' (could be 32 or 64 as it is not specified)=20
> is more generic than 'ppc64'.

But it's called '/proc/ppc64' right now on lots of machines, so you
can't go changing it.

>  > This should be the only change you need, and it should follow kernel
>  > coding style, aka:
>  >
>  >     if (!machine_is(pseries) && !machine_is(chrp))
>  >         return -ENODEV;
>  >
>  >>      rtas_node =3D of_find_node_by_name(NULL, "rtas");
>  >>      if (rtas_node =3D=3D NULL)
>  >>          return -ENODEV;
>  >
>  > And given this check I wonder why we need the platform check at all.  =
It
>  > should be safe to just remove it.
>  >
>  >
>=20
> Indeed, however I can only test on CHRP. I'll remove the check in the=20
> upcomming patch.

That should be fine AFAICT, you should probably just check that each of
the proc routines checks for errors - ie. just because you have an
"/rtas" node doesn't mean you necessarily have "/rtas/set-indicator" or
whatever.

> The patch also include a small code to create the /proc/ppc/rtas entry.=20
> Should this be done here, or somewhere in arch/powerpc/chrp/setup.c ?

That code is almost entirely the same as proc_ppc64_create(), so I think
you should try and merge them - we want to minimise the number of
foo_ppc64() and foo_ppc32() routines we have.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-HWWv2gB2THa/Lh7jpNQ5
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBFNcZtdSjSd0sB4dIRAnXpAJ4lLMLuwB3HhBgJ/3apu/Sd8rcDIgCfROUR
MOZetg0erh+YIL3H4oMlPIE=
=VIC4
-----END PGP SIGNATURE-----

--=-HWWv2gB2THa/Lh7jpNQ5--
