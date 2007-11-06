Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id B3D10DDDFE
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Nov 2007 15:40:12 +1100 (EST)
Date: Tue, 6 Nov 2007 15:40:04 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: [RFC] Rework of i2c-mpc.c - Freescale i2c driver
Message-Id: <20071106154004.4f01a536.sfr@canb.auug.org.au>
In-Reply-To: <9e4733910711052025m7905efb6ja3e4b6a022e6aa81@mail.gmail.com>
References: <9e4733910711050714l2aa3a5eeqf5327c3e0d8ca490@mail.gmail.com>
	<472F7247.9070106@freescale.com>
	<9e4733910711051230w2d90a710idec3dcfc2e0f5c16@mail.gmail.com>
	<472F8267.8070106@freescale.com>
	<9e4733910711052025m7905efb6ja3e4b6a022e6aa81@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__6_Nov_2007_15_40_04_+1100_XQ15B7KIkqM30+nh"
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

--Signature=_Tue__6_Nov_2007_15_40_04_+1100_XQ15B7KIkqM30+nh
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jon,

On Mon, 5 Nov 2007 23:25:35 -0500 "Jon Smirl" <jonsmirl@gmail.com> wrote:
>
> +		compatible =3D of_get_property(node, "compatible", &len);
> +		strlcpy(info.driver_name, compatible, len);

Of course, you will check len against sizeof(info.driver_name), right?

> -/* With some changes from Ky=C3=B6sti M=C3=A4lkki <kmalkki@cc.hut.fi>.
> +/* With some changes from Ky=C3=AF=C2=BF=C5=93sti M=C3=AF=C2=BF=C5=93lkk=
i <kmalkki@cc.hut.fi>.

Did you mean to change this?

> +	char **alias;

const char ** would be nicer.

>  struct i2c_driver {
>  	int id;
>  	unsigned int class;
> +=09
> +	/* Alias name for the driver. Used to support device trees on
> +	 * the PowerPC architecture. Device tree names take the form of
> +	 * vendor,chip. For example "epson,pcf8564". Alias is a list of
> +	 * strings terminated by a zero entry.
> +	 */
> +	char **alias;

const char ** would be nicer;

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__6_Nov_2007_15_40_04_+1100_XQ15B7KIkqM30+nh
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHL/AqTgG2atn1QN8RAsReAJ4xV61dcluWiI8bgdI3MIts0AqM4ACaArrT
7XPfCglCBis3khgEXKbaoPk=
=g2Qc
-----END PGP SIGNATURE-----

--Signature=_Tue__6_Nov_2007_15_40_04_+1100_XQ15B7KIkqM30+nh--
