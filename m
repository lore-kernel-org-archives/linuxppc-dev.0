Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id 94DCBDDDEE
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Mar 2008 23:17:07 +1100 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: Trouble with SCC UART ports when moving from ppc to powerpc
Date: Mon, 10 Mar 2008 13:17:01 +0100
References: <200803071521.00383.laurentp@cse-semaphore.com>
	<20080307162135.GC10545@ld0162-tx32.am.freescale.net>
In-Reply-To: <20080307162135.GC10545@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart301292673.pjddNFXazP";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200803101317.04455.laurentp@cse-semaphore.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart301292673.pjddNFXazP
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 07 March 2008 17:21, Scott Wood wrote:
> On Fri, Mar 07, 2008 at 03:20:55PM +0100, Laurent Pinchart wrote:
> > The CPM dual port ram was defined in the device tree as follows (copied
> > from the MPC8272ADS board device tree).
> >
> >         muram@0 {
> >                 #address-cells =3D <1>;
> >                 #size-cells =3D <1>;
> >                 ranges =3D <0 0 10000>;
> >
> >                 data@0 {
> >                         compatible =3D "fsl,cpm-muram-data";
> >                         reg =3D <0 2000 9800 800>;
> >                 };
> >         };
> >
> > Changing the reg property to
> >
> > reg =3D <80 1f80 9800 800>;
> >
> > fixed my problem.
>
> Perhaps there's an SMC1 running with its parameter RAM at offset zero?

Good guess. U-Boot configured SMC1 with its parameter RAM at offset 0.

> > Does anyone have any clue regarding what could write to the dpram ? I
> > thought about some CPM peripheral set up by the boot loader, but my boa=
rd
> > initialization code calls cpm2_reset() long before initializing SCC1.
>
> cpm2_reset() doesn't currently actually reset the CPM, for some reason
> (unlike cpm1).  This should probably be fixed, though then we'd have to
> deal with assigning SMC parameter RAM addresses ourselves.

I had overlooked that. Resetting the CPM in cpm2_reset() helps. Is there an=
y=20
reason not to rset the CPM in cpm2_reset() ?

How should SMC parameter RAM assignment be handled ? I'm not very familiar=
=20
with the CPM1, but for CPM2 the cpm_uart driver could easily cpm_dpalloc()=
=20
parameter RAM.

> For now, the above fix should be done on any board with an active SMC
> device (assuming SMC parameter RAM at zero, as u-boot sets it; other
> bootloaders may need to exempt a different region).

Thanks for your help.

Best regards,

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chauss=E9e de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart301292673.pjddNFXazP
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBH1SbA8y9gWxC9vpcRAgs9AKCZfia4mlWh1BHjrsTUy8JoGsKyLgCdGAPX
KPrXgs28Mlgrn04MKXKxSag=
=Felu
-----END PGP SIGNATURE-----

--nextPart301292673.pjddNFXazP--
