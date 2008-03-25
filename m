Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id 30D19DE0D8
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Mar 2008 02:34:52 +1100 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] cpm_uart: Allocate DPRAM memory for SMC ports on
	CPM2-based platforms.
Date: Tue, 25 Mar 2008 16:34:46 +0100
References: <200803251224.45408.laurentp@cse-semaphore.com>
	<20080325145841.GG13187@ld0162-tx32.am.freescale.net>
In-Reply-To: <20080325145841.GG13187@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3883985.O8NNUEpCUe";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200803251634.50253.laurentp@cse-semaphore.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart3883985.O8NNUEpCUe
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 25 March 2008 15:58, Scott Wood wrote:
> On Tue, Mar 25, 2008 at 12:24:40PM +0100, Laurent Pinchart wrote:
> > I was concerned this would break udbg, but udbg doesn't seem to be=20
supported
> > on PQ2-based platforms.
>=20
> Yes, it is (see arch/powerpc/sysdev/cpm_common.c).

I thought that was for CPM1 only. My bad.
=20
> > This patch modifies the device tree address usage to reference the SMC
> > parameter RAM base pointer instead of a pre-allocated RAM section and
> > allocates memory from the CPM dual-port RAM when initialising the SMC=20
port.
> > CPM1-based platforms are not affected.
>=20
> Please maintain backward compatibility with older device trees (by
> checking the length of the second reg resource).  At the very least,
> update the device trees that are affected.

I haven't seen any CPM2-based board using SMC ports in the device trees=20
available in arch/powerpc/boot/dts.

Should I still maintain compatibility with older device trees ? Is there an=
y=20
out-of-tree PQ2 boards using udbg and SMC ? What about printing a warning i=
f=20
the second reg resource has the wrong size ?

> > +	offset =3D cpm_dpalloc(PROFF_SMC_SIZE, 64);
> > +	out_be16(pram, offset);
>=20
> Up to this point, if we don't reset the CPM prior to any dpalloc calls
> (and if we do, udbg printk breaks), the SMC could be running and
> clobbering some other bit of dpram, which could have been allocated to
> something else.

If udbg uses the parameter RAM allocated by the boot loader, that section o=
f=20
DPRAM should be removed from the muram node in the device tree. Otherwise t=
he=20
SMC DPRAM will eventually be allocated to something else and the system wil=
l=20
break.

It should thus be safe to reset the CPM if udbg isn't used, and the device=
=20
tree should explicitely exclude the pre-allocated parameter RAM from the=20
muram node when udbg is used.

> After this point, even if you don't reset the CPM, udbg printk is broken
> because you moved pram.  The udbg disabling will have to be moved before
> this.

Moving the SMC pram doesn't break udbg printk in itself. What will break it=
 is=20
moving the TX BDs, but the end result is the same, moving pram will result =
in=20
udbg being broken.

The cpm_uart driver disable udbg before allocating the new BDs. What about=
=20
moving that right before moving the parameter RAM ? cpm_uart_request_port()=
,=20
which is called in between, already disables RX and TX on the port, so we=20
won't loose any debug message.

Best regards,

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chauss=E9e de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart3883985.O8NNUEpCUe
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBH6Rua8y9gWxC9vpcRAgkjAJ4oSApw3jfFh4q9Q2S8fetTL8fnVACglWAc
0z9ouAaO0xb0NmmrP13pMxQ=
=DmCz
-----END PGP SIGNATURE-----

--nextPart3883985.O8NNUEpCUe--
