Return-Path: <michael@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id BE96DB7B6E
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 16 Jul 2009 11:41:47 +1000 (EST)
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B13BEDDD0B
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Jul 2009 11:41:47 +1000 (EST)
Subject: Re: [PATCH] Hold reference to device_node during EEH event handling
From: Michael Ellerman <michael@ellerman.id.au>
To: Mike Mason <mmlnx@us.ibm.com>
In-Reply-To: <4A5E4D68.6070909@us.ibm.com>
References: <4A5E4D68.6070909@us.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-bS8kw8IZH90R2J9vXjKX"
Date: Thu, 16 Jul 2009 11:41:46 +1000
Message-Id: <1247708506.9851.8.camel@concordia>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linasvepstas@gmail.com,
	Paul Mackerras <paulus@samba.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-bS8kw8IZH90R2J9vXjKX
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2009-07-15 at 14:43 -0700, Mike Mason wrote:
> This patch increments the device_node reference counter when an EEH
> error occurs and decrements the counter when the event has been
> handled.  This is to prevent the device_node from being released until
> eeh_event_handler() has had a chance to deal with the event.  We've
> seen cases where the device_node is released too soon when an EEH
> event occurs during a dlpar remove, causing the event handler to
> attempt to access bad memory locations.
>=20
> Please review and let me know of any concerns.

Taking a reference sounds sane, but ...

> Signed-off-by: Mike Mason <mmlnx@us.ibm.com>=20
>=20
> --- a/arch/powerpc/platforms/pseries/eeh_event.c	2008-10-09 15:13:53.0000=
00000 -0700
> +++ b/arch/powerpc/platforms/pseries/eeh_event.c	2009-07-14 14:14:00.0000=
00000 -0700
> @@ -75,6 +75,14 @@ static int eeh_event_handler(void * dumm
>  	if (event =3D=3D NULL)
>  		return 0;
> =20
> +	/* EEH holds a reference to the device_node, so if it
> +	 * equals 1 it's no longer valid and the event should
> +	 * be ignored */
> +	if (atomic_read(&event->dn->kref.refcount) =3D=3D 1) {
> +		of_node_put(event->dn);
> +		return 0;
> +	}

That's really gross :)

And what happens if the refcount goes to 1 just after the check? ie.
here.

>  	/* Serialize processing of EEH events */
>  	mutex_lock(&eeh_event_mutex);
>  	eeh_mark_slot(event->dn, EEH_MODE_RECOVERING);


cheers


--=-bS8kw8IZH90R2J9vXjKX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkpehVcACgkQdSjSd0sB4dKtrQCgomOFRLtqbHtB4q6NoMnGM3tK
NdoAoJrS5rvFuAdwTefsXEmC+3hSVX4Y
=FS4t
-----END PGP SIGNATURE-----

--=-bS8kw8IZH90R2J9vXjKX--
