Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 87AD2DDDF6
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jan 2007 07:52:53 +1100 (EST)
Date: Wed, 10 Jan 2007 23:14:21 +0300
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 3/5] [FS_ENET] OF-related update for FEC and SCC MAC's
Message-ID: <20070110231421.6c6ec86c@localhost.localdomain>
In-Reply-To: <CE5804BC-675C-474A-B74B-62E6B8E0D9F2@kernel.crashing.org>
References: <20070110011124.20342.38130.stgit@localhost.localdomain>
	<20070110011154.20342.12189.stgit@localhost.localdomain>
	<CE5804BC-675C-474A-B74B-62E6B8E0D9F2@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_=_BY7qeWeCL7RIbFVhDt+m8";
	protocol="application/pgp-signature"; micalg=PGP-SHA1
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Sig_=_BY7qeWeCL7RIbFVhDt+m8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 10 Jan 2007 11:07:58 -0600
Kumar Gala wrote:

>=20
> On Jan 9, 2007, at 7:11 PM, Vitaly Bordug wrote:
>=20
> >
> > Updated direct resource pass with ioremap call, make it grant =20
> > proper IRQ
> > mapping, stuff incompatible with the new approach were
> > respectively put  under
> > #ifndef CONFIG_PPC_MERGE.
> >
> > Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>
> > ---
> >
> >  drivers/net/fs_enet/mac-fec.c |   13 +++++++++----
> >  drivers/net/fs_enet/mac-scc.c |    6 ++++--
> >  drivers/net/phy/fixed.c       |    2 +-
> >  3 files changed, 14 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/net/fs_enet/mac-fec.c b/drivers/net/fs_enet/=20
> > mac-fec.c
> > index c2c5fd4..474d6d7 100644
> > --- a/drivers/net/fs_enet/mac-fec.c
> > +++ b/drivers/net/fs_enet/mac-fec.c
> > @@ -104,9 +104,9 @@ static int do_pd_setup(struct fs_enet_private =20
> > *fep)
> >  	fep->interrupt =3D platform_get_irq_byname(pdev,"interrupt");
> >  	if (fep->interrupt < 0)
> >  		return -EINVAL;
> > -=09
> > +
> >  	r =3D platform_get_resource_byname(pdev, IORESOURCE_MEM,
> > "regs");
> > -	fep->fec.fecp =3D(void*)r->start;
> > +	fep->fec.fecp =3D (void *)ioremap(r->start, r->end -
> > r->start + 1);
>=20
> you should get rid of the (void *) cast
>=20

Here and below:=20
Agreed; will fix and respin.


Thanks,=20
Vitaly

--Sig_=_BY7qeWeCL7RIbFVhDt+m8
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFFpUkduOg9JvQhSEsRAr9LAJ4/igwnLP5HvNAXFHvyw9zScuMMzgCfQRlA
oNUQAnwLZZlsBYOJhgyCTdQ=
=v3CZ
-----END PGP SIGNATURE-----

--Sig_=_BY7qeWeCL7RIbFVhDt+m8--
