Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 84C04DDDF2
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Nov 2007 13:28:50 +1100 (EST)
Date: Tue, 6 Nov 2007 13:28:46 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: [RFC] Rework of i2c-mpc.c - Freescale i2c driver
Message-Id: <20071106132846.612f3afc.sfr@canb.auug.org.au>
In-Reply-To: <9e4733910711051734m7cf1fac0y5fb39feb37bad548@mail.gmail.com>
References: <9e4733910711050714l2aa3a5eeqf5327c3e0d8ca490@mail.gmail.com>
	<472F7247.9070106@freescale.com>
	<9e4733910711051734m7cf1fac0y5fb39feb37bad548@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__6_Nov_2007_13_28_46_+1100_uVvPrrZNBpMp9k0w"
Cc: Tjernlund <tjernlund@tjernlund.se>, Jean Delvare <khali@linux-fr.org>,
	i2c@lm-sensors.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__6_Nov_2007_13_28_46_+1100_uVvPrrZNBpMp9k0w
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 5 Nov 2007 20:34:51 -0500 "Jon Smirl" <jonsmirl@gmail.com> wrote:
>
> On 11/5/07, Scott Wood <scottwood@freescale.com> wrote:
> > > +static struct of_platform_driver mpc_i2c_driver =3D {
> > > +     .owner          =3D THIS_MODULE,
> > > +     .name           =3D DRV_NAME,
> > > +     .match_table    =3D mpc_i2c_of_match,
> > > +     .probe          =3D mpc_i2c_probe,
> > > +     .remove         =3D __devexit_p(mpc_i2c_remove),
> > > +     .driver         =3D {
> > > +             .name   =3D DRV_NAME,
> > >       },
> > >  };
> >
> > Do we still need .name if we have .driver.name?
>=20
> This is a general question, if of_platform_driver doesn't need .name
> it should be removed from the structure.

I am in the process of doing that.  However there a quite a few drivers
that need to be fixed first.  In the meantime,
of_register_platform_driver will copy which ever of the name and owner
fields you fill in to the others, so we can convert over time.  For new
drivers (and changing), please use the name and owner fields in the
embedded device_driver struct. (this is the same as done by the platform
drivers currently ...)

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__6_Nov_2007_13_28_46_+1100_uVvPrrZNBpMp9k0w
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHL9FjTgG2atn1QN8RArWrAJ44d8bsUz6DDX3zkEkvZ1LMYFcayQCfUCI2
XHfuF7y6tH7LNQ5R+DAc5Tk=
=/Udr
-----END PGP SIGNATURE-----

--Signature=_Tue__6_Nov_2007_13_28_46_+1100_uVvPrrZNBpMp9k0w--
