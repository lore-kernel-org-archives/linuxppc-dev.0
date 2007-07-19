Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] make powerpc pci compile again
From: Michael Ellerman <michael@ellerman.id.au>
To: Johannes Berg <johannes@sipsolutions.net>
In-Reply-To: <1184779608.8125.2.camel@johannes.berg>
References: <1184779608.8125.2.camel@johannes.berg>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-NX2VS5M3YzLhX1SxVjBu"
Date: Thu, 19 Jul 2007 10:08:47 +1000
Message-Id: <1184803727.9798.17.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-NX2VS5M3YzLhX1SxVjBu
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2007-07-18 at 19:26 +0200, Johannes Berg wrote:
> Looks like we got a new declaration in the generic header... This fixes
> compile but I don't know whether it's correct.

We got a new declaration, along with updated C code in pci_64.c and
pci_32.c, but when that was merged with the creation of pci-common.c it
all went fubar.

Your patch is correct, but I think Tony has already sent it.

cheers

> --- linux-2.6-git.orig/arch/powerpc/kernel/pci-common.c	2007-07-17 19:11:=
57.519997066 +0200
> +++ linux-2.6-git/arch/powerpc/kernel/pci-common.c	2007-07-17 19:12:14.82=
0997066 +0200
> @@ -156,10 +156,12 @@ static DEVICE_ATTR(devspec, S_IRUGO, pci
>  #endif /* CONFIG_PPC_OF */
> =20
>  /* Add sysfs properties */
> -void pcibios_add_platform_entries(struct pci_dev *pdev)
> +int pcibios_add_platform_entries(struct pci_dev *pdev)
>  {
>  #ifdef CONFIG_PPC_OF
> -	device_create_file(&pdev->dev, &dev_attr_devspec);
> +	return device_create_file(&pdev->dev, &dev_attr_devspec);
> +#else
> +	return 0;
>  #endif /* CONFIG_PPC_OF */
>  }


--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-NX2VS5M3YzLhX1SxVjBu
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGnquPdSjSd0sB4dIRAv4DAKCG/OnNAausIF6S6PpHzw4w1Zn57ACaA3aA
Hi9qo1LlLYScJFzh1wp6+I8=
=obe9
-----END PGP SIGNATURE-----

--=-NX2VS5M3YzLhX1SxVjBu--
