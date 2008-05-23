Return-Path: <michael@ellerman.id.au>
Subject: Re: section mismatch warnings in current git head for powerpc
From: Michael Ellerman <michael@ellerman.id.au>
To: Chris Friesen <cfriesen@nortel.com>
In-Reply-To: <4835ABDB.8020901@nortel.com>
References: <4835ABDB.8020901@nortel.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-6pCvLfZbrGyP8YZ2QDAm"
Date: Fri, 23 May 2008 11:02:39 +1000
Message-Id: <1211504559.7671.2.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-6pCvLfZbrGyP8YZ2QDAm
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, 2008-05-22 at 11:22 -0600, Chris Friesen wrote:
> I got the following warnings when building current git head for powerpc=20
> 64bit:
>=20
>=20
>    LD      net/ipv4/built-in.o
>    LD      drivers/scsi/built-in.o
>    LD      net/built-in.o
>    LD      drivers/built-in.o
>    LD      vmlinux.o
>    MODPOST vmlinux.o
> WARNING: vmlinux.o(.text+0x73bc): Section mismatch in reference from the=20
> function .start_secondary_prolog() to the function=20
> .devinit.text:.start_secondary()
> The function .start_secondary_prolog() references
> the function __devinit .start_secondary().
> This is often because .start_secondary_prolog lacks a __devinit
> annotation or the annotation of .start_secondary is wrong.

start_secondary_prolog() is in asm, so I don't know what you're supposed
to do with that.

> WARNING: vmlinux.o(.text+0x260a8): Section mismatch in reference from=20
> the function .pci_dn_reconfig_notifier() to the function=20
> .devinit.text:.update_dn_pci_info()
> The function .pci_dn_reconfig_notifier() references
> the function __devinit .update_dn_pci_info().
> This is often because .pci_dn_reconfig_notifier lacks a __devinit
> annotation or the annotation of .update_dn_pci_info is wrong.

I think =EF=BB=BFpci_dn_reconfig_notifier() could be __devinit, but it's no=
t
clear because the code that calls it is not __devinit or conditional on
HOTPLUG, eventhough in practice I think it is only used for hotplug.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-6pCvLfZbrGyP8YZ2QDAm
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBINhevdSjSd0sB4dIRAkPIAJsF0e4y9HSU1+BVgceA5RAzvY+TPwCeI+IL
3DIIOHkG83GiuAoTgK2ycgA=
=RgT4
-----END PGP SIGNATURE-----

--=-6pCvLfZbrGyP8YZ2QDAm--
