Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [195.58.98.146])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 2C6D92C012D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Nov 2013 10:39:51 +1100 (EST)
In-Reply-To: <1384885766.1403.366.camel@snotra.buserror.net>
References: <20131118070423.E47181A4D3D@localhost.localdomain>	
 <OF5004EA63.AA9B7989-ONC1257C28.004D6C13-C1257C28.004DF922@transmode.se>
 <1384885766.1403.366.camel@snotra.buserror.net>
To: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
Subject: Re: [PATCH] lib/crc32: slice by 4 is more efficient than the default
 slice by 8 on Powerpc 8xx.
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Message-ID: <OFE596957E.9CEC5C97-ONC1257C28.00814EE8-C1257C28.0081FB80@transmode.se>
Date: Wed, 20 Nov 2013 00:39:45 +0100
Content-Type: text/plain; charset="ISO-8859-1"
Cc: Christophe Leroy <christophe.leroy@c-s.fr>,
 Marcelo Tosatti <marcelo@kvack.org>,
 Bob Pearson <rpearson@systemfabricworks.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Scott Wood <scottwood@freescale.com> wrote on 2013/11/19 19:29:26:
>=20
> I don't think we should go littering the Kconfig with defaults for
> various bits of hardware -- especially since you've already pointed out
> non-8xx hardware that would also want this.  Put it in defconfig
> instead, unless you can identify very broad classes of machines for
> which SLICEBY4 is faster.

hmm, when 64bits went in there was not much proof that it was faster for
a wide range of CPU, just 2 or 3 if I recall correctly. I suspect there
are quite a few CPUs where 32 bits a equal or faster.

  Jocke

>=20
> -Scott
>=20
> On Tue, 2013-11-19 at 15:11 +0100, Joakim Tjernlund wrote:
> > I found the same on MPC8321 long time ago(when 64 bits change went=20
in),=20
> > the 32 bits were much faster. I guess the "smaller"
> > CPUs cannot handle the cache trashing these big tables impose, I=20
didn't=20
> > look into the details though.
> > So I think this is a good change for 8xx.
> >=20
> > Acked-by: Joakim Tjernlund <joakim.tjernlund@transmode.se>
> >=20
> > Christophe Leroy <christophe.leroy@c-s.fr> wrote on 2013/11/18=20
08:04:23:
> >=20
> > > From: Christophe Leroy <christophe.leroy@c-s.fr>
> > > To: Vitaly Bordug <vitb@kernel.crashing.org>, Marcelo Tosatti=20
> > <marcelo@kvack.org>, Joakim Tjernlund <joakim.tjernlund@transmode.se>, =

Bob=20
> > Pearson <rpearson@systemfabricworks.com>,=20
> > > Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
> > > Date: 2013/11/19 13:05
> > > Subject: [PATCH] lib/crc32: slice by 4 is more efficient than the=20
> > default slice by 8 on Powerpc 8xx.
> > >=20
> > > On PPC=5F8xx, CRC32=5FSLICEBY4 is more efficient (almost twice) than =

> > CRC32=5FSLICEBY8,
> > > as shown below:
> > >=20
> > > With CRC32=5FSLICEBY8:
> > > [    1.109204] crc32: CRC=5FLE=5FBITS =3D 64, CRC=5FBE BITS =3D 64
> > > [    1.114401] crc32: self tests passed, processed 225944 bytes in=20
> > 15118910 nsec
> > > [    1.130655] crc32c: CRC=5FLE=5FBITS =3D 64
> > > [    1.134235] crc32c: self tests passed, processed 225944 bytes in=20
> > 4479879 nsec
> > >=20
> > > With CRC32=5FSLICEBY4:
> > > [    1.097129] crc32: CRC=5FLE=5FBITS =3D 32, CRC=5FBE BITS =3D 32
> > > [    1.101878] crc32: self tests passed, processed 225944 bytes in=20
> > 8616242 nsec
> > > [    1.116298] crc32c: CRC=5FLE=5FBITS =3D 32
> > > [    1.119607] crc32c: self tests passed, processed 225944 bytes in=20
> > 3289576 nsec
> > >=20
> > > Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> > >=20
> > > Index: a/lib/Kconfig
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > --- a/lib/Kconfig   (r=C3=A9vision 5325)
> > > +++ b/lib/Kconfig   (copie de travail)
> > > @@ -102,6 +102,7 @@
> > >  choice
> > >     prompt "CRC32 implementation"
> > >     depends on CRC32
> > > +   default CRC32=5FSLICEBY4 if PPC=5F8xx
> > >     default CRC32=5FSLICEBY8
> > >     help
> > >       This option allows a kernel builder to override the default=20
choice
> >=20
> > =5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F
> > Linuxppc-dev mailing list
> > Linuxppc-dev@lists.ozlabs.org
> > https://lists.ozlabs.org/listinfo/linuxppc-dev
> >=20
> >=20
>=20
>=20
>=20
