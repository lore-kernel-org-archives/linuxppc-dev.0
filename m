Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 12/15] powerpc: Do not use op_model_cell under LPAR
From: Michael Ellerman <michael@ellerman.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1165899226.11914.20.camel@localhost.localdomain>
References: <200612120402.kBC42USg007674@toshiba.co.jp>
	<1165896791.14839.7.camel@concordia.ozlabs.ibm.com>
	<1165899226.11914.20.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-2yVoEelM0MQ0RNzuYl6g"
Date: Tue, 12 Dec 2006 15:55:56 +1100
Message-Id: <1165899356.14839.20.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-2yVoEelM0MQ0RNzuYl6g
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-12-12 at 15:53 +1100, Benjamin Herrenschmidt wrote:
> On Tue, 2006-12-12 at 15:13 +1100, Michael Ellerman wrote:
> > On Tue, 2006-12-12 at 13:02 +0900, Ishizaki Kou wrote:
> > > op_model_cell supports native Cell processor. Under LPAR environment,
> > > it cannot work.
> > >=20
> > > Signed-off-by: Kou Ishizaki <kou.ishizaki.co.jp>
> > > ---
> > >=20
> > > Index: linux-powerpc-git/arch/powerpc/oprofile/common.c
> > > diff -u linux-powerpc-git/arch/powerpc/oprofile/common.c:1.1.1.1 linu=
x-powerpc-git/arch/powerpc/oprofile/common.c:1.2
> > > --- linux-powerpc-git/arch/powerpc/oprofile/common.c:1.1.1.1	Wed Dec =
 6 08:25:43 2006
> > > +++ linux-powerpc-git/arch/powerpc/oprofile/common.c	Wed Dec  6 08:43=
:15 2006
> > > @@ -149,6 +149,8 @@
> > >  #ifdef CONFIG_PPC64
> > >  #ifdef CONFIG_PPC_CELL_NATIVE
> > >  		case PPC_OPROFILE_CELL:
> > > +			if (firmware_has_feature(FW_FEATURE_LPAR))
> > > +				return -ENODEV;
> > >  			model =3D &op_model_cell;
> > >  			break;
> > >  #endif
> >=20
> > Is FW_FEATURE_LPAR is the right switch to use here, I'm not sure.
>=20
> For now, it probably is as none of the LPAR env. for cell work with that
> op_model.

Sure, there's probably twenty different things we could use at the
moment, I'm just wondering out loud if LPAR is the best thing to reduce
the chance we have to change it in the future.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-2yVoEelM0MQ0RNzuYl6g
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBFfjZcdSjSd0sB4dIRAr7IAJ9R57mZoLLKXtrJiCMp76yKURlFzgCfTUtX
UFcvIqiGBtXbTeoSSbQ7FPo=
=A29j
-----END PGP SIGNATURE-----

--=-2yVoEelM0MQ0RNzuYl6g--
