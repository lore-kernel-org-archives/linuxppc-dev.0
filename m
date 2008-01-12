Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 353F9DDE32
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Jan 2008 14:47:37 +1100 (EST)
Date: Sat, 12 Jan 2008 14:47:22 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: [i2c] [PATCH 19 1/5] Implement module aliasing for i2c to
	translate from device tree names
Message-Id: <20080112144722.e0de9306.sfr@canb.auug.org.au>
In-Reply-To: <9e4733910801111900w6ace7c3bxe7e5f781db07ae4b@mail.gmail.com>
References: <20080112024737.7023.61680.stgit@terra.home>
	<20080112024739.7023.90634.stgit@terra.home>
	<9e4733910801111900w6ace7c3bxe7e5f781db07ae4b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Sat__12_Jan_2008_14_47_22_+1100_Ea.ZjLb2a9KWuI=V"
Cc: linuxppc-dev@ozlabs.org, i2c@lm-sensors.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Sat__12_Jan_2008_14_47_22_+1100_Ea.ZjLb2a9KWuI=V
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jon,

On Fri, 11 Jan 2008 22:00:42 -0500 "Jon Smirl" <jonsmirl@gmail.com> wrote:
>
> +++ b/drivers/hwmon/f75375s.c
> @@ -117,7 +117,7 @@ struct f75375_data {
>  static int f75375_attach_adapter(struct i2c_adapter *adapter);
>  static int f75375_detect(struct i2c_adapter *adapter, int address, int k=
ind);
>  static int f75375_detach_client(struct i2c_client *client);
> -static int f75375_probe(struct i2c_client *client);
> +static int f75375_probe(struct i2c_client *client, const struct
> i2c_device_id *id);

Looks like your mail client has wrapped this.  Also in various later
spots.

> +++ b/drivers/i2c/i2c-core.c
> @@ -47,6 +47,19 @@ static DEFINE_IDR(i2c_adapter_idr);
>=20
>  /* ---------------------------------------------------------------------=
---- */
>=20
> +static const struct i2c_device_id *i2c_match_id(
> +		const struct i2c_device_id *id, struct i2c_client *client)

Any reason that the "client" argument is not const as well?

> +++ b/include/linux/i2c.h
> @@ -141,11 +141,10 @@ struct i2c_driver {
>=20
>  	struct device_driver driver;
>  	struct list_head list;
> +	struct i2c_device_id *id_table;

Any reason that this is not const?  Making it const would allow divers to
make their tables const.

These are just small things (apart from the wrapping) that can be fixed
up with followup patches.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Sat__12_Jan_2008_14_47_22_+1100_Ea.ZjLb2a9KWuI=V
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHiDhQTgG2atn1QN8RAkvzAJ4r8DaBYRyq1PBhTN8IXW//3fZGSwCfYu1M
IFzVy4mah4t9+8O/vqQ2z28=
=3njn
-----END PGP SIGNATURE-----

--Signature=_Sat__12_Jan_2008_14_47_22_+1100_Ea.ZjLb2a9KWuI=V--
