Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 564D4DDDFC
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2008 01:05:11 +1100 (EST)
Date: Wed, 23 Jan 2008 01:05:05 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Olaf Hering <olaf@aepfle.de>
Subject: Re: [PATCH] create modalias file in sysfs for bus vio
Message-Id: <20080123010505.d812129e.sfr@canb.auug.org.au>
In-Reply-To: <20080122083328.GA11928@aepfle.de>
References: <20080122083328.GA11928@aepfle.de>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__23_Jan_2008_01_05_05_+1100_MTRyhACgKEInKMA0"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Wed__23_Jan_2008_01_05_05_+1100_MTRyhACgKEInKMA0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Olaf,

Thanks for this.  Just a couple of nits ...

On Tue, 22 Jan 2008 09:33:28 +0100 Olaf Hering <olaf@aepfle.de> wrote:
>
> +static ssize_t modalias_show (struct device *dev, struct device_attribut=
e *attr,
                               ^
No space here, please.

> +			      char *buf)
> +{
> +	struct device_node *of_node =3D dev->archdata.of_node;
> +	const char *compat;
> +	int i =3D 0;
> +
> +	if (of_node) {
> +		compat =3D of_get_property(of_node, "compatible", &i);
> +		i =3D sprintf (buf, "vio:T%sS%s\n", of_node->type, compat ? compat : "=
");
                           ^
Or here.

It would be nice if we could factor out the "vio:T%sS%s" string as it is
also used in vio_hotplug().

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__23_Jan_2008_01_05_05_+1100_MTRyhACgKEInKMA0
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHlfgWTgG2atn1QN8RAidZAJ9RLY/uTBAWqR7/njEt30Pfi7uzpwCbBQ3k
92grRT4EZ3rsrM/g7lHB9C0=
=Mdl8
-----END PGP SIGNATURE-----

--Signature=_Wed__23_Jan_2008_01_05_05_+1100_MTRyhACgKEInKMA0--
