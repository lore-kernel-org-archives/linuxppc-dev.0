Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id 9758EDE1F7
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2008 21:39:21 +1100 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: OF compatible MTD platform RAM driver ?
Date: Tue, 11 Mar 2008 11:39:08 +0100
References: <200803101606.39184.laurentp@cse-semaphore.com>
	<DCEAAC0833DD314AB0B58112AD99B93B0418505E@ismail.innsys.innovsys.com>
	<20080311004545.GI11559@localhost.localdomain>
In-Reply-To: <20080311004545.GI11559@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1326343.dkoBPVv9Gm";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200803111139.12667.laurentp@cse-semaphore.com>
Cc: ben@simtec.co.uk, linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart1326343.dkoBPVv9Gm
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 11 March 2008 01:45, David Gibson wrote:
> On Mon, Mar 10, 2008 at 12:00:22PM -0500, Rune Torgersen wrote:
> > linuxppc-dev-bounces+runet=3Dinnovsys.com@ozlabs.org wrote:
> > > Hi everybody,
> > >
> > > as part of a ARCH=3Dppc to ARCH=3Dpowerpc migration process, I'm
> > > looking for an
> > > OpenFirmware compatible way to handle a RAM-based MTD device.
> > >
> > > On the platform_device based ppc architecture, the
> > > drivers/mtd/maps/plat-ram.c
> > > driver handled "mtd-ram" platform devices. There is no such
> > > driver for the
> > > OF-based powerpc architecture.
> > >
> > > As a temporary workaround I hacked the physmap_of driver to
> > > handle "direct-mapped" OF devices oh type "ram" by adding a
> > > corresponding entry in the of_flash_match[] array. This seems to work
> > > fine.
> > >
> > > What would be the preferred way to handle OF-compatible RAM-based MTD
> > > devices ? The 3 ways I can think of are
> > >
> > > 1. porting the plat-ram driver to OF (the driver isn't used
> > > in the kernel tree
> > > but I suspect it is used by out-of-tree boards)
> > >
> > > 2. creating a new plat-ram-of driver, much like the
> > > physmap_of driver comes
> > > from the physmap driver
> > >
> > > 3. extending the physmap_of driver to handle RAM devices (in
> > > which case
> > > references to "flash" in the function names should probably
> > > be replaced
> > > by "mtd")
> > >
> > > I live option 3 better so far.
> > >
> > > Has anyone already worked on this ? Is there any defined
> > > device tree mapping
> > > for MTD RAM devices ?
> >
> > We ran ito the same issue.
> > We did option 3, as it was efinetly the easiest,
>
> I think this is the best option in principle.

I'll implement that and post a patch after completing the ppc-to-powerpc=20
migration.

> > here is the sram entry in our dts:
>
> Except that your implementation of it is not good.
>
> You're relying on the old obsolete flash binding with the "probe-type"
> field.  The solution should be adapted to the new approach which uses
> values in the "compatible" field to indicate various sorts of flash
> device.

What "compatible" values should I use for ROM and RAM mappings ?

Best regards,

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chauss=E9e de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart1326343.dkoBPVv9Gm
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBH1mFQ8y9gWxC9vpcRAhbCAJsHnLx9ZO1hehJcG3pELUcj1tQQgwCeORgF
FrAu3Eb313p04zRKi2boxdo=
=98cs
-----END PGP SIGNATURE-----

--nextPart1326343.dkoBPVv9Gm--
