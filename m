Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 320BEDDF92
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Dec 2007 11:06:42 +1100 (EST)
Received: from ash.ozlabs.ibm.com (bh02i525f01.au.ibm.com [202.81.18.30])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by smtps.tip.net.au (Postfix) with ESMTP id 612BA368003
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Dec 2007 11:06:38 +1100 (EST)
Date: Tue, 11 Dec 2007 11:06:01 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: ppc-dev <linuxppc-dev@ozlabs.org>
Subject: Re: Powerpc PCI cleanups (mainly iSeries)
Message-Id: <20071211110601.3604980b.sfr@canb.auug.org.au>
In-Reply-To: <20071206180045.0eb1db98.sfr@canb.auug.org.au>
References: <20071206180045.0eb1db98.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__11_Dec_2007_11_06_01_+1100_=s=6/ouXdByh_3=J"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__11_Dec_2007_11_06_01_+1100_=s=6/ouXdByh_3=J
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 6 Dec 2007 18:00:45 +1100 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> Hi all,
>=20
> I started out looking for ways to remove our dependencies on pci_dn and
> got sidetracked into clening up the iSeries PCI code.  The intention of
> the following set of patches is that there be no semantic changes
> (mostly).

I have rebased this series to remove the dependency on benh's patches and
will repost (as replies to the originals) only those that changed
(numbers 2, 14, 16 and I repoested 19 yesterday).

> Overall diffstat looks like this:
>  arch/powerpc/kernel/pci-common.c           |   31 +--
>  arch/powerpc/kernel/pci_32.c               |    6 +-
>  arch/powerpc/kernel/pci_64.c               |   40 +--
>  arch/powerpc/kernel/pci_dn.c               |    2 +-
>  arch/powerpc/platforms/85xx/mpc85xx_ds.c   |    2 +-
>  arch/powerpc/platforms/86xx/mpc86xx_hpcn.c |    2 +-
>  arch/powerpc/platforms/iseries/pci.c       |  426 +++++++++++-----------=
------
>  arch/powerpc/platforms/iseries/pci.h       |   20 +-
>  arch/powerpc/platforms/iseries/setup.c     |    2 +
>  arch/powerpc/platforms/iseries/vpdinfo.c   |   17 +-
>  arch/powerpc/platforms/powermac/pci.c      |    2 +-
>  arch/powerpc/platforms/pseries/iommu.c     |    2 +-
>  include/asm-powerpc/pci-bridge.h           |  156 ++++------
>  include/asm-powerpc/ppc-pci.h              |    3 -
>  14 files changed, 266 insertions(+), 445 deletions(-)

Now:
 arch/powerpc/kernel/isa-bridge.c               |    2 +-
 arch/powerpc/kernel/pci-common.c               |   34 +--
 arch/powerpc/kernel/pci_32.c                   |   10 +-
 arch/powerpc/kernel/pci_64.c                   |   42 +--
 arch/powerpc/kernel/pci_dn.c                   |    2 +-
 arch/powerpc/kernel/prom_parse.c               |    2 +-
 arch/powerpc/kernel/rtas_pci.c                 |    2 +-
 arch/powerpc/platforms/82xx/pq2.c              |    2 +-
 arch/powerpc/platforms/85xx/mpc85xx_ds.c       |    2 +-
 arch/powerpc/platforms/86xx/mpc8610_hpcd.c     |    2 +-
 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c     |    2 +-
 arch/powerpc/platforms/cell/io-workarounds.c   |    4 +-
 arch/powerpc/platforms/celleb/io-workarounds.c |    4 +-
 arch/powerpc/platforms/celleb/pci.c            |    2 +-
 arch/powerpc/platforms/iseries/pci.c           |  426 +++++++++-----------=
---
 arch/powerpc/platforms/iseries/pci.h           |   20 +-
 arch/powerpc/platforms/iseries/setup.c         |    2 +
 arch/powerpc/platforms/iseries/vpdinfo.c       |   17 +-
 arch/powerpc/platforms/maple/pci.c             |    2 +-
 arch/powerpc/platforms/powermac/pci.c          |    6 +-
 arch/powerpc/platforms/pseries/iommu.c         |    2 +-
 include/asm-powerpc/pci-bridge.h               |  159 ++++------
 include/asm-powerpc/ppc-pci.h                  |    3 -
 23 files changed, 287 insertions(+), 462 deletions(-)

The extra files are from the arch_data rename posted earlier.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/


--Signature=_Tue__11_Dec_2007_11_06_01_+1100_=s=6/ouXdByh_3=J
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHXdRtTgG2atn1QN8RAoCuAJwMuIuRGbnZF4enH9677m3qSwIxBACeP1B4
EnTo+PBpfgHudGpYJe4CMVc=
=hYp4
-----END PGP SIGNATURE-----

--Signature=_Tue__11_Dec_2007_11_06_01_+1100_=s=6/ouXdByh_3=J--
