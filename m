Return-Path: <wsa@the-dreams.de>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5BB601A01BA
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Dec 2014 04:46:47 +1100 (AEDT)
Received: from pokefinder.org (sauhun.de [89.238.76.85])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id DF21B1400E7
 for <linuxppc-dev@ozlabs.org>; Fri,  5 Dec 2014 04:46:46 +1100 (AEDT)
Date: Thu, 4 Dec 2014 18:46:42 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: [alsa-devel] [RFC 2/2] sound: ppc: keywest: drop using attach
 adapter
Message-ID: <20141204174642.GA7944@katana>
References: <1417711313-7257-1-git-send-email-wsa@the-dreams.de>
 <1417711313-7257-3-git-send-email-wsa@the-dreams.de>
 <s5hiohrpd0w.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="PNTmBPCT7hxwcZjr"
In-Reply-To: <s5hiohrpd0w.wl-tiwai@suse.de>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > +
> > +	/* We assume Macs have consecutive I2C bus numbers starting at 0 */
> > +	while (adap) {
> > +		err =3D keywest_attach_adapter(adap);
> > +		if (!err)
> > +			break;
> > +		i2c_put_adapter(adap);
> > +		adap =3D i2c_get_adapter(++i);
> > +	}
> > +
> >  	return 0;
>=20
> What if adap is NULL in the last while loop?  Isn't it supposed to
> return an error?

True, we probably should have something like

	return adap ? 0 : -ENODEV;

Thanks!

--PNTmBPCT7hxwcZjr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUgJ4BAAoJEBQN5MwUoCm2DcYP/iXD/LXZnNZdGJK9LJLFk46C
9o07m4srk91m4GeJJw7pmiF8y8BhEHtwNZfEFokXuOhLHczMHslyzspOJH/rGjFA
MVPIUX1/apojiAjUj2rxxqtfDUorOQ3WR0pwlZatTwQYV7xRnH1jqC5o+PXYOyfL
RtAhmEmqUHYLgJSDtRoeqBPYEC8rvWl1ylGZmzURQ7Pwe6Em+lqDk1rFwfSYiOCK
Wi7dOP9Ra+aVKWWrHQ1yyD2c0cliOEV33s4UMLjYA7ZtvbldtqwR7neUkpBJhbQY
axCjuK+/AvZvKplnSEHUrnkFM1pWqEmP9SSI1b3EXK+DUKwe+DpghjuDjF36tXRy
jKfJnocFzFhgBzKEspWZ9CA5nd+nmB/StoC5XHSrh2QiZgB/SFs/tITEs5BsEccC
Ae1qypm2YlO/646kXvkeMmceobIai+t6KlhVPoLUgomjwhVVwkZlg806Ma6Z1GZw
QrbdLRk6rxeNoxgrpYoQmz0bbfu+eGPdtwEPdmF/kXiNhvdPJ+Ll04Yl6HJIF/Qo
D6Q4j7WDpTjjO6ay6uBocPJlZTM2izMwNP7ikmWSp/behold/BnFVB6CvrOmZPEX
eRA2nItjKCBItIMmPsxhXJTJ0f3ZGqpFb53yWH1LnLicK5RyN3/1gW4nzHHCVgzn
/w1YkBdn3r/uu0+nIZPS
=Fcnn
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--
