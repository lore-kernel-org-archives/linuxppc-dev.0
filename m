Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B7ABF1A06A6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jun 2015 15:53:36 +1000 (AEST)
Received: from mail-pa0-x22d.google.com (mail-pa0-x22d.google.com
 [IPv6:2607:f8b0:400e:c03::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 2D507140306
 for <linuxppc-dev@ozlabs.org>; Thu, 25 Jun 2015 15:53:36 +1000 (AEST)
Received: by pabvl15 with SMTP id vl15so43297782pab.1
 for <linuxppc-dev@ozlabs.org>; Wed, 24 Jun 2015 22:53:33 -0700 (PDT)
Message-ID: <1435211538.4286.42.camel@axtens.net>
Subject: Re: [PATCH V9 06/13] powerpc, perf: Re organize BHRB processing
From: Daniel Axtens <dja@axtens.net>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, mpe@ellerman.id.au, sukadev@linux.vnet.ibm.com,
 mikey@neuling.org
Date: Thu, 25 Jun 2015 15:52:18 +1000
In-Reply-To: <1434370268-19056-7-git-send-email-khandual@linux.vnet.ibm.com>
References: <1434370268-19056-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1434370268-19056-7-git-send-email-khandual@linux.vnet.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
 protocol="application/pgp-signature"; boundary="=-0TWnR2W8mkqi+KJAnr5W"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-0TWnR2W8mkqi+KJAnr5W
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable


> +static void insert_branch(struct cpu_hw_events *cpuhw,
> +			int index, u64 from, u64 to, int mispred)
Given that your previous patch made mispred a bool, this could take a
bool too. It could probably be an inline function as well.
> +{
> +	cpuhw->bhrb_entries[index].from =3D from;
> +	cpuhw->bhrb_entries[index].to =3D to;
> +	cpuhw->bhrb_entries[index].mispred =3D mispred;
> +	cpuhw->bhrb_entries[index].predicted =3D ~mispred;
> +}
> +
> =20
--=20
Regards,
Daniel

--=-0TWnR2W8mkqi+KJAnr5W
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: GPGTools - https://gpgtools.org

iQIcBAABCgAGBQJVi5cSAAoJEPC3R3P2I92FWhcP/16y/PoRB+b+gfGluFb1E+5Z
rZi0xdSCeL59gkXdgz/MiT6Vpr5N0nkBHiD7342M1zMEUWQM+X+KlKOPOGx+ioVO
zpD4U00mX1MNqICgCrKn8G3wc8ylHvInJHUk8ibi2x7ymqzGVQUCjE7q0ZdOula0
OtyzrpWL8f4fim7EBFPf/TgwLiJdNJzVKFSpcxLQkxKEIWiFHhe9MSp5XZ0Kjjfh
VQH9dq8wG7En4kAg4cun3Gu9ftBZud0eIqTfxBPg/LAqL4PNb0ozkrLviY59u27o
wPRbyTJaVw0iTfjFZsfnlk22StyTwfm6C9ontFUHe9MI9fY/7c5Qp4WKlHk9Pion
bDtIMJ+I8YaY3O4BlSL3AyETu/S5vUtujTrcHWvoSr2/t18zhh+mqzbv8oYhaM1t
ERgeV3Pwz0iOjUzUmipq7tDE43ivTrCCu3oTvXVUkY243hXe+2m7opbgYlP2DOer
eubMDxKuXj2ffiMv+BJFTgxWofaX8JvfH+c7x6gYvDBUJbAFsC0Zcr7pBQWtbkQB
d+bJN5zhUGThwLZDb//2pz6S7cnqkpMoAf3CV1VLDk7bfhDBxRsXugE8tHpPz1KU
s23O8zJzHZ2qRuJLz8xUhO1R7wBAZmlNf//SfHbLNlcKqj0A6HkhrQ5yTCXvaS5f
Dyp6HuEAVprjBu9h/UbP
=/nj+
-----END PGP SIGNATURE-----

--=-0TWnR2W8mkqi+KJAnr5W--
