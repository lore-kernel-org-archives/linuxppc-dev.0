Return-Path: <lukma@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yknyC2XB7zDrcV
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Nov 2017 09:37:53 +1100 (AEDT)
Date: Sat, 25 Nov 2017 23:29:48 +0100
From: Lukasz Majewski <lukma@denx.de>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Arnaud Mouiche <arnaud.mouiche@invoxia.com>, broonie@kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 alsa-devel@alsa-project.org, tiwai@suse.com, perex@perex.cz,
 lgirdwood@gmail.com, fabio.estevam@nxp.com, timur@tabi.org,
 caleb@crome.org, max.krummenacher@toradex.com, mpa@pengutronix.de,
 mail@maciej.szmigiero.name
Subject: Re: [PATCH] ASoC: fsl_ssi: Override bit clock rate based on slot
 number
Message-ID: <20171125232921.01994d72@jawa>
In-Reply-To: <20170913230147.GA21287@Asurada-Nvidia>
References: <1504848223-3376-1-git-send-email-nicoleotsuka@gmail.com>
 <2020d72a-4517-55d0-59a1-171c71f91c7b@invoxia.com>
 <20170912213233.GA11419@Asurada-Nvidia>
 <fdb71350-0b89-8c5a-9ed0-c744bb6f2118@invoxia.com>
 <20170913230147.GA21287@Asurada-Nvidia>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/P9/mtF/.pSIy2CD/LP33DJF"; protocol="application/pgp-signature"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Sig_/P9/mtF/.pSIy2CD/LP33DJF
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Nicolin,

> On Wed, Sep 13, 2017 at 10:02:20AM +0200, Arnaud Mouiche wrote:
>=20
> > >Could you please give me a few set of examples of how you set
> > >set_sysclk(), set_tdm_slot() with the current driver? The idea
> > >here is to figure out a way to calculate the bclk in hw_params
> > >without getting set_sysclk() involved any more. =20
>=20
> > Here is one, where a bclk =3D 4*16*fs is expected =20
>=20
> > In another setup, there are 8 x 16 bits slots, whatever the number
> > of active channels is.
> > In this case bclk =3D 128 * fs
> > The number of slots is completely arbitrary. Some slots can even be
> > reserved for communication between codecs that don't communicate
> > with linux. =20
>=20
> In summary, bclk =3D sample rate * slots * slot_width;
>=20
> I will update my patch soon.
>=20
> > >Unfortunately, it looks like a work around to me. I understand
> > >the idea of leaving set_sysclk() out there to override the bit
> > >clock is convenient, but it is not a standard ALSA design and
> > >may eventually introduce new problems like today. =20
> >=20
> > I agree. I'm not conservative at all concerning this question.
> > I don't see a way to remove set_sysclk without breaking current TDM
> > users anyway, at least for those who don't have their code
> > upstreamed. =20
>=20
> Which TDM case would be broken by this removal? The only impact
> that I can see is that the ASoC core returns an ENOTSUPP for a
> set_sysclk() call now, which is something that a dai-link driver
> should have taken care of anyway.
>=20
> > All information provided through snd_soc_dai_set_tdm_slot( cpu_dai,
> > mask, mask, slots, width ) should be enough
> > In this case, for TDM users
> >=20
> >    bclk =3D slots * width * fs   (where slots is !=3D channels) =20
>=20
> > will manage 99 % of the cases.
> > And the remaining 1% will concern people who need to hack the kernel
> > so widely they don't care about the set_sysclk removal. =20
>=20
> A patch from those people will be always welcome.
>=20
> > - fsl-asoc-card.c : *something will break since
> > snd_soc_dai_set_sysclk returned code is checked* =20
>=20
> I've already submitted a patch to ignore all ENOTSUPP.

Nicolin, do you know what happened with this patch? I couldn't find it
in current linux/master.

Has it been applied to any asoc tree for being upstreamed?

Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de

--Sig_/P9/mtF/.pSIy2CD/LP33DJF
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAloZ7twACgkQAR8vZIA0
zr3UNwgAxc7jIVuPCbUqlreObR7s2qxgN7/9bH9gZb06a6jYk1mItbMYU6wPqB62
2FxeHSqxWxRUrAFARxpLxDOD8Wr5C86OrWs2qFL9a1ljKN2wyUCcCtWceiVNfkfP
Lhq9R93SBBcYv2djUYezv5W5aOGF2kSlr7blAanf01oC48WDkBdMnTaMK9UCbxB0
u8s5gkfXAyODs68JqxvI+v4LJH9yj05hjv/ZN+cntyhJKsydZJNNiAIH37z2JmwY
iql07mOzalBdsgjfMiikArgyFJQq7g+WoiVzMYUU0ldfcytZFDl6lHHtF/bUqicd
Ywk9UFGdwZUUC14uZDB2iJYWGirVgg==
=8trV
-----END PGP SIGNATURE-----

--Sig_/P9/mtF/.pSIy2CD/LP33DJF--
