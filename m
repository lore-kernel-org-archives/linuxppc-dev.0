Return-Path: <michael@ellerman.id.au>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 75A37DDF8C
	for <linuxppc-dev@ozlabs.org>; Fri,  1 May 2009 00:49:26 +1000 (EST)
Subject: Re: [PATCH] powerpc/pci: Move pseries code into pseries platform
	specific area
From: Michael Ellerman <michael@ellerman.id.au>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1241100846-14216-1-git-send-email-galak@kernel.crashing.org>
References: <1241100846-14216-1-git-send-email-galak@kernel.crashing.org>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-TJ70sLckL5AuY92D7Ki1"
Date: Fri, 01 May 2009 00:49:25 +1000
Message-Id: <1241102965.7356.7.camel@concordia>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-TJ70sLckL5AuY92D7Ki1
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2009-04-30 at 09:14 -0500, Kumar Gala wrote:
> There doesn't appear to be any specific reason that we need to setup the
> pseries specific notifier in generic arch pci code.  Move it into pseries
> land.

Yeah I guess. Although if some other platform ever wants to do PCI
hotplug it probably wants to call update_dn_pci_info() also.

> --- a/arch/powerpc/platforms/pseries/setup.c
> +++ b/arch/powerpc/platforms/pseries/setup.c
> @@ -254,6 +255,31 @@ static void __init pseries_discover_pic(void)
>                " interrupt-controller\n");
>  }
> =20
> +extern void * update_dn_pci_info(struct device_node *dn, void *data);

Ahem :)

cheers

--=-TJ70sLckL5AuY92D7Ki1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkn5unUACgkQdSjSd0sB4dJwuwCgpjF/7bMlT4XO827gcS9+uGlY
6O8AoKK3dGKyB2TkozIgoab4qh6Qvmfn
=aC5b
-----END PGP SIGNATURE-----

--=-TJ70sLckL5AuY92D7Ki1--
