Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id 16745DDED5
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Mar 2008 01:36:21 +1100 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: OF compatible MTD platform RAM driver ?
Date: Tue, 25 Mar 2008 15:36:12 +0100
References: <200803101606.39184.laurentp@cse-semaphore.com>
	<200803111139.12667.laurentp@cse-semaphore.com>
	<20080311224048.GA7642@localhost.localdomain>
In-Reply-To: <20080311224048.GA7642@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3247855.gUWhUHSo2b";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200803251536.17795.laurentp@cse-semaphore.com>
Cc: ben@simtec.co.uk, linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart3247855.gUWhUHSo2b
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 11 March 2008 23:40, David Gibson wrote:
> On Tue, Mar 11, 2008 at 11:39:08AM +0100, Laurent Pinchart wrote:
> > On Tuesday 11 March 2008 01:45, David Gibson wrote:
> > > On Mon, Mar 10, 2008 at 12:00:22PM -0500, Rune Torgersen wrote:
> > > > linuxppc-dev-bounces+runet=3Dinnovsys.com@ozlabs.org wrote:
> [snip]
> > > > We ran ito the same issue.
> > > > We did option 3, as it was efinetly the easiest,
> > >
> > > I think this is the best option in principle.
> >=20
> > I'll implement that and post a patch after completing the ppc-to-powerp=
c=20
> > migration.
> >=20
> > > > here is the sram entry in our dts:
> > >
> > > Except that your implementation of it is not good.
> > >
> > > You're relying on the old obsolete flash binding with the "probe-type"
> > > field.  The solution should be adapted to the new approach which uses
> > > values in the "compatible" field to indicate various sorts of flash
> > > device.
> >=20
> > What "compatible" values should I use for ROM and RAM mappings ?
>=20
> That I'm not so sure of.  We'll need to find some consensus.
>=20
> There may be existing IEEE1275 bindings for roms, which we should
> investigate.

Do you (or someone else here) have access to the IEEE1275 specification ? I=
s=20
there any ROM binding in there ?

> Arguably RAM should be represented by a memory node, but=20
> that's going to get messy for this sort of application.

We're talking about a very specific type of RAM, used for permanent storage=
=20
with a battery backup. The RAM is really meant to be used as an MTD device=
=20
and as such I think it makes sense to describe it as an mtd-compatible devi=
ce=20
on the local bus.

What about the following definition for the RAM node ?

        nvram@2,0000 {
                compatible =3D "mtd,ram";
                reg =3D <2 0x0000 0x00100000>;
                bank-width =3D <2>;
        };

Or should the node have a device-type property of either 'ram' or 'rom' wit=
h=20
the compatible property just referencing MTD ?

Best regards,

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chauss=C3=A9e de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart3247855.gUWhUHSo2b
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBH6Q3h8y9gWxC9vpcRAndqAJ9tkmT0QYoubo1HsWSHHY2pq/whrwCdG2Tz
lOMWmBQFI3g+XD/k7Uo0Ee4=
=19Bl
-----END PGP SIGNATURE-----

--nextPart3247855.gUWhUHSo2b--
