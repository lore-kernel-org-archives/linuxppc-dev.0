Return-Path: <marc.leeman@gmail.com>
Received: from lmailproxy03.edpnet.net (lmailproxy03.edpnet.net [212.71.1.196])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CAD44DDEF6
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Jun 2007 07:18:02 +1000 (EST)
Date: Mon, 4 Jun 2007 23:17:40 +0200
From: Marc Leeman <marc.leeman@gmail.com>
To: Andy Fleming <afleming@freescale.com>
Subject: Re: 83xx GPIO/EXT int in arch/powerpc/
Message-ID: <20070604211740.GN17456@chiana.homelinux.org>
References: <20070604095625.GF17456@chiana.homelinux.org>
	<4E25DA41-741E-40AC-9186-936FEEFE6B29@freescale.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4ickEXl+ukcSQ/3E"
In-Reply-To: <4E25DA41-741E-40AC-9186-936FEEFE6B29@freescale.com>
Cc: linuxppc-dev@ozlabs.org
Reply-To: Marc Leeman <marc.leeman@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--4ickEXl+ukcSQ/3E
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Wow.  Hardware designers sure like to make things easy, don't they?

<rant>
The reason that I am switching to powerpc is that dts seems a cleaner
way to handle the I-didn't-know-what-a-reference-design-is-for decisions
=66rom our hardware designers and just connect up the devices like a large
box of lego :-/.

Even getting the gianfar eth devices up can become a challenge (not
again) because someone thought 'it makes more sense like this'. On
the bright side, I always have a reason in digging into the mpc834x
processor manual.
</rant>

> I'm assuming it's a PCI device on the board (and not in a slot).

yep, it's an FPGA device using PCI and GPIOs for interrupts (depending
on the board, it's for a MAC core in FPGA or custom logic).

> I believe you're ok if you explicitly define the node, and point it =20
> at the IPIC for its interrupt.  Something like this:
>=20
> pci1: pci@8000 {
> 	...
> 	my_pci_device@0 {
> 		...
> 		interrupts =3D <irq#, sense>;
> 		interrupt-parent =3D <&ipic>;
> 	}
> }

So I don't have to define the GPIO pins in pio-map in "vi) Pin
configuration nodes" and already set in the U-Boot bootloader? Using the
GPIOs for interrupts or IO would just work "out of the box" after the
U-boot initialisation (used for TI's HPI in with the UPMB).

Hang, and I finally thought the documentation made sense to me :-)

I already tried hardcoding the EXT7 pin as assigned in the ppc arch
(int 23); this would mean that, in the powerpc arch, the assignments of
interrupts is different wrt to ppc?

--=20
  greetz, marc
You'll be happy to know I have a plan.
	Crichton - Through the Looking Glass
chiana 2.6.18-4-ixp4xx #1 Tue Mar 27 18:01:56 BST 2007 GNU/Linux

--4ickEXl+ukcSQ/3E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGZIF0UQpj09NWLeERAg+JAJ9cN6x3wwJFLg2BAddK6H7UeDB7mgCfShS5
kJbbBbNgHZgKMNzu6kKH28U=
=4njk
-----END PGP SIGNATURE-----

--4ickEXl+ukcSQ/3E--
