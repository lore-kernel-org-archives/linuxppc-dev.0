Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id E2DD5DDF32
	for <linuxppc-dev@ozlabs.org>; Fri,  1 May 2009 10:30:40 +1000 (EST)
Date: Fri, 1 May 2009 10:30:35 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: linux-next: galak tree build warning
Message-Id: <20090501103035.3f683ead.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Fri__1_May_2009_10_30_35_+1000_p7K3QNq2DvXLDoaq"
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, linux-next@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Fri__1_May_2009_10_30_35_+1000_p7K3QNq2DvXLDoaq
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Kumar,

Today's linux-next build (powerpc_ppc64_defconfig) produced these
warnings:

arch/powerpc/platforms/pseries/iommu.c: In function 'pci_dma_bus_setup_pSer=
ies':
arch/powerpc/platforms/pseries/iommu.c:391: warning: format '%lx' expects t=
ype 'long unsigned int', but argument 2 has type 'resource_size_t'
arch/powerpc/platforms/pseries/iommu.c:417: warning: format '%lx' expects t=
ype 'long unsigned int', but argument 2 has type 'resource_size_t'

Caused by commit 78665c790a654cc2d509df3bf3971cdb102beac9 ("powerpc: make
dma_window_* in pci_controller struct avail on 32b").  resource_size_t
can be 32 or 64 bit depending on platform and config, so it needs to be
cast to (unsigned long long) when printed.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__1_May_2009_10_30_35_+1000_p7K3QNq2DvXLDoaq
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkn6QqsACgkQjjKRsyhoI8xrBgCfS6m5TXa4mwh1PuG3k+jroVep
eDkAn2n9tk3ymkSfRPtbqoDUEHxGR3iG
=GRCW
-----END PGP SIGNATURE-----

--Signature=_Fri__1_May_2009_10_30_35_+1000_p7K3QNq2DvXLDoaq--
