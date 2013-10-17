Return-Path: <ben@decadent.org.uk>
Received: from shadbolt.e.decadent.org.uk (shadbolt.e.decadent.org.uk
 [88.96.1.126])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 6DD012C0079
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Oct 2013 15:22:53 +1100 (EST)
Message-ID: <1381982024.3267.14.camel@deadeye.wl.decadent.org.uk>
Subject: Re: [PATCH] powerpc/vio: Fix modalias_show return values
From: Ben Hutchings <ben@decadent.org.uk>
To: Prarit Bhargava <prarit@redhat.com>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>
Date: Thu, 17 Oct 2013 04:53:44 +0100
Content-Type: multipart/signed; micalg="pgp-sha512";
 protocol="application/pgp-signature"; boundary="=-VHdDC/Jxi8KnPAAR2tD6"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, stable@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-VHdDC/Jxi8KnPAAR2tD6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Commit e82b89a6f19bae73fb064d1b3dd91fcefbb478f4 introduces a trivial
local denial of service.

> --- a/arch/powerpc/kernel/vio.c
> +++ b/arch/powerpc/kernel/vio.c
> @@ -1351,11 +1351,15 @@ static ssize_t modalias_show(struct devi
>  	const char *cp;
> =20
>  	dn =3D dev->of_node;
> -	if (!dn)
> -		return -ENODEV;
> +	if (!dn) {
> +		strcat(buf, "\n");

Every read from the same sysfs file handle uses the same buffer, which
gets zero-initialised just once.  So if I open the file, read it and
seek back to 0 repeatedly, I can make modalias_show() write arbitrary
numbers of newlines into *and beyond* that page-sized buffer.

Obviously strcat() should be strcpy().

Ben.

> +		return strlen(buf);
> +	}
>  	cp =3D of_get_property(dn, "compatible", NULL);
> -	if (!cp)
> -		return -ENODEV;
> +	if (!cp) {
> +		strcat(buf, "\n");
> +		return strlen(buf);
> +	}
> =20
>  	return sprintf(buf, "vio:T%sS%s\n", vio_dev->type, cp);
>  }

--=20
Ben Hutchings
Horngren's Observation:
                   Among economists, the real world is often a special case=
.

--=-VHdDC/Jxi8KnPAAR2tD6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIVAwUAUl9fSOe/yOyVhhEJAQraiBAA1BFN06kQry43JgUMCuoVB3T9zBues3x8
Th1kzFmv18vcGkOYvnSIRTpLfZRwbux4kStWgdTP9Wf4AfC9lVNk9gzmSjdCF0TB
yMmXQVSBowqR1E+PGZ/aMclGJB5jYvtwg5C4fwBZ+XGuH4MQ7sBZ/J19eLpiT7fC
secd0ETfMOqMPDzcqSYrMH1650QJspYUpf2ar34B/inGFaerWRVAmGZcFQ+ZfNeu
tTOVv2Neg3C7yeUxNPgM7OBMTrIHlI1Q4wTXqSkRUKqEpJ9SLm265NBabfCgGnWf
pgXMnwEWuSSAFCrlH65I3LsVCadRMgtv+FU6YR7oTR7YMQThfJElSPFjlcxKBSib
qXMgp4ZyxD723b+H6b9wTajt3F9RnRNLNa96WsErVjNom6dEv0RNSKQIagJHRfDU
Q1n/sv197RkiVK1vygyRBRJMwA5cBoEOFP1sqIkfoSBzi6+1ygUXrPikrP4+rmeV
dQzqtgY2+QcgKiENWEGyPc7e5CxQReLsks7wgPfqkPKJ9DrCZoxInHc+g1LWlJue
oTVhgahecUgOlQKlIVbEFFUG/GwzZefL//ye6ie3HBGLJ1FdCzXuir5QrQu1XbNT
vgZJRbbaUc2lk0rtYPDP/ZGVYUnIjqig7xxw1OdqnPtv4tkelpAD3XQlSsJLbM0M
G5rBQuTB6bE=
=djlN
-----END PGP SIGNATURE-----

--=-VHdDC/Jxi8KnPAAR2tD6--
