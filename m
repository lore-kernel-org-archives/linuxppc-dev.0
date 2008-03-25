Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id E780ADE0DC
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Mar 2008 03:20:27 +1100 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] cpm_uart: Allocate DPRAM memory for SMC ports on
	CPM2-based platforms.
Date: Tue, 25 Mar 2008 17:20:21 +0100
References: <20080325160331.GB15093@ld0162-tx32.am.freescale.net>
In-Reply-To: <20080325160331.GB15093@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5977279.5zazmx9Ss5";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200803251720.24667.laurentp@cse-semaphore.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart5977279.5zazmx9Ss5
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 25 March 2008 17:03, Scott Wood wrote:
> On Tue, Mar 25, 2008 at 04:34:46PM +0100, Laurent Pinchart wrote:
> > On Tuesday 25 March 2008 15:58, Scott Wood wrote:
> > > Please maintain backward compatibility with older device trees (by
> > > checking the length of the second reg resource).  At the very least,
> > > update the device trees that are affected.
> >=20
> > I haven't seen any CPM2-based board using SMC ports in the device trees=
=20
> > available in arch/powerpc/boot/dts.
>=20
> ep8248e

I should have checked git head. My bad. I'll include the ep8248e device tre=
e=20
in the next patch.

> > Should I still maintain compatibility with older device trees ? Is ther=
e=20
any=20
> > out-of-tree PQ2 boards using udbg and SMC ?
>=20
> Yes, I've answered questions on the lists from at least one person using
> a custom board with cpm2 smc.

Are you sure it wasn't me ? ;-)

> > What about printing a warning if the second reg resource has the wrong
> > size ?
>=20
> The only way you'll see the warning is if udbg is enabled. :-P
>=20
> Will a CPM reset blow away the portion of muram that holds the SMC pram
> pointer?  If not (and I don't think it will), just return the device tree
> reg resource as is currently done if the resource is the wrong size.

Ok I'll do that. Should I add a warning message to tell people to update th=
e=20
device tree ?

> > > After this point, even if you don't reset the CPM, udbg printk is bro=
ken
> > > because you moved pram.  The udbg disabling will have to be moved bef=
ore
> > > this.
> >=20
> > Moving the SMC pram doesn't break udbg printk in itself. What will brea=
k=20
it is=20
> > moving the TX BDs, but the end result is the same, moving pram will res=
ult=20
in=20
> > udbg being broken.
> >=20
> > The cpm_uart driver disable udbg before allocating the new BDs. What ab=
out=20
> > moving that right before moving the parameter RAM ?=20
cpm_uart_request_port(),=20
> > which is called in between, already disables RX and TX on the port, so =
we=20
> > won't loose any debug message.
>=20
> cpm_uart_request_port() returns without doing that if it's a console
> port.  I think the current placement of the udbg disable will be fine.

Ok. I'll prepare a new patch that maintains compatibility with old device=20
trees.

Best regards,

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chauss=E9e de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart5977279.5zazmx9Ss5
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBH6SZI8y9gWxC9vpcRAsRkAKCdb3vKJlIJhRSyuNwHwurk3ccy6wCg0pNV
DpmDrLznaCwnz7k6B+7JCAA=
=1Lz2
-----END PGP SIGNATURE-----

--nextPart5977279.5zazmx9Ss5--
